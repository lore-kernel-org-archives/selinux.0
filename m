Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h984OlWt016770
	for <selinux@tycho.nsa.gov>; Wed, 8 Oct 2003 00:24:47 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h984Ok7d007773
	for <selinux@tycho.nsa.gov>; Wed, 8 Oct 2003 04:24:46 GMT
Received: from tsv.sws.net.au ([61.95.69.2])
        by jazzband.ncsc.mil  with ESMTP id h984OgRn007770 for <selinux@tycho.nsa.gov>; Wed, 8 Oct 2003 04:24:44 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: =?iso-8859-2?q?Magos=E1nyi=20=C1rp=E1d?= <mag@bunuel.tii.matav.hu>
Subject: Re: [selinux] init
Date: Wed, 8 Oct 2003 14:24:19 +1000
Cc: Stephen Smalley <sds@epoch.ncsc.mil>, SE Linux <selinux@tycho.nsa.gov>
References: <200310080111.50210.russell@coker.com.au> <1065558422.7696.106.camel@kusturica>
In-Reply-To: <1065558422.7696.106.camel@kusturica>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Message-Id: <200310081424.19249.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 8 Oct 2003 06:27, Magosányi Árpád wrote:
> I would vote for 5 being
> < 5) if policy isn't loaded and we don't have [some indication that we
> do not insist on selinux], halt the system with an appropriate message.
>
> The indication could be that there is no selinux support in the kernel,
> or some boot option.

Currently we have been working towards making a SE Linux system be usable if 
booted with a non-SE kernel.  We could have a compile option to do what you 
request, but I doubt that we want it on by default.  We certainly don't want 
it in RPMs that we ship!

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
