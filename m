Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id DAA22607
	for <selinux@tycho.nsa.gov>; Tue, 25 Feb 2003 03:29:34 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id IAA02159
	for <selinux@tycho.nsa.gov>; Tue, 25 Feb 2003 08:26:21 GMT
Received: from nox.lemuria.org (nox.lemuria.org [213.191.86.30])
	by jazzswing.ncsc.mil  with ESMTP id IAA02155
	for <selinux@tycho.nsa.gov>; Tue, 25 Feb 2003 08:26:20 GMT
Date: Tue, 25 Feb 2003 09:29:31 +0100
From: Tom <tom@lemuria.org>
To: Russell Coker <russell@coker.com.au>
Cc: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Core policy
Message-ID: <20030225092931.A15162@lemuria.org>
References: <Pine.LNX.4.33.0302241349350.1479-100000@vox.gw.tislabs.com> <200302242059.51557.russell@coker.com.au> <20030224235117.B11665@lemuria.org> <200302250845.10294.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200302250845.10294.russell@coker.com.au>; from russell@coker.com.au on Tue, Feb 25, 2003 at 08:45:10AM +0100
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, Feb 25, 2003 at 08:45:10AM +0100, Russell Coker wrote:
> Apparently not.  The vim package does not require it, and I've used vim 
> without using gpm before.  The vim package does require libgpmg1, but that 
> doesn't require any SE policy.

You and Brian are right, it's libgpm, not gpm itself.


> > I use xfs-tt on my workstations, and you're correct, the main reason is
> > anti-aliasing. Both machines work just fine without xfs.
> 
> Installing xfs policy won't be that difficult if you really need it.  Just as 
> installing gpm policy won't b e difficult.

I was trying to say: Leave it out, it's not important. Even if it's
installed and used, breaking it will not cause much trouble, only a few
apps won't look that crisp anymore and a few fonts won't work. Nothing
serious compared to, say, a failure to boot up correctly.


-- 
PGP/GPG key: http://web.lemuria.org/pubkey.html
pub  1024D/2D7A04F5 2002-05-16 Tom Vogt <tom@lemuria.org>
     Key fingerprint = C731 64D1 4BCF 4C20 48A4  29B2 BF01 9FA1 2D7A 04F5

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
