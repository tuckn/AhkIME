#Include %A_ScriptDir%\..\IME.ahk

^+9::
  Msgbox, Let activate a your editor. Ready is OK.
  Sleep, 1000

  if (IME.IsEnabling()) {
    Msgbox, 1. Now IME enabling on the editor
  } else {
    Msgbox, 1. Now IME disabling on the editor
  }

  Msgbox, 2. AHK will be IME enabling. Ready is OK.
  Sleep, 1000
  IME.SwitchIME(1)
  Msgbox, Finished IME enabled.
  Sleep, 1000

  if (IME.IsEnabling()) {
    Msgbox, 3. Now IME enabling on the editor
  } else {
    Msgbox, 3. Now IME disabling on the editor
  }

  Msgbox, 4. AHK will be IME disabling. Ready is OK.
  Sleep, 1000
  IME.SwitchIME(0)
  Msgbox, Finished IME disabled.

  if (IME.IsEnabling()) {
    Msgbox, 5. Now IME enabling on the editor
  } else {
    Msgbox, 5. Now IME disabling on the editor
  }

  Msgbox, 6. AHK will be INS mode enabling. Ready is OK.
  Sleep, 1000
  IME.SwitchInsMode("ON")
  Msgbox, Finished INS mode enabled. Check your editor

  Sleep, 3000

  Msgbox, 7. AHK will be INS mode disbling. Ready is OK.
  Sleep, 1000
  IME.SwitchInsMode("OFF")
  Msgbox, Finished INS mode disabled. Check your editor

  Msgbox, All Done
  Return
