/**
 * Copyright IBM Corporation 2015
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
import Freddy

/**
 
 **DocumentText**
 
 DocumentText returned by the AlchemyLanguage service.
 
 */

public struct DocumentText: JSONDecodable {
    
    /** the URL information was requested for */
    public let url: String?
    
    /** extracted language */
    public let language: String?
    
    /** extracted text */
    public let text: String?
    
    /// Used internally to initialize a DocumentText object
    public init(json: JSON) throws {
        url = try? json.string("url")
        language = try? json.string("language")
        text = try? json.string("text")
    }
}
