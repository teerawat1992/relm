import Html exposing (..)
import Html.App as App
import Html.Attributes exposing (..)
import Html.Events exposing (onInput)



main =
  App.beginnerProgram { model = model, view = view, update = update }



-- MODEL


type alias Model =
  { name : String
  , password: String
  , passwordConfirmation: String
  }


model : Model
model =
  Model "" "" ""



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
  div [ class "row" ]
    [ div [ class "col-md-6 col-md-offset-3" ]
      [ Html.form [ action "/users", method "post" ]
        [ div [ class "form-group" ]
          [ input
            [ type' "text"
            , name "user[name]"
            , placeholder "Name"
            , class "form-control"
            ] []
          ]

        , div [ class "form-group" ]
          [ input
            [ type' "password"
            , name "user[password]"
            , placeholder "Password"
            , class "form-control"
            ] []
          ]

        , div [ class "form-group" ]
          [ input
            [ type' "password"
            , name "user[password_confirmation]"
            , placeholder "Re-enter password"
            , class "form-control"
            ] []
          ]

        , input
          [ type' "submit"
          , value "Signup"
          , class "btn btn-primary btn-block btn-lg"
          ] []
        ]
      ]
    ]
