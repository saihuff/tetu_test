{-# LANGUAGE OverloadedStrings #-}

module Main (main) where


import Lib
import qualified Network.Wai as Wai
import qualified Network.Wai.Handler.Warp as Warp
import qualified Network.HTTP.Types.Status as Status
import Data.ByteString.Internal

simpleApp :: Wai.Application
simpleApp req respond = do
    putStrLn . show . Wai.pathInfo $ req -- とりあえずリクエストのパスとか表示してみる。
    respond $ Wai.responseLBS Status.status200 [] "test"

main :: IO ()
main = do
    let port = 3000 -- とりあえずポート3000番で。
    let setting = Warp.setPort port Warp.defaultSettings
    putStrLn $ "start server port=" ++ show port
    Warp.runSettings setting simpleApp

