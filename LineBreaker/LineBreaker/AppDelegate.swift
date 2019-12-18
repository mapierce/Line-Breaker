//
//  AppDelegate.swift
//  LineBreaker
//
//  Created by Matthew Pierce on 16/12/2019.
//  Copyright © 2019 Matthew Pierce. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBAction func readmeTapped(_ sender: Any) {
        let url = URL(string: "https://github.com/mapierce/Line-Breaker/blob/master/README.md")!
        NSWorkspace.shared.open(url)
    }
    
    @IBAction func submitIssueTapped(_ sender: Any) {
        let url = URL(string: "https://github.com/mapierce/Line-Breaker/issues/new")!
        NSWorkspace.shared.open(url)
    }
    
    @IBAction func shareFeedbackTapped(_ sender: Any) {
        let url = URL(string: "https://twitter.com/PierceMatthew")!
        NSWorkspace.shared.open(url)
    }
    
}

