/* See LICENSE file for copyright and license details.
 *
 * dynamic window manager is designed like any other X client as well. It is
 * driven through handling X events. In contrast to other X clients, a window
 * manager selects for SubstructureRedirectMask on the root window, to receive
 * events about window (dis-)appearance.  Only one X connection at a time is
 * allowed to select for this event mask.
 *
 * The event handlers of dwm are organized in an array which is accessed
 * whenever a new event has been fetched. This allows event dispatching
 * in O(1) time.
 *
 * Each child of the root window is called a client, except windows which have
 * set the override_redirect flag.  Clients are organized in a linked client
 * list on each monitor, the focus history is remembered through a stack list
 * on each monitor. Each client contains a bit array to indicate the tags of a
 * client.
 *
 * Keys and tagging rules are organized as arrays and defined in config.h.
 *
 * To understand everything else, start reading main().
 */
#include <errno.h>
#include <locale.h>
#include <stdarg.h>
#include <signal.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <X11/cursorfont.h>
#include <X11/keysym.h>
#include <X11/Xatom.h>
#include <X11/Xlib.h>
#include <X11/Xproto.h>
#include <X11/Xutil.h>
#ifdef XINERAMA
#include <X11/extensions/Xinerama.h>
#endif /* XINERAMA */

/* macros */
#define BUTTONMASK              (ButtonPressMask|ButtonReleaseMask)
#define CLEANMASK(mask)         (mask & ~(numlockmask|LockMask) & (ShiftMask|ControlMask|Mod1Mask|Mod2Mask|Mod3Mask|Mod4Mask|Mod5Mask))
#define INRECT(X,Y,RX,RY,RW,RH) ((X) >= (RX) && (X) < (RX) + (RW) && (Y) >= (RY) && (Y) < (RY) + (RH))
#define ISVISIBLE(C)            ((C->tags & C->mon->tagset[C->mon->seltags]))
#define LENGTH(X)               (sizeof X / sizeof X[0])
#define MAX(A, B)               ((A) > (B) ? (A) : (B))
#define MIN(A, B)               ((A) < (B) ? (A) : (B))
#define MOUSEMASK               (BUTTONMASK|PointerMotionMask)
#define WIDTH(X)                ((X)->w + 2 * (X)->bw)
#define HEIGHT(X)               ((X)->h + 2 * (X)->bw)
#define TAGMASK                 ((1 << LENGTH(tags)) - 1)
#define TEXTW(X)                (textnw(X, strlen(X)) + dc.font.height)
#define ROOT                    RootWindow(dpy, DefaultScreen(dpy))

/* enums */
enum { CurNormal, CurResize, CurMove, CurLast };        /* cursor */
enum { ColBorder, ColFG, ColBG, ColLast };              /* color */
enum { NetSupported, NetWMName, NetWMState,
       NetWMFullscreen, NetWMWindowOpacity, 
       NetSystemTray, NetActiveWindow, NetLast };                        /* EWMH atoms */
enum { WMProtocols, WMDelete, WMState, WMTakeFocus, WMLast };        /* default atoms */
enum { ClkTagBar, ClkLtSymbol, ClkStatusText, ClkWinTitle,
       ClkClientWin, ClkRootWin, ClkLast };             /* clicks */
enum { AttAsFirst, AttAsLast, AttAbove, AttBelow,       /* Attach modes */
       AttAside };
//enum { ColNorm, ColSel, ColUrg, ColErr, ColDelim,       /* more colors */
//       ColHot, ColMed, ColCool, NumColors };

typedef union {
	int i;
	unsigned int ui;
	float f;
	const void *v;
} Arg;

typedef struct {
	unsigned int click;
	unsigned int mask;
	unsigned int button;
	void (*func)(const Arg *arg);
	const Arg arg;
} Button;

typedef struct Monitor Monitor;
typedef struct Client Client;
struct Client {
	char name[256];
	float mina, maxa;
	int x, y, w, h;
	int oldx, oldy, oldw, oldh;
	int basew, baseh, incw, inch, maxw, maxh, minw, minh;
	int bw, oldbw;
	unsigned int tags;
	Bool isfixed, isfloating, isurgent, neverfocus, oldstate, isfullscreen, needresize, ispanel, isscratch;
	Client *next;
	Client *snext;
	Monitor *mon;
	Window win;
	double opacity;
};

typedef struct {
	int x, y, w, h;
	unsigned long norm[ColLast];
	unsigned long sel[ColLast];
	Drawable drawable;
	GC gc;
	struct {
		int ascent;
		int descent;
		int height;
		XFontSet set;
		XFontStruct *xfont;
	} font;
} DC; /* draw context */

typedef struct {
	unsigned int mod;
	KeySym keysym;
	void (*func)(const Arg *);
	const Arg arg;
} Key;

typedef struct {
	const char *symbol;
	Bool addgaps;
	void (*arrange)(Monitor *);
} Layout;

struct Monitor {
	char ltsymbol[16];
	float mfact;
	int num;
	int by;               /* bar geometry */
	int mx, my, mw, mh;   /* screen size */
	int wx, wy, ww, wh;   /* window area  */
	unsigned int seltags;
	unsigned int sellt;
	unsigned int tagset[2];
	Bool showbar;
	Bool topbar;
	Client *clients;
	Client *sel;
	Client *stack;
	Monitor *next;
	Window barwin;
	const Layout *lt[2];
	int curtag;
	int prevtag;
	int titlebarbegin;
	int titlebarend;
	const Layout **lts;
	double *mfacts;
	Bool *showbars;
	Bool *topbars;
	int *attachmodes;
	int *nmasters;
	Client **lastfocus;
        int primary;
};

typedef struct {
	const char *name;
	const Layout *layout;
	float mfact;
	int showbar;
	int topbar;
	int attachmode;
	int nmaster;
} Tag;

typedef struct {
	const char *class;
	const char *instance;
	const char *title;
	unsigned int tags;
	Bool isfloating;
	int monitor;
	double opacity;
	Bool ispanel;
	unsigned int isscratch;
} Rule;

typedef struct {
        //const unsigned char *bits;
        Pixmap pix;
        unsigned int bw;
        unsigned int bh;
} Bitmap;

typedef struct Systray Systray;
struct Systray {
   Window win;
   XRectangle geo;
   Systray *next, *prev;
};

/* function declarations */
static void applyrules(Client *c);
static Bool applysizehints(Client *c, int *x, int *y, int *w, int *h, Bool interact);
static void arrange(Monitor *m);
static void arrangemon(Monitor *m);
static void attachasfirst(Client *c);
static void attachaslast(Client *c);
static void attachabove(Client *c);
static void attachbelow(Client *c);
static void attachaside(Client *c);
static void attach(Client *c);
static void setattachmode(const Arg *arg);
static void attachstack(Client *c);
static void buttonpress(XEvent *e);
static void checkotherwm(void);
static void cleanup(void);
static void cleanupmon(Monitor *mon);
static void clearurgent(Client *c);
static void clientmessage(XEvent *e);
static void configure(Client *c);
static void configurenotify(XEvent *e);
static void configurerequest(XEvent *e);
static Monitor *createmon(int primary);
static void destroynotify(XEvent *e);
static void detach(Client *c);
static void detachstack(Client *c);
static void die(const char *errstr, ...);
static Monitor *dirtomon(int dir);
static void drawbar(Monitor *m);
static void drawbars(void);
static void drawsquare(Bool filled, Bool empty, Bool invert, unsigned long col[ColLast]);
static void drawtext(const char *text, unsigned long col[ColLast], Bool invert, Bool pad);
static void drawvline(unsigned long col[ColLast]);
static void drawhline(unsigned long col[ColLast], Monitor *m);
static void drawbox(int x, int y, int w, int h, unsigned long col);
static void drawgraph(int num, Bool h, unsigned long col[ColLast]);
static void drawimage(int image, unsigned long col[ColLast], int num, Bool h);
static void drawcoloredtext(Monitor *m, char *text);
//static void enternotify(XEvent *e);
static void expose(XEvent *e);
static void window_opacity_set(Client *c, double opacity);
static void focus(Client *c);
static void focusonclick(const Arg *arg);
static void focusin(XEvent *e);
static void focusmon(const Arg *arg);
static void focusstack(const Arg *arg);
static void focustoggle(const Arg *arg);
static unsigned long getcolor(const char *colstr);
static Bool getrootptr(int *x, int *y);
static long getstate(Window w);
static Bool gettextprop(Window w, Atom atom, char *text, unsigned int size);
static void grabbuttons(Client *c, Bool focused);
static void grabkeys(void);
static void initfont(const char *fontstr);
static void keypress(XEvent *e);
static void killclient(const Arg *arg);
static void manage(Window w, XWindowAttributes *wa);
static void toggle_scratch(const Arg *arg);
static void mappingnotify(XEvent *e);
static void maprequest(XEvent *e);
static void monocle(Monitor *m);
static void movemouse(const Arg *arg);
static Client *nexttiled(Client *c);
static void pop(Client *c);
static void propertynotify(XEvent *e);
static Monitor *ptrtomon(int x, int y);
static void quit(const Arg *arg);
static void resize(Client *c, int x, int y, int w, int h, Bool interact);
static void resizeclient(Client *c, int x, int y, int w, int h);
static void resizemouse(const Arg *arg);
static void restack(Monitor *m);
static void run(void);
static void scan(void);
static Bool sendevent(Client *c, Atom proto);
static void sendmon(Client *c, Monitor *m);
static void setclientstate(Client *c, long state);
static void setfocus(Client *c);
static void setlayout(const Arg *arg);
static void setmfact(const Arg *arg);
static void setnmaster(const Arg *arg);
static void incnmaster(const Arg *arg);
static void setup(void);
static void showhide(Client *c);
static void sigchld(int unused);
static void spawn(const Arg *arg);
static Bool systray_acquire(void);
static void systray_add(Window win);
static void systray_del(Systray *s);
static void systray_freeicons(void);
static Systray* systray_find(Window win);
static int systray_get_width(void);
static void systray_update(void);
static void tag(const Arg *arg);
static void tagmon(const Arg *arg);
static int textnw(const char *text, unsigned int len);
static int coloredtextw(const char *text/*, unsigned int len*/);
static void ntile(Monitor *);
static void togglebar(const Arg *arg);
static void togglefloating(const Arg *arg);
static void toggletag(const Arg *arg);
static void toggleview(const Arg *arg);
static void unfocus(Client *c, Bool setfocus);
static void unmanage(Client *c, Bool destroyed);
static void unmapnotify(XEvent *e);
static Bool updategeom(void);
static void updatebarpos(Monitor *m);
static void updatebars(void);
static void updatenumlockmask(void);
static void updatesizehints(Client *c);
static void updatestatus(void);
static void updatetitle(Client *c);
static void updatewmhints(Client *c);
static void view(const Arg *arg);
static Client *wintoclient(Window w);
static Monitor *wintomon(Window w);
static int xerror(Display *dpy, XErrorEvent *ee);
static int xerrordummy(Display *dpy, XErrorEvent *ee);
static int xerrorstart(Display *dpy, XErrorEvent *ee);
static void zoom(const Arg *arg);
static void moveresize(const Arg *arg);

/* variables */
static const char broken[] = "broken";
static char stext[512];
static int screen;
static int sw, sh;           /* X display screen geometry width, height */
static int bh, blw = 0;      /* bar geometry */
static int (*xerrorxlib)(Display *, XErrorEvent *);
static unsigned int numlockmask = 0;
static void (*handler[LASTEvent]) (XEvent *) = {
	[ButtonPress] = buttonpress,
	[ClientMessage] = clientmessage,
	[ConfigureRequest] = configurerequest,
	[ConfigureNotify] = configurenotify,
	[DestroyNotify] = destroynotify,
	//[EnterNotify] = enternotify,
	[Expose] = expose,
	[FocusIn] = focusin,
	[KeyPress] = keypress,
	[MappingNotify] = mappingnotify,
	[MapRequest] = maprequest,
	[PropertyNotify] = propertynotify,
	[UnmapNotify] = unmapnotify
};
static Atom wmatom[WMLast], netatom[NetLast];
static Bool running = True;
static Client *scratch = NULL;
static Bool isscratched = False;
static int exitcode = 0;
static Cursor cursor[CurLast];
static Display *dpy;
static DC dc;
static Monitor *mons = NULL, *selmon = NULL;
static Window root;
static unsigned long *barcolors;
//static char sstrings[];

/* configuration, allows nested code to access above variables */
#include "config.h"

/* moveresize */
static void moveresize(const Arg *arg) {

XEvent ev;
Monitor *m = selmon;

//if(!(m->sel && arg && arg->v && m->sel->isfloating))
//    return;

/* moveresize */
/* automatically toggle floating when move/resize */
if(!(m->sel && arg && arg->v))
    return;
if(m->lt[m->sellt]->arrange && !m->sel->isfloating)
    togglefloating(NULL);

resize(m->sel, m->sel->x + ((int *)arg->v)[0],
    m->sel->y + ((int *)arg->v)[1],
    m->sel->w + ((int *)arg->v)[2],
    m->sel->h + ((int *)arg->v)[3],
    True);

while(XCheckMaskEvent(dpy, EnterWindowMask, &ev));

}

