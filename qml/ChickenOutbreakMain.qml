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
  licenseKey: "E4613A47BD885CCE27AA88B97F0F249C068B303B3FB767A9320AB3F9836E56E20DAB3EABBE3D119A0486DD6D58D7B51EE46C8743F92024EA0116118C01CA531ECBADFB1B417CF9A7EA516B758CF2D75637F8972F8B26F677DC06B2A93D99E6F54EF4C4535BC1F71D890EEB3B2A03824D715A19335F8ECD3AC97A8C5098C128CE02533F176CBE221AA6FDEE14EB6D37A4B98904AB14EEEB16B976866F500EF991D7B4AE9EB859BE65EF2635F27780C890D5D8BB6238FC1E8AB19EA90510B0DE337221B5427BF06E9CE02E2B0E0E96D9CAF123F28BCF37B3C0ADC800F4D9E1DBC4438FC5741D30C67743A349F60643191BF47C7432E60CC08EF4E70410918B592CC6F5B618B5E099B3E0D8A5847E52FB0F20C86DBA8E593E9621FE34C77EF54A6DDEAB6B55A0465FB8337DDED36D6BD4FECB95C5661E36830B94E8A655CD00A841872E5C14D351AF1E3090C5F4C8643CA8DA4B0F13B049AD7738C05977EEDCC4A7DCE3B6F3B8D6CFF5512E54EA5B60180F01E8A215DE5D7139148EEE4BF78FCC66"
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
