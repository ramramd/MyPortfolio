# MyPortfolio
Displays list of stocks owned by the individual, current price and stock units owned.
Project also has unit tests written for the view model.
Have leveraged RxSwift framework to set up data bindings and implement MVVM architecture.
Have used Resolver dependency injection framework to inject dependencies.


**If I were to use the dictionary data from the api response and not use any codable type model classes, I would pass the dictionary response from the api request class as is and then let view model take care of extracting the data it needs and update UI. I can also think of a DataService between view model and APIRequest class that can aggregate data if required and then send the aggregated data to the view model so the logic to aggregate data by making additional service call can be kept in Data service and data service send the aggregated data back to view model. So, things like downloading image from url can also be taken care by data service.**


https://github.com/ramramd/MyPortfolio/assets/25652399/320fc552-7b71-4a2f-8385-af5e4fdaac7c

