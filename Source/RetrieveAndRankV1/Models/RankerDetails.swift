/**
 * Copyright IBM Corporation 2016
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

/** A model containing information about a specific ranker. */
public struct RankerDetails: JSONDecodable {
    
    /// The unique identifier for this ranker.
    public let rankerID: String
    
    /// The link to this ranker.
    public let url: String
    
    /// The user-supplied name for this ranker.
    public let name: String
    
    /// The date and time, in Coordinated Universal Time, that the ranker was created.
    public let created: String
    
    /// The current state of this ranker.
    public let status: RankerStatus
    
    /// Additional details about the status of this ranker.
    public let statusDescription: String
    
    /// Used internally to initialize a `Ranker` model from JSON.
    public init(json: JSON) throws {
        rankerID = try json.string("ranker_id")
        url = try json.string("url")
        name = try json.string("name")
        created = try json.string("created")
        statusDescription = try json.string("status_description")
        
        guard let rankerStatus = RankerStatus(rawValue: try json.string("status")) else {
            throw JSON.Error.ValueNotConvertible(value: json, to: RankerStatus.self)
        }
        status = rankerStatus
    }
}

/** An enum describing the state of the ranker. */
public enum RankerStatus: String {
    
    case NonExistent = "Non_Existent"
    case Training = "Training"
    case Failed = "Failed"
    case Available = "Available"
    case Unavailable = "Unavailable"
}
