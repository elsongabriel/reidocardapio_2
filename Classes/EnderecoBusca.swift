//
//  EnderecoBusca.swift
//  reidocardapio
//
//  Created by Bruno Rocha on 29/09/16.
//  Copyright © 2016 Bruno Rocha. All rights reserved.
//

import Foundation

public class EnderecoBusca{
    
    private var cidade: String!
    private var bairro: String!
//    private var endereco: String!
   
    func getCidade() -> String{
        return self.cidade
    }
    
    func getBairro() -> String{
        return self.bairro
    }
    
//    func getEndereco() -> String{
//        return self.endereco
//    }
    
    func setCidade(cidade: String){
        self.cidade = cidade
    }
    
    func setBairro(bairro: String){
        self.bairro = bairro
    }
    
//    func setEndereco(endereco :String){
//        self.endereco = endereco
//    }
    
}
