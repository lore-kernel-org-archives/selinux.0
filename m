Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i899kUrT010370
	for <selinux@tycho.nsa.gov>; Thu, 9 Sep 2004 05:46:30 -0400 (EDT)
Received: from open.hands.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i899kUVJ019179
	for <selinux@tycho.nsa.gov>; Thu, 9 Sep 2004 09:46:30 GMT
Date: Thu, 9 Sep 2004 10:57:42 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Chris PeBenito <pebenito@gentoo.org>
Cc: SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: for bootsplash to operate correctly...
Message-ID: <20040909095742.GC12629@lkcl.net>
References: <20040908224108.GJ7717@lkcl.net> <1094698870.14648.19.camel@gorn.pebenito.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1094698870.14648.19.camel@gorn.pebenito.net>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, Sep 08, 2004 at 11:01:11PM -0400, Chris PeBenito wrote:
> On Wed, 2004-09-08 at 18:41, Luke Kenneth Casson Leighton wrote:
> > ... i hacked in the three following permissions:
> > 
> > # this is to allow splash to write to /proc/splash
> > allow initrc_t proc_t:file { write };
> 
> > # this is for fbmngplay to do err... *clueless*
> > allow initrc_t self:capability { sys_admin };
> > 
> > i look forward to one day writing a policy for the bootsplash
> > package :)
> > 
> 
> I threw together a bootsplash policy several months ago to get the
> Gentoo LiveCD going.  I always forget about it since I only use
> bootsplash on the LiveCD.  I didn't encounter that sys_admin capability
> that you have, but it might be a result of the bootsplash setings.  We
> probably should label /proc/splash differently, now that I think about
> it.
 
 fbmngplay is the "animations" program.

 [change of topic]

 i had to disable that for other reasons: because it is running,
 it seems to lock out the /usr partition.  because of that,
 umount at shutdown actually remounts it as read-only.  because
 of _that_, stupid-debian-selinux can't stupid-remount the
 stupid-/usr partition and you end up with an unusable system.

 if i disable selinux before one of these boots (permissive) then
 it boots up fine.

 l.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
