# basalt_test

Flutter App that shows the stock market report of 10 random
companies.

## TASK
- Use [MarketStack API](https://marketstack.com/)
- Build a flutter app that shows the stock market report of 10 random
companies.
- Add a date range and an auto complete search box to the UI. The autocomplete feature
should filter the list returned from the API. 
- Also, notify the user if the device is offline.

## Prerequisites
In order to be able to setup and run this application, the following need to be installed and setup
- [Flutter](https://docs.flutter.dev/get-started/install)
- [Android Studio](https://developer.android.com/studio)
- [VS Code](https://code.visualstudio.com/)

## Project Setup

To setup the project in your machine:

- Clone the repo

```console
foo@bar:~$ git clone https://github.com/Ikami-Mercy/BasalMarketStocksApp.git
```

- Setup env files
```
Add two .env file 'testing' and 'production' in assets/env/testing/ directory
 and  assets/env/production/ directory
Add the Marketstack Api key in both the directories with MARKET_STACK_API_KEY as the key
 and value as the ApiKey as follows:
MARKET_STACK_API_KEY=YOUR_API_KEY
Add a DB_NAME key in both the directories with DB_NAME as the key and value as the database name value as follows:
DB_NAME=basalt_db
Add the BASE_URL key in both the directories with BASE_URL as the key and value as the base url as follows:
BASE_URL=http://api.marketstack.com/v1
```

- CD into the repo and install the dependencies
```console
foo@bar:~$ cd basal_test
```
```console
foo@bar:~$ flutter pub get
```

- Run the build runner in all packages to generate required files
```console
foo@bar:-$ flutter pub run build_runner watch --delete-conflicting-outputs
```

- Run the application
```console
foo@bar:~$ flutter run
```

- Delete generated files
```console
foo@bar:~$ sh scripts/ci.sh --delete_generated
```

## Architecture

The project is divided into 4 modules, namely:
- Presentation (lib)
- Dependencies
- Data
- Domain

This approach is guided by the clean architecture approach which advocates for clear abstraction of the flow of data from the business logic to the presentation framework dealing with displaying data to the user.

#### Dependencies
The dependencies module creates a central module for manage all 3rd party dependencies for the project. New libraries are added to the `pubspec.yaml` file then exported from the `lib/dependencies.dart` file to make them available for use by other modules.

#### Presentation
The presentation module handles all logic that deals with UI/UX display to the user. These are the various pages that are contained within the application

#### Data
The data modules handles all logic that has to do with saving/fetching of data both local and remote data from the API.

#### Domain
The domain module deals with the model classes which hold the data used in the `presentation` and `data` modules.

## External Links
- [Dependency Injection](https://www.youtube.com/watch?v=KNcP8z0hWqs)
- [Dependency Injection in Multi-Module Project](https://abdulhakeemahmoood.medium.com/dependency-injection-in-multi-module-flutter-project-a2bbf99b14ff)
- [Bloc Pattern](https://blog.logrocket.com/state-management-flutter-bloc-pattern/)
- [Bloc Fundamentals](https://bloclibrary.dev/#/coreconcepts?id=state-changes)
- [Setting up build flavors](https://medium.com/@animeshjain/build-flavors-in-flutter-android-and-ios-with-different-firebase-projects-per-flavor-27c5c5dac10b)
- [Generating IPA on flutter](https://jtmuller5-98869.medium.com/flutter-build-an-ipa-90520e813a96)
- [Setting Up CI](https://medium.com/kinandcartacreated/setup-a-flutter-ci-cd-with-gitlab-ci-part-1-8d40b7a3b3dc)
- [Retrofit](https://pub.dev/packages/retrofit)
- [Floor](https://pub.dev/packages/floor)
- [Testing](https://medium.com/flutter-community/tagged/testing)
- [Managing Multi package Flutter App](https://medium.com/flutter-community/managing-multi-package-flutter-projects-with-melos-c8ce96fa7c82)
