Subject: New regression test suite for hardened environments & Hardened
	Debian proposals
From: Lorenzo Hernandez Garcia-Hierro <lorenzo@gnu.org>
Reply-To: lorenzo@gnu.org
To: SELinux@tycho.nsa.gov
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-r/VxAfwqzS14W+bgGipX"
Date: Mon, 29 Nov 2004 21:07:08 +0100
Message-Id: <1101758828.21523.20.camel@localhost>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-r/VxAfwqzS14W+bgGipX
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Hi,

This is my first message on the list, so, let me do a brief presentation
of myself.

I'm a guy from Spain that launched a few months ago the Hardened Debian
project, i have limited knowledge on these things , and sure many of you
know many more than me, so, i think my approaches wouldn't be really
important, and i just come out to see, learn and hear from you, sharing
what i've already known and learning for the things i don't.

I want to announce that i've started a new regression tests suite, based
on paxtest, but adding more features to make it much more useful.

Original paxtest (by Peter Busser) is a regression tests suite for the
PaX kernel security enhancements (mainly the NOEXEC implementations and
also the ASLR stuff).

My one, still under development and not ready at all, supplies many more
features than paxtest, including but not limited to:

. FIPS 1402 compliance test for random numbers generation devices
(RNG,PRNG,TRNG,CSRNG...)
=B7 Stack Smashing Protector / ProPolice detection & alocation routines.
	(i'm working on them, they are already implemented on Hardened Debian's
gcc wrapper)
=B7 PIE support detection.
=B7 Planning SELinux support...

I want to know if somebody is interested in contributing with this, i
need help to learn how to integrate some SELinux capabilities in it, and
also help in developing it as i don't get a lot of time with school,
"work", projects, etc.

I would comment also that i was talking with some people from the
Adamantix and Hardened Gentoo projects about an initiative i had in mind
for many time since i'm leading on Hardened Debian.

I was thinking in the possibility of setting up, managing and supporting
a SF.net-like (free projects hosting for those who are under open
source/free software licenses) site for software-security related
projects, promoting the collaboration between the developers of each
project and also the development of standards to assure that projects
could share their work with time wasting, and also assuring the
interoperability between them and their work.

For example i use the SSP/ProPolice case.Many projects have their own
implementation of it: inside Glibc, inside libgcc...and there's the
possibility of using another implementation that has no crappy
restrictions like libgcc's one or Glibc's one, the libssp, implementing
SSP as a library that could be used with GCC and SPECS files to compile
SSP-ready binaries without the problems gathered by the others:
backwards incompatibility, incompatibility between different project
packages (for ex. between Adamantix and Hardened Debian , but this is
not proved yet).That would mean a "standarized solution" and it's what
i'm looking for.

Thanks in advance for your attention reading this boring bunch of text
and cheers ;-)

--=20
Lorenzo Hern=E1ndez Garc=EDa-Hierro [1024D/6F2B2DEC]
Hardened Debian head developer & project manager.
http://www.debian-hardened.org | http://lorenzo.debian-hardened.org

--=-r/VxAfwqzS14W+bgGipX
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Esta parte del mensaje =?ISO-8859-1?Q?est=E1?= firmada
	digitalmente

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBBq4FrDcEopW8rLewRAuCjAKC3tL0sfccL8pm/b7XoxPfB2XVL8wCg2Agg
oiLpaQztiyOQnMYpCVKbhiQ=
=I5GF
-----END PGP SIGNATURE-----

--=-r/VxAfwqzS14W+bgGipX--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