//static Pixmap bmaps[LENGTH(bitmaps)];

/* compile-time check if all tags fit into an unsigned int bit array. */
struct NumTags { char limitexceeded[LENGTH(tags) > 31 ? -1 : 1]; };

#define XEMBED_EMBEDDED_NOTIFY  0
#define IFREE(x)                if(x) free(x)
#define zcalloc(size)           calloc(1, (size))
 
Systray *trayicons;
Window traywin;

/* function implementations */
void
applyrules(Client *c) {
	const char *class, *instance;
	unsigned int i;
	const Rule *r;
	Monitor *m;
	XClassHint ch = { 0 };

	/* rule matching */
	c->isfloating = c->ispanel = c->isscratch = c->tags = 0;
	if(XGetClassHint(dpy, c->win, &ch)) {
		class = ch.res_class ? ch.res_class : broken;
		instance = ch.res_name ? ch.res_name : broken;
		for(i = 0; i < LENGTH(rules); i++) {
			r = &rules[i];
			if((!r->title || strstr(c->name, r->title))
			&& (!r->class || strstr(class, r->class))
			&& (!r->instance || strstr(instance, r->instance)))
			{
				c->isfloating = r->isfloating;
				c->opacity = r->opacity;
				c->tags |= r->tags;
				for(m = mons; m && m->num != r->monitor; m = m->next);
				if(m)
					c->mon = m;
				c->ispanel = r->ispanel;
				if(!c->ispanel)
					c->isscratch = r->isscratch;
			}
		}
		if(ch.res_class)
			XFree(ch.res_class);
		if(ch.res_name)
			XFree(ch.res_name);
	}
	//c->tags = c->tags & TAGMASK ? c->tags & TAGMASK : c->mon->tagset[c->mon->seltags];
	// Why?
    if(!c->tags && !c->ispanel && !c->isscratch)
		c->tags = c->tags & TAGMASK ? c->tags & TAGMASK : c->mon->tagset[c->mon->seltags];
}

Bool
applysizehints(Client *c, int *x, int *y, int *w, int *h, Bool interact) {
	Bool baseismin;
	Monitor *m = c->mon;

	/* set minimum possible */
	*w = MAX(1, *w);
	*h = MAX(1, *h);
	if(interact) {
		if(*x > sw)
			*x = sw - WIDTH(c);
		if(*y > sh)
			*y = sh - HEIGHT(c);
		if(*x + *w + 2 * c->bw < 0)
			*x = 0;
		if(*y + *h + 2 * c->bw < 0)
			*y = 0;
	}
	else {
		if(*x > m->mx + m->mw)
			*x = m->mx + m->mw - WIDTH(c);
		if(*y > m->my + m->mh)
			*y = m->my + m->mh - HEIGHT(c);
		if(*x + *w + 2 * c->bw < m->mx)
			*x = m->mx;
		if(*y + *h + 2 * c->bw < m->my)
			*y = m->my;
	}
	if(*h < bh)
		*h = bh;
	if(*w < bh)
		*w = bh;
	if(resizehints || c->isfloating) {
		/* see last two sentences in ICCCM 4.1.2.3 */
		baseismin = c->basew == c->minw && c->baseh == c->minh;
		if(!baseismin) { /* temporarily remove base dimensions */
			*w -= c->basew;
			*h -= c->baseh;
		}
		/* adjust for aspect limits */
		if(c->mina > 0 && c->maxa > 0) {
			if(c->maxa < (float)*w / *h)
				*w = *h * c->maxa + 0.5;
			else if(c->mina < (float)*h / *w)
				*h = *w * c->mina + 0.5;
		}
		if(baseismin) { /* increment calculation requires this */
			*w -= c->basew;
			*h -= c->baseh;
		}
		/* adjust for increment value */
		if(c->incw)
			*w -= *w % c->incw;
		if(c->inch)
			*h -= *h % c->inch;
		/* restore base dimensions */
		*w = MAX(*w + c->basew, c->minw);
		*h = MAX(*h + c->baseh, c->minh);
		if(c->maxw)
			*w = MIN(*w, c->maxw);
		if(c->maxh)
			*h = MIN(*h, c->maxh);
	}
	return *x != c->x || *y != c->y || *w != c->w || *h != c->h;
}

void
arrange(Monitor *m) {
	if(m) {
	    	showhide(m->stack);
	} else {
		for(m = mons; m; m = m->next)
			showhide(m->stack);
	}
	focus(NULL);
	if(m)
		arrangemon(m);
	else for(m = mons; m; m = m->next)
		arrangemon(m);
}

void
arrangemon(Monitor *m) {
	strncpy(m->ltsymbol, m->lt[m->sellt]->symbol, sizeof m->ltsymbol);
	if(m->lt[m->sellt]->arrange)
		m->lt[m->sellt]->arrange(m);
	restack(m);
}

void
attachasfirst(Client *c) {
	c->next = c->mon->clients;
	c->mon->clients = c;
}

void
attachaslast(Client *c) {
	Client *at;
	if(!c->mon->clients) {
		attachasfirst(c);
		return;
	}
	for(at = c->mon->clients; at->next; at = at->next);
	c->next = at->next;
	at->next = c;
}

void
attachabove(Client *c) {
	if(c->mon->sel == NULL /*|| c->mon->sel == c->mon->clients */|| c->mon->sel->isfloating) {
		attachasfirst(c);
		return;
	}

	Client *at;
	for (at = c->mon->clients; at->next != c->mon->sel; at = at->next);
	c->next = at->next;
	at->next = c;
}

void
attachbelow(Client *c) {
	if(!c->mon->sel /*|| c->mon->sel == c->mon->clients */|| c->mon->sel->isfloating) {
		attachaslast(c);
		return;
	}

	Client *at;
	for(at = c->mon->clients; at->next && at->next != c->mon->sel; at = at->next);
	if(at->next)
		at = at->next;
	c->next = at->next;
	at->next = c;
}

void
attachaside(Client *c) {
	Client *at = nexttiled(c->mon->clients);
	if(/*c->mon->sel == NULL || c->mon->sel->isfloating || */!at) {
		attachasfirst(c);
		return;
	}
	c->next = at->next;
	at->next = c;
}

void
attach(Client *c) {
	if(c->mon->attachmodes[c->mon->curtag] == AttAside)
		attachaside(c);
	else if(c->mon->attachmodes[c->mon->curtag] == AttBelow)
		attachbelow(c);
	else if(c->mon->attachmodes[c->mon->curtag] == AttAbove)
		attachabove(c);
	else if(c->mon->attachmodes[c->mon->curtag] == AttAsLast)
		attachaslast(c);
	else
		attachasfirst(c);
}

void
setattachmode(const Arg *arg) {
	if(!arg) return;
	selmon->attachmodes[selmon->curtag] = arg->i;
}

void
attachstack(Client *c) {
	c->snext = c->mon->stack;
	c->mon->stack = c;
}

void
buttonpress(XEvent *e) {
	unsigned int i, x, click;
	Arg arg = {0};
	Client *c;
	Monitor *m;
	XButtonPressedEvent *ev = &e->xbutton;

	click = ClkRootWin;
	/* focus monitor if necessary */
	if((m = wintomon(ev->window)) && m != selmon) {
		unfocus(selmon->sel, True);
		selmon = m;
		focus(NULL);
	}
	if(ev->window == selmon->barwin) {
		i = x = 0;
		do {
			x += TEXTW(tags[i].name);
		} while(ev->x >= x && ++i < LENGTH(tags));
		if(i < LENGTH(tags)) {
			click = ClkTagBar;
			arg.ui = 1 << i;
		}
		else if(ev->x < x + blw)
			click = ClkLtSymbol;
		else if(ev->x > selmon->wx + selmon->ww - selmon->titlebarend)
			click = ClkStatusText;
		else {
			arg.ui = ev->x;
 			click = ClkWinTitle;
		}
	}
	else if((c = wintoclient(ev->window))) {
		focus(c);
		click = ClkClientWin;
	}
	for(i = 0; i < LENGTH(buttons); i++)
		if(click == buttons[i].click && buttons[i].func && buttons[i].button == ev->button
		&& CLEANMASK(buttons[i].mask) == CLEANMASK(ev->state))
			buttons[i].func((click == ClkTagBar || click == ClkWinTitle) && buttons[i].arg.i == 0 ? &arg : &buttons[i].arg);
}

void
checkotherwm(void) {
	xerrorxlib = XSetErrorHandler(xerrorstart);
	/* this causes an error if some other window manager is running */
	XSelectInput(dpy, DefaultRootWindow(dpy), SubstructureRedirectMask);
	XSync(dpy, False);
	XSetErrorHandler(xerror);
	XSync(dpy, False);
}

void
cleanup(void) {
	Arg a = {.ui = 1};
	Layout foo = { "", False, NULL };
	Monitor *m;

	view(&a);
	selmon->lt[selmon->sellt] = &foo;
	for(m = mons; m; m = m->next)
		while(m->stack)
			unmanage(m->stack, False);
	if(dc.font.set)
		XFreeFontSet(dpy, dc.font.set);
	else
		XFreeFont(dpy, dc.font.xfont);
	XUngrabKey(dpy, AnyKey, AnyModifier, root);
	XFreePixmap(dpy, dc.drawable);
	XFreeGC(dpy, dc.gc);
	XFreeCursor(dpy, cursor[CurNormal]);
	XFreeCursor(dpy, cursor[CurResize]);
	XFreeCursor(dpy, cursor[CurMove]);
	while(mons)
		cleanupmon(mons);
	XSync(dpy, False);
	XSetInputFocus(dpy, PointerRoot, RevertToPointerRoot, CurrentTime);
}

void
cleanupmon(Monitor *mon) {
	Monitor *m;

	if(mon == mons)
		mons = mons->next;
	else {
		for(m = mons; m && m->next != mon; m = m->next);
		m->next = mon->next;
	}
	XUnmapWindow(dpy, mon->barwin);
	XDestroyWindow(dpy, mon->barwin);
	free(mon->mfacts);
	free(mon->lts);
	free(mon->showbars);
	free(mon->topbars);
	free(mon->attachmodes);
	free(mon->nmasters);
	free(mon->lastfocus);
	free(mon);
}

void
clearurgent(Client *c) {
	XWMHints *wmh;

	c->isurgent = False;
	if(!(wmh = XGetWMHints(dpy, c->win)))
		return;
	wmh->flags &= ~XUrgencyHint;
	XSetWMHints(dpy, c->win, wmh);
	XFree(wmh);
}

void
clientmessage(XEvent *e) {
	XClientMessageEvent *cme = &e->xclient;
	Client *c;

	if((c = wintoclient(cme->window))) {
		if(cme->message_type == netatom[NetWMState] && cme->data.l[1] == netatom[NetWMFullscreen]) {
			if(cme->data.l[0] && !c->isfullscreen) {
				XChangeProperty(dpy, cme->window, netatom[NetWMState], XA_ATOM, 32,
				                PropModeReplace, (unsigned char*)&netatom[NetWMFullscreen], 1);
				c->isfullscreen = True;
				c->oldstate = c->isfloating;
				c->oldbw = c->bw;
				c->bw = 0;
				c->isfloating = True;
				resizeclient(c, c->mon->mx, c->mon->my, c->mon->mw, c->mon->mh);
				XRaiseWindow(dpy, c->win);
			}
			else {
				XChangeProperty(dpy, cme->window, netatom[NetWMState], XA_ATOM, 32,
				                PropModeReplace, (unsigned char*)0, 0);
				c->isfullscreen = False;
				c->isfloating = c->oldstate;
				c->bw = c->oldbw;
				c->x = c->oldx;
				c->y = c->oldy;
				c->w = c->oldw;
				c->h = c->oldh;
				resizeclient(c, c->x, c->y, c->w, c->h);
				arrange(c->mon);
			}
		}
		else if(cme->message_type == netatom[NetActiveWindow]) {
			if(!ISVISIBLE(c)) {
				c->mon->seltags ^= 1;
				c->mon->tagset[c->mon->seltags] = c->tags;
			}
			pop(c);
		}
	}
	if(cme->window == traywin) {
		if(cme->data.l[1] == XEMBED_EMBEDDED_NOTIFY){
			systray_add(cme->data.l[2]);
			systray_update();
		}
	}
}

void
configure(Client *c) {
	XConfigureEvent ce;

	ce.type = ConfigureNotify;
	ce.display = dpy;
	ce.event = c->win;
	ce.window = c->win;
	ce.x = c->x;
	ce.y = c->y;
	ce.width = c->w;
	ce.height = c->h;
	ce.border_width = c->bw;
	ce.above = None;
	ce.override_redirect = False;
	XSendEvent(dpy, c->win, False, StructureNotifyMask, (XEvent *)&ce);
}

