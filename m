Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i91GhirT002779
	for <selinux@tycho.nsa.gov>; Fri, 1 Oct 2004 12:43:44 -0400 (EDT)
Received: from moss-lions.epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i91GhhEZ006794
	for <selinux@tycho.nsa.gov>; Fri, 1 Oct 2004 16:43:43 GMT
Subject: Re: policy patches
From: James Carter <jwcart2@epoch.ncsc.mil>
Reply-To: jwcart2@epoch.ncsc.mil
To: Russell Coker <russell@coker.com.au>
Cc: SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <200409300620.41527.russell@coker.com.au>
References: <200409292354.15227.russell@coker.com.au>
	 <20040929174540.GA4373@rom.cip.ifi.lmu.de>
	 <200409300620.41527.russell@coker.com.au>
Content-Type: text/plain
Message-Id: <1096648965.13366.35.camel@moss-lions.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Fri, 01 Oct 2004 12:42:45 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Mostly merged with the corrections.

These two lines caused things to break, so I held off merging these for
now.
+/sbin/kmodule  --      system_u:object_r:kudzu_exec_t
+/sbin/start_udev --    system_u:object_r:udev_exec_t

These are the denials I am seeing:
avc:  denied  { unlink } for  pid=705 exe=/bin/rm name=.udev.tdb dev=tmpfs ino=927 scontext=system_u:system_r:udev_t tcontext=system_u:object_r:tmpfs_t tclass=file
avc:  denied  { read write } for  pid=707 exe=/sbin/udev name=.udev.tdb dev=tmpfs ino=927 scontext=system_u:system_r:udev_t tcontext=system_u:object_r:tmpfs_t tclass=file
avc:  denied  { search } for  pid=856 exe=/sbin/kmodule name=usr dev=hda2 ino=162881 scontext=system_u:system_r:kudzu_t tcontext=user_u:object_r:file_t tclass=dir
avc:  denied  { getattr } for  pid=856 exe=/sbin/kmodule path=/lib/modules/2.6.8-1.541/kernel dev=hda2 ino=930725 scontext=system_u:system_r:kudzu_t tcontext=system_u:object_r:modules_object_t tclass=dir
avc:  denied  { setattr } for  pid=2402 exe=/usr/X11R6/bin/Xorg name=dri dev=tmpfs ino=7757 scontext=system_u:system_r:xdm_xserver_t tcontext=system_u:object_r:device_t tclass=dir

The udev_t tmpfs_t:file { read write } denial occurs a lot.

The xdm_xserver_t device_t:dir setattr denial is not due to this patch. 
It is the only denial that I have been seeing lately; I just haven't had
an opportunity to look into it more.  It doesn't appear to cause any
problems though.

On Wed, 2004-09-29 at 16:20, Russell Coker wrote:
> On Thu, 30 Sep 2004 03:45, Thomas Bleher <bleher@informatik.uni-muenchen.de> 
> wrote:
> > > +ifdef(`unlimitedUsers', `
> > > +role staff_r types rpm_t;
> > > +domain_auto_trans(staff_t, rpm_exec_t, rpm_t)
> > > +')
> >
> > AFAIK unlimitedUsers was removed recently, so this snippet makes no
> > sense anymore.
> 
> Thanks, I've removed that from my tree.
> 
> > On Debian, it's
> > /usr/sbin/nagios                --      system_u:object_r:nagios_exec_t
> > and
> > /usr/lib/cgi-bin/nagios         --      system_u:object_r:nagios_cgi_exec_t
> >
> > These should be added also.
> 
> Thanks for that.  I've attached a new nagios.fc with that change.
-- 
James Carter <jwcart2@epoch.ncsc.mil>
National Security Agency

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
