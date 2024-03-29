# Fetching data with combine

## Méthode simple

cet article [fetch remote data using Combine](https://cedricbahirwe.hashnode.dev/fetch-remote-data-using-combine) bon point de départ  
voir [Processing URL session data task results with Combine](https://developer.apple.com/documentation/foundation/urlsession/processing_url_session_data_task_results_with_combine) article Apple Doc

## Méthode avancée

Network Kit utilisant generic + 3 methodes pour fetch (combine + closure + async/await) + placer le tout en library pour Swift package manager 👍 overkill mais interessant+pedago a mettre en place !
[ici](https://sabapathy7.medium.com/how-to-create-a-network-layer-for-your-ios-app-623f99161677)

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
<br/>
<br/>
<br/>
<br/>








---
---
---






<br/>
<br/>
<br/>
<br/>
<br/>





# **iTunesExplorer**

## **@Home**

  1. [X] explo.state == .notSearchedYet => StarExplo + logoapp icon `a continuer`
  2. [X] simplifier le exploView > Button > if canClear { }
  3. [X] bug image fetch infini si on swap avec le segmented control
  3. [X] XCTest avant de passer a comnine pour comparer ?

  1. [X] TODO ExplorerView voir si peur refract utilisant viewbuilder (cf lien)
  2. [ ] TODO utiliser enum pour gérer plus clairement les etats du star button

- [ ] link mon compte firefox -> sur mon windows + mac
- [X] faire image 1000x500px logo + nom ItunesExplorer  pour le readme **-> chounky**
1. [ ] clean la partie combine > **WIP cleaning** + Issue => on a plus la possibilité de cancel si on spam le segmented control par exemple
    -  video wwdc19 combine in pratice 5min10  
    -  [switthinkusefull video](https://www.youtube.com/watch?v=fdxFp5vU6MQ) + screens dans ./ressources  
2. [X] Si besoin de record les tapGesture tester : `defaults write com.apple.iphonesimulator ShowSingleTouches 1`

3. [X] Prendre des screens de l'UI actuelle (section rework UI du readme)

4. [ ] Branche reworkUI + lister/hierarchiser les etapes a effectuer
	1. [X] searchBar 1 element avec loupe + micro dedans + 2 boutons au desssus
	2. [X] Boutton dessus back (back) + (filtre) showCategory(doit faire apparaitre/enlever le seg control)
	3. [X] La zone de tap gesture d'une row c'est toute la row 
	4. [ ] rendre le bouton moicro reelement fonctionnel
	5. [X] changer le style de l'étoile avec SFSymbol location.north.fill

- [ ] faire un *Unit Test_`ok`* + un UItest !



## **`@42`**

  1. [X] check si je peux chercher des solutions sur les "TO DO" en cours
    . animation verticale lors du pop / depop du segmented control

    ```
    // tester
    .transition(.asymmetric(insertion: .move(edge: .bottom), removal: .move(edge: .top)))
    ```
  2. [ ] combine rework and cleaning -> comment ajouter la possibilité cancellable comme avant
    [checkCancellation / cancellable article medium](https://medium.com/appgrid/handling-cancellation-in-combine-swift-with-example-1bc3ec42a163)


 
 ```swift
 // tester ceci :
 .handleEvents(receiveCancel: {
                print("Synced objects: CANCELED!")
            })
 ```

 ```swift
 // ici il y a peut etre ce qui me manquait pour stocker le publisher afin de l'annuler
 import Combine

class DataFetcher {
    var cancellable: AnyCancellable?

    func fetchData() -> AnyPublisher<Data, Error> {
        // Annuler l'appel précédent s'il existe
        cancellable?.cancel()

        let url = URL(string: "https://example.com/data")!
        let publisher = URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .eraseToAnyPublisher()

        // Stocker la souscription dans la propriété cancellable
        cancellable = publisher.sink(receiveCompletion: { _ in
            // Réinitialiser cancellable après que la tâche est terminée (complétée ou échouée)
            self.cancellable = nil
        }, receiveValue: { _ in })

        return publisher
    }
}
/*
Dans ce code, nous avons ajouté une étape pour initialiser la propriété cancellable avec la souscription retournée par sink. sink est utilisé pour consommer les valeurs émises par le publisher et gérer la fin de la tâche (complétée ou échouée). Après que la tâche est terminée, nous réinitialisons la propriété cancellable à nil, ce qui permet de libérer la mémoire de la souscription précédente.

Ainsi, maintenant, chaque fois que vous appelez fetchData, l'appel précédent est annulé et une nouvelle souscription est créée, assurant qu'un seul appel de fetchData est actif à la fois.*/
```

> *[article medium ou le publisher est return aussi](https://medium.com/@ganeshrajugalla/swiftui-async-await-escaping-combine-60f4b847520c)* 

  2. [X] essayer de voir ce que je peux faire pour tester perform explo
  
&emsp; **Parties `"highlighted"` à ajouter au readme :**  

- [X] Xctest
- [X] Combine (une fois implementé) (revoir les titres fetch machin)
- [X] SwiftPackage Manager
- [X] Faire sommaire
- [ ] Une fois UI a jour faire une section rework uI dans le readme
- [ ] Autres ? (une fois un UITest fait ? ou truc qui sort du lot)


