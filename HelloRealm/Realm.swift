//
//  Realm.swift
//  HelloRealm
//
//  Created by ido on 2021/02/03.
//

import Foundation
import RealmSwift

//MARK: - Object 생성
/*  dynamic : Runtime 일때, Realm이 자동으로 변수의 변화를 탐지하기 위해
    @objc : 위 과정이 objective-c를 통해 이루어지기 때문에 @objc 키워드를 덧붙입니다.*/
class MyData: Object {
    @objc dynamic var name = ""
    @objc dynamic var jobPosition = ""
    var careers = List<String>()
}

struct RealmModel {
    
    //MARK: - Default Realm
    let realm = try! Realm()
    
    //MARK: - Create Data
    func create(_ data: MyData) {
        do {
            try realm.write {
                realm.add(data)
            }
        } catch {
            print("Error: \(error)")
        }
    }
        
    //MARK: - Update Data
       func update(_ data: MyData, jobPostion: String, career: List<String>) {
           do {
               try realm.write {
                   data.jobPosition = jobPostion
                   data.careers = career
               }
           } catch {
               print("Error: \(error)")
           }
    }
    
    //MARK: - Delete Data
    func delete(_ data: MyData) {
        do {
            try realm.write {
                realm.delete(data)
            }
        } catch {
            print("Error: \(error)")
        }
    }
    
    //MARK: - Filter & Sorting
    func filering() -> MyData? {
        let result = realm.objects(MyData.self).filter("name == Doyoung")
        return result.first
    }
    
    
    //MARK: - 파일 확인
    /* Realm Studio 설치 후*/
   

}
