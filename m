Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hACNx6Sf016434
	for <selinux@tycho.nsa.gov>; Wed, 12 Nov 2003 18:59:06 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id hACNx5qY020506
	for <selinux@tycho.nsa.gov>; Wed, 12 Nov 2003 23:59:05 GMT
Received: from moss-huskies.epoch.ncsc.mil (moss-huskies.epoch.ncsc.mil [144.51.25.7])
        by jazzband.ncsc.mil  with ESMTP id hACNx50o020503 for <selinux@tycho.nsa.gov>; Wed, 12 Nov 2003 23:59:05 GMT
Received: from moss-huskies.epoch.ncsc.mil (localhost.localdomain [127.0.0.1])
	by moss-huskies.epoch.ncsc.mil (8.12.8/8.12.8) with ESMTP id hACNx4h9019709
	for <selinux@tycho.nsa.gov>; Wed, 12 Nov 2003 18:59:04 -0500
Received: (from hdholm@localhost)
	by moss-huskies.epoch.ncsc.mil (8.12.8/8.12.8/Submit) id hACNx4eV019707
	for selinux@tycho.nsa.gov; Wed, 12 Nov 2003 18:59:04 -0500
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Dean Anderson <dean@av8.com>
Subject: Re: Verify the integrity of downloads
Date: Thu, 13 Nov 2003 10:54:48 +1100
Cc: <SELinux@tycho.nsa.gov>
References: <Pine.LNX.4.44.0311101958440.8992-100000@vista.av8.net>
In-Reply-To: <Pine.LNX.4.44.0311101958440.8992-100000@vista.av8.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200311131054.48634.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 11 Nov 2003 12:05, Dean Anderson wrote:
> Certain ISPs in the Netherlands permit scanning that other ISPs think is
> inappropriate.  Thus, said ISPs are blocked from entering the US by
> certain American ISPs.  This could affect the NSA public sites, I suppose.

Every ISP that has any customers permits scanning that some ISPs won't like.  
If you lock down customers too much they go elsewhere.  The solution to such 
problems is to avoid getting hosting through American ISPs that put in stupid 
filters.

> On the other hand, it could the user's ISP that is blocking the NSA...

Unlikely.  Blocking web servers makes the ISP an "editor" of the Internet 
content (and therefore legally liable to some degree for what they don't 
censor).  This is why hardly any ISPs block the truely objectionable 
material.

> One used to be able to tell where the block was by the ICMP error return,
> but some many ISPs are blocking ICMP these days that it is hard to tell
> what is wrong, or where.

If we got in contact with the person who reported this problem then we could 
probably track it down in a small amount of time.  The real problem here is 
that we don't even have contact with the person who had the problem (and lots 
of people want to download SE Linux without identifying themselves, so 
presumably they aren't the only one).

For the record anyone who has problems downloading SE Linux related files from 
the NSA site can contact me by email or IRC (I am usually on #selinux on 
irc.freenode.net) and I'll help track it down.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
