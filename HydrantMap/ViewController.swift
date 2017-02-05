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

    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let hydrants = hydrantsFromJSONFile()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    private func hydrantsFromJSONFile() -> [Hydrant]? {
        
        do{
            guard let hydrantJSONFile = Bundle.main.url(forResource:"hydranten", withExtension: "json") else { return nil }
            
            let fileContent = try String(contentsOf: hydrantJSONFile, encoding: String.Encoding.utf8)
            
            guard
                let data = fileContent.data(using: .utf8),
            let hydrantJSONArray = try? JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]]
                else { return nil }
            
            return hydrantJSONArray?.flatMap({
                guard let pair = $0 as? [String:String] else {return nil    }
                return makeHydrant(jsonDict: pair)
            })
            
        } catch {
            NSLog(error.localizedDescription)
            return nil
        }
    }
    
    private func makeHydrant(jsonDict: [String:String]) -> Hydrant? {
        
        guard
            let longiture = Double(jsonDict["Longitude"] ?? "0"),
            let latitude = Double(jsonDict["Latitude"] ?? "0")
            else { return nil }
        
        return Hydrant(latitude: latitude, longitude: longiture)
    }
}

