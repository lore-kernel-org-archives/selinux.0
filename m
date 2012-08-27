Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q7REc6M1029681
	for <selinux@tycho.nsa.gov>; Mon, 27 Aug 2012 10:38:06 -0400
Date: Mon, 27 Aug 2012 16:37:58 +0200
From: Ole Kliemann <ole@plastictree.net>
To: selinux@tycho.nsa.gov
Subject: neverallow and attributes
Message-ID: <20120827143758.GC2168@telvanni>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="E39vaYmALEf/7YXx"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--E39vaYmALEf/7YXx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

If I do:

    attribute A;
   =20
    type T1_t;
    type T2_t;
   =20
    typeattribute T2_t A;
   =20
    allow A T1_t:file read;
   =20
    neverallow T2_t T1_t:file read;

I can compile and load the corresponding module. I can even do:

    allow A T1_t:file read;
   =20
    neverallow A T1_t:file read;

without problems.

I cannot do:

    allow T2_t T1_t:file read;
   =20
    neverallow A T1_t:file read;


The neverallow assertion does not find any allows that are=20
constituted by allowing something for an attribute.

Is this normal behaviour?

Ole

--E39vaYmALEf/7YXx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEARECAAYFAlA7hkUACgkQS1FjE303ERwnWACfXINQCCJA4QDneZoCteCMZZOp
UFMAnjOBaoJxl0xCSkkj4VWSLmRsbTsE
=qgh7
-----END PGP SIGNATURE-----

--E39vaYmALEf/7YXx--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
