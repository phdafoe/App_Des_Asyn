//
//  SegundaViewController.swift
//  App_Des_Asyn
//
//  Created by cice on 22/3/17.
//  Copyright © 2017 cice. All rights reserved.
//

import UIKit

class SegundaViewController: UIViewController {
    
    //MARK: - Variables locales
    var myOperationQueue : OperationQueue?
    
    let urlStringUno = "http://cdn1.ouchpress.com/media/celebrities/585/alexa-davalos-400996.jpg"
    let urlStringDos = "http://i0.wp.com/kingoftheflatscreen.com/wp-content/uploads/2015/10/alexa_davalos_reunion_promo_DLJs2Dk.jpg"
    let urlStringTres = "http://www.media4.hw-static.com/wp-content/uploads/6837655.jpg"
    let urlStringCuatro = "http://www.hdfondos.eu/pictures/2012/0214/1/orig_498476.jpg"
    
    
    
    //MARK: - IBOutlets
    @IBOutlet weak var myImageViewUno: UIImageView!
    @IBOutlet weak var myImageViewDos: UIImageView!
    @IBOutlet weak var myIMageViewTres: UIImageView!
    @IBOutlet weak var myImageViewCuatro: UIImageView!
    
    
    //MARK: - IBActions
    @IBAction func cancelAllOperationsACTIONS(_ sender: AnyObject) {
        //podriamos preguntar en que estado se encuentra las operaciones en cualquier momento
        if myOperationQueue != nil{
            myOperationQueue?.cancelAllOperations()
            print("AQUI \(myOperationQueue!) CANCELADA")
        }
        
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        downloadImages()
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func downloadImages(){
        
        //Bloque de operaciones
        let operation1 = BlockOperation{
            //aqui dentro colocamos la tarea que queremos ejecutar
            do{
                let urlData = try Data(contentsOf: URL(string: self.urlStringUno)!)
                //cola 1 plano
                OperationQueue.main.addOperation {
                    self.myImageViewUno.image = UIImage(data: urlData)
                }
            }catch{
                print("Error en la descarga de la imagen 1")
            }
        }
        
        let operation2 = BlockOperation{
            //aqui dentro colocamos la tarea que queremos ejecutar
            do{
                let urlData = try Data(contentsOf: URL(string: self.urlStringDos)!)
                //cola 1 plano
                OperationQueue.main.addOperation {
                    self.myImageViewDos.image = UIImage(data: urlData)
                }
            }catch{
                print("Error en la descarga de la imagen 1")
            }
        }
        
        let operation3 = BlockOperation{
            //aqui dentro colocamos la tarea que queremos ejecutar
            do{
                let urlData = try Data(contentsOf: URL(string: self.urlStringTres)!)
                //cola 1 plano
                OperationQueue.main.addOperation {
                    self.myIMageViewTres.image = UIImage(data: urlData)
                }
            }catch{
                print("Error en la descarga de la imagen 1")
            }
        }
        
        
        let operation4 = BlockOperation{
            //aqui dentro colocamos la tarea que queremos ejecutar
            do{
                let urlData = try Data(contentsOf: URL(string: self.urlStringCuatro)!)
                //cola 1 plano
                OperationQueue.main.addOperation {
                    self.myImageViewCuatro.image = UIImage(data: urlData)
                }
            }catch{
                print("Error en la descarga de la imagen 1")
            }
        }
        
        //Cosas interesantes
        //podemos añadirle dependecias  a las operaciones
        //quiere decir que la operacion 1 no se va acometer hasta que se de paso a la dos y asi suscesivamente
        operation1.addDependency(operation2)
        operation2.addDependency(operation3)
        operation3.addDependency(operation4)
        
        
        myOperationQueue = OperationQueue()
        myOperationQueue?.addOperation(operation1)
        myOperationQueue?.addOperation(operation2)
        myOperationQueue?.addOperation(operation3)
        myOperationQueue?.addOperation(operation4)
        
        
    }
    

   

}
