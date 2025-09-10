//
//  ClothoApp.swift
//  Clotho
//
//  Created by Eva Kalachik on 10/09/2025.
//

import SwiftUI
import SwiftData
import UIKit

@main
struct ClothoApp: App {
    
    let container = try! ModelContainer(for: Focus.self, Note.self)
    
    init() {
        setupAppearance()
    }
    
    
    var body: some Scene {
        WindowGroup {
            ContentView(context: container.mainContext)
        }
        .modelContainer(container)
    }
}

private func setupAppearance() {
    let topColor = UIColor(red: 0.85, green: 0.60, blue: 0.95, alpha: 0)
    
    let bottomColor = UIColor(red: 0.95, green: 0.85, blue: 0.65, alpha: 1)
    
    let imageHeight: CGFloat = 128
    let gradientImage = makeGradientImage(colors: [topColor, bottomColor], size: CGSize(width: 1, height: imageHeight))
    
    let tabAppearance = UITabBarAppearance()
    tabAppearance.configureWithTransparentBackground()
    tabAppearance.backgroundImage = gradientImage.resizableImage(withCapInsets: .zero, resizingMode: .stretch)
    tabAppearance.shadowImage = UIImage()
    tabAppearance.shadowColor = nil
    
    UITabBar.appearance().standardAppearance = tabAppearance
    if #available(iOS 15.0, *) {
        UITabBar.appearance().scrollEdgeAppearance = tabAppearance
    }
}

private func makeGradientImage(colors: [UIColor], size: CGSize) -> UIImage {
    let renderer = UIGraphicsImageRenderer(size: size)
    return renderer.image { ctx in
        let cgctx = ctx.cgContext
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let cgColors = colors.map { $0.cgColor } as CFArray
        let locations: [CGFloat] = [0.0, 1.0]
        
        if let gradient = CGGradient(colorsSpace: colorSpace, colors: cgColors, locations: locations) {
            let start = CGPoint(x: size.width / 2.0, y: 0)
            let end = CGPoint(x: size.width / 2.0, y: size.height)
            cgctx.drawLinearGradient(gradient, start: start, end: end, options: [])
        }
    }
}
