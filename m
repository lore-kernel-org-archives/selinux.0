Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i2O7CKRb005549
	for <selinux@tycho.nsa.gov>; Wed, 24 Mar 2004 02:12:21 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i2O7CJFV007791
	for <selinux@tycho.nsa.gov>; Wed, 24 Mar 2004 07:12:20 GMT
Received: from ns.sws.net.au ([61.95.69.3])
        by jazzband.ncsc.mil  with ESMTP id i2O7C836007142 for <selinux@tycho.nsa.gov>; Wed, 24 Mar 2004 07:12:19 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Stephen Smalley <sds@epoch.ncsc.mil>
Subject: Re: patch for libselinux1
Date: Wed, 24 Mar 2004 18:10:45 +1100
Cc: SE Linux <selinux@tycho.nsa.gov>
References: <200403232125.21252.russell@coker.com.au> <1080050046.30176.75.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1080050046.30176.75.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200403241810.45211.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 24 Mar 2004 00:54, Stephen Smalley <sds@epoch.ncsc.mil> wrote:
> > It's not a significant issue for Fedora at the moment as no-one will be
> > mounting /selinux by hand (I hope).  But it's already become an issue for
> > Debian (I've uploaded a fixed package to Debian already).
>
> Your patch has a few bugs in it.  How about this one instead?

Yes, your patch is much better.  I've done a new upload to Debian with your 
patch.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