void
configurenotify(XEvent *e) {
	Monitor *m;
	XConfigureEvent *ev = &e->xconfigure;

	if(ev->window == root) {
		sw = ev->width;
		sh = ev->height;
		if(updategeom()) {
			if(dc.drawable != 0)
				XFreePixmap(dpy, dc.drawable);
			dc.drawable = XCreatePixmap(dpy, root, sw, bh, DefaultDepth(dpy, screen));
			updatebars();
			for(m = mons; m; m = m->next)
				XMoveResizeWindow(dpy, m->barwin, m->wx, m->by, m->ww, bh);
			arrange(NULL);
		}
	}
}

void
configurerequest(XEvent *e) {
	Client *c;
	Monitor *m;
	XConfigureRequestEvent *ev = &e->xconfigurerequest;
	XWindowChanges wc;

	if((c = wintoclient(ev->window))) {
		if(ev->value_mask & CWBorderWidth)
			c->bw = ev->border_width;
		else if(c->isfloating || !c->mon->lt[c->mon->sellt]->arrange) {
			m = c->mon;
			if(ev->value_mask & CWX)
				c->x = m->mx + ev->x;
			if(ev->value_mask & CWY)
				c->y = m->my + ev->y;
			if(ev->value_mask & CWWidth)
				c->w = ev->width;
			if(ev->value_mask & CWHeight)
				c->h = ev->height;
			if((c->x + c->w) > m->mx + m->mw && c->isfloating)
				c->x = m->mx + (m->mw / 2 - c->w / 2); /* center in x direction */
			if((c->y + c->h) > m->my + m->mh && c->isfloating)
				c->y = m->my + (m->mh / 2 - c->h / 2); /* center in y direction */
			if((ev->value_mask & (CWX|CWY)) && !(ev->value_mask & (CWWidth|CWHeight)))
				configure(c);
			if(ISVISIBLE(c))
				XMoveResizeWindow(dpy, c->win, c->x, c->y, c->w, c->h);
			else
				c->needresize=1;
		}
		else
			configure(c);
	}
	else {
		wc.x = ev->x;
		wc.y = ev->y;
		wc.width = ev->width;
		wc.height = ev->height;
		wc.border_width = ev->border_width;
		wc.sibling = ev->above;
		wc.stack_mode = ev->detail;
		XConfigureWindow(dpy, ev->window, ev->value_mask, &wc);
	}
	XSync(dpy, False);
}

Monitor *
createmon(int primary) {// this multimonitor pertag conf patch is awefull crude...
	Monitor *m;
	int i, numtags = LENGTH(tags) + 1;

#ifdef moretags
	Monitor *mm;
	int ii, mnum=0;
	if(mons) {
		for(mm=mons; mm->next; mm=mons->next);
		mnum = mm->num+1;
		if(mnum < LENGTH(moretags) / numtags) mnum = 0;
	}
#endif

	if(!(m = (Monitor *)calloc(1, sizeof(Monitor))))
		die("fatal: could not malloc() %u bytes\n", sizeof(Monitor));
	if(!(m->mfacts = calloc(sizeof(double), numtags)))
		die("fatal: could not malloc() %u bytes\n", sizeof(double) * numtags);
	if(!(m->lts = calloc(sizeof(Layout *), numtags)))
		die("fatal: could not malloc() %u bytes\n", sizeof(Layout *) * numtags);
	if(!(m->showbars = calloc(sizeof(Bool *), numtags)))
		die("fatal: could not malloc() %u bytes\n", sizeof(Bool *) * numtags);
	if(!(m->topbars = calloc(sizeof(Bool *), numtags)))
		die("fatal: could not malloc() %u bytes\n", sizeof(Bool *) * numtags);
	if(!(m->attachmodes = calloc(sizeof(int *), numtags)))
		die("fatal: could not malloc() %u bytes\n", sizeof(int *) * numtags);
	if(!(m->nmasters = calloc(sizeof(int *), numtags)))
		die("fatal: could not malloc() %u bytes\n", sizeof(int *) * numtags);
	if(!(m->lastfocus = calloc(sizeof(Client *), numtags)))
		die("fatal: could not malloc() %u bytes\n", sizeof(Client *) * numtags);
	m->tagset[0] = m->tagset[1] = 1;
	m->showbar = showbar;
	m->topbar = topbar;

	m->curtag = m->prevtag = 1;
	for(i = 1; i < numtags; i++) {
#ifdef moretags
		if(mnum) {
			m->mfacts[i] = moretags[ii - 1].mfact < 0 ? mfact : moretags[ii - 1].mfact;
			m->lts[i] = moretags[ii - 1].layout;
			m->showbars[i] = moretags[ii - 1].showbar < 0 ? showbar : moretags[ii - 1].showbar;
			m->topbars[i] = moretags[ii - 1].topbar < 0 ? topbar : moretags[ii - 1].topbar;
			m->attachmodes[i] = moretags[ii - 1].attachmode < 0 ? attachmode : moretags[ii - 1].attachmode;
			m->nmasters[i] = moretags[ii - 1].nmaster < 0 ? nmaster : moretags[ii - 1].nmaster;
			m->lastfocus[i] = NULL;
		} else {
#endif
			m->mfacts[i] = tags[i - 1].mfact < 0 ? mfact : tags[i - 1].mfact;
			m->lts[i] = tags[i - 1].layout;
			m->showbars[i] = tags[i - 1].showbar < 0 ? showbar : tags[i - 1].showbar;
			m->topbars[i] = tags[i - 1].topbar < 0 ? topbar : tags[i - 1].topbar;
			m->attachmodes[i] = tags[i - 1].attachmode < 0 ? attachmode : tags[i - 1].attachmode;
			m->nmasters[i] = tags[i - 1].nmaster < 0 ? nmaster : tags[i - 1].nmaster;
			m->lastfocus[i] = NULL;
#ifdef moretags
		}
#endif
	}
	m->lt[0] = m->lts[m->curtag];

	m->lt[1] = &layouts[1 % LENGTH(layouts)];
	strncpy(m->ltsymbol, m->lt[0]->symbol, sizeof m->ltsymbol);
	m->primary = primary;
	return m;
}

/*void
destroynotify(XEvent *e) {
	Client *c;
	XDestroyWindowEvent *ev = &e->xdestroywindow;

	if((c = wintoclient(ev->window)))
		unmanage(c, True);
}*/
void destroynotify(XEvent *e) {
   Client *c;
   Systray *s;
   XDestroyWindowEvent *ev = &e->xdestroywindow;

   if((c = wintoclient(ev->window))) unmanage(c, True);
   else if((s = systray_find(ev->window))){
      systray_del(s);
      systray_update();
   }
}

void
detach(Client *c) {
	Client **tc;

	for(tc = &c->mon->clients; *tc && *tc != c; tc = &(*tc)->next);
	*tc = c->next;
}

void
detachstack(Client *c) {
	Client **tc, *t;

	for(tc = &c->mon->stack; *tc && *tc != c; tc = &(*tc)->snext);
	*tc = c->snext;

	if(c == c->mon->sel) {
		for(t = c->mon->stack; t && !ISVISIBLE(t); t = t->snext);
		c->mon->sel = t;
	}
}

void
die(const char *errstr, ...) {
	va_list ap;

	va_start(ap, errstr);
	vfprintf(stderr, errstr, ap);
	va_end(ap);
	exit(EXIT_FAILURE);
}

Monitor *
dirtomon(int dir) {
	Monitor *m = NULL;

	if(dir > 0) {
		if(!(m = selmon->next))
			m = mons;
	}
	else {
		if(selmon == mons)
			for(m = mons; m->next; m = m->next);
		else
			for(m = mons; m->next != selmon; m = m->next);
	}
	return m;
}

void
drawbar(Monitor *m) {
	int x, a= 0, s= 0, ow, mw = 0, extra, tw, i;
	unsigned int n = 0, occ = 0, urg = 0;
	char posbuf[10];
	unsigned long *col;
	Client *c, *firstvis, *lastvis = NULL;
	DC seldc;

	for(c = m->clients; c; c = c->next) {
		if(ISVISIBLE(c))
                        n++;
		if(!c->ispanel && !c->isscratch) { // Yoda expressions they are!
                        occ |= c->tags;
			if(c->isurgent)
				urg |= c->tags;
		}
	}
	dc.x = 0;
	for(i = 0; i < LENGTH(tags); i++) {
		dc.w = TEXTW(tags[i].name);
		col = m->tagset[m->seltags] & 1 << i ? dc.sel : dc.norm;
		drawtext(tags[i].name, col, urg & 1 << i, True);
		drawsquare(m == selmon && (selmon->sel && !selmon->sel->ispanel && !selmon->sel->isscratch) && selmon->sel->tags & 1 << i, occ & 1 << i, urg & 1 << i, col);
		dc.x += dc.w;
	}
	dc.w = blw = TEXTW(m->ltsymbol);
	drawtext(m->ltsymbol, dc.norm, False, True);
	dc.x += dc.w;
	x = dc.x;
	m->titlebarbegin=dc.x;
	if(m == selmon) { /* status is only drawn on selected monitor */
		if(m->lt[m->sellt]->arrange == monocle){
			  dc.x= x;
			  for(c= nexttiled(m->clients), a= 0, s= 0; c; c= nexttiled(c->next), a++)
				if(c == m->stack)
					s = a;
			  if(!s && a)
				s = a;
			  snprintf(posbuf, LENGTH(posbuf), "[%d/%d]", s, a);
			  dc.w= TEXTW(posbuf);
			  drawtext(posbuf, dc.norm, False, True);
			  x= dc.x + dc.w;
		}

		dc.w = coloredtextw(stext);
		dc.x = m->ww - (dc.w + systray_get_width());
		if(dc.x < x) {
			dc.x = x;
			dc.w = m->ww - x;
		}
		m->titlebarend=dc.x;
		drawcoloredtext(m, stext);
	}
	else {
		dc.x = m->ww;
		m->titlebarend=dc.x;
	}

	for(c = m->clients; c && (!ISVISIBLE(c) || c->ispanel); c = c->next);
	firstvis = c;

	col = (m == selmon && !monobar) ? dc.sel : dc.norm;
	dc.w = dc.x - x;
	dc.x = x;

	if(n > 0) {
		mw = dc.w / n;
		extra = 0;
		seldc = dc;
		i = 0;

		while(c) {
			lastvis = c;
			if(!c->ispanel) {
				tw = TEXTW(c->name);
				if(tw < mw) extra += (mw - tw); else i++;
			}
			for(c = c->next; c && !ISVISIBLE(c); c = c->next);
		}

		if(i > 0) mw += extra / i;

		c = firstvis;
		x = dc.x;
	}
	m->titlebarbegin=dc.x;
	while(dc.w > bh) {
		if(c) {
			if(!c->ispanel) {
				ow = dc.w;
				tw = TEXTW(c->name);
				dc.w = MIN(ow, tw);

				if(dc.w > mw) dc.w = mw;
				if(m->sel == c) seldc = dc;
				if(c == lastvis) dc.w = ow;

				drawtext(c->name, col, False, True);
				if(c != firstvis && !c->ispanel) drawvline(col);
				drawsquare(c->isfixed, c->isfloating, False, col);

				dc.x += dc.w;
				dc.w = ow - dc.w;
			}
			for(c = c->next; c && !ISVISIBLE(c); c = c->next);
		} else {
			drawtext(NULL, dc.norm, False, True);
			break;
		}
	}

	if(m == selmon && m->sel && ISVISIBLE(m->sel)) {
		dc = seldc;
		drawtext(m->sel->name, monobar ? dc.sel : col, !monobar, True);
		if(m->sel != firstvis && monobar && (!c || !c->ispanel)) drawvline(col);
		drawsquare(m->sel->isfixed, m->sel->isfloating, !monobar, monobar ? dc.sel : col);
	}

	if(barline) drawhline(dc.sel, m);

	XCopyArea(dpy, dc.drawable, m->barwin, dc.gc, 0, 0, m->ww, bh, 0, 0);
	XSync(dpy, False);
}

void
drawbars(void) {
	Monitor *m;

	for(m = mons; m; m = m->next)
		drawbar(m);
}

void
drawsquare(Bool filled, Bool empty, Bool invert, unsigned long col[ColLast]) {
	int x;

	XSetForeground(dpy, dc.gc, col[invert ? ColBG : ColFG]);
	x = (dc.font.ascent + dc.font.descent + 2) / 4;
	if(filled)
		XFillRectangle(dpy, dc.drawable, dc.gc, dc.x+1, dc.y+1, x+1, x+1);
	else if(empty)
		XDrawRectangle(dpy, dc.drawable, dc.gc, dc.x+1, dc.y+1, x, x);
}

void
drawtext(const char *text, unsigned long col[ColLast], Bool invert, Bool pad) {
	char buf[256];
	int i, x, y, h, ph, len, olen;

	XSetForeground(dpy, dc.gc, col[invert ? ColFG : ColBG]);
	XFillRectangle(dpy, dc.drawable, dc.gc, dc.x, dc.y, dc.w, dc.h);
	if(!text)
		return;
	olen = strlen(text);
	h = dc.font.ascent + dc.font.descent;
	ph = pad ? h : 0;
	y = dc.y + (dc.h / 2) - (h / 2) + dc.font.ascent;
	x = dc.x + (ph / 2);
	/* shorten text if necessary */
	for(len = MIN(olen, sizeof buf); len && textnw(text, len) > dc.w - ph; len--);
	if(!len)
		return;
	memcpy(buf, text, len);
	if(len < olen)
		for(i = len; i && i > len - 3; buf[--i] = '.');
	XSetForeground(dpy, dc.gc, col[invert ? ColBG : ColFG]);
	if(dc.font.set)
		XmbDrawString(dpy, dc.drawable, dc.font.set, dc.gc, x, y, buf, len);
	else
		XDrawString(dpy, dc.drawable, dc.gc, x, y, buf, len);
}

