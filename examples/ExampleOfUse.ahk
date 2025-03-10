#Include %A_ScriptDir%\..\IME.ahk

MsgBox, [Ctrl] + [Shift] + [9] でIME状態確認スクリプトを実行します。終了する場合はタスクトレイのアイコンを右クリックしてください。

^+9::
  MsgBox, IME状態を確認したいエディタやテキストボックスにフォーカスをセットしてください。準備ができたら「OK」をクリックしてください。
  Sleep, 1000

  if (IME.IsEnabling()) {
    MsgBox, 1. 現在、そのエディタではIMEが有効になっています。
  } else {
    MsgBox, 1. 現在、そのエディタではIMEは無効になっています。
  }

  MsgBox, 2. AutoHotkeyでIMEを有効化します。準備ができたら「OK」をクリックしてください。
  Sleep, 1000
  IME.SwitchIME(1)
  MsgBox, IMEの有効化が完了しました。
  Sleep, 1000

  if (IME.IsEnabling()) {
    MsgBox, 3. 現在、そのエディタではIMEが有効になっています。
  } else {
    MsgBox, 3. 現在、そのエディタではIMEは無効になっています。
  }

  MsgBox, 4. AutoHotkeyでIMEを無効に切り替えます。準備ができたら「OK」をクリックしてください。
  Sleep, 1000
  IME.SwitchIME(0)
  MsgBox, IMEの無効化が完了しました。

  if (IME.IsEnabling()) {
    MsgBox, 5. 現在、そのエディタではIMEが有効になっています。
  } else {
    MsgBox, 5. 現在、そのエディタではIMEは無効になっています。
  }

  MsgBox, 6. AHKが挿入モード（INSモード）を「有効」に切り替えます。準備ができたら「OK」をクリックしてください。
  Sleep, 1000
  IME.SwitchInsMode("ON")
  MsgBox, INSモードの有効化が完了しました。エディタをご確認ください。

  Sleep, 3000

  MsgBox, 7. AHKがINSモードを「無効」に切り替えます。準備ができたら「OK」をクリックしてください。
  Sleep, 1000
  IME.SwitchInsMode("OFF")
  MsgBox, INSモードの無効化が完了しました。エディタをご確認ください。

  MsgBox, 全ての処理が完了しました。
Return
