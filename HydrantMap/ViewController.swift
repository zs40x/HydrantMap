//
//  ViewController.swift
//  HydrantMap
//
//  Created by Stefan Mehnert on 02/02/2017.
//  Copyright © 2017 Stefan Mehnert. All rights reserved.
//

import UIKit

struct Hydrant {
    let latitude: Double
    let longitude: Double
}

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        hydrantsFromJSONFile()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    private func hydrantsFromJSONFile() -> [Hydrant]? {
        
        guard let directory = FileManager.default.urls(for: .applicationDirectory, in: .userDomainMask).first else { return nil }
    
        do{
            let fileContent =
                try String(contentsOf: directory.appendingPathComponent("hydranten.json"), encoding: String.Encoding.utf8)
            
            guard
                let data = fileContent.data(using: .utf8),
                let hydrantJSONArray = try? JSONSerialization.jsonObject(with: data, options: []) as? [String]
                else { return nil }
            
        } catch {
            NSLog(error.localizedDescription)
            return nil
        }
        
      
        
        
        /*return
            hydrantJSONArray.flatMap{
                guard
                    let data = $0.data(using: .utf8),
                    let jsonDict = try? JSONSerialization.data(with: data, options: []) as? [String:String],
                    let longiture = jsonDict?["longitude"],
                    let latitude = jsonDict?["latitude"]
                    else { return nil }

                return Hydrant(latitude: latitude, longitude: longiture)
            }*/
        
        return nil
    }
}

