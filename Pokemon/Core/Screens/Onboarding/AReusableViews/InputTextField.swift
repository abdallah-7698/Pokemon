//
//  InputTextField.swift
//  Pokemon
//
//  Created by name on 22/04/2025.
//

import SwiftUI

public enum TFCases {
    case email
    case password
    case username
    
    var placeholder: String {
        switch self {
        case .email: return "E-mail"
        case .password: return "Password"
        case .username: return "Name"
        }
    }
    
    var isSecure: Bool {
        switch self {
        case .email, .username: return false
        case .password: return true
        }
    }
}

struct InputTextField: View {
    let textFielsType: TFCases
    @Binding var text: String
    @State private var isSecured: Bool = true
    @FocusState private var isFocused: Bool
    
    var body: some View {
        ZStack {
            Group {
                switch textFielsType {
                case .email:
                    TextField(textFielsType.placeholder, text: $text)
                        .textContentType(.emailAddress)
                        .autocapitalization(.none)
                        .keyboardType(.emailAddress)
                        .focused($isFocused, equals: true)
                        .padding()
                    
                case .password:
                    HStack {
                        if isSecured {
                            SecureField(textFielsType.placeholder, text: $text)
                                .textContentType(.newPassword)
                                .textInputAutocapitalization(.never)
                                .keyboardType(.asciiCapable)
                                .focused($isFocused, equals: true)
                                .padding()
                            
                        } else {
                            TextField(textFielsType.placeholder, text: $text)
                                .textContentType(.newPassword)
                                .textInputAutocapitalization(.never)
                                .keyboardType(.asciiCapable)
                                .focused($isFocused, equals: true)
                                .padding()
                        }
                        
                        Button(action: {
                            isSecured.toggle()
                        }, label: {
                            Image(systemName: self.isSecured ? "eye.slash" : "eye")
                                .accentColor(.gray)
                                .opacity(isFocused ? 1 : 0.2)
                                .padding()
                        })
                        
                    }
                case .username:
                    TextField(textFielsType.placeholder, text: $text)
                        .textContentType(.username)
                        .keyboardType(.default)
                        .focused($isFocused, equals: true)
                        .padding()
                }
            }

            RoundedRectangle(cornerRadius: 10)
                .stroke(lineWidth: 2)
                .foregroundColor(.gray)
                .opacity(isFocused ? 1 : 0.2)
        }
        .frame(height: 60)
    }
}

#Preview {
    InputTextField(textFielsType: .password, text: .constant(""))
}
