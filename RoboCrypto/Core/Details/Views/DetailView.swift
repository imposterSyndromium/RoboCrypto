//
//  DetailView.swift
//  RoboCrypto
//
//  Created by Robin O'Brien on 2025-04-11.
//

import SwiftUI


struct DetailView: View {
    
    @StateObject private var vm: DetailViewModel
    private let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
    private let spacing: CGFloat = 30
    let coin: CoinModel
    
    init(coin: CoinModel) {
        self.coin = coin
        _vm = StateObject(wrappedValue: DetailViewModel(coin: coin))
        print("Initializing detail view for \(coin.name)")
    }
    
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Text("")
                    .frame(height: 150)
                
                

                overviewTitle
                Divider()
                overViewGrid
                
                additionalTitle
                Divider()
                additionalGrid
                

            }
            .padding()
        }
        .navigationTitle(vm.coin.name)
    }
}



#Preview {
    NavigationStack {
        DetailView(coin: CoinModel.sample)
    }
}





extension DetailView {
    
    private var overviewTitle: some View {
        Text("Overview")
            .font(.title)
            .bold()
            .foregroundStyle(Color.theme.accent)
            .frame(maxWidth: .infinity, alignment: .leading)

    }

    
    private var overViewGrid: some View {
        LazyVGrid(
            columns: columns,
            alignment: .leading,
            spacing: nil,
            pinnedViews: [],
            content: {
                
                ForEach(vm.overviewStatistics) { stat in
                    StatisticView(stat: stat)
                        .padding(.bottom, 10)
                }

            })
    }
    
    
    private var additionalTitle: some View {
        Text("Additional Details")
            .font(.title)
            .bold()
            .foregroundStyle(Color.theme.accent)
            .frame(maxWidth: .infinity, alignment: .leading)

    }
    
    
    private var additionalGrid: some View {
        LazyVGrid(
            columns: columns,
            alignment: .leading,
            spacing: nil,
            pinnedViews: [],
            content: {
                
                ForEach(vm.additionalStatistics) { stat in
                    StatisticView(stat: stat)
                        .padding(.bottom, 10)
                }

            })
    }

}


