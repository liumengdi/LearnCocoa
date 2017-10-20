//
//  ViewController.swift
//  ToDo List
//
//  Created by 刘梦迪 on 2017/10/19.
//  Copyright © 2017年 mengdi. All rights reserved.
//

import Cocoa

class ViewController: NSViewController, NSTableViewDataSource, NSTableViewDelegate {

    @IBOutlet weak var importantChecbox: NSButton!
    @IBOutlet weak var textField: NSTextField!
    
    @IBOutlet weak var tableView: NSTableView!
    var toDoItems: [TodoItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override var representedObject: Any? {
        didSet {

        }
    }
    
    func getTodoItems() {
        //Get the todoItems from coreData
        if let context = (NSApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
            
            do {
                toDoItems = try context.fetch(TodoItem.fetchRequest())
                print(toDoItems.count)
            } catch {
                
            }
            
        }
        
        // set them to the class property
        
        // update UI
        
        
    }

    @IBAction func addClicked(_ sender: NSButton) {
        if textField.stringValue != "" {
            if let context = (NSApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
                let todoItem = TodoItem(context: context)
                todoItem.name = textField.stringValue
                if importantChecbox.state.rawValue == 0 {
                    todoItem.important = false
                }else {
                    todoItem.important = true
                }
                (NSApplication.shared.delegate as? AppDelegate)?.saveAction(nil)
                
                textField.stringValue = ""
                importantChecbox.state = .off
                
                getTodoItems()
                tableView.reloadData()
            }
            
        }
        
    }
    
    // MARK: - TableView Staff
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        return toDoItems.count
    }
    
//    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
//        if let cell = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "importanceCell"), owner: self) as? NSTableCellView {
//            let todoItem = toDoItems[row]
//
//            print(todoItem.name ?? "没有数据")
//            cell.textField?.stringValue = todoItem.name!
//
//            return cell
//        }
//        return nil
//    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        
        let todoItem = toDoItems[row]
        
        if (tableColumn?.identifier)!.rawValue == "importanceColumn" {
            
            if let cell = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "importance"), owner: self) as? NSTableCellView {
                let todoItem = toDoItems[row]
                
                cell.textField?.stringValue = todoItem.name!
                
                return cell
            }

        } else {
            
            if let cell = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "importance"), owner: self) as? NSTableCellView {
                
                cell.textField?.stringValue = todoItem.name!
                
                return cell
            }

        }
        
        return nil
    }
    
}

