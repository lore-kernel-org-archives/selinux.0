Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i72JrerT015831
	for <selinux@tycho.nsa.gov>; Mon, 2 Aug 2004 15:53:40 -0400 (EDT)
Date: Mon, 2 Aug 2004 21:00:52 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: SE-Linux <selinux@tycho.nsa.gov>, Daniel J Walsh <dwalsh@redhat.com>
Subject: Re: matchfilecon (the program) vs matchfilecon (the libselinux1 fn)
Message-ID: <20040802200052.GN4194@lkcl.net>
References: <20040801172751.GD20103@lkcl.net> <1091455223.23449.66.camel@moss-spartans.epoch.ncsc.mil> <20040802145724.GG4194@lkcl.net> <1091458325.23449.102.camel@moss-spartans.epoch.ncsc.mil> <20040802191243.GJ4194@lkcl.net> <1091474356.23449.272.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1091474356.23449.272.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, Aug 02, 2004 at 03:19:16PM -0400, Stephen Smalley wrote:

> On Mon, 2004-08-02 at 15:12, Luke Kenneth Casson Leighton wrote:
> > On Mon, Aug 02, 2004 at 10:52:05AM -0400, Stephen Smalley wrote:
> > > What's the objection to patching udev to directly invoke matchpathcon(3)
> > > and setfscreatecon(3) prior to creating each device node?
> >  
> >  time!  how long do those function calls take?
> > 
> >  using /sbin/restorecon, which is the present hack, each device node
> >  creation takes around a quarter of a second (!!)
> 
> Directly invoking the library functions has to be faster than exec'ing a
> separate helper program (restorecon) that then invokes the library
> functions.  Further, restorecon has to re-lookup the device node in the
> filesystem, whereas udev can set up its context upon initial creation. 
> Further, matchpathcon() caches the file context specification upon the
> first call, so if the udev process stays around for multiple device
> creations, then subsequent matchpathcon() calls will be a bit faster
> (although pathname regex matching is still going to take time).

 great.

> In any event, the patch to udev would naturally be #ifdef'd
> WITH_SELINUX, so no effect on non-SELinux users.  

 and is_selinux_enabled() even :)


> Dan had a patch at one
> time, although I'm not sure that it used setfscreatecon(); it may have
> done a setfilecon() after creation.  Preferable to use setfscreatecon()
> prior to creation, but either way is ok as long as you guarantee that no
> access is possible prior to labeling.
 
 if it was the one that was in udev-0.024, it was setfilecon.

 it was taken out, along with the dbus patch, due to the amount of time
 that (both these patches) were perceived as hitting the system with.

 i mean, dbus was causing a ONE SECOND delay per device node.

 from what i can gather, i believe the selinux patch got
 painted with the same tar brush.

 l.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
