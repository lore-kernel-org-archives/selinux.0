Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i01BbNRb022350
	for <selinux@tycho.nsa.gov>; Thu, 1 Jan 2004 06:37:23 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i01BbM7m018540
	for <selinux@tycho.nsa.gov>; Thu, 1 Jan 2004 11:37:22 GMT
Received: from ns.sws.net.au ([61.95.69.3])
        by jazzband.ncsc.mil  with ESMTP id i01BbBLC018520 for <selinux@tycho.nsa.gov>; Thu, 1 Jan 2004 11:37:22 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Thibault Godouet <fcron@free.fr>
Subject: Re: [fcron announce] Fcron 2.9.4 - a replacement for Vixie cron and anacron
Date: Thu, 1 Jan 2004 22:35:38 +1100
References: <3FF0A314.6050509@free.fr>
In-Reply-To: <3FF0A314.6050509@free.fr>
Cc: SE Linux <selinux@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200401012235.38103.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 30 Dec 2003 08:56, Thibault Godouet <fcron@free.fr> wrote:
> What is new in this release (2.9.4) ?
> ------------------------------------
>
>      * Merged support for SE Linux (patch from Russell Coker : thanks !)

Thanks for that.

Since the time that I sent you the SE Linux patch the "new" SE Linux has 
become ready for wide use and the "old" SE Linux is deprecated.  But it was 
still good to have the SE Linux patch included in your tree as it make it 
much easier for me to put in new SE Linux support.

I have attached the patch I use which gives new SE Linux support in fcron, and 
also has the patch for building a Debian package (you may include the Debian 
patch in your tree if you wish - I don't feel strongly about it either way).

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
