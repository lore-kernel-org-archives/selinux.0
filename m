Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id CAA22480
	for <selinux@tycho.nsa.gov>; Tue, 25 Feb 2003 02:45:23 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id HAA00908
	for <selinux@tycho.nsa.gov>; Tue, 25 Feb 2003 07:42:10 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id HAA00904
	for <selinux@tycho.nsa.gov>; Tue, 25 Feb 2003 07:42:08 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Tom <tom@lemuria.org>
Subject: Re: Core policy
Date: Tue, 25 Feb 2003 08:45:10 +0100
Cc: Wayne Salamon <wsalamon@tislabs.com>, SE Linux <selinux@tycho.nsa.gov>
References: <Pine.LNX.4.33.0302241349350.1479-100000@vox.gw.tislabs.com> <200302242059.51557.russell@coker.com.au> <20030224235117.B11665@lemuria.org>
In-Reply-To: <20030224235117.B11665@lemuria.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200302250845.10294.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 24 Feb 2003 23:51, Tom wrote:
> On Mon, Feb 24, 2003 at 08:59:51PM +0100, Russell Coker wrote:
> > > gpm.te		General Purpose Mouse driver
> >
> > GPM is not suitable for core IMHO.  I've never used it or seen anyone use
> > it.
>
> Isn't gpm required by vim in Debian?

Apparently not.  The vim package does not require it, and I've used vim 
without using gpm before.  The vim package does require libgpmg1, but that 
doesn't require any SE policy.

> If it's installed per default,
> even if not used, the policy should be there.

The priority for gpm is "optional", while netkit-inetd is "important".  
Therefore I think that inetd policy should be in core and gpm shouldn't.

Also if you were to poll 100 admins as to what is a standard part of a Linux 
system, I expect that at least 90 would say inetd, while no more than 5 would 
say gpm.

> I use xfs-tt on my workstations, and you're correct, the main reason is
> anti-aliasing. Both machines work just fine without xfs.

Installing xfs policy won't be that difficult if you really need it.  Just as 
installing gpm policy won't b e difficult.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
