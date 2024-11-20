/*
See LICENSE folder for this sample’s licensing information.

Abstract:
The main content view of the app.
*/

import PhotosUI
import SwiftUI

struct Profile: View {
    var body: some View {
        NavigationView {
            ProfileForm()
        }
    }
}

struct ProfileForm: View {
    @StateObject var viewModel = ProfileModel()
    private var user = supabase.auth.currentUser

    var body: some View {
        Form {
            Section {
                HStack {
                    Spacer()
                    VStack {
                        EditableCircularProfileImage(viewModel: viewModel)
                        ProfileMsg(imageState: viewModel.imageState)
                    }
                    Spacer()
                }
            }
            .listRowBackground(Color.clear)
            Section {
                TextField(
                    "First Name",
                    text: $viewModel.firstName,
                    prompt: Text("First Name"))
                TextField(
                    "Last Name",
                    text: $viewModel.lastName,
                    prompt: Text("Last Name"))
            }
            Section(
                header: Text("Something Coo about Yourself")
            ) {
                TextEditor(
                    text: $viewModel.aboutMe
                )
            }
            if user != nil {
                Section(
                    header: Text("User email")
                ) {
                    Text("Creating profile for \(user?.email ?? "")")
                }
            }
            Section {
                Button(
                    action: {
                        Task {
                            try await viewModel.submitProfile()
                        }
                    },
                    label: {
                        HStack {
                            Spacer()
                            Text("Submit")
                            Spacer()
                        }
                    })
            }
        }
        .navigationTitle("Profile")
    }
}

struct ProfileMsg: View {
    let imageState: ProfileModel.ImageState

    var body: some View {
        switch imageState {
        case .failure(let error):
            Text(
                error.localizedDescription
            ).font(.headline)
        case .empty:
            EmptyView()
        case .loading(_):
            EmptyView()
        case .success(_):
            EmptyView()
        }
    }
}

#Preview {
    Profile()
}
