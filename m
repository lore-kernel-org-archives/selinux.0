Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h768bjHa025299
	for <selinux@tycho.nsa.gov>; Wed, 6 Aug 2003 04:37:46 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h768aUFB014160
	for <selinux@tycho.nsa.gov>; Wed, 6 Aug 2003 08:36:30 GMT
Received: from tsv.sws.net.au ([61.95.69.2])
	by jazzswing.ncsc.mil  with ESMTP id h768aTGD014155
	for <selinux@tycho.nsa.gov>; Wed, 6 Aug 2003 08:36:29 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Chris PeBenito <pebenito@gentoo.org>,
   SELinux Mail List <selinux@tycho.nsa.gov>
Subject: Re: [patch] initrd Makefile target
Date: Wed, 6 Aug 2003 18:37:32 +1000
References: <1060132448.678.13.camel@chris.pebenito.net>
In-Reply-To: <1060132448.678.13.camel@chris.pebenito.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200308061837.32187.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 6 Aug 2003 11:14, Chris PeBenito wrote:
> Please consider this patch for inclusion into the new api policy.  It
> creates a initrd target in the policy Makefile.  By default it creates
> /boot/initrd-$(KV) where KV defaults to `uname -r`.  However a user may
> be creating an initrd for a newly installed kernel, so that obviously
> could be overridden on the commandline:

There are at least two different "mkinitrd" programs in common use, the Red 
Hat one and the Debian one.

This sort of patch is probably best left as a distribution patch, otherwise 
those of us who use different mkinitrd programs will just have to patch out 
your changes.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