void
drawvline(unsigned long col[ColLast]) {
	XGCValues gcv;

	gcv.foreground = col[ColBorder];
	XChangeGC(dpy, dc.gc, GCForeground, &gcv);
	XDrawLine(dpy, dc.drawable, dc.gc, dc.x, dc.y, dc.x, dc.y + (dc.font.ascent + dc.font.descent + 2));
}

void
drawhline(unsigned long col[ColLast], Monitor *m) {
	XGCValues gcv;
	int y;

	gcv.foreground = col[ColBorder];
	XChangeGC(dpy, dc.gc, GCForeground, &gcv);
	if(m->topbars[m->curtag])
		y = m->my + (dc.font.ascent + dc.font.descent + 2);
	else
		y = m->my + m->wy - (dc.font.ascent + dc.font.descent + 3);
	XDrawLine(dpy, dc.drawable, dc.gc, 0, y, m->mw, y);
}

void
drawbox(int x, int y, int w, int h, unsigned long col) {
	XGCValues gcv;
	XRectangle r = { dc.x, dc.y, dc.w, dc.h };

	gcv.foreground = col;
	XChangeGC(dpy, dc.gc, GCForeground, &gcv);

	r.x = dc.x + x;
	r.y = dc.y + y;
	r.width = w;
	r.height = h;

	XFillRectangles(dpy, dc.drawable, dc.gc, &r, 1);
	dc.x += w + x;
}

void
drawimage(int image, unsigned long col[ColLast], int num, Bool h) {
        int x, y;
        float v;

	if(image>=LENGTH(bitmaps)) {
	  printf("Pixmap %d not exists!", image);
	        return;
	}
	if(num<0) num = 0;
	if(num>9) num = 9;

        const Bitmap *bitmap = &bitmaps[image];

        y = dc.y + (dc.h / 2) - (bitmap->bh / 2);
        x = dc.x + 1;

	XSetBackground(dpy, dc.gc, col[2]);
	if(h) {
		v = bitmap->bw * (num / 9.0);
		if(v>0) {
			XSetForeground(dpy, dc.gc, col[1]);
			XCopyPlane(dpy, bitmap->pix, dc.drawable, dc.gc, 0, 0, v, bitmap->bh, x, y, 1);
		}
		if(v<bitmap->bw) {
			XSetForeground(dpy, dc.gc, col[0]);
			XCopyPlane(dpy, bitmap->pix, dc.drawable, dc.gc, v, 0, bitmap->bw-v+1, bitmap->bh, x+v, y, 1);
		}
	} else {
		v = bitmap->bh * ((9-num) / 9.0);
		if(v>0) {
			XSetForeground(dpy, dc.gc, col[0]);
			XCopyPlane(dpy, bitmap->pix, dc.drawable, dc.gc, 0, 0, bitmap->bw, v, x, y, 1);
		}
		if(v<bitmap->bh) {
			XSetForeground(dpy, dc.gc, col[1]);
			XCopyPlane(dpy, bitmap->pix, dc.drawable, dc.gc, 0, v, bitmap->bw, bitmap->bh-v+1, x, y+v, 1);
		}
	}
        dc.x += bitmap->bw + 2;
}


void
drawgraph(int num, Bool h, unsigned long col[ColLast]) {
	int x, n;
	float m, v;

	if(num<0) num = 0;
	if(num>9) num = 9;

	x = dc.font.ascent + dc.font.descent + 2;

	v = (num / 9.0);

	m = h ? (x * 2) : (x-2);
	n = m * v;

	if(h) {
		drawbox(1, x/4+1, n, x/2, col[1]);
		drawbox(0, x/4+1, m-n, x/2, col[0]);
	} else {
		drawbox(1, 1, x/3, m-n, col[0]);
		dc.x -= x/3;
		drawbox(0, 1+m-n, x/3, n, col[1]);
	}
	dc.x += 1;
}

void
drawcoloredtext(Monitor *m, char *text) {
	Bool first=True, h=True;
	char *buf = text, *ptr = buf, *rptr=0, c = 1;
	unsigned long col[ColLast],  lastcol[ColLast];
	int i, ox = dc.x, num, cn = 1, ii;

	for(i=0; i<ColLast; i++)
		col[i]=barcolors[i];

	while( *ptr || rptr ) {
		for( i = 0; *ptr && ( *ptr!='^' || ptr[1]!='[' ); i++, ptr++ );
		if( !*ptr && !rptr ) break;

		if( i ) {
			c=*ptr;
			*ptr=0;
			dc.w = m->ww - dc.x;
			drawtext(buf, col, False, first);
			dc.x += textnw(buf, i);// + textnw(&c,1);
			if( first ) dc.x += ( dc.font.ascent + dc.font.descent ) / 2;
			first = False;
			*ptr = c;
		} else if( first ) {
			ox = dc.x += textnw(&c,1);
		}
		if( !*ptr ) {
			buf = ptr = rptr;
			rptr = 0;
		}
		if(*ptr=='^' && ptr[1]=='[') {
			ptr+=2;
			for( i = 0; ptr[i] && ( ptr[i]!=';' ); i++ );
			if(i) {
				ptr[i] = 0;
				switch(*ptr) {
				case 'b':
					cn = 2;
				case 'f':
					if( i==7 || i==4 ) {
						c = *ptr;
						*ptr = '#';
						lastcol[cn] = col[cn];
						col[cn] = getcolor(ptr);
						*ptr = c;
					} else if( i>1 && i<=3 ) {
						num = atoi(ptr+1);
						lastcol[cn] = col[cn];
						if( num<LENGTH(colors) ) col[cn] = barcolors[num*3+cn];
					} else if( i==1 ) {
						col[cn] = lastcol[cn];
					} else {
						printf("Bad color sequence '%s'!", &ptr[1]);
					}
					cn = 1;
					break;
				case 'v':
					h = False;
				case 'h':
					if(i==2) {
						num=atoi(ptr+1);
						drawgraph(num, h, col);
					} else {
						printf("Bad bargraph sequence '%s'!", &ptr[1]);
					}
					h = True;
					break;
				case 'i':
					if(i>1) {
						num=atoi(ptr+1);
						drawimage(num, col, 9, True);
					} else {
						printf("Bad image sequence '%s'!", &ptr[1]);
					}
					h = True;
					break;
				case 'G':
					h = False;
				case 'g':
					for( ii = 1; ptr[ii] && ( ptr[ii]!=',' ); ii++ );
					if(i>3 && ii<i) {
						num=atoi(ptr+ii+1);
						ptr[ii]=0;
						drawimage(atoi(ptr+1), col, num, h);
						ptr[ii]=',';
					} else {
						printf("Bad image sequence '%s'!", &ptr[1]);
					}
					h = True;
					break;
				case 'd':
					ptr[i] = ';';
					rptr = ptr + i + 1;
					ptr = buf = sstrings[atoi(ptr+1)];
					i=-1;
					break;
				default:
					// Later
					break;
				}
				if(i>=0) {
					ptr[i] = ';';
					buf = ptr = ptr + i + 1;
				}
			}
			
		}
	}
	//if( !first ) dc.x-=(dc.font.ascent+dc.font.descent)/2;
	drawtext(buf, col, False, False);
	dc.x = ox;
}
/*
void
enternotify(XEvent *e) {
	Client *c;
	Monitor *m;
	XCrossingEvent *ev = &e->xcrossing;

	if((ev->mode != NotifyNormal || ev->detail == NotifyInferior) && ev->window != root)
		return;
	c = wintoclient(ev->window);
	m = c ? c->mon : wintomon(ev->window);
	if(m != selmon) {
		unfocus(selmon->sel, True);
		selmon = m;
	}
	else if(!c || c == selmon->sel)
		return;
	focus(c);
}
*/
void
expose(XEvent *e) {
	Monitor *m;
	XExposeEvent *ev = &e->xexpose;

	if(ev->count == 0 && (m = wintomon(ev->window)))
		drawbar(m);
}

void
window_opacity_set(Client *c, double opacity) {
	if(opacity >= 0 && opacity < 1) {
		unsigned long real_opacity[] = { opacity * 0xffffffff };
		XChangeProperty(dpy, c->win, netatom[NetWMWindowOpacity], XA_CARDINAL, 32, PropModeReplace, (unsigned char *)real_opacity, 1);
	}
	else
		XDeleteProperty(dpy, c->win, netatom[NetWMWindowOpacity]);
}

void
focus(Client *c) {
	if(!c || !ISVISIBLE(c) || c->ispanel)
		for(c = selmon->stack; c && (!ISVISIBLE(c) || c->ispanel); c = c->snext);
	if(!c) return;
	if(selmon->sel && selmon->sel != c)
		unfocus(selmon->sel, False);
	if(c->mon->sel && c!=c->mon->sel && c && (!root || (c->mon->sel->win!=root && c->win!=root)) ) window_opacity_set(c->mon->sel, c->opacity>1 ? c->opacity-1 : shade);
	if(c && c!=c->mon->sel && (!root || (c->win!=root)) ) window_opacity_set(c, c->opacity - (c->opacity>1 ? 1 : 0));
	if(c) {
		if(c->mon != selmon)
			selmon = c->mon;
		if(c->isurgent)
			clearurgent(c);
		detachstack(c);
		attachstack(c);
		grabbuttons(c, True);
		XSetWindowBorder(dpy, c->win, dc.sel[ColBorder]);
		setfocus(c);
	}
	else
		XSetInputFocus(dpy, root, RevertToPointerRoot, CurrentTime);
	c->mon->lastfocus[c->mon->curtag]=c->mon->sel;
	c->mon->sel = c;
	drawbars();
	if(c) window_opacity_set(c, c->opacity);
}

void
focusonclick(const Arg *arg) {
	int x, w, mw = 0, tw, n = 0, i = 0, extra = 0;
	Monitor *m = selmon;
	Client *c, *firstvis;

	for(c = m->clients; c && !ISVISIBLE(c); c = c->next);
	firstvis = c;

	for(c = m->clients; c; c = c->next)
		if (ISVISIBLE(c))
		    n++;
	if(n > 0) {
		mw = (m->titlebarend - m->titlebarbegin) / n;
		c = firstvis;
		while(c) {
			tw = TEXTW(c->name);
			if(tw < mw) extra += (mw - tw); else i++;
			for(c = c->next; c && !ISVISIBLE(c); c = c->next);
 		}
		if(i > 0) mw += extra / i;
	}

	x=m->titlebarbegin;

	c = firstvis;
        while(x < m->titlebarend) {
		if(c) {
			w=MIN(TEXTW(c->name), mw);
			if (x < arg->i && x+w > arg->i) {
				focus(c);
				restack(selmon);
				break;
			} else
				x+=w;

			for(c = c->next; c && !ISVISIBLE(c); c = c->next);
		} else {
			break;
		}
        }
}

void
focusin(XEvent *e) { /* there are some broken focus acquiring clients */
	XFocusChangeEvent *ev = &e->xfocus;

	if(selmon->sel && ev->window != selmon->sel->win)
		XSetInputFocus(dpy, selmon->sel->win, RevertToPointerRoot, CurrentTime);
}

void
focusmon(const Arg *arg) {
	Monitor *m;

	if(!mons->next)
		return;
	if((m = dirtomon(arg->i)) == selmon)
		return;
	unfocus(selmon->sel, True);
	selmon = m;
	focus(NULL);
}

void
focusstack(const Arg *arg) {
	Client *c = NULL, *i;

	if(!selmon->sel)
		return;
	if(arg->i > 0) {
		for(c = selmon->sel->next; c && (!ISVISIBLE(c) || c->ispanel); c = c->next);
		if(!c)
			for(c = selmon->clients; c && (!ISVISIBLE(c) || c->ispanel); c = c->next);
	}
	else {
		for(i = selmon->clients; i != selmon->sel; i = i->next)
			if(ISVISIBLE(i) && (!i || !i->ispanel))
				c = i;
		if(!c)
			for(; i; i = i->next)
				if(ISVISIBLE(i) && !i->ispanel)
					c = i;
	}
	if(c) {
		focus(c);
		restack(selmon);
	}
}

void
focustoggle(const Arg *arg) {
       if(selmon->sel && selmon->lastfocus[selmon->curtag]) {
               focus(selmon->lastfocus[selmon->curtag]);
               restack(selmon);
       }
}

unsigned long
getcolor(const char *colstr) {
	Colormap cmap = DefaultColormap(dpy, screen);
	XColor color;

	if(!XAllocNamedColor(dpy, cmap, colstr, &color, &color))
		printf("error, cannot allocate color '%s'\n", colstr);
	return color.pixel;
}

