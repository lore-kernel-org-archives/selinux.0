Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m16KG2Bw019509
	for <selinux@tycho.nsa.gov>; Wed, 6 Feb 2008 15:16:02 -0500
Received: from penguin.goodinassociates.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m16KG15s008367
	for <selinux@tycho.nsa.gov>; Wed, 6 Feb 2008 20:16:02 GMT
Received: from [206.80.71.242] ([206.80.71.242])
	(authenticated bits=0)
	by penguin.goodinassociates.com (8.13.1/8.13.1) with ESMTP id m16KG3xo017263
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NO)
	for <selinux@tycho.nsa.gov>; Wed, 6 Feb 2008 14:16:03 -0600
Subject: Why am I not transitioning correctly?
From: Jeremiah Jahn <jeremiah@goodinassociates.com>
To: selinux <selinux@tycho.nsa.gov>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-8oUuUQ2JIAWu7Gsfwsgn"
Date: Wed, 06 Feb 2008 14:16:00 -0600
Message-Id: <1202328961.2801.354.camel@bluejay.goodinassociates.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-8oUuUQ2JIAWu7Gsfwsgn
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

I get this error in the audit log:
type=3DSELINUX_ERR msg=3Daudit(1202327606.098:732): security_compute_sid:  =
invalid context system_u:system_r:monetra_t:s0 for scontext=3Dsystem_u:syst=
em_r:initrc_t:s0 tcontext=3Dsystem_u:object_r:monetra_server_exec_t:s0 tcla=
ss=3Dprocess
type=3DSYSCALL msg=3Daudit(1202327606.098:732): arch=3D40000003 syscall=3D1=
1 success=3Dno exit=3D-13 a0=3D9d9f650 a1=3D9d9f5d8 a2=3D9d8c728 a3=3D9d9ff=
20 items=3D0 ppid=3D2575 pid=3D2593 auid=3D4294967295 uid=3D0 gid=3D0 euid=
=3D0 suid=3D0 fsuid=3D0 egid=3D0 sgid=3D0 fsgid=3D0 tty=3D(none) comm=3D"S9=
9monetra" ex
e=3D"/bin/bash" subj=3Dsystem_u:system_r:initrc_t:s0 key=3D(null)

I was under the assumption that the following would work:
allow initrc_t monetra_server_exec_t:file { read execute getattr};
allow monetra_t monetra_server_exec_t:file { entrypoint };
type_transition initrc_t monetra_server_exec_t:process monetra_t;

I can't do init_daemon_domain(monetra_t,monetra_server_exec_t) because I
can't let sysadm_t read anything involving monetra_t. And I'd thought
I'd read in "selinux by example" that
domain_auto_trans(initrc_t,monetra_server_exec_t,monetra_t) is generally
a bad idea.
=09



Yes, but every time I try to see things your way, I get a headache.

--=-8oUuUQ2JIAWu7Gsfwsgn
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQBHqhWA6caZY8jbHDkRAj9nAJ47XwkepY+t2iBggdEM9HrTCuZWoQCfd3s+
xK26p1ykgZlPih4MaXNRajU=
=RPGb
-----END PGP SIGNATURE-----

--=-8oUuUQ2JIAWu7Gsfwsgn--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
