Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id MAA14621
	for <selinux@tycho.nsa.gov>; Wed, 31 Jul 2002 12:49:09 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id QAA19383
	for <selinux@tycho.nsa.gov>; Wed, 31 Jul 2002 16:47:34 GMT
Received: from vmmr1.verisignmail.com (vmmr1.verisignmail.com [216.168.230.137])
        by jazzband.ncsc.mil  with ESMTP id QAA19379 for <selinux@tycho.nsa.gov>; Wed, 31 Jul 2002 16:47:34 GMT
Reply-To: <nigel@forever-networks.com>
From: "Nigel Clarke" <nigel@forever-networks.com>
To: <selinux@tycho.nsa.gov>
Subject: Problem with install 
Date: Wed, 31 Jul 2002 12:39:53 -0700
Message-ID: <HGEEKCPKMCLEIOHFGKCNOEKNCAAA.nigel@forever-networks.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

I'm trying to install on a new server. I'm running Redhat 7.2 

I started by following the instructions in the STEP-BY-STEP guide. 

[root@localhost selinux]# make insert
Patching the LSM tree.
cd module && make insert LSMVER=-2.4
make[1]: Entering directory `/usr/vault/nsa/selinux/module'
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
make[1]: *** [insert] Error 1
make[1]: Leaving directory `/usr/vault/nsa/selinux/module'
make: *** [insert] Error 2
[root@localhost selinux]#

Nigel Clarke
Network Security Engineer
Forever Networks
 

-----BEGIN PGP SIGNATURE-----
Version: PGPfreeware 7.0.3 for non-commercial use <http://www.pgp.com>

iQA/AwUBPUg89tBDCv2bqVf3EQKFLACggCqBNf09r0XxeTIsCIvpLcDW8tAAoOuB
UHU9+QSzcOWtexJ9VUNES0AA
=nbxi
-----END PGP SIGNATURE-----


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
