Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iBPGlHIi011911
	for <selinux@tycho.nsa.gov>; Sat, 25 Dec 2004 11:47:17 -0500 (EST)
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id iBPGlHFA029452
	for <selinux@tycho.nsa.gov>; Sat, 25 Dec 2004 16:47:19 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Zia Syed <zia.chacho@gmail.com>
Subject: Re: fedora core 3, httpd and PHP exec()
Date: Sun, 26 Dec 2004 03:47:13 +1100
Cc: selinux@tycho.nsa.gov
References: <41CCEEB5.3040200@gmail.com> <200412251702.17953.russell@coker.com.au> <41CD5AAB.80505@smartweb.rgu.ac.uk>
In-Reply-To: <41CD5AAB.80505@smartweb.rgu.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200412260347.16199.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Saturday 25 December 2004 23:18, Zia Syed <zia.chacho@gmail.com> wrote:
> Thanks for your reply. Where should I write this rule? I search for
> documentation on selinux and according to them i need to put them in a
> .te file. However, I dont have any .te file on my system.

You need to install the package selinux-policy-X-sources where "X" is either 
"targeted" or "strict" depending on what you installed (most likely 
targeted).

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
