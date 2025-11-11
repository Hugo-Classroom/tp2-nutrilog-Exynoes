import SwiftUI
import SwiftData

struct AddMealView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss

    var body: some View {
        AddMealForm(dismiss: dismiss)
    }
}

struct AddMealForm: View {
    @Environment(\.modelContext) var modelContext
    
    @State private var selectedFood: Food? = nil
    @State private var servingSize: Double = 100
    @State private var selectedMealType: MealType = .dinner
    
    var dismiss: DismissAction

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                
                HStack {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                            .font(.title3)
                            .foregroundStyle(.black)
                    }
                    Spacer()
                    Text(NSLocalizedString("KeyAddEnter", comment: ""))
                        .font(.headline)
                    Spacer()
                    Spacer()
                }
                .padding(.horizontal)
                .padding(.top)
                
                HStack(spacing: 8) {
                    Text(NSLocalizedString("KeyFood", comment: ""))
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                    Picker(NSLocalizedString("KeyFood", comment: ""), selection: $selectedFood) {
                        ForEach(MockData.foods, id: \.name) { food in
                            Text(food.name).tag(food as Food?)
                        }
                    }
                    .pickerStyle(.menu)
                }
                .padding(.horizontal)
                
                HStack {
                    Section(NSLocalizedString("KeyPortion", comment: "") + " (g)") {
                        Stepper("\(Int(servingSize)) g", value: $servingSize, in: 50...500, step: 100)
                    }
                }
                .padding(.horizontal)
                .padding(.top, 4)
                
                Picker(NSLocalizedString("KeyTypeMeal", comment: ""), selection: $selectedMealType) {
                    ForEach(MealType.allCases, id: \.self) { type in
                        Text(type.localizedName).tag(type)
                    }
                }
                .pickerStyle(.segmented)
                .padding(.horizontal)
                .padding(.bottom, 4)

                if let food = selectedFood {
                    VStack(alignment: .leading, spacing: 6) {
                        Text(NSLocalizedString("KeyMacro", comment: "") + " \(Int(servingSize)) g")
                            .font(.subheadline)
                            .bold()
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text("\(NSLocalizedString("KeyCalorie", comment: "")): \(food.calories * servingSize / 100, specifier: "%.1f") kcal")
                            Text("\(NSLocalizedString("KeyProtein", comment: "")): \(food.protein * servingSize / 100, specifier: "%.1f") g")
                            Text("\(NSLocalizedString("KeyCarbs", comment: "")): \(food.carbs * servingSize / 100, specifier: "%.1f") g")
                            Text("\(NSLocalizedString("KeyFat", comment: "")): \(food.fat * servingSize / 100, specifier: "%.1f") g")
                        }
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                    }
                    .padding(.horizontal)
                }
                
                Spacer()
                
                Button(action: addMeal) {
                    Text(NSLocalizedString("KeySave", comment: ""))
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(selectedFood == nil ? Color.gray : Color.orange)
                        .cornerRadius(12)
                        .padding(.horizontal)
                }
                .disabled(selectedFood == nil)
            }
            .navigationBarHidden(true)
        }
    }

    private func addMeal() {
        guard let selectedFood else { return }
        let newEntry = FoodEntry(food: selectedFood, servingSize: servingSize, mealType: selectedMealType)
        modelContext.insert(newEntry)
        dismiss()
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
