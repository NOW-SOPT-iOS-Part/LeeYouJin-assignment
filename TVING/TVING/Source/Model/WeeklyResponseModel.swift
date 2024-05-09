//
//  WeeklyResponseModel.swift
//  TVING
//
//  Created by YOUJIM on 5/10/24.
//

import Foundation


struct WeeklyResponseModel: Codable {
    let boxOfficeResult: boxOfficeResult
}

struct boxOfficeResult: Codable {
    let boxofficeType, showRange, yearWeekTime: String
    let weeklyBoxOfficeList: [WeeklyBoxOfficeList]
}

struct WeeklyBoxOfficeList: Codable {
    let rnum, rank, rankInten, rankOldAndNew, movieCd, movieNm, openDt, salesAmt,
    salesShare, salesInten, salesChange, salesAcc, audiCnt, audiInten, audiChange, audiAcc,
    scrnCnt, showCnt: String
}

