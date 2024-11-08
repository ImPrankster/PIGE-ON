/*
See LICENSE folder for this sample’s licensing information.

Abstract:
The profile image that reflects the selected item state.
*/

import PhotosUI
import SwiftUI

struct ProfileImage: View {
    let imageState: ProfileModel.ImageState

    var body: some View {
        switch imageState {
        case .success(let image):
            image.resizable()
                .clipShape(Circle())
        case .loading:
            ProgressView()
        case .empty:
            Image("DefaultProfile")
                .resizable()
                .offset(y: 8)
                .clipShape(Circle())
        case .failure:
            Image(systemName: "exclamationmark.triangle")
                .font(.system(size: 40))
                .foregroundColor(.white)
        }
    }
}

struct CircularProfileImage: View {
    let imageState: ProfileModel.ImageState

    var body: some View {
        ProfileImage(imageState: imageState)
            .scaledToFill()
            .frame(width: 100, height: 100)
            .background {
                Circle().fill(
                    LinearGradient(
                        colors: [.yellow, .orange],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
            }
    }
}

struct EditableCircularProfileImage: View {
    @ObservedObject var viewModel: ProfileModel

    var body: some View {
        CircularProfileImage(imageState: viewModel.imageState)
            .overlay(alignment: .bottomTrailing) {
                PhotosPicker(
                    selection: $viewModel.imageSelection,
                    matching: .images,
                    photoLibrary: .shared()
                ) {
                    Image(systemName: "pencil.circle.fill")
                        .symbolRenderingMode(.multicolor)
                        .font(.system(size: 30))
                        .foregroundColor(.accentColor)
                }
                .buttonStyle(.borderless)
            }
    }
}
