import Foundation

struct MockData {
    // 🥩 Protéines
    static let proteinFood = Food(
        name: NSLocalizedString("KeyFoodChickenBreast", comment: ""),
        calories: 165,
        protein: 31,
        carbs: 0,
        fat: 3.6,
        desc: NSLocalizedString("KeyFoodChickenBreastDesc", comment: "")
    )
    static let boiledEgg = Food(
        name: NSLocalizedString("KeyBoiledEgg", comment: ""),
        calories: 155,
        protein: 13,
        carbs: 1.1,
        fat: 11,
        desc: NSLocalizedString("KeyBoiledEggDesc", comment: "")
    )
    static let grilledSalmon = Food(
        name: NSLocalizedString("KeyGrilledSalmon", comment: ""),
        calories: 208,
        protein: 20,
        carbs: 0,
        fat: 13,
        desc: NSLocalizedString("KeyGrilledSalmonDesc", comment: "")
    )
    static let firmTofu = Food(
        name: NSLocalizedString("KeyFirmTofu", comment: ""),
        calories: 76,
        protein: 8,
        carbs: 1.9,
        fat: 4.8,
        desc: NSLocalizedString("KeyFirmTofuDesc", comment: "")
    )
    static let leanBeef = Food(
        name: NSLocalizedString("KeyLeanBeef", comment: ""),
        calories: 250,
        protein: 26,
        carbs: 0,
        fat: 17,
        desc: NSLocalizedString("KeyLeanBeefDesc", comment: "")
    )

    // 🍚 Féculents
    static let rice = Food(
        name: NSLocalizedString("KeyRice", comment: ""),
        calories: 130,
        protein: 2.7,
        carbs: 28,
        fat: 0.3,
        desc: NSLocalizedString("KeyRiceDesc", comment: "")
    )
    static let pasta = Food(
        name: NSLocalizedString("KeyPasta", comment: ""),
        calories: 131,
        protein: 5,
        carbs: 25,
        fat: 1.1,
        desc: NSLocalizedString("KeyPastaDesc", comment: "")
    )
    static let wholeWheatBread = Food(
        name: NSLocalizedString("KeyWholeWheatBread", comment: ""),
        calories: 247,
        protein: 13,
        carbs: 41,
        fat: 4.2,
        desc: NSLocalizedString("KeyWholeWheatBreadDesc", comment: "")
    )
    static let oatmeal = Food(
        name: NSLocalizedString("KeyOatmeal", comment: ""),
        calories: 71,
        protein: 2.5,
        carbs: 12,
        fat: 1.4,
        desc: NSLocalizedString("KeyOatmealDesc", comment: "")
    )
    static let sweetPotato = Food(
        name: NSLocalizedString("KeySweetPotato", comment: ""),
        calories: 86,
        protein: 1.6,
        carbs: 20,
        fat: 0.1,
        desc: NSLocalizedString("KeySweetPotatoDesc", comment: "")
    )

    // 🍎 Fruits
    static let apple = Food(
        name: NSLocalizedString("KeyApple", comment: ""),
        calories: 52,
        protein: 0.3,
        carbs: 14,
        fat: 0.2,
        desc: NSLocalizedString("KeyAppleDesc", comment: "")
    )
    static let banana = Food(
        name: NSLocalizedString("KeyBanana", comment: ""),
        calories: 89,
        protein: 1.1,
        carbs: 23,
        fat: 0.3,
        desc: NSLocalizedString("KeyBananaDesc", comment: "")
    )
    static let orange = Food(
        name: NSLocalizedString("KeyOrange", comment: ""),
        calories: 47,
        protein: 0.9,
        carbs: 12,
        fat: 0.1,
        desc: NSLocalizedString("KeyOrangeDesc", comment: "")
    )
    static let strawberries = Food(
        name: NSLocalizedString("KeyStrawberries", comment: ""),
        calories: 32,
        protein: 0.7,
        carbs: 7.7,
        fat: 0.3,
        desc: NSLocalizedString("KeyStrawberriesDesc", comment: "")
    )
    static let avocado = Food(
        name: NSLocalizedString("KeyAvocado", comment: ""),
        calories: 160,
        protein: 2,
        carbs: 9,
        fat: 15,
        desc: NSLocalizedString("KeyAvocadoDesc", comment: "")
    )

    // 🥦 Légumes
    static let broccoli = Food(
        name: NSLocalizedString("KeyBroccoli", comment: ""),
        calories: 34,
        protein: 2.8,
        carbs: 7,
        fat: 0.4,
        desc: NSLocalizedString("KeyBroccoliDesc", comment: "")
    )
    static let carrots = Food(
        name: NSLocalizedString("KeyCarrot", comment: ""),
        calories: 41,
        protein: 0.9,
        carbs: 10,
        fat: 0.2,
        desc: NSLocalizedString("KeyCarrotDesc", comment: "")
    )
    static let spinach = Food(
        name: NSLocalizedString("KeySpinach", comment: ""),
        calories: 23,
        protein: 2.9,
        carbs: 3.6,
        fat: 0.4,
        desc: NSLocalizedString("KeySpinachDesc", comment: "")
    )
    static let tomato = Food(
        name: NSLocalizedString("KeyTomato", comment: ""),
        calories: 18,
        protein: 0.9,
        carbs: 3.9,
        fat: 0.2,
        desc: NSLocalizedString("KeyTomatoDesc", comment: "")
    )

    // 🍫 Collations / Autres
    static let almonds = Food(
        name: NSLocalizedString("KeyAlmonds", comment: ""),
        calories: 579,
        protein: 21,
        carbs: 22,
        fat: 50,
        desc: NSLocalizedString("KeyAlmondsDesc", comment: "")
    )
    static let peanutButter = Food(
        name: NSLocalizedString("KeyPeanutButter", comment: ""),
        calories: 588,
        protein: 25,
        carbs: 20,
        fat: 50,
        desc: NSLocalizedString("KeyPeanutButterDesc", comment: "")
    )
    static let greekYogurt = Food(
        name: NSLocalizedString("KeyGreekYogurt", comment: ""),
        calories: 59,
        protein: 10,
        carbs: 3.6,
        fat: 0.4,
        desc: NSLocalizedString("KeyGreekYogurtDesc", comment: "")
    )
    static let cheddar = Food(
        name: NSLocalizedString("KeyCheddar", comment: ""),
        calories: 403,
        protein: 25,
        carbs: 1.3,
        fat: 33,
        desc: NSLocalizedString("KeyCheddarDesc", comment: "")
    )
    static let darkChocolate = Food(
        name: NSLocalizedString("KeyDarkChocolate", comment: ""),
        calories: 598,
        protein: 7.8,
        carbs: 46,
        fat: 42,
        desc: NSLocalizedString("KeyDarkChocolateDesc", comment: "")
    )


    static let foods = [
        proteinFood, boiledEgg, grilledSalmon, firmTofu, leanBeef,
        rice, pasta, wholeWheatBread, oatmeal, sweetPotato,
        apple, banana, orange, strawberries, avocado,
        broccoli, carrots, spinach, tomato,
        almonds, peanutButter, greekYogurt, cheddar, darkChocolate
    ]
}

