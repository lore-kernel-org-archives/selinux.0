Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j5QGEFgA018604
	for <selinux@tycho.nsa.gov>; Sun, 26 Jun 2005 12:14:15 -0400 (EDT)
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j5QGDoFZ012769
	for <selinux@tycho.nsa.gov>; Sun, 26 Jun 2005 16:13:51 GMT
Received: from localhost (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id 943D761AFE
	for <selinux@tycho.nsa.gov>; Mon, 27 Jun 2005 02:13:51 +1000 (EST)
Received: from smtp.sws.net.au ([127.0.0.1])
	by localhost (smtp [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 06971-06 for <selinux@tycho.nsa.gov>;
	Mon, 27 Jun 2005 02:13:51 +1000 (EST)
Received: from aeon.coker.com.au (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id 41DB161AEA
	for <selinux@tycho.nsa.gov>; Mon, 27 Jun 2005 02:13:51 +1000 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: James Morris <jmorris@redhat.com>
Subject: Re: Alternative user management approach
Date: Mon, 27 Jun 2005 02:13:45 +1000
Cc: selinux@tycho.nsa.gov
References: <Xine.LNX.4.44.0506241549100.19660-100000@thoron.boston.redhat.com>
In-Reply-To: <Xine.LNX.4.44.0506241549100.19660-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200506270213.49958.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Saturday 25 June 2005 05:50, James Morris <jmorris@redhat.com> wrote:
> On Fri, 24 Jun 2005, Stephen Smalley wrote:
> > Yes, but SELinux doesn't isolate those shells even if they have
> > different SELinux user identities if they have the same role and domain.
> > In fact, you only get real isolation in SELinux between domains (or MLS
> > levels, if using MLS).
>
> But how would this change impact MLS, given that levels are associated
> with SELinux users?

Why would it have any impact on MLS?  The proposed change just changes the 
mapping from Unix UID/GID to SE Linux identity.  What role/level/category is 
assigned to the identity is a separate issue.  So I don't see MLS or the lack 
thereof making any impact on this decision.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
