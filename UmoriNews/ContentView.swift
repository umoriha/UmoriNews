//
//  ContentView.swift
//  UmoriNewsAPP
//
//  Created by umoriha on 2021/05/30.
//  名称変更

import SwiftUI

struct ContentView: View {

    @ObservedObject var newsDataList = NewsData()
    //前回の検索キーワードを保存
    @AppStorage("keyword") var inputText = ""
    @State var showSafari = false
    
    var body: some View {
        VStack{
            //検索機能
            Text("検索欄")
                .fontWeight(.bold)
                .foregroundColor(Color.orange)
                .padding()
                .frame(height: 23.0)
            HStack{
                TextField("キーワードを入れてください", text: $inputText, onCommit: {
                    newsDataList.searchNews(keyword: inputText)
                })
                .padding()
                .border(Color.black, width: 1)
                Button(action: {
                    inputText = ""
                }) {
                    Text("消去")
                }
                .padding()
                .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
            }
            .padding(.horizontal)
            ZStack{
                Color("backgroundColor")
                //いらすとや様の画像を使用しております
                Image("earth_japan")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .edgesIgnoringSafeArea(.all)
                    
                List(newsDataList.newsList){ news in
                    Button(action: {
                        showSafari.toggle()
                    }) {
                        HStack{
                            Image(uiImage: news.image)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 60.0, height: 60.0)
                            Text(news.title)
                        }
                    }
                    .padding(.horizontal)
                    .sheet(isPresented: self.$showSafari, content: {
                        SafariView(url: news.link)
                            .edgesIgnoringSafeArea(.bottom)
                    })//-Button
                }
                .opacity(0.9)//-List
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
        }
    }
}


