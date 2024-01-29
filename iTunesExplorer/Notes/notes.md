# Fetching data with combine

## Méthode simple

cet article [fetch remote data using Combine](https://cedricbahirwe.hashnode.dev/fetch-remote-data-using-combine) bon point de départ  
voir [Processing URL session data task results with Combine](https://developer.apple.com/documentation/foundation/urlsession/processing_url_session_data_task_results_with_combine) article Apple Doc

## Méthode avancée

Network Kit utilisant generic + 3 methodes pour fetch (combine + closure + async/await) + placer le tout en library pour Swift package manager 👍 overkill mais interessant+pedago a mettre en place !
[ici](https://sabapathy7.medium.com/how-to-create-a-network-layer-for-your-ios-app-623f99161677)

---

## Strategie (at home)

### **Neopuyo personnal Library**

- [ ] créer de la Doc avec DocC -> tester up la version dans manifest. Sinon tant pis faire une doc peu custom
- [ ] Retester avec version +up dans le manifest + nommer l'article [`GettingStarted.md`](https://developer.apple.com/documentation/xcode/adding-supplemental-content-to-a-documentation-catalog)

```swift
platforms: [
        .iOS("16.0") // depuis la sample app panda meme creator 
    ],
```

### **iTunesExplorer+**

- étudier si `AsyncSequence` pourrait aider avec le fetch

### **iTunesExplorer**

- [ ] penser à commit les étapes importantes
- [ ] mettre en place le bouton
- [X] faire le model `ExploResult` [!] observable et cie *NOPE*
- [X] faire l'objet `Exploration` SANS **combine** [!] observable et cie *NOPE*
- [X] tester avec des print un fetch
- [X] Installer et utiliser instrumnt pour check ca : [doc apple](https://developer.apple.com/documentation/foundation/url_loading_system/analyzing_http_traffic_with_instruments)
- [X] Detail view a finir de mettre en forme (contenu + gerer espace autours)
- [X] Peaufiner un peu la scrollview + ajout du segmented control
- [ ] un gradient sympa comme ici :  [background doc](https://developer.apple.com/documentation/swiftui/adding-a-background-to-your-view)
- [X] **Commit ou newbranch** avant, puis tester de remplacer la scrollview avec list pour perfs
- [X] Faire une lib avec SPM -> github prive NeoTools 
  - v1 blur (laisser le readme pour 42)
  - v2 networkLayer combine (plus tard, une fois combine integré)
- **TODO**  
  1. [X] 2 couleurs + fichier swift pour un gradient en background 
  2. [X] explo.state == .loading => animate text with moving gradient inside typo
  3. [ ] explo.state == .notSearchedYet => StarExplo + logoapp icon `a continuer`
  4. [ ] simplifier le exploView > Button > if canClear { }
  5. [ ] bug image fetch infini si on swap avec le segmented control

- [ ] **Git branch** integrer combine maintenant
- [ ] retester des fetch
- [ ] Une fois le fetch ok -> affichage de la list des results + segmented controls pour category
- [ ] Ajouter une page d'intro / un bouton avant d'afficher la searchbar avec une animation sympa comme [ceci](https://www.hackingwithswift.com/quick-start/swiftui/how-to-dynamically-adjust-the-appearance-of-a-view-based-on-its-size-and-location)

---

## Strategie (at 42)

### **Direct pour iTunesExplorer**

- [X] faire un logo png 1024 ~> Placeholder 👎
- [X] Etudier s'il faut une Scrollview avec lazyVstack au lieu de la List{} 
- [X] Noter dans jobiView diff entre @unkown default et default dans un switch + clipShape et overlay !!
- [X] Voir si je trouve une methode sympa pour extraire l'alerte dans un fichier à part et rendre ça plus modulable **video kavsoft**
- [X] Etudier le cote cancel de la datatask machin, est-ce que c'est bien en place dans ma version ?
- [X] infos sur le @FocusState [Kodeco](https://www.kodeco.com/31569019-focus-management-in-swiftui-getting-started)
- [X] pour cntinuer ma DetailView -> comment avoir transparant + geoReader ?
- [X] s'occuper du readme du packageManager blur
- [X] *changer le nom plus explicite transparent NOPE* puis tag patch 1.0.1
- [X] > **DetailView** retrouver comment formater le texte pour labels ?
- [ ] simulator -> comment enregistrer n extrait et en faire un gif pour mon readme.md ?
- **JobiView** *se documenter + faire un paragraphe*
  - [X] Documenter ses fonctions dans Xcode
  - [X] Accessibilité, voiceOver voiceControl + accessibilitylabel ect de ios17
  - [X] Logger
  - [X] Mon iPhone en appareil de dév --> pas trop d'info claires
- **TODO** *préparer pour intégrer au projet iTunesExplorer*  
  1. [X] 2 couleurs + fichier swift pour un gradient en background 
  2. [X] explo.state == .loading => animate text with moving gradient inside typo
  3. [X] explo.state == .notSearchedYet => welcome user with picture&Text, button to focus on textField + logoapp icon

### **Long Terme**

- [ ] continuer de revoir les swiftUI app + sample App d'apple et les referencer dans jobiView
- [ ] continuer de voir le truc sur testView dans la partie jobiview structural pattern
- [ ] Extraire puis passer une partie de jobiView en repo public ?

<br/>

# SwiftUI

[Kodeco cookbook](https://www.kodeco.com/books/swiftui-cookbook)
