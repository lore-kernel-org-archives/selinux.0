Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i4IJrxRb004858
	for <selinux@tycho.nsa.gov>; Tue, 18 May 2004 15:53:59 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i4IJrvAR019024
	for <selinux@tycho.nsa.gov>; Tue, 18 May 2004 19:53:57 GMT
Received: from smtp.sws.net.au ([61.95.69.6])
        by jazzband.ncsc.mil  with ESMTP id i4IJrtHn018907 for <selinux@tycho.nsa.gov>; Tue, 18 May 2004 19:53:56 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Stephen Smalley <sds@epoch.ncsc.mil>
Subject: Re: suggestion to help transition to selinux: dynamic loading of libselinux
Date: Wed, 19 May 2004 05:52:43 +1000
Cc: Luke Kenneth Casson Leighton <lkcl@lkcl.net>, selinux@tycho.nsa.gov
References: <20040515232606.GA9378@lkcl.net> <1084898046.28966.100.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1084898046.28966.100.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200405190552.43316.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 19 May 2004 02:34, Stephen Smalley <sds@epoch.ncsc.mil> wrote:
> Interestingly, this issue just came up on the userlinux mailing list;
> someone noticed that upon doing an apt-get update, they pulled in
> libselinux1.  After a bit of investigation, they found that this was due
> to updating gdm, because the SELinux patch for gdm is already
> upstreamed.

I don't think that is a problem.  If you have gdm installed then you have lots 
of other libraries dragged in by gdm itself and by all the other GNOME 
components.  libselinux should be lost in the noise.

Using dlopen for SE Linux alone is not worth-while for gdm (IMHO) unless we 
find a more generic use for the mechanism (IE supporting things other than SE 
Linux).

> Note of caution:  Some people still build /sbin/init statically, I
> think, and we don't want to prevent people from doing so just for
> SELinux.  The current patches allow for that; if we rewrite them to use
> dlopen, won't that be a problem?

To support that we would want to have #ifdef STATIC_BUILD or something 
similar.  That should not be hard to do.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
