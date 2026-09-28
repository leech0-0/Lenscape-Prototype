//
//  HomeView.swift
//  Lenscape-Prototype
//
//  Created by C :) on 11/9/2026.
//

import SwiftUI
import AVKit

struct HomeView: View {
    
    @State private var viewModel = QuestsViewModel()
    
    var body: some View {
        NavigationStack{
            ScrollView{
                
                //titles
                VStack(alignment: .leading, spacing: 4){
                    Text("Lenscape")
                        .font(.title)
                        .bold()
                        .padding()
                    
                    Spacer()
                    
                    // Card Layout for Quests
                Text("Weekly Quests")
                        .font(.title2)
                        .fontWeight(.bold)
                        .padding()
                    
                    NavigationLink(destination: Group {
                                            if viewModel.hasWatchedVideo {
                                                QuestsView(viewModel: viewModel)
                                            } else {
                                                QuestsVideoView(viewModel: viewModel)
                                            }
                                        }) {
                        HStack{
                            
                            VStack(){
                                Text(viewModel.questTitle)
                                    .font(.title3)
                                    .fontWeight(.bold)
                                
                                Image("placeholder")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 150, height: 150)
                                
                                Text(viewModel.buttonTitle) //fakebutton
                                    .font(.title2)
                                    .fontWeight(.semibold)
                                    .foregroundStyle(.white)
                                    .padding(.horizontal, 20)
                                    .padding(.vertical, 10)
                                    .background(Color(.blue), in: Capsule()) // change colour later
                                
                            }
                            
                            Spacer()
                        }
                        .padding(20)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(20)
                    }
                    .buttonStyle(.plain)
                    .padding()
                    
                    Spacer()
                    
                    // Card Layout for Festival
                Text("Upcoming Events")
                        .font(.title2)
                        .fontWeight(.bold)
                        .padding()
                    
                    NavigationLink(destination: FestivalsView()){ //TO BE CHANGED TO FESTIVALS
                        HStack(){
                            
                            VStack(){
                                Text("City North Shared Futures Festival")
                                    .font(.title3)
                                    .fontWeight(.bold)
                                
                                Spacer()
                                
                                HStack{
                                    Image(systemName: "calendar.badge.clock")
                                        .resizable()
                                        .frame(width: 100, height: 90)
                                    
                                    Text("x days to go!")
                                        .fontWeight(.semibold)
                                }
                                
                                Spacer()
                               
                                Text("See Details") //fakebutton
                                    .font(.title2)
                                    .fontWeight(.semibold)
                                    .foregroundStyle(.white)
                                    .padding(.horizontal, 20)
                                    .padding(.vertical, 10)
                                    .background(Color(.blue), in: Capsule()) // change colour later
                                
                                
                                
                            }
                            
                            Spacer()
                        }
                        .padding(20)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(20)
                    }
                    .buttonStyle(.plain)
                    .padding(.horizontal)
                }
            }
        }
    }
}



// MARK: - Preview
#Preview {
    HomeView()
}
