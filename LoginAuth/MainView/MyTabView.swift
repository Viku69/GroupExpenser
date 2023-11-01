//
//  MyTabView.swift
//  LoginAuth
//
//  Created by Vikram Singh on 10/10/23.
//

import SwiftUI
import Foundation

struct MyTabView: View {
    // View Properties
    
    @State private var activeTab : Tab = .home
    // for smooth shape sliding effect , use Matched Geometry Effect
    @Namespace private var animation
    @State private var tabshapePosition : CGPoint = .zero
    init(){
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
        
        VStack(spacing : 0){
            
            TabView (selection: $activeTab) {
                HomeView()
                    .tag(Tab.home)
                    //.toolbar(.hidden , for: .tabBar)
                
                GroupView()
                    .tag(Tab.group)
                    //.toolbar(.hidden , for: .tabBar)
                
                TransactionView()
                    .tag(Tab.transaction)
                    //.toolbar(.hidden , for: .tabBar)
                
                AccountView()
                    .tag(Tab.account)
                    //.toolbar(.hidden , for: .tabBar)
            }
            
            CustomTabBar()
        }
    }
    
    // Custom Tab bar
    // Easy Customization
    @ViewBuilder
    func CustomTabBar(_ tint : Color = Color("TabCol"), _ inactiveTint : Color = .green) -> some View{
        // Move all remaining tab item to bottom
        
        HStack(alignment : .bottom,spacing:0){
            ForEach(Tab.allCases , id: \.rawValue){
                TabItem(
                    tint: tint,
                    inactiveTint: inactiveTint,
                    tab: $0,
                    animation: animation,
                    activeTab: $activeTab,
                    position:$tabshapePosition )
            }
        }
        .padding(.horizontal , 15)
        .padding(.vertical , 10)
        .background(content: {
            TabShape(midpoint: tabshapePosition.x)
                .fill(.white)
                .ignoresSafeArea()
            // add blur + Shadow
            // for shape smoothing
                .shadow(color: tint.opacity(0.2), radius: 5 , x: 0, y: -5)
                .blur(radius: 2)
                .padding(.top , 22)
        })
        // Add Animation
        .animation(.interactiveSpring(response: 0.6, dampingFraction: 0.7 , blendDuration:
            0.7), value: activeTab)
    }
}

// Tab Bar Item

struct TabItem : View {
    var tint : Color
    var inactiveTint : Color
    var tab: Tab
    var animation : Namespace.ID
    @Binding var activeTab: Tab
    @Binding var position : CGPoint
    
    // Each tab Item Position on the screen
    @State private var tabPosition : CGPoint = .zero
    
    var body: some View{
        VStack(spacing:0){
            Image(systemName: tab.systemImage)
                .font(.title2)
                .foregroundStyle(activeTab == tab ? .white : inactiveTint )
            
            // Increase size for the active tab
            
                .frame(width: activeTab == tab ? 50 : 35 , height: activeTab == tab ? 50 : 35 )
                .background(){
                    if activeTab == tab {
                        Circle()
                            .fill(tint.gradient)
                            .matchedGeometryEffect(id: "ACTIVETAB", in: animation)
                    }
                }
            
            Text(tab.rawValue)
                .font(.caption)
                .foregroundStyle(activeTab == tab ? tint : .gray)
        }
        .frame(maxWidth: .infinity)
        .contentShape(Rectangle())
        .viewPosition(completion: { rect in
            tabPosition.x = rect.midX
            
            // update active tab postion
            if activeTab == tab {
                position.x = rect.midX
            }
        })
        .onTapGesture {
            
            activeTab = tab
            withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.7 , blendDuration: 0.7)){
                position.x = tabPosition.x
            }
        }
    }
    
}

#Preview {
    MyTabView()
}
