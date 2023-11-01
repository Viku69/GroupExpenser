//
//  ContentView.swift
//  LoginAuth
//
//  Created by Vikram Singh on 04/10/23.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("Log_status") var logStatus:Bool = false
    var body: some View {
        if logStatus{
            MyTabView()
        }else{
            LoginView()
        }
        
    }
}

#Preview {
    ContentView()
}
