Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h7MBVCLa008657
	for <selinux@tycho.nsa.gov>; Fri, 22 Aug 2003 07:31:12 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h7MBVBfF013497
	for <selinux@tycho.nsa.gov>; Fri, 22 Aug 2003 11:31:11 GMT
Received: from moss-lions.epoch.ncsc.mil (moss-lions.epoch.ncsc.mil [144.51.25.4])
        by jazzband.ncsc.mil  with ESMTP id h7MBVAHd013494 for <selinux@tycho.nsa.gov>; Fri, 22 Aug 2003 11:31:10 GMT
Received: from moss-lions.epoch.ncsc.mil (localhost.localdomain [127.0.0.1])
	by moss-lions.epoch.ncsc.mil (8.12.8/8.12.8) with ESMTP id h7MBVAmG009160
	for <selinux@tycho.nsa.gov>; Fri, 22 Aug 2003 07:31:10 -0400
Received: (from jwcart2@localhost)
	by moss-lions.epoch.ncsc.mil (8.12.8/8.12.8/Submit) id h7MBVAXm009158
	for selinux@tycho.nsa.gov; Fri, 22 Aug 2003 07:31:10 -0400
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Colin Walters <walters@verbum.org>
Subject: Re: 2.6.0-test3
Date: Fri, 22 Aug 2003 12:36:16 +1000
Cc: SELinux@tycho.nsa.gov
References: <1061468940.1665.16.camel@kusturica> <200308212337.59952.russell@coker.com.au> <1061487623.22355.27.camel@columbia>
In-Reply-To: <1061487623.22355.27.camel@columbia>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200308221236.16677.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 22 Aug 2003 03:40, Colin Walters wrote:
> Eventually, I'd like to not have to use any packages outside of unstable
> at all.  Russell, what do you think about starting to send these patches
> to the Debian package maintainers and get them integrated?  At least the
> Debian coreutils package already applies over 50 patches, one more
> wouldn't hurt :)

I think it's a great idea.

In fact I will move my old-SE Linux packages out of Debian.  Anyone who wants 
backward compatability can use my personal site, and your packages for 2.6 
etc can go into main.

I will continue to maintain the policy package however.

Colin, I suggest that you resist the temptation to upload a "selinux" package 
which depends on all your packages.  Make your packages conflict/replace 
selinux.

I will file the bug report requesting that my selinux-small packages be 
removed from main and that your packages replace them.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
