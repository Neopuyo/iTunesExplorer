# Fetching data with combine

## Méthode simple

cet article [fetch remote data using Combine](https://cedricbahirwe.hashnode.dev/fetch-remote-data-using-combine) bon point de départ  
voir [Processing URL session data task results with Combine](https://developer.apple.com/documentation/foundation/urlsession/processing_url_session_data_task_results_with_combine) article Apple Doc

## Méthode avancée

Network Kit utilisant generic + 3 methodes pour fetch (combine + closure + async/await) + placer le tout en library pour Swift package manager 👍 overkill mais interessant+pedago a mettre en place !
[ici](https://sabapathy7.medium.com/how-to-create-a-network-layer-for-your-ios-app-623f99161677)

<br/>

# **NeopuyoLib**

- **@Home**
  - [X] créer de la Doc avec DocC -> Ok ça fonctionne
  - [ ] piste pour le pb de swiftPackage import swiftUI   
  ce [link](https://www.appsloveworld.com/swift/100/75/cannot-find-swiftui-or-combine-types-when-building-swift-package-for-any-ios-dev) puis link vers [reddit](https://www.reddit.com/r/SwiftUI/comments/l5mt0b/cannot_build_for_any_ios_device_arm64_as_doesnt/?rdt=44959)

  ```swift
  #if canImport(SwiftUI) && (!os(iOS) || arch(arm64))
  
  import SwiftUI

  // []...]

  #endif
  ```

  - [ ] si ok, exporter la doc et [heberger avec github](https://apple.github.io/swift-docc-plugin/documentation/swiftdoccplugin/publishing-to-github-pages/)
- **`@42`**
  - [ ] Faire la 1ere page getting started nickel
  - [ ] Faire un sommaire/topic (voir vidéo apple doc)
  - [ ] Voir vidéo apple doc pour exporter la docC vers github

<br/>

# **iTunesExplorer**

**@Home**

  1. [X] explo.state == .notSearchedYet => StarExplo + logoapp icon `a continuer`
  2. [X] simplifier le exploView > Button > if canClear { }
  3. [ ] bug image fetch infini si on swap avec le segmented control

- [ ] **Git branch** integrer combine maintenant
- [ ] retester des fetch
- [ ] Une fois le fetch ok -> affichage de la list des results + segmented controls pour category
- [ ] Ajouter une page d'intro / un bouton avant d'afficher la searchbar avec une animation sympa comme [ceci](https://www.hackingwithswift.com/quick-start/swiftui/how-to-dynamically-adjust-the-appearance-of-a-view-based-on-its-size-and-location)
- [ ] faire un Unit Test + un UItest !

**`@42`**

  1. [ ] check si je peux chercher des solutions sur les "TO DO" en cours

<br/>

# **Jobbing & Tech'up**

**@Home**  

- [ ] 

**`@42`**  

- [ ] Readme du projet itunesExplorer -> public -> screens + gif
- [ ] continuer de revoir **sample App d'apple** (>seismonester..)
- [ ] Xcode doc apple -> testable (continuer voir dans Jobiview)
- [ ] continuer de voir le truc sur testView dans la partie jobiview structural pattern
- [ ] Extraire puis passer une partie de jobiView en repo public ?

<br/>

## SwiftUI

- [Kodeco cookbook](https://www.kodeco.com/books/swiftui-cookbook)

### **iTunesExplorer+**

- étudier si `AsyncSequence` pourrait aider avec le fetch
``