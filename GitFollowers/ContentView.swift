//
//  ContentView.swift
//  GitFollowers
//
//  Created by Maliks on 28/08/2023.
//

import SwiftUI

struct ContentView: View {
    @State private var user: GitHubUser?
    @State private var userName: String = ""
    
    var body: some View {
        VStack(spacing: 20) {
            
            HStack {
                TextField("Please Enter a userName", text: $userName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .textInputAutocapitalization(.never)
                
                Button("Search") {
                    Task {
                        do {
                            user = try await getUser(userName: self.userName)
                        } catch GHError.invalidResponse {
                            print("Invalid Response")
                        } catch GHError.invalidURL {
                            print("Invalid URL")
                        } catch GHError.invalidData {
                            print("Invalid Data")
                        } catch {
                            print("Unexpected Error")
                        }
                    }
                }
            }.padding()
            
            AsyncImage(url: URL(string: user?.avatarUrl ?? "")) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .clipShape(Circle())
            } placeholder: {
                Circle()
                    .foregroundColor(.secondary)
            }
            .frame(width: 120, height: 120)
            
            Text("\(user?.name ?? "-") (\(user?.login ?? "-"))")
                .bold()
                .font(.title3)
            
            Text(user?.bio ?? "-")
            
            Text("No. of Followers: \(user?.followers ?? 0)")
            
            Text("Following: \(user?.following ?? 0)")
            
            Spacer()
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
