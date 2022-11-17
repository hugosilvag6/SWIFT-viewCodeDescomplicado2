//
//  HomeScreen.swift
//  backfront2 - messenger
//
//  Created by Hugo Silva on 15/11/22.
//

import UIKit

class HomeScreen: UIView {
   
   lazy var navView: NavView = {
      let view = NavView()
      view.translatesAutoresizingMaskIntoConstraints = false
      return view
   }()
   
   lazy var collectionView: UICollectionView = {
      let cv = UICollectionView(frame: CGRect.zero, collectionViewLayout: .init())
      cv.translatesAutoresizingMaskIntoConstraints = false
      cv.showsVerticalScrollIndicator = false
      cv.backgroundColor = .clear
      cv.delaysContentTouches = false
      cv.register(LastMessageCollectionViewCell.self, forCellWithReuseIdentifier: LastMessageCollectionViewCell.identifier)
      cv.register(MessageDetailCollectionViewCell.self, forCellWithReuseIdentifier: MessageDetailCollectionViewCell.identifier)
      // o layout serve pra falar se é horizontal ou vertical
      let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout.init()
      layout.scrollDirection = .vertical
      cv.setCollectionViewLayout(layout, animated: false)
      return cv
   }()
   
   
   
   override init(frame: CGRect) {
      super.init(frame: frame)
      self.addViews()
      self.addConstraints()
   }
   required init?(coder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
   }
   
}

extension HomeScreen {
   public func collectionViewDelegate (delegate: UICollectionViewDelegate, dataSource: UICollectionViewDataSource) {
      self.collectionView.delegate = delegate
      self.collectionView.dataSource = dataSource
   }
   public func reloadCollectionView () {
      self.collectionView.reloadData()
   }
}

extension HomeScreen {
   private func addViews() {
      self.addSubview(navView)
      self.addSubview(collectionView)
   }
   private func addConstraints() {
      NSLayoutConstraint.activate([
         navView.topAnchor.constraint(equalTo: self.topAnchor),
         navView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
         navView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
         navView.heightAnchor.constraint(equalToConstant: 140),
         
         collectionView.topAnchor.constraint(equalTo: self.navView.bottomAnchor),
         collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
         collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
         collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
      ])
   }
}
