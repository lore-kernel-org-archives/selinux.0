Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id IAA03882
	for <selinux@tycho.nsa.gov>; Thu, 17 Jan 2002 08:16:17 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id NAA00683
	for <selinux@tycho.nsa.gov>; Thu, 17 Jan 2002 13:15:43 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id NAA00679
	for <selinux@tycho.nsa.gov>; Thu, 17 Jan 2002 13:15:40 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Stephen Smalley <sds@tislabs.com>
Subject: Re: 2.4.17 support?
Date: Thu, 17 Jan 2002 14:15:57 +0100
Cc: <selinux@tycho.nsa.gov>
References: <Pine.GSO.4.33.0201170754570.18610-100000@raven>
In-Reply-To: <Pine.GSO.4.33.0201170754570.18610-100000@raven>
MIME-Version: 1.0
Message-Id: <20020117131558.3BD3A32FDE6@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 17 Jan 2002 13:59, Stephen Smalley wrote:
> On Wed, 16 Jan 2002, Russell Coker wrote:
> > The latest kernel patch for 2.4.17 from immunix uses version 8 of the
> > Policy DB, while the latest utilities on the NSA site are clearly
> > designed for version 7 only (compile errors when trying to compile with
> > version 8 headers).
>
> The NSA SELinux web site states that you should use the version of the LSM
> kernel patch that is on it, since the one from lsm.immunix.org may not
> always be compatible.  The policydb change was pushed to the
> lsm.immunix.org tree (with a comment in the ChangeLog about the need for a
> corresponding patch to the checkpolicy program) in preparation for a new
> SELinux release on the NSA web site.  So just be patient and wait for the
> new release.

OK.

BTW  Could documentation be added as to which kernel supports which version 
of the policydb?

-- 
http://www.coker.com.au/bonnie++/     Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/       Postal SMTP/POP benchmark
http://www.coker.com.au/projects.html Projects I am working on
http://www.coker.com.au/~russell/     My home page

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
