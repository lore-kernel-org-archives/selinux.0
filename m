Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id JAA19360
	for <selinux@tycho.nsa.gov>; Wed, 20 Feb 2002 09:51:19 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id OAA29721
	for <selinux@tycho.nsa.gov>; Wed, 20 Feb 2002 14:50:20 GMT
Received: from entoo.connect.com.au (entoo.connect.com.au [192.189.54.8])
        by jazzband.ncsc.mil  with ESMTP id OAA29717 for <selinux@tycho.nsa.gov>; Wed, 20 Feb 2002 14:50:18 GMT
Date: Thu, 21 Feb 2002 01:39:05 +1100
From: Ben McGinnes <ben-mcginnes@iname.com>
To: selinux@tycho.nsa.gov
Cc: Flood Randy Capt AFCA/TCAA <randy.flood@scott.af.mil>,
        Lonnie Cumberland <lonnie@outstep.com>
Subject: Re: ftp long time connection
Message-ID: <20020221013905.B20971@mail.enternet.com.au>
References: <1BF4DDD78DDA5D4EB0769BEA7F158E5A011BB229@amcw2ms812.amc.ds.af.mil>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qlTNgmc+xy1dBmNv"
In-Reply-To: <1BF4DDD78DDA5D4EB0769BEA7F158E5A011BB229@amcw2ms812.amc.ds.af.mil>; from randy.flood@scott.af.mil on Tue, Feb 19, 2002 at 01:55:17PM -0600
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--qlTNgmc+xy1dBmNv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Flood Randy Capt AFCA/TCAA(randy.flood@scott.af.mil)@Tue, Feb 19, 2002 at 0=
1:55:17PM -0600:
>=20
> Do you have reverse DNS entries for your server and client and is DNS
> configured correctly?
>=20
> If DNS is not set up properly you can get results like that.

True, DNS errors will do that, as others here have pointed out.  The
original query, however, also mentioned that accessing the host directly
by its IP was attempted with the same results.  So while there may be some=
=20
DNS-related delays as well, it cannot be a complete explanation.  I also=20
doubt SE Linux is the cause here either since it's a fairly generic kind=20
of problem.

I'd try attempting other protocols such as SSH, telnet (if enabled), SMTP=
=20
and probably SCP too.  To both hostname and IP address.  See if it is=20
affecting all protocols or just one or two, also try telnetting to the=20
machine on port 21 and see exactly what point at which it slows to a crawl=
=20
or breaks.

Chances are the cause (and shortly thereafter, the solution) will leap out=
=20
during this process.


Regards,
Ben

--qlTNgmc+xy1dBmNv
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: PGP 6.5.8

iQA/AwUBPHO1CDcaxb+gSuMTEQJUZACgllq0PTV2TnjGvwrxYCllU302xVAAmwQP
LJ++8fyAtr7ItIdEUZC8UB3O
=mn2A
-----END PGP SIGNATURE-----

--qlTNgmc+xy1dBmNv--

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
