Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iA5FUNGZ000853
	for <selinux@tycho.nsa.gov>; Fri, 5 Nov 2004 10:30:23 -0500 (EST)
Received: from monk.area614.net (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id iA5F9jgk025651
	for <selinux@tycho.nsa.gov>; Fri, 5 Nov 2004 15:09:46 GMT
Subject: Re: Updated SELinux Release
From: Colin Walters <walters@verbum.org>
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Cc: Manoj Srivastava <manoj.srivastava@stdc.com>, selinux@tycho.nsa.gov,
   debian-devel@lists.debian.org
In-Reply-To: <20041105102853.GA5565@lkcl.net>
References: <1099496380.1213.111.camel@moss-spartans.epoch.ncsc.mil>
	 <Pine.LNX.4.58.0411031908500.12297@d10systems.homelinux.com>
	 <1099534538.3875.6.camel@nexus.verbum.private>
	 <87k6t2qepg.fsf@glaurung.internal.golden-gryphon.com>
	 <20041104131544.GC5461@lkcl.net>
	 <1099627566.25416.6.camel@nexus.verbum.private>
	 <20041105102853.GA5565@lkcl.net>
Content-Type: text/plain
Date: Fri, 05 Nov 2004 10:11:01 -0500
Message-Id: <1099667461.25416.27.camel@nexus.verbum.private>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2004-11-05 at 10:28 +0000, Luke Kenneth Casson Leighton wrote:
> On Thu, Nov 04, 2004 at 11:06:06PM -0500, Colin Walters wrote:
> > On Thu, 2004-11-04 at 13:15 +0000, Luke Kenneth Casson Leighton wrote:
> > 
> > >  default: no.
> > 
> > Why not on by default, 
> 
>  i would agree with stephen that it should be compiled in,
>  default options "selinux=no".

I don't believe Stephen said that.  He said that the performance hit in
that case is just the LSM hooks.

>  that gives people the choice, 

It doesn't make sense to make security a "choice".  The current Linux
security model is simply inadequate.

http://www.nsa.gov/selinux/papers/inevit-abs.cfm

> without affecting performance.

That's just a bug, and it's being worked on.  Personally I don't notice
any performance problems.

> > with a targeted policy, for everyone?  
> 
>  debianites have yet to be convinced of the benefits of
>  _anything_ to do with selinux [irrespective of whether they
>  are actually _aware_ of its benefits]

That's what we're working on.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
