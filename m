Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iA5FloGZ001328
	for <selinux@tycho.nsa.gov>; Fri, 5 Nov 2004 10:47:51 -0500 (EST)
Received: from open.hands.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id iA5FkOgk027982
	for <selinux@tycho.nsa.gov>; Fri, 5 Nov 2004 15:46:28 GMT
Date: Fri, 5 Nov 2004 15:57:52 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Colin Walters <walters@verbum.org>
Cc: Manoj Srivastava <manoj.srivastava@stdc.com>, selinux@tycho.nsa.gov,
   debian-devel@lists.debian.org
Subject: Re: Updated SELinux Release
Message-ID: <20041105155752.GC5565@lkcl.net>
References: <1099496380.1213.111.camel@moss-spartans.epoch.ncsc.mil> <Pine.LNX.4.58.0411031908500.12297@d10systems.homelinux.com> <1099534538.3875.6.camel@nexus.verbum.private> <87k6t2qepg.fsf@glaurung.internal.golden-gryphon.com> <20041104131544.GC5461@lkcl.net> <1099627566.25416.6.camel@nexus.verbum.private> <20041105102853.GA5565@lkcl.net> <1099667461.25416.27.camel@nexus.verbum.private>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1099667461.25416.27.camel@nexus.verbum.private>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, Nov 05, 2004 at 10:11:01AM -0500, Colin Walters wrote:
> On Fri, 2004-11-05 at 10:28 +0000, Luke Kenneth Casson Leighton wrote:
> > On Thu, Nov 04, 2004 at 11:06:06PM -0500, Colin Walters wrote:
> > > On Thu, 2004-11-04 at 13:15 +0000, Luke Kenneth Casson Leighton wrote:
> > > 
> > > >  default: no.
> > > 
> > > Why not on by default, 
> > 
> >  i would agree with stephen that it should be compiled in,
> >  default options "selinux=no".
> 
> I don't believe Stephen said that.  He said that the performance hit in
> that case is just the LSM hooks.
 
 oh. yes.

> >  that gives people the choice, 
> 
> It doesn't make sense to make security a "choice".  The current Linux
> security model is simply inadequate.

 response 1: *shrug*.  that's their choice - and their problem.

 response 2: you don't have to tell _me_ that - i'm the mad one who is
 actively working on a debian/selinux distro!!! :)

 response 3: _is_ it the job of debian developers to dictate the minimum
 acceptable security level?

 basically what i mean is, in gentoo, it's a no-brainer: you set options
 at the beginning of your build, come back [2 weeks? :) ] later and you
 have a system with PAX stack smashing, lovely kernel, everything
 hunky-dory.

 debian doesn't GIVE users that choice [remember the adamantix
 bun-fight, anyone?] and instead settles for about the lowest possible
 common denominator - no consideration to modern security AT ALL!

> > without affecting performance.
> 
> That's just a bug, and it's being worked on.  

 cool.

> Personally I don't notice any performance problems.
 
 maybe it's just me with my weird setup [very likely], but
 running mozilla under KDE 3.3.0 with selinux 2.6.8.1-selinux1
 on a 256mb system P4 2.4Ghz) is a 10-11 second startup,
 whereas if i set selinux=0 i've seen as fast as a THREE second
 startup time.

 i've put KDE_IS_PRELINKED=1, KDE_FORK_SLAVES=1 into the
 /usr/bin/startkde and i've run prelink, but i have the nvidia drivers
 so the x-windows glx drivers are symlinks, which stops prelink from
 being able to do its job on them.

 also i recompiled kde 3.3.0 .debs with the latest gcc 3.3.

 so i'm not _entirely_ confident that my setup is a good example to
 follow (!)

-- 
--
you don't have to BE MAD   | this space    | my brother wanted to join mensa,
  to work, but   IT HELPS  |   for rent    | for an ego trip - and get kicked 
 you feel better!  I AM    | can pay cash  | out for a even bigger one.
--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
