//
//  MainViewController.swift
//  TVING
//
//  Created by YOUJIM on 4/24/24.
//

import UIKit

import SnapKit
import Then
import Moya

final class MainViewController: UIViewController {
    
    
    var mainViewModel = MainViewModel()
    
    // MARK: - Component
    
    private let scrollView = UIScrollView().then {
        $0.backgroundColor = .black
    }
    
    private let contentView = UIView()
    
    private let logoImageView: UIImageView = UIImageView().then {
        $0.image = .mainLogo
        $0.contentMode = .scaleAspectFit
    }
    
    private let mirroringButton: UIButton = UIButton().then {
        $0.setImage(.icMirroring, for: .normal)
    }
    
    private let profileImageView: UIImageView = UIImageView().then {
        $0.image = .basicProfile
        $0.contentMode = .scaleToFill
    }
    
    let segmentCollectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout().then {
        $0.scrollDirection = .horizontal
        $0.minimumLineSpacing = 32
        $0.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
    }).then {
        $0.tag = 3
        $0.backgroundColor = .clear
        $0.showsHorizontalScrollIndicator = false
        $0.register(SegmentCollectionViewCell.self, forCellWithReuseIdentifier: SegmentCollectionViewCell.cellID)
    }
    
    private let mainPosterView: UIImageView = UIImageView().then {
        $0.image = .mainPoster
        $0.contentMode = .scaleAspectFill
    }
    
    private let contentLabel: UILabel = UILabel().then {
        $0.font = UIFont.font(.applegothicSemibold, ofSize: 15)
        $0.textColor = .white
        $0.text = "티빙에서 꼭 봐야하는 컨텐츠"
    }
    
    private lazy var moreContentButton: UIButton = UIButton().then {
        $0.setTitle("전체보기", for: .normal)
        $0.setImage(UIImage(systemName: "chevron.right"), for: .normal)
        $0.tintColor = .white
        $0.setTitleColor(UIColor(hexCode: "9C9C9C"), for: .normal)
        $0.titleLabel?.font = UIFont.font(.pretendardMedium, ofSize: 11)
        $0.setPreferredSymbolConfiguration(.init(scale: .small), forImageIn: .normal)
        $0.semanticContentAttribute = .forceRightToLeft
    }
    
    lazy var contentCollectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout().then {
        $0.scrollDirection = .horizontal
        $0.minimumLineSpacing = 10
        $0.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
    }).then {
        $0.tag = 1
        $0.backgroundColor = .clear
        $0.showsHorizontalScrollIndicator = false
        $0.register(ContentCollectionViewCell.self, forCellWithReuseIdentifier: ContentCollectionViewCell.cellID)
    }
    
    private let channelLabel: UILabel = UILabel().then {
        $0.font = UIFont.font(.applegothicSemibold, ofSize: 15)
        $0.textColor = .white
        $0.text = "인기 LIVE 채널"
    }
    
    private lazy var moreChannelButton: UIButton = UIButton().then {
        $0.setTitle("전체보기", for: .normal)
        $0.tintColor = .white
        $0.setTitleColor(UIColor(hexCode: "9C9C9C"), for: .normal)
        $0.titleLabel?.font = UIFont.font(.pretendardMedium, ofSize: 11)
        $0.setImage(UIImage(systemName: "chevron.right"), for: .normal)
        $0.setPreferredSymbolConfiguration(.init(scale: .small), forImageIn: .normal)
        $0.semanticContentAttribute = .forceRightToLeft
    }
    
    lazy var channelCollectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout().then {
        $0.scrollDirection = .horizontal
        $0.minimumLineSpacing = 10
        $0.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
    }).then {
        $0.tag = 2
        $0.backgroundColor = .clear
        $0.showsHorizontalScrollIndicator = false
        $0.register(ChannelCollectionViewCell.self, forCellWithReuseIdentifier: ChannelCollectionViewCell.cellID)
    }
    
    private let seriesLabel: UILabel = UILabel().then {
        $0.font = UIFont.font(.applegothicSemibold, ofSize: 15)
        $0.textColor = .white
        $0.text = "1화 무료! 파라마운트+ 인기 시리즈"
    }
    
    private lazy var moreSeriesButton: UIButton = UIButton().then {
        $0.setTitle("전체보기", for: .normal)
        $0.tintColor = .white
        $0.setTitleColor(UIColor(hexCode: "9C9C9C"), for: .normal)
        $0.titleLabel?.font = UIFont.font(.pretendardMedium, ofSize: 11)
        $0.setImage(UIImage(systemName: "chevron.right"), for: .normal)
        $0.setPreferredSymbolConfiguration(.init(scale: .small), forImageIn: .normal)
        $0.semanticContentAttribute = .forceRightToLeft
    }
    
    lazy var seriesCollectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout().then {
        $0.scrollDirection = .horizontal
        $0.minimumLineSpacing = 10
        $0.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
    }).then {
        $0.backgroundColor = .clear
        $0.showsHorizontalScrollIndicator = false
        $0.register(ContentCollectionViewCell.self, forCellWithReuseIdentifier: ContentCollectionViewCell.cellID)
    }
    
    private let firstAdImageView: UIImageView = UIImageView().then {
        $0.image = .firstAD
        $0.contentMode = .scaleAspectFill
    }
    
    private let secondAdImageView: UIImageView = UIImageView().then {
        $0.image = .secondAD
        $0.contentMode = .scaleAspectFill
    }
    
    private let movieLabel: UILabel = UILabel().then {
        $0.font = UIFont.font(.applegothicSemibold, ofSize: 15)
        $0.textColor = .white
        $0.text = "티빙에서 꼭 봐야하는 컨텐츠"
    }
    
    private lazy var moreMovieButton: UIButton = UIButton().then {
        $0.setTitle("전체보기", for: .normal)
        $0.tintColor = .white
        $0.setTitleColor(UIColor(hexCode: "9C9C9C"), for: .normal)
        $0.titleLabel?.font = UIFont.font(.pretendardMedium, ofSize: 11)
        $0.setImage(UIImage(systemName: "chevron.right"), for: .normal)
        $0.setPreferredSymbolConfiguration(.init(scale: .small), forImageIn: .normal)
        $0.semanticContentAttribute = .forceRightToLeft
    }
    
    lazy var movieCollectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout().then {
        $0.scrollDirection = .horizontal
        $0.minimumLineSpacing = 10
        $0.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
    }).then {
        $0.backgroundColor = .clear
        $0.showsHorizontalScrollIndicator = false
        $0.register(ContentCollectionViewCell.self, forCellWithReuseIdentifier: ContentCollectionViewCell.cellID)
    }

    
    // MARK: - ViewDidLoad()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.mainViewModel.getBoxOfficeList([self.contentCollectionView, self.seriesCollectionView, self.movieCollectionView])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpLayout()
        setUpConstraint()
        setUpDelegate()
    }
    
    
    // MARK: - setUpLayout()
    
    private func setUpLayout() {
        print(mainViewModel.contentData)
        view.backgroundColor = .white
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        [
            mainPosterView, contentLabel, moreContentButton, contentCollectionView, channelLabel,
            moreChannelButton, channelCollectionView, seriesLabel, moreSeriesButton, seriesCollectionView,
            firstAdImageView, secondAdImageView, movieLabel, moreMovieButton, movieCollectionView
        ].forEach { contentView.addSubview($0) }
        [
            logoImageView, mirroringButton, profileImageView, segmentCollectionView
        ].forEach { mainPosterView.addSubview($0) }
    }
    
    
    // MARK: - setUpConstraint()
    
    private func setUpConstraint() {
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        contentView.snp.makeConstraints {
            $0.edges.width.equalToSuperview()
        }
        
        mainPosterView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(520)
        }
        
        logoImageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(58)
            $0.leading.equalToSuperview().offset(11)
            $0.width.equalTo(100)
            $0.height.equalTo(25)
        }
        
        profileImageView.snp.makeConstraints {
            $0.centerY.equalTo(logoImageView)
            $0.trailing.equalToSuperview().inset(11)
            $0.width.height.equalTo(26)
        }
        
        mirroringButton.snp.makeConstraints {
            $0.centerY.equalTo(logoImageView)
            $0.leading.equalTo(logoImageView.snp.trailing).offset(186)
        }
        
        segmentCollectionView.snp.makeConstraints {
            $0.top.equalTo(logoImageView.snp.bottom).offset(15)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(30)
        }
        
        contentLabel.snp.makeConstraints {
            $0.top.equalTo(mainPosterView.snp.bottom).offset(43)
            $0.leading.equalToSuperview().offset(16)
        }
        
        moreContentButton.snp.makeConstraints {
            $0.centerY.equalTo(contentLabel)
            $0.trailing.equalToSuperview().inset(16)
        }
        
        contentCollectionView.snp.makeConstraints {
            $0.top.equalTo(contentLabel.snp.bottom).offset(13)
            $0.leading.equalTo(contentLabel)
            $0.trailing.equalToSuperview()
            $0.height.equalTo(166)
        }
        
        channelLabel.snp.makeConstraints {
            $0.top.equalTo(contentCollectionView.snp.bottom).offset(20)
            $0.leading.equalTo(contentLabel)
        }
        
        moreChannelButton.snp.makeConstraints {
            $0.centerY.equalTo(channelLabel)
            $0.trailing.equalTo(moreContentButton.snp.trailing)
        }
        
        channelCollectionView.snp.makeConstraints {
            $0.top.equalTo(channelLabel.snp.bottom).offset(13)
            $0.leading.equalTo(channelLabel)
            $0.trailing.equalToSuperview()
            $0.height.equalTo(166)
        }
        
        seriesLabel.snp.makeConstraints {
            $0.top.equalTo(channelCollectionView.snp.bottom).offset(18)
            $0.leading.equalTo(contentLabel)
        }
        
        moreSeriesButton.snp.makeConstraints {
            $0.centerY.equalTo(seriesLabel)
            $0.trailing.equalTo(moreContentButton.snp.trailing)
        }
        
        seriesCollectionView.snp.makeConstraints {
            $0.top.equalTo(seriesLabel.snp.bottom).offset(13)
            $0.leading.equalTo(seriesLabel)
            $0.trailing.equalToSuperview()
            $0.height.equalTo(166)
        }
        
        firstAdImageView.snp.makeConstraints {
            $0.top.equalTo(seriesCollectionView.snp.bottom).offset(50)
            $0.leading.equalToSuperview()
            $0.height.equalTo(58)
            $0.width.equalTo(view.frame.width / 2)
        }
        
        secondAdImageView.snp.makeConstraints {
            $0.top.height.width.equalTo(firstAdImageView)
            $0.trailing.equalToSuperview()
        }
        
        movieLabel.snp.makeConstraints {
            $0.top.equalTo(firstAdImageView.snp.bottom).offset(50)
            $0.leading.equalTo(contentLabel)
        }
        
        moreMovieButton.snp.makeConstraints {
            $0.centerY.equalTo(movieLabel)
            $0.trailing.equalTo(moreContentButton.snp.trailing)
        }
        
        movieCollectionView.snp.makeConstraints {
            $0.top.equalTo(movieLabel.snp.bottom).offset(18)
            $0.leading.equalTo(movieLabel)
            $0.trailing.equalToSuperview()
            $0.height.equalTo(166)
            $0.bottom.equalToSuperview().inset(20)
        }
    }
    
    
    // MARK: - setUpDelegate()
    
    private func setUpDelegate() {
        [
            segmentCollectionView, contentCollectionView, channelCollectionView, seriesCollectionView, movieCollectionView
        ].forEach {
            $0.delegate = self
            $0.dataSource = self
        }
    }
}


// MARK: - Extension

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mainViewModel.countCollectionView(collectionView)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return mainViewModel.bindCollectionViewData(collectionView, indexPath)
    }
}
