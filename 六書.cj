// surname.cj - Expressing Chinese surnames using 六書 and union types

// 六書 (Six Principles of Chinese Character Formation)
enum Liushu {
    | 象形 (Xiangxing)     // Pictograms - characters that resemble objects
    | 指事 (Zhishi)        // Indicatives - abstract concepts indicated by symbols
    | 会意 (Huiyi)         // Associative compounds - combining meanings
    | 形声 (Xingsheng)     // Phonetic-semantic compounds - meaning + sound
    | 转注 (Zhuanzhu)      // Mutual explanatory - characters with related meanings
    | 假借 (Jiajie)        // Phonetic loans - borrowed characters
}

// Character component structure
struct Component {
    let glyph: String           // The component character
    let meaning: String         // Semantic meaning
    let liushu: Liushu          // Which 六書 category this component belongs to
}

// Union type for a Chinese character's composition
enum CharacterComposition {
    | Simple(Liushu)                    // Single character with one formation principle
    | Compound(Component, Component)     // Two-component character (e.g., 形声)
    | Complex(Array<Component>)          // Multi-component character
}

// Chinese character representation
struct ChineseChar {
    let character: String        // The actual character (e.g., "张")
    let pinyin: String           // Pronunciation
    let meaning: String          // Core meaning
    let liushu: Liushu           // Primary 六書 classification
    let composition: CharacterComposition   // Internal structure
}

// Surname with additional genealogical context
struct Surname {
    let character: ChineseChar
    let origin: String           // Historical origin
    let rankByPopulation: UInt64 // Ranking in China
}

// Example: Building common Chinese surnames

// 张 (Zhāng) - a common surname
// 形声 character: 弓 (meaning: bow) + 长 (phonetic: zhǎng/cháng)
let zhangComponent1 = Component {
    glyph: "弓",
    meaning: "bow",
    liushu: 象形  // 弓 is a pictogram
}

let zhangComponent2 = Component {
    glyph: "长",
    meaning: "long/grow",
    liushu: 象形  // 长 originally a pictogram of long hair
}

let zhangChar = ChineseChar {
    character: "张",
    pinyin: "Zhāng",
    meaning: "to stretch, to open",
    liushu: 形声,
    composition: Compound(zhangComponent1, zhangComponent2)
}

let surnameZhang = Surname {
    character: zhangChar,
    origin: "Descendants of the archer Zhang Hui",
    rankByPopulation: 3
}

// 李 (Lǐ) - another common surname
// 形声 character: 木 (wood) + 子 (child/phonetic)
let liComponent1 = Component {
    glyph: "木",
    meaning: "tree, wood",
    liushu: 象形
}

let liComponent2 = Component {
    glyph: "子",
    meaning: "child",
    liushu: 象形
}

let liChar = ChineseChar {
    character: "李",
    pinyin: "Lǐ",
    meaning: "plum",
    liushu: 形声,
    composition: Compound(liComponent1, liComponent2)
}

let surnameLi = Surname {
    character: liChar,
    origin: "Descendants of Gao Yao, officials with plum trees",
    rankByPopulation: 2
}

// 王 (Wáng) - 象形/指事 character
let wangChar = ChineseChar {
    character: "王",
    pinyin: "Wáng",
    meaning: "king",
    liushu: 象形,  // Some classify as pictogram (axe shape), some as indicative
    composition: Simple(象形)
}

let surnameWang = Surname {
    character: wangChar,
    origin: "Royal descendants",
    rankByPopulation: 1
}

// Function to describe a character's 六書 properties
func describeCharacter(_ char: ChineseChar): String {
    var description = "Character: ${char.character} (${char.pinyin})\n"
    description += "Meaning: ${char.meaning}\n"
    description += "六書: ${char.liushu}\n"
    
    match (char.composition) {
        case Simple(let liushu) => {
            description += "Composition: Single character - ${liushu}"
        }
        case Compound(let c1, let c2) => {
            description += "Composition: ${c1.glyph} (${c1.meaning}) + ${c2.glyph} (${c2.meaning})"
        }
        case Complex(let components) => {
            description += "Composition: " + components.map(c => "${c.glyph}").join(" + ")
        }
    }
    
    return description
}

// Function to get surname by rank
func getSurnameByRank(rank: UInt64): String? {
    let surnames = [surnameWang, surnameLi, surnameZhang]
    
    for (s in surnames) {
        if (s.rankByPopulation == rank) {
            return s.character.character
        }
    }
    return None
}

// Main demonstration
main(): Int64 {
    println("=== Chinese Surnames with 六書 Classification ===\n")
    
    // Display surname information
    println(describeCharacter(surnameZhang.character))
    println("Rank: #${surnameZhang.rankByPopulation}")
    println("Origin: ${surnameZhang.origin}\n")
    
    println(describeCharacter(surnameLi.character))
    println("Rank: #${surnameLi.rankByPopulation}")
    println("Origin: ${surnameLi.origin}\n")
    
    println(describeCharacter(surnameWang.character))
    println("Rank: #${surnameWang.rankByPopulation}")
    println("Origin: ${surnameWang.origin}\n")
    
    // Demonstrate union type pattern matching
    println("=== Pattern Matching on 六書 ===\n")
    
    let surnames = [surnameZhang, surnameLi, surnameWang]
    
    for (s in surnames) {
        match (s.character.liushu) {
            case 象形 => println("${s.character.character} is a pictogram (象形)")
            case 指事 => println("${s.character.character} is an indicative (指事)")
            case 会意 => println("${s.character.character} is an associative compound (会意)")
            case 形声 => println("${s.character.character} is a phonetic-semantic compound (形声)")
            case 转注 => println("${s.character.character} uses mutual explanation (转注)")
            case 假借 => println("${s.character.character} is a phonetic loan (假借)")
        }
    }
    
    // Query example
    println("\n=== Query by Rank ===")
    if (let name = getSurnameByRank(1)) {
        println("Rank 1 surname: ${name}")
    }
    
    return 0
}
