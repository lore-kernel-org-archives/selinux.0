Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h4OIKaI4001657
	for <selinux@tycho.nsa.gov>; Sat, 24 May 2003 14:20:36 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h4OIKZtV019508
	for <selinux@tycho.nsa.gov>; Sat, 24 May 2003 18:20:35 GMT
Received: from sat.sws.net.au ([202.5.161.49])
        by jazzband.ncsc.mil  with ESMTP id h4OIKWal019505 for <selinux@tycho.nsa.gov>; Sat, 24 May 2003 18:20:33 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Tom <tom@lemuria.org>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: some policy patches
Date: Sun, 25 May 2003 04:18:34 +1000
References: <20030524180730.C8251@lemuria.org>
In-Reply-To: <20030524180730.C8251@lemuria.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200305250418.34270.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 25 May 2003 02:07, Tom wrote:
> I have attached three diff files for policy changes. These are against
> Russell's default policy, though from the file comments at least one
> (xdm) is unchanged from the upstream tree.

+# XFree86-4 wants to check if kernel is tainted
+allow xdm_xserver_t sysctl_kernel_t:dir { search };
+allow xdm_xserver_t sysctl_kernel_t:file { getattr read };
+allow xdm_xserver_t sysctl_t:dir { search };

Strange, it doesn't seem to do that on my system.  Maybe it's some module that 
you are using.  In any case this is pretty harmless and should go in, but not 
to xserver.te.  Putting it in xserver.te breaks policy compilation for 
everyone who doesn't use xdm.

I've added it to xserver_macros.te in my tree.

> apm.diff contains minor updates so that acpid works (they are very
> similiar in requirements, and you don't usually have both running
> anyway, so a shared domain for apmd and acpid should be ok).

Done that.

> games.diff enables what I believe to be better games support. I have a

Firstly, don't use an apostrophy in words such as dont.  It causes problems 
with m4.

For the games patch to be merged it will have to use the macros so that it can 
work from user roles other than user_r.

I have put an updated policy.tgz on my web page containing the patches 
discussed here and some other changes.  A new Debian package will be 
available in a day or two.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
