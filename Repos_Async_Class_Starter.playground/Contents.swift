import SwiftUI
import Foundation

// Simplified decodable structs from earlier exercise
struct Repositories: Decodable {
  let repos: [Repository]

  enum CodingKeys : String, CodingKey {
    case repos = "items"
  }
}

struct Repository: Decodable {
  let name: String
  let htmlURL: String

  enum CodingKeys : String, CodingKey {
    case name
    case htmlURL = "html_url"
  }
}

// Our initial function (needs fixing...)
func fetchRepositories() async throws -> [Repository] {
  let url = URL(string: "https://api.github.com/search/repositories?q=language:swift&sort=stars&order=desc")!
  let (data, _) = try await URLSession.shared.data(from: url)
  return try JSONDecoder().decode(Repositories.self, from: data).repos
}


// A task to utilize this function
// - call function then loop over repos array to print out the name & url for each
// - interject lots of print statements with 'Step X' to see how things are progressing
Task {
  print("Step 1: task starts")
  do {
    print("Step 2: fetch the repo")
    let repoArray:[Repository] = try await fetchRepositories()
    print("Step 3: loop over repos")
    for repo in repoArray {
      print("- \(repo.name): \(repo.htmlURL)")
    }
    print("step4: task ends")
  } catch {
    print(error)
  }
  

  // ...

  print("Step 5")
}
print("Step 6")
