Received: from msux-gh1-uea01.nsa.gov (msux-gh1-uea01.nsa.gov [63.239.67.1])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n62FaMMH002938
	for <selinux@tycho.nsa.gov>; Thu, 2 Jul 2009 11:36:22 -0400
Received: from ey-out-2122.google.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id n62Fa5Ai012791
	for <selinux@tycho.nsa.gov>; Thu, 2 Jul 2009 15:36:05 GMT
Received: by ey-out-2122.google.com with SMTP id 9so442957eyd.39
        for <selinux@tycho.nsa.gov>; Thu, 02 Jul 2009 08:36:20 -0700 (PDT)
Subject: Re: request for review of, and collaboration on SELinux models
 wiki entry
From: Dominick Grift <domg472@gmail.com>
To: Joshua Kramer <josh@globalherald.net>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <alpine.LFD.2.00.0907021220590.25405@home-av-server.home-av>
References: <1246542053.26320.15.camel@notebook2.grift.internal>
	 <1246544997.13464.314.camel@moss-pluto.epoch.ncsc.mil>
	 <1246546486.26320.30.camel@notebook2.grift.internal>
	 <alpine.LFD.2.00.0907021220590.25405@home-av-server.home-av>
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-jAxurYIykfRcAn2QVZQO"
Date: Thu, 02 Jul 2009 17:36:19 +0200
Message-Id: <1246548979.26320.37.camel@notebook2.grift.internal>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-jAxurYIykfRcAn2QVZQO
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2009-07-02 at 12:26 -0400, Joshua Kramer wrote:
> >> - Security contexts are assigned to more than just processes and files=
.
> > You and i know that but for a common user i think just separation of
> > files and processes should suffice.
> > When all is said and done a Linux system is just a bunch of files
>=20
> Note that I'm putting together a similar tutorial on Userspace Object=20
> Managers [1].  There are applications - DBus, SE-PGSQL - that use SELinux=
=20
> contexts on arbitrary objects in the program itself, for example, databas=
e=20
> columns.  These objects are not necessarily files, but instead they are=20
> in-memory data structures.
>=20
> I'm going way out there and modelling the behavior of a dog pack - sled=20
> dogs actually - using SELinux contexts.  I'll forward to the group for=20
> review when it's done.
>=20
> Cheers,
> -JK

Understood. i will change it to read "objects". my reasoning behind the
use of the word files instead was so that it would easier for common
users to understand, Although strictly speaking it is
incomplete/incorrect.

I do not think common users are aware of in-memory data structures and
other low level technical details.

But again, i will edit it to reflect facts instead.

Thanks
> -----
> http://www.globalherald.net/jb01
> GlobalHerald.NET, the Smarter Social Network! (tm)

--=-jAxurYIykfRcAn2QVZQO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkpM0+0ACgkQMlxVo39jgT9G8QCePnHknJqON/zTX7JPu3C1eeSd
D9MAnigF4+S93LzG55JZ4Uvt/yjuPmjr
=e3Ui
-----END PGP SIGNATURE-----

--=-jAxurYIykfRcAn2QVZQO--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
