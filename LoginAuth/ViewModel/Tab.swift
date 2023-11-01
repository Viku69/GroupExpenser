//
//  Tab.swift
//  LoginAuth
//
//  Created by Vikram Singh on 24/10/23.
//

import SwiftUI

enum Tab: String , CaseIterable{
    case home = "Home"
    case group = "Group"
    case transaction = "Transaction"
    case account = "Account"
    
    var systemImage : String{
        switch self{
        case.home:
            return "house"
        case.group:
            return "person.3.fill"
        case.transaction:
            return "dollarsign.arrow.circlepath"
        case.account:
            return "person.crop.circle"
        
        }
    }
    
    var index : Int{
        return Tab.allCases.firstIndex(of: self) ?? 0
    }
}

