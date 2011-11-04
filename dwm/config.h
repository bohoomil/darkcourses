/* See LICENSE file for copyright and license details. */

/* appearance */
static const char font[]            = "-xos4-terminus-medium-r-normal-*-12-120-72-72-c-*-iso10646-1";
static const char normbordercolor[] = "#0F2133";
static const char normbgcolor[]     = "#000C1A";
static const char normfgcolor[]     = "#8A9199";
static const char selbordercolor[]  = "#3A4759";
static const char selbgcolor[]      = "#8A9199"; 
static const char selfgcolor[]      = "#000C1A";
static const char urgentfgcolor[]   = "#B33E54";
static const char urgentbgcolor[]   = "#000000";

static const char* colors[][ColLast] = {
	// border          foreground   background
	{ normbordercolor, "#5E6875",   normbgcolor },  // 0 normal
	{ normbordercolor, "#993D3D",   normbgcolor },  // 1 error  red
	{ normbordercolor, "#3987BF",   normbgcolor },  // 2 delim  bright blue
	{ normbordercolor, "#4BA65A",   normbgcolor },  // 3 artist bright green
	{ normbordercolor, "#005999",   normbgcolor },  // 4 title  blue
	{ normbordercolor, "#A64286",   normbgcolor },  // 5 hot    bright magenta
	{ normbordercolor, "#B38F6B",   normbgcolor },  // 6 medium bright yellow
	{ normbordercolor, "#008080",   normbgcolor },  // 7 cool   cyan
};

static const unsigned int borderpx = 1;     /* border pixel of windows */
static const unsigned int snap     = 8;     /* snap pixel */
static const double shade          = 0.6;   /* opacity of unfocussed clients */
static const unsigned int gappx    = 0;     /* gap pixel between windows */
static const Bool showbar          = True;  /* False means no bar */
static const Bool topbar           = True;  /* False means bottom bar */
static const Bool monobar          = True;  /* Draw selected window title not inverse */
static const Bool barline          = True;  /* Draw a single line below the statusbar */
static const int nmaster           = 1;     /* default number of clients in the master area */
static const Bool systray_enable   = True;
static const int systray_spacing   = 1;

#include "other/togglefullscreen.c"
#include "other/bitmaps.h"

char sstrings[][30] = {
    "^[f4C4C4C;|^[f;",
    "^[f0F2133;:^[f;",
		"^[f3A4759;:^[f;",
    "^[f4C4C4C;·^[f;",
};

static const Rule rules[] = {
	/* class      instance    title     tags mask   isfloating monitor opacity  panel scratchpad */
	{ "Firefox",     NULL,    NULL,       1 << 0,     False,     -1,     -1, False, False },
	{ "Firefox",     NULL, "Downloads",   1 << 0,     True,      -1,     -1, False, False },
	{ "Firefox",     NULL, "Firefox Preferences",  1 << 0, True, -1,     -1, False, False }, 
	{ "Gimp",        NULL,    NULL,       1 << 1,     True,      -1,     -1, False, False },
	{ "Gtk2fontsel", NULL,    NULL,            0,     True,      -1,     -1, False, False },
	{ "Deadbeef",    NULL,    NULL,       1 << 1,     True,      -1,     -1, False, False },
	{ "XCalc",       NULL,    NULL,            0,     True,      -1,     -1, False, False },
	{ "XFontSel",    NULL,    NULL,            0,     True,      -1,     -1, False, False },
	{ "Rsvg-view",   NULL,    NULL,            0,     True,      -1,     -1, False, False },
	{  NULL,         NULL,  "Xdefaults Color Picker", 0,  True,  -1,     -1, False, False },
	{  NULL,         NULL, "NVIDIA X Server Settings", 0, True,  -1,     -1, False, False },
	{  NULL,         NULL,   "feh",            0,     True,      -1,     -1, False, False },
	{ "Xsane",       NULL,    NULL,       1 << 1,     True,      -1,     -1, False, False },
	{  NULL,         NULL,    "mutt",     1 << 0,     False,     -1,     -1, False, False },
	{ "MPlayer",     NULL,    NULL,            0,     True,      -1,     -1, False, False },
	{  NULL,         NULL,    "pad",           0,     True,      -1,     -1, False, False },
	{  NULL,         NULL,    "mc",            0,     True,      -1,     -1, False, False },
	{ "XTerm",       NULL,    NULL,            0,     True,      -1,     -1, False, False },
	{ "Gnome-font-viewer", NULL,  NULL,        0,     True,      -1,     -1, False, False },
};

