//
//  AccountView.swift
//  LoginAuth
//
//  Created by Vikram Singh on 10/10/23.
//

import SwiftUI
import Firebase

struct AccountView: View {
    @AppStorage("Log_status") var logStatus:Bool = false
    var body: some View {
        NavigationView{
            
            List{
                
                Section("About"){
                    HStack(spacing:30){
                        Text("VS")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundStyle(.white)
                            .frame(width: 72, height: 72)
                            .background(Color(.green))
                            .clipShape(Circle())
                        
                        Text("VIKRAM SINGH")
                            .font(.title2)
                            .fontWeight(.bold)
                    }
                    .padding(.vertical , 10)
                    
                }
                
                
                
                Section("General"){
                    HStack(){
                        HStack(spacing:12){
                            Image(systemName: "gear")
                            Text("Version")
                        }
                        Spacer()
                        Text("1.0.0")
                    }
                }
                Section("MORE"){
                    VStack{
                        HStack (spacing: 15){
                            
                            Image(systemName:"arrow.right.circle.fill")
                                .foregroundStyle(.red)
                            
                            
                            Button("Logout"){
                                try? Auth.auth().signOut()
                                withAnimation(.easeInOut){
                                    logStatus = false
                                }
                            }
                            .foregroundColor(.red)
                        }
                    }
                }
                
            }
            
            .navigationTitle("ACCOUNT")
        }
    }
}

#Preview {
    AccountView()
}
