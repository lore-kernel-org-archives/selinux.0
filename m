Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h5REoP0S013966
	for <selinux@tycho.nsa.gov>; Fri, 27 Jun 2003 10:50:25 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h5REnZss000998
	for <selinux@tycho.nsa.gov>; Fri, 27 Jun 2003 14:49:36 GMT
Received: from monk.verbum.org (monk.debian.net [216.226.142.128])
	by jazzswing.ncsc.mil  with ESMTP id h5REnUhY000970
	for <selinux@tycho.nsa.gov>; Fri, 27 Jun 2003 14:49:34 GMT
Subject: Re: various policy fixes: suexec and user content, apache2 reload,
	mount and locales
From: Colin Walters <walters@verbum.org>
To: Russell Coker <russell@coker.com.au>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <200306271814.21264.russell@coker.com.au>
References: <1056693151.11057.47.camel@columbia>
	 <200306271814.21264.russell@coker.com.au>
Content-Type: text/plain
Message-Id: <1056725326.14921.2.camel@columbia>
Mime-Version: 1.0
Date: 27 Jun 2003 10:48:46 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2003-06-27 at 04:14, Russell Coker wrote:

> I think it's best to permit those.  If an administrator wants to see mount 
> messages in a foreign language then we should support it.  So I have put in 
> allow rules in the macro file.

Ok, that's fine too, but as I said it doesn't seem mount has any
translations right now so it doesn't matter.

> NB  It will probably be quite some time before my Apache policy gets accepted 
> by the NSA.  I've made a lot of changes, some of which make upgrades 
> difficult.  I think it's the right thing to do however, and it seems that you 
> are happy with the result too.

Yeah, I like the policy a lot, it works quite well.  Hopefully the NSA
maintainers can make a backwards-incompatible release at some point and
merge your changes.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
