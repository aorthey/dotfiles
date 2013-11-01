import XMonad
import Data.Monoid
import System.Exit
import XMonad.Util.EZConfig
--import XMonad.Hooks.ManageHelpers
import XMonad.Config.Gnome
import XMonad.Hooks.SetWMName
import XMonad.Layout.WindowNavigation
import XMonad.Layout.ResizableTile
import XMonad.Config.Desktop (desktopLayoutModifiers)
import XMonad.Actions.FloatKeys 
import qualified XMonad.StackSet as W
import qualified Data.Map        as M
 
-- The preferred terminal program, which is used in a binding below and by
-- certain contrib modules.
--
--myTerminal      = "xterm"
myTerminal      = "gnome-terminal"
 
-- Whether focus follows the mouse pointer.
myFocusFollowsMouse :: Bool
myFocusFollowsMouse = False
 
-- Width of the window border in pixels.
--
myBorderWidth   = 6
 
-- modMask lets you specify which modkey you want to use. The default
-- is mod1Mask ("left alt").  You may also consider using mod3Mask
-- ("right alt"), which does not conflict with emacs keybindings. The
-- "windows key" is usually mod4Mask.
--
myModMask       = mod1Mask
strgMask        = xK_Control_L
 
-- NOTE: from 0.9.1 on numlock mask is set automatically. The numlockMask
-- setting should be removed from configs.
--
-- You can safely remove this even on earlier xmonad versions unless you
-- need to set it to something other than the default mod2Mask, (e.g. OSX).
--
-- The mask for the numlock key. Numlock status is "masked" from the
-- current modifier status, so the keybindings will work with numlock on or
-- off. You may need to change this on some systems.
--
-- You can find the numlock modifier by running "xmodmap" and looking for a
-- modifier with Num_Lock bound to it:
--
-- > $ xmodmap | grep Num
-- > mod2        Num_Lock (0x4d)
--
-- Set numlockMask = 0 if you don't have a numlock key, or want to treat
-- numlock status separately.
--
-- myNumlockMask   = mod2Mask -- deprecated in xmonad-0.9.1
------------------------------------------------------------
 
 
-- The default number of workspaces (virtual screens) and their names.
-- By default we use numeric strings, but any string may be used as a
-- workspace name. The number of workspaces is determined by the length
-- of this list.
--
-- A tagging example:
--
-- > workspaces = ["web", "irc", "code" ] ++ map show [4..9]
--
myWorkspaces    = ["1","2","3","4","5","6","7","8","9"]
 
-- Border colors for unfocused and focused windows, respectively.
--
myNormalBorderColor  = "#000000"
myFocusedBorderColor = "#ff0000"
 
