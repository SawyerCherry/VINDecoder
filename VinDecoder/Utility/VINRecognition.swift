//
//  VINRecognition.swift
//  VinDecoder
//
//  Created by Sawyer Cherry
//




import SwiftUI
import Vision

enum TextRecognitionError: Error {
    case somethingWentWrong
}

class TextRecognition {
    private let queue = DispatchQueue(label: "textRecognitionQueue", qos: .userInitiated)
    
    func recognizeText(
        from image: UIImage,
        completion: @escaping (Result<String, Error>) -> Void
    ) {
        queue.async {
            guard let cgImage = image.cgImage else { return }

            let requestHandler = VNImageRequestHandler(cgImage: cgImage, options: [:])

            do {
                let textCompletionHandler = VNRecognizeTextRequest { request, error in
                    if let error = error {
                        print(error.localizedDescription)
                        DispatchQueue.main.async {
                            completion(.failure(error))
                        }
                        return
                    }

                    guard let observations = request.results as? [VNRecognizedTextObservation] else {
                        DispatchQueue.main.async {
                            completion(.failure(TextRecognitionError.somethingWentWrong))
                        }
                        return

                    }

                    var string = ""
                    observations.forEach { observation in
                        guard let recognizedText = observation.topCandidates(1).first else { return }
                        string += recognizedText.string
                        string += "\n"
                    }


                    DispatchQueue.main.async {
                        completion(.success(string))
                    }
                }
                textCompletionHandler.recognitionLevel = .accurate
                textCompletionHandler.usesLanguageCorrection = true
                try requestHandler.perform([textCompletionHandler])
            } catch {
                print(error.localizedDescription)
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
    }
}
