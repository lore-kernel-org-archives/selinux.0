Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h578TXI4007870
	for <selinux@tycho.nsa.gov>; Sat, 7 Jun 2003 04:29:33 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h578TWtV007926
	for <selinux@tycho.nsa.gov>; Sat, 7 Jun 2003 08:29:32 GMT
Received: from a.mx.rapturesecurity.com ([66.113.84.53])
        by jazzband.ncsc.mil  with ESMTP id h578TVal007923 for <selinux@tycho.nsa.gov>; Sat, 7 Jun 2003 08:29:31 GMT
Subject: Re: A vulnerability in SELinux
From: Jack <jack@rapturesecurity.com>
Reply-To: jack@rapturesecurity.com
To: selinux@tycho.nsa.gov
In-Reply-To: <1054916729.1057.213.camel@moss-huskers.epoch.ncsc.mil>
References: <1054916729.1057.213.camel@moss-huskers.epoch.ncsc.mil>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-K2ic0tcr9cigglPGqoRf"
Message-Id: <1054974401.13760.29.camel@bubbles.eatflamingdeath.org>
Mime-Version: 1.0
Date: 07 Jun 2003 01:26:42 -0700
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-K2ic0tcr9cigglPGqoRf
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2003-06-06 at 09:25, Stephen Smalley wrote:

> ....Snip.....  A full integration of
> SELinux into a Linux distribution should include appropriate changes to
> ld.so to apply safeguards on domain transitioning executables (which can
> be detected by checking the previous context/old SID against the current
> context/SID), just as certain safeguards are currently applied to setuid
> execution.  SELinux is _not_ a Linux distribution, and has never claimed
> to be one.

=46rom the limited research Ive been able to put into this=20
Ive found that changing glibc/sysdeps/generic/enbl-secure.c
to

 __libc_enable_secure =3D (__geteuid () !=3D __getuid ()
                          || __getegid () !=3D __getgid ()
                          || getsecsid() !=3D getosecsid());

works to fix my boxes btw. Of couse this brings up more problems than
it solves, such as where to put all the code, and if this is really the
fix that I want. I would like to hear flames or feedback about this code
being here, as I am no glibc hacker. Luckily for me all the utilities
I'm using are already flaging __libc_enable_secure from setuid or
setgid via shadow or the Owl tcb pam stuff, that pertain to this
thread anyhow.

On a Side Note:
This might be a dumb question, but why would root have DAC override in a
shell? I certainly dont allow this in my _messy_ policy, am I missing
something?

--=20
Jack <jack@rapturesecurity.com>
RaptureSecurity

--=-K2ic0tcr9cigglPGqoRf
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA+4aHACNDQVeieV0YRAhLMAJ9oVDkyjt7jg57pp0gmHKGiUyQAbQCgsoYp
33dNoOwpcbLsaWkui9My0WY=
=Yu3C
-----END PGP SIGNATURE-----

--=-K2ic0tcr9cigglPGqoRf--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
