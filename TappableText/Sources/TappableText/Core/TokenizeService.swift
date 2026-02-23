import Foundation

extension TappableText {
    enum TokenizeService {
        static func tokenizeWord(_ input: String) -> [String] {
            let pattern = #"(\s+|\w+|[^\w\s])"#
            let regex = try? NSRegularExpression(pattern: pattern)
            let range = NSRange(input.startIndex..., in: input)
            let matches = regex?.matches(in: input, range: range) ?? []
            return matches.map { String(input[Range($0.range, in: input)!]) }
        }
        
        static func tokenizeSentence(_ text: String) -> [String] {
            let pattern = #"(\s+|\w+|[^\w\s])"#
            let regex = try? NSRegularExpression(pattern: pattern)
            let range = NSRange(text.startIndex..., in: text)
            let matches = regex?.matches(in: text, range: range) ?? []
            let words = matches.map { String(text[Range($0.range, in: text)!]) }
            
            return words
        }
    }
}
