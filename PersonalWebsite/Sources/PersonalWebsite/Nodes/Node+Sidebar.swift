//
//  Node+Sidebar.swift
//  
//
//  Created by Povilas Staskus on 1/26/20.
//

import Plot

extension Node where Context == HTML.BodyContext {
    private static var sections: [PersonalWebsite.SectionID] { PersonalWebsite.SectionID.allCases }
    static func sidebar(for site: PersonalWebsite) -> Node {
        return .div(
            .class("sidebar pure-u-1 pure-u-md-1-4"),
            .div(
                .class("header"),
                .grid(
                    .div(
                        .class("brand-section pure-u-md-1-1 pure-u-3-4"),
                        .h1(
                            .class("brand-title"),
                            .text(site.name)
                        )
                    )
                ),
                .grid(
                        .div(
                            .class("menu-section pure-u-md-1-1 pure-u-3-4"),
                                .nav(
                                .ul(
                                    .class("menu-list pure-menu-list"),
                                    .forEach(sections, { section in
                                        .li(
                                            .class("mystic-menu-list pure-menu-item"),
                                            .a(
                                                .class("section-headers"),
                                                .text(section.rawValue.capitalized),
                                                .href(site.path(for: section))
                                            )
                                        )
                                    })
                                ))
                        )
                ),
                .grid(
                    .div (
                        .class("additional-text"),
                        .text(site.description)
                    ),
                     .div(
                       .forEach(site.socialMediaLinks, { link in
                           .div(
                                .class("pure-u-md-1-1"),
                               .a(
                                   .href(link.url),
                                   .icon(link.icon),
                                   .a(
                                       .class("social-media"),
                                       .href(link.url),
                                       .text(link.title)
                                   )
                               )
                           )
                       })
                   )
                )
            )
        )
    }}

    
