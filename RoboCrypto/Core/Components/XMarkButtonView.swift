//
//  XMarkButtonView.swift
//  RoboCrypto
//
//  Created by Robin O'Brien on 2025-03-26.
//

import SwiftUI

struct XMarkButtonView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        Button {
            dismiss()
        } label: {
            ZStack {
                Color.theme.secondaryText.opacity(0.3)
                    .frame(width: 40, height: 40)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                
                Image(systemName: "xmark")
                    .font(.headline)
                    .foregroundColor(Color.theme.accent)
            }
        }
    }
}

#Preview {
    XMarkButtonView()
}
