Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h5RExr0S014015
	for <selinux@tycho.nsa.gov>; Fri, 27 Jun 2003 10:59:53 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h5REx5ss001526
	for <selinux@tycho.nsa.gov>; Fri, 27 Jun 2003 14:59:05 GMT
Received: from sat.sws.net.au ([202.5.161.49])
	by jazzswing.ncsc.mil  with ESMTP id h5REx0hY001523
	for <selinux@tycho.nsa.gov>; Fri, 27 Jun 2003 14:59:03 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Colin Walters <walters@verbum.org>
Subject: Re: various policy fixes: suexec and user content, apache2 reload, mount and locales
Date: Sat, 28 Jun 2003 00:59:33 +1000
Cc: selinux@tycho.nsa.gov
References: <1056693151.11057.47.camel@columbia> <200306271814.21264.russell@coker.com.au> <1056725326.14921.2.camel@columbia>
In-Reply-To: <1056725326.14921.2.camel@columbia>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200306280059.33337.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 28 Jun 2003 00:48, Colin Walters wrote:
> > NB  It will probably be quite some time before my Apache policy gets
> > accepted by the NSA.  I've made a lot of changes, some of which make
> > upgrades difficult.  I think it's the right thing to do however, and it
> > seems that you are happy with the result too.
>
> Yeah, I like the policy a lot, it works quite well.  Hopefully the NSA
> maintainers can make a backwards-incompatible release at some point and
> merge your changes.

Just to clarify, the only significant change in my policy that will cause any 
problems with an upgrade is the Apache policy.  Apart from that you should be 
able to upgrade a running server from the NSA policy to my policy, and apart 
from needing to relabel some files it should be all fine.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
