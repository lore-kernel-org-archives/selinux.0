Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j2Q1kbDo013878
	for <selinux@tycho.nsa.gov>; Fri, 25 Mar 2005 20:46:37 -0500 (EST)
Received: from vds-320151.amen-pro.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j2Q1ha54019037
	for <selinux@tycho.nsa.gov>; Sat, 26 Mar 2005 01:43:37 GMT
Subject: [Ubuntu SELinux] Linux-PAM-0.78, cron, checkpolicy, libselinux,
	libsepol, logrotate, sysvinit
From: Lorenzo =?ISO-8859-1?Q?Hern=E1ndez_?= =?ISO-8859-1?Q?Garc=EDa-Hierro?= <lorenzo@gnu.org>
To: ubuntu-hardened@lists.ubuntu.com
Cc: selinux@tycho.nsa.gov, ubuntu-devel@lists.ubuntu.com
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-yBAlC1QlL5OPo7zvRjP8"
Date: Sat, 26 Mar 2005 02:45:38 +0100
Message-Id: <1111801538.27644.172.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-yBAlC1QlL5OPo7zvRjP8
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

I'm pleased to announce the available of some user-land packages ready
for SELinux support, that amount a total percentage of 75% from the
total work needed to have the base SELinux support in both userland and
kernel-level (the targeted policy is left, coreutils is being fixed and
openssh needs more work, see
http://pearls.tuxedo-es.org/selinux/ubuntu/openssh/openssh_3.9p1-1ubuntu2_i=
386.build for more information (no, it's not a missing -lselinux ;) ).

The following packages are ready for SELinux support or upgraded:

	1. Linux-PAM 	(0.78)
	2. cron 	(3.0pl1-86ubuntu2)
	3. checkpolicy 	(1.22-3)
	4. libselinux 	(1.22-2)
	5. libsepol 	(1.4-2)
	6. logrotate 	(3.7-3)
	7. sysvinit 	(2.86-5ubuntu)

1. http://pearls.tuxedo-es.org/selinux/ubuntu/pam/

Instead of assessing the risk of porting the patch to the old (and
currently used in both Debian and Ubuntu) 0.76 version, I've re-worked
the package with the current 0.78 version, tested each one of the
specific Debian patches, reviewed each line of diff and the package
building directives.
Thus, most Debian specific patches were ported and are available within
the source (and/or edited and available in ./debian/patches-applied),
also I've used some Fedora's patches (mainly SELinux related ones) and
fixed those offsets and hunks failing during the transition from 0.76 to
0.78.

It's a key goal to update Linux-PAM in both distributions, among
providing SELinux support.

I encourage to test the package and give feedback on it.

2. http://pearls.tuxedo-es.org/selinux/ubuntu/cron/

Re-worked package for Vixie cron (aka cron) that uses the cron-b-se tree
for building and packaging, thus, providing the SELinux compliant
version.

3. http://pearls.tuxedo-es.org/selinux/ubuntu/checkpolicy/

Upgraded from 1.18 to latest from Manoj.

4. http://pearls.tuxedo-es.org/selinux/ubuntu/libselinux/

Upgraded from 1.18 to latest from Manoj (1.22).

5. http://pearls.tuxedo-es.org/selinux/ubuntu/logrotate/

Added SELinux support.

6. http://pearls.tuxedo-es.org/selinux/ubuntu/sysvinit/

Fixed revision with latest code from Fedora's patches, originally using
Russell Coker's old patches.

Thanks in advance for the comments, cheers.
--=20
Lorenzo Hern=E1ndez Garc=EDa-Hierro <lorenzo@gnu.org>=20
[1024D/6F2B2DEC] & [2048g/9AE91A22][http://tuxedo-es.org]

--=-yBAlC1QlL5OPo7zvRjP8
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBCRL7CDcEopW8rLewRArunAKC1its7//u0eGtf/y7sxvzBMdk2FgCfVVC3
Vb8VagMymrtlERzBVv5eMjQ=
=L6eM
-----END PGP SIGNATURE-----

--=-yBAlC1QlL5OPo7zvRjP8--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
