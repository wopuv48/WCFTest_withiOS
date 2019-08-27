//
//  ViewController.swift
//  WCFTest
//
//  Created by 진형진 on 13/08/2019.
//  Copyright © 2019 진형진. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {
    //     url : "http://yourPortNumber/WCFService_Template/WCFService_Template.svc"
    
    func getLines() {
        let webMethodName = "ServiceTest"
        
        var bodyData : String = "<SOAP-ENV:Envelope xmlns:SOAP-ENV=\"http://schemas.xmlsoap.org/soap/envelope/\">"
        bodyData = bodyData + "<SOAP-ENV:Body>"
        bodyData = bodyData + String(format: "<%@ xmlns=\"http://tempuri.org/\">", webMethodName)
        bodyData = bodyData + String(format: "<value>%d</value>", 10)
        bodyData = bodyData + String(format: "</%@>", webMethodName)
        bodyData = bodyData + "</SOAP-ENV:Body>"
        bodyData = bodyData + "</SOAP-ENV:Envelope>"
        let theUrl = URL(string: "http://yourPortNumber/WCFService_Template/WCFService_Template.svc")
        var url = URLRequest(url: theUrl!)
        url.addValue("text/xml; charset=utf-8", forHTTPHeaderField: "Content-Type")
        url.addValue(String(format: "http://tempuri.org/IWCFService/%@", webMethodName), forHTTPHeaderField: "SOAPAction")
        url.addValue(String(bodyData.lengthOfBytes(using: .utf8)), forHTTPHeaderField: "Content-Length")
        url.httpMethod = "POST"
        url.httpBody = bodyData.data(using: String.Encoding.utf8)
        
        Alamofire.request(url).responseString { response in
            switch(response.result) {
            case .success:
                print(response.result.value)
                print("success")
            case .failure:
                print("fail")
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getLines()
        // Do any additional setup after loading the view.
    }
    
    
}

