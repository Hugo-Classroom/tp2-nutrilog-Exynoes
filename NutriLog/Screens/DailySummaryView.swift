import SwiftUI
import SwiftData

struct DailySummaryView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var allEntries: [FoodEntry]
    @State private var showingAddMeal = false
    @State private var selectedDate = Date.now
    
    var entries: [FoodEntry] {
        allEntries.filter { Calendar.current.isDate($0.date, inSameDayAs: selectedDate) }
    }
    
    var body: some View {
        NavigationSplitView {
            VStack(alignment: .leading, spacing: 20) {
                
                List {
                    SummaryHeader(entries: entries)
                    SummaryCategories(entries: entries)
                }
                
            }
            .navigationTitle(NSLocalizedString("KeyToday",comment: ""))
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showingAddMeal.toggle()
                    } label: {
                        Label("Ajouter", systemImage: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingAddMeal) {
                AddMealView()
            }
        } detail: {
            Text("Sélectionne un repas pour voir plus de détails.")
                .foregroundStyle(.secondary)
        }
    }
}

struct SummaryHeader: View {
    var entries: [FoodEntry]
    
    @State private var proteinGoal = 150.0
    @State private var carbGoal = 125.0
    @State private var fatGoal = 100.0
    @State private var calorieGoal = 2500.0
    
    var totalCalories: Double {
        entries.reduce(0) { $0 + $1.calories }
    }
    var totalProtein: Double {
        entries.reduce(0) { $0 + ($1.food?.protein ?? 0) * $1.servingSize / 100 }
    }
    var totalCarbs: Double {
        entries.reduce(0) { $0 + ($1.food?.carbs ?? 0) * $1.servingSize / 100 }
    }
    var totalFat: Double {
        entries.reduce(0) { $0 + ($1.food?.fat ?? 0) * $1.servingSize / 100 }
    }
    
    var body: some View {
        Section(NSLocalizedString("KeyCalorie",comment: "")){
            HStack {
                HStack{
                    VStack {
                        Spacer()
                        Text(NSLocalizedString("KeyRemaining",comment: ""))
                        Spacer()
                        Text("\(String(format: "%.0f", calorieGoal - totalCalories)) Cal")
                        Spacer()
                    }
                    .frame(maxWidth: .infinity, alignment: .init(horizontal: .leading, vertical: .center))
                    
                    CircularProgressView(progress: (totalCalories/calorieGoal), color: .green)
                        .padding(.horizontal,10)
                }
                VerticalDivider(height: 80)
                VStack {
                    Spacer()
                    Text(NSLocalizedString("KeyConsumed",comment: ""))
                    Spacer()
                    Text("\(String(format: "%.0f", totalCalories)) Cal")
                    Spacer()
                }
                .padding(.trailing, 65)
            }
        }
        Section(NSLocalizedString("KeyMacro",comment: "")) {
                HStack(spacing: 12) {
                    VStack {
                        MacroProgressView(title: NSLocalizedString("KeyProtein", comment: ""), symbol: "p.circle.fill", value: totalProtein, goal: proteinGoal, color: .red)
                    }
                    VStack {
                        MacroProgressView(title: NSLocalizedString("KeyCarbs", comment: ""), symbol: "g.circle.fill", value: totalCarbs, goal: carbGoal, color: .purple)
                    }
                    VStack {
                        MacroProgressView(title: NSLocalizedString("KeyFat", comment: ""), symbol: "l.circle.fill", value: totalFat, goal: fatGoal, color: .blue)
                    }
                }
            }
    }
}

struct SummaryCategories: View {
    @Environment(\.modelContext) private var modelContext
    var entries: [FoodEntry]

