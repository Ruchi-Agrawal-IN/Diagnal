//
//  MovieData.swift
//  Diagnal
//
//  Created by Ruchi Agrawal on 4/7/24.
//

import Foundation

    

   
struct MovieModel: Decodable{
    let image: String
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case image = "poster-image"
      }
}

func fetchData(forPage page: Int, completion: @escaping (Result<[MovieModel], Error>) -> Void) {
    let fileName = "CONTENTLISTINGPAGE-PAGE\(page)"
//    print(page)
    guard let filePath = Bundle.main.path(forResource: fileName, ofType: "json") else {
      completion(.failure(NSError(domain: "MyErrorDomain", code: 1, userInfo: ["message": "File not found"])))
      return
    }

    do {
      guard let jsonData = try String(contentsOfFile: filePath).data(using: .utf8) else {
          //throw MyCustomError.fileNotFound(message: "Error loading JSON file from bundle: File not found or data is empty.")
          return
        }
      let decoder = JSONDecoder()
        struct Root: Decodable {
            let page: Page

            enum CodingKeys: String, CodingKey {
                case page = "page"
            }
        }

        struct Page: Decodable {
            let contentItems: ContentItems

            enum CodingKeys: String, CodingKey {
                case contentItems = "content-items"
            }
        }

        struct ContentItems: Decodable {
            let content: [MovieModel]
            
            enum CodingKeys: String, CodingKey {
                case content = "content"
            }
        }
        let root = try decoder.decode(Root.self, from: jsonData)
        let newMovies = root.page.contentItems.content
      completion(.success(newMovies))
    } catch {
      completion(.failure(error))
    }
  }