/* layout(s) */
static const float mfact      = 0.65;       /* factor of master area size [0.05..0.95] */
static const Bool resizehints = False;      /* True means respect size hints in tiled resizals */
static const float attachmode = AttAsFirst; /* Attach Mode */

/* addons: layouts */
#include "layouts/bstack.c"                 /* bottom stack */

static const Layout layouts[] = {
	/* symbol     gap?    arrange function*/
	{ "[F]",      False,  NULL },          /* no layout function means floating behavior */
	{ "[T]",      False,  ntile },         /* first entry is default */
	{ "[S]",      False,  bstack },
	{ "[M]",      False,  monocle },
};

/* tagging */
static const Tag tags[] = {
	/* name layout        mfact, showbar, topbar, attachmode, nmaster */
	{ "[1]", &layouts[0], 0.65,    -1,      -1,     AttAside,    -1 },
	{ "[2]", &layouts[0], 0.5,     -1,      -1,     AttAside,    -1 },
	{ "[3]", &layouts[1], 0.5,     -1,      -1,     AttAside,    -1 },
	{ "[4]", &layouts[3], 0.5,     -1,      -1,     -1,          -1 },
};

/* addons: other */
#include "other/togglemax.c"
#include "other/push.c"

/* key definitions */
#define MODKEY Mod4Mask
#define TAGKEYS(KEY,TAG) \
	{ MODKEY,                       KEY,      view,           {.ui = 1 << TAG} }, \
	{ MODKEY|ShiftMask,             KEY,      toggleview,     {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask,           KEY,      tag,            {.ui = 1 << TAG} }, \
	{ MODKEY|ShiftMask|ControlMask, KEY,      toggletag,      {.ui = 1 << TAG} },

/* helper for spawning shell commands in the pre dwm-5.0 fashion */
#define SHCMD(cmd) { .v = (const char*[]){ "/bin/sh", "-c", cmd, NULL } }

#include "X11/XF86keysym.h"
/* commands */
static const char *dmenucmd[]  = { "dmenu-dwm", NULL };
static const char *termcmd[]   = { "urxvtc", "-title", "urxvt", NULL };
static const char *tmuxcmd[]   = { "urxvtc", "-title", "tmux", "-e", "tmux", "-f", "/home/bohoomil/.tmux.conf", NULL };
static const char *xtermcmd[]  = { "xterm", "-title", "xterm", NULL };
static const char *webbcmd[]   = { "firefox", "-title", "Firefox", NULL };
static const char *mailcmd[]   = { "urxvtc", "-title", "mutt", "-e", "mutt", NULL };
static const char *padcmd[]    = { "xterm", "-title", "pad", "-geometry", "78x12+10+800", NULL };
static const char *fmcmd[]     = { "urxvtc", "-title", "mc", "-fn", "xft:PragmataPro:Regular:pixelsize=13", "-fb", "xft:PragmataPro:Regular:pixelsize=13", "-fi", "xft:PragmataPro:Italic:pixelsize=13", "-fbi", "xft:PragmataPro:Italic:pixelsize=13", "-geometry", "102x36+0-0", "-e", "mc", NULL };
static const char *deadcmd[]   = { "deadbeef", NULL };
static const char *vimcmd[]    = { "vim-xt", NULL };
static const char *volup[]     = { "amixer", "-q", "sset", "PCM", "1+", NULL };
static const char *voldw[]     = { "amixer", "-q", "sset", "PCM", "1-", NULL };
static const char *volmt[]     = { "amixer", "-q", "sset", "PCM", "toggle", NULL };
static const char *quitcmd[]   = { "killall", "dwm-start", NULL };
static const char *sleepcmd[]  = { "sudo", "pm-suspend", NULL };
static const char *rebootcmd[] = { "sudo", "shutdown", "-r", "now", NULL };
static const char *haltcmd[]   = { "sudo", "shutdown", "-h", "now", NULL };

static Key keys[] = {
	/* modifier                   key       function          argument */
	/* requires togglefullscren.c  */
	{ MODKEY|ShiftMask,           XK_f,      togglefullscreen, {0} },
	/* moveresize */
	{ MODKEY,                     XK_Down,  moveresize, {.v = (int []){ 0, 10, 0, 0 }}},
	{ MODKEY,                     XK_Up,    moveresize, {.v = (int []){ 0, -10, 0, 0 }}},
	{ MODKEY,                     XK_Right, moveresize, {.v = (int []){ 10, 0, 0, 0 }}},
	{ MODKEY,                     XK_Left,  moveresize, {.v = (int []){ -10, 0, 0, 0 }}},
	{ MODKEY|ShiftMask,           XK_Down,  moveresize, {.v = (int []){ 0, 0, 0, 20 }}},
	{ MODKEY|ShiftMask,           XK_Up,    moveresize, {.v = (int []){ 0, 0, 0, -10 }}},
	{ MODKEY|ShiftMask,           XK_Right, moveresize, {.v = (int []){ 0, 0, 20, 0 }}},
	{ MODKEY|ShiftMask,           XK_Left,  moveresize, {.v = (int []){ 0, 0, -10, 0 }}},
	/* media keys */
	{ 0,                          XF86XK_AudioRaiseVolume,   spawn,  {.v = volup } },
	{ 0,                          XF86XK_AudioLowerVolume,   spawn,  {.v = voldw } },
	{ 0,                          XF86XK_AudioMute,          spawn,  {.v = volmt } },
	/* custom commands */
	{ 0,                          XK_Menu,   spawn,           {.v = dmenucmd } },
	{ MODKEY|ShiftMask,           XK_Return, spawn,           {.v = termcmd } },
	{ ControlMask|Mod1Mask,       XK_f,      spawn,           {.v = fmcmd} },
	{ ControlMask|Mod1Mask,       XK_t,      spawn,           {.v = tmuxcmd} },
	{ ControlMask|Mod1Mask,       XK_x,      spawn,           {.v = xtermcmd} },
	{ ControlMask|Mod1Mask,       XK_b,      spawn,           {.v = webbcmd} },
	{ ControlMask|Mod1Mask,       XK_m,      spawn,           {.v = mailcmd} },
	{ ControlMask|Mod1Mask,       XK_p,      spawn,           {.v = padcmd} },
//	{ ControlMask|Mod1Mask,       XK_n,      spawn,           {.v = mpdcmd} },
	{ ControlMask|Mod1Mask,       XK_d,      spawn,           {.v = deadcmd} },
	{ ControlMask|Mod1Mask,       XK_v,      spawn,           {.v = vimcmd} },
//	{ ControlMask|Mod1Mask,       XK_e,      spawn,           {.v = editcmd} },
	/* attach  */
	{ MODKEY|ControlMask,         XK_a,      setattachmode,   {.i = AttAsFirst } },
	{ MODKEY|ControlMask,         XK_l,      setattachmode,   {.i = AttAsLast } },
	{ MODKEY|ControlMask,         XK_q,      setattachmode,   {.i = AttAbove } },
	{ MODKEY|ControlMask,         XK_y,      setattachmode,   {.i = AttBelow } },
	{ MODKEY|ControlMask,         XK_s,      setattachmode,   {.i = AttAside } },
	/* */
	{ MODKEY,                     XK_b,      togglebar,       {0} },
	{ MODKEY,                     XK_j,      focusstack,      {.i = +1} },
	{ MODKEY,                     XK_k,      focusstack,      {.i = -1} },
	{ MODKEY,                     XK_h,      setmfact,        {.f = -0.05} },
	{ MODKEY,                     XK_l,      setmfact,        {.f = +0.05} },
	{ MODKEY|ControlMask,         XK_j,      pushdown,        {0} },
	{ MODKEY|ControlMask,         XK_k,      pushup,          {0} },
	{ MODKEY,                     XK_Return, zoom,            {0} },
	{ MODKEY,                     XK_Tab,    view,            {0} },
	{ MODKEY|ShiftMask,           XK_Tab,    focustoggle,     {0} },
	{ MODKEY|ShiftMask,           XK_c,      killclient,      {0} },
	{ MODKEY,                     XK_f,      setlayout,  {.v = &layouts[0]} }, /*float*/
	{ MODKEY,                     XK_t,      setlayout,  {.v = &layouts[1]} }, /*ntile*/
	{ MODKEY,                     XK_s,      setlayout,  {.v = &layouts[2]} }, /*bstack*/
	{ MODKEY,                     XK_m,      setlayout,  {.v = &layouts[3]} }, /*monocle*/
	{ MODKEY,                     XK_space,  setlayout,        {0} },
	{ MODKEY|ShiftMask,           XK_space,  togglefloating,   {0} },
	{ MODKEY|ControlMask,         XK_space,  toggle_scratch,   {0} },
	{ MODKEY|ShiftMask,           XK_h,      incnmaster,       {.i = +1} },
	{ MODKEY|ShiftMask,           XK_l,      incnmaster,       {.i = -1} },
	{ MODKEY,                     XK_x,      setnmaster,       {.i = 1} },
	{ MODKEY,                     XK_0,      view,             {.ui = ~0} },
	{ MODKEY|ShiftMask,           XK_0,      tag,              {.ui = ~0} },
	TAGKEYS(                      XK_1,                        0)
	TAGKEYS(                      XK_2,                        1)
	TAGKEYS(                      XK_3,                        2)
	TAGKEYS(                      XK_4,                        3)
	{ MODKEY|ShiftMask,             XK_q,    spawn,            {.v = quitcmd } },
//	{ MODKEY|ShiftMask,             XK_q,      quit,           {.i = 0} },
	{ MODKEY|ControlMask,           XK_q,      quit,           {.i = 23} },
	{ MODKEY|ControlMask|ShiftMask, XK_r,    spawn,            {.v = rebootcmd } },
	{ MODKEY|ControlMask|ShiftMask, XK_s,    spawn,            {.v = sleepcmd } },
	{ MODKEY|ControlMask|ShiftMask, XK_h,    spawn,            {.v = haltcmd } },
	/* monitor */
	{ MODKEY,                       XK_comma,  focusmon,       {.i = -1 } },
	{ MODKEY,                       XK_period, focusmon,       {.i = +1 } },
	{ MODKEY|ShiftMask,             XK_comma,  tagmon,         {.i = -1 } },
	{ MODKEY|ShiftMask,             XK_period, tagmon,         {.i = +1 } },
};

/* button definitions */
/* click can be ClkLtSymbol, ClkStatusText, ClkWinTitle, ClkClientWin, or ClkRootWin */
static Button buttons[] = {
	/* click              event mask      button     function        argument */
	{ ClkLtSymbol,        0,              Button1,   setlayout,      {0} },
	{ ClkLtSymbol,        0,              Button3,   setlayout,      {.v = &layouts[2]} },
	{ ClkWinTitle,        0,              Button1,   focusonclick,   {0} },
	{ ClkWinTitle,        0,              Button2,   zoom,           {0} },
	{ ClkStatusText,      0,              Button2,   spawn,          {.v = termcmd } },
	{ ClkClientWin,       MODKEY,         Button1,   movemouse,      {0} },
	{ ClkClientWin,       MODKEY,         Button2,   togglefloating, {0} },
	{ ClkClientWin,       MODKEY,         Button3,   resizemouse,    {0} },
	{ ClkTagBar,          0,              Button1,   view,           {0} },
	{ ClkTagBar,          0,              Button3,   toggleview,     {0} },
	{ ClkTagBar,          MODKEY,         Button1,   tag,            {0} },
	{ ClkTagBar,          MODKEY,         Button3,   toggletag,      {0} },
};
