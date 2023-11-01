//
//  CustomTextField.swift
//  LoginAuth
//
//  Created by Vikram Singh on 04/10/23.
//

import SwiftUI

struct CustomTextField: View {
    var hint: String
    @Binding var text: String
    
    // View properties
    
    @FocusState var isEnabled:Bool
    var contentType:UITextContentType = .telephoneNumber
    var body: some View {
        VStack(alignment: .leading, spacing: 15){
            TextField(hint , text: $text)
                .keyboardType(.numberPad)
                .textContentType(contentType)
                .focused($isEnabled)
                .foregroundStyle(.black)
            
            ZStack(alignment: .leading){
                Rectangle()
                    .fill(.black.opacity(0.8))
                    .padding(.trailing , 60)
                
                Rectangle()
                    .fill(.black.opacity(0.4))
                    .padding(.trailing , 60)
                    .frame(width: isEnabled ? nil : 0)
                    .animation(.easeInOut(duration: 0.3), value: isEnabled)

            }
            .frame(height: 2)
            
        }
    }
}

#Preview {
    ContentView()
}
