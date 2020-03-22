import Foundation
import Publish
import Plot

// This type acts as the configuration for your website.
struct PersonalWebsite: Website {
    enum SectionID: String, WebsiteSectionID {
        // Add the sections that you want your website to contain here:
        case about
        case portfolio
        case blog
    }

    struct ItemMetadata: WebsiteItemMetadata {
        var excerpt: String
        // Add any site-specific metadata that you want to use here.
//        var ingredients: [String]
//        var preparationTime: TimeInterval
    }

    // Update these properties to configure your website:
    var url = URL(string: "cyndichin.github.io")!
    var name = "Cyndi Chin"
    var description = "Let's connect!"
    var language: Language { .english }
    var imagePath: Path? { "/images/logo.png"  }
    var socialMediaLinks: [SocialMediaLink] { [.email, .linkedIn, .github] }
}

// This will generate your website using the built-in Foundation theme:
//try PersonalWebsite().publish(
//    withTheme: .mystic
////    additionalSteps: [.deploy(using: .gitHub("cyndichin.github.io"))],
////    plugins: [.splash(withClassPrefix: "")]
//)


try PersonalWebsite().publish(
    using: [
    .addMarkdownFiles(),
    .copyResources(),
    .generateHTML(withTheme: .mystic),
    .generateRSSFeed(including: [.blog]),
    .generateSiteMap()
    ])
    
    
