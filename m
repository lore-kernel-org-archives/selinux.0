Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i6PGR7rT020473
	for <selinux@tycho.nsa.gov>; Sun, 25 Jul 2004 12:27:07 -0400 (EDT)
Received: from home.nightdaughter.de (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i6PGQxYd005151
	for <selinux@tycho.nsa.gov>; Sun, 25 Jul 2004 16:27:06 GMT
Received: from hydra.joerghoh.de (hydra.joerghoh.de [192.168.0.14])
	by home.nightdaughter.de (Postfix) with SMTP id 5702217003A
	for <selinux@tycho.nsa.gov>; Sun, 25 Jul 2004 18:26:53 +0200 (CEST)
From: "Joerg Hoh" <joerg@devone.org>
Date: Sun, 25 Jul 2004 18:26:53 +0200
To: SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: Selinux possible on Debian-Linux/ppc?
Message-ID: <20040725162653.GC8638@hydra.joerghoh.de>
References: <1090769556.7265.32.camel@debby>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qcHopEYAB45HaUaB"
In-Reply-To: <1090769556.7265.32.camel@debby>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--qcHopEYAB45HaUaB
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 25, 2004 at 05:32:36PM +0200, Wolfgang Pfeiffer wrote:
>=20
> I'm planning to get a SE Kernel 2.6 compiled here.
>=20
> But I'm not quite sure whether SElinux will run on that machine, and on
> Debian-ppc ...

I think SELinux runs well on your machine, most little/big-endian flaws
should have been found ...

> On=20
> <http://www.nsa.gov/selinux/>:
> I read:
> "Currently, we can only support the x86 architecture .."

This is a historic statement :-) SELinux ran fine on my alpha 6 months
ago.

Joerg

--=20
Fachbegriffe der Informatik (Nr 289): Chef
- Jemand, der ohne Plan von der Sache unsinnige Anweisungen gibt, die Erfol=
ge
f=FCr sich reklamiert und die Katastrophen an =BBdie Techniker=AB weitergib=
t.=20
	Alexander Schreiber

--qcHopEYAB45HaUaB
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFBA99N6xdMID018FIRAsjvAJ4ltLxkrn+CM8cfcpfTrv+KEUEVwQCfco9Z
pbPoafO4W/EjnqtgK1WE5TU=
=J557
-----END PGP SIGNATURE-----

--qcHopEYAB45HaUaB--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