------------------------------------------------------------------------
-- Key bindings. Add, modify or remove key bindings here.
--
myKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList $
 

    --
    -- mod-[1..9], Switch to workspace N
    --
    -- mod-[1..9], Switch to workspace N
    -- mod-shift-[1..9], Move client to workspace N
    --
    [((m .|. modm, k), windows $ f i)
         | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
        , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]
     ++
 
    --
    -- mod-{w,e,r}, Switch to physical/Xinerama screens 1, 2, or 3
    -- mod-shift-{w,e,r}, Move client to screen 1, 2, or 3
    --
    [((m .|. modm, key), screenWorkspace sc >>= flip whenJust (windows . f))
         | (key, sc) <- zip [xK_w, xK_e, xK_r] [0..]
        , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]

    ++
    -- launch a terminal
    [ ((modm .|. shiftMask, xK_Return), spawn $ XMonad.terminal conf)
 
    , ((modm,               xK_p     ), spawn "exe=`dmenu_path | dmenu` && eval \"exec $exe\"")
 
    ,  ((modm .|. shiftMask, xK_f), spawn "firefox")
    ,  ((modm .|. shiftMask, xK_v), spawn "vlc")
    ,  ((modm .|. shiftMask, xK_n), spawn "nautilus")
    ,  ((modm .|. shiftMask, xK_t), spawn "thunderbird")
    ,  ((modm .|. shiftMask, xK_s), spawn "skype")
    ,  ((modm .|. shiftMask, xK_g), spawn "gimp")
		--,	((modm .|. shiftMask, xK_p     ), spawn "gmrun")
 
    , ((modm , xK_d     ), kill)
 
     -- Rotate through the available layout algorithms
    , ((modm,               xK_space ), sendMessage NextLayout)
 
    --  Reset the layouts on the current workspace to default
    , ((modm .|. shiftMask, xK_space ), setLayout $ XMonad.layoutHook conf)
    , ((modm,               xK_n     ), refresh)
 
    , ((modm,               xK_Tab   ), windows W.focusDown)
    , ((modm,               xK_m     ), windows W.focusMaster  )
    , ((modm,               xK_Return), windows W.swapMaster)
    

    , ((modm              , xK_comma ), sendMessage Expand)
    , ((modm              , xK_period), sendMessage Shrink)
    , ((modm .|. shiftMask, xK_comma ), sendMessage MirrorExpand)
   , ((modm .|. shiftMask, xK_period), sendMessage MirrorShrink)
   , ((modm .|. shiftMask, xK_b), spawn "gnome-session-quit --power-off --no-prompt --force")

    -- Push window back into tiling
    , ((modm,               xK_t     ), withFocused $ windows . W.sink)
    , ((modm,               xK_h     ), hKeyWindowBehaviour)
    , ((modm,               xK_l     ), lKeyWindowBehaviour)
    , ((modm,               xK_j     ), jKeyWindowBehaviour)
    , ((modm,               xK_k     ), kKeyWindowBehaviour)
    , ((modm .|. shiftMask, xK_h     ), hShiftKeyWindowBehaviour)
    , ((modm .|. shiftMask, xK_l     ), lShiftKeyWindowBehaviour)
    , ((modm .|. shiftMask, xK_j     ), jShiftKeyWindowBehaviour)
    , ((modm .|. shiftMask, xK_k     ), kShiftKeyWindowBehaviour)

    -- Quit xmonad
    --, ((modm .|. shiftMask, xK_w     ), io (exitWith ExitSuccess))
    -- Restart xmonad
    , ((modm .|. shiftMask              , xK_q     ), spawn "xmonad --recompile; xmonad --restart")
    ]where
	hKeyWindowBehaviour = withFocused (\w -> do
                              { floats <- gets (W.floating . windowset);
                                if w `M.member` floats
                                then withFocused (keysMoveWindow (-10,0))
                                else do sendMessage $ Go L
                              }) 
	lKeyWindowBehaviour = withFocused (\w -> do
                              { floats <- gets (W.floating . windowset);
                                if w `M.member` floats
                                then withFocused (keysMoveWindow (10,0))
                                else do sendMessage $ Go R
                              }) 
	jKeyWindowBehaviour = withFocused (\w -> do
                              { floats <- gets (W.floating . windowset);
                                if w `M.member` floats
                                then withFocused (keysMoveWindow (0,10))
                                else do sendMessage $ Go D
                              }) 
	kKeyWindowBehaviour = withFocused (\w -> do
                              { floats <- gets (W.floating . windowset);
                                if w `M.member` floats
                                then withFocused (keysMoveWindow (0,-10))
                                else do sendMessage $ Go U
                              }) 
-- Shift + Key Behaviours for floating and sinked windows
	hShiftKeyWindowBehaviour = withFocused (\w -> do
                              { floats <- gets (W.floating . windowset);
                                if w `M.member` floats
                                then withFocused (keysResizeWindow (10,0) (1,1))
                                else do sendMessage $ Swap L
                              }) 
	lShiftKeyWindowBehaviour = withFocused (\w -> do
                              { floats <- gets (W.floating . windowset);
                                if w `M.member` floats
                                then withFocused (keysResizeWindow (-10,0) (1,1))
                                else do sendMessage $ Swap R
                              }) 
	jShiftKeyWindowBehaviour = withFocused (\w -> do
                              { floats <- gets (W.floating . windowset);
                                if w `M.member` floats
                                then withFocused (keysResizeWindow (0,-10) (1,1))
                                else do sendMessage $ Swap D
                              }) 
	kShiftKeyWindowBehaviour = withFocused (\w -> do
                              { floats <- gets (W.floating . windowset);
                                if w `M.member` floats
                                then withFocused (keysResizeWindow (0,10) (1,1))
                                else do sendMessage $ Swap U
                              }) 
 
