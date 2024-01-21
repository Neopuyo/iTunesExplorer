# Fetching data with combine

## Méthode simple

cet article [fetch remote data using Combine](https://cedricbahirwe.hashnode.dev/fetch-remote-data-using-combine) bon point de départ  
voir [Processing URL session data task results with Combine](https://developer.apple.com/documentation/foundation/urlsession/processing_url_session_data_task_results_with_combine) article Apple Doc

## Méthode avancée

Network Kit utilisant generic + 3 methodes pour fetch (combine + closure + async/await) + placer le tout en library pour Swift package manager 👍 overkill mais interessant+pedago a mettre en place !
[ici](https://sabapathy7.medium.com/how-to-create-a-network-layer-for-your-ios-app-623f99161677)

---

## Strategie (at home)
 
- [ ] penser à commit les étapes importantes
- [ ] mettre en place le bouton
- [X] faire le model `ExploResult` [!] observable et cie *NOPE*
- [X] faire l'objet `Exploration` SANS **combine** [!] observable et cie *NOPE*
- [X] tester avec des print un fetch
- [X] Installer et utiliser instrumnt pour check ca : [doc apple](https://developer.apple.com/documentation/foundation/url_loading_system/analyzing_http_traffic_with_instruments)
- [ ] Detail view a finir de mettre en forme (contenu + gerer espace autours)
- [ ] Peaufiner un peu la scrollview + ajout du segmented control
- [ ] une peu de color et design [background doc](https://developer.apple.com/documentation/swiftui/adding-a-background-to-your-view)
- [ ] Faire une lib avec SPM -> github prive NeoTools 
  - v1 blur (laisser le readme pour 42)
  - v2 networkLayer combine (plus tard, une fois combine integré)
- [ ] **Git branch** integrer combine maintenant
- [ ] retester des fetch
- [ ] Une fois le fetch ok -> affichage de la list des results + segmented controls pour category
- [ ] Ajouter une page d'intro / un bouton avant d'afficher la searchbar avec une animation sympa comme [ceci](https://www.hackingwithswift.com/quick-start/swiftui/how-to-dynamically-adjust-the-appearance-of-a-view-based-on-its-size-and-location)

## Strategie (at 42)

### **Direct pour iTunesExplorer**

- [X] faire un logo png 1024 ~> Placeholder 👎
- [X] Etudier s'il faut une Scrollview avec lazyVstack au lieu de la List{} 
- [X] Noter dans jobiView diff entre @unkown default et default dans un switch + clipShape et overlay !!
- [X] Voir si je trouve une methode sympa pour extraire l'alerte dans un fichier à part et rendre ça plus modulable **video kavsoft**
- [X] Etudier le cote cancel de la datatask machin, est-ce que c'est bien en place dans ma version ?
- [X] infos sur le @FocusState [Kodeco](https://www.kodeco.com/31569019-focus-management-in-swiftui-getting-started)
- [X] pour cntinuer ma DetailView -> comment avoir transparant + geoReader ?
- [ ] s'occuper du readme du packageManager blur
- [ ] changer le nom plus explicite transparent puis tag patch 1.0.1 
- [ ] continuer de voir le truc sur testView dans la partie jobiview structural pattern

### **Long Terme**

- [ ] continuer de revoir les swiftUI app + sample App d'apple et les referencer dans jobiView

<br/>

# SwiftUI

[Kodeco cookbook](https://www.kodeco.com/books/swiftui-cookbook)
