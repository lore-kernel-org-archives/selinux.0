Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i94KDIrT021382
	for <selinux@tycho.nsa.gov>; Mon, 4 Oct 2004 16:13:19 -0400 (EDT)
Received: from moss-lions.epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i94KDIs6026345
	for <selinux@tycho.nsa.gov>; Mon, 4 Oct 2004 20:13:18 GMT
Subject: Re: policy patches
From: James Carter <jwcart2@epoch.ncsc.mil>
Reply-To: jwcart2@epoch.ncsc.mil
To: Russell Coker <russell@coker.com.au>
Cc: SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <200410020344.04225.russell@coker.com.au>
References: <200409292354.15227.russell@coker.com.au>
	 <200409300620.41527.russell@coker.com.au>
	 <1096648965.13366.35.camel@moss-lions.epoch.ncsc.mil>
	 <200410020344.04225.russell@coker.com.au>
Content-Type: text/plain
Message-Id: <1096920735.3235.17.camel@moss-lions.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Mon, 04 Oct 2004 16:12:15 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Merged the start_udev line and the kudzu patch.

On Fri, 2004-10-01 at 13:44, Russell Coker wrote:
> On Sat, 2 Oct 2004 02:42, James Carter <jwcart2@epoch.ncsc.mil> wrote:
> > Mostly merged with the corrections.
> >
> > These two lines caused things to break, so I held off merging these for
> > now.
> > +/sbin/kmodule  --      system_u:object_r:kudzu_exec_t
> > +/sbin/start_udev --    system_u:object_r:udev_exec_t
> >
> > These are the denials I am seeing:
> > avc:  denied  { unlink } for  pid=705 exe=/bin/rm name=.udev.tdb dev=tmpfs
> > ino=927 scontext=system_u:system_r:udev_t
> 
> Version 7.85-1 of the initscripts package fixes the restorecon command to use 
> the -R option to label all of /dev.  If you upgrade to the latest rawhide 
> then the start_udev labelling should work.  NB  I sent the patch to you 
> before rawhide was fixed, this was intentional as neither patch worked well 
> without the other so there was no benefit in delaying.

> > avc:  denied  { search } for  pid=856 exe=/sbin/kmodule
> > name=usr dev=hda2 ino=162881 scontext=system_u:system_r:kudzu_t
> > tcontext=user_u:object_r:file_t tclass=dir
> 
> Looks like either mis-labelling or you have /usr on a different file system.  
> I guess we have to add a dontaudit rule for that for when /usr (or /var or 
> whatever else it may access that isn't on the root fs).
> 

I do have /usr on a different file system.

> > avc:  denied  { getattr } for  
> > pid=856 exe=/sbin/kmodule path=/lib/modules/2.6.8-1.541/kernel dev=hda2
> > ino=930725 scontext=system_u:system_r:kudzu_t
> > tcontext=system_u:object_r:modules_object_t tclass=dir
> 
> I've attached kudzu.diff to deal with this issue and the above.  Please try 
> including those file contexts changes, with kudzu.diff and the latest 
> initscripts it should be fine.
> 
> > avc:  denied  { 
> > setattr } for  pid=2402 exe=/usr/X11R6/bin/Xorg name=dri dev=tmpfs ino=7757
> > scontext=system_u:system_r:xdm_xserver_t
> > tcontext=system_u:object_r:device_t tclass=dir
> 
> I think that Dan's latest patch allowed that one.
> 
> > The xdm_xserver_t device_t:dir setattr denial is not due to this patch.
> > It is the only denial that I have been seeing lately; I just haven't had
> > an opportunity to look into it more.  It doesn't appear to cause any
> > problems though.
> 
> Long term udev has to deal with that too.  The X server should not be creating 
> device nodes.  Quite a bit of work has recently gone into reducing /dev/mem 
> access but allowing arbitrary device node creation wastes that.  It'll be 
> fixed eventually (but at the moment we are already busy enough with udev 
> issues).
-- 
James Carter <jwcart2@epoch.ncsc.mil>
National Security Agency

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
