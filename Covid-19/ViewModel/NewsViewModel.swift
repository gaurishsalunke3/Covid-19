//
//  NewsViewModel.swift
//  Covid-19
//
//  Created by Gaurish Salunke on 4/15/20.
//  Copyright © 2020 Gaurish Salunke. All rights reserved.
//

import SwiftUI
import Combine

class NewsViewModel: ObservableObject {
    var didChage = PassthroughSubject<NewsViewModel, Never>()
    
    @Published var notifications: [Notification]? {
        didSet {
            self.didChage.send(self)
        }
    }
    
    init() {
        
    }
    
    func getNotifications() {
        let urlString = "https://api.rootnet.in/covid19-in/notifications"
        WebService().getRequest(from: urlString) { (result: Result<NotificationResponse, NetworkError>) in
            switch result {
            case .success(let response):
                self.notifications = response.data

            case .failure(let error):
                print(error.localizedDescription)
            }
        }

//        self.notifications = Notification.getSampleData()
        
    }
}

struct NewsViewModel_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
