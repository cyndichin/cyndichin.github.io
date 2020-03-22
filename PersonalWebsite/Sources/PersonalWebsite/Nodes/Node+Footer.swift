//
//  Node+Footer.swift
//  
//
//  Created by Povilas Staskus on 1/26/20.
//

import Plot

extension Node where Context == HTML.BodyContext {
    static func footer(for site: PersonalWebsite) -> Node {
        return .div(
            .class("footer pure-u-1"),
            .div(
                .text("© 2019 \(site.name). Written in Swift. Generated using "),
                .a(
                    .text("Publish"),
                    .href("https://github.com/johnsundell/publish")
                )
            ),
            .div(
                .a(
                    .text("RSS feed"),
                    .href("/feed.rss")
                )
            )
        )
    }
}
