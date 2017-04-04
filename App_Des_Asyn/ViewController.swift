//
//  ViewController.swift
//  App_Des_Asyn
//
//  Created by cice on 22/3/17.
//  Copyright © 2017 cice. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK: - Variables locales
    let sUrl = "https://static.wixstatic.com/media/2b4d35_b2a498b76cad4257a34603c07bb6eda7~mv2_d_4096_2733_s_4_2.jpg"
    
    let sUrlWiki = "https://es.wikipedia.org/wiki/Wikipedia:Portada"
    
    typealias downloadImageData = (_ imageData : UIImage) -> ()
    typealias downloadWebData = (_ webData : URLRequest) -> ()
    
    
    //MARK: - IBOutlets
    @IBOutlet weak var myImageView: UIImageView!
    @IBOutlet weak var myActiInd: UIActivityIndicatorView!
    @IBOutlet weak var mywebViewWikipedia: UIWebView!
    
    
    @IBAction func holaMundoACTION(_ sender: AnyObject) {
        //downloadImage()
        //downloadImageAsync()
        downloadImageAsyncPlus()
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
       
        myActiInd.isHidden = true
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //MARK: - Utils
    //1
    func downloadImage(){
        
        let urlString = URL(string: sUrl)
        do{
            let urlData = try Data(contentsOf: urlString!)
            myImageView.image = UIImage(data: urlData)
        }catch let error{
            print("\(error.localizedDescription)")
        }
        
    }
    
    //2
    func downloadImageAsync(){
        //Cola 2 plano
        DispatchQueue.global(qos: .default).async {
            do{
                //Imagen
                let urlData = try Data(contentsOf: URL(string: self.sUrl)!)
                //Web
                let requestWeb = URLRequest(url: URL(string: self.sUrlWiki)!)
                
                //Cola 1 plano primera accion
                DispatchQueue.main.async {
                    self.myImageView.image = UIImage(data: urlData)
                }
                //Cola 1 plano segunda accion
                DispatchQueue.main.async {
                    self.mywebViewWikipedia.loadRequest(requestWeb)
                }
            }catch{
                print("Error en la dscarga de la informacion")
            }
        }
    }
    
    //3
    func downloadImageAsyncPlus(){
        myActiInd.isHidden = false
        myActiInd.startAnimating()
        downloadDataFinal(callBackImage: { (imageData) in
            self.myImageView.image = imageData
            }) { (urlRequestData) in
                self.mywebViewWikipedia.loadRequest(urlRequestData)
                self.myActiInd.isHidden = true
                self.myActiInd.stopAnimating()
        }
    }
    
    
    //3.1
    func downloadDataFinal(callBackImage : @escaping downloadImageData , callBackWeb : @escaping downloadWebData){
        
        //Cola 2 plano
        DispatchQueue.global(qos: .default).async {
            do{
                //Image
                let imageData = UIImage(data: try Data(contentsOf: URL(string: self.sUrl)!))
                
                //Web
                let requestWeb = URLRequest(url: URL(string: self.sUrlWiki)!)
                
                //Cola 1 plano
                DispatchQueue.main.async {
                    callBackImage(imageData!)
                }
                
                DispatchQueue.main.async {
                    callBackWeb(requestWeb)
                }
            }catch{
                
            }
        }
        
    }
   
    
    
    


}

