Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hBLMk6Rb019536
	for <selinux@tycho.nsa.gov>; Sun, 21 Dec 2003 17:46:07 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id hBLMk5pn020133
	for <selinux@tycho.nsa.gov>; Sun, 21 Dec 2003 22:46:06 GMT
Received: from a141.shuttle.de (home.nightdaughter.de [194.95.224.141])
        by jazzband.ncsc.mil  with ESMTP id hBLMjsab020130 for <selinux@tycho.nsa.gov>; Sun, 21 Dec 2003 22:46:05 GMT
Received: from hydra.joerghoh.de (unknown [192.168.0.14])
	by a141.shuttle.de (Postfix) with SMTP id C03E4170021
	for <selinux@tycho.nsa.gov>; Mon, 22 Dec 2003 00:02:33 +0100 (CET)
Date: Sun, 21 Dec 2003 23:49:16 +0100
From: Joerg Hoh <joerg@devone.org>
To: selinux@tycho.nsa.gov
Subject: Re: Apache on FedoraCore1(Was Re: log_domain macro)
Message-ID: <20031221224916.GA3419@hydra.joerghoh.de>
References: <20031219195045.4425635f.ynakam@ori.hitachi-sk.co.jp> <2407.202.27.185.71.1072043647.squirrel@www.crypt.gen.nz>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IS0zKkzwUGydFO0o"
In-Reply-To: <2407.202.27.185.71.1072043647.squirrel@www.crypt.gen.nz>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--IS0zKkzwUGydFO0o
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 22, 2003 at 10:54:07AM +1300, Kerry Thompson wrote:
>=20
> PAM ( and others ) make calls to the kerberos library which will always
> open /etc/krb5.conf in r/w mode, even though no apps should be writing to
> it. I suggest allowing read from all, and dontaudit for write.

But the longterm solution would be to check why kerberos wants to have write
access to that file (and change it to read-only, if it isn't necessary at
all).

Joerg

--=20
Fachbegriffe der Informatik (Nr 293): Halteproblem
- Man zeigt, da=DF ein Problem im allgemeinen Fall nicht l=F6sbar ist, und
verweigert dann die L=F6sung der wichtigsten, praxisrelevanten F=E4lle.=20
	Florian Weimer

--IS0zKkzwUGydFO0o
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/5iNr6xdMID018FIRAvpDAJ9foLNKArRv9DgG6yT4mp+64x6fMgCdHoGe
kg9F0e/n9SzgevuCteGKsNU=
=5xWA
-----END PGP SIGNATURE-----

--IS0zKkzwUGydFO0o--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
