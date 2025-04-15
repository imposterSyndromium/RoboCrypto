//
//  DetailView.swift
//  RoboCrypto
//
//  Created by Robin O'Brien on 2025-04-11.
//

import SwiftUI


struct DetailView: View {
    
    @StateObject private var vm: DetailViewModel
    @State private var showFullDescription: Bool = false
    
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
            VStack {
                ChartView(coin: vm.coin)
                    .padding(.vertical)
                    
                    
                VStack(spacing: 20) {
                    overviewTitle
                    Divider()
                    descriptionSection
                    
                    overViewGrid
                    
                    additionalTitle
                    Divider()
                    additionalGrid
                    
                    websiteSection
                        .accentColor(.blue)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.headline)
                    
                }
                .padding()
            }
        }
        .background(Color.theme.background)
        .navigationTitle(vm.coin.name)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                navigationBarTrailingItems
            }
        }
    }
}



#Preview {
    NavigationStack {
        DetailView(coin: CoinModel.sample)
    }
}





extension DetailView {
    
    private var navigationBarTrailingItems: some View {
        HStack {
            Text(vm.coin.symbol.uppercased())
                .font(.headline)
                .foregroundStyle(Color.theme.secondaryText)
            
            CoinImageView(coin: vm.coin)
                .frame(width: 30, height: 30)
        }
    }
    
    
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
    
    
    private var descriptionSection: some View {
        ZStack {
            if let coinDescription = vm.coinDescription,
               !coinDescription.isEmpty {
                VStack(alignment: .leading) {
                    Text(coinDescription)
                        .lineLimit(showFullDescription ? nil : 3)
                        .font(.callout)
                        .foregroundStyle(Color.theme.secondaryText)
                    
                    Button {
                        withAnimation(.easeInOut) {
                            showFullDescription.toggle()
                        }
                    } label: {
                        Text(showFullDescription ? "less..." : "Read more...")
                            .font(.caption)
                            .fontWeight(.bold)
                            .padding(.vertical, 4)
                        

                    }

                }
            }
        }
    }
    
    
    private var websiteSection: some View {
        VStack(alignment: .leading, spacing: 20) {
            if let website = vm.websiteURL,
               let url = URL(string: website) {
                Link("\(url)", destination: url)
            }
            
            if let redditString = vm.redditURL,
               let url = URL(string: redditString) {
                Link("\(url)", destination: url)
            }
        }
    }

}


