Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i818MKrT019139
	for <selinux@tycho.nsa.gov>; Wed, 1 Sep 2004 04:22:20 -0400 (EDT)
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i818MIeu023022
	for <selinux@tycho.nsa.gov>; Wed, 1 Sep 2004 08:22:19 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Joshua Brindle <method@gentoo.org>
Subject: Re: automount policy
Date: Wed, 1 Sep 2004 18:22:16 +1000
Cc: SE-Linux <selinux@tycho.nsa.gov>, Daniel J Walsh <dwalsh@redhat.com>
References: <200409011238.15293.russell@coker.com.au> <4135433D.1090506@gentoo.org>
In-Reply-To: <4135433D.1090506@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200409011822.16392.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 1 Sep 2004 13:34, Joshua Brindle <method@gentoo.org> wrote:
> >-allow initrc_t automount_etc_t:file getattr;
> >+allow initrc_t automount_etc_t:file { getattr read };
>
> Why add this allow for everyone if it's just for rawhide?

It appears to also be necessary for Debian.  If Gentoo is different then we 
could have ifdef(`distro_gentoo', `', ` before it.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
