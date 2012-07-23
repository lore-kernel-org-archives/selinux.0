Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q6NCogoA008592
	for <selinux@tycho.nsa.gov>; Mon, 23 Jul 2012 08:50:42 -0400
Date: Mon, 23 Jul 2012 14:49:11 +0200
From: Ole Kliemann <ole@plastictree.net>
To: selinux@tycho.nsa.gov
Subject: Writing policy: default_contexts etc.
Message-ID: <20120723124911.GA6980@telvanni>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mP3DRpeJDSE+ciuQ"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--mP3DRpeJDSE+ciuQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm in the process of writing a simple policy from scratch. =20
Everything works as expected, except for logins.

I have a user named tfm on my system.
/etc/selinux/mypolicy/seusers looks like:
   =20
    tfm:tfm_u
    root:system_u

In my policy I have a user tfm_u with roles tfm_r. tfm_r has=20
several types, for example xserver_tfm_t. I also have a user=20
system_u with role unconfined_r and type unconfined_t.

Using runcon I can transition from=20
system_u:unconfined_r:unconfined_t to tfm_u:tfm_r:xserver_tfm_t.=20

I figured I have to tell the login programs which context to=20
choose per default. My login programs run as=20
system_u:unconfined_r:unconfined_t, so I added to=20
/etc/selinux/mypolicy/contexts/default_contexts the line

    unconfined_r:unconfined_t   tfm_r:xserver_tfm_t

I also have in /etc/selinux/mypolicy/contexts/default_type

    unconfined_r:unconfined_t
    tfm_r:xserver_tfm_t

I can login as root and have context=20
system_u:unconfined_r:unconfined_t.

I cannot login as tfm, because:

pam_selinux(login:session): Unable to get valid context for tfm


Apparently I am missing something, just can't find what.

In general I find it difficult to find comprehensive=20
documentation about the userland tools' interaction with the=20
policy conifguration. On top of that error messages are often=20
uninformative. (Random example: when the file=20
/etc/selinux/mypolicy/contexts/files/file_contexts is missing,=20
useradd without any output exits with return code 12. Which says=20
'cannot create homedir' but contains no clue about the reason for=20
the failure.)

So any hint on the above problem or hints on good places I could=20
read up on the topic would be highly appreciated!

--mP3DRpeJDSE+ciuQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEARECAAYFAlANSEcACgkQS1FjE303ERznXgCaAnTIF3+OXEq0kYn4yylbrVTU
z1wAnR2O6zxKjD41jKRK7TGeespxkv0S
=dNIY
-----END PGP SIGNATURE-----

--mP3DRpeJDSE+ciuQ--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
