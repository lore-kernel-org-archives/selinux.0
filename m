Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i1Q78XRb005019
	for <selinux@tycho.nsa.gov>; Thu, 26 Feb 2004 02:08:34 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i1Q78XQQ002629
	for <selinux@tycho.nsa.gov>; Thu, 26 Feb 2004 07:08:33 GMT
Received: from ns.sws.net.au ([61.95.69.3])
        by jazzband.ncsc.mil  with ESMTP id i1Q78LP0002532 for <selinux@tycho.nsa.gov>; Thu, 26 Feb 2004 07:08:32 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Chris PeBenito <pebenito@gentoo.org>
Subject: Re: [patch] etc type naming
Date: Thu, 26 Feb 2004 18:06:45 +1100
Cc: SELinux Mail List <selinux@tycho.nsa.gov>
References: <1072495081.4439.9.camel@chris.pebenito.net> <1073593716.28727.231.camel@moss-spartans.epoch.ncsc.mil> <1073614420.15555.1.camel@chris.pebenito.net>
In-Reply-To: <1073614420.15555.1.camel@chris.pebenito.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200402261806.45980.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 9 Jan 2004 13:13, Chris PeBenito <pebenito@gentoo.org> wrote:
> On Thu, 2004-01-08 at 14:28, Stephen Smalley wrote:
> > On Fri, 2003-12-26 at 22:18, Chris PeBenito wrote:
> > > Attached is a hefty patch to change almost all of the etc type names to
> > > be consistent with the rest of the policy naming.  Namely, the
> > > daemon/program is prefixed.
> > >
> > > ex: etc_cupsd_t -> cupsd_etc_t
> >
> > The kinder, gentler way of making this kind of change is to introduce
> > type aliases with the old type name so that people can easily migrate to
> > the new type names on running systems, e.g.
>
> Ah, good point.  I updated the patch to add in the type aliases.

I've included that into my tree.  While I was at it I used the new typealias 
directive, and I added some global macros etc_domain() and etcdir_domain().

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
