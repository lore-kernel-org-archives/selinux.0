Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i8B6iFrT023456
	for <selinux@tycho.nsa.gov>; Sat, 11 Sep 2004 02:44:16 -0400 (EDT)
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i8B6iC6V028331
	for <selinux@tycho.nsa.gov>; Sat, 11 Sep 2004 06:44:15 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Bill Nottingham <notting@redhat.com>
Subject: Re: tmpfs /dev
Date: Sat, 11 Sep 2004 16:43:54 +1000
Cc: Development discussions related to Fedora Core <fedora-devel-list@redhat.com>,
   Daniel J Walsh <dwalsh@redhat.com>, SE Linux <selinux@tycho.nsa.gov>,
   "Fedora SELinux support list for users & developers." <fedora-selinux-list@redhat.com>
References: <200409100536.59711.russell@coker.com.au> <200409101508.27612.russell@coker.com.au> <20040910163021.GA28303@nostromo.devel.redhat.com>
In-Reply-To: <20040910163021.GA28303@nostromo.devel.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200409111643.54132.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 11 Sep 2004 02:30, Bill Nottingham <notting@redhat.com> wrote:
> Russell Coker (russell@coker.com.au) said:
> > On Fri, 10 Sep 2004 06:19, Daniel J Walsh <dwalsh@redhat.com> wrote:
> > > You will need to talk to Bill Nottingham about modifying /sbin/init to
> > > do this.  They are not crazy about
> > > putting additional code into /sbin/init since it is very hard to debug.
> >
> > We've done it once, we can do it again.
>
> But why is init any better? Especially when it's just spawning a
> shell script - that's a hack.

Spawning a shell script is good for a test.  If we decide to run it from init 
then we can do it differently in the release version of the code.

> > > They prefer rc.sysinit.  They also do not
> >
> > rc.sysinit means changing the policy for init_t, initrc_t, and maybe
> > others.
>
> init runs in init_t, surely?

init runs in init_t AFTER it re-exec's itself.  At the time it is doing the SE 
Linux stuff it's running as kernel_t or running on a system with no policy 
loaded.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
