//
//  Mocks.swift
//  CompositionalDiffableDemo
//
//  Created by thoonk on 2024/05/13.
//

import Foundation

enum Mocks {
    static let features: AppSectionItem =
        .feature([
            .init(type: "지금 이용 가능", title: "디즈니+", description: "닥터 후"),
            .init(type: "지금 이용 가능", title: "Wavve", description: "돌싱글즈5"),
            .init(type: "오늘 밤 22:30", title: "Wavve", description: "함부로 대해줘"),
            .init(type: "지금 이용 가능", title: "티빙", description: "졸업"),
            .init(type: "현재 진행 중", title: "듀오링고", description: "가족과 함께 언어를 배워보세요")
        ])
    
    static let rankingFeatures: AppSectionItem =
        .rankingFeature([
            .init(title: "Temu: 억만장자처럼 쇼핑하기", description: "어디서나 무료 배송!", isInAppPurchase: false),
            .init(title: "TikTok Lite", description: "다채로운 즐거움 틱톡 라이트", isInAppPurchase: true),
            .init(title: "GC 오토마우스", description: "생산성", isInAppPurchase: true),
            .init(title: "오토클릭 - 오토매틱 클리커 (Auto Clicker)", description: "오토마우스, 자동터치, 오토클릭", isInAppPurchase: true),
            .init(title: "삼쩜삼 - 세금 신고/환급 도우미", description: "잠자고 있는 내 세금 얼마일까?", isInAppPurchase: false),
            .init(title: "배달요기요 - 기다림 없는 맛집 배달앱", description: "매일매일 할인 받는 배달앱", isInAppPurchase: false)
        ])
    
//    static let themeFeatures: AppSectionItem =
//        .themeFeature([
//            .init(title: "필수 금융 앱 10"),
//            .init(title: "필수 생산성 앱 10"),
//            .init(title: "필수 엔터테인먼트 앱 10"),
//            .init(title: "필수 사진 앱 10"),
//            .init(title: "필수 마음챙김 앱 10")
//        ])
}
