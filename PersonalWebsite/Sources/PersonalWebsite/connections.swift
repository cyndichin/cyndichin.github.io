//
//  File.swift
//  
//
//  Created by cynber on 2/10/20.
//

import Foundation

struct SocialMediaLink {
    let title: String
    let url: String
    let icon: String
}

extension SocialMediaLink {

    static var linkedIn: SocialMediaLink {
        return SocialMediaLink(
            title: "LinkedIn",
            url: "https://www.linkedin.com/in/cyndichin",
            icon: "fab fa-linkedin-in"
        )
    }
    
    static var email: SocialMediaLink {
        return SocialMediaLink(
            title: "Email",
            url: "mailto:cyndi.chin8@gmail.com",
            icon: "fas fa-paper-plane"
        )
    }
    
    static var github: SocialMediaLink {
        return SocialMediaLink(
            title: "GitHub",
            url: "https://github.com/cyndichin",
            icon: "fab fa-github-alt"
        )
    }
}
