//
//  ViewController.swift
//  Downloading App
//
//  Created by Faiz Ul Hassan on 12/6/20.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let myStuffURL = URL.createFolder(folderName: "VIDEOS")
        print("\(myStuffURL)")

        guard let sourcePath = Bundle.main.path(forResource: "sample", ofType: "pdf") else {return}

        let fileManager = FileManager.default
        let doumentDirectoryPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString
        let destinationPath = doumentDirectoryPath.appendingPathComponent("sample.pdf")
        do{
          try fileManager.copyItem(atPath: sourcePath, toPath: destinationPath)
        }catch let error as NSError {
          print("error occurred, here are the details:\n \(error)")
        }

    }


}


//
import Foundation

extension URL {
    static func createFolder(folderName: String) -> URL? {
        let fileManager = FileManager.default
        // Get document directory for device, this should succeed
        if let documentDirectory = fileManager.urls(for: .documentDirectory,
                                                    in: .userDomainMask).first {
            // Construct a URL with desired folder name
            let folderURL = documentDirectory.appendingPathComponent(folderName)
            // If folder URL does not exist, create it
            if !fileManager.fileExists(atPath: folderURL.path) {
                do {
                    // Attempt to create folder
                    try fileManager.createDirectory(atPath: folderURL.path,
                                                    withIntermediateDirectories: true,
                                                    attributes: nil)
                } catch {
                    // Creation failed. Print error & return nil
                    print(error.localizedDescription)
                    return nil
                }
            }
            // Folder either exists, or was created. Return URL
            return folderURL
        }
        // Will only be called if document directory not found
        return nil
    }
}
