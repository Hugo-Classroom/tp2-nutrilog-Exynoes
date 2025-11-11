import SwiftUI
import SwiftData
import Charts

struct DailyChartsView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \FoodEntry.date, order: .reverse)
    private var allEntries: [FoodEntry]
    
    var mealTypeStats: [(type: String, count: Int)] {
        var counts: [String: Int] = [:]
        for entry in allEntries {
            counts[entry.mealType.localizedName, default: 0] += 1
        }
        return counts.map { ($0.key, $0.value) }
    }
    
    var nutrientTotals: [(nutrient: String, total: Double)] {
        var totals = (protein: 0.0, carbs: 0.0, fat: 0.0)
        
        for entry in allEntries {
            guard let food = entry.food else { continue }
            let radio = entry.servingSize / 100.0
            totals.protein += food.protein * radio
            totals.carbs += food.carbs * radio
            totals.fat += food.fat * radio
        }
        return [
            (NSLocalizedString("KeyProtein", comment: ""), totals.protein),
            (NSLocalizedString("KeyCarbs", comment: ""), totals.carbs),
            (NSLocalizedString("KeyFat", comment: ""), totals.fat)
        ]
    }
    var averageCaloriesByMeal: [(meal: String, avgCalories: Double)] {
        var grouped: [MealType: [Double]] = [:]
        
        for entry in allEntries {
            let calories = (entry.food?.calories ?? 0) * entry.servingSize / 100
            grouped[entry.mealType, default: []].append(calories)
        }
        
        return grouped.map { (meal, values) in
            let avg = values.reduce(0, +) / Double(values.count)
            return (meal.localizedName, avg)
        }.sorted { $0.meal < $1.meal }
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 30) {
                
                Text(NSLocalizedString("KeyGraphic", comment: ""))
                    .font(.largeTitle)
                    .bold()
                    .padding(.horizontal)
                
                VStack(alignment: .leading) {
                    Text(NSLocalizedString("KeyMostFrequentMealType", comment: ""))
                        .font(.headline)
                        .padding(.bottom, 5)
                    
                    if mealTypeStats.isEmpty {
                        Text(NSLocalizedString("KeyNoData", comment: ""))
                            .foregroundStyle(.secondary)
                    } else {
                        Chart(mealTypeStats, id: \.type) { stat in
                            BarMark(
                                x: .value("Count", stat.count),
                                y: .value("Meal", stat.type)
                            )
                            .foregroundStyle(.orange.gradient)
                        }
                        .frame(height: 200)
                    }
                }
                .padding(.horizontal)
                
                VStack(alignment: .leading) {
                    Text(NSLocalizedString("KeyNutrientBreakdown", comment: ""))
                        .font(.headline)
                        .padding(.bottom, 5)
                    
                    if nutrientTotals.allSatisfy({ $0.total == 0 }) {
                        Text(NSLocalizedString("KeyNoData", comment: ""))
                            .foregroundStyle(.secondary)
                    } else {
                        Chart(nutrientTotals, id: \.nutrient) { nutrient in
                            SectorMark(
                                angle: .value("Amount", nutrient.total),
                                innerRadius: .ratio(0.5),
                                angularInset: 1
                            )
                            .foregroundStyle(by: .value("Type", nutrient.nutrient))
                        }
                        .frame(height: 250)
                    }
                }
                .padding(.horizontal)
                
                VStack(alignment: .leading) {
                    Text(NSLocalizedString("KeyChartCaloriesByMeal", comment: ""))
                        .font(.headline)
                        .padding(.bottom, 5)
                    
                    if averageCaloriesByMeal.isEmpty {
                        Text(NSLocalizedString("KeyNoData", comment: ""))
                            .foregroundStyle(.secondary)
                            .frame(maxWidth: .infinity, alignment: .center)
                            .padding()
                    } else {
                        Chart(averageCaloriesByMeal, id: \.meal) { data in
                            BarMark(
                                x: .value("Type de repas", data.meal),
                                y: .value("Calories moyennes", data.avgCalories)
                            )
                            .foregroundStyle(.orange.gradient)
                            .cornerRadius(6)
                        }
                        .chartYAxisLabel(NSLocalizedString("KeyCalorie", comment: ""))
                        .chartXAxisLabel(NSLocalizedString("KeyTypeMeal", comment: ""))
                        .frame(height: 300)
                    }
                    
                    Spacer()
                }
                .padding(.horizontal)
            }
            .padding(.vertical)
            
        }
    }
}

    #Preview {
        do {
            let container = try ModelContainer(
                for: Food.self, FoodEntry.self,
                configurations: ModelConfiguration(isStoredInMemoryOnly: true)
            )
            
            let context = container.mainContext
            
            // Données de test
            let food1 = Food(name: "Riz", calories: 130, protein: 2.7, carbs: 28, fat: 0.3)
            let food2 = Food(name: "Poulet", calories: 165, protein: 31, carbs: 0, fat: 3.6)
            let food3 = Food(name: "Avocat", calories: 160, protein: 2, carbs: 9, fat: 15)
            
            context.insert(food1)
            context.insert(food2)
            context.insert(food3)
            
            context.insert(FoodEntry(food: food1, servingSize: 200, mealType: .lunch))
            context.insert(FoodEntry(food: food2, servingSize: 150, mealType: .dinner))
            context.insert(FoodEntry(food: food3, servingSize: 100, mealType: .breakfast))
            context.insert(FoodEntry(food: food2, servingSize: 200, mealType: .lunch))
            context.insert(FoodEntry(food: food3, servingSize: 100, mealType: .breakfast))
            context.insert(FoodEntry(food: food3, servingSize: 100, mealType: .breakfast))
            context.insert(FoodEntry(food: food3, servingSize: 100, mealType: .breakfast))
            context.insert(FoodEntry(food: food3, servingSize: 100, mealType: .breakfast))
            context.insert(FoodEntry(food: food3, servingSize: 100, mealType: .breakfast))
            context.insert(FoodEntry(food: food3, servingSize: 100, mealType: .breakfast))
            context.insert(FoodEntry(food: food3, servingSize: 100, mealType: .breakfast))
            context.insert(FoodEntry(food: food3, servingSize: 100, mealType: .breakfast))
            context.insert(FoodEntry(food: food3, servingSize: 100, mealType: .breakfast))
            context.insert(FoodEntry(food: food3, servingSize: 100, mealType: .breakfast))
            context.insert(FoodEntry(food: food2, servingSize: 150, mealType: .dinner))
            context.insert(FoodEntry(food: food2, servingSize: 150, mealType: .dinner))
            context.insert(FoodEntry(food: food2, servingSize: 150, mealType: .dinner))
            context.insert(FoodEntry(food: food2, servingSize: 150, mealType: .dinner))
            context.insert(FoodEntry(food: food2, servingSize: 150, mealType: .dinner))
            context.insert(FoodEntry(food: food2, servingSize: 150, mealType: .dinner))
            
            return DailyChartsView()
                .modelContainer(container)
        } catch {
            fatalError("Erreur de preview : \(error)")
        }
    }
