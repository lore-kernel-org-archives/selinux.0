Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h4LD5SI4015220
	for <selinux@tycho.nsa.gov>; Wed, 21 May 2003 09:05:28 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h4LD5RtV002672
	for <selinux@tycho.nsa.gov>; Wed, 21 May 2003 13:05:28 GMT
Received: from datas-world.dyndns.org (dsl-213-023-212-232.arcor-ip.net [213.23.212.232])
        by jazzband.ncsc.mil  with ESMTP id h4LD5Qal002655 for <selinux@tycho.nsa.gov>; Wed, 21 May 2003 13:05:27 GMT
From: Torsten Knodt <tk-selinux@datas-world.de>
To: selinux@tycho.nsa.gov
Subject: Re: matrix
Date: Wed, 21 May 2003 15:05:03 +0200
References: <C540EABA36FDD41189FD00508BAF8E850149266A@atsgroup.saic.com> <200305210013.14976.russell@coker.com.au> <1053459308.21482.23.camel@bubbles.eatflamingdeath.org>
In-Reply-To: <1053459308.21482.23.camel@bubbles.eatflamingdeath.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <200305211505.10089.tk-selinux@datas-world.de>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

> > Good point about inetd.  If sshd is started by inetd and denied ptrace
> > access to itself then a cracked sshd can't interfere with another ssh
> > session.  I will have to look into changing my servers to do this.  Of
> > course this raises another problem, the unreliability of inetd's.  But if
> > inetd is cracked it doesn't allow much of an attack on the ssh protocol
> > as long as the clients already have a copy of the server public key.
> I was accually using something similar, but with djb tcpserver and the
> daemonutils package, but my idea was just to allow ssh connections
> though ipsec? with roaming users, and firewall eth?, that seems to
> control exposure very well with crls and X.509 FreeS/WAN patches.
With ipsec, you move the encryption bugs and friends problem of the daemons 
into the kernel. Without comparing openssh and freeswan code quality, I think 
this is more insecure. You have to crack one service (freeswan) and get 
access to the whole system (via kernel). When I'm not wrong, SE Linux doesn't 
protect the kernel. Or am I wrong with the last?

> IPSEC also seems to fix almost all tcp/ip problems as well ;)
This part sounds very get. Only bad, than I can't reach my providers proxy 
with ipsec. ;(

- -- 
Domain in provider transition, hope for smoothness. Planed date is 24.7.2003
pub 1024D/4CD29A2C 2001-01-12 Torsten Knodt <torstenknodt@datas-world.de>
 Schl.-Fingerabdruck = A2B1 C626 F819 7C58 B2F9 4F4C BF16 64B6 4CD2 9A2C
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE+y3mFvxZktkzSmiwRAh3tAJ9aUrY7yYjfunol/L5N6GiNfHc35wCfcL+p
DVsiofP7rQLFy4GZKuA6qr4=
=JB/1
-----END PGP SIGNATURE-----



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
