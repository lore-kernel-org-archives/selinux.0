Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iBK1GPIi012245
	for <selinux@tycho.nsa.gov>; Sun, 19 Dec 2004 20:16:25 -0500 (EST)
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id iBK1GPKh005470
	for <selinux@tycho.nsa.gov>; Mon, 20 Dec 2004 01:16:26 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Casey Schaufler <casey@schaufler-ca.com>
Subject: Re: [patch] selinux_capget()
Date: Mon, 20 Dec 2004 12:16:19 +1100
Cc: James Morris <jmorris@redhat.com>, Darrel Goeddel <dgoeddel@TrustedCS.com>,
   "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
References: <20041214162207.5089.qmail@web50205.mail.yahoo.com>
In-Reply-To: <20041214162207.5089.qmail@web50205.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200412201216.23660.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wednesday 15 December 2004 03:22, Casey Schaufler <casey@schaufler-ca.com> 
wrote:
> > How does the application determine the real
> > effective set?
>
> The short answer is that it doesn't. How do you
> determine if you can really open a file for write
> access? The real world behavior is to check what
> you know about (e.g. UID, mode bits) and hope that
> you'll pass any additinoal constraints (e.g. ACLS,
> capabilities, mount options) that might apply. Then
> try it and check the error return.

Doesn't access(2) deal with ACLs and mount options?

> which is a generalized version of access(2), that
> notoriously unuseful syscall. Needless to say, such
> an inferface is impracticle and would still yield
> false positives.

A faccess(2) syscall would be handy if you are contributing to further POSIX 
standards...

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
