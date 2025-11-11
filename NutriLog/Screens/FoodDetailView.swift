import SwiftUI
import SwiftData

struct FoodDetailView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    let food: Food
    
    @Query(sort: \FoodEntry.date, order: .reverse)
    private var allEntries: [FoodEntry]
    
    var filteredEntries: [FoodEntry] {
        allEntries.filter { $0.food?.name == food.name }
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(food.name)
                    .font(.largeTitle)
                    .bold()
                Spacer()
            }
            .padding(.horizontal)
            
            HStack {
                Text("\(String(format: "%.0f", food.calories)) cal")
                    .foregroundStyle(.secondary)
                    .font(.title)
                
                Spacer()
                
                VStack {
                    Text("\(String(format: "%.0f", food.protein)) g")
                    Text(NSLocalizedString("KeyProtein", comment: ""))
                        .foregroundStyle(.secondary)
                        .font(.system(size: 15))
                }
                
                VStack {
                    Text("\(String(format: "%.0f", food.carbs)) g")
                    Text(NSLocalizedString("KeyCarbs", comment: ""))
                        .foregroundStyle(.secondary)
                        .font(.system(size: 15))
                }
                
                VStack {
                    Text("\(String(format: "%.0f", food.fat)) g")
                    Text(NSLocalizedString("KeyFat", comment: ""))
                        .foregroundStyle(.secondary)
                        .font(.system(size: 15))
                }
            }
            .padding(.horizontal)
            .padding(.vertical)
            
            Text(NSLocalizedString("KeyConsumptionHistory", comment: ""))
                .font(.headline)
                .padding(.horizontal)
                .padding(.top, 10)
            
            if filteredEntries.isEmpty {
                Text(NSLocalizedString("KeyNoEnterConsumptionHistory", comment: ""))
                    .foregroundStyle(.secondary)
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .center)
            } else {
                List {
                    ForEach(filteredEntries) { entry in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(entry.mealType.localizedName)
                                    .font(.headline)
                                Text(formattedDate(entry.date))
                                    .font(.subheadline)
                                    .foregroundStyle(.secondary)
                            }
                            Spacer()
                            Text("\(String(format: "%.0f", entry.servingSize)) g")
                                .foregroundStyle(.secondary)
                        }
                        .padding(.vertical, 4)
                    }
                }
                .listStyle(.plain)
                .scrollContentBackground(.hidden)
            }
            
            Spacer()
        }
        .padding(.top)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: { dismiss() }) {
                    HStack(spacing: 4) {
                        Image(systemName: "chevron.left")
                        Text("Aujourd’hui")
                    }
                    .foregroundStyle(.orange)
                }
            }
        }
    }
    
    func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .none
        formatter.locale = .current
        return formatter.string(from: date)
    }
}


#Preview {
    do {
        let container = try ModelContainer(
            for: Food.self, FoodEntry.self,
            configurations: ModelConfiguration(isStoredInMemoryOnly: true)
        )
        let context = container.mainContext
        
        let food = Food(name: "Riz", calories: 130, protein: 2.7, carbs: 28, fat: 0.3)
        context.insert(food)
        
        let entry1 = FoodEntry(food: food, servingSize: 150, mealType: .lunch, date: Date.now.addingTimeInterval(-86400))
        let entry2 = FoodEntry(food: food, servingSize: 200, mealType: .dinner, date: .now)
        context.insert(entry1)
        context.insert(entry2)
        
        return FoodDetailView(food: food)
            .modelContainer(container)
    } catch {
        fatalError("Erreur de preview : \(error)")
    }
}
