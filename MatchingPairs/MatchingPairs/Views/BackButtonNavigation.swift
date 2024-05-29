//
//  BackButtonNavigation.swift
//  MatchingPairs
//
//  Created by Catalina Besliu on 29.05.2024.
//

import SwiftUI

/// Modifier for view where we don't want to have the default back button.
/// It expects the user to confirm leaving the screen with an alert.
struct BackButtonNavigation: ViewModifier {
    @Binding var showAlert: Bool
    let dismissAction: () -> ()
    
    func body(content: Content) -> some View {
        content
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    backButton
                }
            }
            .alert("Are you sure you want to leave?",
                   isPresented: $showAlert) {
                Button("Yes", role: .destructive) {
                    dismissAction()
                }
                Button("Cancel", role: .cancel) { }
            }
    }
    
    private var backButton: some View {
        Button {
            showAlert.toggle()
        } label: {
            HStack {
                Image(systemName: "chevron.backward")
                Text("Leave")
            }
        }
    }
}

extension View {
    func backButtonModifier(showAlert: Binding<Bool>, 
                            backAction: @escaping () -> ()) -> some View {
        modifier(BackButtonNavigation(showAlert: showAlert, dismissAction: backAction))
    }
}
