Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iAFBqMIi022293
	for <selinux@tycho.nsa.gov>; Mon, 15 Nov 2004 06:52:23 -0500 (EST)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id iAFBorvq011074
	for <selinux@tycho.nsa.gov>; Mon, 15 Nov 2004 11:50:55 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Joshua Brindle <jbrindle@tresys.com>
Subject: Re: [RFC][PATCH] Control ability to have a writable executable mapping
Date: Mon, 15 Nov 2004 22:52:00 +1100
Cc: Stephen Smalley <sds@epoch.ncsc.mil>, selinux@tycho.nsa.gov,
   "Christopher J. PeBenito" <cpebenito@tresys.com>
References: <1100025603.408.203.camel@moss-spartans.epoch.ncsc.mil> <41914F8B.3060102@tresys.com>
In-Reply-To: <41914F8B.3060102@tresys.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200411152252.07081.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wednesday 10 November 2004 10:15, Joshua Brindle <jbrindle@tresys.com> 
wrote:
> I can't think of any circumstances where the domain which an application
> is in should have an impact on it's PaX flags.

Maybe instances of the application running in different domains will be 
permitted to load different DSOs such that one domain is permitted to load a 
DSO which wants write-execute access while another domain is not permitted to 
load such DSOs.

It's just a hypothetical, I don't know of an example of this happening.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
