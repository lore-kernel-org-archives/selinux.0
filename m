Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i4IKJcRb005095
	for <selinux@tycho.nsa.gov>; Tue, 18 May 2004 16:19:38 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i4IKJZAR020950
	for <selinux@tycho.nsa.gov>; Tue, 18 May 2004 20:19:35 GMT
Received: from smtp.sws.net.au ([61.95.69.6])
        by jazzband.ncsc.mil  with ESMTP id i4IKJYHn020855 for <selinux@tycho.nsa.gov>; Tue, 18 May 2004 20:19:34 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Thomas Bleher <bleher@informatik.uni-muenchen.de>
Subject: Re: [PATCH] some file_contexts for SuSE, binfmt_misc, small cleanup (was: Re: Suse)
Date: Wed, 19 May 2004 06:18:21 +1000
Cc: "'Selinux'" <selinux@tycho.nsa.gov>
References: <1084540729.17741.61.camel@moss-spartans.epoch.ncsc.mil> <200405171027.47689.russell@coker.com.au> <20040517231318.GA2127@jmh.mhn.de>
In-Reply-To: <20040517231318.GA2127@jmh.mhn.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200405190618.21025.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 18 May 2004 09:13, Thomas Bleher <bleher@informatik.uni-muenchen.de> 
wrote:
> This is a very good point.
> I just went through my tree and collected the patches (not all
> SuSE-specific) which I think can be applied immediately.
> The patches are:
> * binfmt_misc.patch - add support for mounting the binfmt_misc fs
> * file_contexts.patch - add a bunch of file contexts
> * cleanup.patch - some very small cleanup and policy additions
> The patches should apply cleanly against current CVS.

I think that we want to avoid file contexts for /tmp as much as possible.  I 
have removed the reference to /tmp from the file_contexts patch, but have 
applied everything else to my tree.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
