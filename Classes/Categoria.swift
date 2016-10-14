//
//  Categoria.swift
//  reidocardapio
//
//  Created by Bruno Rocha on 14/10/16.
//  Copyright © 2016 Bruno Rocha. All rights reserved.
//

import Foundation

public class Categoria {
    
    private var id : Int!
    private var descricao : String!
    
    func getId() -> Int{
        return self.id
    }
    
    func getDescricao() -> String{
        return self.descricao
    }
    
    func setId(id: Int){
        self.id = id
    }
    
    func setDescricao(desc: String){
        self.descricao = desc
    }
}