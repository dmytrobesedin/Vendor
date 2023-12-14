//
//  MainView.swift
//  Vendor
//
//  Created by Dmytro Besedin on 10.12.2023.
//

import SwiftUI

struct MainView: View {
    @StateObject var viewModel = MainViewModel()
    
    var body: some View {
        ZStack {
            switch viewModel.state {
            case .loading:
                LoadingView()
                    .navigationBarTitleDisplayMode(.inline)
            case .empty:
                EmptyView()
            case .content:
                content
            }
        }
        .task {
            await viewModel.getVendors()
        }
        .alert(isPresented: $viewModel.showAlert, content: {
            Alert(
                title: Text(viewModel.alertTitle),
                message: Text(viewModel.alertMessage),
                dismissButton: .default(Text("OK"))
            )
        })
    }
    
    private var content: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                SearchView(text: $viewModel.searchQuery)
                    .padding(.horizontal, 16)
                if viewModel.hasSearchResult {
                    vendors
                } else {
                    noSearchResultView
                }
            }
        }
        .padding(.vertical, 24)
    }
    
    private var vendors: some View {
        ScrollView {
            ForEach(viewModel.isSearching ? viewModel.filteredVendors : viewModel.vendors, id: \.self) { vendor in
                CardView(vendor: vendor)
            }
        }
    }
    
    private var noSearchResultView: some View {
        ZStack(alignment: .center) {
            NoSearchResultView()
                .frame(width: 320, alignment: .center)
                .padding(.vertical, 225)
                .padding(.horizontal, 20)
            
            Spacer()
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
