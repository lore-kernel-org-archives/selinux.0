Message-ID: <4666DFA3.5070008@tycho.nsa.gov>
Date: Wed, 06 Jun 2007 12:24:03 -0400
From: Eamon Walsh <ewalsh@tycho.nsa.gov>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: SE Linux <selinux@tycho.nsa.gov>, Joshua Brindle <jbrindle@tresys.com>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>
Subject: Re: [PATCH 1/2] libselinux: class and permission mapping support
References: <4666D5E6.508@tycho.nsa.gov> <1181145576.3699.148.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1181145576.3699.148.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Wed, 2007-06-06 at 11:42 -0400, Eamon Walsh wrote:
>   
>> This provides support for userspace object managers to register a
>> mapping of class and permission values.  After the mapping is
>> registered all libselinux functions that take a security class
>> or permission value must be provided with mapped values instead
>> of the "real," kernel values.
>>
>> Changes from the original interface proposal: No selinux_init()
>> function, just a straight set_mapping() function.  Also, to
>> simplify things the incoming mapping does not include explicit
>> values; the classes and permissions are numbered implicitly by
>> their ordering.  NULL strings are used to terminate the lists.
>>
>> Tested with X server, no problems encountered.
>>
>> This patch includes the interface and implementation of the
>> mapping set function.
>>     
>
> Can you post a snippet of code from the X server showing the usage of
> this interface by an object manager

In a header file:

/* Private Flask definitions */
#define SECCLASS_DRAWABLE		1
#define DRAWABLE__CREATE		0x00000001UL
#define DRAWABLE__DESTROY		0x00000002UL
#define DRAWABLE__DRAW			0x00000004UL
#define DRAWABLE__COPY			0x00000008UL
#define DRAWABLE__GETATTR		0x00000010UL
#define SECCLASS_WINDOW			2
#define WINDOW__ADDCHILD		0x00000001UL
#define WINDOW__CREATE			0x00000002UL
#define WINDOW__DESTROY			0x00000004UL
#define WINDOW__MAP			0x00000008UL
#define WINDOW__UNMAP			0x00000010UL
#define WINDOW__CHSTACK			0x00000020UL
#define WINDOW__CHPROPLIST		0x00000040UL
#define WINDOW__CHPROP			0x00000080UL
#define WINDOW__LISTPROP		0x00000100UL
#define WINDOW__GETATTR			0x00000200UL
#define WINDOW__SETATTR			0x00000400UL
#define WINDOW__SETFOCUS		0x00000800UL
#define WINDOW__MOVE			0x00001000UL
#define WINDOW__CHSELECTION		0x00002000UL
#define WINDOW__CHPARENT		0x00004000UL
#define WINDOW__CTRLLIFE		0x00008000UL
#define WINDOW__ENUMERATE		0x00010000UL
#define WINDOW__TRANSPARENT		0x00020000UL
#define WINDOW__MOUSEMOTION		0x00040000UL
#define WINDOW__CLIENTCOMEVENT		0x00080000UL
#define WINDOW__INPUTEVENT		0x00100000UL
#define WINDOW__DRAWEVENT		0x00200000UL
#define WINDOW__WINDOWCHANGEEVENT	0x00400000UL
#define WINDOW__WINDOWCHANGEREQUEST	0x00800000UL
#define WINDOW__SERVERCHANGEEVENT	0x01000000UL
#define WINDOW__EXTENSIONEVENT		0x02000000UL
#define SECCLASS_GC			3
#define GC__CREATE			0x00000001UL
#define GC__FREE			0x00000002UL
#define GC__GETATTR			0x00000004UL
#define GC__SETATTR			0x00000008UL
#define SECCLASS_FONT			4
...


In the initialization code:

/* Dynamically allocated security classes and permissions */
/* Do not change these without changing the private Flask definitions */
static struct security_class_mapping map[] = {
    { "drawable",
      { "create", "destroy", "draw", "copy", "getattr", NULL }},
    { "window",
      { "addchild", "create", "destroy", "map", "unmap", "chstack",
	"chproplist", "chprop", "listprop", "getattr", "setattr", "setfocus",
	"move", "chselection", "chparent", "ctrllife", "enumerate",
	"transparent", "mousemotion", "clientcomevent", "inputevent",
	"drawevent", "windowchangeevent", "windowchangerequest",
	"serverchangeevent", "extensionevent", NULL }},
    { "gc",
      { "create", "free", "getattr", "setattr", NULL }},
    { "font",
      { "load", "free", "getattr", "use", NULL }},
    { "colormap",
      { "create", "free", "install", "uninstall", "list", "read", "store",
	"getattr", "setattr", NULL }},
    { "property",
      { "create", "free", "read", "write", NULL }},
    { "cursor",
      { "create", "createglyph", "free", "assign", "setattr", NULL }},
    { "xclient",
      { "kill", NULL }},
    { "xinput",
      { "lookup", "getattr", "setattr", "setfocus", "warppointer",
	"activegrab", "passivegrab", "ungrab", "bell", "mousemotion",
	"relabelinput", NULL }},
    { "xserver",
      { "screensaver", "gethostlist", "sethostlist", "getfontpath",
	"setfontpath", "getattr", "grab", "ungrab", NULL }},
    { "xextension",
      { "query", "use", NULL }},
    { NULL }
};

if (selinux_set_mapping(map) < 0) {
    FatalError("XSELinux: Failed to set up security class mapping\n");
}

That's it, no other changes.



-- 
Eamon Walsh <ewalsh@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