    var body: some View {
        let breakfasts = entries.filter { $0.mealType == .breakfast }
        let lunches = entries.filter { $0.mealType == .lunch }
        let dinners = entries.filter { $0.mealType == .dinner }
        
        Section {
            if !breakfasts.isEmpty {
                VStack(alignment: .leading, spacing: 6) {
                    HStack {
                        Text(NSLocalizedString("KeyBreakfast",comment: ""))
                            .font(.headline)
                        Spacer()
                        Text("\(Int(totalCalories(for: breakfasts))) KCAL")
                            .bold()
                        if hasProtein(breakfasts) { Image(systemName: "p.circle.fill").foregroundColor(.red) }
                        if hasCarbs(breakfasts) { Image(systemName: "g.circle.fill").foregroundColor(.purple) }
                        if hasFat(breakfasts) { Image(systemName: "l.circle.fill").foregroundColor(.blue) }
                    }
                    .padding(.vertical, 4)
                }
                
                ForEach(breakfasts) { entry in
                    if let food = entry.food {
                        NavigationLink(destination: FoodDetailView(food: food)) {
                            MealRow(entry: entry)
                        }
                    }
                }
                .onDelete { deleteEntries(offsets: $0, from: breakfasts) }
            } else {
                Text(NSLocalizedString("KeyBreakfast",comment: ""))
                    .font(.headline)
                Text(NSLocalizedString("KeyTextNoFood", comment: ""))
                    .foregroundStyle(.secondary)
            }
        }
        
        Section {
            if !lunches.isEmpty {
                VStack(alignment: .leading, spacing: 6) {
                    HStack {
                        Text(NSLocalizedString("KeyLunch",comment: ""))
                            .font(.headline)
                        Spacer()
                        Text("\(Int(totalCalories(for: lunches))) KCAL")
                            .bold()
                        if hasProtein(lunches) { Image(systemName: "p.circle.fill").foregroundColor(.red) }
                        if hasCarbs(lunches) { Image(systemName: "g.circle.fill").foregroundColor(.purple) }
                        if hasFat(lunches) { Image(systemName: "l.circle.fill").foregroundColor(.blue) }
                    }
                    .padding(.vertical, 4)
                }
                
                ForEach(lunches) { entry in
                    if let food = entry.food {
                        NavigationLink(destination: FoodDetailView(food: food)) {
                            MealRow(entry: entry)
                        }
                    }
                }
                .onDelete { deleteEntries(offsets: $0, from: lunches) }
            } else {
                Text(NSLocalizedString("KeyLunch",comment: ""))
                    .font(.headline)
                Text(NSLocalizedString("KeyTextNoFood", comment: ""))
                    .foregroundStyle(.secondary)
            }
        }
        
        Section {
            if !dinners.isEmpty {
                VStack(alignment: .leading, spacing: 6) {
                    HStack {
                        Text(NSLocalizedString("KeyDinner",comment: ""))
                            .font(.headline)
                        Spacer()
                        Text("\(Int(totalCalories(for: dinners))) KCAL")
                            .bold()
                        if hasProtein(dinners) { Image(systemName: "p.circle.fill").foregroundColor(.red) }
                        if hasCarbs(dinners) { Image(systemName: "g.circle.fill").foregroundColor(.purple) }
                        if hasFat(dinners) { Image(systemName: "l.circle.fill").foregroundColor(.blue) }
                    }
                    .padding(.vertical, 4)
                }
                
                ForEach(dinners) { entry in
                    if let food = entry.food {
                        NavigationLink(destination: FoodDetailView(food: food)) {
                            MealRow(entry: entry)
                        }
                    }
                }
                .onDelete { deleteEntries(offsets: $0, from: dinners) }
            } else {
                Text(NSLocalizedString("KeyDinner",comment: ""))
                    .font(.headline)
                Text(NSLocalizedString("KeyTextNoFood", comment: ""))
                    .foregroundStyle(.secondary)
            }
        }
        
    }

    private func deleteEntries(offsets: IndexSet, from list: [FoodEntry]) {
        withAnimation {
            for index in offsets {
                let entry = list[index]
                modelContext.delete(entry)
            }
            try? modelContext.save()
        }
    }
    func totalCalories(for entries: [FoodEntry]) -> Double {
        entries.reduce(0) { $0 + $1.calories }
    }

    func hasProtein(_ entries: [FoodEntry]) -> Bool {
        entries.contains { ($0.food?.protein ?? 0) * $0.servingSize / 100 > 0 }
    }

    func hasCarbs(_ entries: [FoodEntry]) -> Bool {
        entries.contains { ($0.food?.carbs ?? 0) * $0.servingSize / 100 > 0 }
    }

    func hasFat(_ entries: [FoodEntry]) -> Bool {
        entries.contains { ($0.food?.fat ?? 0) * $0.servingSize / 100 > 0 }
    }

}

struct MealRow: View {
    var entry: FoodEntry

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack{
                VStack{
                    Text(entry.food?.name ?? "")
                        .font(.title2)
                        .frame(maxWidth: 400, alignment: .leading)
                    Spacer()
                    Text(entry.food?.desc ?? "")
                        .foregroundStyle(.secondary)
                        .font(.system(size: 15))
                        .frame(maxWidth: 400, alignment: .leading)
                        .lineLimit(1)
                }
                Spacer()
                Text("\(Int(entry.calories)) kcal")
                    .font(.title2)
            }
        }
        .padding(.vertical, 4)
    }
}



struct MacroProgressView: View {
    let title: String
    let symbol: String
    let value: Double
    let goal: Double
    let color: Color
    var body: some View {
        VStack {
            HStack(spacing: 4)
            {
                Image(systemName: symbol)
                    .foregroundStyle(color)
                Text(title)
                    .foregroundStyle(color)
                    .bold()
            }
            ProgressView(value: value, total: goal)
                .tint(color)
                .frame(height: 8)
                .clipShape(Capsule())
            HStack {
                Text("\(Int(value)) g")
                Text("/ \(Int(goal))g")
                    .foregroundStyle(.secondary)
            }
            .font(.caption)
        }
    }
}

struct VerticalDivider: View {
    var color: Color = .gray
    var height: CGFloat
    var body: some View {
        Rectangle()
            .fill(color)
            .frame(width: 1, height: height)
    }
}

struct CircularProgressView: View {
    var progress: Double
    var color: Color = .blue
    var lineWidth: CGFloat = 10
    
    var frameWidthHeight: CGFloat = 50
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: lineWidth)
                .opacity(0.3)
                .foregroundColor(.gray)
            
            Circle()
                .trim(from: 0.0, to: progress)
                .stroke(
                    color, style: StrokeStyle(lineWidth: lineWidth, lineCap: .round)
                )
                .rotationEffect(.degrees(-90))
                .animation(.easeOut, value: progress)
        }
        .frame(width: frameWidthHeight, height: frameWidthHeight)
    }
}


#Preview {
    do {
            let container = try ModelContainer(
                for: Food.self, FoodEntry.self,
                configurations: ModelConfiguration(isStoredInMemoryOnly: true)
            )
            
            let context = container.mainContext
            
            let food = MockData.rice
            context.insert(food)
            
            let entry = FoodEntry(food: food, servingSize: 150, mealType: .lunch)
            context.insert(entry)
            
            return DailySummaryView()
                .modelContainer(container)
        } catch {
            fatalError("Erreur de preview : \(error)")
        }
}

