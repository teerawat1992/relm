module Store exposing (..)


import Html exposing (..)
import Html.App as App
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Http
import Json.Decode exposing (..)
import Task


main =
  App.program
    { init = init
    , view = view
    , update = update
    , subscriptions = subscriptions
    }



-- MODEL


type alias Product =
  { title : String
  , description :String
  , image_url : String
  , price : String
  , created_at : String
  , updated_at : String
  }


type alias Model =
  List Product


init : (Model, Cmd Msg)
init =
  ([ Product "" "" "" "" "" "" ], getProducts)



-- UPDATE


type Msg
  = FetchSucceed (List Product)
  | FetchFail Http.Error


update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    FetchSucceed products ->
      (products , Cmd.none)

    FetchFail _ ->
      ([ Product "" "" "" "" "" "" ], Cmd.none)



-- VIEW


productPanel : Product -> Html Msg
productPanel product =
  div [ class "col-sm-6 col-md-4" ]
    [ div [ class "thumbnail" ]
      [ img [ src product.image_url, width 128, height 128 ] []
      , div [ class "caption" ]
        [ h3 [] [ text product.title ]
        , p [] [ text product.description ]
        , strong [] [ text ("$" ++ product.price) ]
        ]
      ]
    ]


view : Model -> Html Msg
view products =
  div [] (List.map productPanel products)



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none



-- HTTP


getProducts : Cmd Msg
getProducts =
  let
    url = "/products.json"
  in
    Task.perform FetchFail FetchSucceed (Http.get decodeProducts url)


decodeProduct : Decoder Product
decodeProduct =
  object6 Product
    ("title" := string)
    ("description" := string)
    ("image_url" := string)
    ("price" := string)
    ("created_at" := string)
    ("updated_at" := string)


decodeProducts : Decoder (List Product)
decodeProducts =
  Json.Decode.list decodeProduct
