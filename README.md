# iTunesExplorer

![iTunesExplorer AppIcon](/ressources/placeholder-1000x500.png)

**An iOS learning support mini-app**  
&emsp; Based on the StoreSearch tutorial from the *[UIKit Apprentice](https://www.kodeco.com/books/uikit-apprentice/v10.0), by Fahim Farook*.  
&emsp; My aim is to rewrite the UI using **SwiftUI** instead of **UIKit** and customize it to improve my knowledge.  
&emsp; Using, for example, **swift packages**  or practicing **swift concurrency** with the **Combine framework** 

<br/>

 ## **🟦 &emsp; 🟦 🟦 🟦 🟦  &emsp; Highlighted points &emsp; 🟦 🟦 🟦 🟦 &emsp; 🟦** 

---

<br/>

<div style="display: flex; align-items: center;">
    <img src="./ressources/startAppicon.gif" alt="start screen" style="width: 320px;">
    <div style="margin-left: 20px;">
        <h2><b>Start it easy</b></h2>
        <p> I chose to added this star-shapped button, gently animated as a welcome screen.
        </p>
    </div>
</div>

<br/>

## **Fetching API**

The **core** of this app excerpt is to **fetch JSON** from iTunes **API**.  
The initial version of iTunesExplorer is using the framework **`URLSession`** to manage the fetching asynchronously

```swift
func performExplo(for text: String, category: Category, completion: @escaping ExploComplete) {

    dataTask?.cancel()

    state = .loading

    let url = iTunesURL(searchText: text, category: category)
    let session = URLSession.shared
    session.sessionDescription = "Main Shared Session"

    dataTask = session.dataTask(with: url) { data, response, error in
    	// using a temp state because secondary thread
        var newState = State.notSearchedYet
    	var success = false
    	if let error = error as NSError?, error.code == -999 {
    		print("search was cancelled (error code -999)")
    		return
    	}
    	if let httpResponse = response as? HTTPURLResponse,
    	   httpResponse.statusCode == 200, let data = data {
        
    		var searchResults = self.parse(data: data)
    		if searchResults.isEmpty {
    			newState = .noResults
    		} else  {
    			searchResults.sort(by: <)
    			newState = .results(searchResults)
    		}
    		success = true
    	}
    	DispatchQueue.main.async {
            // state has to be changed on main thread to prevent data races
    		self.state = newState
    		completion(success)
    	}
    }
    dataTask?.resume()
	}
```

## **Fetching API reworked**

Here the expected thing will be to use the **`combine`** framework to manage the fetching.  
> `Work in progress`

<br/>

<div style="display: flex; align-items: center;">
    <img src="./ressources/exploDemo.gif" alt="use demo" style="width: 320px;">
    <div style="margin-left: 20px;">
        <h2><b>Let's explore</b></h2>
        <p> Here's a fetching demo. The search can be filtered by category thanks to the segmented control.
        </p>
    </div>
</div>

<br/>

<div style="display: flex; align-items: center;">
    <div style="margin-right: 20px;">
        <h2><b>Color schemes</b></h2>
        <p> Create <b>ColorSet</b> in Xcode Assets make the switching between color mode easy.
        </p>
    </div>
    <img src="./ressources/appIcon%2BcolorScheme.gif" alt="showing light and dark mode" style="width: 320px;">
</div>

