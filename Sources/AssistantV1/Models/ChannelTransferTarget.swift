/**
 * (C) Copyright IBM Corp. 2021.
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
 An object specifying target channels available for the transfer. Each property of this object represents an available
 transfer target. Currently, the only supported property is **chat**, representing the web chat integration.
 */
public struct ChannelTransferTarget: Codable, Equatable {

    /**
     Information for transferring to the web chat integration.
     */
    public var chat: ChannelTransferTargetChat?

    // Map each property name to the key that shall be used for encoding/decoding.
    private enum CodingKeys: String, CodingKey {
        case chat = "chat"
    }

    /**
      Initialize a `ChannelTransferTarget` with member variables.

      - parameter chat: Information for transferring to the web chat integration.

      - returns: An initialized `ChannelTransferTarget`.
     */
    public init(
        chat: ChannelTransferTargetChat? = nil
    )
    {
        self.chat = chat
    }

}
