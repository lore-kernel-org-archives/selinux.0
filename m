Subject: Re: network and module problems
From: Timothy Wood <timothy@hallcomp.com>
To: Paul Krumviede <pwk@acm.org>
Cc: SELinux <SELinux@tycho.nsa.gov>, Stephen Smalley <sds@tislabs.com>
In-Reply-To: <78301711.1011942185@localhost>
References: <1011969383.1945.1.camel@phobos>
	<78301711.1011942185@localhost>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-eBV5rDKlxg6ZCaOZOBf1"
Date: 25 Jan 2002 13:49:15 -0500
Message-Id: <1011984582.1946.6.camel@phobos>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-eBV5rDKlxg6ZCaOZOBf1
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

This is just a real quick post before I have to run out of the office.=20
I switched to enforcing mode and tried bringing up the interface and
this is what I got.

kernel: avc: denied { create } for pid=3D761 exe=3D/sbin/ip
scontext=3Droot:sysadm_r:sysadm_t tcontext=3Droot:sysadm_r:sysadm_t
tclass=3Dnetlink_socket

I'll check out that posted VMware Rules as soon as I get the chance and
then try the new version.

Timothy,

--=-eBV5rDKlxg6ZCaOZOBf1
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQA8Uairf/PqxrKarmgRAr4rAKCKIOOelLuzXXLcTOG5VqZGgu6EhgCeK5HF
iQEGOWIZ8iAgKSOtlNcb5o8=
=LWVn
-----END PGP SIGNATURE-----

--=-eBV5rDKlxg6ZCaOZOBf1--


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
