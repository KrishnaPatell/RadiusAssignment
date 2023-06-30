//
//  HomeViewModel.swift
//  iosAssignment
//
//  Created by C100-174 on 30/06/23.
//

import Foundation

class HomeViewModel: BaseViewModel {
    private var objData : BaseClass?
    private var selectedThings : [selectedFacilityAndOption] = []
    var reloadSection: Dynamic<Int> = Dynamic(0)
    
    //MARK:- DEPENDENCY INJECTION
    override init() {
        super.init()
    }
    
    //MARK:- API CALLING
    func API_GetData() {
        self.isLoaderHidden.value = false
        APIHelper.shared.getRequestWithoutParams(endpointurl: WEBSERVICE_PATH) { data, error, message in
            self.isLoaderHidden.value = true
            if error != nil {
                self.warningTextMessage.value = error?.localizedDescription ?? MESSAGE
            } else {
                do {
                    let jsonData = try JSONSerialization.data(withJSONObject: data, options: .prettyPrinted)
                    let decoder = JSONDecoder()
                    let model = try decoder.decode(BaseClass.self, from: jsonData)
                    self.setData(obj: model)
                    //self.setUpDefaultArrayForselection()
                    self.needToReload.value = true
                } catch {
                    self.warningTextMessage.value = error.localizedDescription
                }
            }
        }
    }
    
}

extension HomeViewModel {
    
    //SET DATA
    func setData(obj : BaseClass) {
        objData = obj
    }
    
    func getData() -> BaseClass? {
        objData
    }
    
    func getFacilities() -> [Facilities] {
        objData?.facilities ?? []
    }
    
    func getFacilities(AtPos : Int) -> Facilities? {
        objData?.facilities?[AtPos]
    }
    
    func getExclusions() -> [[exclusion]] {
        objData?.exclusions ?? []
    }
    
    func getTotalFacilities() -> Int {
        getFacilities().count
    }
    
    func getOptionsForFacility(AtPos : Int) -> [Options] {
        let objFac = getFacilities(AtPos: AtPos)
        return objFac?.options ?? []
    }
    
    func getOptionsCountForFacility(AtPos : Int) -> Int {
        getOptionsForFacility(AtPos: AtPos).count
    }
    
    func setUpDefaultArrayForselection()  {
        for _ in getFacilities() {
            selectedThings.append(selectedFacilityAndOption())
        }
    }
    
    func setSelectedOptionWithFacility(facilityId: String, optionId: String, forIndex: Int) {
        //check if facility is already there or not
        if selectedThings.contains(where: { $0.facility_id == facilityId}) {
            if let index = selectedThings.firstIndex(where: { $0.facility_id == facilityId }) {
                let canAdd = checkForExclusion(incomingFacilityId: facilityId, incomingOptionId: optionId)
                if canAdd {
                    var objS = selectedThings[index]
                    objS.facility_id = facilityId
                    objS.option_id = optionId
                    selectedThings[index] = objS
                    reloadSection.value = forIndex
                }
            }
        } else {
            let canAdd = checkForExclusion(incomingFacilityId: facilityId, incomingOptionId: optionId)
            if canAdd {
                if !checkIfFacilityOptionSelectedOrNot(facilityId: facilityId, optionId: optionId) {
                    selectedThings.append(selectedFacilityAndOption(facility_id: facilityId, option_id: optionId))
                    reloadSection.value = forIndex
                }
                
            }
        }
        
    }
    
    func checkIfFacilityOptionSelectedOrNot(facilityId: String, optionId: String) -> Bool{
        if selectedThings.contains(where: { $0.facility_id == facilityId && $0.option_id == optionId}) {
            return true
        }
        return false
    }
    
    func checkForExclusion(incomingFacilityId: String, incomingOptionId: String) -> Bool{
        if let matchedIndex = getExclusions().firstIndex(where: { subArray in
            subArray.contains(where: { obj in
                return obj.facilityId == incomingFacilityId && obj.optionsId == incomingOptionId
            })
        }) {
            let matchedArray = getExclusions()[matchedIndex]
            if matchedArray.count > 0 {
                let filteredArray = matchedArray.filter { obj in
                    return obj.facilityId != incomingFacilityId || obj.optionsId != incomingOptionId
                }
                print(filteredArray)
                if filteredArray.count > 0 {
                    let obj = filteredArray[0]
                    
                                       
                    if checkIfFacilityOptionSelectedOrNot(facilityId: obj.facilityId ?? "", optionId: obj.optionsId ?? "") {
                        
                        if let index = selectedThings.firstIndex(where: { $0.facility_id == obj.facilityId ?? "" && $0.option_id == obj.optionsId ?? "" }) {
                            selectedThings.remove(at: index)
                            
                            if let inx = getFacilities().firstIndex(where: {$0.facilityId == obj.facilityId ?? ""}) {
                                reloadSection.value = inx
                            }
                            return true
                        }
                        
                        return false
                    } else {
                        return true
                    }
                    
                } else {
                    return true
                }
            } else {
                return true
            }
        } else {
            return true
        }
    }
}
