//
//  AspectVGrid.swift
//  CoreProject
//
//  Created by Paweł Powroźnik on 04/12/2024.
//

import SwiftUI

struct AspectVGrid<Item : Identifiable, ItemView : View>: View {
    var items : [Item]
    var aspectRatio: CGFloat = 1
    var content: (Item) -> ItemView
    
    init(_ items: [Item], aspectRatio: CGFloat, @ViewBuilder content: @escaping (Item) -> ItemView) {
        self.items = items
        self.aspectRatio = aspectRatio
        self.content = content
    }
    
    var body: some View {
        GeometryReader { geometry in
        let gridItemSize = gridItemWidthThatFits(count: items.count, size: geometry.size, aspectRatio: aspectRatio)
            LazyVGrid(columns: [GridItem(.adaptive(minimum: gridItemSize), spacing: 0)], spacing: 0){
                ForEach(items){ item in
                    content(item)
                        .aspectRatio(aspectRatio, contentMode: .fit)
                }
            }
        }
    }
    
    func gridItemWidthThatFits(count: Int, size: CGSize, aspectRatio: CGFloat) -> CGFloat {
        var columnCount = 1.0
        let count = CGFloat(count)
        repeat {
            let width = size.width / columnCount
            let height = width / aspectRatio
            
            let rowCont = (count / columnCount).rounded(.up)
            if rowCont * height < size.height {
                return (size.width / columnCount).rounded(.down)
            }
            columnCount += 1
            
        } while columnCount < count
        return min(size.width / count, size.height * aspectRatio).rounded(.down)
    }
}
