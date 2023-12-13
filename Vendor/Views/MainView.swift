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
        .onAppear {
            viewModel.getVendors()
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
        VStack(alignment: .leading, spacing: 24) {
            SearchView(text: $viewModel.searchQuery)
                .padding(.horizontal, 16)

            vendors
        }
        .padding(.vertical, 24)
        .padding(.horizontal, 16)
    }

    private var vendors: some View {
        ScrollView {
            ForEach(viewModel.vendors, id: \.id) { vendor in
                CardView(vendor: vendor)
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