Bool
getrootptr(int *x, int *y) {
	int di;
	unsigned int dui;
	Window dummy;

	return XQueryPointer(dpy, root, &dummy, &dummy, x, y, &di, &di, &dui);
}

long
getstate(Window w) {
	int format;
	long result = -1;
	unsigned char *p = NULL;
	unsigned long n, extra;
	Atom real;

	if(XGetWindowProperty(dpy, w, wmatom[WMState], 0L, 2L, False, wmatom[WMState],
	                      &real, &format, &n, &extra, (unsigned char **)&p) != Success)
		return -1;
	if(n != 0)
		result = *p;
	XFree(p);
	return result;
}

Bool
gettextprop(Window w, Atom atom, char *text, unsigned int size) {
	char **list = NULL;
	int n;
	XTextProperty name;

	if(!text || size == 0)
		return False;
	text[0] = '\0';
	XGetTextProperty(dpy, w, &name, atom);
	if(!name.nitems)
		return False;
	if(name.encoding == XA_STRING)
		strncpy(text, (char *)name.value, size - 1);
	else {
		if(XmbTextPropertyToTextList(dpy, &name, &list, &n) >= Success && n > 0 && *list) {
			strncpy(text, *list, size - 1);
			XFreeStringList(list);
		}
	}
	text[size - 1] = '\0';
	XFree(name.value);
	return True;
}

void
grabbuttons(Client *c, Bool focused) {
	updatenumlockmask();
	{
		unsigned int i, j;
		unsigned int modifiers[] = { 0, LockMask, numlockmask, numlockmask|LockMask };
		XUngrabButton(dpy, AnyButton, AnyModifier, c->win);
		if(focused || c->ispanel) {
			for(i = 0; i < LENGTH(buttons); i++)
				if(buttons[i].click == ClkClientWin)
					for(j = 0; j < LENGTH(modifiers); j++)
						XGrabButton(dpy, buttons[i].button,
						            buttons[i].mask | modifiers[j],
						            c->win, False, BUTTONMASK,
						            GrabModeAsync, GrabModeSync, None, None); 
		}
		else
			XGrabButton(dpy, AnyButton, AnyModifier, c->win, False,
			            BUTTONMASK, GrabModeAsync, GrabModeSync, None, None); 
	}
}

void
grabkeys(void) {
	updatenumlockmask();
	{
		unsigned int i, j;
		unsigned int modifiers[] = { 0, LockMask, numlockmask, numlockmask|LockMask };
		KeyCode code;

		XUngrabKey(dpy, AnyKey, AnyModifier, root);
		for(i = 0; i < LENGTH(keys); i++) {
			if((code = XKeysymToKeycode(dpy, keys[i].keysym)))
				for(j = 0; j < LENGTH(modifiers); j++)
					XGrabKey(dpy, code, keys[i].mod | modifiers[j], root,
						 True, GrabModeAsync, GrabModeAsync);
		}
	}
}

void
initfont(const char *fontstr) {
	char *def, **missing;
	int n;

	missing = NULL;
	dc.font.set = XCreateFontSet(dpy, fontstr, &missing, &n, &def);
	if(missing) {
		while(n--)
			fprintf(stderr, "dwm: missing fontset: %s\n", missing[n]);
		XFreeStringList(missing);
	}
	if(dc.font.set) {
		XFontStruct **xfonts;
		char **font_names;

		dc.font.ascent = dc.font.descent = 0;
		XExtentsOfFontSet(dc.font.set);
		n = XFontsOfFontSet(dc.font.set, &xfonts, &font_names);
		while(n--) {
			dc.font.ascent = MAX(dc.font.ascent, (*xfonts)->ascent);
			dc.font.descent = MAX(dc.font.descent,(*xfonts)->descent);
			xfonts++;
		}
	}
	else {
		if(!(dc.font.xfont = XLoadQueryFont(dpy, fontstr))
		&& !(dc.font.xfont = XLoadQueryFont(dpy, "fixed")))
			die("error, cannot load font: '%s'\n", fontstr);
		dc.font.ascent = dc.font.xfont->ascent;
		dc.font.descent = dc.font.xfont->descent;
	}
	dc.font.height = dc.font.ascent + dc.font.descent;
}

#ifdef XINERAMA
static Bool
isuniquegeom(XineramaScreenInfo *unique, size_t n, XineramaScreenInfo *info) {
	while(n--)
		if(unique[n].x_org == info->x_org && unique[n].y_org == info->y_org
		&& unique[n].width == info->width && unique[n].height == info->height)
			return False;
	return True;
}
#endif /* XINERAMA */

void
keypress(XEvent *e) {
	unsigned int i;
	KeySym keysym;
	XKeyEvent *ev;

	ev = &e->xkey;
	keysym = XKeycodeToKeysym(dpy, (KeyCode)ev->keycode, 0);
	for(i = 0; i < LENGTH(keys); i++)
		if(keysym == keys[i].keysym
		&& CLEANMASK(keys[i].mod) == CLEANMASK(ev->state)
		&& keys[i].func)
			keys[i].func(&(keys[i].arg));
}

void
killclient(const Arg *arg) {
	if(!selmon->sel)
		return;
	if(!sendevent(selmon->sel, wmatom[WMDelete])) {
		return;
		XGrabServer(dpy);
		XSetErrorHandler(xerrordummy);
		XSetCloseDownMode(dpy, DestroyAll);
		XKillClient(dpy, selmon->sel->win);
		XSync(dpy, False);
		XSetErrorHandler(xerror);
		XUngrabServer(dpy);
	}
}

void
manage(Window w, XWindowAttributes *wa) {
	Client *c, *t = NULL;
	Window trans = None;
	XWindowChanges wc;
	Bool tainted;

	if(!(c = calloc(1, sizeof(Client))))
		die("fatal: could not malloc() %u bytes\n", sizeof(Client));
	c->win = w;
	updatetitle(c);
	c->opacity = -1;
	if(XGetTransientForHint(dpy, w, &trans) && (t = wintoclient(trans))) {
		c->mon = t->mon;
		c->tags = t->tags;
	}
	else {
		c->mon = selmon;
		applyrules(c);
	}
	/* geometry */         /* removed in patch http://hg.suckless.org/dwm/rev/5b4d7f3b03f9, dont sure about it... */
	c->x = c->oldx = wa->x;// + c->mon->wx;
	c->y = c->oldy = wa->y;// + c->mon->wy;
	c->w = c->oldw = wa->width;
	c->h = c->oldh = wa->height;
	c->oldbw = wa->border_width;
	if(c->w == c->mon->mw && c->h == c->mon->mh) {
		c->isfloating = True;
		c->x = c->mon->mx;
		c->y = c->mon->my;
		c->bw = 0;
	}
	else {
		if(c->x + WIDTH(c) > c->mon->mx + c->mon->mw)
			c->x = c->mon->mx + c->mon->mw - WIDTH(c);
		if(c->y + HEIGHT(c) > c->mon->my + c->mon->mh)
			c->y = c->mon->my + c->mon->mh - HEIGHT(c);
		c->x = MAX(c->x, c->mon->mx);
		/* only fix client y-offset, if the client center might cover the bar */
		c->y = MAX(c->y, ((c->mon->by == 0) && (c->x + (c->w / 2) >= c->mon->wx)
		           && (c->x + (c->w / 2) < c->mon->wx + c->mon->ww)) ? bh : c->mon->my);
		c->bw = borderpx;
	}

	updatetitle(c);

	if(c->ispanel)
		c->bw = 0;


	if(c->isscratch) {
		tainted = False;
		for(t = scratch; t; t = t->next)
			if(t->isscratch == c->isscratch)
				tainted = True;
		if(isscratched) // TODO: find scratched client and check !
			tainted = True;
		if(!tainted) {
			printf("not tainted\n");
			c->isfloating = 1;
			c->bw = 4*borderpx;
			c->x = (c->mon->mw - c->w) / 2;
			c->y = (c->mon->mh - c->h) / 2;
			c->next = NULL;

			if(scratch!=NULL) {
				for(t = scratch; t->next; t = t->next);
				t->next = c;
			} else {
				scratch = c;
			}
			isscratched = False;
		} else
			c->isscratch = False;
 	}

	wc.border_width = c->bw;
	XConfigureWindow(dpy, w, CWBorderWidth, &wc);
	XSetWindowBorder(dpy, w, dc.norm[ColBorder]);
	configure(c); /* propagates border_width, if size doesn't change */
	updatesizehints(c);

	if(c->isscratch) return;

	XSelectInput(dpy, w, EnterWindowMask|FocusChangeMask|PropertyChangeMask|StructureNotifyMask);
	grabbuttons(c, False);
	if(!c->isfloating)
		c->isfloating = c->oldstate = trans != None || c->isfixed;
	if(c->isfloating)
		XRaiseWindow(dpy, c->win);
	attach(c);
	attachstack(c);
	XMoveResizeWindow(dpy, c->win, c->x + 2 * sw, c->y, c->w, c->h); /* some windows require this */
	setclientstate(c, NormalState);
	arrange(c->mon);
	XMapWindow(dpy, c->win);
	focus(c);
}

void
toggle_scratch(const Arg *arg) {
	XWindowChanges wc;
	Client *t = NULL, *s = NULL, *p = NULL;


	if(isscratched) {
		for(t = selmon->clients; t; t = t->next) {
			if(t->isscratch == isscratched) {
				s = t;
			}
		}
		if(s) {
			unfocus(s, True);

			detach(s);
			detachstack(s);

			s->next = s->snext = NULL;
			XLowerWindow(dpy, s->win);

			XMoveWindow(dpy, s->win, s->x + 2 * sw, s->y);

			setclientstate(s, IconicState);

			focus(NULL);
			arrange(NULL);

			if(scratch==NULL) {
				scratch = s;
			} else {
				for(t = scratch; t->next; t = t->next);
				//if(t) 
				t->next = s;
				//else scratch = s;
			}
			if(arg->i==isscratched) {
				isscratched = False;
				return;
			} else
				isscratched = False;
		} else {
			isscratched = False;
			return;
		}
	}

	if(!scratch)
		return;

	p = NULL;
	for(t = scratch; t; t = t->next) {
		if(t->isscratch == arg->i) {
			s = t;
			if(p) p->next = t->next;
			else scratch = t->next;
		}
		if(!p) p = t;
		else p = p->next;
	}

	if(!s) return;

	s->tags = ~0;
	s->mon = selmon;

	s->x = s->mon->mx + (s->mon->mw - s->w) / 2;
	s->y = s->mon->my + (s->mon->mh - s->h) / 2;

	wc.border_width = s->bw;
	XConfigureWindow(dpy, s->win, CWBorderWidth, &wc);
	XSetWindowBorder(dpy, s->win, dc.norm[ColBorder]);

	XRaiseWindow(dpy, s->win);
	XMoveWindow(dpy, s->win, s->x, s->y);
	attachasfirst(s);
	attachstack(s);
	XMoveResizeWindow(dpy, s->win, s->x + 2 * s->bw, s->y, s->w, s->h); /* some windows require this */
	XMapWindow(dpy, s->win);
	setclientstate(s, NormalState);
	focus(s);

	isscratched = arg->i;
}

void
mappingnotify(XEvent *e) {
	XMappingEvent *ev = &e->xmapping;

	XRefreshKeyboardMapping(ev);
	if(ev->request == MappingKeyboard)
		grabkeys();
}

void
maprequest(XEvent *e) {
	static XWindowAttributes wa;
	XMapRequestEvent *ev = &e->xmaprequest;

	if(!XGetWindowAttributes(dpy, ev->window, &wa))
		return;
	if(wa.override_redirect)
		return;
	if(!wintoclient(ev->window))
		manage(ev->window, &wa);
}

void
monocle(Monitor *m) {
	unsigned int n = 0;
	Client *c;

	for(c = m->clients; c; c = c->next)
		if(ISVISIBLE(c))
			n++;
	if(n > 0) /* override layout symbol */
		snprintf(m->ltsymbol, sizeof m->ltsymbol, "[%d]", n);
	for(c = nexttiled(m->clients); c; c = nexttiled(c->next))
		resize(c, m->wx, m->wy, m->ww - 2 * c->bw, m->wh - 2 * c->bw, False);
}

