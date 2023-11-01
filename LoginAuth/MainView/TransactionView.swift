//
//  TransactionView.swift
//  LoginAuth
//
//  Created by Vikram Singh on 10/10/23.
//

import SwiftUI

struct TransactionView: View {
    var body: some View {
        
        ScrollView{
            
                Text("No Trasactions!")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .foregroundStyle(.red)
        }
        .padding(.top , 20)
    }
}

#Preview {
    TransactionView()
}
