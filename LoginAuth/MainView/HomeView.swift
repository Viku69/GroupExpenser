//
//  HomeView.swift
//  LoginAuth
//
//  Created by Vikram Singh on 10/10/23.
//

import SwiftUI

struct HomeView: View {
    @State private var searchText: String = ""
    var body: some View {
        ScrollView(.vertical){
            VStack(spacing: 15){
                HStack(spacing: 12){
                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                        Image(systemName: "line.3.horizontal")
                            .font(.title)
                            .foregroundStyle(.green)
                        
                    })
                    
                    HStack(spacing:12){
                        Image(systemName: "magnifyingglass")
                            .foregroundStyle(.black)
                        
                        TextField("Search", text: $searchText)
                    }
                    .padding(.horizontal , 15)
                    .padding(.vertical , 15)
                    .background(.ultraThinMaterial , in: .capsule)
                }
                
                Text("Features!")
                    .font(.largeTitle.bold())
                    .frame(maxWidth: .infinity , alignment: .leading)
                    .padding(.top, 10)
                
                // parallax carousel home
                
                GeometryReader(content: { geometry in
                    let size = geometry.size
                    
                    ScrollView(.horizontal){
                        HStack(spacing: 5){
                            ForEach(homecards){ card in
                                // in order to move in reverse order
                                GeometryReader(content: { proxy in
                                    let cardSize = proxy.size
                                    // simple parllax
                                    //let minX = proxy.frame(in: .scrollView).minX - 30 
                                    
                                    let minX = min((proxy.frame(in: .scrollView).minX - 30 ) * 1.4 , size.width * 1.4)
                                    
                                    Image(card.image)
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .offset(x : -minX)
                                        // use scaling
                                        //.scaleEffect(1.75)
                                        .frame(width: proxy.size.width * 1.85)
                                        .frame(width: cardSize.width, height: cardSize.height)
                                        .overlay{
                                            OverlayView(card)
                                        }
                                        .clipShape(.rect(cornerRadius: 20))
                                        .shadow(color: .black.opacity(0.25), radius: 8 ,
                                                x : 5 , y : 10)
                                })
                                // padding of 30 each side which is 60 so reduce 60
                                .frame(width:size.width-60 , height: size.height-50)
                                
                                // scroll animation
                                
                                .scrollTransition(.interactive , axis: .horizontal){
                                    view , phase in
                                    view
                                        .scaleEffect(phase.isIdentity ? 1: 0.95)
                                }
                            }
                        }
                        // Enable Carousel api
                        .padding(.horizontal, 30)
                        .scrollTargetLayout()
                        .frame(height: size.height , alignment: .top)
                        
                    }
                    .scrollTargetBehavior(.viewAligned)
                    .scrollIndicators(.hidden)
                })
                .frame(height: 520)
                .padding(.horizontal , -15)
                .padding(.top , 10)
            }
            .padding(15)
            
            // after cards
            
            VStack(spacing: 10){
                Text("Create Groups")
                     .font(.largeTitle)
                     .fontWeight(.heavy)
                
                HStack(spacing: 30){
                    Text("Split Money")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundStyle(.green)
                    
                    Text("Track Expenses")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundStyle(.green)
                        
                }
                .padding(.horizontal , 10)
               
            }
        }
        .scrollIndicators(.hidden)
    }
    
    /// Overlay view
    
    @ViewBuilder
    func OverlayView(_ card : HomeCard) -> some View{
        ZStack(alignment: .bottomLeading , content: {
            LinearGradient(colors: [
                .clear,
                .clear,
                .clear,
                .clear,
                .clear,
                .black.opacity(0.1),
                .black.opacity(0.5),
                .black
            ], startPoint: .top, endPoint: .bottom)
            
            VStack(alignment: .leading, spacing: 4 , content: {
                Text(card.title)
                    .font(.title2)
                    .fontWeight(.black)
                    .foregroundStyle(.white)
                
                Text(card.subTitle)
                    .font(.callout)
                    .foregroundStyle(.white.opacity(0.8))
            })
            .padding(20)
        })
    }
}

#Preview {
    HomeView()
}
