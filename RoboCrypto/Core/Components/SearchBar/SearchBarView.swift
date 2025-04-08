//
//  SearchBarView.swift
//  RoboCrypto
//
//  Created by Robin O'Brien on 2025-03-20.
//

import SwiftUI

struct SearchBarView: View {
    @Binding var searchText: String
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundStyle(Color.theme.secondaryText)
            
            TextField("Search by name or symbol...", text: $searchText)
                .autocorrectionDisabled()
                .foregroundStyle(Color.theme.accent)
                .padding(.leading, 10)
                .overlay(
                    Image(systemName: "xmark.circle.fill")
                        .padding()
                        .offset(x: 10)
                        .foregroundStyle(Color.theme.secondaryText)
                        .opacity(searchText.isEmpty ? 0.0 : 1.0)
                        .onTapGesture {
                            UIApplication.shared.endEditing()
                            searchText = ""
                        }
                    ,alignment: .trailing
                )
        }
        .font(.headline)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 25.0)
                .fill(Color.theme.background)
                .shadow(color: Color.theme.accent.opacity(0.25),
                        radius: 10, x: 0.0, y: 0.0)
        )
        .padding()
    }
}

#Preview {
    SearchBarView(searchText: .constant("Test"))
}
