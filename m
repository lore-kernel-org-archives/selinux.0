Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7V9c2rT010812
	for <selinux@tycho.nsa.gov>; Tue, 31 Aug 2004 05:38:02 -0400 (EDT)
Received: from open.hands.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7V9c15m017221
	for <selinux@tycho.nsa.gov>; Tue, 31 Aug 2004 09:38:02 GMT
Date: Tue, 31 Aug 2004 10:49:08 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Nigel Kukard <nkukard@lbsd.net>
Cc: linux-hotplug-devel@lists.sourceforge.net, SELinux <SELinux@tycho.nsa.gov>,
   "Fedora SELinux support list for users & developers." <fedora-selinux-list@redhat.com>,
   harald@redhat.com, Bill Nottingham <notting@redhat.com>
Subject: Re: [idea] udev + selinux
Message-ID: <20040831094908.GA2098@lkcl.net>
References: <20040830173744.GD10151@lbsd.net> <20040830203140.GB31497@lkcl.net> <20040831050252.GF10151@lbsd.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20040831050252.GF10151@lbsd.net>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, Aug 31, 2004 at 07:02:52AM +0200, Nigel Kukard wrote:
> >  you mean on /dev, i presume?
> 
> yep, or /udev (configured in the udev config file)
 
 oh.

 yes.

 redhat :)

> > 
> >  well i had to patch selinux/hooks.c to allow this [on a tmpfs]
> >  by relaxing the criteria of the "fscontext=" option for mount.
> > 
> 
> if its tmpfs, this would void the requirement of passing a mount option
> fscontext, udev would set the correct context when started up (a check
> could also be added to do this only if the mount point is /dev and its
> tmpfs... *shrug*)
> 
> >  otherwise it's not _possible_ t set the context on /dev as it is
> >  mounted [on a tmpfs].
> > 
> >  [if /dev was a persistent filesystem everything would be hunky-dory
> >   and this wouldn't be an issue].
> >
> 
> *nod*
> 
> > 
> >  with that in mind, it's more that because you're putting device
> >  inodes into a non-persistent filesystem, you end up getting the
> >  "default" rules and so you must "restore" the contexts, or
> >  you must patch udev to "understand" the contents of
> >  /etc/selinux/src/file_contexts/file_contexts (using matchpathcon()
> >  and setfscreatecon() from libselinux) such that it will create
> >  inodes with the right file context.
> >
> 
> I applied the patch to tmpfs to make it store xattr attributes which i
> found on the mailing list, seems your patch forgets xattr.h?

 ??  oops.

 okay, i had put it at http://www.hands.com/~lkcl/selinux/2.6.6/
 and when i posted copies to the list i must have missed it out.

 if you _do_ know how to properly create patches that other people
 can apply simply, that'd be great.

> I also applied the patch which adds  "matchpathcon()" & 
> "setfscreatecon()" support, 

 dan is working on a new version of that, for udev-0.030-10.


> and modified udev to set the correct 
> context of its root_path on startup.

 mount -o fscontext=system_u:object_r:device_t yes?

 did you patch selinux/hooks.c to relax the constraints on
 the fscontext= parameter to allow the correct context to be
 correctly applied?  :)


> >  ... but that's not how udev works: it deletes and creates inodes
> >  on demand; nothing exists at boot-time, it's all created on-demand.
> 
> at boot time i have about 5 devices in /dev with correct contexts set,
> udev them mounts tmpfs over this, WorksForMe(tm)
> 
> so in actual fact we do need matchpathcon() & setfscreatecon(), if its a
> persistent or non-persistent filesystem

 yep.

> > 
> >  so, not only must udev be patched to restore contexts but also
> >  the policies and various hacks added to "cope" with /dev being
> >  incredibly basic at startup - prior to udev running.
> 
> i have a simple persistent /dev which is used before udev runs, udev is
> then initialized, mounts a tmpfs over /dev (and restores its context) 

 oh.  ah.... you _restore_ its context (i.e. run restorecon
 /dev), you don't mount it with the modified mount -o fscontext=
 parameter?

> just 
> after sysctl -p is run in my initscripts so its basically one of the 
> first things to run. 

 yep.

> Seeing as my initial /dev is on a persistent 
> filesystem i don't have a problem with pre-udev stuff running.

 well.... you shouldn't... until you reinitialise or somehow delete,
 upgrade or otherwise modify the "old" /dev [which you will find is
 remounted --rbind to /.dev].

 try it: do setfiles /etc/selinux/src/file_contexts/file_contexts /.dev
 and then reboot [in permissive mode!!!]

 due to the present files/types.fc, you will find that the entire
 /.dev gets relabelled to something completely useless: root_t
 or default_t.  i think it's default_t.

 consequently your next reboot in enforcing mode will fail because
 /sbin/init tries to access /dev/null and /dev/initctl etc. as
 default_t ... and it can't.

 should you choose to deal with this, replace /u?dev with /[\.u]dev or
 some suitable regexp that i haven't a clue how to write so i just
 did /.?u?dev and that did the trick.


 the only _other_ thing you might find is that things like dialup
 don't or won't have been loaded.

 so i had to add in a _second_ version of /etc/init.d/modutils which
 does exactly the same as /etc/init.d/modutils ... but with a different
 list of modules, and AFTER udev has been run, not before.

 the list i have so far in /etc/modules.postudev contains (for my purposes):

 ppp_generic
 nvidia
 sg

 ppp_generic is there because "pon provider" bitches about /dev/ppp
 not existing

 sg is there because of usb-mount using sg_mod: if the module is
 pre-loaded, then /dev/sg0 gets created by udev.

 i don't believe that these modules should be loaded prior to udev
 being run: maybe they can, maybe they can't, maybe the nodes being
 loaded prior will result in a pending hotplug event such that when
 udev is run, the node gets created.

 ... but certainly, _some_ modules haven't been modified to conform
 to the new /sys thing.


 the "trick" of a node in /dev existing, and its first access
 automatically triggering a modprobe... well that only works if
 the node is there, and of course with udev, it isn't.

 perhaps there should be a "hook" into tmpfs to be able to pass
 filenames accessed in /dev on to udev, such that udev can go
 "oo, they tried to access /dev/ppp, let's kick off that module,
  then".

 l.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
