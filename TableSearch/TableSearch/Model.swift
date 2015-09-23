//
//  Model.swift
//  TableSearch
//
//  Created by neil-r on 9/22/15.
//  Copyright (c) 2015 neil-r. All rights reserved.
//

import UIKit

class Model: NSObject {
    
// MARK: Private Variables
    //dataListArray is the base data.  Feel free to change this, but keep the same format
    //Sections will be presented in the same order as they are in the array
    //Row data will be sorted alphabetically.  Find "Row-Sort-Filter" and remove to present data is same order as array.
    private let dataListArray = [["A":["Antigua and Barbuda","Atlanta","Australia"]],
                                ["B":["Bahamas","Bora Bora","Barcelona"]],
                                ["F":["Fargo","France"]],
                                ["G":["Gernamny"]],
                                ["I":["Italy"]],
                                ["L":["London","Las Vegas","Lima, Peru","Los Angeles"]],
                                ["M":["Maui","Milan","Minneapolis"]],
                                ["P":["Paris","Philadelphia"]],
                                ["S":["San Fransisco","Sydney","Scotland","Sweden","Switzerland"]]]
    
    //Data Array used for Search.  Array removes all sections and arranges alphabetically.  Array contains ALL rows.
    private var dataListValuesArray : Array<String>{
        var dataArray:[String] = []
        for items in dataListArray{
            let getValues = Array(items.values)
            dataArray += getValues[0]
        }
        dataArray = dataArray.sort{$0 < $1}
        return dataArray
    }
    //Array that contains only rows that match search criteria.
    private var filteredValuesArray = [String]()
    //Flag that is flipped when Search is in progress.  This helps determine which array to present to the TableViewController.
    private var searchActive = false
    
// MARK: Public Functions
    func isSearchActive(state:Bool){
        searchActive = state
    }
    
    //SearchBar on TableViewController calls this method and passes the searchTerm the user entered.
    //this function will search dataListValueArray and write results to filteredValueArray.
    func filterListForSearch(searchTerm:String){
        filteredValuesArray = dataListValuesArray.filter({(item:String) -> Bool in
            let searchTermCount = searchTerm.characters.count
            let itemCount = item.characters.count
           
            if searchTermCount <= itemCount{
                let index  = item.startIndex.advancedBy(searchTermCount)
                let tempStr = item.substringToIndex(index)
                if searchTerm.lowercaseString == tempStr.lowercaseString{
                    return true
                }else{
                    return false}
            } else {
                return false}
        })
    }
    //MARK: TableView Functions
    //functions below are called by the TableView.  They use the searchActive flag to determine what 
    //data array to use.
    func getSectionCount() -> Int{
        if searchActive{
            return 1
        }
        else{
            return dataListArray.count
        }
    }
    
    func getSectionNameForSectionNumber(section:Int) ->String{
        if searchActive{
            return sectionNameForSearch()
        }else{
         return sectionNameForSection(section)
        }
    }
    
    func getCellTitle(section section:Int, row:Int) -> String{
        
        if searchActive{
            return cellTitleFor(row: row)
        }
        else {
            return cellTitleFor(row:row, section:section)
        }
    }
    
    func getRowCountForSectionNumber(section:Int)->Int{
        if searchActive{
            return rowCountOneSection()
        }else{
            return rowCountWithSection(section)
        }
    }
    //This function doesn't use searchActive flag since it is only called when searchActive = false (Table sections are only used when search is not being performed)
    func getSectionListArray() ->Array<String>{
        var sections:[String] = []
        
        for items in dataListArray{
            let getSection = Array(items.keys)
            sections += getSection
        }
        return sections
    }

    
    
    
// MARK: Private Functions
    //functions used by TableRow functions above.  Functions with just Row as a parameter are used with searchActive = true
    //functions with Section and Row parameters are used when searchActive = false.
    
    private func cellTitleFor(row row:Int)->String{
        let cellTitle = filteredValuesArray[row]
        return cellTitle
    }
    private func cellTitleFor(row row:Int,section:Int)-> String{
        let sectionDictionary = dataListArray[section]
        let sectionDictionaryValues = Array(sectionDictionary.values)
        if (sectionDictionaryValues.count != 0){
            var rowValues = sectionDictionaryValues[0]
            rowValues = rowValues.sort{$0 < $1} // Sort-Data-Filter.  Remove this line if not needed.
            let cellTitle = rowValues[row]
            return cellTitle
        }else {return ""}
    }
    private func rowCountWithSection(section:Int)->Int{
        let sectionDictionary = dataListArray[section]
        let sectionDictionaryValues = Array(sectionDictionary.values)
        if (sectionDictionaryValues.count != 0){
            let rowValues = sectionDictionaryValues[0]
            return rowValues.count
        }else {return 0}
    }
    private func rowCountOneSection() ->Int{
        return filteredValuesArray.count
    }
    private func sectionNameForSection(section:Int) ->String{
        let sectionList = getSectionListArray()
        return sectionList[section]
    }
    private func sectionNameForSearch() -> String{
        let tempStr = filteredValuesArray.first
        if (tempStr != nil){
            let tempStrFirstChar = tempStr![tempStr!.startIndex]
            return String(tempStrFirstChar)
        }else{
            return ""
        }
    }

}
