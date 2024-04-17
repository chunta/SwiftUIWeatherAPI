//
//  CustomTitleView.swift
//  SwiftUIWeather
//
//  Created by Rex Chen on 2024/4/17.
//

import SwiftUI

struct CustomTitleView: View {
    @Binding var selectedIndex: Int
    var body: some View {
        HStack {
            RoundButton(border: true, title: "Update binding variable") {
                selectedIndex = selectedIndex + 1
                selectedIndex = selectedIndex % 3
            }
            Text("\(selectedIndex)")
        }
    }
}

#Preview {
    CustomTitleView(selectedIndex: .constant(0))
}
