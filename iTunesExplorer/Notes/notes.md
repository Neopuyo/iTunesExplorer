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
- [ ] Installer et utiliser instrumnt pour check ca : [doc apple](https://developer.apple.com/documentation/foundation/url_loading_system/analyzing_http_traffic_with_instruments)
- [ ] Peaufiner un peu la scrollview + ajout du segmented control
- [ ] **Git branch** integrer combine maintenant
- [ ] retester des fetch
- [ ] Une fois le fetch ok -> affichage de la list des results + segmented controls pour category

## Strategie (at 42)

### **Direct pour iTunesExplorer**

- [ ] faire un logo png 1024
- [X] Etudier s'il faut une Scrollview avec lazyVstack au lieu de la List{} 
- [ ] Noter dans jobiView diff entre @unkown default et default dans un switch + clipShape et overlay !!
- [ ] Considérer faire une extension de Image ou AsyncImage pour avoir directment dans la vignette des row
- [ ] Voir si je trouve une methode sympa pour extraire l'alerte dans un fichier à part et rendre ça plus modulable **video kavsoft**
- [ ] Etudier le cote cancel de la datatask machin, est-ce que c'est bien en place dans ma version ?
- [ ] infos sur le @FocusState [Kodeco](https://www.kodeco.com/31569019-focus-management-in-swiftui-getting-started)
- [ ] pour cntinuer ma DetailView -> comment avoir transparant + geoReader ?
- [ ] si le blur effect fonctionne bien : voir si je peux en faire une lib avec SPM

### **Long Terme**

- [ ] continuer de revoir les swiftUI app + sample App d'apple et les referencer dans jobiView

<br/>

# SwiftUI

[Kodeco cookbook](https://www.kodeco.com/books/swiftui-cookbook)
