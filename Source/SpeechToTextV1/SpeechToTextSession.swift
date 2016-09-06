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

/**
 The IBM Watson Speech to Text service enables you to add speech transcription capabilities to
 your application. It uses machine intelligence to combine information about grammar and language
 structure to generate an accurate transcription. Transcriptions are supported for various audio
 formats and languages.
 */
public class SpeechToTextSession {
    
    /// The results of the most recent recognition request.
    public var results: [TranscriptionResult] {
        get { return socket.results }
    }
    
    /// The state of the session.
    public var state: SpeechToTextState {
        get { return socket.state }
    }
    
    /// Invoked when the session connects to the Speech to Text service.
    public var onConnect: (Void -> Void)? {
        get { return socket.onConnect }
        set { socket.onConnect = newValue }
    }
    
    /// Invoked when the session transitions to the listening state.
    public var onListening: (Void -> Void)? {
        get { return socket.onListening }
        set { socket.onListening = newValue }
    }
    
    /// Invoked when transcription results are received for a recognition request.
    public var onResults: ([TranscriptionResult] -> Void)? {
        get { return socket.onResults }
        set { socket.onResults = newValue }
    }
    
    /// Invoked when an error or warning occurs.
    public var onError: (NSError -> Void)? {
        get { return socket.onError }
        set { socket.onError = newValue }
    }
    
    /// Invoked when the session disconnects from the Speech to Text service.
    public var onDisconnect: (Void -> Void)? {
        get { return socket.onDisconnect }
        set { socket.onDisconnect = newValue }
    }
    
    private let socket: SpeechToTextSocket
    private let recorder: SpeechToTextRecorder
    private let encoder: SpeechToTextEncoder
    private var compress: Bool = true
    private let domain = "com.ibm.watson.developer-cloud.SpeechToTextV1"
    
    /**
     Create a `SpeechToTextSession` object.
     
     - parameter username: The username used to authenticate with the service.
     - parameter password: The password used to authenticate with the service.
     - parameter model: The language and sample rate of the audio. For supported models, visit
        https://www.ibm.com/watson/developercloud/doc/speech-to-text/input.shtml#models.
     - parameter learningOptOut: If `true`, then this request will not be logged for training.
     - parameter serviceURL: The base URL of the Speech to Text service.
     - parameter tokenURL: The URL that shall be used to obtain a token.
     - parameter websocketsURL: The URL that shall be used to stream audio for transcription.
     */
    public init(
        username: String,
        password: String,
        model: String? = nil,
        learningOptOut: Bool? = nil,
        serviceURL: String = "https://stream.watsonplatform.net/speech-to-text/api",
        tokenURL: String = "https://stream.watsonplatform.net/authorization/api/v1/token",
        websocketsURL: String = "wss://stream.watsonplatform.net/speech-to-text/api/v1/recognize")
    {
        socket = SpeechToTextSocket(
            username: username,
            password: password,
            model: model,
            learningOptOut: learningOptOut,
            serviceURL: serviceURL,
            tokenURL: tokenURL,
            websocketsURL: websocketsURL
        )
        
        recorder = SpeechToTextRecorder()
        
        encoder = try! SpeechToTextEncoder(
            format: recorder.format,
            opusRate: Int32(recorder.format.mSampleRate),
            application: .VOIP
        )
    }
    
    /**
     Connect to the Speech to Text service.
     
     If set, the `onConnect()` callback will be invoked after the session connects to the service.
     */
    public func connect() {
        socket.connect()
    }
    
    /**
     Start a recognition request.
 
     - parameter settings: The configuration to use for this recognition request.
     */
    public func startRequest(settings: TranscriptionSettings) {
        socket.writeStart(settings)
    }
    
    /**
     Send an audio file to transcribe.
     
     - parameter audio: The audio file to transcribe.
     */
    public func recognize(audio: NSURL) {
        guard let audio = NSData(contentsOfURL: file) else {
            let failureReason = "Could not load audio data from \(file)."
            let userInfo = [NSLocalizedFailureReasonErrorKey: failureReason]
            let error = NSError(domain: domain, code: 0, userInfo: userInfo)
            onError?(error)
            return
        }
        recognize(audio)
    }
    
    /**
     Send audio data to transcribe.
     
     - parameter audio: The audio data to transcribe.
     */
    public func recognize(audio: NSData) {
        socket.writeAudio(audio)
    }
    
    /**
     Start streaming microphone audio data to transcribe.
     
     By default, microphone audio data is compressed to Opus format to reduce latency and bandwidth.
     To disable Opus compression and send linear PCM data instead, set `compress` to `false`.
     
     If compression is enabled, the recognitions request's `contentType` setting should be set to
     `AudioMediaType.Opus`. If compression is disabled, then the `contentType` settings should be
     set to `AudioMediaType.L16(rate: 16000, channels: 1)`.
     
     This function may cause the system to automatically prompt the user for permission
     to access the microphone. See `AVAudioSession.requestRecordPermission(_:)` if you
     would rather explicitly ask for the user's permission before invoking this function.
     
     - parameter compress: Should microphone audio be compressed to Opus before being sent to
        the Speech to Text service? (Opus compression reduces latency and bandwidth.)
     */
    public func startMicrophone(compress: Bool = true) {
        print("starting microphone")
        self.compress = compress
        
        let onAudioPCM = { (pcm: NSData) in
            guard pcm.length > 0 else { return }
            self.socket.writeAudio(pcm)
        }
        
        let onAudioOpus = { (pcm: NSData) in
            guard pcm.length > 0 else { return }
            try! self.encoder.encode(pcm)
            let opus = self.encoder.bitstream(true)
            self.socket.writeAudio(opus)
        }
        
        if compress {
            recorder.onAudio = onAudioOpus
        } else {
            recorder.onAudio = onAudioPCM
        }
        
        recorder.startRecording()
    }
    
    /**
     Stop streaming microphone audio data to transcribe.
     */
    public func stopMicrophone() {
        print("stopping microphone")
        recorder.stopRecording()
        if compress {
            let opus = try! self.encoder.endstream()
            self.socket.writeAudio(opus)
        }
    }
    
    /**
     Stop the recognition request.
     */
    public func stopRequest() {
        socket.writeStop()
    }
    
    /**
     Send a message to prevent the service from automatically disconnecting due to inactivity.
 
     As described in the service documentation, the Speech to Text service terminates the session
     and closes the connection if the inactivity or session timeout is reached. The inactivity
     timeout occurs if audio is being sent by the client but the service detects no speech. The
     inactivity timeout is 30 seconds by default, but can be configured by specifying a value for
     the `inactivityTimeout` setting. The session timeout occurs if the service receives no data
     from the client or sends no interim results for 30 seconds. You cannot change the length of
     this timeout; however, you can extend the session by sending a message. This function sends
     a `no-op` message to touch the session and reset the session timeout in order to keep the
     connection alive.
     */
    public func keepAlive() {
        socket.writeNop()
    }
    
    /**
     Wait for any queued recognition requests to complete then disconnect from the service.
     */
    public func disconnect() {
        socket.waitForResults()
        socket.disconnect()
    }
}
