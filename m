Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i1NN5jRb020251
	for <selinux@tycho.nsa.gov>; Mon, 23 Feb 2004 18:05:46 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i1NN4BlK022282
	for <selinux@tycho.nsa.gov>; Mon, 23 Feb 2004 23:04:11 GMT
Received: from monk.verbum.org (monk.debian.net [216.226.142.128])
	by jazzswing.ncsc.mil  with ESMTP id i1NN4BOX022245
	for <selinux@tycho.nsa.gov>; Mon, 23 Feb 2004 23:04:11 GMT
Received: from nexus.verbum.private (dhcp024-208-187-170.columbus.rr.com [24.208.187.170])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "nexus.verbum.org", Issuer "monk.verbum.org" (verified OK))
	by monk.verbum.org (Postfix (Debian/GNU)) with ESMTP id 5A64532A6D9
	for <selinux@tycho.nsa.gov>; Mon, 23 Feb 2004 18:07:58 -0500 (EST)
Subject: odd segfault in checkpolicy
From: Colin Walters <walters@verbum.org>
To: selinux@tycho.nsa.gov
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-CbGTYoAhVDt+bx9ws/V8"
Message-Id: <1077577191.4374.9.camel@nexus.verbum.private>
Mime-Version: 1.0
Date: Mon, 23 Feb 2004 17:59:51 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-CbGTYoAhVDt+bx9ws/V8
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

I've been trying to track down an odd segfault when checkpolicy is
compiled without optimization, but I've been looking at the code for
like an hour and a half now and I just can't see the problem.  Here's
some debugging information:

walters@nexus> make CFLAGS=3D'-g -O0'
[build output elided]
walters@nexus> gdb --args ./checkpolicy -b -d ~/tmp/policy.15
GNU gdb Red Hat Linux (5.3.90-0.20030710.41rh)
Copyright 2003 Free Software Foundation, Inc.
GDB is free software, covered by the GNU General Public License, and you ar=
e
welcome to change it and/or distribute copies of it under certain condition=
s.
Type "show copying" to see the conditions.
There is absolutely no warranty for GDB.  Type "show warranty" for details.
This GDB was configured as "i386-redhat-linux-gnu"...Using host libthread_d=
b library "/lib/tls/libthread_db.so.1".
=20
(gdb) r
Starting program: /src/research/checkpolicy-1.4/checkpolicy -b -d /home/wal=
ters/tmp/policy.15
/src/research/checkpolicy-1.4/checkpolicy:  loading policy configuration fr=
om /home/walters/tmp/policy.15
=20
Program received signal SIGSEGV, Segmentation fault.
0x0804c7ae in policydb_read (p=3D0x8062a40, fp=3D0xbffff628) at policydb.c:=
993
993                     buf[i] =3D le32_to_cpu(buf[i]);
(gdb) bt
#0  0x0804c7ae in policydb_read (p=3D0x8062a40, fp=3D0xbffff628) at policyd=
b.c:993
#1  0x0804e86f in security_load_policy (data=3D0x40012000, len=3D1150156) a=
t services.c:921
#2  0x08058f55 in main (argc=3D4, argv=3D0xbffff9c4) at checkpolicy.c:373
(gdb) p buf
$1 =3D (__u32 *) 0x40012000
(gdb) p/x buf[0]
$2 =3D 0xf97cff8c
(gdb) p buf[1]
$3 =3D 8

This problem disappears if I recompile with the default optimization
(just 'make').  I started to suspect a gcc bug...but every time so far
that I suspected that I've been wrong :)  I can reproduce the problem
using the default gcc on FC1 (3.3.2), as well as the default gcc on
Debian woody (2.95.4).

Looking at the code, I suspected it was a problem with the "next_entry"
inline function - but I don't see a bug there.  Note above that buf[0]
does match SELINUX_MAGIC.

Does anyone have any ideas?  Can anyone else reproduce this?

--=-CbGTYoAhVDt+bx9ws/V8
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQBAOoXmOIkJWWp2WGURAslhAJ95pCtBCG+bCEoeiTWqm4nx3s4mSgCeM6w/
cVdP3jdWsAaZkd3GEZq/J8k=
=EDPe
-----END PGP SIGNATURE-----

--=-CbGTYoAhVDt+bx9ws/V8--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
