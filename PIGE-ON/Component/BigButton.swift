//
//  BigButton.swift
//  PIGE-ON
//
//  Created by Ruofan Wang on 2024/12/8.
//
import SwiftUI

struct BigButton: ButtonStyle {
    var fill: Color = Color.blue
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.system(size: 24, weight: .bold, design: .rounded))
            .padding()
            .background(
                ZStack {
                    Capsule()
                        .fill(fill)
                        .stroke(.black, lineWidth: 3)
                        .offset(y: configuration.isPressed ? 0 : 10)
                    Capsule()
                        .fill(.background)
                        .stroke(.black, lineWidth: 3)
                }
            )
            .offset(y: configuration.isPressed ? 10 : 0)
    }
}

#Preview {
    Button(
        action: {}, label: { Image(systemName: "heart.fill") }
    ).buttonStyle(
        BigButton(
            fill: Color.cyan
        ))
}
