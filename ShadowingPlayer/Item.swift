
import Foundation

struct Item: Equatable, Identifiable {

  let id: String

  let audioFileURL: URL
  let subtitleFileURL: URL

  init(
    identifier: String,
    audioFileURL: URL,
    subtitleFileURL: URL
  ) {
    self.id = identifier
    self.audioFileURL = audioFileURL
    self.subtitleFileURL = subtitleFileURL
  }

  static var example: Self {
    make(name: "example")
  }

  static var overwhelmed: Self {
    make(name: "overwhelmed - Peter Mckinnon")
  }

  static func make(name: String) -> Self {

    let audioFileURL = Bundle.main.path(forResource: name, ofType: "mp3").map {
      URL(fileURLWithPath: $0)
    }!
    let subtitleFileURL = Bundle.main.path(forResource: name, ofType: "srt").map {
      URL(fileURLWithPath: $0)
    }!
    return .init(
      identifier: name,
      audioFileURL: audioFileURL,
      subtitleFileURL: subtitleFileURL
    )
  }

  static func globInBundle() -> [Self] {
    let bundle = Bundle.main

    let audioFiles = bundle.paths(forResourcesOfType: "mp3", inDirectory: nil)

    let items = audioFiles.map { file in
      
      let base = (file as NSString).deletingPathExtension
      let audioFileURL = URL(fileURLWithPath: file)
      let subtitleFileURL = URL(fileURLWithPath: base + ".srt")

      return Item.init(
        identifier: base,
        audioFileURL: audioFileURL,
        subtitleFileURL: subtitleFileURL
      )
    }

    return items

  }
}
