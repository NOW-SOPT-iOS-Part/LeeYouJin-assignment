//
//  WeeklyBoxOfficeAPI.swift
//  TVING
//
//  Created by YOUJIM on 5/10/24.
//

import Foundation

import Moya

enum WeeklyBoxOfficeAPI {
    case weekly
}


extension WeeklyBoxOfficeAPI: TargetType {
    var path: String {
        return "/kobisopenapi/webservice/rest/boxoffice/searchWeeklyBoxOfficeList.json"
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var task: Moya.Task {
        switch self {
        case .weekly:
            let parameter: [String: String] = [
                "key": Secret.movieAPIkey,
                "targetDt": "20240503",
                "weekGb": "0",
                "itemPerPage": "10",
                "multiMovieYn": "",
                "repNationCd": "",
                "wideAreaCd": ""
            ]
            
            return .requestParameters(parameters: parameter, encoding: URLEncoding.queryString)
            
        default:
            return .requestPlain
        }
        
    }
    
    var headers: [String : String]? {
        return ["Content-Type": "application/json"]
    }
    
    var baseURL: URL {
        return URL(string: "http://www.kobis.or.kr")!
    }
}
