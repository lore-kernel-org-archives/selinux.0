Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id OAA00663
	for <selinux@tycho.nsa.gov>; Mon, 15 Jan 2001 14:18:44 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil (8.9.1/8.9.1) with ESMTP id TAA25672
	for <selinux@tycho.nsa.gov>; Mon, 15 Jan 2001 19:18:06 GMT
Received: from og.latency.net (og.latency.net [209.123.200.27])
	by jazzband.ncsc.mil (8.9.1/8.9.1) with ESMTP id TAA25668
	for <selinux@tycho.nsa.gov>; Mon, 15 Jan 2001 19:18:06 GMT
Date: Mon, 15 Jan 2001 14:19:03 -0500
From: Bennett Todd <bet@rahul.net>
To: Johnathon Day <jcday@mail.thesportsregister.com>
Cc: Jan Petranek <jan@petranek.de>, selinux@tycho.nsa.gov
Subject: Re: Goal / Danger: Attack by malicious root
Message-ID: <20010115141903.S8565@rahul.net>
References: <01011516091701.13938@linux16> <Pine.LNX.4.21.0101151209240.18288-100000@mail.thesportsregister.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="mvzZjokS1nTZS3h1"
In-Reply-To: <Pine.LNX.4.21.0101151209240.18288-100000@mail.thesportsregister.com>; from jcday@mail.thesportsregister.com on Mon, Jan 15, 2001 at 12:53:07PM -0500
Sender: owner-selinux@tycho.nsa.gov
List-ID: <selinux@tycho.nsa.gov>


--mvzZjokS1nTZS3h1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

2001-01-15-12:53:07 Johnathon Day:
>    If someone on the SELinux team sees any mistakes in what I'm saying,
> feel free to correct me.

I'm not on the selinux team, but I see an assumption you're making
that needs to be hauled out and examined clearly.

You're assuming that control mechanisms wired into selinux can be
effective. This is true only as long as the selinux installation
itself isn't modified or replaced by something else.

The original poster seemed to be describing a setting where the
physical hardware on which the OS was running was left exposed in a
public lab. If that were the case, then no OS protections could
solve the resulting security problem; before OS design can be of any
help, the hardware itself must be physically secured enough to
prevent the attacker from simply replacing it.

That's why replies emphasized tricks like rigging a bootable CD to
carry with you.

>    SELinux, as I understand it, uses mandatory access controls. To me,
> this implies that NO user, including the superuser, has automatic right
> of access, except in those specific cases where access is explicitly=20
> granted. ie: the default is to deny access.

That's all fine --- as long as selinux is running, and the OS itself
hasn't been compromised. With physically unprotected hardware, that
cannot be guaranteed.

-Bennett

--mvzZjokS1nTZS3h1
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE6Y00mHZWg9mCTffwRAk8xAJ0dZqhYgDNS1UOCHgcR5l5xRRVExACg0prs
3mTHhJeoX0fndKygLUgoyQc=
=xzzs
-----END PGP SIGNATURE-----

--mvzZjokS1nTZS3h1--

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
