Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id RAA20292
	for <selinux@tycho.nsa.gov>; Mon, 24 Feb 2003 17:57:32 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h1OMvVI15585
	for <selinux@tycho.nsa.gov>; Mon, 24 Feb 2003 22:57:31 GMT
Received: from unicorn.lemuria.org (c145118.adsl.hansenet.de [213.39.145.118])
        by jazzband.ncsc.mil  with ESMTP id h1OMvTf15577 for <selinux@tycho.nsa.gov>; Mon, 24 Feb 2003 22:57:30 GMT
Date: Mon, 24 Feb 2003 23:51:17 +0100
From: Tom <tom@lemuria.org>
To: Russell Coker <russell@coker.com.au>
Cc: Wayne Salamon <wsalamon@tislabs.com>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Core policy
Message-ID: <20030224235117.B11665@lemuria.org>
References: <Pine.LNX.4.33.0302241349350.1479-100000@vox.gw.tislabs.com> <200302242059.51557.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200302242059.51557.russell@coker.com.au>; from russell@coker.com.au on Mon, Feb 24, 2003 at 08:59:51PM +0100
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, Feb 24, 2003 at 08:59:51PM +0100, Russell Coker wrote:
> > gpm.te		General Purpose Mouse driver
> 
> GPM is not suitable for core IMHO.  I've never used it or seen anyone use it.

Isn't gpm required by vim in Debian? If it's installed per default,
even if not used, the policy should be there.


> xfs is not required IMHO.  I think that the only need for XFS is for TrueType 
> fonts, and I get the impression that anti-aliasing benefits from this too.  
> But the core functionality is fine without it.

I use xfs-tt on my workstations, and you're correct, the main reason is
anti-aliasing. Both machines work just fine without xfs.


-- 
http://web.lemuria.org/pubkey.html
pub  1024D/2D7A04F5 2002-05-16 Tom Vogt <tom@lemuria.org>
     Key fingerprint = C731 64D1 4BCF 4C20 48A4  29B2 BF01 9FA1 2D7A 04F5

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
