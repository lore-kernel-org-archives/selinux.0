Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o27AFGOA018448
	for <selinux@tycho.nsa.gov>; Sun, 7 Mar 2010 05:15:16 -0500
Received: from relay.felk.cvut.cz (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id o27AFf6p002336
	for <selinux@tycho.nsa.gov>; Sun, 7 Mar 2010 10:15:41 GMT
Received: from labe.felk.cvut.cz (labe.felk.cvut.cz [147.32.85.34])
	by relay.felk.cvut.cz (8.14.3/8.14.3) with ESMTP id o27AF6pY092634
	for <selinux@tycho.nsa.gov>; Sun, 7 Mar 2010 11:15:06 +0100 (CET)
	(envelope-from michal.svoboda@agents.felk.cvut.cz)
Received: from [147.32.84.251] (mas16.felk.cvut.cz [147.32.84.166])
	by labe.felk.cvut.cz (8.13.8/8.13.8) with ESMTP id o27AF5p0061226
	for <selinux@tycho.nsa.gov>; Sun, 7 Mar 2010 11:15:06 +0100 (CET)
	(envelope-from michal.svoboda@agents.felk.cvut.cz)
Date: Sun, 7 Mar 2010 11:15:05 +0100
From: Michal Svoboda <michal.svoboda@agents.felk.cvut.cz>
To: selinux@tycho.nsa.gov
Subject: init problem
Message-ID: <20100307101505.GA3587@myhost.felk.cvut.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qDbXVdCdHGoSgWSk"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--qDbXVdCdHGoSgWSk
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

I just tried to boot a selinux installation in the plain old way (ie.
without initramfs) and it seems there is a bug in the init mechanism.
Sysvinit has a

#ifdef WITH_SELINUX
        if (getenv("SELINUX_INIT") =3D=3D NULL && !is_selinux_enabled()) {
          putenv("SELINUX_INIT=3DYES");
          if (selinux_init_load_policy(&enforce) =3D=3D 0 ) {
            execv(myname, argv);

whereas the is_selinux_enabled man page says "returns 1 if SELinux is
running or 0 if it is not.".

The problem is that init is the first process and at that very early
point neither /selinux nor /proc is mounted. The function uses these to
determine the state of things and if it can't it returns a -1, which is
an undocumented value and thus a value not accounted for.

So I think that either is_selinux_enabled should return 0 if it can't
tell (or use some other mechanism to tell), or -1 should be documented
in the man page and the sysvinit code should be changed to read=20

  if (getenv("SELINUX_INIT") =3D=3D NULL && (0 =3D=3D is_selinux_enabled())=
) {
                                         ^^^^

Michal Svoboda

--qDbXVdCdHGoSgWSk
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkuTfKkACgkQg/fU9pp1uX6SVwCghJBv9RKnR8L9BRs/2kUOmOFX
k6gAn0dBYy3m8ITWeaYOAVRFMYgU8ADl
=loV3
-----END PGP SIGNATURE-----

--qDbXVdCdHGoSgWSk--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
