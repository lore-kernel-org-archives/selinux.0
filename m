Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id QAA00060
	for <selinux@tycho.nsa.gov>; Fri, 16 Mar 2001 16:52:01 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id VAA07082
	for <selinux@tycho.nsa.gov>; Fri, 16 Mar 2001 21:51:59 GMT
Received: from og.latency.net (og.latency.net [209.123.200.27])
	by jazzband.ncsc.mil  with ESMTP id VAA07077
	for <selinux@tycho.nsa.gov>; Fri, 16 Mar 2001 21:51:58 GMT
Date: Fri, 16 Mar 2001 16:51:08 -0500
From: Bennett Todd <bet@rahul.net>
To: Pedro Rosa <Pedro.Rosa@ksu.ru>
Cc: Kurth Bemis <kurth@usaexpress.net>, selinux@tycho.nsa.gov
Subject: Re: Secure?
Message-ID: <20010316165108.A12384@rahul.net>
References: <4.3.2.7.2.20010315083635.02bb5068@mail.usaexpress.net> <3AB1F827.3010308@ksu.ru>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="BOKacYhQ+x31HxR3"
In-Reply-To: <3AB1F827.3010308@ksu.ru>; from Pedro.Rosa@ksu.ru on Fri, Mar 16, 2001 at 02:25:27PM +0300
Sender: owner-selinux@tycho.nsa.gov
List-ID: <selinux@tycho.nsa.gov>


--BOKacYhQ+x31HxR3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

2001-03-16-06:25:27 Pedro Rosa:
> [...] the presence of WuFTP is probably the most questionable
> program in selinux. Not only in technical terms but also it arises
> questions in the concept itself.

I don't see that at all.

The concept of selinux, as it stands today, is (I believe --- if
people think I'm wrong please straighten me out:-) to experiment
with a novel model of mandatory access control, on a system which is
exceedingly wide-spread and getting more so rapidly, one which
stands a chance, in the reasonable future, of being usable in many,
perhaps most settings.

Today it's an early research project, and the specific focus is
on experimenting with the policy definition mechanism, and trying
to evolve a comfortable to manage, flexible, suitably high-level
setup for expressing policy decisions, while letting people get
comfortable with the performance, the stability, and the way the
resulting system behaves. The reasonable decision is to try to
integrate it into the most widely-used distribution, and to confine
the focus of this project to just the MAC features, patching other
components only as necessary to make them work.

Meanwhile, in unrelated developments, it's fair to hope that the
popular distributions may get more secure as time goes by; certainly
they're showing some interest in that area. I believe RH7.1 may be
the best Red Hat to date.

I'm expecting it'll be a year or two before this selinux thing will
be in a state of maturity and stability to become part of a major
distribution outright. Perhaps by then Red Hat will be shipping a
better-founded ftpd. I've rpmmed a port of the OpenBSD ftpd, it's
not particularly tricky to do so.

-Bennett

--BOKacYhQ+x31HxR3
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE6sorMHZWg9mCTffwRArm6AJ4qL1eIolohxnZcMfbTQdWd8GP4dQCfTQEB
zb8sJ4VPeIcyF6dv5zjlQwE=
=K5vf
-----END PGP SIGNATURE-----

--BOKacYhQ+x31HxR3--

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
