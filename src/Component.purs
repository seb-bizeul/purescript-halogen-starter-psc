module Component where

import Prelude

import Data.Maybe (Maybe(..))
import Halogen as H
import Halogen.HTML as HH
import Halogen.HTML.Events as HE

type State = Boolean

data Query a = Toggle a

ui :: forall m. H.Component HH.HTML Query Unit Void m
ui =
  H.component
    { initialState: const initialState
    , render
    , eval
    , receiver: const Nothing
    }
  where

  initialState :: State
  initialState = false

  render :: State -> H.ComponentHTML Query
  render state =
    let
      value = if state then "On" else "Off"
    in
      HH.div_
        [ HH.h1_ [ HH.text "Toggle" ]
        , HH.p_ [ HH.text ("value is: " <> value) ]
        , HH.button
            [ HE.onClick (HE.input_ Toggle) ]
            [ HH.text "Toggle State" ]
        ]

  eval :: Query ~> H.ComponentDSL State Query Void m
  eval = case _ of
    Toggle next -> do
      state <- H.get
      H.put (not state)
      pure next
