//
//  ViewController.swift
//  PostData
//
//  Created by supapon pucknavin on 1/22/2560 BE.
//  Copyright © 2560 supapon pucknavin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var lbStatus: UILabel!
    
    @IBOutlet weak var btPost: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func tapOnPost(_ sender: UIButton) {
        
        
        
    }

    
    // MARK: - Network
    
    func request_GET() {
        
        let urlUpdate:URL! = URL(string: "")
        
        
        var request = URLRequest(url: urlUpdate)
        
        request.httpMethod = "GET"
        
        request.addValue("abcdewtsdfdsfsfsfsfsf", forHTTPHeaderField: "HTTP-AUTHENTICATION-TOKEN")
        
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
     
        

        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let _ = response, let data = data{
                // print(response)
                //let strData:String = String(data: data, encoding: String.Encoding.utf8)!
                
                //print(strData)
                
                do{
                    let dicData = try JSONSerialization.jsonObject(with: data, options: []) as? [[String:Any]]
                    
                    
                    if let dicData = dicData{
                        
                    
                        
                        
                        
                        print(dicData)
                        
                        
                        self.lbStatus.text = "Success"
                        
                        
                    }else{
                        
                        self.lbStatus.text = "Error"
                    }
                    
                    
                }catch{
                    
                    
                    
                    self.lbStatus.text = "Error"
                    
                }
                
                
            }else{
                
                
                
                
                
                var errMess:String = ""
                if let error = error{
                    print(error)
                    errMess = error.localizedDescription
                }
                
                self.lbStatus.text = errMess
                
                
            }
        }
        
        task.resume()
        
        
    }
    
    
    
    
    
    
    func request_POST() {
        
        let strURLUpdate:String = ""
        print(strURLUpdate)
        
        let urlUpdate:URL! = URL(string: strURLUpdate)
        
        var request = URLRequest(url: urlUpdate)
        
        request.httpMethod = "POST"
        
        request.addValue("abcdewtsdfdsfsfsfsfsf", forHTTPHeaderField: "HTTP-AUTHENTICATION-TOKEN")
        
        

        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        
        
        
        
        var body:[String:Any] = [String:Any]()
        
        body["user"] = "aassffdd"
        body["password"] = 0


        
        
        var property:[String:Any] = [String:Any]()
        property["login"] = body
        
        
        
        print(property)
        
        
        
        do{
            let postData = try JSONSerialization.data(withJSONObject: property, options: JSONSerialization.WritingOptions())
 
            
            request.httpBody = postData
            
            print(postData)
            
            
            
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                if let _ = response, let data = data{
                    //print(response)
                    let strData:String = String(data: data, encoding: String.Encoding.utf8)!
                    
                    print(strData)
                    
                    do{
                        let dicData = try JSONSerialization.jsonObject(with: data, options: []) as? [String:Any]
                        
                        
                        if let dicData = dicData{
                            print(dicData)
             
                            self.lbStatus.text = "Success"
                        }else{
                           self.lbStatus.text = "Error"
                        }
                        
                        
                    }catch{
                        self.lbStatus.text = "Error"
                    }
                    
                    
                }else{
                    
                    
                    
                    
                    
                    var errMess:String = ""
                    if let error = error{
                        print(error)
                        errMess = error.localizedDescription
                    }
                    
                    print(errMess)
                    self.lbStatus.text = errMess
                    
                }
            }
            
            task.resume()
            
            
            
        }catch{
            //Json error
            self.lbStatus.text = "Error"
            
        }
        
        
    }
    
    
    // MARK: - Post Image
    
    func generateBoundaryString() -> String {
        return "Boundary-\(NSUUID().uuidString)"
    }
    
    
    

    
    func createBody(parameters: [String: String],
                    boundary: String,
                    data: Data,
                    mimeType: String,
                    filename: String) -> Data {
        let body = NSMutableData()
        
        let boundaryPrefix = "--\(boundary)\r\n"
        
        for (key, value) in parameters {
            body.append(boundaryPrefix.data(using: String.Encoding.utf8, allowLossyConversion: false)!)
            
            var str:String = "Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n"
            
            
            
            body.append(str.data(using: String.Encoding.utf8, allowLossyConversion: false)!)
            
            
            str = "\(value)\r\n"
            body.append(str.data(using: String.Encoding.utf8, allowLossyConversion: false)!)
        }
        
        body.append(boundaryPrefix.data(using: String.Encoding.utf8, allowLossyConversion: false)!)
        
        
        var str:String = "Content-Disposition: form-data; name=\"file\"; filename=\"\(filename)\"\r\n"
        
        body.append(str.data(using: String.Encoding.utf8, allowLossyConversion: false)!)
        
        
        
        
        str = "Content-Type: \(mimeType)\r\n\r\n"
        body.append(str.data(using: String.Encoding.utf8, allowLossyConversion: false)!)
        body.append(data)
        
        str = "\r\n"
        body.append(str.data(using: String.Encoding.utf8, allowLossyConversion: false)!)
        
        
        str = "--".appending(boundary.appending("--"))
        
        body.append(str.data(using: String.Encoding.utf8, allowLossyConversion: false)!)
        
        return body as Data
    }
    
    
    
    
    
    
    func postImage(Image image:UIImage) {
        
   
        
        
        
        if let imageData = UIImageJPEGRepresentation(image, 0.9){
            
            
            let strURLUpdate:String = ""
            print(strURLUpdate)
            
            let urlUpdate:URL! = URL(string: strURLUpdate)
            
            var request = URLRequest(url: urlUpdate)
            
            request.httpMethod = "POST"
            
            request.addValue("abcdewtsdfdsfsfsfsfsf", forHTTPHeaderField: "HTTP-AUTHENTICATION-TOKEN")
            
            
            let boundary = generateBoundaryString()
            
            let contentType:String = String(format: "multipart/form-data; boundary=%@", boundary)
            request.addValue(contentType, forHTTPHeaderField: "Content-Type")
  

            let param:[String:String] = ["userId": "qwe33"]
            
            
            
            let time:NSInteger = NSInteger(NSDate.timeIntervalSinceReferenceDate)
            let filename:String = String(format: "%d.jpg", time)//"userAvatar.jpg"
            
            
            
            request.httpBody = createBody(parameters: param, boundary: boundary, data: imageData, mimeType: "image/jpg", filename: filename)
            
            //print(request.httpBody)
            
            
            
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                if let _ = response, let data = data{
                    //print(response)
                    let strData:String = String(data: data, encoding: String.Encoding.utf8)!
                    print("Upload Image")
                    print(strData)
                    
                    self.lbStatus.text = "Success"
                    
                }else{
                    
                    
                    self.lbStatus.text = "Error"
                    
                }
                
                
             
            }
            
            task.resume()
            
            
            
        }else{
            
            self.lbStatus.text = "Error"
        }
    }
    
    
    
}

