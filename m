Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o2BJKaKh027179
	for <selinux@tycho.nsa.gov>; Thu, 11 Mar 2010 14:20:36 -0500
Received: from relay.felk.cvut.cz (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id o2BJL2T3005945
	for <selinux@tycho.nsa.gov>; Thu, 11 Mar 2010 19:21:03 GMT
Received: from labe.felk.cvut.cz (labe.felk.cvut.cz [147.32.85.34])
	by relay.felk.cvut.cz (8.14.3/8.14.3) with ESMTP id o2BJKIxX003451
	for <selinux@tycho.nsa.gov>; Thu, 11 Mar 2010 20:20:18 +0100 (CET)
	(envelope-from michal.svoboda@agents.felk.cvut.cz)
Received: from [147.32.84.251] (mas16.felk.cvut.cz [147.32.84.166])
	by labe.felk.cvut.cz (8.13.8/8.13.8) with ESMTP id o2BJKIW6060886
	for <selinux@tycho.nsa.gov>; Thu, 11 Mar 2010 20:20:18 +0100 (CET)
	(envelope-from michal.svoboda@agents.felk.cvut.cz)
Date: Thu, 11 Mar 2010 20:20:18 +0100
From: Michal Svoboda <michal.svoboda@agents.felk.cvut.cz>
To: selinux@tycho.nsa.gov
Subject: Re: init problem
Message-ID: <20100311192018.GG24034@myhost.felk.cvut.cz>
References: <20100307101505.GA3587@myhost.felk.cvut.cz>
 <4B939F47.7050704@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bFsKbPszpzYNtEU6"
In-Reply-To: <4B939F47.7050704@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--bFsKbPszpzYNtEU6
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Daniel J Walsh wrote:
> /* Return 1 if we are running on a SELinux kernel, or 0 if not or -1
> if we get an error. */
> extern int is_selinux_enabled(void);
>=20
> Attached patch to fix man page.

Okay. In that case, sysvinit needs the following fix (tested to solve
the issue):

   if (getenv("SELINUX_INIT") =3D=3D NULL&&  (1 !=3D is_selinux_enabled()))=
 {
                                          ^

(I got the original fix wrong.)

Michal Svoboda

--bFsKbPszpzYNtEU6
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkuZQnIACgkQg/fU9pp1uX55qgCfb1+Grej2vnoqWWRTIAPEwwyA
z/wAnRoHbbIePUW59ZJsqtvByUiaAhfj
=ZXli
-----END PGP SIGNATURE-----

--bFsKbPszpzYNtEU6--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
