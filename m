Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id NAA09016
	for <selinux@tycho.nsa.gov>; Mon, 19 Mar 2001 13:44:46 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id SAA28224
	for <selinux@tycho.nsa.gov>; Mon, 19 Mar 2001 18:44:39 GMT
Received: from biocserver.BIOC.CWRU.Edu (biocserver.BIOC.CWRU.Edu [129.22.208.36])
	by jazzswing.ncsc.mil  with ESMTP id SAA28220
	for <selinux@tycho.nsa.gov>; Mon, 19 Mar 2001 18:44:38 GMT
Date: Mon, 19 Mar 2001 13:51:14 -0500 (EST)
From: Jose Nazario <jose@biocserver.bioc.cwru.edu>
To: Howard Holm <hdholm@epoch.ncsc.mil>
cc: <kmrussel@hsc.vcu.edu>, <selinux@tycho.nsa.gov>
Subject: Re: SELinux compatible with XFS?
In-Reply-To: <200103191645.LAA08103@coalstove.epoch.ncsc.mil>
Message-ID: <Pine.LNX.4.30.0103191346050.24251-100000@biocserver.BIOC.CWRU.Edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 19 Mar 2001, Howard Holm wrote:

> While I'm not completely familiar with XFS, my understanding is that
> one of its advantages is that it stores extended attributes with the
> files.  So, it should, hopefully, be relatively easy to add a PSID to
> the extended file attributes.  That said, it isn't one of NSA's
> priorities to add that support.  If someone else wants it enough to do
> the work, we'd certainly like to see the results made available.

i'd like to chime in with some notes from the field and some links.

first up, we've just migrated *away* from XFS on some early 2.4 kernels on
out local LUG server, lockups and IO problems were just too great. that is
to say that this may have been fixed in recent releases of the 2.4 kernel
and the XFS source. i hope so, we would hover around 8 hours of uptime on
a busy server.

however, Linus is not happy to import large chunks of code into the
kernel, which will probably slow the adoption of XFS in Linux. also, they
recently officialy merged Reiser in, albeit you have to request
experimental code.

but, having been using XFS on IRIX for many, many years, i can say it's
one high performance filesystem. and yes, it does have extended attributes
on Linux, like MACLs and such. very nice, indeed. hence, with whatever
little weight i have here (i don't code stuff for you guys, for example),
i would like to vote for XFS in SELinux over other filesystems. i know
that SGI could use the help, and i know that the features of XFS would be
well utilized in SELinux.

some papers on XFS have appeared, and are available in large measure at:

	http://linux-xfs.sgi.com/projects/xfs/publications.html

later,

____________________________
jose nazario						     jose@cwru.edu
	      	     PGP: 89 B0 81 DA 5B FD 7E 00  99 C3 B2 CD 48 A0 07 80
				       PGP key ID 0xFD37F4E5 (pgp.mit.edu)


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
