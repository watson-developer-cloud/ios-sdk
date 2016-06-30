# Watson Developer Cloud iOS SDK

[![Build Status](https://travis-ci.org/watson-developer-cloud/ios-sdk.svg?branch=master)](https://travis-ci.org/watson-developer-cloud/ios-sdk)
[![Carthage Compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![codecov.io](https://codecov.io/github/watson-developer-cloud/ios-sdk/coverage.svg?branch=master)](https://codecov.io/github/watson-developer-cloud/ios-sdk?branch=master)
[![Docs](https://img.shields.io/badge/Docs-0.4.1-green.svg?style=flat)](http://watson-developer-cloud.github.io/ios-sdk/)
[![Swift 2.2](https://img.shields.io/badge/Swift-2.2-orange.svg?style=flat)](https://developer.apple.com/swift/)
[![CLA assistant](https://cla-assistant.io/readme/badge/watson-developer-cloud/ios-sdk)](https://cla-assistant.io/watson-developer-cloud/ios-sdk)

## Overview

The Watson Developer Cloud iOS SDK makes it easy for mobile developers to build Watson-powered applications. With the iOS SDK you can leverage the power of Watson's advanced artificial intelligence, machine learning, and deep learning techniques to understand unstructured data and engage with mobile users in new ways.

Follow our [Quickstart Guide](https://github.com/watson-developer-cloud/ios-sdk/blob/master/Documentation/Quickstart.md) to build your first Watson-powered app!

## Contents

### General

* [Requirements](#requirements)
* [Installation](#installation)
* [Service Instances](#service-instances)
* [Contributing](#contributing)
* [License](#license)

### Services

* [AlchemyData News](#alchemydata-news)
* [AlchemyLanguage](#alchemylanguage)
* [Alchemy Vision](#alchemy-vision)
* [Conversation](#conversation)
* [Dialog](#dialog)
* [Document Conversion](#document-conversion)
* [Language Translator](#language-translator)
* [Natural Language Classifier](#natural-language-classifier)
* [Personality Insights](#personality-insights)
* [Speech to Text](#speech-to-text)
* [Text to Speech](#text-to-speech)
* [Tone Analyzer](#tone-analyzer)
* [Tradeoff Analytics](#tradeoff-analytics)
* [Visual Recognition](#visual-recognition)

---

## Requirements

- iOS 9.0+
- Xcode 7.3+

## Installation

### Dependency Management

The Watson Developer Cloud iOS SDK uses [Carthage](https://github.com/Carthage/Carthage) to manage dependencies and build binary frameworks.

You can install Carthage with [Homebrew](http://brew.sh/):

```bash
$ brew update
$ brew install carthage
```

To use the Watson Developer Cloud iOS SDK in your application, specify it in your `Cartfile`:

```
github "watson-developer-cloud/ios-sdk"
```

Then run `carthage update --platform iOS` to build the dependencies and frameworks. Finally, drag-and-drop the built frameworks into your Xcode project.

### App Transport Security

App Transport Security was introduced with iOS 9 to enforce secure Internet connections. The IBM Bluemix team is in the process of upgrading the platform to the latest security standards required by App Transport Security.

Please add the following exception to your application's `Info.plist` to securely connect to IBM Bluemix and the Watson services:

```xml
<key>NSAppTransportSecurity</key>
    <dict>
        <key>NSExceptionDomains</key>
        <dict>
            <key>watsonplatform.net</key>
            <dict>
                <key>NSTemporaryExceptionRequiresForwardSecrecy</key>
                <false/>
                <key>NSIncludesSubdomains</key>
                <true/>
                <key>NSTemporaryExceptionAllowsInsecureHTTPLoads</key>
                <true/>
                <key>NSTemporaryExceptionMinimumTLSVersion</key>
                <string>TLSv1.0</string>
            </dict>
        </dict>
    </dict>
```

## Service Instances and Credentials

The [IBM Watson Developer Cloud](https://www.ibm.com/smarterplanet/us/en/ibmwatson/developercloud/) offers a variety of services for developing cognitive applications. The complete list of Watson Developer Cloud services is available from the [services catalog](https://www.ibm.com/smarterplanet/us/en/ibmwatson/developercloud/services-catalog.html). Services are instantiated using the [IBM Bluemix](http://www.ibm.com/cloud-computing/bluemix/) cloud platform.

Follow these steps to create a service instance and obtain its credentials:

1. Log in to Bluemix at [https://bluemix.net](https://bluemix.net).
2. Create a service instance:
    a. From the Dashboard, select "Use Services or APIs".
    b. Select the service you want to use.
    c. Click "Create".
3. Copy your service credentials:
    a. Click "Service Credentials" on the left side of the page.
    b. Copy the service's `username` and `password` (or `api_key` for Alchemy).

You will need to provide these service credentials in your mobile application. For example:

```swift
let textToSpeech = TextToSpeech(username: "your-username-here", password: "your-password-here")
```

Note that service credentials are different from your Bluemix username and password.

## Contributing

See [CONTRIBUTING](https://github.com/watson-developer-cloud/ios-sdk/blob/master/.github/CONTRIBUTING.md) on how to help out.

## License

This library is licensed under Apache 2.0. Full license text is
available in [LICENSE](https://github.com/watson-developer-cloud/ios-sdk/blob/master/LICENSE).

This SDK is intended solely for use with an Apple iOS product and intended to be used in conjunction with officially licensed Apple development tools.

---

## AlchemyData News

AlchemyData News provides news and blog content enriched with natural language processing to allow for highly targeted search and trend analysis. Now you can query the world's news sources and blogs like a database.

The following example demonstrates how to use the AlchemyData News service:

```swift
let apiKey = "your-apikey-here"
let alchemyDataNews = AlchemyDataNews(apiKey: apiKey)

let start = "now-1d" // yesterday
let end = "now" // today
let query = [
  "q.enriched.url.title": "O[IBM^Apple]",
  "return": "enriched.url.title,enriched.url.entities.entity.text,enriched.url.entities.entity.type"
]
let failure = { (error: NSError) in print(error) }

alchemyDataNews.getNews(start, end: end, query: query, failure: failure) { news in
  print(news)
}
```

Use the [Count and TimeSlice Queries](http://docs.alchemyapi.com/docs/counts) and [API Fields](http://docs.alchemyapi.com/docs/full-list-of-supported-news-api-fields) documentation to refine your query.

The following links provide additional information about the IBM AlchemyData News service:

* [IBM AlchemyData News - Service Page](https://www.ibm.com/smarterplanet/us/en/ibmwatson/developercloud/alchemy-data-news.html)
* [IBM AlchemyData News - Documentation](http://docs.alchemyapi.com/)
* [IBM AlchemyData News - Demo](http://querybuilder.alchemyapi.com/builder)

## AlchemyLanguage

AlchemyLanguage is a collection of text analysis functions that derive semantic information from your content. You can input text, HTML, or a public URL and leverage sophisticated natural language processing techniques to get a quick high-level understanding of your content and obtain detailed insights such as directional sentiment from entity to object.

AlchemyLanguage has a number of features, including:

- Entity Extraction
- Sentiment Analysis
- Keyword Extraction
- Concept Tagging
- Relation Extraction
- Taxonomy Classification
- Author Extraction
- Language Detection
- Text Extraction
- Microformats Parsing
- Feed Detection

The following example demonstrates how to use the AlchemyLanguage service:

```swift
let apiKey = "your-apikey-here"
let alchemyLanguage = AlchemyLanguage(apiKey: apiKey)

let url = "https://github.com/watson-developer-cloud/ios-sdk"
let failure = { (error: NSError) in print(error) }
alchemyLanguage.getTextSentiment(forURL: url, failure: failure) { sentiment in
  print(sentiment)
}
```

The following links provide additional information about the IBM AlchemyLanguage service:

* [IBM AlchemyLanguage - Service Page](http://www.ibm.com/smarterplanet/us/en/ibmwatson/developercloud/alchemy-language.html)
* [IBM AlchemyLanguage - Documentation](http://www.ibm.com/smarterplanet/us/en/ibmwatson/developercloud/doc/alchemylanguage/)
* [IBM AlchemyLanguage - Demo](https://alchemy-language-demo.mybluemix.net/)

## Conversation

With the IBM Watson Conversation service you can create cognitive agents--virtual agents that combine machine learning, natural language understanding, and integrated dialog scripting tools to provide outstanding customer engagements.

The following example shows how to send a message to the Conversation service and print the response:

```swift
let username = "your-username-here"
let password = "your-password-here"
let version = "YYYY-MM-DD" // use today's date for the most recent version
let conversation = Conversation(username: username, password: password, version: version)


let workspace = "your-workspace-id-here"
let message = "your-message-here"
let failure = { (error: NSError) in print(error) }
conversation.message(workspace, message: message, failure: failure) { response in
    print(response)
}
```

* [IBM Watson Conversation - Service Page](http://www.ibm.com/smarterplanet/us/en/ibmwatson/developercloud/conversation.html)
* [IBM Watson Conversation - Documentation](http://www.ibm.com/smarterplanet/us/en/ibmwatson/developercloud/doc/conversation/overview.shtml)

## Dialog

The IBM Watson Dialog service provides a comprehensive and robust platform for managing conversations between virtual agents and users through an application programming interface (API). Developers automate branching conversations that use natural language to automatically respond to user questions, cross-sell and up-sell, walk users through processes or applications, or even hand-hold users through difficult tasks.

To use the Dialog service, developers script conversations as they would happen in the real world, upload them to a Dialog application, and enable back-and-forth conversations with a user.

The following example demonstrates how to instantiate the Dialog class:

```swift
let username = "your-username-here"
let password = "your-password-here"
let dialog = Dialog(username: username, password: password)
```

The following example demonstrates how to create a dialog application:

```swift
// store dialog id to access application
var dialogID: DialogID?

guard let fileURL = NSBundle.mainBundle().URLForResource("your-dialog-filename", withExtension: "xml") else {
  print("Failed to locate dialog file.")
  return
}

let name = "your-dialog-name"
let failure = { (error: NSError) in print(error) }
dialog.createDialog(dialogName, fileURL: fileURL, failure: failure) { dialogID in
  self.dialogID = dialogID
  print(dialogID)
}
```

The following example demonstrates how to start a conversation with a dialog application:

```swift
// store ids to continue conversation
var conversationID: Int?
var clientID: Int?

let failure = { (error: NSError) in print(error) }
dialog.converse(dialogID!, failure: failure) { response in
    self.conversationID = response.conversationID
    self.clientID = response.clientID
    print(response.response)
}
```

The following example demonstrates how to continue a conversation with a dialog application:

```swift
let input = "your-text-here"
let failure = { (error: NSError) in print(error) }
dialog.converse(dialogID!, conversationID: conversationID!, clientID: clientID!, input: input, failure: failure) { response in
    print(conversationResponse.response)
}
```

The following links provide additional information about the IBM Watson Dialog service:

* [IBM Watson Dialog - Service Page](http://www.ibm.com/smarterplanet/us/en/ibmwatson/developercloud/dialog.html)
* [IBM Watson Dialog - Video](https://www.youtube.com/watch?v=Rn64SpnSq9I)
* [IBM Watson Dialog - Documentation](http://www.ibm.com/smarterplanet/us/en/ibmwatson/developercloud/doc/dialog/)
* [IBM Watson Dialog - Demo](http://dialog-demo.mybluemix.net/?cm_mc_uid=57695492765114489852726&cm_mc_sid_50200000=1449164796)

## Document Conversion

The IBM Watson Document Conversion Service converts a single HTML, PDF, or Microsoft Word™ document. The input document is transformed into normalized HTML, plain text, or a set of JSON-formatted Answer units that can be used with other Watson services, like the Watson Retrieve and Rank Service.

The following example demonstrates how to convert a document:

```swift
let username = "your-username-here"
let password = "your-password-here"
let version = "2015-12-15"
let documentConversion = DocumentConversion(username: username, password: password, version: version)

guard let document = NSBundle.mainBundle().URLForResource("your-dialog-filename", withExtension: "xml") else {
  print("Failed to locate dialog file.")
  return
}

let config = documentConversion.writeConfig(ReturnType.Text)
let failure = { (error: NSError) in print(error) }
documentConversion.convertDocument(config, document: document, failure: failure) { text in
  print(text)
}
```

The following links provide additional information about the IBM Document Conversion service:

* [IBM Watson Document Conversion - Documentation](http://www.ibm.com/smarterplanet/us/en/ibmwatson/developercloud/doc/document-conversion/index.shtml)
* [IBM Watson Document Conversion - Demo](https://watson-api-explorer.mybluemix.net/apis/document-conversion-v1)

## Language Translator

The IBM Watson Language Translator service lets you select a domain, customize it, then identify or select the language of text, and then translate the text from one supported language to another.

The following example demonstrates how to use the Language Translator service:

```swift
let username = "your-username-here"
let password = "your-password-here"
let languageTranslator = LanguageTranslator(username: username, password: password)

let failure = { (error: NSError) in print(error) }
languageTranslator.translate("Hello", source: "en", target: "es", failure: failure) { translation in
  print(translation)
}
```

The following links provide more information about the IBM Watson Language Translator service:

* [IBM Watson Language Translator - Service Page](http://www.ibm.com/smarterplanet/us/en/ibmwatson/developercloud/language-translation.html)
* [IBM Watson Language Translator - Documentation](http://www.ibm.com/smarterplanet/us/en/ibmwatson/developercloud/doc/language-translation/)
* [IBM Watson Language Translator - Demo](https://language-translation-demo.mybluemix.net/)

## Natural Language Classifier

The IBM Watson Natural Language Classifier service enables developers without a background in machine learning or statistical algorithms to create natural language interfaces for their applications. The service interprets the intent behind text and returns a corresponding classification with associated confidence levels. The return value can then be used to trigger a corresponding action, such as redirecting the request or answering a question.

The following example demonstrates how to use the Natural Language Classifier service:

```swift
let username = "your-username-here"
let password = "your-password-here"
let naturalLanguageClassifier = NaturalLanguageClassifier(username: username, password: password)

let classifierID = "your-trained-classifier-id"
let text = "your-text-here"
let failure = { (error: NSError) in print(error) }
naturalLanguageClassifier.classify(classifierID, text: text, failure: failure) { classification in
  print(classification)
}
```

The following links provide more information about the Natural Language Classifier service:

* [IBM Watson Natural Language Classifier - Service Page](http://www.ibm.com/smarterplanet/us/en/ibmwatson/developercloud/nl-classifier.html)
* [IBM Watson Natural Language Classifier - Documentation](http://www.ibm.com/smarterplanet/us/en/ibmwatson/developercloud/doc/nl-classifier)
* [IBM Watson Natural Language Classifier - Demo](https://natural-language-classifier-demo.mybluemix.net/)

## Personality Insights

The IBM Watson Personality Insights service enables applications to derive insights from social media, enterprise data, or other digital communications. The service uses linguistic analytics to infer personality and social characteristics, including Big Five, Needs, and Values, from text.

```swift
let username = "your-username-here"
let password = "your-password-here"
let personalityInsights = PersonalityInsights(username: username, password: password)

let text = "your-input-text"
let failure = { (error: NSError) in print(error) }
personalityInsights.getProfile(text: text, failure: failure) { profile in
  print(profile)                      
}
```

The following links provide more information about the Personality Insights service:

* [IBM Watson Personality Insights - Service Page](http://www.ibm.com/smarterplanet/us/en/ibmwatson/developercloud/personality-insights.html)
* [IBM Watson Personality Insights - Documentation](http://www.ibm.com/smarterplanet/us/en/ibmwatson/developercloud/doc/personality-insights)
* [IBM Watson Personality Insights - Demo](https://personality-insights-livedemo.mybluemix.net)

## Speech to Text

The IBM Watson Speech to Text service enables you to add speech transcription capabilities to your application. It uses machine intelligence to combine information about grammar and language structure to generate an accurate transcription. Transcriptions are supported for various audio formats and languages.

#### Recorded Audio

The following example demonstrates how to use the Speech to Text service to transcribe an audio file.

```swift
let username = "your-username-here"
let password = "your-password-here"
let speechToText = SpeechToText(username: username, password: password)

guard let fileURL = NSBundle.mainBundle().URLForResource("your-audio-filename", withExtension: "wav") else {
	print("Audio file could not be loaded.")
	return
}

let settings = TranscriptionSettings(contentType: .WAV)
let failure = { (error: NSError) in print(error) }

speechToText.transcribe(fileURL, settings: settings, failure: failure) { results in
  print(results.last?.alternatives.last?.transcript)
}
```

#### Streaming Audio

Audio can also be streamed from the microphone to the Speech to Text service for real-time transcriptions.

(Please note that the microphone is inaccessible when testing applications with the iOS Simulator. Only applications on a physical device can access the microphone to stream audio to Speech to Text.)

The following example demonstrates how to use the Speech to Text service with streaming audio:

```swift
let username = "your-username-here"
let password = "your-password-here"
let speechToText = SpeechToText(username: username, password: password)

var settings = TranscriptionSettings(contentType: .L16(rate: 44100, channels: 1))
settings.continuous = true
settings.interimResults = true

let failure = { (error: NSError) in print(error) }
let stopStreaming = speechToText.transcribe(settings, failure: failure) { results in
  print(results.last?.alternatives.last?.transcript)
}

// Streaming will continue until either an end-of-speech event is detected by
// the Speech to Text service or the `stopStreaming` function is executed.
```

#### Custom Capture Sessions

Advanced users who want to create and manage their own `AVCaptureSession` can construct an `AVCaptureAudioDataOutput` to stream audio to the Speech to Text service. This is particularly useful for users who would like to visualize an audio waveform, save audio to disk, or otherwise access the microphone audio data while simultaneously streaming to the Speech to Text service.

The following example demonstrates how to use an `AVCaptureSession` to stream audio to the Speech to Text service.

```swift
class ViewController: UIViewController {
    var captureSession: AVCaptureSession?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let speechToText = SpeechToText(username: "your-username-here", password: "your-password-here")
        
        captureSession = AVCaptureSession()
        guard let captureSession = captureSession else {
            return
        }
        
        let microphoneDevice = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeAudio)
        let microphoneInput = try? AVCaptureDeviceInput(device: microphoneDevice)
        if captureSession.canAddInput(microphoneInput) {
            captureSession.addInput(microphoneInput)
        }
        
        var settings = TranscriptionSettings(contentType: .L16(rate: 44100, channels: 1))
        settings.continuous = true
        settings.interimResults = true
        
        let failure = { (error: NSError) in print(error) }
        let outputOpt = speechToText.createTranscriptionOutput(settings,
                                                               failure: failure) { results in
            if let transcription = results.last?.alternatives.last?.transcript {
                print(transcription)
            }
        }
        
        guard let output = outputOpt else {
            return
        }
        let transcriptionOutput = output.0
        let stopStreaming = output.1
        
        if captureSession.canAddOutput(transcriptionOutput) {
            captureSession.addOutput(transcriptionOutput)
        }
        
        captureSession.startRunning()
    }
    
    // Streaming will continue until either an end-of-speech event is detected by
    // the Speech to Text service, the `stopStreaming` function is executed, or
    // the capture session is stopped.
```
#### Additional Information

The following links provide additional information about the IBM Speech to Text service:

* [IBM Watson Speech to Text - Service Page](http://www.ibm.com/smarterplanet/us/en/ibmwatson/developercloud/speech-to-text.html)
* [IBM Watson Speech to Text - Documentation](http://www.ibm.com/smarterplanet/us/en/ibmwatson/developercloud/doc/speech-to-text/)
* [IBM Watson Speech to Text - Demo](https://speech-to-text-demo.mybluemix.net/)

## Text to Speech

The Text to Speech service gives your app the ability to synthesize spoken text in a variety of voices.

Create a TextToSpeech service:

```swift
let textToSpeech = TextToSpeech(username: "your-username-here", password: "your-password-here")
```

To call the service to synthesize text:

```swift
let failure = { (error: NSError) in print(error) }
textToSpeech.synthesize("Hello World", failure: failure) { data in
        // code here
}
```

When the callback function is invoked, and the request was successful, the data object is an NSData structure containing WAVE formatted audio in 48kHz and mono-channel.

If you wish to play the audio through the device's speakers, create an AVAudioPlayer with that NSData object:

``` swift
let audioPlayer = try AVAudioPlayer(data: data)
audioPlayer.prepareToPlay()
audioPlayer.play()
```

The Watson TTS service contains support for many voices with different genders, languages, and dialects. For a complete list, see the [documentation](http://www.ibm.com/smarterplanet/us/en/ibmwatson/developercloud/doc/text-to-speech/using.shtml#voices) or call the service's to list the possible voices in an asynchronous callback:

```swift
let failure = { (error: NSError) in print(error) }
textToSpeech.getVoices(failure) { voices in
    	  // code here
}
```

You can review the different voices and languages [here](http://www.ibm.com/smarterplanet/us/en/ibmwatson/developercloud/doc/text-to-speech/using.shtml#voices).

To use the voice, such as Kate's, specify the voice identifier in the synthesize method:

```swift
textToSpeech.synthesize("Hello World", voice: SynthesisVoice.GB_Kate) { data in
    // code here
}
```

The following links provide more information about the Text To Speech service:

* [IBM Watson Text To Speech - Service Page](http://www.ibm.com/smarterplanet/us/en/ibmwatson/developercloud/text-to-speech.html)
* [IBM Watson Text To Speech - Documentation](http://www.ibm.com/smarterplanet/us/en/ibmwatson/developercloud/doc/text-to-speech/)
* [IBM Watson Text To Speech - Demo](https://text-to-speech-demo.mybluemix.net/)

## Tone Analyzer

The Tone Analyzer service uses linguistic analysis to detect three types of tones from text: emotion, social tendencies, and language style.

How to instantiate and use the Tone Analyzer service:

```swift
let username = "your-username-here"
let password = "your-password-here"
let versionDate = "YYYY-MM-DD" // use today's date for the most recent version
let service = ToneAnalyzer(username: username, password: password, versionDate: versionDate)

let failure = { (error: NSError) in print(error) }
service.getTone("Text that you want to get the tone of", failure: failure) { responseTone in
    print(responseTone.documentTone)
}
```

The following links provide more information about the Text To Speech service:

* [IBM Watson Tone Analyzer - Service Page](http://www.ibm.com/smarterplanet/us/en/ibmwatson/developercloud/tone-analyzer.html)
* [IBM Watson Tone Analyzer - Documentation](http://www.ibm.com/smarterplanet/us/en/ibmwatson/developercloud/doc/tone-analyzer/)
* [IBM Watson Tone Analyzer - Demo](https://tone-analyzer-demo.mybluemix.net/)

## Tradeoff Analytics

The IBM Watson Tradeoff Analytics service helps people make better choices when faced with multiple, often conflicting, goals and alternatives. By using mathematical filtering techniques to identify the best candidate options based on different criteria, the service can help users explore the tradeoffs between options to make complex decisions. The service combines smart visualization and analytical recommendations for easy and intuitive exploration of tradeoffs.

The following example defines a problem then uses Tradeoff Analytics to identify optimal solutions:

```swift
let username = "your-username-here"
let password = "your-password-here"
let tradeoffAnalytics = TradeoffAnalytics(username: username, password: password)

// define columns
let price = Column(
    key: "price",
    type: .Numeric,
    goal: .Minimize,
    isObjective: true
)
let ram = Column(
    key: "ram",
    type: .Numeric,
    goal: .Maximize,
    isObjective: true
)
let screen = Column(
    key: "screen",
    type: .Numeric,
    goal: .Maximize,
    isObjective: true
)
let os = Column(
    key: "os",
    type: .Categorical,
    isObjective: true,
    range: Range.CategoricalRange(categories: ["android", "windows-phone", "blackberry", "ios"]),
    preference: ["android", "ios"]
)

// define options
let galaxy = Option(
    key: "galaxy",
    values: ["price": .Int(50), "ram": .Int(45), "screen": .Int(5), "os": .String("android")],
    name: "Galaxy S4"
)
let iphone = Option(
    key: "iphone",
    values: ["price": .Int(99), "ram": .Int(40), "screen": .Int(4), "os": .String("ios")],
    name: "iPhone 5"
)
let optimus = Option(
    key: "optimus",
    values: ["price": .Int(10), "ram": .Int(300), "screen": .Int(5), "os": .String("android")],
    name: "LG Optimus G"
)

// define problem
let problem = Problem(
    columns: [price, ram, screen, os],
    options: [galaxy, iphone, optimus],
    subject: "Phone"
)

// define failure function
let failure = { (error: NSError) in print(error) }

// identify optimal options
tradeoffAnalytics.getDilemma(problem, failure: failure) {
    dilemma in
    print(dilemma.solutions)
}
```

The following links provide more information about the Tradeoff Analytics service:

* [IBM Watson Tradeoff Analytics - Service Page](http://www.ibm.com/smarterplanet/us/en/ibmwatson/developercloud/tradeoff-analytics.html)
* [IBM Watson Tradeoff Analytics - Documentation](http://www.ibm.com/smarterplanet/us/en/ibmwatson/developercloud/doc/tradeoff-analytics/)
* [IBM Watson Tradeoff Analytics - Demo](https://tradeoff-analytics-demo.mybluemix.net/)

## Visual Recognition

The Visual Recognition service helps you to understand the contents of images. Submit an image, and the service returns scores for relevant classifiers representing things. It can even detect objects, texts or faces.

Here is an example how to use the service to detect faces in an Image:

```swift
let apiKey = "your-apikey-here"
let versionDate = "YYYY-MM-DD" // use today's date for the most recent version

let service = VisualRecognition(apiKey: apiKey, version: versionDate)

let failure = { (error: NSError) in print(error) }
service.detectFaces(url, failure: failure) { imagesWithFaces in
    // code here
}
```

The following links provide more information about the Text To Speech service:

* [IBM Watson Visual Recognition - Service Page](http://www.ibm.com/smarterplanet/us/en/ibmwatson/developercloud/visual-recognition.html)
* [IBM Watson Visual Recognition - Documentation](http://www.ibm.com/smarterplanet/us/en/ibmwatson/developercloud/doc/visual-recognition/)
* [IBM Watson Visual Recognition - Demo](http://visual-recognition-demo.mybluemix.net/)
