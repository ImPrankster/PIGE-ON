//
//  CardView.swift
//  SwipeTest
//
//  Created by Federico on 06/02/2022.
//

import SwiftUI

struct CardView: View {
    @State private var offset = CGSize.zero
    @State private var color: Color = .black
    var person: ProfileInfo
    var onSwipeLeft: (() -> Void)
    var onSwipeRight: (() -> Void)

    var body: some View {
        ZStack {
            Rectangle()
                .frame(width: 320, height: 420)
                .clipShape(.rect(cornerRadius: 32))
                .foregroundColor(color)
            HStack {
                Text(person.firstName)
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .bold()
                Image(systemName: "heart.fill")
                    .foregroundColor(.red)
            }

        }
        .offset(x: offset.width * 1, y: offset.height * 0.4)
        .rotationEffect(.degrees(Double(offset.width / 40)))
        .gesture(
            DragGesture()
                .onChanged { gesture in
                    offset = gesture.translation
                    withAnimation {
                        changeColor(width: offset.width)
                    }
                }
                .onEnded { _ in
                    withAnimation {
                        swipeCard(width: offset.width)
                        changeColor(width: offset.width)
                    }
                }
        )
    }

    func swipeCard(width: CGFloat) {
        switch width {
        case -500...(-150):
            offset = CGSize(width: -500, height: 0)
            onSwipeLeft()
        case 150...500:
            offset = CGSize(width: 500, height: 0)
            onSwipeRight()
        default:
            offset = .zero
        }
    }

    func changeColor(width: CGFloat) {
        switch width {
        case -500...(-130):
            color = .red
        case 130...500:
            color = .green
        default:
            color = .black
        }
    }

}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(
            person: ProfileInfo(
                uniqueId: UUID(), userId: "111", firstName: "Leo",
                lastName: "Wang",
                description: "Cool"
            ),
            onSwipeLeft: {}, onSwipeRight: {}
        )
    }
}
