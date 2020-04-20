//
//  ProgressView.swift
//  Covid-19
//
//  Created by Gaurish Salunke on 4/15/20.
//  Copyright © 2020 Gaurish Salunke. All rights reserved.
//

import SwiftUI

struct ProgressView: View {
    @Binding var showProgress: Bool

    var body: some View {
        ZStack {
            BlurView()
            
            VStack {
                Indicator(isAnimating: self.$showProgress)
                
                Text("Loading...")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding(.top, 8)
            }
        }
        .frame(width: 120, height: 120)
        .cornerRadius(8)
    }
}

struct ProgressView_Previews: PreviewProvider {
    static var previews: some View {
        ProgressView(showProgress: .constant(true))
    }
}

struct BlurView: UIViewRepresentable {
    func makeUIView(context: UIViewRepresentableContext<BlurView>) -> UIVisualEffectView {
        let effect = UIBlurEffect(style: .systemMaterialDark)
        let view = UIVisualEffectView(effect: effect)
        
        return view
    }
    
    func updateUIView(_ uiView: UIVisualEffectView, context: UIViewRepresentableContext<BlurView>) {
        
    }
}

struct Indicator: UIViewRepresentable {
    @Binding var isAnimating: Bool
    
    func makeUIView(context: UIViewRepresentableContext<Indicator>) -> UIActivityIndicatorView {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.color = UIColor.white
        
        return indicator
    }
    
    func updateUIView(_ uiView: UIActivityIndicatorView, context: UIViewRepresentableContext<Indicator>) {
        isAnimating ? uiView.startAnimating() : uiView.stopAnimating()
    }
}
