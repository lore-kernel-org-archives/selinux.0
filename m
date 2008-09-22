Subject: Re: Latest flask definitions for libselinux.
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Joshua Brindle <method@manicmethod.com>
Cc: Daniel J Walsh <dwalsh@redhat.com>, SE Linux <selinux@tycho.nsa.gov>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>
In-Reply-To: <48D7EB92.90108@manicmethod.com>
References: <48D7EA05.8060608@manicmethod.com> <48D7EAA6.1000107@redhat.com>
	 <48D7EB92.90108@manicmethod.com>
Content-Type: text/plain
Date: Mon, 22 Sep 2008 15:07:07 -0400
Message-Id: <1222110427.18735.70.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Mon, 2008-09-22 at 15:01 -0400, Joshua Brindle wrote:
> Daniel J Walsh wrote:
> > -----BEGIN PGP SIGNED MESSAGE-----
> > Hash: SHA1
> > 
> > Joshua Brindle wrote:
> >> Daniel J Walsh wrote:
> >>
> >>
> >> diff --exclude-from=exclude -N -u -r nsalibselinux/include/selinux/flask.h libselinux-2.0.71/include/selinux/flask.h
> >> --- nsalibselinux/include/selinux/flask.h	2008-08-28 09:34:24.000000000 -0400
> >> +++ libselinux-2.0.71/include/selinux/flask.h	2008-09-22 13:28:05.000000000 -0400
> >> @@ -35,18 +35,18 @@
> >>  #define SECCLASS_SHM                                     28
> >>  #define SECCLASS_IPC                                     29
> >>  #define SECCLASS_PASSWD                                  30
> >> -#define SECCLASS_DRAWABLE                                31
> >> -#define SECCLASS_WINDOW                                  32
> >> -#define SECCLASS_GC                                      33
> >> -#define SECCLASS_FONT                                    34
> >> -#define SECCLASS_COLORMAP                                35
> >> -#define SECCLASS_PROPERTY                                36
> >> -#define SECCLASS_CURSOR                                  37
> >> -#define SECCLASS_XCLIENT                                 38
> >> -#define SECCLASS_XINPUT                                  39
> >> -#define SECCLASS_XSERVER                                 40
> >> -#define SECCLASS_XEXTENSION                              41
> >> -#define SECCLASS_PAX                                     42
> >> +#define SECCLASS_X_DRAWABLE                              31
> >> +#define SECCLASS_X_SCREEN                                32
> >> +#define SECCLASS_X_GC                                    33
> >> +#define SECCLASS_X_FONT                                  34
> >> +#define SECCLASS_X_COLORMAP                              35
> >> +#define SECCLASS_X_PROPERTY                              36
> >> +#define SECCLASS_X_SELECTION                             37
> >> +#define SECCLASS_X_CURSOR                                38
> >> +#define SECCLASS_X_CLIENT                                39
> >> +#define SECCLASS_X_DEVICE                                40
> >> +#define SECCLASS_X_SERVER                                41
> >> +#define SECCLASS_X_EXTENSION                             42
> >>  #define SECCLASS_NETLINK_ROUTE_SOCKET                    43
> >>  #define SECCLASS_NETLINK_FIREWALL_SOCKET                 44
> >>  #define SECCLASS_NETLINK_TCPDIAG_SOCKET                  45
> >>
> >>
> >> These are renumbered, why are you doing that?
> > I did nothing other then take the policy in REFpolicy and run the make
> > file on it.
> > 
> > My only change was to add netlink
> 
> It looks like some classes got reclaimed/reordered in the policy but
> the headers weren't updated. We need to be careful about this, and I
> hope the kernel headers also got updated.

There was an overhaul of the X classes by Eamon.  Doesn't affect the
kernel.  And even X doesn't use the libselinux #define's anymore - it
uses the class/perm discovery support.

libselinux #define's are largely only there for legacy applications that
still use the old interfaces.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