void
movemouse(const Arg *arg) {
	int x, y, ocx, ocy, nx, ny;
	Client *c;
	Monitor *m;
	XEvent ev;

	if(!(c = selmon->sel))
		return;
	if (c->ispanel) return;
	restack(selmon);
	ocx = c->x;
	ocy = c->y;
	if(XGrabPointer(dpy, root, False, MOUSEMASK, GrabModeAsync, GrabModeAsync,
	None, cursor[CurMove], CurrentTime) != GrabSuccess)
		return;
	if(!getrootptr(&x, &y))
		return;
	do {
		XMaskEvent(dpy, MOUSEMASK|ExposureMask|SubstructureRedirectMask, &ev);
		switch(ev.type) {
		case ConfigureRequest:
		case Expose:
		case MapRequest:
			handler[ev.type](&ev);
			break;
		case MotionNotify:
			nx = ocx + (ev.xmotion.x - x);
			ny = ocy + (ev.xmotion.y - y);
			if(nx >= selmon->wx && nx <= selmon->wx + selmon->ww
			&& ny >= selmon->wy && ny <= selmon->wy + selmon->wh) {
				if(abs(selmon->wx - nx) < snap)
					nx = selmon->wx;
				else if(abs((selmon->wx + selmon->ww) - (nx + WIDTH(c))) < snap)
					nx = selmon->wx + selmon->ww - WIDTH(c);
				if(abs(selmon->wy - ny) < snap)
					ny = selmon->wy;
				else if(abs((selmon->wy + selmon->wh) - (ny + HEIGHT(c))) < snap)
					ny = selmon->wy + selmon->wh - HEIGHT(c);
				if(!c->isfloating && selmon->lt[selmon->sellt]->arrange
				&& (abs(nx - c->x) > snap || abs(ny - c->y) > snap))
					togglefloating(NULL);
			}
			if(!selmon->lt[selmon->sellt]->arrange || c->isfloating)
				resize(c, nx, ny, c->w, c->h, True);
			break;
		}
	} while(ev.type != ButtonRelease);
	XUngrabPointer(dpy, CurrentTime);
	if((m = ptrtomon(c->x + c->w / 2, c->y + c->h / 2)) != selmon) {
		sendmon(c, m);
		selmon = m;
		focus(NULL);
	}
}

Client *
nexttiled(Client *c) {
	for(; c && (c->isfloating || !ISVISIBLE(c)); c = c->next);
	return c;
}

void
pop(Client *c) {
	detach(c);
	attach(c);
	focus(c);
	arrange(c->mon);
}

Monitor *
ptrtomon(int x, int y) {
	Monitor *m;

	for(m = mons; m; m = m->next)
		if(INRECT(x, y, m->wx, m->wy, m->ww, m->wh))
			return m;
	return selmon;
}

void
propertynotify(XEvent *e) {
	Client *c;
	Window trans;
	XPropertyEvent *ev = &e->xproperty;

	if((ev->window == root) && (ev->atom == XA_WM_NAME))
		updatestatus();
	else if(ev->state == PropertyDelete)
		return; /* ignore */
	else if((c = wintoclient(ev->window))) {
		switch(ev->atom) {
		default: break;
		case XA_WM_TRANSIENT_FOR:
			if(!c->isfloating && (XGetTransientForHint(dpy, c->win, &trans)) && 
			   (c->isfloating = (wintoclient(trans)) != NULL))
				arrange(c->mon);
			break;
		case XA_WM_NORMAL_HINTS:
			updatesizehints(c);
			break;
		case XA_WM_HINTS:
			updatewmhints(c);
			drawbars();
			break;
		}
		if(ev->atom == XA_WM_NAME || ev->atom == netatom[NetWMName]) {
			updatetitle(c);
			if(c == c->mon->sel)
				drawbar(c->mon);
		}
	}
}

void
quit(const Arg *arg) {
	running = False;
	if(arg->i) exitcode = arg->i;
}

void
resize(Client *c, int x, int y, int w, int h, Bool interact) {
	if(applysizehints(c, &x, &y, &w, &h, interact)){
		resizeclient(c, x, y, w, h);
		}
}

void
resizeclient(Client *c, int x, int y, int w, int h) {
	XWindowChanges wc;
	//unsigned int gap = c->isfloating ? 0 : selmon->lt[selmon->sellt]->addgaps ? gappx : 0;
	unsigned int gap = c->isfloating ? 0 : c->mon->lt[c->mon->sellt]->addgaps ? gappx : 0;

	c->oldx = c->x; c->x = wc.x = x + gap;
	c->oldy = c->y; c->y = wc.y = y + gap;
	c->oldw = c->w; c->w = wc.width = w - (gap ? (x + w + (c->bw * 2) == c->mon->wx + c->mon->ww ? 2 : 1) * gap : 0);
	c->oldh = c->h; c->h = wc.height = h - (gap ? (y + h + (c->bw * 2) == c->mon->wy + c->mon->wh ? 2 : 1) * gap : 0);
	wc.border_width = (c->mon->lt[c->mon->sellt]->arrange == monocle && !c->isfloating) ? 0 : c->bw;
	if(c->mon->lt[c->mon->sellt]->arrange == monocle && !c->isfloating) {
//		c->w = wc.width+=2;
//		c->h = wc.height+=2;
//		borderless monocle:
		c->w = wc.width += borderpx * 2;
		c->h = wc.height += borderpx * 2;
	}
	XConfigureWindow(dpy, c->win, CWX|CWY|CWWidth|CWHeight|CWBorderWidth, &wc);
	configure(c);
	XSync(dpy, False);
}

void
resizemouse(const Arg *arg) {
	int ocx, ocy;
	int nw, nh;
	Client *c;
	Monitor *m;
	XEvent ev;

	if(!(c = selmon->sel))
		return;
	restack(selmon);
	ocx = c->x;
	ocy = c->y;
	if(XGrabPointer(dpy, root, False, MOUSEMASK, GrabModeAsync, GrabModeAsync,
	                None, cursor[CurResize], CurrentTime) != GrabSuccess)
		return;
	XWarpPointer(dpy, None, c->win, 0, 0, 0, 0, c->w + c->bw - 1, c->h + c->bw - 1);
	do {
		XMaskEvent(dpy, MOUSEMASK|ExposureMask|SubstructureRedirectMask, &ev);
		switch(ev.type) {
		case ConfigureRequest:
		case Expose:
		case MapRequest:
			handler[ev.type](&ev);
			break;
		case MotionNotify:
			nw = MAX(ev.xmotion.x - ocx - 2 * c->bw + 1, 1);
			nh = MAX(ev.xmotion.y - ocy - 2 * c->bw + 1, 1);
			if(c->mon->wx + nw >= selmon->wx && c->mon->wx + nw <= selmon->wx + selmon->ww
			&& c->mon->wy + nh >= selmon->wy && c->mon->wy + nh <= selmon->wy + selmon->wh)
			{
				if(!c->isfloating && selmon->lt[selmon->sellt]->arrange
				&& (abs(nw - c->w) > snap || abs(nh - c->h) > snap))
					togglefloating(NULL);
			}
			if(!selmon->lt[selmon->sellt]->arrange || c->isfloating)
				resize(c, c->x, c->y, nw, nh, True);
			break;
		}
	} while(ev.type != ButtonRelease);
	XWarpPointer(dpy, None, c->win, 0, 0, 0, 0, c->w + c->bw - 1, c->h + c->bw - 1);
	XUngrabPointer(dpy, CurrentTime);
	while(XCheckMaskEvent(dpy, EnterWindowMask, &ev));
	if((m = ptrtomon(c->x + c->w / 2, c->y + c->h / 2)) != selmon) {
		sendmon(c, m);
		selmon = m;
		focus(NULL);
	}
}

void
restack(Monitor *m) {
	Client *c;
	XEvent ev;
	XWindowChanges wc;

	drawbar(m);
	if(!m->sel)
		return;
	if(m->sel->isfloating || !m->lt[m->sellt]->arrange)
		XRaiseWindow(dpy, m->sel->win);
	if(m->lt[m->sellt]->arrange) {
		wc.stack_mode = Below;
		wc.sibling = m->barwin;
		for(c = m->stack; c; c = c->snext)
			if(!c->isfloating && ISVISIBLE(c)) {
				XConfigureWindow(dpy, c->win, CWSibling|CWStackMode, &wc);
				wc.sibling = c->win;
			}
	}
	XSync(dpy, False);
	while(XCheckMaskEvent(dpy, EnterWindowMask, &ev));
}

void
run(void) {
	XEvent ev;
	/* main event loop */
	XSync(dpy, False);
	while(running && !XNextEvent(dpy, &ev)) {
		if(handler[ev.type])
			handler[ev.type](&ev); /* call handler */
	}
}

void
scan(void) {
	unsigned int i, num;
	Window d1, d2, *wins = NULL;
	XWindowAttributes wa;

	if(XQueryTree(dpy, root, &d1, &d2, &wins, &num)) {
		for(i = 0; i < num; i++) {
			if(!XGetWindowAttributes(dpy, wins[i], &wa)
			|| wa.override_redirect || XGetTransientForHint(dpy, wins[i], &d1))
				continue;
			if(wa.map_state == IsViewable || getstate(wins[i]) == IconicState)
				manage(wins[i], &wa);
		}
		for(i = 0; i < num; i++) { /* now the transients */
			if(!XGetWindowAttributes(dpy, wins[i], &wa))
				continue;
			if(XGetTransientForHint(dpy, wins[i], &d1)
			&& (wa.map_state == IsViewable || getstate(wins[i]) == IconicState))
				manage(wins[i], &wa);
		}
		if(wins)
			XFree(wins);
	}
}

void
sendmon(Client *c, Monitor *m) {
	if(c->mon == m)
		return;
	unfocus(c, True);
	detach(c);
	detachstack(c);
	c->mon = m;
	c->tags = m->tagset[m->seltags]; /* assign tags of target monitor */
	attach(c);
	attachstack(c);
	focus(NULL);
	arrange(NULL);
}

void
setclientstate(Client *c, long state) {
	long data[] = { state, None };

	XChangeProperty(dpy, c->win, wmatom[WMState], wmatom[WMState], 32,
			PropModeReplace, (unsigned char *)data, 2);
}

Bool
sendevent(Client *c, Atom proto) {
	int n;
	Atom *protocols;
	Bool exists = False;
	XEvent ev;

	if(XGetWMProtocols(dpy, c->win, &protocols, &n)) {
		while(!exists && n--)
			exists = protocols[n] == proto;
		XFree(protocols);
	}
	if(exists) {
		ev.type = ClientMessage;
		ev.xclient.window = c->win;
		ev.xclient.message_type = wmatom[WMProtocols];
		ev.xclient.format = 32;
		ev.xclient.data.l[0] = proto;
		ev.xclient.data.l[1] = CurrentTime;
		XSendEvent(dpy, c->win, False, NoEventMask, &ev);
	}
	return exists;
}

void
setfocus(Client *c) {
	if(!c->neverfocus)
		XSetInputFocus(dpy, c->win, RevertToPointerRoot, CurrentTime);
	sendevent(c, wmatom[WMTakeFocus]);
}


void
setlayout(const Arg *arg) {
	if(!arg || !arg->v || arg->v != selmon->lt[selmon->sellt])
		selmon->sellt ^= 1;
	if(arg && arg->v)
		selmon->lt[selmon->sellt] = selmon->lts[selmon->curtag] = (Layout *)arg->v;
	strncpy(selmon->ltsymbol, selmon->lt[selmon->sellt]->symbol, sizeof selmon->ltsymbol);
	if(selmon->sel)
		arrange(selmon);
	else
		drawbar(selmon);
}

void
incnmaster(const Arg *arg) {
	int i;

	if(!arg || !selmon->lt[selmon->sellt]->arrange)
		return;
	i = selmon->nmasters[selmon->curtag] + arg->i;
	selmon->nmasters[selmon->curtag] = i < 0 ? 0 : i;
	arrange(selmon);
}

void
setnmaster(const Arg *arg) {
	if(!arg || !selmon->lt[selmon->sellt]->arrange)
		return;
	selmon->nmasters[selmon->curtag] = arg->i > 0 ? arg->i : 0;
	arrange(selmon);
}

/* arg > 1.0 will set mfact absolutly */
void
setmfact(const Arg *arg) {
	float f;

	if(!arg || !selmon->lt[selmon->sellt]->arrange)
		return;
	f = arg->f < 1.0 ? arg->f + selmon->mfacts[selmon->curtag] : arg->f - 1.0;
	if(f < 0.1 || f > 0.9)
		return;
	selmon->mfacts[selmon->curtag] = f;
	arrange(selmon);
}

