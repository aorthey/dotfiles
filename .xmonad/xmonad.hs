import XMonad
import Data.Monoid
import System.Exit
import XMonad.Util.EZConfig
--import XMonad.Hooks.ManageHelpers
import XMonad.Config.Gnome
import XMonad.Hooks.SetWMName
import XMonad.Layout.IndependentScreens
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
 
myWorkspaces    = ["1","2","3","4","5","6","7","8","9"]
myNormalBorderColor  = "#000000"
myFocusedBorderColor = "#ff0000"
 
------------------------------------------------------------------------
myKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList $
 
    -- mod-[1..9], Switch to workspace N
    -- mod-shift-[1..9], Move client to workspace N
    -- mod-{w,e,r}, Switch to physical/Xinerama screens 1, 2, or 3
    -- mod-shift-{w,e,r}, Move client to screen 1, 2, or 3

    [((m .|. modm, k), windows $ f i)
         | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
        , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]
     ++
 
    [((m .|. modm, key), screenWorkspace sc >>= flip whenJust (windows . f))
         | (key, sc) <- zip [xK_w, xK_e, xK_r] [0..]
        , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]
    ++
    [ ((modm .|. shiftMask, xK_Return), spawn $ XMonad.terminal conf)
    , ((modm,               xK_p     ), spawn "exe=`dmenu_path | dmenu` && eval \"exec $exe\"")
    ,  ((modm .|. shiftMask, xK_f), spawn "firefox")
    ,  ((modm .|. shiftMask, xK_v), spawn "vlc")
    ,  ((modm .|. shiftMask, xK_n), spawn "nautilus")
    ,  ((modm .|. shiftMask, xK_t), spawn "thunderbird")
    ,  ((modm .|. shiftMask, xK_s), spawn "skype")
    ,  ((modm .|. shiftMask, xK_g), spawn "gimp")
    ,  ((modm .|. shiftMask, xK_w), spawn "gksudo virtualbox")
    ,  ((modm .|. shiftMask, xK_p), spawn "pkill ipython")
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
    , ((modm .|. shiftMask, xK_b     ), spawn "gnome-session-quit --power-off --no-prompt --force")
    , ((modm              , xK_Up    ), spawn "amixer -D pulse sset Master 5%+")
    , ((modm              , xK_Down  ), spawn "amixer -D pulse sset Master 5%-")

    -- Push window back into tiling
    --, ((modm, xK_f), withFocused $ windows . W.shiftMaster)
    , ((modm,               xK_f     ), windows W.shiftMaster)
    , ((modm,               xK_t     ), withFocused $ windows . W.sink)
    , ((modm,               xK_h     ), hKeyWindowBehaviour)
    , ((modm,               xK_l     ), lKeyWindowBehaviour)
    , ((modm,               xK_j     ), jKeyWindowBehaviour)
    , ((modm,               xK_k     ), kKeyWindowBehaviour)
    , ((modm .|. shiftMask, xK_h     ), hShiftKeyWindowBehaviour)
    , ((modm .|. shiftMask, xK_l     ), lShiftKeyWindowBehaviour)
    , ((modm .|. shiftMask, xK_j     ), jShiftKeyWindowBehaviour)
    , ((modm .|. shiftMask, xK_k     ), kShiftKeyWindowBehaviour)
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

 
myManageHook = composeAll
    [ manageHook gnomeConfig
    --, className =? "tilda"           --> doFloat
    , className =? "Unity-2d-shell" --> doIgnore
    , className =? "Unity-2d-launcher" --> doIgnore
    , className =? "Unity-2d-panel" --> doIgnore
    , (role =? "gimp-toolbox" <||> role =? "gimp-image-window") --> (ask >>= doF . W.sink)
    , className =? "Gimp"           --> doShift "5"
    , className =? "Qtcreator"           --> doShift "3"
    , className =? "Inkscape"           --> doShift "5"
    , className =? "Thunderbird"           --> doShift "4"
    , className =? "Virtualbox"           --> doShift "5"
    --, className =? "emulator-arm" --> doFloat
    ]
      where role = stringProperty "WM_WINDOW_ROLE"

------------------------------------------------------------------------
-- Now run xmonad with all the defaults we set up.
 
-- Run xmonad with the settings you specify. No need to modify this.
--
main = do
     xmonad $ gnomeConfig {
        terminal           = myTerminal,
        --focusFollowsMouse  = myFocusFollowsMouse,
        borderWidth        = myBorderWidth,
        workspaces         = myWorkspaces,
        normalBorderColor  = myNormalBorderColor,
        focusedBorderColor = myFocusedBorderColor,
        mouseBindings = myMouseBindings,
        keys               = myKeys,
        layoutHook         = myLayout,
       -- handleEventHook    = myEventHook,
       -- logHook            = myLogHook
        --startupHook        = setWMName "LG3D"
        manageHook         = myManageHook,
        startupHook        = setWMName "LG3D"
}
