Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id VAA23381
	for <selinux@tycho.nsa.gov>; Wed, 20 Feb 2002 21:51:28 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id CAA07276
	for <selinux@tycho.nsa.gov>; Thu, 21 Feb 2002 02:50:30 GMT
Received: from entoo.connect.com.au (entoo.connect.com.au [192.189.54.8])
        by jazzband.ncsc.mil  with ESMTP id CAA07272 for <selinux@tycho.nsa.gov>; Thu, 21 Feb 2002 02:50:28 GMT
Received: from devious.adversary.org (ppp181.mel.off.connect.com.au [192.94.41.181])
	by entoo.connect.com.au (Postfix) with ESMTP id 16F31E32EA
	for <selinux@tycho.nsa.gov>; Thu, 21 Feb 2002 13:45:02 +1100 (EST)
Received: (from khayman@localhost)
	by devious.adversary.org (8.11.6/8.10.2) id g1L2emP22653
	for selinux@tycho.nsa.gov; Thu, 21 Feb 2002 13:40:48 +1100
Date: Thu, 21 Feb 2002 13:40:48 +1100
From: Ben McGinnes <ben-mcginnes@iname.com>
To: selinux@tycho.nsa.gov
Subject: Re: ftp long time connection
Message-ID: <20020221134048.E20971@mail.enternet.com.au>
References: <1BF4DDD78DDA5D4EB0769BEA7F158E5A011BB22E@amcw2ms812.amc.ds.af.mil>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Qz2CZ664xQdCRdPu"
In-Reply-To: <1BF4DDD78DDA5D4EB0769BEA7F158E5A011BB22E@amcw2ms812.amc.ds.af.mil>; from randy.flood@scott.af.mil on Wed, Feb 20, 2002 at 08:55:50AM -0600
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--Qz2CZ664xQdCRdPu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Flood Randy Capt AFCA/TCAA(randy.flood@scott.af.mil)@Wed, Feb 20, 2002 at 0=
8:55:50AM -0600:
>=20
> Actually, even if you ftp or telnet to a machine using its ip address,
> often times the client will nslookup the ip address.  Likewise, the
> server will often do a reverse lookup on the client (for logging
> purposes).  I have also seen this sort of behavior if you use host names
> rather than ip addresses in /etc/hosts.allow and /etc/hosts.deny.  Try
> fixing DNS and then see if you still have the problem.

Yeah, as the other branch of this thread has probably shown, I'd forgotten=
=20
that while specifying the IP for the connecting host would speed up some=20
parts, it does not help much if the server has DNS troubles while=20
attempting to resolve reverse DNS on that host.  I had also forgotten that=
=20
some older protocols still insist on doing this step.

Some newer protocols, of course, skip this by ignoring reverse DNS=20
completely and simply respond to whatever IP address is in the appropriate=
=20
TCP/IP header from the incoming packet.  Initially I had assumed FTP would=
=20
do this, but a refresher of the protocol reminded me that its initial=20
connection is basically the same as telnet, which means it is going to=20
keep sticking to the good old fashioned reverse DNS double check. =20


Regards,
Ben

--Qz2CZ664xQdCRdPu
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: PGP 6.5.8

iQA/AwUBPHReLjcaxb+gSuMTEQJp8ACg/0tfygh8C5IgJPLq5VO3jkzpdYwAnjHw
PMtJpcYfX3xiO6Q6vhn2Llqs
=us7h
-----END PGP SIGNATURE-----

--Qz2CZ664xQdCRdPu--

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
