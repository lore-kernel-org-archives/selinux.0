Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id RAA16837
	for <selinux@tycho.nsa.gov>; Wed, 31 Jul 2002 17:33:27 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id VAA06716
	for <selinux@tycho.nsa.gov>; Wed, 31 Jul 2002 21:31:53 GMT
Received: from vmmr1.verisignmail.com (vmmr1.verisignmail.com [216.168.230.137])
        by jazzband.ncsc.mil  with ESMTP id VAA06710 for <selinux@tycho.nsa.gov>; Wed, 31 Jul 2002 21:31:52 GMT
Reply-To: <nigel@forever-networks.com>
From: "Nigel Clarke" <nigel@forever-networks.com>
To: <selinux@tycho.nsa.gov>
Subject: PROBLEM PATCHING THE KERNEL
Date: Wed, 31 Jul 2002 17:23:47 -0700
Message-ID: <HGEEKCPKMCLEIOHFGKCNAELECAAA.nigel@forever-networks.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

I've just installed Redhat 7.2.  I'm having some problems with the
SElinux kernel patch file(s). 

Is there a problem with the make file ? 

[root@localhost selinux]# cd module/
[root@localhost module]# make insert
cd ../../lsm-2.4; patch -p0 < ../selinux/module/lsm-2.4-patch
(Stripping trailing CRs from patch.)
patching file Makefile
Hunk #1 FAILED at 1.
1 out of 1 hunk FAILED -- saving rejects to file Makefile.rej
(Stripping trailing CRs from patch.)
patching file arch/i386/defconfig
Hunk #1 FAILED at 154.
Hunk #2 FAILED at 830.
2 out of 2 hunks FAILED -- saving rejects to file
arch/i386/defconfig.rej
(Stripping trailing CRs from patch.)
patching file net/netsyms.c
Hunk #1 FAILED at 295.
1 out of 1 hunk FAILED -- saving rejects to file net/netsyms.c.rej
make: *** [insert] Error 1
[root@localhost module]#

Nigel Clarke
Network Security Engineer
Forever Networks
 

-----BEGIN PGP SIGNATURE-----
Version: PGPfreeware 7.0.3 for non-commercial use <http://www.pgp.com>

iQA/AwUBPUh/iNBDCv2bqVf3EQIjuQCguER1p68vAhx8syrEboNH2a9FCKkAoNgP
hraLR0MtNuh3Hv3bQyUBhqzN
=CpGt
-----END PGP SIGNATURE-----


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
