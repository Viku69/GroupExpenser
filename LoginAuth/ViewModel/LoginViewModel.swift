//
//  LoginViewModel.swift
//  LoginAuth
//
//  Created by Vikram Singh on 04/10/23.
//

import SwiftUI
import Firebase

class LoginViewModel: ObservableObject{
    
    // View Properties
    @Published var mobileNo: String = ""
    @Published var otpCode: String = ""
    
    @Published var CLIENT_CODE: String = ""
    @Published var showOTPField: Bool = false
    
    // Error Properties
    
    @Published var showError : Bool = false
    @Published var errorMessage : String = ""
    
    // App log status
    
    @AppStorage("Log_status") var logStatus:Bool = false
    
    // Firebase API's
    
    func getOTPCode(){
        UIApplication.shared.closeKeyboard()
        Task{
            do{
                // Disable It when testing with real device
                Auth.auth().settings?.isAppVerificationDisabledForTesting = true
                
                let code = try await  PhoneAuthProvider.provider().verifyPhoneNumber("+\(mobileNo)", uiDelegate: nil)
                await MainActor.run(body : {
                    CLIENT_CODE = code
            
                // Enabling OTP Field When Its success
                    withAnimation(.easeInOut){showOTPField = true}
                })
                
            } catch{
                await handleError(error: error)
            }
        }
    }
    
    func verifyOTPCode(){
        UIApplication.shared.closeKeyboard()
        Task{
            do{
                
                let credential = PhoneAuthProvider.provider().credential(withVerificationID: CLIENT_CODE, verificationCode: otpCode)
                
                try await Auth.auth().signIn(with: credential)
                
                // user logged in succesfully
               print("Success")
                await MainActor.run(body :{
                    withAnimation(.easeInOut){self.logStatus=true}
                })
                
            }catch{
                await handleError(error: error)
            }
        }
    }
    
    // Handling Errors
    
    func handleError(error:Error)async{
        await MainActor.run(body :{
            errorMessage = error.localizedDescription
            showError.toggle()
        })
    }
}


// Extensions

    extension UIApplication{
    func closeKeyboard(){
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
