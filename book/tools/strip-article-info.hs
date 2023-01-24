#!/usr/bin/env stack
-- stack runghc --system-ghc --resolver ghc-9.4.4
{-# LANGUAGE OverloadedStrings #-}
import System.Environment (getArgs)
import qualified Data.ByteString.Char8 as S

main :: IO ()
main = getArgs >>= mapM_ go

go :: FilePath -> IO ()
go fp = S.readFile fp >>= S.writeFile fp . S.unlines . go' . S.lines . S.filter (/= '\r')

go' :: [S.ByteString] -> [S.ByteString]
go' [] = []
go' ("<articleinfo>":rest) = drop 1 $ dropWhile (/= "</articleinfo>") rest
go' (x:xs) = x : go' xs
