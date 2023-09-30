//
//  SportsViewModel.swift
//  Sports-Hub
//
//  Created by Khater on 28/09/2023.
//

import Foundation


protocol SportsViewModelProtocol {
    var noOfItems: Int { get }
    var didSelectSport: () -> Void { get set }
    
    func configuarCell(_ cell: SportCellView, at index: Int)
    func selectedSport(at index: Int)
}


class SportsViewModel: SportsViewModelProtocol {
    private var sports: [(title: String, imageURLString: String)] = [
        (title: "Football", imageURLString: "https://images.unsplash.com/photo-1522778119026-d647f0596c20?w=480"),
        (title: "Basketball", imageURLString: "https://images.unsplash.com/photo-1574142233428-93b8c48af5ec?w=480"),
        (title: "Cricket", imageURLString: "https://images.unsplash.com/photo-1589801126816-38f3f2e18b89?w=480"),
        (title: "Tennis", imageURLString: "https://images.unsplash.com/photo-1531315396756-905d68d21b56?w=480"),
    ]
    
    var noOfItems: Int {
        return sports.count
    }
    
    var didSelectSport: () -> Void = {}
    
    func configuarCell(_ cell: SportCellView, at index: Int){
        let sport = sports[index]
        cell.setBackgroundImageView(withURL: URL(string: sport.imageURLString))
        cell.setTitleLabel(withText: sport.title)
    }
    
    func selectedSport(at index: Int) {
        didSelectSport()
    }
}
