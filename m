Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id NAA21003
	for <selinux@tycho.nsa.gov>; Wed, 20 Feb 2002 13:05:12 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id SAA11131
	for <selinux@tycho.nsa.gov>; Wed, 20 Feb 2002 18:04:15 GMT
Received: from entoo.connect.com.au (entoo.connect.com.au [192.189.54.8])
        by jazzband.ncsc.mil  with ESMTP id SAA11121 for <selinux@tycho.nsa.gov>; Wed, 20 Feb 2002 18:04:14 GMT
Date: Thu, 21 Feb 2002 05:03:49 +1100
From: Ben McGinnes <ben-mcginnes@iname.com>
To: Ivan Pulleyn <ivan@torpid.com>
Cc: selinux@tycho.nsa.gov, Lonnie Cumberland <lonnie@outstep.com>,
        Flood Randy Capt AFCA/TCAA <randy.flood@scott.af.mil>
Subject: Re: OT: Re: ftp long time connection
Message-ID: <20020221050349.C20971@mail.enternet.com.au>
References: <20020221013905.B20971@mail.enternet.com.au> <Pine.LNX.4.10.10202201124190.24117-100000@norway.torpid.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Clx92ZfkiYIKRjnr"
In-Reply-To: <Pine.LNX.4.10.10202201124190.24117-100000@norway.torpid.com>; from ivan@torpid.com on Wed, Feb 20, 2002 at 11:28:02AM -0600
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--Clx92ZfkiYIKRjnr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Ivan Pulleyn(ivan@torpid.com)@Wed, Feb 20, 2002 at 11:28:02AM -0600:
>=20
> Yes, it *can* be an explanation. Quite a few services (telnet, web,
> ftp, etc) look up the source address. So if you are on host 'foo' and
> you type 'ftp 192.168.1.1', there's no DNS query, but the server has
> to lookup 192.168.1.100 (the address of foo) to determine it's
> name. This is the lookup that is most likely causing the problem. If
> telnet hangs for 180 seconds, then prints 'login:', I bet a dollar
> it's reverse DNS.

Hrm, you are, of course, quite correct.  As a brief re-read of a couple of=
=20
RFCs are driving firmly back into my skull.

Though there are enough protocols these days which do not bother with
reverse DNS verification as much as many of the older protocols do.  That,=
=20
of course, has its own problems, but that's another topic altogether.  One=
=20
which is probably even further off-topic for this list than this one is=20
becoming.  ;)


Regards,
Ben

--Clx92ZfkiYIKRjnr
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: PGP 6.5.8

iQA/AwUBPHPlBDcaxb+gSuMTEQJLEgCdEv26MybiSuuwAq1G2mAh71UEOYsAoI21
UQS6pdgDwaFfdbAb5Uk9HIk+
=QIvx
-----END PGP SIGNATURE-----

--Clx92ZfkiYIKRjnr--

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
