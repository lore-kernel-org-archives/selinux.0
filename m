Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7VCZ0rT011694
	for <selinux@tycho.nsa.gov>; Tue, 31 Aug 2004 08:35:00 -0400 (EDT)
Received: from open.hands.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7VCYBID017530
	for <selinux@tycho.nsa.gov>; Tue, 31 Aug 2004 12:34:11 GMT
Date: Tue, 31 Aug 2004 13:46:13 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Nigel Kukard <nkukard@lbsd.net>
Cc: linux-hotplug-devel@lists.sourceforge.net, SELinux <SELinux@tycho.nsa.gov>,
   "Fedora SELinux support list for users & developers." <fedora-selinux-list@redhat.com>,
   harald@redhat.com, Bill Nottingham <notting@redhat.com>
Subject: Re: [idea] udev + selinux
Message-ID: <20040831124613.GF11456@lkcl.net>
References: <20040830173744.GD10151@lbsd.net> <20040830203140.GB31497@lkcl.net> <20040831050252.GF10151@lbsd.net> <20040831094908.GA2098@lkcl.net> <20040831102715.GJ10151@lbsd.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20040831102715.GJ10151@lbsd.net>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, Aug 31, 2004 at 12:27:15PM +0200, Nigel Kukard wrote:

> > > and modified udev to set the correct 
> > > context of its root_path on startup.
> > 
> >  mount -o fscontext=system_u:object_r:device_t yes?
> >
> 
> nope....   mount -t ramfs none /dev
> 
> then run   udevstart   (udevstart does the C call to restorecon on
> root_path, so it ends up being labeled with whatever is configured) 
  
  oh, does it?

  oh!

> >  did you patch selinux/hooks.c to relax the constraints on
> >  the fscontext= parameter to allow the correct context to be
> >  correctly applied?  :)
> >
> 
> correct, not sure if this is the 100% right way to do it though, I think
> it would be better for the capabilities of the fs to be set properly
> instead of commenting out code, this will have better chance being
> included mainstream.
>
 
 well if someone wants to write a new patch to hooks.c and invent
 a new mount -o option oh i dunno overridecontext=.... then sure.

 it's all the same to me.

> > > > 
> > > >  so, not only must udev be patched to restore contexts but also
> > > >  the policies and various hacks added to "cope" with /dev being
> > > >  incredibly basic at startup - prior to udev running.
> > > 
> > > i have a simple persistent /dev which is used before udev runs, udev is
> > > then initialized, mounts a tmpfs over /dev (and restores its context) 
> > 
> >  oh.  ah.... you _restore_ its context (i.e. run restorecon
> >  /dev), you don't mount it with the modified mount -o fscontext=
> >  parameter?
> 
> correct!, it does the restore in udevstart

 ok.

 my question is: is this desirable behaviour?

> > > Seeing as my initial /dev is on a persistent 
> > > filesystem i don't have a problem with pre-udev stuff running.
> > 
> >  well.... you shouldn't... until you reinitialise or somehow delete,
> >  upgrade or otherwise modify the "old" /dev [which you will find is
> >  remounted --rbind to /.dev].
> 
> got no reason to add other entries to the pre-udev /dev, so as I said
> ItWorksForMe(tm).
> 
> > 
> >  try it: do setfiles /etc/selinux/src/file_contexts/file_contexts /.dev
> >  and then reboot [in permissive mode!!!]
> > 
> >  due to the present files/types.fc, you will find that the entire
> >  /.dev gets relabelled to something completely useless: root_t
> >  or default_t.  i think it's default_t.
> 
> yep, i'm 100% aware of this... i don't need /.dev, nor do I have it, nor
> do I want it ... heh, on installation of our distribution the pre-udev
> /dev is created and labeled correctly.

 ... how?

 and can you guarantee that it will _stay_ labelled correctly?


> > 
> >  consequently your next reboot in enforcing mode will fail because
> >  /sbin/init tries to access /dev/null and /dev/initctl etc. as
> >  default_t ... and it can't.
> > 
> 
> yep, but as I said... i don't label pre-udev /dev when udev is running,
> before I added it to our distro installer I mounted /dev/hda1 (root) as
> /mnt/hda1, chroot'd onto it and re-labeled the files there  (basically
> the same thing our installer does)

 that's cheating :)

> >  the list i have so far in /etc/modules.postudev contains (for my purposes):
> > 
> >  ppp_generic
> >  nvidia
> >  sg
> > 
> 
> no probs with any of these either (and yes we do use them), the pc i'm
> on runs dual-head nvidia ;-)
 
 bizarre.

 how do you deal with that?

 perhaps an answer would be best off-selinux list because it's not
 entirely relevant to selinux, more the use of it.


> every distro is different, so i would expect some to gulp bubbles and
> some not to... *shrug*
> 
> >  i don't believe that these modules should be loaded prior to udev
> >  being run: maybe they can, maybe they can't, maybe the nodes being
> >  loaded prior will result in a pending hotplug event such that when
> >  udev is run, the node gets created.
> 
> we load them after udev, and everything ends up labeled correctly...
> 
> for instance...
> 
> ot@localhost.localdomain policy]# ls -Z /dev/ppp
> ls: /dev/ppp: No such file or directory
> [root@localhost.localdomain policy]# modprobe ppp_generic
                                       ^^^^^^^^^^^^^^^^^^^^
  this is the bit that my /etc/init.d/modutils.postudev initscript
  does for me: i'd be interested to know if you do something similar.

  i can't be telling users to do _that_ they're unlikely
  even know what a ppp is, that a modprobe is something to do
  with police investigations in the 70s into the sex pistols,
  and if you mentioned xterm they'd call rentakill.


> [root@localhost.localdomain policy]# ls -Z /dev/ppp
> crw-------  root     root     system_u:object_r:ppp_device_t   /dev/ppp
> [root@localhost.localdomain policy]#

 yes, this i'd expect to happen... _if_ the modprobe ppp_generic command
 is ever issued [and users shouldn't be expected to do it!]

> >  perhaps there should be a "hook" into tmpfs to be able to pass
> >  filenames accessed in /dev on to udev, such that udev can go
> >  "oo, they tried to access /dev/ppp, let's kick off that module,
> >   then".
> 
> if you need any of my initscripts or anything, give me a shout, i've
> nearly got a 100% functional selinux enabled server!  ;-)

 if you could place them on a convenient http-accessible server
 somewhere near you, that'd be great.

 l.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
