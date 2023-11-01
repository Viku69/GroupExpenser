//
//  HomeModel.swift
//  LoginAuth
//
//  Created by Vikram Singh on 22/10/23.
//

import Foundation
import SwiftUI

/// card model

struct HomeCard : Identifiable, Hashable{
    var id : UUID = .init()
    var title : String
    var subTitle : String
    var image : String
}

/// sample cards

var homecards: [HomeCard] = [
    .init( title: "Split", subTitle: "Money", image: "Home1"),
    .init( title: "Track", subTitle: "Expenses", image: "Home2"),
    .init( title: "Enjoy", subTitle: "Moments of Happiness", image: "Home3")
]
