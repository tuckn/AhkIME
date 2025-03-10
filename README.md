# AhkImeManager

AhkImeManager は、AutoHotkey 用の IME（日本語入力システム）の状態管理・制御モジュールです。  
このモジュールを利用すると、AutoHotkey スクリプトから現在の IME のオン／オフ状態の確認、IME の切り替え、さらに「INS モード」の切り替え（日本語エディタなどで利用される入力モード）などを簡単に行えます。

本モジュールは、[http://www6.atwiki.jp/eamat/](http://www6.atwiki.jp/eamat/) をForkし、Class化したものです。

## 特徴

- **IME の状態判定**  
  - `IME.IsEnabling()` により、現在の日本語入力状態が有効か無効かを確認できます。
- **IME の切り替え**  
  - `IME.SwitchIME(1)` で IME を有効に、`IME.SwitchIME(0)` で無効に切り替えます。
- **INS モードの制御**  
  - `IME.SwitchInsMode("ON")` や `IME.SwitchInsMode("OFF")` により、エディタなどでの INS モード（挿入モード）の切り替えが可能です。

## インストール

1. 本リポジトリを Git でcloneするか、ZIP ファイルとしてダウンロードしてください。
2. あなたのスクリプトから `#Include` を使って `IME.ahk` を読み込むことで利用できます。  

   例:  
   ```ahk
   #Include %A_ScriptDir%\..\IME.ahk
   ```

## 使用例

サンプルコード（`ExampleOfUse.ahk`）は、`examples` フォルダ内にあります。  
このスクリプトをAutoHotkeyで実行し、**Ctrl + Shift + 9** を押すと IME の状態が確認され、IME のオン／オフ、さらに INS モードの切り替えが順次行われます。

## ライセンス

本プロジェクトは MIT ライセンスのもとで公開されています。  
詳細は [LICENSE](./LICENSE) ファイルをご確認ください。
