Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h4LNnfI4018920
	for <selinux@tycho.nsa.gov>; Wed, 21 May 2003 19:49:41 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h4LNnHuO011930
	for <selinux@tycho.nsa.gov>; Wed, 21 May 2003 23:49:17 GMT
Received: from a.mx.rapturesecurity.com ([66.113.84.53])
	by jazzswing.ncsc.mil  with ESMTP id h4LNnGlV011926
	for <selinux@tycho.nsa.gov>; Wed, 21 May 2003 23:49:16 GMT
Subject: Re: matrix [NOW FreeS/WAN vs sshd]
From: Jack <jack@rapturesecurity.com>
Reply-To: jack@rapturesecurity.com
To: selinux@tycho.nsa.gov
In-Reply-To: <200305211505.10089.tk-selinux@datas-world.de>
References: <C540EABA36FDD41189FD00508BAF8E850149266A@atsgroup.saic.com>
	 <200305210013.14976.russell@coker.com.au>
	 <1053459308.21482.23.camel@bubbles.eatflamingdeath.org>
	 <200305211505.10089.tk-selinux@datas-world.de>
Content-Type: text/plain
Message-Id: <1053560950.23132.69.camel@bubbles.eatflamingdeath.org>
Mime-Version: 1.0
Date: 21 May 2003 16:49:11 -0700
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2003-05-21 at 06:05, Torsten Knodt wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> > > Good point about inetd.  If sshd is started by inetd and denied ptrace
> > > access to itself then a cracked sshd can't interfere with another ssh
> > > session.  I will have to look into changing my servers to do this.  Of
> > > course this raises another problem, the unreliability of inetd's.  But if
> > > inetd is cracked it doesn't allow much of an attack on the ssh protocol
> > > as long as the clients already have a copy of the server public key.
> > I was accually using something similar, but with djb tcpserver and the
> > daemonutils package, but my idea was just to allow ssh connections
> > though ipsec? with roaming users, and firewall eth?, that seems to
> > control exposure very well with crls and X.509 FreeS/WAN patches.
> With ipsec, you move the encryption bugs and friends problem of the daemons 
> into the kernel. Without comparing openssh and freeswan code quality, I think 
> this is more insecure. You have to crack one service (freeswan) and get 
> access to the whole system (via kernel). When I'm not wrong, SE Linux doesn't 
> protect the kernel. Or am I wrong with the

FreeS/WAN is userland AND kernel first off, and if you read the policy
unused/ipsec.te and compare it to sshd.te in the policy directory you
might get an idea of why I would rather expose ipsec.te before sshd.te.
If you want to talk about this further you can just email me directly,
as this is a long opinionated discussion. However you have given me
the idea to edit the ipsec scripts to interact with iptables and only
allow esp from someone who has passed IKE, as there is no reason
to allow esp from everyone, not that it should matter.

> 
> > IPSEC also seems to fix almost all tcp/ip problems as well ;)
> This part sounds very get. Only bad, than I can't reach my providers proxy 
> with ipsec. ;(

The idea is to negotiate an IPSEC tunnel between 2 hosts to allow ssh
traffic inside of that tunnel, if you can communicate directly with a
host, then you should be able to do this.

-- 
Jack <jack@rapturesecurity.com>
RaptureSecurity


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
