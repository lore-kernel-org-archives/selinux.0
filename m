Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h4KJZSI4012000
	for <selinux@tycho.nsa.gov>; Tue, 20 May 2003 15:35:28 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h4KJZ5Qj028900
	for <selinux@tycho.nsa.gov>; Tue, 20 May 2003 19:35:05 GMT
Received: from a.mx.rapturesecurity.com ([66.113.84.53])
	by jazzswing.ncsc.mil  with ESMTP id h4KJZ4xS028880
	for <selinux@tycho.nsa.gov>; Tue, 20 May 2003 19:35:04 GMT
Subject: Re: matrix
From: Jack <jack@rapturesecurity.com>
Reply-To: jack@rapturesecurity.com
To: selinux@tycho.nsa.gov
In-Reply-To: <200305210013.14976.russell@coker.com.au>
References: <C540EABA36FDD41189FD00508BAF8E850149266A@atsgroup.saic.com>
	 <200305201437.24228.russell@coker.com.au>
	 <200305201505.25398.tk-selinux@datas-world.de>
	 <200305210013.14976.russell@coker.com.au>
Content-Type: text/plain
Message-Id: <1053459308.21482.23.camel@bubbles.eatflamingdeath.org>
Mime-Version: 1.0
Date: 20 May 2003 12:35:09 -0700
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2003-05-20 at 07:13, Russell Coker wrote:

...
> >
> > I think this can be reduced. Stack smash protection and pax are already
> > there, they only have to be used by the distributions. Then there is
> 
> Has anyone got PaX working with LSM?
> 
> Propolice would be good to have.

I have an selinux server up with ProPolice daemons and PaX. There is
only 1 reject if you patch last time I checked, but then again I haven't
looked to see how safe the code is (with both aplied).

...
> Good point about inetd.  If sshd is started by inetd and denied ptrace access 
> to itself then a cracked sshd can't interfere with another ssh session.  I 
> will have to look into changing my servers to do this.  Of course this raises 
> another problem, the unreliability of inetd's.  But if inetd is cracked it 
> doesn't allow much of an attack on the ssh protocol as long as the clients 
> already have a copy of the server public key.

I was accually using something similar, but with djb tcpserver and the
daemonutils package, but my idea was just to allow ssh connections
though ipsec? with roaming users, and firewall eth?, that seems to
control exposure very well with crls and X.509 FreeS/WAN patches.
IPSEC also seems to fix almost all tcp/ip problems as well ;)

-- 
Jack <jack@rapturesecurity.com>
RaptureSecurity


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
