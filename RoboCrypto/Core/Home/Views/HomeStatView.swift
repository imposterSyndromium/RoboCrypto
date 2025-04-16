//
//  HomeStatView.swift
//  RoboCrypto
//
//  Created by Robin O'Brien on 2025-03-21.
//

import SwiftUI

struct HomeStatView: View {
    @EnvironmentObject var vm: HomeViewModel
    @Binding var showPortfolio: Bool
    
    
    var body: some View {
        HStack {
            ForEach(vm.statistics) { stat in
                StatisticView(stat: stat)
                    .frame(width: UIScreen.main.bounds.width / 3.15)
            }
        }
        .frame(width: UIScreen.main.bounds.width, alignment: showPortfolio ? .trailing : .leading)        
    }
    
}



#Preview {
    let vm = HomeViewModel()
    HomeStatView(showPortfolio: .constant(false))
        .environmentObject(vm)
}
