{-# LANGUAGE OverloadedStrings #-}

module Main (main) where


import Lib
import qualified Network.Wai as Wai
import qualified Network.Wai.Handler.Warp as Warp
import qualified Network.HTTP.Types.Status as Status
import Data.ByteString.Lazy.Internal
import qualified Data.ByteString.Char8 as BS
import Data.Text (Text)
import Data.Time.LocalTime

simpleApp :: Wai.Application
simpleApp req respond = do
    putStrLn . show . Wai.pathInfo $ req -- とりあえずリクエストのパスとか表示してみる。
    let rpath = Wai.pathInfo req
    zt <- getZonedTime
    case rpath of
    --respond $ Wai.responseLBS Status.status200 [] "test"
        ["api"] -> respond $ Wai.responseLBS Status.status200 [] "api"
        ["time"] -> respond $ Wai.responseLBS Status.status200 [] ((BS.fromStrict . BS.pack . show) zt)
        otherwise ->  respond $ Wai.responseLBS Status.status200 [] "baka"

main :: IO ()
main = do
    let port = 8080 -- とりあえずポート3000番で。
    let setting = Warp.setPort port Warp.defaultSettings
    putStrLn $ "start server port=" ++ show port
    Warp.runSettings setting simpleApp

