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
                vendors
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
    
    private var vendors: some View {
        ScrollView {
            ForEach(viewModel.vendors, id: \.id) { vendor in
                HStack {
                    VStack(alignment: .leading, spacing: 5) {
                        Text(vendor.companyName)
                            .lineLimit(3)
                            .multilineTextAlignment(.leading)
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(.black)
                        
                        Text(vendor.businessType)
                            .multilineTextAlignment(.leading)
                            .fixedSize(horizontal: false, vertical: true)
                            .lineSpacing(3)
                            .lineLimit(5)
                            .font(.system(size: 14, weight: .regular))
                            .foregroundColor(.black)
                    }
                }
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
