Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id JAA12269
	for <selinux@tycho.nsa.gov>; Thu, 11 Jan 2001 09:38:13 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil (8.9.1/8.9.1) with ESMTP id OAA24004
	for <selinux@tycho.nsa.gov>; Thu, 11 Jan 2001 14:37:37 GMT
Received: from og.latency.net (og.latency.net [209.123.200.27])
	by jazzband.ncsc.mil (8.9.1/8.9.1) with ESMTP id OAA24000
	for <selinux@tycho.nsa.gov>; Thu, 11 Jan 2001 14:37:36 GMT
Date: Thu, 11 Jan 2001 09:38:18 -0500
From: Bennett Todd <bet@rahul.net>
To: =?iso-8859-1?Q?Magos=E1nyi_=C1rp=E1d?= <mag@bunuel.tii.matav.hu>
Cc: Andi Kleen <ak@suse.de>, selinux@tycho.nsa.gov
Subject: Re: [selinux] Re: SELinux and covert channels
Message-ID: <20010111093818.X21255@rahul.net>
References: <A0669F3E0A6B3448A962DC6141E6C7A614415C@mis1> <20010110192931.A3665@gruyere.muc.suse.de> <20010111005355.A20214@bunuel.tii.matav.hu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="4nn+A2p41ba1mxGd"
In-Reply-To: <20010111005355.A20214@bunuel.tii.matav.hu>; from mag@bunuel.tii.matav.hu on Thu, Jan 11, 2001 at 12:53:55AM +0100
Sender: owner-selinux@tycho.nsa.gov
List-ID: <selinux@tycho.nsa.gov>


--4nn+A2p41ba1mxGd
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

2001-01-10-18:53:55 Magos=E1nyi =C1rp=E1d:
> > Linux is full of covert channels between processes and I doubt
> > selinux helps for most of them.
>=20
> When a process
> -cannot see the existence of an other process (policy enforced on /proc)
> -cannot ipc with another process (policy enforced on sysv ipc mechanisms =
and sockets)
> -cannot use the same files as the other (policy enforced on files)
> and cannot send signals to another process (policy enforced on kill)
> how do the two processes create a covert channel?

You're talking about pretty overt channels, OS objects with clear
security policies associated with them.

Linux makes no attempt to manage its resources in a fashion that
would prevent covert channels.

As a trivial example, illustrative of the class of problem, one
process can very, very easily modulate Linux's load average;
and even if the load avg itself is not made available to other
processes, it's very very easily indirectly observed: to a far
worse degree than any other Unix-like OS I've ever used, Linux's
context-switching performance takes a dive as the load average goes
up. So the sender could modulate the load avg by spawning and
killing cpu-bound children; and the receiver could keep a couple of
children around, sending one byte at a time down a pipe between
them, with a second pipe for an ACK channel, forcing synchronous
chatter between the two and so forcing constant context switches; if
they then noted the bytes/sec they'd easily see a waveform whose
shape was determined by the sender.

As I said, that's an illustration (possibly the classic example on
normal systems, but by no means the only one).

If you really want to block all covert channels, you end up
designing an OS on the same basis that cryppies design protocols
to thwart traffic analysis: you pad all resource utilization to
constant values with dummy load-inflictors, while imposing soft
limits that are hard to accurately discern. And even this is
very hard to get right: you end up having to define ceilings on
permitted utilization, and then you have to prevent the sender from
communicating covertly with the receiver by intermittently pushing
the system against those limits.

Lessee, besides load average, other bounded and so exhaustable, as
well as modulatable, resources would include pids, network ports,
and disk space.

Today, I'd say most software engineers familiar with the problem
consider the gyrations required to close all covert channels to be
too painful, and so design systems where preventing covert channels
is not a security requirement.

-Bennett

--4nn+A2p41ba1mxGd
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE6XcVaHZWg9mCTffwRAqDZAJ0eaS+Aqhr13IQcisN7GxgTWnxdzACfXluv
hguNAqASaIcYGF/qE6JBFnM=
=uzgR
-----END PGP SIGNATURE-----

--4nn+A2p41ba1mxGd--

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