--
--
------------------------------------------------------------------------
-- Mouse bindings: default actions bound to mouse events
--
myMouseBindings (XConfig {XMonad.modMask = modm}) = M.fromList $
 
    -- mod-button1, Set the window to floating mode and move by dragging
    [ 
    --((modm, button1), (\w -> focus w >> mouseMoveWindow w >> windows W.shiftMaster))
 
    -- mod-button2, Raise the window to the top of the stack
    --, ((modm, button2), (\w -> focus w >> windows W.shiftMaster))
 
    -- mod-button3, Set the window to floating mode and resize by dragging
    --, ((modm, button3), (\w -> focus w >> mouseResizeWindow w >> windows W.shiftMaster))
 
    -- you may also bind events to the mouse scroll wheel (button4 and button5)
    ]
 
------------------------------------------------------------------------
-- Layouts:
 
-- You can specify and transform your layouts by modifying these values.
-- If you change layout bindings be sure to use 'mod-shift-space' after
-- restarting (with 'mod-q') to reset your layout state to the new
-- defaults, as xmonad preserves your old layout settings by default.
--
-- * NOTE: XMonad.Hooks.EwmhDesktops users must remove the obsolete
-- ewmhDesktopsLayout modifier from layoutHook. It no longer exists.
-- Instead use the 'ewmh' function from that module to modify your
-- defaultConfig as a whole. (See also logHook, handleEventHook, and -- startupHook ewmh notes.)
--
-- The available layouts.  Note that each layout is separated by |||,
-- which denotes layout choice.
--


--myLayout = windowNavigation (Tall 1 (3/100) (1/2)) ||| Full ||| desktopLayoutModifiers (Tall 1 0.03 0.5) ||| tiled ||| Full
myLayout = windowNavigation (desktopLayoutModifiers (tiled) ) ||| Full
  where
    -- default tiling algorithm partitions the screen into two panes
    tiled   = ResizableTall nmaster delta ratio []
 
    -- The default number of windows in the master pane
    nmaster = 1
 
    -- Default proportion of screen occupied by master pane
    ratio   = 1/2
 
    -- Percent of screen to increment by when resizing panes
    delta   = 3/100

 
------------------------------------------------------------------------
-- Window rules:
 
-- Execute arbitrary actions and WindowSet manipulations when managing
-- a new window. You can use this to, for example, always float a
-- particular program, or have a client always appear on a particular
-- workspace.
--
-- To find the property name associated with a program, use
-- > xprop | grep WM_CLASS
-- and click on the client you're interested in.
--
-- To match on the WM_NAME, you can use 'title' in the same way that
-- 'className' and 'resource' are used below.
--
--myManageHook = composeAll . concat $
--	[ [ resource  =? r --> doIgnore                    | r <- myIgnores ]
--	, [ className =? c --> doShift (myWorkspaces !! 1) | c <- myWebS    ]
--	, [ className =? c --> doShift (myWorkspaces !! 2) | c <- myCodeS   ]
--	, [ className =? c --> doShift (myWorkspaces !! 3) | c <- myGfxS    ]
--	, [ className =? c --> doShift (myWorkspaces !! 4) | c <- myChatS   ]
--	, [ className =? c --> doShift (myWorkspaces !! 9) | c <- myAlt3S   ]
--	, [ className =? c --> doCenterFloat               | c <- myFloatCC ]
--	, [ name      =? n --> doCenterFloat               | n <- myFloatCN ]
--	] where
--		name      = stringProperty "WM_NAME"
--		myIgnores = []
--		myWebS    = ["Chromium", "Firefox", "Opera"]
--		myCodeS   = ["NetBeans IDE 7.3"]
--		myChatS   = ["Pidgin", "Skype"]
--		myGfxS    = ["Gimp", "gimp", "GIMP"]
--		myAlt3S   = ["Amule", "Transmission-gtk"]
--		myFloatCC = ["MPlayer", "mplayer2", "File-roller", "zsnes", "Gcalctool", "Exo-helper-1"
--			    , "Gksu", "Galculator", "Nvidia-settings", "XFontSel", "XCalc", "XClock"
--			    , "Ossxmix", "Xvidcap", "Wicd-client.py"]
--		myFloatCN = ["Choose a file", "Open Image", "File Operation Progress", "Firefox Preferences"
--			    , "Preferences", "Search Engines", "Set up sync", "Passwords and Exceptions"
--			    , "Autofill Options", "Rename File", "Copying files", "Moving files"
--			    , "File Properties", "Replace", "Quit GIMP", "Change Foreground Color"
--			    , "Change Background Color", ""]
--		myFloatSN = ["Event Tester"]
--		myFocusDC = ["Event Tester", "Notify-osd"]
--		keepMaster c = assertSlave <+> assertMaster where
--			assertSlave = fmap (/= c) className --> doF W.swapDown
--			assertMaster = className =? c --> doF W.swapMaster
myManageHook = composeAll
    [ manageHook gnomeConfig
    --, className =? "tilda"           --> doFloat
    , className =? "Unity-2d-shell" --> doIgnore
    , className =? "Unity-2d-launcher" --> doIgnore
    , className =? "Unity-2d-panel" --> doIgnore
    , (role =? "gimp-toolbox" <||> role =? "gimp-image-window") --> (ask >>= doF . W.sink)
    , className =? "Gimp-2.6"           --> doShift "5"
    , className =? "Qtcreator"           --> doShift "3"
    , className =? "Inkscape"           --> doShift "5"
    , className =? "Thunderbird"           --> doShift "4"
    --, className =? "emulator-arm" --> doFloat
    ]
      where role = stringProperty "WM_WINDOW_ROLE"
