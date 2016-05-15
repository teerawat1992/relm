module RegistraionForm exposing (..)


import Html exposing (..)
import Html.App as App
import Html.Attributes exposing (..)
import Html.Events exposing (onInput)
import String
import Regex


main =
  App.beginnerProgram { model = model, view = view, update = update }



-- MODEL


type alias Model =
  { name : String
  , password : String
  , passwordConfirmation : String
  }


model : Model
model =
  Model "" "" ""


validatePresenceOfName : Model -> Bool
validatePresenceOfName model =
  not (String.isEmpty model.name)


validatePresenceOfPassword : Model -> Bool
validatePresenceOfPassword model =
  not (String.isEmpty model.password)


validateLengthOfPassword : Model -> Bool
validateLengthOfPassword model =
  String.length model.password >= 8


validateMatchOfPasswords : Model -> Bool
validateMatchOfPasswords model =
  model.password == model.passwordConfirmation


validateNumberOfPassword : Model -> Bool
validateNumberOfPassword model =
  Regex.contains (Regex.regex "\\d") model.password


validateNonWordCharacterOfPassword : Model -> Bool
validateNonWordCharacterOfPassword model =
  Regex.contains (Regex.regex "\\W") model.password


isValid : Model -> Bool
isValid model =
  [ validatePresenceOfName
  , validatePresenceOfPassword
  , validateLengthOfPassword
  , validateMatchOfPasswords
  , validateNumberOfPassword
  , validateNonWordCharacterOfPassword
  ] |> List.all (\validate -> validate model)



-- UPDATE


type Msg
  = Name String
  | Password String
  | PasswordConfirmation String


update : Msg -> Model -> Model
update msg model =
  case msg of
    Name name ->
      { model | name = name }

    Password password ->
      { model | password = password }

    PasswordConfirmation passwordConfirmation ->
      { model | passwordConfirmation = passwordConfirmation }



-- VIEW


view : Model -> Html Msg
view model =
  div []
    [ div [ class "form-group" ]
      [ input
        [ type' "text"
        , name "user[name]"
        , placeholder "Name"
        , class "form-control"
        , onInput Name
        ] []
      ]

    , div [ class "form-group" ]
      [ input
        [ type' "password"
        , name "user[password]"
        , placeholder "Password"
        , class "form-control"
        , onInput Password
        ] []
      ]

    , div [ class "form-group" ]
      [ input
        [ type' "password"
        , name "user[password_confirmation]"
        , placeholder "Re-enter password"
        , class "form-control"
        , onInput PasswordConfirmation
        ] []
      ]

    , viewValidation model

    , input
      [ type' "submit"
      , value "Signup"
      , class "btn btn-primary btn-block btn-lg"
      , disabled (not (isValid model))
      ] []
    ]



viewValidation : Model -> Html Msg
viewValidation model =
  let
    namePresenceColor =
      if validatePresenceOfName model then "green" else "red"

    passwordLengthColor =
      if validateLengthOfPassword model then "green" else "red"

    passwordContainsNumberColor =
      if validateNumberOfPassword model then "green" else "red"

    passwordWithNonWordCharacterColor =
      if validateNonWordCharacterOfPassword model then "green" else "red"

    passwordsMatchColor =
      if validateMatchOfPasswords model && validatePresenceOfPassword model then
        "green"
      else
        "red"
  in
    div [ class "panel panel-info" ]
      [ div [ class "panel-heading"]
        [ h4 [ class "panel-title" ] [ text "Form validation:" ] ]

      , div [ class "panel-body" ]
        [ ul []
          [ li [ style [("color", namePresenceColor)] ]
              [ text "Name must be present" ]

          , li [ style [("color", passwordContainsNumberColor)] ]
              [ text "Password must contain at least one number (0-9)" ]

          , li [ style [("color", passwordWithNonWordCharacterColor)] ]
              [ text "Password must contain at least one non-word character" ]

          , li [ style [("color", passwordLengthColor)] ]
              [ text "Password must be at least 8 characters" ]

          , li [ style [("color", passwordsMatchColor)]]
              [ text "Passwords match!" ]
          ]
        ]
      ]
