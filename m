Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id IAA18452
	for <selinux@tycho.nsa.gov>; Tue, 29 Oct 2002 08:11:48 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id NAA12651
	for <selinux@tycho.nsa.gov>; Tue, 29 Oct 2002 13:09:55 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id NAA12645
	for <selinux@tycho.nsa.gov>; Tue, 29 Oct 2002 13:09:54 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Stephen Smalley <sds@tislabs.com>, Tom <tom@lemuria.org>
Subject: Re: patches to policy question
Date: Tue, 29 Oct 2002 14:11:35 +0100
Cc: <selinux@tycho.nsa.gov>
References: <Pine.GSO.4.33.0210290743010.29605-100000@raven>
In-Reply-To: <Pine.GSO.4.33.0210290743010.29605-100000@raven>
MIME-Version: 1.0
Message-Id: <200210291411.35967.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 29 Oct 2002 13:47, Stephen Smalley wrote:
> Yes, posting here is the right way to submit patches.  Russell does submit
> policy patches to us for merging, but we also consider other directly
> submitted policy patches.  A diff against the sourceforge selinux CVS tree
> is optimal for us, but may not always be reasonable for Debian selinux
> users if the Debian policy deviates too much.

You can be certain that I'll incorporate everything from the CVS into my tree 
at the time of the next release (if not before).

Also when patches are posted against the CVS I often merge them, but it 
sometimes depends on how interested I am in that area and whether it's 
something I think can wait for the next release.

Also there was one occasion that I refused a patch and advised the author to 
try Steve because I would never accept it otherwise.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
