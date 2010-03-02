Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o22BCtdN022628
	for <selinux@tycho.nsa.gov>; Tue, 2 Mar 2010 06:12:55 -0500
Received: from relay.felk.cvut.cz (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id o22BCOAw021825
	for <selinux@tycho.nsa.gov>; Tue, 2 Mar 2010 11:12:24 GMT
Received: from labe.felk.cvut.cz (labe.felk.cvut.cz [147.32.85.34])
	by relay.felk.cvut.cz (8.14.3/8.14.3) with ESMTP id o22BCWQ0006653
	for <selinux@tycho.nsa.gov>; Tue, 2 Mar 2010 12:12:32 +0100 (CET)
	(envelope-from michal.svoboda@agents.felk.cvut.cz)
Received: from [147.32.84.251] (mas16.felk.cvut.cz [147.32.84.166])
	by labe.felk.cvut.cz (8.13.8/8.13.8) with ESMTP id o22BCVCa069324
	for <selinux@tycho.nsa.gov>; Tue, 2 Mar 2010 12:12:31 +0100 (CET)
	(envelope-from michal.svoboda@agents.felk.cvut.cz)
Date: Tue, 2 Mar 2010 12:12:31 +0100
From: Michal Svoboda <michal.svoboda@agents.felk.cvut.cz>
To: SELinux <selinux@tycho.nsa.gov>
Subject: Re: denials with filesystem associate
Message-ID: <20100302111231.GK3990@myhost.felk.cvut.cz>
References: <20100228223834.GE3990@myhost.felk.cvut.cz>
 <1267452601.601.3.camel@moss-pluto.epoch.ncsc.mil>
 <20100301165602.GH3990@myhost.felk.cvut.cz>
 <1267463356.601.26.camel@moss-pluto.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1ppIqr1kl39GnwQx"
In-Reply-To: <1267463356.601.26.camel@moss-pluto.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--1ppIqr1kl39GnwQx
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Stephen Smalley wrote:
> On file creation, there is an associate check between the security
> context of the file and the security context of the containing
> filesystem. =20

OK, I think I now understand this permission. But it seems that in a
normal (reference) policy all files are permitted on all filesystems.
Are there cases when they're not?

And secondly, it seems that every file type has an associate permission
on itself, ie.

   allow etc_runtime_t etc_runtime_t : filesystem associate ;=20

Why is this so?

Regards,
Michal Svoboda


--1ppIqr1kl39GnwQx
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkuM8p8ACgkQg/fU9pp1uX7M5gCaAr3l90CZhd2Aqr/emaznTS/S
XYMAoLAwZ+/KJiy3aTyTKyQ3VbpbZG1n
=a15x
-----END PGP SIGNATURE-----

--1ppIqr1kl39GnwQx--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
