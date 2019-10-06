import QtQuick 2.0
import Felgo 3.0
import QtMultimedia 5.0 // needed for SoundEffect.Infinite

GameWindow {
  id: window
  // depending on which window size is defined as start resolution here, the corresponding image sizes get loaded here! so for testing hd2 images, at least use factor 3.5
  // the window size can be changed at runtime by pressing the keys 1-6 (see GameWindow.qml)
  screenWidth: 640//*1.5 // for testing on desktop with the highest res, use *1.5 so the -hd2 textures are used
  screenHeight: 960//*1.5

  // You get free licenseKeys from https://felgo.com/licenseKey
  // With a licenseKey you can:
  //  * Publish your games & apps for the app stores
  //  * Remove the Felgo Splash Screen or set a custom one (available with the Pro Licenses)
  //  * Add plugins to monetize, analyze & improve your apps (available with the Pro Licenses)
  //licenseKey: "<generate one from https://felgo.com/licenseKey>"
  licenseKey: "AB6236B3BB070B284A285271C17A1CBEF0144A71141CDEFFB6B3956C56453247E11C3F09CB8C87A18B45F31958987AD1E5F2C1B6779AA7BD7D116C261149AA836EFF01665576A3961D93E9624258A578870FCE650A1C74A965075A48C565D300EFF93DA6EF434CB817D944F4E1903E9CD398282CD43679414992AE96EA5018B37DFA4C5EADBA93E47ACDB69910225A6D557CCBB52235A295AE861DD172A1B00DD237D0F93A8263618A4A5BADBC41B022AF33FAB74AF4AA043E5ED52DF683449D458FCD97B2ACBD1CFFBC949248D1CBDA4F52609E9C82C5A6D7D91B410A1FA2F13EF0B72462F5D659CED50448C055B3B312CA4A61A08A176849D32EE2D083493D3F35BD0CCF97942F10650477530704869A7A1323F9BB9E297157F29D018C56DC9C67C09BE121AB72091A554A646184D4D9EDDABAD3DE950C658AB02E51A96E69D77881A2168396BBA338D763B1F2A9EA8CD8E25008960AF58FB4088C35AEF707C4D277E9DB02EC764A1E79D20197A06A1342E74331A32799BFFFAD67C3E3D940"
 // licenseKey: "609E2E8A7A07D3D26345DC2C7A556EDC7FD3CECD9C946C071C377EE23A539FA9108FD82EDD6FD9260FB919BE05B4CD484B9C8860EF485D9AC18D8CFC18F879CF5959A4294AD95B6019222AC88CC575F37E0C57965BAF8745277287B962219ACFB0F0F0755AF02A7F873AF951F02F3F886F871A4E6D01E42EA1A3444C8089D2C220D41F35267CF0354B69D6EFFDD193715B245B0865C3AB2D3F52E44F26E902FA821B05D756414A08635816C0D4FB77E2EEDD3E5591016093F827E5D1D3B03318DFFD5724E3593753E0EB606036A936342EBB5E506D8450A98B08299E27A5B84A13B6139889DF02789D08C3C24B376F40CCD80A63D261928DC8BA9FCA2252D636AF2F358A1D558AA06D515B5896FD447E668420DA16EA98491856767A3F72B120878FFC010AF39DCD5DFC16EF3A8E96B0E4D5A21969797F0747211F2484DD94B510F6D3CC0682F9B6FE09E7B14BB97DC95E4944DDC3AC6A23825CE414A8292C34682800F4F2F0A5925791B00464A196B0"
  // for better readability of the fps for QML renderer
//  fpsTextItem.color: "white"

  // all properties assigned here are accessible from all entities!
  // the reason for that is, because entities get created through the EntityManager here in this GameWindow, and only the parent items of the item where it was created are known to the dynamically created entities
  property alias level: scene.level
  property alias player: scene.player // this works, when player is defined as alias in scene

  // for loading the stored highscore and displaying on GameOverScreen when a new highscore is reached
  // these get accessed from the MainScene and the ChickenOutbreakScene
  property int maximumHighscore: 0
  property int lastScore: 0
  Component.onCompleted: {
//    var storedScore = settings.getValue("maximumHighscore");
    // if first-time use, nothing can be loaded and storedScore is undefined
//    if(storedScore) {
//      maximumHighscore = storedScore;
//    }

    // Authenticate player to gamecenter
//    gameCenter.authenticateLocalPlayer();

    // this may be added to deactivate sounds in debug builds
//    if(system.debugBuild) {
//      settings.ignoredPropertiesForStoring = ["soundEnabled"]
//      settings.soundEnabled = false
//    }
    // enable System language for translations
//    translation.useSystemLanguage = true

    // TODO: test the difference with Qt5, what looks better - by default the schedulingMethod is Accumulated, which means one update for every 16ms
    // Scheduling needs to be turned off in chicken outbreak on iOS, Android and Mac to avoid small lags during fast movement.
//    if(system.isPlatform(System.IOS) || system.isPlatform(System.Mac) || system.isPlatform(System.Android) ) {
//        vplayScheduler.schedulingMethod = VPlayScheduler.None
//    }
  }
  onMaximumHighscoreChanged: {
//    var storedScore = settings.getValue("maximumHighscore");
    // if not stored anything yet, store the new value
    // or if a new highscore is reached, store that
    // if the same score is submitted, call reportScore() too to update the score on GameCenter
//    if(!storedScore || maximumHighscore >= storedScore) {
//      console.debug("stored improved highscore from", storedScore, "to", maximumHighscore);
//      settings.setValue("maximumHighscore", maximumHighscore);

      // this call posts the highscore both to Felgo Game Network and GameCenter, because gameCenterItem is set in VPGN
      gameNetwork.reportScore(maximumHighscore)
//    }
  }

  // use BackgroundMusic for long-playing background sounds
  // there are issues with the Qt 5 Audio element on some Android devices, which do not allow playing with Audio component from qrc files!
  // thus use a SoundEffect until these issues get fixed (hopefully in Qt 5.3.1)
  // when playing Audio from qrc is supported, also switch to an mp3 format as it is less resource intensive
  //BackgroundMusic {
  BackgroundMusic {
    id: backgroundMusic
    source: "../assets/snd/bg-slow.wav"
    // this must be set
//    loops: SoundEffect.Infinite
    autoPlay: true
  }

  // Custom font loading of ttf fonts
  FontLoader {
    id: fontHUD
    source: "fonts/pf_tempesta_seven_compressed.ttf"
  }

  // be sure to enable GameCenter for your application (developer.apple.com)
//  GameCenter {
//    id: gameCenter

//    // Use highscore from GameCenter if it is higher than our local one
//    onAuthenticatedChanged: {
//      if (authenticated === true) {
//        // For debugging only
//        // resetAchievements();

//        var gameCenterScore = getGameCenterScore();
//        if (gameCenterScore > maximumHighscore)
//          maximumHighscore = gameCenterScore;
//      }
//    }
//  }

  FelgoGameNetwork {
   id: gameNetwork
   // created in the Felgo Web Dashboard; this is the dev version of the game
   gameId: 683
   // the production password is not public, but this is the dev password
   secret: "12345678910"

   gameNetworkView: vplayGameNetworkScene.gameNetworkView
   // facebookItem: facebook
//   gameCenterItem: gameCenter

   achievements: [

     Achievement {
       key: "grains10"
       name: "Hobby Collector"
       iconSource: "../assets/img/achievement_10grains.png"
       target: 10
       points: 10
       description: "Collect at least 10 grains in one game"
       descriptionAfterUnlocking: "Collected at least 10 grains in one game"
     },
     Achievement {
       key: "grains25"
       name: "Passionate Collector"
       iconSource: "../assets/img/achievement_25grains.png"
       target: 25
       points: 25
       description: "Collect at least 25 grains in one game"
       descriptionAfterUnlocking: "Collected at least 25 grains in one game"
     },
     Achievement {
       key: "grains50"
       name: "Obsessed Collector"
       iconSource: "../assets/img/achievement_50grains.png"
       target: 50
       points: 50
       description: "Collect at least 50 grains in one game"
       descriptionAfterUnlocking: "Collected at least 50 grains in one game"
     },
     Achievement {
       key: "chickendead1"
       name: "Empty Henhouse"
       iconSource: "../assets/img/achievement_chickendead.png"
       target: 10
       points: 15
       description: "The chicken dies 10 times in a row"
       descriptionAfterUnlocking: "The chicken died 10 times in a row"
     }
   ]

   onUserScoresInitiallySyncedChanged: {
     if(userScoresInitiallySynced) {
       console.debug("the Felgo Game Network user highscore got synced with the server, maximumHighScore:", maximumHighscore, ", userHighscoreForCurrentActiveLeaderboard:", gameNetwork.userHighscoreForCurrentActiveLeaderboard)

       // if no value is in the highscore list yet, -1 is returned; thus add the check if the maxHighscore is bigger 0
       if(maximumHighscore>0 && maximumHighscore > gameNetwork.userHighscoreForCurrentActiveLeaderboard) {
         // if the user already reached a highscore BEFORE the gameNetwork was used, we initially send the maximumHighscore to the server
         console.debug("there was a highscore reached in a previous version before Felgo Game Network was used - upload it to the server now..")

         gameNetwork.reportScore(maximumHighscore)
       } else if(gameNetwork.userHighscoreForCurrentActiveLeaderboard > maximumHighscore) {
         console.debug("there was a higher score reached on a different device - update the local maximumHighscore now")
         // updating the maximumHighscore here leads to a call of gameNetwork.reportScore(), which then updates the score on GameCenter
         maximumHighscore = gameNetwork.userHighscoreForCurrentActiveLeaderboard
       }


     }
   }

   onAchievementUnlocked: {
     // only show the native dialog during development on non-publish builds
     if(!system.publishBuild) {
      nativeUtils.displayMessageBox("Achievement unlocked with key " + key)
     }
   }

   onNewHighscore: {
     // only show the native dialog during development on non-publish builds
     if(!system.publishBuild) {
      nativeUtils.displayMessageBox("New highscore reached for leaderboard " + leaderboard + ": " + Math.round(highscore))
     }
   }


  }// FelgoGameNetwork



  // this scene is set to visible when loaded initially, so its opacity value gets set to 1 in a PropertyChange below
  MainScene {
    id: mainScene
    // when opacity is 0, visible gets set to false in SceneBase
    opacity: 0
  }

  ChickenOutbreakScene {
    id: scene
    // when opacity is 0, visible gets set to false in SceneBase
    opacity: 0
    onVisibleChanged: console.debug("GameScene changed visible to", visible)
  }

  GameOverScene {
    id: gameOverScene
    // when opacity is 0, visible gets set to false in SceneBase
    opacity: 0
    AdMobBanner {
      adUnitId: "ca-app-pub-2479144310234386~6519698786" // banner test ad by AdMob
      banner: AdMobBanner.Smart
      anchors.horizontalCenter: parent.horizontalCenter
      anchors.top: parent.top
    }
  }

  CreditsScene {
    id: creditsScene
    // when opacity is 0, visible gets set to false in SceneBase
    opacity: 0
  }

  FelgoGameNetworkScene {
    id: vplayGameNetworkScene
    opacity: 0
  }

  // for creating & removing entities
  EntityManager {
    id: entityManager
    entityContainer: scene.entityContainer
    poolingEnabled: true // entity pooling works since version 0.9.4, so use it
  }

  // this gets used for analytics, to know which state was ended before
  property string lastActiveState: ""

  onStateChanged: {

    console.debug("ChickenBreakoutMain: changed state to", state)

    if(state === "main")
      activeScene = mainScene;
    else if(state === "game")
      activeScene = scene;
    else if(state === "gameOver")
      activeScene = gameOverScene;
    else if(state === "credits")
      activeScene = creditsScene;
    else if(state === "gameNetwork")
      activeScene = vplayGameNetworkScene;

    if(lastActiveState === "main") {
      // flurry.endTimedEvent("Display.Main");
    } else if(lastActiveState === "game") {
      // flurry.endTimedEvent("Display.Game");

      // NOTE: Android doesn't support endTimedEventWithParams yet!?! http://stackoverflow.com/questions/12205860/android-flurry-and-endtimedevent
      //flurry.endTimedEvent("Display.Game", { "score": lastScore, "collectedCorns" : player.bonusScore, "scoreForCorns": player.bonusScore*player.bonusScoreForCoin });
      // thus emit them with own events

      // flurry.logEvent("Game.Finished", { "score": lastScore, "collectedCorns" : player.bonusScore, "scoreForCorns": player.bonusScore*player.bonusScoreForCoin })

    } else if(lastActiveState === "gameOver") {
      // flurry.endTimedEvent("Display.GameOver");
    } else if(lastActiveState === "credits") {
      // flurry.endTimedEvent("Display.Credits");
    } else if(lastActiveState === "gameNetwork") {
        // flurry.endTimedEvent("Display.FelgoGameNetwork");
    }

    if(state === "main") {
      // flurry.logTimedEvent("Display.Main");
    } else if(state === "game") {
      // flurry.logTimedEvent("Display.Game");
    } else if(state === "gameOver") {
      // flurry.logTimedEvent("Display.GameOver");
    } else if(state === "credits") {
      // flurry.logTimedEvent("Display.Credits");
    } else if(state === "gameNetwork") {
      // flurry.logTimedEvent("Display.FelgoGameNetwork");
    }

    lastActiveState = state;
  }

  state: "main"
  // use one of the following states to start with another state when launching the game
  //    state: "game"
  //state: "gameOver"

  // these states are switched when the play button is pressed in MainScene, when the game is lost and when the Continue button is pressed in GameOverScene
  states: [
    State {
      name: "main"
      // by switching the property to 1, which is by default set to 0 above, the Behavior defined in SceneBase takes care of animating the opacity of the new Scene from 0 to 1, and the one of the old scene from 1 to 0
      PropertyChanges { target: mainScene; opacity: 1}

    },
    State {
      name: "game"
      PropertyChanges { target: scene; opacity: 1}
      StateChangeScript {
        script: {
          console.debug("entered state 'game'")
          scene.enterScene();
        }
      }
    },
    State {
      name: "gameOver"
      PropertyChanges { target: gameOverScene; opacity: 1}
      StateChangeScript {
        script: {
          console.debug("entered state 'gameOver'")
          gameOverScene.enterScene();
        }
      }
    },
    State {
      name: "credits"
      PropertyChanges { target: creditsScene; opacity: 1}
    },
    State {
      name: "gameNetwork"
      PropertyChanges { target: vplayGameNetworkScene; opacity: 1}

    }
  ]
}
