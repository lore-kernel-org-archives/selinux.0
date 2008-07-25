Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m6P4Adhe016525
	for <selinux@tycho.nsa.gov>; Fri, 25 Jul 2008 00:10:39 -0400
Received: from QMTA05.emeryville.ca.mail.comcast.net (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m6P4AcGx002732
	for <selinux@tycho.nsa.gov>; Fri, 25 Jul 2008 04:10:39 GMT
Subject: Re: [PATCH] Communication between domains under labeled networks
From: Chris PeBenito <pebenito@gentoo.org>
To: KaiGai Kohei <kaigai@ak.jp.nec.com>
Cc: Paul Moore <paul.moore@hp.com>, selinux@tycho.nsa.gov,
        DGoeddel@TrustedCS.com, vyekkirala@TrustedCS.com
In-Reply-To: <4885BB42.4060603@ak.jp.nec.com>
References: <D709A20F2164C84E8B7014B0301F5EF87C72FA@HAVOC.tcs-sec.com>
	 <1203428116.13618.77.camel@gorn> <47BB7B6A.1090207@ak.jp.nec.com>
	 <200802192237.22546.paul.moore@hp.com>  <47BBB69C.2050007@ak.jp.nec.com>
	 <1203955972.32061.55.camel@gorn> <47C3738A.3010007@ak.jp.nec.com>
	 <4860BA1B.5030302@ak.jp.nec.com>  <4861DED0.9050407@ak.jp.nec.com>
	 <1216388484.21191.139.camel@gorn>  <4885BB42.4060603@ak.jp.nec.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-YqYshakdoDr0E+qHiK4J"
Date: Fri, 25 Jul 2008 00:10:17 -0400
Message-Id: <1216959017.5022.42.camel@defiant.pebenito.net>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-YqYshakdoDr0E+qHiK4J
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2008-07-22 at 19:49 +0900, KaiGai Kohei wrote:
> Christopher J. PeBenito wrote:
> > On Wed, 2008-06-25 at 14:59 +0900, KaiGai Kohei wrote:
> >> Hi,
> >>
> >> The attached patch allows user domains to communicate with daemon
> >> domain, and some other domains (Apache and CGI script) to communicate
> >> with RDBMS (PostgreSQL and MySQL) using xxxx_tcp_connect() interface.
> >>
> >> This approach enables to cover most of relationship needed.
> >> All we have to do is to describe the rest of relationship like
> >> ones between CGI script and RDBMS, daemons and name server,
> >> anything and samba server, ....
> >>
> >> At least, we cannot get labeled networks available unless adding
> >> policies to communicate between proper domains.
> >> I think it is necessary to make a decision to describe the policies.

> The attached patch is a revised version.
> Please review it again.
>=20
> And I also noticed that ipsec_match_default_spd() should be invoked with
> server's domain as postgresql_t doing.
> (e.g: communication between staff_t and sshd_t)
> I think it also should be allowed for whole of daemon attribute.
> What is your opinion? The version.3 patch also contains this fix.

I merged everything except for the default spd part.  I don't know if
its been suggested before, but I'm considering putting that match rule
into corenet_*_recvfrom_unlabeled().

--=20
Chris PeBenito
<pebenito@gentoo.org>
Developer,
Hardened Gentoo Linux
=20
Public Key: http://pgp.mit.edu:11371/pks/lookup?op=3Dget&search=3D0xE6AF924=
3
Key fingerprint =3D B0E6 877A 883F A57A 8E6A  CB00 BC8E E42D E6AF 9243

--=-YqYshakdoDr0E+qHiK4J
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkiJUikACgkQvI7kLeavkkMw8wCgrVnDCSo6FYAH7VNcVjS965kH
F5AAoJNuiBOEqYt4lCzEGTebmwiT/H5n
=Q6pJ
-----END PGP SIGNATURE-----

--=-YqYshakdoDr0E+qHiK4J--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
