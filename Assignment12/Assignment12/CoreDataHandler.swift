//
//  CoreDataHandler.swift
//  MyCoreData
//
//  Created by DCS on 16/12/21.
//  Copyright © 2021 DCS. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class CoreDataHandler {
    static let shared = CoreDataHandler()
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    let managedObjectContext : NSManagedObjectContext?
    
    private init() {
        managedObjectContext = appDelegate.persistentContainer.viewContext
    }
    
    func save() {
        appDelegate.saveContext()
    }
    
    func insert(name: String, pwd: String, sclass: String, phone: String, completion: @escaping () -> Void) {
        let s = Stud(context: managedObjectContext!)
        
        s.name = name
        s.password = pwd
        s.sclass = sclass
        s.phone = phone
        
        save()
        completion()
    }
    
    func update(s: Stud, name: String, pwd: String, sclass: String, phone: String, completion: @escaping () -> Void) {
        s.name = name
        s.password = pwd
        s.sclass = sclass
        s.phone = phone
        
        save()
        completion()
    }
    
    func delete(s: Stud, completion: @escaping () -> Void) {
        managedObjectContext!.delete(s)
        
        save()
        completion()
    }
    
    func fetch() -> [Stud] {
        let fetchRequest: NSFetchRequest<Stud> = Stud.fetchRequest()
        
        do {
            let s = try managedObjectContext?.fetch(fetchRequest)
            return s!
        }catch {
            print(error)
            return [Stud]()
        }
    }
    
    func fetchclass(sclass: String) -> [Stud] {
        let fetchRequest: NSFetchRequest<Stud> = Stud.fetchRequest()
        
        fetchRequest.predicate = NSPredicate(format: "sclass like %@", sclass)
        
        do {
            let s = try managedObjectContext?.fetch(fetchRequest)
            return s!
        }catch {
            print(error)
            return [Stud]()
        }
    }
    
    func insertN(title: String, date: String, des: String, completion: @escaping () -> Void) {
        let n = Noticetb(context: managedObjectContext!)
        
        n.title = title
        n.date = date
        n.des = des
        
        save()
        completion()
    }
    
    func updateN(n: Noticetb, title: String, date: String, des: String, completion: @escaping () -> Void) {
        n.title = title
        n.date = date
        n.des = des
        
        save()
        completion()
    }
    
    func deleteN(n: Noticetb, completion: @escaping () -> Void) {
        managedObjectContext!.delete(n)
        
        save()
        completion()
    }
    
    func fetchN() -> [Noticetb] {
        let fetchRequest: NSFetchRequest<Noticetb> = Noticetb.fetchRequest()
        
        do {
            let n = try managedObjectContext?.fetch(fetchRequest)
            return n!
        }catch {
            print(error)
            return [Noticetb]()
        }
    }
    
    func check(id : Int, pwd : String) -> Bool {
        let fetchRequest: NSFetchRequest<Stud> = Stud.fetchRequest()

        fetchRequest.predicate = NSPredicate(format: "spid contains %i and password like %@",id , pwd)
        
        fetchRequest.resultType = .countResultType
        do {
            let s : NSInteger = try (managedObjectContext?.count(for: fetchRequest))!
           
            if s == 0 {
                return false
            }
            else {
                return true
            }
        }catch {
            print(error)
            return false
        }
    }
    
    func fetchid(id: Int) -> Stud {
        let fetchRequest: NSFetchRequest<Stud> = Stud.fetchRequest()
        
        fetchRequest.predicate = NSPredicate(format: "spid contains %i", id)
        
        do {
            let s = try managedObjectContext?.fetch(fetchRequest)
            return s![0]
        }catch {
            print(error)
            return Stud()
        }
    }
    
    func chpwd(s: Stud, pwd: String, completion: @escaping () -> Void) {
        s.password = pwd
        
        save()
        completion()
    }
    
    func fetchidN(id: Int) -> Noticetb {
        let fetchRequest: NSFetchRequest<Noticetb> = Noticetb.fetchRequest()
        
        fetchRequest.predicate = NSPredicate(format: "nid contains %i", id)
        
        do {
            let n = try managedObjectContext?.fetch(fetchRequest)
            return n![0]
        }catch {
            print(error)
            return Noticetb()
        }
    }
}
