/**
 * (C) Copyright IBM Corp. 2017, 2020.
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

/**
 Example.
 */
public struct Example: Codable, Equatable {

    /**
     The text of a user input example. This string must conform to the following restrictions:
     - It cannot contain carriage return, newline, or tab characters.
     - It cannot consist of only whitespace characters.
     */
    public var text: String

    /**
     An array of contextual entity mentions.
     */
    public var mentions: [Mention]?

    /**
     The timestamp for creation of the object.
     */
    public var created: Date?

    /**
     The timestamp for the most recent update to the object.
     */
    public var updated: Date?

    // Map each property name to the key that shall be used for encoding/decoding.
    private enum CodingKeys: String, CodingKey {
        case text = "text"
        case mentions = "mentions"
        case created = "created"
        case updated = "updated"
    }

    /**
      Initialize a `Example` with member variables.

      - parameter text: The text of a user input example. This string must conform to the following restrictions:
        - It cannot contain carriage return, newline, or tab characters.
        - It cannot consist of only whitespace characters.
      - parameter mentions: An array of contextual entity mentions.

      - returns: An initialized `Example`.
     */
    public init(
        text: String,
        mentions: [Mention]? = nil
    )
    {
        self.text = text
        self.mentions = mentions
    }

}
