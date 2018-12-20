# InstaMovies

InstaMovies is an app that fetches movies info and displays it in a tableView, 
nothing special, huh? 
well there is something special about it, which is...

## The Architecture!

I am mainly using MVVM code with an extra layer of seperation called the `Interactor`
basically the `Interactor`, by name, is the layer that is responsible for the interactions with the app
the special thing about this layer is that it makes life easier when it comes to writing tests for your app

you will see in the code that am testing the app through `Router` which allows me to detect wheither the user is being
shown the appropriate UI parts such as, an alert in case of no network connections and showing the correct view to him
when a certain event occurs in the app (that's where Validators come to play, and those beautiful typealias :D)
and the one-way binding style class `Dynamic<T>` _(actually it's really really simply made so don't get ur hopes up and expect 
Rx stuff outta of it)_

### So, What is the purpose of this repo?

- it's a learning project, you can always hop in and suggest changes ofc
- it's there to teach how to test ur own code or write ur code in a way that allows it to be tested
- am trying to impress someone :D (mainly this)

### And, What does it lack?

- [ ] currently am working on improving the caching technique to enhance UX
- [ ] a changelog 
- [ ] an effective handlation of the bind between the viewController and the viewModel in case of threadings

### Okay, what can this project do?

- [X] you can view movies posters, their release date and some overview about the movie
- [X] you can add your own movie to the list (but it won't be presisted)
- [X] you can expand the movieCell to read more about the Movie's overview
- [X] it supports pagination
- [X] it has a validator class which validates some scenarios like...
  - [X] checking if user is reachable and thus alerting him that there is no internet connection
  - [X] checking upon creating a movie if the user has entered a title to the movie or not and thus the app would alert the user of that
- [X] download images and assigning them correctly without images appearing out of place (due to cell reuse)
- [X] versionings
