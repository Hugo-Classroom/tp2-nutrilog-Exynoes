import SwiftUI
import SwiftData


struct HomeView: View {
    var body: some View {
        TabView {
            DailySummaryView()
                .tabItem {
                    Label(NSLocalizedString("KeyToday", comment: ""), systemImage: "sun.max.fill")
                }

            DailyChartsView()
                .tabItem {
                    Label(NSLocalizedString("KeyGraphic", comment: ""), systemImage: "chart.bar.fill")
                }
        }
        .tint(.orange)
        .tabViewStyle(.automatic)
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
            
            return HomeView()
                .modelContainer(container)
        } catch {
            fatalError("Erreur de preview : \(error)")
        }
}