void
setup(void) {
	XSetWindowAttributes wa;
	int i, ii;

	/* clean up any zombies immediately */
	sigchld(0);

	/* init screen */
	screen = DefaultScreen(dpy);
	root = RootWindow(dpy, screen);
	initfont(font);
	sw = DisplayWidth(dpy, screen);
	sh = DisplayHeight(dpy, screen);
	bh = dc.h = dc.font.height + 3;
	updategeom();
	/* init atoms */
	wmatom[WMProtocols] = XInternAtom(dpy, "WM_PROTOCOLS", False);
	wmatom[WMDelete] = XInternAtom(dpy, "WM_DELETE_WINDOW", False);
	wmatom[WMState] = XInternAtom(dpy, "WM_STATE", False);
	wmatom[WMTakeFocus] = XInternAtom(dpy, "WM_TAKE_FOCUS", False);
	netatom[NetActiveWindow] = XInternAtom(dpy, "_NET_ACTIVATE_WINDOW", False);
	netatom[NetSupported] = XInternAtom(dpy, "_NET_SUPPORTED", False);
	netatom[NetWMName] = XInternAtom(dpy, "_NET_WM_NAME", False);
	netatom[NetWMWindowOpacity] = XInternAtom(dpy, "_NET_WM_WINDOW_OPACITY", False);
	netatom[NetWMState] = XInternAtom(dpy, "_NET_WM_STATE", False);
	netatom[NetWMFullscreen] = XInternAtom(dpy, "_NET_WM_STATE_FULLSCREEN", False);
	netatom[NetSystemTray] = XInternAtom(dpy, "_NET_SYSTEM_TRAY_S0", False);
	/* init cursors */
	cursor[CurNormal] = XCreateFontCursor(dpy, XC_left_ptr);
	cursor[CurResize] = XCreateFontCursor(dpy, XC_sizing);
	cursor[CurMove] = XCreateFontCursor(dpy, XC_fleur);
	/* init appearance */
	barcolors = malloc(LENGTH(colors)*sizeof(unsigned long)*ColLast);
	for(i=0; i<LENGTH(colors); i++) {
		for(ii=0; ii<ColLast; ii++)
			barcolors[i*3+ii] = getcolor(colors[i][ii] );
	}
	dc.norm[ColBorder] = getcolor(normbordercolor);
	dc.norm[ColBG] = getcolor(normbgcolor);
	dc.norm[ColFG] = getcolor(normfgcolor);
	dc.sel[ColBorder] = getcolor(selbordercolor);
	dc.sel[ColBG] = getcolor(selbgcolor);
	dc.sel[ColFG] = getcolor(selfgcolor);
	dc.drawable = XCreatePixmap(dpy, root, DisplayWidth(dpy, screen), bh, DefaultDepth(dpy, screen));
	dc.gc = XCreateGC(dpy, root, 0, NULL);
	XSetLineAttributes(dpy, dc.gc, 1, LineSolid, CapButt, JoinMiter);
	if(!dc.font.set)
		XSetFont(dpy, dc.gc, dc.font.xfont->fid);
	const unsigned char *map=allbits;
	for(i = 0; i < LENGTH(bitmaps); i++) {
		bitmaps[i].pix = XCreateBitmapFromData(dpy, root, (char *)map, bitmaps[i].bw, bitmaps[i].bh);
		map+=(bitmaps[i].bw*bitmaps[i].bh)/8;
	}
	/* init bars */
	updatebars();
	updatestatus();
	systray_acquire();
	/* EWMH support per view */
	XChangeProperty(dpy, root, netatom[NetSupported], XA_ATOM, 32,
			PropModeReplace, (unsigned char *) netatom, NetLast);
	/* select for events */
	wa.cursor = cursor[CurNormal];
	wa.event_mask = SubstructureRedirectMask|SubstructureNotifyMask|ButtonPressMask
	                |EnterWindowMask|LeaveWindowMask|StructureNotifyMask
	                |PropertyChangeMask;
	XChangeWindowAttributes(dpy, root, CWEventMask|CWCursor, &wa);
	XSelectInput(dpy, root, wa.event_mask);
	grabkeys();
}

void
showhide(Client *c) {
	if(!c)
		return;
	if(ISVISIBLE(c) || c->ispanel) { /* show clients top down */
                if(c->needresize) {
			c->needresize = False;
			XMoveResizeWindow(dpy, c->win, c->x, c->y, c->w, c->h);
                } else {
			XMoveWindow(dpy, c->win, c->x, c->y);
                }

		if((!c->mon->lt[c->mon->sellt]->arrange || c->isfloating) && !c->isfullscreen) {
			resize(c, c->x, c->y, c->w, c->h, False);
			}
		showhide(c->snext);
	}
	else { /* hide clients bottom up */
		showhide(c->snext);
		XMoveWindow(dpy, c->win, c->x + 2 * sw, c->y);
	}
}


void
sigchld(int unused) {
	if(signal(SIGCHLD, sigchld) == SIG_ERR)
		die("Can't install SIGCHLD handler");
	while(0 < waitpid(-1, NULL, WNOHANG));
}

void
spawn(const Arg *arg) {
	if(fork() == 0) {
		if(dpy)
			close(ConnectionNumber(dpy));
		setsid();
		execvp(((char **)arg->v)[0], (char **)arg->v);
		fprintf(stderr, "dwm: execvp %s", ((char **)arg->v)[0]);
		perror(" failed");
		exit(0);
	}
}

Bool systray_acquire(void) {
    XSetWindowAttributes wattr;
    if(!systray_enable || traywin) return False;

    if(XGetSelectionOwner(dpy, netatom[NetSystemTray]) != None) {
        fprintf(stderr, "Can't initialize system tray: owned by another process\n");
        return False;
    }

    // Init traywin window
    wattr.event_mask        = ButtonPressMask | ExposureMask;
    wattr.override_redirect = True;
    wattr.background_pixmap = ParentRelative;
    wattr.background_pixel  = dc.norm[ColBG];

    traywin = XCreateSimpleWindow(dpy, root, 0, 0, 1, 1, 0, 0, dc.norm[ColBG]);

    XChangeWindowAttributes(dpy, traywin, CWEventMask | CWOverrideRedirect | CWBackPixel, &wattr);
    XSelectInput(dpy, traywin, KeyPressMask | ButtonPressMask);

    XMapRaised(dpy, traywin);

    XSetSelectionOwner(dpy, netatom[NetSystemTray], traywin, CurrentTime);

    if(XGetSelectionOwner(dpy, netatom[NetSystemTray]) != traywin) {
        systray_freeicons();
        fprintf(stderr, "System tray: can't get systray manager\n");
        return False;
    }
    XSync(dpy, False);

    return True;
}


void systray_add(Window win) {
    Systray *s;

    if(!systray_enable) return;

    s = zcalloc(sizeof(Systray));
    s->win = win;

    s->geo.height = bh - (barline ? 1 : 0);
    s->geo.width  = bh - (barline ? 1 : 0);

    XSelectInput(dpy, s->win, StructureNotifyMask | PropertyChangeMask| EnterWindowMask | FocusChangeMask);
    XReparentWindow(dpy, s->win, traywin, 0, 0);

    // Attach
    if(trayicons) trayicons->prev = s;

    s->next = trayicons;
    trayicons = s;

    return;
}

void systray_del(Systray *s) {
    Systray **ss;

    if(!systray_enable) return;

    for(ss = &trayicons; *ss && *ss != s; ss = &(*ss)->next);
    *ss = s->next;

    IFREE(s);
    return;
}

void systray_freeicons(void) {
    Systray *i;

    if(!systray_enable) return;

    for(i = trayicons; i; i = i->next) {
        XUnmapWindow(dpy, i->win);
        XReparentWindow(dpy, i->win, ROOT, 0, 0);
        IFREE(i);
    }

    XSetSelectionOwner(dpy, netatom[NetSystemTray], None, CurrentTime);
    XDestroyWindow(dpy, traywin);
    XSync(dpy, 0);

    return;
}

Systray* systray_find(Window win) {
    Systray *i;

    if(!systray_enable) return NULL;

    for(i = trayicons; i; i = i->next)
        if(i->win == win) return i;

    return NULL;
}

int systray_get_width(void) {
    int w = 0;
    Systray *i;

    if(!systray_enable) return 0;

    for(i = trayicons; i; i = i->next)
        w += i->geo.width + systray_spacing + 1;

    return w;
}

void systray_update(void) {
    Systray *i;
    Monitor *m;
    int x = 1;
    int pos = blw;

    drawbars();

    if(!systray_enable) return;

    for(m = mons; m; m = m->next){
        if(m->primary == 1) pos = m->mx + m->ww;
    }

    if(!trayicons) {
        pos -= 1;
        XMoveResizeWindow(dpy, traywin, pos, 0, 1, 1);
        return;
    }

    for(i = trayicons; i; i = i->next) {
        XMapWindow(dpy, i->win);
        XMoveResizeWindow(dpy, i->win, (i->geo.x = x), 0, i->geo.width, i->geo.height);

        x += i->geo.width + systray_spacing;
    }

    pos -= x;
    XMoveResizeWindow(dpy, traywin, pos, 0, x, bh - (barline ? 1 : 0));

    return;
}

void
tag(const Arg *arg) {
	if(selmon->sel && arg->ui & TAGMASK) {
		selmon->sel->tags = arg->ui & TAGMASK;
		focus(NULL);
		arrange(selmon);
	}
}

void
tagmon(const Arg *arg) {
	if(!selmon->sel || !mons->next)
		return;
	sendmon(selmon->sel, dirtomon(arg->i));
}

int
textnw(const char *text, unsigned int len) {
	XRectangle r;

	if(dc.font.set) {
		XmbTextExtents(dc.font.set, text, len, NULL, &r);
		return r.width;
	}
	return XTextWidth(dc.font.xfont, text, len);
}

int
coloredtextw(const char *text/*, unsigned int len*/) {
	int i, num, w=0;
	const char *buf = text, *ptr = buf, *rptr = NULL;
	const Bitmap *bitmap;
	//rptr=0;
	while( *ptr || rptr ) {

		for( i = 0; *ptr && ( *ptr!='^' || ptr[1]!='[' ); i++, ptr++ );
		w += textnw(buf, i);
		if( !*ptr && rptr ) {
			buf = ptr = rptr;
			rptr = 0;
		}
		if(*ptr=='^' && ptr[1]=='[') {
			for( i = 0; ptr[i] && ( ptr[i]!=';' ); i++ );
			switch( ptr[2] ) {
			case 'd':
				rptr = ptr + i + 1;
				ptr = buf = sstrings[atoi(ptr+3)];
				i = -1;
			    break;
			case 'h':
				w += (dc.font.ascent + dc.font.descent + 2) * 2 + 3;
				break;
			case 'v':
				w += (dc.font.ascent + dc.font.descent + 2) / 3 + 3;
				break;
			case 'i':
				num = atoi(ptr+3);
			case 'g':
			case 'G':
				if(ptr[2]!='i') num=atoi(ptr+5);
				if(num<LENGTH(bitmaps)) {
					bitmap = &bitmaps[num];
					w += bitmap->bw+2;
				}
				break;
			default:
				break;
			}
			if(i>=0) {
				buf = ptr = ptr + i + 1;
			}
		}
	}
	return w + dc.font.height;
}

void
ntile(Monitor *m) {
	int x, y, h, w, mw, nmax, nm;
	unsigned int i, n;
	Client *c;

	snprintf(m->ltsymbol, sizeof m->ltsymbol, "=%d]", m->nmasters[m->curtag]);
	for(n = 0, c = nexttiled(m->clients); c; c = nexttiled(c->next), n++);
	c = nexttiled(m->clients);
	nmax = m->nmasters[m->curtag];
	nm = nmax == 1 ? 1 : MIN(n / 2, nmax);
	if(nm > n)
		nm = n;
	/* master */
	if(nm > 0) {
		mw = m->mfacts[m->curtag] * m->ww;
		h = m->wh / nm;
		if(h < bh)
			h = m->wh;
		y = m->wy;
		for(i = 0; i < nm; i++, c = nexttiled(c->next)) {
			resize(c, m->wx, y, (n == nm ? m->ww : mw) - 2 * c->bw,
			       ((i + 1 == nm) ? m->wy + m->wh - y : h) - 2 * c->bw, False);
			if(h != m->wh)
				y = c->y + HEIGHT(c);
		}
		n -= nm;
	} else
		mw = 0;
	if(n == 0)
		return;
	/* tile stack */
	x = m->wx + mw;
	y = m->wy;
	w = m->ww - mw;
	h = m->wh / n;
	if(h < bh)
		h = m->wh;
	for(i = 0; c; c = nexttiled(c->next), i++) {
		resize(c, x, y, w - 2 * c->bw,
		       ((i + 1 == n) ? m->wy + m->wh - y : h) - 2 * c->bw, False);
		if(h != m->wh)
			y = c->y + HEIGHT(c);
	}
}

void
togglebar(const Arg *arg) {
	selmon->showbars[selmon->curtag] = !selmon->showbars[selmon->curtag];
	updatebarpos(selmon);
	XMoveResizeWindow(dpy, selmon->barwin, selmon->wx, selmon->by, selmon->ww, bh);
	arrange(selmon);
}

void
togglefloating(const Arg *arg) {
	if(!selmon->sel)
		return;
	selmon->sel->isfloating = !selmon->sel->isfloating || selmon->sel->isfixed;
	if(selmon->sel->isfloating)
		resize(selmon->sel, selmon->sel->x, selmon->sel->y,
		       selmon->sel->w, selmon->sel->h, False);
	arrange(selmon);
}

void
toggletag(const Arg *arg) {
	unsigned int newtags;
	unsigned int i;

	if(!selmon->sel)
		return;
	newtags = selmon->sel->tags ^ (arg->ui & TAGMASK);
	if(newtags) {
		selmon->sel->tags = newtags;
		if(newtags == ~0) {
			selmon->prevtag = selmon->curtag;
			selmon->curtag = 0;
		}
		if(!(newtags & 1 << (selmon->curtag - 1))) {
			selmon->prevtag = selmon->curtag;
			for (i=0; !(newtags & 1 << i); i++);
			selmon->curtag = i + 1;
		}
		selmon->sel->tags = newtags;
		selmon->lt[selmon->sellt] = selmon->lts[selmon->curtag];
		arrange(selmon);
	}
}

