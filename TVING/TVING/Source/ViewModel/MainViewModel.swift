//
//  MainViewModel.swift
//  TVING
//
//  Created by YOUJIM on 6/7/24.
//

import UIKit
import Moya


class MainViewModel {
    var contentData = [Content]()
    let channelDummy = Channel.dummy()
    let segmentData = ["홈", "실시간", "TV프로그램", "영화", "파라마운트+"]
    
    func getBoxOfficeList(_ collectionViews: [UICollectionView]) {
        let provider = MoyaProvider<WeeklyBoxOfficeAPI>()
        
        provider.request(.weekly) { [self] result in
            switch result {
            case let .success(result):
                let result = try? result.map(WeeklyResponseModel.self)
                guard let movieList = result?.boxOfficeResult.weeklyBoxOfficeList else { return }
                
                for movie in movieList {
                    contentData.append(Content(image: .mainPoster, name: movie.movieNm))
                    print(contentData)
                }
                
                collectionViews.forEach { $0.reloadData() }
                
            case .failure(_):
                print("오류")
            }
        }
    }
    
    func countCollectionView(_ collectionView: UICollectionView) -> Int {
        if collectionView.tag == 3 { return segmentData.count }
        if collectionView.tag == 2 { return channelDummy.count }
        
        return contentData.count
    }
    
    func bindCollectionViewData(_ collectionView: UICollectionView,_ indexPath: IndexPath) -> UICollectionViewCell {
        let contentCell = collectionView.dequeueReusableCell(withReuseIdentifier: ContentCollectionViewCell.cellID, for: indexPath) as? ContentCollectionViewCell
        
    
        if collectionView.tag == 3 {
            let segmentCell = (collectionView.dequeueReusableCell(withReuseIdentifier: SegmentCollectionViewCell.cellID, for: indexPath) as? SegmentCollectionViewCell)!
            
            segmentCell.textLabel.text = segmentData[indexPath.row]
            
            return segmentCell
        }
        if collectionView.tag == 2 {
            let channelCell = (collectionView.dequeueReusableCell(withReuseIdentifier: ChannelCollectionViewCell.cellID, for: indexPath) as? ChannelCollectionViewCell)!
            
            channelCell.channelImageView.image = channelDummy[indexPath.row].image
            channelCell.channelLabel.text = channelDummy[indexPath.row].channel
            channelCell.contentLabel.text = channelDummy[indexPath.row].content
            channelCell.rankLabel.text = channelDummy[indexPath.row].rank
            channelCell.ratingLabel.text = channelDummy[indexPath.row].rating
            
            return channelCell
        }
        
        contentCell?.contentImageView.image = contentData[indexPath.row].image
        contentCell?.contentLabel.text = contentData[indexPath.row].name
        
        return contentCell!
    }
}
