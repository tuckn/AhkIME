/**
 * @Fileoverview IME handler for AutoHotkey
 * @Fileencoding UTF-8[dos]
 * @Requirements AutoHotkey v1.1.x. Not confirmed to work on v2.0 or newer.
 * @Installation
 *   Use #Include %A_ScriptDir%\AhkIME\Libs\Class_IME.ahk or copy into your code
 * @License MIT
 * @Links
 *   eamat(original) http://www6.atwiki.jp/eamat/
 *   Tuckn(forked) https://github.com/tuckn/AhkIME
 * @Email tuckn333@gmail.com
 */

/**
 * @Class IME
 * @Description The IME object contains methods for parsing IME
 * @Methods
 *   IsEnabling(...) - Check IME status whether enabling or disabling
 *   IsConverting(...) - Check IME status whether converting
 *   SwitchIME(...) - Switch IME status to enabled/disabled
 *   SwitchInsMode(...) - s: "ON" / "OFF" / others is switch
 */
class IME
{
  /**
   * @Method IsEnabling
   * @Description Check IME status whether enabling or disabling {{{
   * @Syntax value := IME.IsEnabling([WinTitle])
   * @Param {String} [WinTitle="A"]
   * @Return {Number}  0: disableing, 1: enableing
   * @Link http://www6.atwiki.jp/eamat/pages/17.html
   */
  class IsEnabling extends IME.Functor
  {
    Call(self, WinTitle="A")
    {
      ControlGet, hwnd, HWND, , , %WinTitle%

      if (WinActive(WinTitle)) {
        ptrSize := !A_PtrSize ? 4 : A_PtrSize
        VarSetCapacity(stGTI, cbSize:=4+4+(PtrSize*6)+16, 0)
        NumPut(cbSize, stGTI,  0, "UInt")   ;   DWORD   cbSize;
        hwnd := DllCall("GetGUIThreadInfo", Uint,0, Uint,&stGTI)
            ? NumGet(stGTI,8+PtrSize,"UInt") : hwnd
      }

      Return DllCall("SendMessage"
          , UInt, DllCall("imm32\ImmGetDefaultIMEWnd", Uint,hwnd)
          , UInt, 0x0283  ;Message : WM_IME_CONTROL
          ,  Int, 0x0005  ;wParam  : IMC_GETOPENSTATUS
          ,  Int, 0)      ;lParam  : 0
    }
  } ; }}}

  /**
   * @Method IsConverting
   * @Description Check IME status whether converting {{{
   * @Syntax value := IME.IsConverting([WinTitle, ConvCls, CandCls])
   * @Param {String} [WinTitle="A"]
   * @Param {String} [ConvCls=""]
   * @Param {String} [CandCls=""]
   * @Return {Number}  1: Converting, 2: Have converting window, 0: Others
   * @Link http://www6.atwiki.jp/eamat/pages/17.html
   */
  class IsConverting extends IME.Functor
  {
    Call(self, WinTitle="A", ConvCls="", CandCls="")
    {
      ; Input windows, candidate windows (Add new IME with "|")
      ConvCls .= (ConvCls ? "|" : "")                 ;--- Input Window ---
        .  "ATOK\d+CompStr"                           ; ATOK
        .  "|imejpstcnv\d+"                           ; MS-IME
        .  "|WXGIMEConv"                              ; WXG
        .  "|SKKIME\d+\.*\d+UCompStr"                 ; SKKIME Unicode
        .  "|MSCTFIME Composition"                    ; Google IME
      CandCls .= (CandCls ? "|" : "")                 ;--- Candidate Window ---
        .  "ATOK\d+Cand"                              ; ATOK
        .  "|imejpstCandList\d+|imejpstcand\d+"       ; MS-IME 2002(8.1)XP
        .  "|mscandui\d+\.candidate"                  ; MS Office IME-2007
        .  "|WXGIMECand"                              ; WXG
        .  "|SKKIME\d+\.*\d+UCand"                    ; SKKIME Unicode
     CandGCls := "GoogleJapaneseInputCandidateWindow" ; Google IME

      ControlGet, hwnd, HWND, , , %WinTitle%

      if (WinActive(WinTitle)) {
        ptrSize := !A_PtrSize ? 4 : A_PtrSize
        VarSetCapacity(stGTI, cbSize:=4+4+(PtrSize*6)+16, 0)
        NumPut(cbSize, stGTI,  0, "UInt")   ;   DWORD   cbSize;
        hwnd := DllCall("GetGUIThreadInfo", Uint,0, Uint,&stGTI)
          ? NumGet(stGTI,8+PtrSize,"UInt") : hwnd
      }

      WinGet, pid, PID,% "ahk_id " hwnd
      tmm:=A_TitleMatchMode
      SetTitleMatchMode, RegEx
      ret := WinExist("ahk_class " . CandCls . " ahk_pid " pid) ? 2
          :  WinExist("ahk_class " . CandGCls                 ) ? 2
          :  WinExist("ahk_class " . ConvCls . " ahk_pid " pid) ? 1
          :  0
      SetTitleMatchMode, %tmm%
      Return ret
    }
  } ; }}}

  /**
   * @Method SwitchIME
   * @Description Switch IME status to enabled/disabled {{{
   * @Syntax value := IME.SwitchIME(SetSts, [WinTitle])
   * @Param {Number or String} [SetSts=0] 0/Off, 1/On
   * @Return {Number}  0: Success, other for non-success
   * @Link http://www6.atwiki.jp/eamat/pages/17.html
   */
  class SwitchIME extends IME.Functor
  {
    Call(self, SetSts:=0, WinTitle:="A")
    {
      if (SetSts = "Off") {
        SetSts := 0
      } else if (SetSts = "On") {
        SetSts := 1
      }

      ControlGet, hwnd, HWND, , , %WinTitle%

      if (WinActive(WinTitle)) {
        ptrSize := !A_PtrSize ? 4 : A_PtrSize
        VarSetCapacity(stGTI, cbSize:=4+4+(PtrSize*6)+16, 0)
        NumPut(cbSize, stGTI,  0, "UInt")   ;   DWORD   cbSize;
        hwnd := DllCall("GetGUIThreadInfo", Uint,0, Uint,&stGTI)
            ? NumGet(stGTI,8+PtrSize,"UInt") : hwnd
      }

      Return DllCall("SendMessage"
        , UInt, DllCall("imm32\ImmGetDefaultIMEWnd", Uint,hwnd)
        , UInt, 0x0283  ;Message : WM_IME_CONTROL
        ,  Int, 0x006   ;wParam  : IMC_SETOPENSTATUS
        ,  Int, SetSts) ;lParam  : 0 or 1
    }
  } ; }}}

  /**
   * @Method SwitchInsMode
   * @Description Switch IME Insert Mode {{{
   * @Syntax value := IME.SwitchInsMode([st])
   * @Param {String} st "ON":ON, "OFF":OFF, others:switch
   * @Return {Number}  0: Success, other for non-success
   * @Link https://autohotkey.com/board/topic/3430-how-to-switch-the-insert-key-reliably-to-insert-mode/
   */
  class SwitchInsMode extends IME.Functor
  {
    Call(self, st="")
    {
      ;"D"か"U"。どちらがInsキー押した状態かは場合によって違うようだ・・・
      ;"?":ReplaceモードON(Insキー押した状態) "?":逆
      GetKeyState, DO_INS_YN, Insert, T

      if ((st = "ON" && DO_INS_YN = "U")       ;指示:ON、状態:OFF
          || (st = "OFF" && DO_INS_YN = "D")  ;指示:OFF、状態:ON
          || (st != "ON" && st != "OFF"))     ;指示:switch
      {
        Send, {INSERT}
        ;ToolTip, %DO_INS_YN%
      }
    }
  } ; }}}

  class Functor
  {
    __Call(method, args*)
    {
    ; When casting to Call(), use a new instance of the "function object"
    ; so as to avoid directly storing the properties(used across sub-methods)
    ; into the "function object" itself.
      if (method == "")
        Return (new this).Call(args*)
      if (IsObject(method))
        Return (new this).Call(method, args*)
    }
  }
}

; vim:set foldmethod=marker commentstring=;%s :
