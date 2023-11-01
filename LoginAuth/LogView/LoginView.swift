//
//  LoginView.swift
//  LoginAuth
//
//  Created by Vikram Singh on 04/10/23.
//

import SwiftUI

struct LoginView: View {
    @StateObject var loginModel : LoginViewModel = .init()
    var body: some View {
        
        ScrollView(.vertical, showsIndicators: false){
                VStack(alignment: .leading, spacing: 15 ){
                    Image(systemName: "triangle")
                        .font(.system(size: 38))
                        .foregroundStyle(.white)
                    
                    (Text("Welcome")
                        .foregroundColor(.black)
                     + Text("\nLogin to Continue")
                        .foregroundStyle(.white)
                    )
                    .font(.title)
                    .fontWeight(.bold)
                    .lineSpacing(10)
                    .padding(.top,20)
                    
                    // custom textfield
                    
                    CustomTextField(hint: "+91 9267948329", text: $loginModel.mobileNo)
                        .disabled(loginModel.showOTPField)
                        .opacity(loginModel.showOTPField ? 0.4 :1)
                        .overlay(alignment: .trailing, content: {
                            Button("Change"){
                                withAnimation(.easeInOut){
                                    loginModel.showOTPField = false
                                    loginModel.otpCode = ""
                                    loginModel.CLIENT_CODE = ""
                                }
                            }
                            .font(.caption)
                            .foregroundStyle(.red)
                            .opacity(loginModel.showOTPField ? 1 : 0)
                            .padding(.trailing , 60)
                        })
                        .padding(.top , 90)
                    
                    
                    CustomTextField(hint: "OTP CODE", text: $loginModel.otpCode)
                        .disabled(!loginModel.showOTPField)
                        .opacity(!loginModel.showOTPField ? 0.4 :1)
                        .padding(.top , 30)
                    
                    
                    Button(action: loginModel.showOTPField ? loginModel.verifyOTPCode: loginModel.getOTPCode){
                        HStack(spacing:15){
                            Text(loginModel.showOTPField ? "VERIFY CODE" : "SEND CODE")
                                .fontWeight(.semibold)
                                .contentTransition(.identity)
                            Image(systemName: "arrow.right")
                                .font(.title3)
                        }
                        .foregroundStyle(.black)
                        .padding(.horizontal , 60)
                        .padding(.vertical)
                        .background{
                            RoundedRectangle(cornerRadius: 30, style: .continuous)
                                .fill(.green.opacity(0.9))
                        }
                    }
                    .padding(.top)
                    
                    // Other SignIn Options
                    
                    Text("(OR)")
                        .foregroundStyle(.black)
                        .frame(maxWidth: .infinity)
                        .padding(.top , 30)
                        .padding(.trailing , 60)
                        .padding(.horizontal)
                    
                    // Google sign in
                    
                    
                }
                .padding(.leading , 50)
                .padding(.vertical , 15)
            }
            .alert(loginModel.errorMessage,isPresented: $loginModel.showError){
                
         }
            .background(
                Image("LogIcon1")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .edgesIgnoringSafeArea(.vertical)
                
            )
     }
 }



#Preview {
    ContentView()
}
