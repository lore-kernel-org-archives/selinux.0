Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hBLBSbRb018433
	for <selinux@tycho.nsa.gov>; Sun, 21 Dec 2003 06:28:37 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id hBLBRjjx000641
	for <selinux@tycho.nsa.gov>; Sun, 21 Dec 2003 11:27:46 GMT
Received: from ns.sws.net.au ([61.95.69.3])
	by jazzswing.ncsc.mil  with ESMTP id hBLBRRSR000611
	for <selinux@tycho.nsa.gov>; Sun, 21 Dec 2003 11:27:45 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Chris PeBenito <pebenito@gentoo.org>,
   SELinux Mail List <selinux@tycho.nsa.gov>
Subject: Re: sshd subsystems
Date: Sun, 21 Dec 2003 22:26:50 +1100
References: <1071982130.10602.6.camel@chris.pebenito.net>
In-Reply-To: <1071982130.10602.6.camel@chris.pebenito.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200312212226.50352.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 21 Dec 2003 15:48, Chris PeBenito <pebenito@gentoo.org> wrote:
> I've been trying to decide what would be the best way to deal with sshd
> subsystems (sftp-server for example).  Right now they can't be used
> because of their label (transition to unpriv_userdomain domain is denied
> for one).  The simplest way to fix it would be to label the sftp-server
> binary as shell_exec_t.  I was also thinking about using a
> sshd_subsys_exec_t or something similar instead, and add the appropriate
> policy.  Any thoughts?

The latter sounds like the correct option.  Please send me a patch when you 
have working policy.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
