import SwiftUI

struct RoundButton: View {
    var border: Bool
    var title: String
    var action: () -> Void

    var body: some View {
        Button(action: {
            action()
        }) {
            Text(title)
                .font(.custom("Quicksand-SemiBold", size: 18))
                .frame(maxWidth: 280, minHeight: 50)
                .foregroundColor(border ? .black : .white)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.black, lineWidth: border ? 1 : 0)
                )
        }
        .background(border ? Color.clear : Color.black)
        .cornerRadius(8)
    }
}

#Preview {
    RoundButton(border: false,
                title: "Hello",
                action: {
    })
}
