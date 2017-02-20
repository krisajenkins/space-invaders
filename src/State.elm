module State exposing (..)

import AnimationFrame
import Keyboard exposing (KeyCode)
import Response exposing (..)
import Types exposing (..)


initAlien : Position -> Alien
initAlien position =
    { position = position
    , isAlive = True
    }


init : Response Model Msg
init =
    ( { ship =
            { position =
                { x = 0
                , y = 0
                }
            , isAlive = True
            }
      , aliens =
            (List.range 0 20)
                |> List.map wavePosition
                |> List.map (scale { x = 400, y = 300 })
                |> List.map (translate { x = -2000, y = -4000 })
                |> List.map initAlien
      , shots = []
      }
    , Cmd.none
    )


update : Msg -> Model -> Response Model Msg
update msg model =
    case msg of
        MoveLeft ->
            ( { model | ship = move { x = shipSize // -1, y = 0 } model.ship }
            , Cmd.none
            )

        MoveRight ->
            ( { model | ship = move { x = shipSize, y = 0 } model.ship }
            , Cmd.none
            )

        Tick delta ->
            ( { model
                | aliens = List.map (move { x = 0, y = alienSize // 40 }) model.aliens
                , shots = List.map moveShot model.shots
              }
                |> resolveCollisions
                |> resolveDeath
                |> prune
            , Cmd.none
            )

        Fire ->
            ( if List.length model.shots > 10 then
                model
              else
                { model
                    | shots =
                        { position = model.ship.position
                        , direction = { x = 0, y = shotHeight // -4 }
                        , isAlive = True
                        }
                            :: model.shots
                }
            , Cmd.none
            )

        Noop ->
            ( model
            , Cmd.none
            )


resolveCollisions : Model -> Model
resolveCollisions model =
    let
        considerOneAlien : Alien -> ( List Shot, List Alien ) -> ( List Shot, List Alien )
        considerOneAlien alien ( survivingShots, survivingAliens ) =
            let
                ( survivingShots_, newAlien ) =
                    resolveAlienCollisions ( survivingShots, alien )
            in
                ( survivingShots_, newAlien :: survivingAliens )

        ( newShots, newAliens ) =
            List.foldl considerOneAlien
                ( model.shots, [] )
                model.aliens
    in
        { model
            | aliens = newAliens
            , shots = newShots
        }


resolveAlienCollisions : ( List Shot, Alien ) -> ( List Shot, Alien )
resolveAlienCollisions ( shots, alien ) =
    let
        considerOneShot shot ( oldShots, oldAlien ) =
            if not oldAlien.isAlive then
                ( oldShots, oldAlien )
            else
                let
                    alienLeft =
                        (alien.position.x - (alienSize // 2))

                    alienRight =
                        (alien.position.x + (alienSize // 2))

                    shotLeft =
                        (shot.position.x - (shotWidth // 2))

                    shotRight =
                        (shot.position.x + (shotWidth // 2))

                    alienTop =
                        (alien.position.y - (alienSize // 2))

                    alienBottom =
                        (alien.position.y + (alienSize // 2))

                    shotTop =
                        (shot.position.y - (shotHeight // 2))

                    shotBottom =
                        (shot.position.y + (shotHeight // 2))

                    isMiss =
                        (shotRight < alienLeft)
                            || (alienRight < shotLeft)
                            || (shotBottom < alienTop)
                            || (alienBottom < shotTop)
                in
                    if isMiss then
                        ( shot :: oldShots
                        , oldAlien
                        )
                    else
                        ( oldShots
                        , { oldAlien | isAlive = False }
                        )
    in
        List.foldl considerOneShot ( [], alien ) shots


resolveDeath : Model -> Model
resolveDeath model =
    let
        ship =
            model.ship

        noCrash =
            model.aliens
                |> List.filter .isAlive
                |> List.filter (.position >> .y >> (<) (model.ship.position.y - (shipSize // 2)))
                |> List.isEmpty
    in
        { model | ship = { ship | isAlive = noCrash } }


prune : Model -> Model
prune model =
    let
        isStillOnScreen { x, y } =
            -5000 < y && y <= 600
    in
        { model
            | aliens =
                model.aliens
                    |> List.filter (.position >> isStillOnScreen)
                    |> List.filter .isAlive
            , shots =
                model.shots
                    |> List.filter (.position >> isStillOnScreen)
                    |> List.filter .isAlive
        }


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
        [ Keyboard.presses readKey
        , AnimationFrame.diffs Tick
        ]


readKey : KeyCode -> Msg
readKey keyCode =
    case keyCode of
        115 ->
            Fire

        32 ->
            Fire

        97 ->
            MoveLeft

        100 ->
            MoveRight

        _ ->
            Noop
