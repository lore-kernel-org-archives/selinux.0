Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hATLZYRb001306
	for <selinux@tycho.nsa.gov>; Sat, 29 Nov 2003 16:35:35 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id hATLYup5014332
	for <selinux@tycho.nsa.gov>; Sat, 29 Nov 2003 21:34:57 GMT
Received: from ns.sws.net.au (ns.sws.net.au [61.95.69.3])
	by jazzswing.ncsc.mil  with ESMTP id hATLYtt0014329
	for <selinux@tycho.nsa.gov>; Sat, 29 Nov 2003 21:34:56 GMT
Received: from localhost (localhost [127.0.0.1])
	by ns.sws.net.au (Postfix) with ESMTP id B7F3261BD5
	for <selinux@tycho.nsa.gov>; Sun, 30 Nov 2003 08:35:26 +1100 (EST)
Received: from ns.sws.net.au ([127.0.0.1])
	by localhost (ns [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 01725-04 for <selinux@tycho.nsa.gov>;
	Sun, 30 Nov 2003 08:35:26 +1100 (EST)
Received: from tsv.sws.net.au (tsv.sws.net.au [61.95.69.2])
	by ns.sws.net.au (Postfix) with ESMTP id 1371761BD1
	for <selinux@tycho.nsa.gov>; Sun, 30 Nov 2003 08:35:26 +1100 (EST)
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id DAA35924CC
	for <selinux@tycho.nsa.gov>; Sun, 30 Nov 2003 08:35:25 +1100 (EST)
Received: from localhost (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with ESMTP id 1BE157F26F
	for <selinux@tycho.nsa.gov>; Sun, 30 Nov 2003 08:35:23 +1100 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: selinux@tycho.nsa.gov
Subject: Re: policy under version control
Date: Sun, 30 Nov 2003 08:35:22 +1100
References: <20031129132619.GE26960@lukas.schuldei.com> <20031129160507.A9332@lemuria.org>
In-Reply-To: <20031129160507.A9332@lemuria.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200311300835.22630.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 30 Nov 2003 02:05, Tom <tom@lemuria.org> wrote:
> On Sat, Nov 29, 2003 at 02:26:19PM +0100, Andreas Schuldei wrote:
> > I find it tiresom and uneffective to make changes to policy
> > without and easy way to feed my effords upstream. Actually i feel
> > selinux stands and falls with a smoothly working policy. this
> > needs attention and time of many, not just one.

Currently the most effective way of getting policy changes sent upstream is to 
send them to me, I bundle them with other patches and send them to Howard.

> Also, the update process needs refinement. For one, I find it very
> tiresome (and error-prone!) to not bundle packages.
>
> For example, there are many policy files that we can be reasonably sure
> will be part of EVERY system. I don't know many Linux systems that
> wouldn't want the rules for mount and init, for example.
>
> Why not just lump them into one bundle? Not one .te file, but one
> installer question.

This is a different issue to that raised by Andreas.  It will be resolved for 
Debian when Collin's code is merged (should happen soon).

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
