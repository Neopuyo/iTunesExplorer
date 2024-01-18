# Fetching data with combine

## Méthode simple

cet article [fetch remote data using Combine](https://cedricbahirwe.hashnode.dev/fetch-remote-data-using-combine) bon point de départ  
voir [Processing URL session data task results with Combine](https://developer.apple.com/documentation/foundation/urlsession/processing_url_session_data_task_results_with_combine) article Apple Doc

## Méthode avancée

Network Kit utilisant generic + 3 methodes pour fetch (combine + closure + async/await) + placer le tout en library pour Swift package manager 👍 overkill mais interessant+pedago a mettre en place !
[ici](https://sabapathy7.medium.com/how-to-create-a-network-layer-for-your-ios-app-623f99161677)

---

## Strategie (at home)
 
- [ ] penser a commit les etapes importante
- [ ] mettre en place le bouton
- [ ] faire le model `ExploResult` [!] observable et cie
- [ ] faire l'objet `Exploration` SANS **combine** [!] observable et cie
- [ ] tester avec des print un fetch
- [ ] Installer et utiliser instrumnt pour check ca : [doc apple](https://developer.apple.com/documentation/foundation/url_loading_system/analyzing_http_traffic_with_instruments)
- [ ] **Git branch** integrer combine maintenant
- [ ] retester des fetch
- [ ] Une fois le fetch ok -> affichage de la list des results + segmented controls pour category

## Strategie (at 42)

- [ ] continuer de revoir les swiftUI app + sample App d'apple et les referencer dans jobiView

<br/>

# SwiftUI

[Kodeco cookbook](https://www.kodeco.com/books/swiftui-cookbook)