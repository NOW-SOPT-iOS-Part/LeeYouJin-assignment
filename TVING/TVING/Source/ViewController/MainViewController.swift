//
//  MainViewController.swift
//  TVING
//
//  Created by YOUJIM on 4/24/24.
//

import UIKit

class MainViewController: UIViewController {
    
    let contentDummy = Content.dummy()
    let channelDummy = Channel.dummy()
    
    // MARK: - Component
    
    final private let scrollView = UIScrollView().then {
        $0.backgroundColor = .black
    }
    
    final private let contentView = UIView()
    
    final private let logoImageView: UIImageView = UIImageView().then {
        $0.image = .mainLogo
        $0.contentMode = .scaleAspectFit
    }
    
    final private let mirroringButton: UIButton = UIButton().then {
        $0.setImage(.icMirroring, for: .normal)
    }
    
    final private let profileImageView: UIImageView = UIImageView().then {
        $0.image = .basicProfile
        $0.contentMode = .scaleToFill
    }
    
    final private lazy var mainSegmentedControl: MainSegmentedControl = MainSegmentedControl(frame: .zero).then {
        $0.addTarget(self, action: #selector(didSegmentedControlChanged), for: .valueChanged)
    }
    
    final private lazy var stickyMainSegmentedControl: MainSegmentedControl = MainSegmentedControl(frame: .zero).then {
        $0.isHidden = true
        $0.addTarget(self, action: #selector(didSegmentedControlChanged), for: .valueChanged)
    }
    
    final private let mainPosterView: UIImageView = UIImageView().then {
        $0.image = .mainPoster
        $0.contentMode = .scaleAspectFill
    }
    
    final private let contentLabel: UILabel = UILabel().then {
        $0.font = UIFont.font(.applegothicSemibold, ofSize: 15)
        $0.textColor = .white
        $0.text = "티빙에서 꼭 봐야하는 컨텐츠"
    }
    
    final private lazy var moreContentButton: UIButton = UIButton().then {
        $0.setTitle("전체보기", for: .normal)
        $0.setImage(UIImage(systemName: "chevron.right"), for: .normal)
        $0.tintColor = .white
        $0.setTitleColor(UIColor(hexCode: "9C9C9C"), for: .normal)
        $0.titleLabel?.font = UIFont.font(.pretendardMedium, ofSize: 11)
        $0.setPreferredSymbolConfiguration(.init(scale: .small), forImageIn: .normal)
        $0.semanticContentAttribute = .forceRightToLeft
    }
    
    final private lazy var contentCollectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout().then {
        $0.scrollDirection = .horizontal
        $0.minimumLineSpacing = 10
        $0.minimumInteritemSpacing = 10
    }).then {
        $0.backgroundColor = .clear
        $0.showsHorizontalScrollIndicator = false
        $0.register(ContentCollectionViewCell.self, forCellWithReuseIdentifier: ContentCollectionViewCell.cellID)
    }
    
    final private let channelLabel: UILabel = UILabel().then {
        $0.font = UIFont.font(.applegothicSemibold, ofSize: 15)
        $0.textColor = .white
        $0.text = "인기 LIVE 채널"
    }
    
    final private lazy var moreChannelButton: UIButton = UIButton().then {
        $0.setTitle("전체보기", for: .normal)
        $0.tintColor = .white
        $0.setTitleColor(UIColor(hexCode: "9C9C9C"), for: .normal)
        $0.titleLabel?.font = UIFont.font(.pretendardMedium, ofSize: 11)
        $0.setImage(UIImage(systemName: "chevron.right"), for: .normal)
        $0.setPreferredSymbolConfiguration(.init(scale: .small), forImageIn: .normal)
        $0.semanticContentAttribute = .forceRightToLeft
    }
    
    final private lazy var channelCollectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout().then {
        $0.scrollDirection = .horizontal
        $0.minimumLineSpacing = 10
        $0.minimumInteritemSpacing = 10
    }).then {
        $0.backgroundColor = .clear
        $0.showsHorizontalScrollIndicator = false
        $0.register(ChannelCollectionViewCell.self, forCellWithReuseIdentifier: ChannelCollectionViewCell.cellID)
    }
    
    final private let seriesLabel: UILabel = UILabel().then {
        $0.font = UIFont.font(.applegothicSemibold, ofSize: 15)
        $0.textColor = .white
        $0.text = "1화 무료! 파라마운트+ 인기 시리즈"
    }
    
    final private lazy var moreSeriesButton: UIButton = UIButton().then {
        $0.setTitle("전체보기", for: .normal)
        $0.tintColor = .white
        $0.setTitleColor(UIColor(hexCode: "9C9C9C"), for: .normal)
        $0.titleLabel?.font = UIFont.font(.pretendardMedium, ofSize: 11)
        $0.setImage(UIImage(systemName: "chevron.right"), for: .normal)
        $0.setPreferredSymbolConfiguration(.init(scale: .small), forImageIn: .normal)
        $0.semanticContentAttribute = .forceRightToLeft
    }
    
