Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iA5AIAXZ001566
	for <selinux@tycho.nsa.gov>; Fri, 5 Nov 2004 05:18:12 -0500 (EST)
Received: from open.hands.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id iA5AGmUH013657
	for <selinux@tycho.nsa.gov>; Fri, 5 Nov 2004 10:16:48 GMT
Date: Fri, 5 Nov 2004 10:28:53 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Colin Walters <walters@verbum.org>
Cc: Manoj Srivastava <manoj.srivastava@stdc.com>, selinux@tycho.nsa.gov,
   debian-devel@lists.debian.org
Subject: Re: Updated SELinux Release
Message-ID: <20041105102853.GA5565@lkcl.net>
References: <1099496380.1213.111.camel@moss-spartans.epoch.ncsc.mil> <Pine.LNX.4.58.0411031908500.12297@d10systems.homelinux.com> <1099534538.3875.6.camel@nexus.verbum.private> <87k6t2qepg.fsf@glaurung.internal.golden-gryphon.com> <20041104131544.GC5461@lkcl.net> <1099627566.25416.6.camel@nexus.verbum.private>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1099627566.25416.6.camel@nexus.verbum.private>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, Nov 04, 2004 at 11:06:06PM -0500, Colin Walters wrote:
> On Thu, 2004-11-04 at 13:15 +0000, Luke Kenneth Casson Leighton wrote:
> 
> >  default: no.
> 
> Why not on by default, 

 i would agree with stephen that it should be compiled in,
 default options "selinux=no".

 that gives people the choice, without affecting performance.

> with a targeted policy, for everyone?  

 debianites have yet to be convinced of the benefits of
 _anything_ to do with selinux [irrespective of whether they
 are actually _aware_ of its benefits]

 i specifically recall seeing a message from 2002 "the more i learn
 about selinux, i like it less and less".

 that having been said, i believe, like i think you do, that a
 targetted policy for debian _would_ make selinux much easier
 to accept.

 l.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
