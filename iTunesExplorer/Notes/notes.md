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
  - [O] piste pour le pb de swiftPackage import swiftUI   
  ce [link](https://www.appsloveworld.com/swift/100/75/cannot-find-swiftui-or-combine-types-when-building-swift-package-for-any-ios-dev) puis link vers [reddit](https://www.reddit.com/r/SwiftUI/comments/l5mt0b/cannot_build_for_any_ios_device_arm64_as_doesnt/?rdt=44959) **=> pas mieux !**
  - [ ] si ok, exporter la doc et [heberger avec github](https://apple.github.io/swift-docc-plugin/documentation/swiftdoccplugin/publishing-to-github-pages/)
- **`@42`**
  - [X] Faire la 1ere page getting started nickel
  - [ ] Faire un sommaire/topic (voir vidéo apple doc)
  - [ ] Voir vidéo apple doc pour exporter la docC vers github

<br/>

# **iTunesExplorer**

**@Home**

  1. [X] explo.state == .notSearchedYet => StarExplo + logoapp icon `a continuer`
  2. [X] simplifier le exploView > Button > if canClear { }
  3. [X] bug image fetch infini si on swap avec le segmented control
  3. [X] XCTest avant de passer a comnine pour comparer ?

  1. [X] TODO ExplorerView voir si peur refract utilisant viewbuilder (cf lien)
  2. [ ] TODO utiliser enum pour gérer plus clairement les etats du star button

- [ ] TODO utiliser enum pour gérer plus clairement les etats du star button
- [ ] link mon compte firefox -> sur mon windows + mac
- [X] faire image 1000x500px logo + nom ItunesExplorer  pour le readme **-> chounky**
1. [ ] clean la partie combine > **WIP cleaning** + Issue => on a plus la possibilité de cancel si on spam le segmented control par exemple
    -  video wwdc19 combine in pratice 5min10  
    -  [switthinkusefull video](https://www.youtube.com/watch?v=fdxFp5vU6MQ) + screens dans ./ressources  
2. [ ] Virer la dependency pour tap gesture des record simulator  
Tester d'utiliser : `defaults write com.apple.iphonesimulator ShowSingleTouches 1`

3. [ ] Prendre des screens de l'UI actuelle (section rework UI du readme)

4. [ ] Branche reworkUI + lister/hierarchiser les etapes a effectuer

- [ ] faire un *Unit Test_`ok`* + un UItest !



**`@42`**

  1. [ ] check si je peux chercher des solutions sur les "TO DO" en cours
  2. [ ] combine rework and cleaning -> comment ajouter la possibilité cancellable comme avant
    [checkCancellation / cancellable article medium](https://medium.com/appgrid/handling-cancellation-in-combine-swift-with-example-1bc3ec42a163)
  2. [X] essayer de voir ce que je peux faire pour tester perform explo
  
&emsp; **Parties `"highlighted"` à ajouter au readme :**  

- [X] Xctest
- [X] Combine (une fois implementé) (revoir les titres fetch machin)
- [X] SwiftPackage Manager
- [X] Faire sommaire
- [ ] Une fois UI a jour faire une section rework uI dans le readme
- [ ] Autres ? (une fois un UITest fait ? ou truc qui sort du lot)

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
