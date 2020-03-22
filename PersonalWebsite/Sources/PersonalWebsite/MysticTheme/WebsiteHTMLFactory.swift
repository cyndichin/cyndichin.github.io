//
//  BlogHTMLFactory.swift
//
//
//  Created by cynber on 2/24/20.
//

import Publish
import Plot
import Foundation

import Publish
import Plot

struct WebsiteHTMLFactory: HTMLFactory {
    private static var sections: [PersonalWebsite.SectionID] { PersonalWebsite.SectionID.allCases }
    func makeIndexHTML(for index: Index, context: PublishingContext<PersonalWebsite>) throws -> HTML {
        HTML(
            .lang(context.site.language),
            .head(for: context.site),
            .body(
                .grid(
                    .sidebar(for: context.site),
                    .posts(
                        for: context.allItems(
                            sortedBy: \.date,
                            order: .descending
                        ),
                        on: context.site,
                        title: "Recent posts"
                    ),
                    .footer(for: context.site)
                )
            )
        )
    }
    
    func makeSectionHTML(for section: Section<PersonalWebsite>, context: PublishingContext<PersonalWebsite>) throws -> HTML {
        var htmlOutput: HTML
        switch section.id {
        case .about:
            htmlOutput = HTML(
                .lang(context.site.language),
                .head(for: context.site),
                .body(
                    .grid(
                        .sidebar(for: context.site),
                        .pageContent(.h1(.text(section.title))),
                        .footer(for: context.site)
                    )
                )
            )
        default:
            htmlOutput = HTML()
            break
    }
        return htmlOutput
    }
    
    
    
    func makeItemHTML(for item: Item<PersonalWebsite>, context: PublishingContext<PersonalWebsite>) throws -> HTML {
//        HTML(
//            .lang(context.site.language),
//            .head(for: context.site),
//            .body(
//                .grid(
//                    .sidebar(for: context.site),
//                    .post(for: item, on: context.site),
//                    .footer(for: context.site)
//                )
//
//            )
//        )
        return HTML()
    }
    
    func makePageHTML(for page: Page, context: PublishingContext<PersonalWebsite>) throws -> HTML {
        print("PAGE \(page.title)")
        var htmlOutput: HTML = HTML()
        switch page.title {
        case "about":
            htmlOutput = HTML(
                .lang(context.site.language),
                .head(for: context.site),
                .body(
                    .grid(
                        .sidebar(for: context.site),
                        .page(for: page, on: context.site),
                        .footer(for: context.site)
                    )
                )
            )
        case "portfolio":
            htmlOutput = HTML(
                .lang(context.site.language),
                .head(for: context.site),
                .body(
                    .grid(
                        .sidebar(for: context.site),
                        .page(for: page, on: context.site),
                        .footer(for: context.site)
                    )
                )
            )
        case "blog":
            htmlOutput = HTML(
                .lang(context.site.language),
                .head(for: context.site),
                .body(
                    .grid(
                        .sidebar(for: context.site),
                        .posts(
                            for: context.allItems(
                                sortedBy: \.date,
                                order: .descending
                            ),
                            on: context.site,
                            title: "Recent posts"
                        ),
                        .footer(for: context.site)
                    )
                )
            )
        default:
            break
        }
        return htmlOutput
    }
    
    func makeTagListHTML(for page: TagListPage, context: PublishingContext<PersonalWebsite>) throws -> HTML? {
        HTML(
            .lang(context.site.language),
            .head(for: context.site),
            .body(
                .grid(
                    .sidebar(for: context.site),
                    .pageContent(
                        .tagList(for: page, on: context.site)
                    ),
                    .footer(for: context.site)
                )
            )
        )
    }
    
    func makeTagDetailsHTML(for page: TagDetailsPage, context: PublishingContext<PersonalWebsite>) throws -> HTML? {
        HTML(
            .lang(context.site.language),
            .head(for: context.site),
            .body(
                .grid(
                    .sidebar(for: context.site),
                    .posts(
                        for: context.items(
                            taggedWith: page.tag,
                            sortedBy: \.date,
                            order: .descending
                        ),
                        on: context.site,
                        title: "\(page.tag.string.capitalized) posts"
                    ),
                    .footer(for: context.site)
                )
            )
        )
    }
}
