Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id KAA07082
	for <selinux@tycho.nsa.gov>; Tue, 3 Dec 2002 10:19:06 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id PAA16831
	for <selinux@tycho.nsa.gov>; Tue, 3 Dec 2002 15:16:49 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id PAA16827
	for <selinux@tycho.nsa.gov>; Tue, 3 Dec 2002 15:16:48 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Shaun Savage <savages@pcez.com>, selinux@tycho.nsa.gov
Subject: Re: RH 8.1
Date: Tue, 3 Dec 2002 16:18:55 +0100
Cc: sailorn@attglobal.net
References: <200212021621.LAA25269@moss-shockers.ncsc.mil> <3DECC486.7080201@pcez.com>
In-Reply-To: <3DECC486.7080201@pcez.com>
MIME-Version: 1.0
Message-Id: <200212031618.55787.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 3 Dec 2002 15:49, Shaun Savage wrote:
> | but the policy configuration will need some updating for it.  Also, the
> | patched utilities and daemons are based on older versions (from RH7.x),
> | so you will ultimately want to port the patches forward to the RH8.0 base
> | sources, although you may be able to use the older versions in the short
> | term.
>
> I have port most of the utils to RH 8.0. I have created rpms for both
> source and binary.  I still have problems with fileutils and strace
> patches.

What problems do you have?

> I do need a site that I can upload these to for distribution.  My DSL
> would be way too slow.

Why would it be too slow?  My web site is on a 256K frame link (shared with 
many other sites).  Your ADSL up-channel probably is at least as fast as the 
effective bandwidth on my site...

There's always sourceforge...

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
