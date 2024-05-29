//
//  WriteUsernameView.swift
//  MatchingPairs
//
//  Created by Catalina Besliu on 27.05.2024.
//

import SwiftUI


/// Congratulation view for completing the game.
/// Takes user input for the username of the player and allows navigation to the `LeaderboardView`
struct WriteUsernameView: View {
    @Environment(\.managedObjectContext) var context
    @State private var showLeaveUserInput = false
    @State private var showLeaderboardView = false
    @State private var name = ""
    var score: ScoreData
    
    var body: some View {
        VStack {
            Text("You won!")
                .font(.largeTitle)
                .foregroundColor(.label)
                .multilineTextAlignment(.center)
            TextField("Please enter your username:", text: $name)
                .multilineTextAlignment(.center)
            NavigationLink(isActive: $showLeaderboardView) {
                LeaderboardView(isFromMainMenu: false)
            } label: {
                EmptyView()
            }
            Spacer()
            Button {
                UsersViewModel.updateUserInCoreData(with: name,
                                                    score: score,
                                                    using: context)
                showLeaderboardView.toggle()
            } label: {
                GenericButton(buttonTitle: "Submit")
            }
            .disabled(name.isEmpty)
            
        }
        .padding()
        .defaultBackground()
        .backButtonModifier(showAlert: $showLeaveUserInput) {
            NavigationManager.shared.popToRootPublisher.send(true)
        }
    }
}

#Preview {
    WriteUsernameView(score: ScoreData(noOfMoves: 1,
                              noOfPoints: 2,
                              time: "01:01"))
}