void
toggleview(const Arg *arg) {
	unsigned int newtagset = selmon->tagset[selmon->seltags] ^ (arg->ui & TAGMASK);

	if(newtagset) {
		selmon->tagset[selmon->seltags] = newtagset;
		focus(NULL);
		arrange(selmon);
	}
}

void
unfocus(Client *c, Bool setfocus) {
	if(!c)
		return;
	grabbuttons(c, False);
	XSetWindowBorder(dpy, c->win, dc.norm[ColBorder]);
	if(setfocus)
		XSetInputFocus(dpy, root, RevertToPointerRoot, CurrentTime);
}

void
unmanage(Client *c, Bool destroyed) {
	Monitor *m = c->mon;
	Client *s;
	XWindowChanges wc;

	/* The server grab construct avoids race conditions. */
	detach(c);
	detachstack(c);
	if(!destroyed) {
		wc.border_width = c->oldbw;
		XGrabServer(dpy);
		XSetErrorHandler(xerrordummy);
		XConfigureWindow(dpy, c->win, CWBorderWidth, &wc); /* restore border */
		XUngrabButton(dpy, AnyButton, AnyModifier, c->win);
		setclientstate(c, WithdrawnState);
		XSync(dpy, False);
		XSetErrorHandler(xerror);
		XUngrabServer(dpy);
	}
	if(scratch == c) scratch = NULL;
	if(scratch!=NULL)
		for(s = scratch; s; s = s->next)
			if(c==s->next) {
				s->next = c->next;
				break;
			}
	free(c);
	focus(NULL);
	arrange(m);
}

void
unmapnotify(XEvent *e) {
	Client *c;
	XUnmapEvent *ev = &e->xunmap;
	if((c = wintoclient(ev->window)))
		unmanage(c, False);
}

void
updatebars(void) {
	Monitor *m;
	XSetWindowAttributes wa = {
		.override_redirect = True,
		.background_pixmap = ParentRelative,
		.event_mask = ButtonPressMask|ExposureMask
	};
	for(m = mons; m; m = m->next) {
		m->barwin = XCreateWindow(dpy, root, m->wx, m->by, m->ww, bh, 0, DefaultDepth(dpy, screen),
		                          CopyFromParent, DefaultVisual(dpy, screen),
		                          CWOverrideRedirect|CWBackPixmap|CWEventMask, &wa);
		XDefineCursor(dpy, m->barwin, cursor[CurNormal]);
		XMapRaised(dpy, m->barwin);
	}
}

void
updatebarpos(Monitor *m) {
	m->wy = m->my;
	m->wh = m->mh;
	if(m->showbars[m->curtag]) {
		m->wh -= bh;
		m->by = m->topbars[m->curtag] ? m->wy : m->wy + m->wh;
		m->wy = m->topbars[m->curtag] ? m->wy + bh : m->wy;
	}
	else
		m->by = -bh;
}

Bool
updategeom(void) {
	Bool dirty = False;

#ifdef XINERAMA
	if(XineramaIsActive(dpy)) {
		int i, j, n, nn;
		Client *c;
		Monitor *m;
		XineramaScreenInfo *info = XineramaQueryScreens(dpy, &nn);
		XineramaScreenInfo *unique = NULL;

		for(n = 0, m = mons; m; m = m->next, n++);
		/* only consider unique geometries as separate screens */
		if(!(unique = (XineramaScreenInfo *)malloc(sizeof(XineramaScreenInfo) * nn)))
			die("fatal: could not malloc() %u bytes\n", sizeof(XineramaScreenInfo) * nn);
		for(i = 0, j = 0; i < nn; i++)
			if(isuniquegeom(unique, j, &info[i]))
				memcpy(&unique[j++], &info[i], sizeof(XineramaScreenInfo));
		XFree(info);
		nn = j;
		if(n <= nn) {
		  /* first = primary monitor */
		  for(m = mons; m && m->next; m = m->next);
		  if(m) m->next = createmon(1);
		  else  mons = createmon(1);			
		  for(i = 0; i < (nn - n - 1); i++) { /* new monitors available */
				for(m = mons; m && m->next; m = m->next);
				if(m)
					m->next = createmon(0);
				else
					mons = createmon(0);
			}
			for(i = 0, m = mons; i < nn && m; m = m->next, i++)
				if(i >= n
				|| (unique[i].x_org != m->mx || unique[i].y_org != m->my
				    || unique[i].width != m->mw || unique[i].height != m->mh))
				{
					dirty = True;
					m->num = i;
					m->mx = m->wx = unique[i].x_org;
					m->my = m->wy = unique[i].y_org;
					m->mw = m->ww = unique[i].width;
					m->mh = m->wh = unique[i].height;
					updatebarpos(m);
				}
		}
		else { /* less monitors available nn < n */
			for(i = nn; i < n; i++) {
				for(m = mons; m && m->next; m = m->next);
				while(m->clients) {
					dirty = True;
					c = m->clients;
					m->clients = c->next;
					detachstack(c);
					c->mon = mons;
					attach(c);
					attachstack(c);
				}
				if(m == selmon)
					selmon = mons;
				cleanupmon(m);
			}
		}
		free(unique);
	}
	else
#endif /* XINERAMA */
	/* default monitor setup */
	{
		if(!mons)
			mons = createmon(1);
		if(mons->mw != sw || mons->mh != sh) {
			dirty = True;
			mons->mw = mons->ww = sw;
			mons->mh = mons->wh = sh;
			updatebarpos(mons);
		}
	}
	if(dirty) {
		selmon = mons;
		selmon = wintomon(root);
	}
	return dirty;
}

void
updatenumlockmask(void) {
	unsigned int i, j;
	XModifierKeymap *modmap;

	numlockmask = 0;
	modmap = XGetModifierMapping(dpy);
	for(i = 0; i < 8; i++)
		for(j = 0; j < modmap->max_keypermod; j++)
			if(modmap->modifiermap[i * modmap->max_keypermod + j]
			   == XKeysymToKeycode(dpy, XK_Num_Lock))
				numlockmask = (1 << i);
	XFreeModifiermap(modmap);
}

void
updatesizehints(Client *c) {
	long msize;
	XSizeHints size;

	if(!XGetWMNormalHints(dpy, c->win, &size, &msize))
		/* size is uninitialized, ensure that size.flags aren't used */
		size.flags = PSize;
	if(size.flags & PBaseSize) {
		c->basew = size.base_width;
		c->baseh = size.base_height;
	}
	else if(size.flags & PMinSize) {
		c->basew = size.min_width;
		c->baseh = size.min_height;
	}
	else
		c->basew = c->baseh = 0;
	if(size.flags & PResizeInc) {
		c->incw = size.width_inc;
		c->inch = size.height_inc;
	}
	else
		c->incw = c->inch = 0;
	if(size.flags & PMaxSize) {
		c->maxw = size.max_width;
		c->maxh = size.max_height;
	}
	else
		c->maxw = c->maxh = 0;
	if(size.flags & PMinSize) {
		c->minw = size.min_width;
		c->minh = size.min_height;
	}
	else if(size.flags & PBaseSize) {
		c->minw = size.base_width;
		c->minh = size.base_height;
	}
	else
		c->minw = c->minh = 0;
	if(size.flags & PAspect) {
		c->mina = (float)size.min_aspect.y / size.min_aspect.x;
		c->maxa = (float)size.max_aspect.x / size.max_aspect.y;
	}
	else
		c->maxa = c->mina = 0.0;
	c->isfixed = (c->maxw && c->minw && c->maxh && c->minh
	             && c->maxw == c->minw && c->maxh == c->minh);
}

void
updatetitle(Client *c) {
	if(!gettextprop(c->win, netatom[NetWMName], c->name, sizeof c->name))
		gettextprop(c->win, XA_WM_NAME, c->name, sizeof c->name);
	if(c->name[0] == '\0') /* hack to mark broken clients */
		strcpy(c->name, broken);
}

void
updatestatus(void) {
	if(!gettextprop(root, XA_WM_NAME, stext, sizeof(stext)))
		strcpy(stext, "dwm-"VERSION);
	drawbar(selmon);
}

void
updatewmhints(Client *c) {
	XWMHints *wmh;

	if((wmh = XGetWMHints(dpy, c->win))) {
		if(c == selmon->sel && wmh->flags & XUrgencyHint) {
			wmh->flags &= ~XUrgencyHint;
			XSetWMHints(dpy, c->win, wmh);
		}
		else
			c->isurgent = (wmh->flags & XUrgencyHint) ? True : False;
		if(wmh->flags && InputHint)
			c->neverfocus = !wmh->input;
		else
			c->neverfocus = False;
		XFree(wmh);
	}
}

void
view(const Arg *arg) {
	unsigned int i;
	//int t=selmon->curtag;

	if((arg->ui & TAGMASK) == selmon->tagset[selmon->seltags])
		return;
	selmon->seltags ^= 1; /* toggle sel tagset */
	if(arg->ui & TAGMASK) {
		selmon->tagset[selmon->seltags] = arg->ui & TAGMASK;
		selmon->prevtag = selmon->curtag;
		if(arg->ui == ~0)
			selmon->curtag = 0;
		else {
			for (i=0; !(arg->ui & 1 << i); i++);
			selmon->curtag = i + 1;
		}
	} else {
		selmon->prevtag= selmon->curtag ^ selmon->prevtag;
		selmon->curtag^= selmon->prevtag;
		selmon->prevtag= selmon->curtag ^ selmon->prevtag;
	}
	focus(NULL);
	selmon->lt[selmon->sellt] = selmon->lts[selmon->curtag ? selmon->curtag : selmon->prevtag];
	if(selmon->showbars[selmon->curtag] != selmon->showbars[selmon->prevtag] || selmon->topbars[selmon->curtag] != selmon->topbars[selmon->prevtag]) {
		updatebarpos(selmon);
		XMoveResizeWindow(dpy, selmon->barwin, selmon->wx, selmon->by, selmon->ww, bh);
	}
	arrange(selmon);
}

Client *
wintoclient(Window w) {
	Client *c;
	Monitor *m;

	if(scratch!=NULL)
		for(c = scratch; c; c = c->next)
			if(c->win == w)
				return c;

	for(m = mons; m; m = m->next)
		for(c = m->clients; c; c = c->next)
			if(c->win == w)
				return c;

	return NULL;
}

Monitor *
wintomon(Window w) {
	int x, y;
	Client *c;
	Monitor *m;

	if(w == root && getrootptr(&x, &y))
		return ptrtomon(x, y);
	for(m = mons; m; m = m->next)
		if(w == m->barwin)
			return m;
	if((c = wintoclient(w)))
		return c->mon;
	return selmon;
}

/* There's no way to check accesses to destroyed windows, thus those cases are
 * ignored (especially on UnmapNotify's).  Other types of errors call Xlibs
 * default error handler, which may call exit.  */
int
xerror(Display *dpy, XErrorEvent *ee) {
	if(ee->error_code == BadWindow
	|| (ee->request_code == X_SetInputFocus && ee->error_code == BadMatch)
	|| (ee->request_code == X_PolyText8 && ee->error_code == BadDrawable)
	|| (ee->request_code == X_PolyFillRectangle && ee->error_code == BadDrawable)
	|| (ee->request_code == X_PolySegment && ee->error_code == BadDrawable)
	|| (ee->request_code == X_ConfigureWindow && ee->error_code == BadMatch)
	|| (ee->request_code == X_GrabButton && ee->error_code == BadAccess)
	|| (ee->request_code == X_GrabKey && ee->error_code == BadAccess)
	|| (ee->request_code == X_CopyArea && ee->error_code == BadDrawable))
		return 0;
	fprintf(stderr, "dwm: fatal error: request code=%d, error code=%d\n",
			ee->request_code, ee->error_code);
	return xerrorxlib(dpy, ee); /* may call exit */
}

int
xerrordummy(Display *dpy, XErrorEvent *ee) {
	return 0;
}

/* Startup Error handler to check if another window manager
 * is already running. */
int
xerrorstart(Display *dpy, XErrorEvent *ee) {
	die("dwm: another window manager is already running\n");
	return -1;
}

void
zoom(const Arg *arg) {
	Client *c = selmon->sel;

	if(!selmon->lt[selmon->sellt]->arrange
	|| (selmon->sel && selmon->sel->isfloating))
		return;
	if(c == nexttiled(selmon->clients))
		if(!c || !(c = nexttiled(c->next)))
			return;
	pop(c);
}

int
main(int argc, char *argv[]) {
	if(argc == 2 && !strcmp("-v", argv[1]))
		die("dwm-"VERSION", © 2006-2011 dwm engineers, see LICENSE for details\n");
	else if(argc != 1)
		die("usage: dwm [-v]\n");
	if(!setlocale(LC_CTYPE, "") || !XSupportsLocale())
		fputs("warning: no locale support\n", stderr);
	if(!(dpy = XOpenDisplay(NULL)))
		die("dwm: cannot open display\n");
	checkotherwm();
	setup();
	scan();
	run();
	cleanup();
	XCloseDisplay(dpy);
	return exitcode;
}
