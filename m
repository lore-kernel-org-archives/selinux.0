Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hBM24HRb019981
	for <selinux@tycho.nsa.gov>; Sun, 21 Dec 2003 21:04:17 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id hBM23Pjx028108
	for <selinux@tycho.nsa.gov>; Mon, 22 Dec 2003 02:03:25 GMT
Received: from ns.sws.net.au ([61.95.69.3])
	by jazzswing.ncsc.mil  with ESMTP id hBM23NSR028077
	for <selinux@tycho.nsa.gov>; Mon, 22 Dec 2003 02:03:24 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Chris PeBenito <pebenito@gentoo.org>
Subject: Re: sshd subsystems
Date: Mon, 22 Dec 2003 13:02:49 +1100
Cc: SELinux Mail List <selinux@tycho.nsa.gov>
References: <1071982130.10602.6.camel@chris.pebenito.net> <200312212226.50352.russell@coker.com.au> <1072051372.13606.9.camel@chris.pebenito.net>
In-Reply-To: <1072051372.13606.9.camel@chris.pebenito.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200312221302.49764.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 22 Dec 2003 11:02, Chris PeBenito <pebenito@gentoo.org> wrote:
> > > I've been trying to decide what would be the best way to deal with sshd
> > > subsystems (sftp-server for example).  Right now they can't be used
> > > because of their label (transition to unpriv_userdomain domain is
> > > denied for one).  The simplest way to fix it would be to label the
> > > sftp-server binary as shell_exec_t.  I was also thinking about using a
> > > sshd_subsys_exec_t or something similar instead, and add the
> > > appropriate policy.  Any thoughts?
> >
> > The latter sounds like the correct option.  Please send me a patch when
> > you have working policy.
>
> Ok, this ended up not being as complex.  If you sftp in, it still at one
> point exec's the user's shell, so it transitions ok.  After the shell
> exec's, it seems to exec the subsystem executable.  So the executable
> just has to be an executable type.  So I added the couple lines to make

Why not just label the sftp executable as bin_t then?

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
