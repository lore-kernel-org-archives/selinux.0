Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id oBFKbU6R027851
	for <selinux@tycho.nsa.gov>; Wed, 15 Dec 2010 15:37:30 -0500
Received: from relay.felk.cvut.cz (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id oBFKbRai010652
	for <selinux@tycho.nsa.gov>; Wed, 15 Dec 2010 20:37:28 GMT
Received: from labe.felk.cvut.cz (labe.felk.cvut.cz [147.32.85.34])
	by relay.felk.cvut.cz (8.14.4/8.14.4) with ESMTP id oBFKbKRD000162
	for <selinux@tycho.nsa.gov>; Wed, 15 Dec 2010 21:37:20 +0100 (CET)
	(envelope-from michal.svoboda@agents.felk.cvut.cz)
Received: from [147.32.84.251] (mas16.felk.cvut.cz [147.32.84.166])
	by labe.felk.cvut.cz (8.13.8/8.13.8) with ESMTP id oBFKd2sV079158
	for <selinux@tycho.nsa.gov>; Wed, 15 Dec 2010 21:39:02 +0100 (CET)
	(envelope-from michal.svoboda@agents.felk.cvut.cz)
Date: Wed, 15 Dec 2010 21:37:20 +0100
From: Michal Svoboda <michal.svoboda@agents.felk.cvut.cz>
To: SELinux <selinux@tycho.nsa.gov>
Subject: type bounds for files?
Message-ID: <20101215203720.GH18729@myhost.felk.cvut.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="hAW+M2+FUO+onfmf"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--hAW+M2+FUO+onfmf
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hello,

let's say I have a www service that's run through apache/selinux+ with
its own domain say foo_t. The domain has write access to some files with
type foo_data_t (which is files_type) through an allow rule.

Now, due to the 'typebound httpd_t foo_t' rule used with apache domains,
I would normally also have to 'allow httpd_t foo_data_t : file ...'.

But today I saw another solution at work, which used an oddball rule
where the foo_data_t was type bounded by another files_type, something
like 'typebound http_user_data_t foo_data_t' (don't remember the
bounding type's name exactly). This would make the www service work the
expected way without the need for 'allow httpd_t foo_data_t : file ...'.

Is this a known behavior? What is the sense in typebounding file types?

Just for completeness this was on FC12 with targeted policy.

Michal Svoboda

--hAW+M2+FUO+onfmf
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEARECAAYFAk0JJwAACgkQg/fU9pp1uX4tigCgre2QZxp3Eib7BmOHGzUJp9kb
H1sAnRazWu6OzZ2wZsV3V/hIFRy4yJXK
=Srbl
-----END PGP SIGNATURE-----

--hAW+M2+FUO+onfmf--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
