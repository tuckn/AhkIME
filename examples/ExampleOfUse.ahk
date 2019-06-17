#Include %A_ScriptDir%\..\IME.ahk

MsgBox, Press [Ctrl] + [Shift] + [9], Run it. Exit to the tasktray icon.

^+9::
  MsgBox, Let activate a your editor. Ready is OK.
  Sleep, 1000

  if (IME.IsEnabling()) {
    MsgBox, 1. Now IME enabling on the editor
  } else {
    MsgBox, 1. Now IME disabling on the editor
  }

  MsgBox, 2. AHK will be IME enabling. Ready is OK.
  Sleep, 1000
  IME.SwitchIME(1)
  MsgBox, Finished IME enabled.
  Sleep, 1000

  if (IME.IsEnabling()) {
    MsgBox, 3. Now IME enabling on the editor
  } else {
    MsgBox, 3. Now IME disabling on the editor
  }

  MsgBox, 4. AHK will be IME disabling. Ready is OK.
  Sleep, 1000
  IME.SwitchIME(0)
  MsgBox, Finished IME disabled.

  if (IME.IsEnabling()) {
    MsgBox, 5. Now IME enabling on the editor
  } else {
    MsgBox, 5. Now IME disabling on the editor
  }

  MsgBox, 6. AHK will be INS mode enabling. Ready is OK.
  Sleep, 1000
  IME.SwitchInsMode("ON")
  MsgBox, Finished INS mode enabled. Check your editor

  Sleep, 3000

  MsgBox, 7. AHK will be INS mode disbling. Ready is OK.
  Sleep, 1000
  IME.SwitchInsMode("OFF")
  MsgBox, Finished INS mode disabled. Check your editor

  MsgBox, All Done
  Return
