Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s0T84Mm1030695
 for <selinux@tycho.nsa.gov>; Wed, 29 Jan 2014 03:04:23 -0500
Received: from desktop.mthode.org (unknown
 [IPv6:2001:470:e1cc:2:f66d:4ff:fe54:f77d])
 (using TLSv1 with cipher ECDHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by mx1.mthode.org (Postfix) with ESMTPSA id 3F4261527A
 for <selinux@tycho.nsa.gov>; Wed, 29 Jan 2014 03:07:48 -0500 (EST)
Message-ID: <52E8B5F8.2070005@mthode.org>
Date: Wed, 29 Jan 2014 02:04:08 -0600
From: Matthew Thode <mthode@mthode.org>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: file access causes a kernel bug
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="3uqopnqv7krPCnipLUFGQ6uucVXb7UE4f"
Reply-To: mthode@mthode.org
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--3uqopnqv7krPCnipLUFGQ6uucVXb7UE4f
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

This happens consistantly, just ls a particular dir and wheeeeee.

[  473.893141] ------------[ cut here ]------------
[  473.962110] kernel BUG at security/selinux/ss/services.c:654!
[  473.995314] invalid opcode: 0000 [#6] SMP
[  474.027196] Modules linked in:
[  474.058118] CPU: 0 PID: 8138 Comm: ls Tainted: G      D   I
3.13.0-grsec #1
[  474.116637] Hardware name: Supermicro X8ST3/X8ST3, BIOS 2.0
07/29/10
[  474.149768] task: ffff8805f50cd010 ti: ffff8805f50cd488 task.ti:
ffff8805f50cd488
[  474.183707] RIP: 0010:[<ffffffff814681c7>]  [<ffffffff814681c7>]
context_struct_compute_av+0xce/0x308
[  474.219954] RSP: 0018:ffff8805c0ac3c38  EFLAGS: 00010246
[  474.252253] RAX: 0000000000000000 RBX: ffff8805c0ac3d94 RCX:
0000000000000100
[  474.287018] RDX: ffff8805e8aac000 RSI: 00000000ffffffff RDI:
ffff8805e8aaa000
[  474.321199] RBP: ffff8805c0ac3cb8 R08: 0000000000000010 R09:
0000000000000006
[  474.357446] R10: 0000000000000000 R11: ffff8805c567a000 R12:
0000000000000006
[  474.419191] R13: ffff8805c2b74e88 R14: 00000000000001da R15:
0000000000000000
[  474.453816] FS:  00007f2e75220800(0000) GS:ffff88061fc00000(0000)
knlGS:0000000000000000
[  474.489254] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  474.522215] CR2: 00007f2e74716090 CR3: 00000005c085e000 CR4:
00000000000207f0
[  474.556058] Stack:
[  474.584325]  ffff8805c0ac3c98 ffffffff811b549b ffff8805c0ac3c98
ffff8805f1190a40
[  474.618913]  ffff8805a6202f08 ffff8805c2b74e88 00068800d0464990
ffff8805e8aac860
[  474.653955]  ffff8805c0ac3cb8 000700068113833a ffff880606c75060
ffff8805c0ac3d94
[  474.690461] Call Trace:
[  474.723779]  [<ffffffff811b549b>] ? lookup_fast+0x1cd/0x22a
[  474.778049]  [<ffffffff81468824>] security_compute_av+0xf4/0x20b
[  474.811398]  [<ffffffff8196f419>] avc_compute_av+0x2a/0x179
[  474.843813]  [<ffffffff8145727b>] avc_has_perm+0x45/0xf4
[  474.875694]  [<ffffffff81457d0e>] inode_has_perm+0x2a/0x31
[  474.907370]  [<ffffffff81457e76>] selinux_inode_getattr+0x3c/0x3e
[  474.938726]  [<ffffffff81455cf6>] security_inode_getattr+0x1b/0x22
[  474.970036]  [<ffffffff811b057d>] vfs_getattr+0x19/0x2d
[  475.000618]  [<ffffffff811b05e5>] vfs_fstatat+0x54/0x91
[  475.030402]  [<ffffffff811b063b>] vfs_lstat+0x19/0x1b
[  475.061097]  [<ffffffff811b077e>] SyS_newlstat+0x15/0x30
[  475.094595]  [<ffffffff8113c5c1>] ? __audit_syscall_entry+0xa1/0xc3
[  475.148405]  [<ffffffff8197791e>] system_call_fastpath+0x16/0x1b
[  475.179201] Code: 00 48 85 c0 48 89 45 b8 75 02 0f 0b 48 8b 45 a0 48
8b 3d 45 d0 b6 00 8b 40 08 89 c6 ff ce e8 d1 b0 06 00 48 85 c0 49 89 c7
75 02 <0f> 0b 48 8b 45 b8 4c 8b 28 eb 1e 49 8d 7d 08 be 80 01 00 00 e8
[  475.255884] RIP  [<ffffffff814681c7>]
context_struct_compute_av+0xce/0x308
[  475.296120]  RSP <ffff8805c0ac3c38>
[  475.328734] ---[ end trace f076482e9d754adc ]---


--=20
-- Matthew Thode


--3uqopnqv7krPCnipLUFGQ6uucVXb7UE4f
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS6LYCAAoJECRx6z5ArFrDn2wQAJziwJ0xFtGnkUe7qKR2ItFh
5K55z6iTzm5gQjkg3PNaes/5C7pwzD9PaWDMlsZXZcN1HpFG//USV3Poh5FPJ3Cw
QZwheq/GvtT8We2Ia0aBMtDT+1227Q9d8fmPMxDfrKJ3BdDBI3F4QXT9Lh3GFUpU
je+Oc67MQkHvfZX4FUdgLfW4QWJb/RVZqdXUpbfaBfUBDL2LEXRpih3nqA/KOE0D
6wOAYd+h+C/6Xe2TGKuNNQALwrSfs4RkL6ZXQi17mr5wH4ogAEGmnYLCeItb4i6i
UMUXS/IhpKOm4ibdBvdSZgYnS3Ewub8TaBonURS6nil9mDtO+qgrZN13pbJN79c3
kJdRoKseRl5vxwnIJO1k/yGqm6vYFivjUtYDdPCKAFVMvMyRd50+YZlcq+E5/SaN
8ORbZjn32D1b9aSfCLW2gaDV/UC2TwdFcJ/NGTY4HYndZw4gbA6qcFJq+96xzvxk
4OnUVBIVom5oiMcT30+i0TVbfut/xyrPBkU77+MM9Iy0yv7xVxyBxB58BXUmUuNr
fddzZ/hriZg1wQElGGpiPpJmT1So/2VdJpNZkQx7eH2l2xQ2hmlcNQZgxXbEeTaP
dwlhIWTMRtIsaAP2l8dcL+PwpEpo3P2EYSlaI7oRjiVsStjhLVnM9AM1klEOXMic
QehikZ27JouUDZQuLJSr
=zSV7
-----END PGP SIGNATURE-----

--3uqopnqv7krPCnipLUFGQ6uucVXb7UE4f--