    final private lazy var seriesCollectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout().then {
        $0.scrollDirection = .horizontal
        $0.minimumLineSpacing = 10
        $0.minimumInteritemSpacing = 10
    }).then {
        $0.backgroundColor = .clear
        $0.showsHorizontalScrollIndicator = false
        $0.register(ContentCollectionViewCell.self, forCellWithReuseIdentifier: ContentCollectionViewCell.cellID)
    }
    
    final private let firstAdImageView: UIImageView = UIImageView().then {
        $0.image = .firstAD
        $0.contentMode = .scaleAspectFill
    }
    
    final private let secondAdImageView: UIImageView = UIImageView().then {
        $0.image = .secondAD
        $0.contentMode = .scaleAspectFill
    }
    
    final private let movieLabel: UILabel = UILabel().then {
        $0.font = UIFont.font(.applegothicSemibold, ofSize: 15)
        $0.textColor = .white
        $0.text = "티빙에서 꼭 봐야하는 컨텐츠"
    }
    
    final private lazy var moreMovieButton: UIButton = UIButton().then {
        $0.setTitle("전체보기", for: .normal)
        $0.tintColor = .white
        $0.setTitleColor(UIColor(hexCode: "9C9C9C"), for: .normal)
        $0.titleLabel?.font = UIFont.font(.pretendardMedium, ofSize: 11)
        $0.setImage(UIImage(systemName: "chevron.right"), for: .normal)
        $0.setPreferredSymbolConfiguration(.init(scale: .small), forImageIn: .normal)
        $0.semanticContentAttribute = .forceRightToLeft
    }
    
    final private lazy var movieCollectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout().then {
        $0.scrollDirection = .horizontal
        $0.minimumLineSpacing = 10
        $0.minimumInteritemSpacing = 10
    }).then {
        $0.backgroundColor = .clear
        $0.showsHorizontalScrollIndicator = false
        $0.register(ContentCollectionViewCell.self, forCellWithReuseIdentifier: ContentCollectionViewCell.cellID)
    }

    
    // MARK: - ViewDidLoad()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpLayout()
        setUpConstraint()
        setUpDelegate()
    }
    
    
    // MARK: - setUpLayout()
    
    final private func setUpLayout() {
        view.backgroundColor = .white
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        [
            mainPosterView, contentLabel, moreContentButton, contentCollectionView, channelLabel,
            moreChannelButton, channelCollectionView, seriesLabel, moreSeriesButton, seriesCollectionView,
            firstAdImageView, secondAdImageView, movieLabel, moreMovieButton, movieCollectionView
        ].forEach { contentView.addSubview($0) }
        [
            logoImageView, mirroringButton, profileImageView, mainSegmentedControl
        ].forEach { mainPosterView.addSubview($0) }
        view.addSubview(stickyMainSegmentedControl)
    }
    
    
    // MARK: - setUpConstraint()
    
    final private func setUpConstraint() {
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
        
        mainSegmentedControl.snp.makeConstraints {
            $0.top.equalTo(logoImageView.snp.bottom).offset(15)
            $0.leading.trailing.equalToSuperview()
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
            $0.height.equalTo(160)
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
    
    final private func setUpDelegate() {
        [
            contentCollectionView, channelCollectionView, seriesCollectionView, movieCollectionView
        ].forEach {
            $0.delegate = self
            $0.dataSource = self
        }
    }
    
    
    // MARK: - Function
    
    @objc
    private func didSegmentedControlChanged() {
        
    }
}


// MARK: - Extension

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == channelCollectionView { return channelDummy.count }
        return contentDummy.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let contentCell = collectionView.dequeueReusableCell(withReuseIdentifier: ContentCollectionViewCell.cellID, for: indexPath) as? ContentCollectionViewCell
        
        if collectionView == channelCollectionView {
            let channelCell = (collectionView.dequeueReusableCell(withReuseIdentifier: ChannelCollectionViewCell.cellID, for: indexPath) as? ChannelCollectionViewCell)!
            
            channelCell.channelImageView.image = channelDummy[indexPath.row].image
            channelCell.channelLabel.text = channelDummy[indexPath.row].channel
            channelCell.contentLabel.text = channelDummy[indexPath.row].content
            channelCell.rankLabel.text = channelDummy[indexPath.row].rank
            channelCell.ratingLabel.text = channelDummy[indexPath.row].rating
            
            return channelCell
        }
        
        contentCell?.contentImageView.image = contentDummy[indexPath.row].image
        contentCell?.contentLabel.text = contentDummy[indexPath.row].name
        
        return contentCell!
    }
    
    /// 셀 별 사이즈 지정
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == channelCollectionView {
            return CGSize(width: 169, height: collectionView.frame.height)
        }
        return CGSize(width: 98, height: collectionView.frame.height)
    }
}