--
------------------------------------------------------------------------
-- Event handling
 
-- Defines a custom handler function for X Events. The function should
-- return (All True) if the default handler is to be run afterwards. To
-- combine event hooks use mappend or mconcat from Data.Monoid.
--
-- * NOTE: EwmhDesktops users should use the 'ewmh' function from
-- XMonad.Hooks.EwmhDesktops to modify their defaultConfig as a whole.
-- It will add EWMH event handling to your custom event hooks by
-- combining them with ewmhDesktopsEventHook.
--
-- myEventHook = mempty
 
------------------------------------------------------------------------
-- Status bars and logging
 
-- Perform an arbitrary action on each internal state change or X event.
-- See the 'XMonad.Hooks.DynamicLog' extension for examples.
--
--
-- * NOTE: EwmhDesktops users should use the 'ewmh' function from
-- XMonad.Hooks.EwmhDesktops to modify their defaultConfig as a whole.
-- It will add EWMH logHook actions to your custom log hook by
-- combining it with ewmhDesktopsLogHook.
--
-- myLogHook = return ()
 
------------------------------------------------------------------------
-- Startup hook
 
-- Perform an arbitrary action each time xmonad starts or is restarted
-- with mod-q.  Used by, e.g., XMonad.Layout.PerWorkspace to initialize
-- per-workspace layout choices.
--
-- By default, do nothing.
--
-- * NOTE: EwmhDesktops users should use the 'ewmh' function from
-- XMonad.Hooks.EwmhDesktops to modify their defaultConfig as a whole.
-- It will add initialization of EWMH support to your custom startup
-- hook by combining it with ewmhDesktopsStartup.
--
--myStartupHook = return ()
 

------------------------------------------------------------------------
-- Now run xmonad with all the defaults we set up.
 
-- Run xmonad with the settings you specify. No need to modify this.
--
main = xmonad gnomeConfig {
      -- simple stuff
        terminal           = myTerminal,
        focusFollowsMouse  = myFocusFollowsMouse,
        borderWidth        = myBorderWidth,
      --  modMask            = myModMask,
        -- numlockMask deprecated in 0.9.1
        -- numlockMask        = myNumlockMask,
        workspaces         = myWorkspaces,
        normalBorderColor  = myNormalBorderColor,
        focusedBorderColor = myFocusedBorderColor,
        mouseBindings = myMouseBindings,
 
      -- key bindings
        keys               = myKeys,
 
      -- hooks, layouts
        layoutHook         = myLayout,
        manageHook         = myManageHook,
       -- handleEventHook    = myEventHook,
       -- logHook            = myLogHook
        startupHook        = setWMName "LG3D"
}
