Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h5J0fJI4000212
	for <selinux@tycho.nsa.gov>; Wed, 18 Jun 2003 20:41:19 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h5J0fI5e018903
	for <selinux@tycho.nsa.gov>; Thu, 19 Jun 2003 00:41:19 GMT
Received: from sat.sws.net.au ([202.5.161.49])
        by jazzband.ncsc.mil  with ESMTP id h5J0fB92018881 for <selinux@tycho.nsa.gov>; Thu, 19 Jun 2003 00:41:17 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Andreas Schuldei <andreas@schuldei.org>, selinux@tycho.nsa.gov
Subject: Re: how usable is selinux in lsm-2.5?
Date: Thu, 19 Jun 2003 10:40:49 +1000
References: <20030618212607.GB5278@schuldei.org>
In-Reply-To: <20030618212607.GB5278@schuldei.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200306191040.50001.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 19 Jun 2003 07:27, Andreas Schuldei wrote:
> I notice with satisfaction that lsm-2.5 with selinux configured
> in compiles fine here.
>
> what is missing from it to be usable? Or which parts are there
> and what can one do with them?
>
> will the 2.4 userspace which russel and brian ship in debian
> packages work on this kernel? I understand that the proc
> interface changed. are there patches for userspace allready?

The packages that Brian and I provide will not work with the new xattr based 
interface in 2.5.x.  To get it working you need to compile your own versions 
of login, cron, and other patched programs with support for this.

At some future time Brian and I will work on this, but if you would like to 
start maintaining some packages for 2.5.x support then that would be would 
help us.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
