Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id SAA08354
	for <selinux@tycho.nsa.gov>; Wed, 12 Feb 2003 18:29:08 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id XAA23388
	for <selinux@tycho.nsa.gov>; Wed, 12 Feb 2003 23:26:03 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id XAA23384
	for <selinux@tycho.nsa.gov>; Wed, 12 Feb 2003 23:26:02 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: j.logsdon@lancaster.ac.uk, selinux@tycho.nsa.gov
Subject: Re: Simple question
Date: Thu, 13 Feb 2003 00:28:56 +0100
References: <Pine.LNX.4.10.10302122051230.25327-100000@mercury.quantex>
In-Reply-To: <Pine.LNX.4.10.10302122051230.25327-100000@mercury.quantex>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200302130028.56134.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 12 Feb 2003 22:40, j.logsdon@lancaster.ac.uk wrote:
> You have explained a clear difference but presumably if the ACL for
> setfacl etc are themselves restricted to root (or better another
> privileged user) and/or they are moved from /usr/bin to /usr/sbin, there
> is a another level of protection.  This doesn't protect you from a root
> hacker of course, which is the key Unix weakness that SEL is trying to
> eradicate.

If someone breaks the full administrative level of any common configuration 
then they get everything.  However SE Linux is very configurable and can be 
configured for uncommon configurations where no-one is permitted to make any 
changes.

Also many things that would result in a successful "root hack" on an 
unprotected Linux machine will not get anywhere on SE Linux.

> The issue of bind and dhcp as
> examples won't come up - they are not needed fortunately but sendmail,
> which is another candidate for hacking, and no doubt others will so there
> will always be weaknesses.

Yes, Sendmail is one of the worst.  Then there's FTP servers (almost all FTP 
servers have a bad history), there's database servers, there's game servers, 
and many others.

> As with all the moves in security, the ideal would be for them to be
> incorporated into the official releases of the kernel but 2.5.x is already
> getting pretty big and 2.6 when it is out (Q2/2k3?) will have so much more
> in it that it's almost starting a new OS!

This is in progress in 2.5.  Best to see the LSM list for the details.

> Obviously SEL is a much more sophisticated product and I may well go with
> it but I am a little nervous at getting into deeper water than I am used
> to!

If you compile a kernel with CONFIG_SECURITY_SELINUX_DEVELOP enabled then you 
can switch it to "permissive mode" at any time if something breaks, and you 
can initially run with no enforcement and policy violations are only logged 
not enforced.

Then once you get into it you'll find that it's not so difficult.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
