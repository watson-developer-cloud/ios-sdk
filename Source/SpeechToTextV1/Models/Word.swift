/**
 * Copyright IBM Corporation 2018
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 **/

import Foundation

/** Word. */
public struct Word {

    /// A word from the custom model's words resource. The spelling of the word is used to train the model.
    public var word: String

    /// An array of pronunciations for the word. The array can include the sounds-like pronunciation automatically generated by the service if none is provided for the word; the service adds this pronunciation when it finishes processing the word.
    public var soundsLike: [String]

    /// The spelling of the word that the service uses to display the word in a transcript. The field contains an empty string if no display-as value is provided for the word, in which case the word is displayed as it is spelled.
    public var displayAs: String

    /// A sum of the number of times the word is found across all corpora. For example, if the word occurs five times in one corpus and seven times in another, its count is `12`. If you add a custom word to a model before it is added by any corpora, the count begins at `1`; if the word is added from a corpus first and later modified, the count reflects only the number of times it is found in corpora.
    public var count: Int

    /// An array of sources that describes how the word was added to the custom model's words resource. For OOV words added from a corpus, includes the name of the corpus; if the word was added by multiple corpora, the names of all corpora are listed. If the word was modified or added by the user directly, the field includes the string `user`.
    public var source: [String]

    /// If the service discovered one or more problems that you need to correct for the word's definition, an array that describes each of the errors.
    public var error: [WordError]?

    /**
     Initialize a `Word` with member variables.

     - parameter word: A word from the custom model's words resource. The spelling of the word is used to train the model.
     - parameter soundsLike: An array of pronunciations for the word. The array can include the sounds-like pronunciation automatically generated by the service if none is provided for the word; the service adds this pronunciation when it finishes processing the word.
     - parameter displayAs: The spelling of the word that the service uses to display the word in a transcript. The field contains an empty string if no display-as value is provided for the word, in which case the word is displayed as it is spelled.
     - parameter count: A sum of the number of times the word is found across all corpora. For example, if the word occurs five times in one corpus and seven times in another, its count is `12`. If you add a custom word to a model before it is added by any corpora, the count begins at `1`; if the word is added from a corpus first and later modified, the count reflects only the number of times it is found in corpora.
     - parameter source: An array of sources that describes how the word was added to the custom model's words resource. For OOV words added from a corpus, includes the name of the corpus; if the word was added by multiple corpora, the names of all corpora are listed. If the word was modified or added by the user directly, the field includes the string `user`.
     - parameter error: If the service discovered one or more problems that you need to correct for the word's definition, an array that describes each of the errors.

     - returns: An initialized `Word`.
    */
    public init(word: String, soundsLike: [String], displayAs: String, count: Int, source: [String], error: [WordError]? = nil) {
        self.word = word
        self.soundsLike = soundsLike
        self.displayAs = displayAs
        self.count = count
        self.source = source
        self.error = error
    }
}

extension Word: Codable {

    private enum CodingKeys: String, CodingKey {
        case word = "word"
        case soundsLike = "sounds_like"
        case displayAs = "display_as"
        case count = "count"
        case source = "source"
        case error = "error"
        static let allValues = [word, soundsLike, displayAs, count, source, error]
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        word = try container.decode(String.self, forKey: .word)
        soundsLike = try container.decode([String].self, forKey: .soundsLike)
        displayAs = try container.decode(String.self, forKey: .displayAs)
        count = try container.decode(Int.self, forKey: .count)
        source = try container.decode([String].self, forKey: .source)
        error = try container.decodeIfPresent([WordError].self, forKey: .error)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(word, forKey: .word)
        try container.encode(soundsLike, forKey: .soundsLike)
        try container.encode(displayAs, forKey: .displayAs)
        try container.encode(count, forKey: .count)
        try container.encode(source, forKey: .source)
        try container.encodeIfPresent(error, forKey: .error)
    }

}
