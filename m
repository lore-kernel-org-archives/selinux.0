Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id MAA10804
	for <selinux@tycho.nsa.gov>; Fri, 18 Jan 2002 12:19:34 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id RAA08247
	for <selinux@tycho.nsa.gov>; Fri, 18 Jan 2002 17:18:45 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id RAA08238 for <selinux@tycho.nsa.gov>; Fri, 18 Jan 2002 17:18:43 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Stephen Smalley <sds@tislabs.com>
Subject: Re: devfs_contexts
Date: Fri, 18 Jan 2002 18:19:20 +0100
Cc: <selinux@tycho.nsa.gov>
References: <Pine.GSO.4.33.0201181118440.3743-100000@raven>
In-Reply-To: <Pine.GSO.4.33.0201181118440.3743-100000@raven>
MIME-Version: 1.0
Message-Id: <20020118171920.F3E3C3918E4@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 18 Jan 2002 17:27, Stephen Smalley wrote:
> On Fri, 18 Jan 2002, Russell Coker wrote:
> > How exactly is devfs_contexts supposed to work, when is it applied?
>
> The devfs_contexts file is consulted for each devfs inode when that inode
> is first caught by a LSM hook.  So subsequent updates to devfs_contexts
> won't be propagated to existing inodes.  Try using chcon on existing
> nodes.

OK.  I've just used chsid as I can't find chcon.  Is chcon still in the 
source distribution?  If so where?

-- 
http://www.coker.com.au/bonnie++/     Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/       Postal SMTP/POP benchmark
http://www.coker.com.au/projects.html Projects I am working on
http://www.coker.com.au/~russell/     My home page

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
