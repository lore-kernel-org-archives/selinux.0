Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k2GMmsea027254
	for <selinux@tycho.nsa.gov>; Thu, 16 Mar 2006 17:48:54 -0500
Received: from mailrelay2.lrz-muenchen.de (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k2GMlG3h020424
	for <selinux@tycho.nsa.gov>; Thu, 16 Mar 2006 22:47:16 GMT
Received: from cobalt.jmh.mhn.de ([192.168.10.2] [192.168.10.2]) by mailout.lrz-muenchen.de for selinux@tycho.nsa.gov; Thu, 16 Mar 2006 23:48:41 +0100
Date: Thu, 16 Mar 2006 23:48:38 +0100
From: Thomas Bleher <bleher@informatik.uni-muenchen.de>
To: SELinux ML <selinux@tycho.nsa.gov>
Subject: semodule dumps core
Message-Id: <20060316224834.GA8552@thorium.jmh.mhn.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="AqsLC8rIMeq19msA"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--AqsLC8rIMeq19msA
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Seems like semodule doesn't like me. I just recompiled my policy with
the new versions of the tools and now semodule dumps core when I do a=20
"semodule -b base.pp".

The backtrace from gdb looks like this:
(gdb) backtrace
#0  0x37ec2f5c in fclose@plt () from /lib/libsemanage.so.1
#1  0x37ec8950 in semanage_direct_commit (sh=3D0x804c4a8) at direct_api.c:4=
01
#2  0x37eca3fe in semanage_commit (sh=3D0x804c4a8) at handle.c:227
#3  0x08049507 in main (argc=3D3, argv=3D0x3fc5db44) at semodule.c:361

I'm not experienced in debugging this so I put up semodule, the corefile
and the base.pp at
http://www.cip.ifi.lmu.de/~bleher/selinux/ubuntu/semodule-coredump.tar.bz2
(1.5MB)

In this directory you will also find the Debian packages I used
(libsemanage, libsepol, ...).

Please let me know if you need more information.

Thanks,
Thomas


--AqsLC8rIMeq19msA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFEGetCD9qpeVMU938RAqTWAJ46C2gmdeGgJwF0oMWJnFfeFYG/1wCeKQhr
+FdqSZRapQUDgbcRzW8yY3I=
=UPAj
-----END PGP SIGNATURE-----

--AqsLC8rIMeq19msA--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
