Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s0T8BuM4031073
 for <selinux@tycho.nsa.gov>; Wed, 29 Jan 2014 03:11:56 -0500
Received: from desktop.mthode.org (unknown
 [IPv6:2001:470:e1cc:2:f66d:4ff:fe54:f77d])
 (using TLSv1 with cipher ECDHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by mx1.mthode.org (Postfix) with ESMTPSA id 0921F1521C
 for <selinux@tycho.nsa.gov>; Wed, 29 Jan 2014 03:15:22 -0500 (EST)
Message-ID: <52E8B7C1.1000101@mthode.org>
Date: Wed, 29 Jan 2014 02:11:45 -0600
From: Matthew Thode <mthode@mthode.org>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: Re: file access causes a kernel bug
References: <52E8B5F8.2070005@mthode.org>
In-Reply-To: <52E8B5F8.2070005@mthode.org>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="HjoO4HNDsF5JT6Q8KJGBheuMLqe0C9e8a"
Reply-To: mthode@mthode.org
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--HjoO4HNDsF5JT6Q8KJGBheuMLqe0C9e8a
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 01/29/2014 02:04 AM, Matthew Thode wrote:
> This happens consistantly, just ls a particular dir and wheeeeee.
>=20
> [  473.893141] ------------[ cut here ]------------
> [  473.962110] kernel BUG at security/selinux/ss/services.c:654!
> [  473.995314] invalid opcode: 0000 [#6] SMP
> [  474.027196] Modules linked in:
> [  474.058118] CPU: 0 PID: 8138 Comm: ls Tainted: G      D   I
> 3.13.0-grsec #1
> [  474.116637] Hardware name: Supermicro X8ST3/X8ST3, BIOS 2.0
> 07/29/10
> [  474.149768] task: ffff8805f50cd010 ti: ffff8805f50cd488 task.ti:
> ffff8805f50cd488
> [  474.183707] RIP: 0010:[<ffffffff814681c7>]  [<ffffffff814681c7>]
> context_struct_compute_av+0xce/0x308
> [  474.219954] RSP: 0018:ffff8805c0ac3c38  EFLAGS: 00010246
> [  474.252253] RAX: 0000000000000000 RBX: ffff8805c0ac3d94 RCX:
> 0000000000000100
> [  474.287018] RDX: ffff8805e8aac000 RSI: 00000000ffffffff RDI:
> ffff8805e8aaa000
> [  474.321199] RBP: ffff8805c0ac3cb8 R08: 0000000000000010 R09:
> 0000000000000006
> [  474.357446] R10: 0000000000000000 R11: ffff8805c567a000 R12:
> 0000000000000006
> [  474.419191] R13: ffff8805c2b74e88 R14: 00000000000001da R15:
> 0000000000000000
> [  474.453816] FS:  00007f2e75220800(0000) GS:ffff88061fc00000(0000)
> knlGS:0000000000000000
> [  474.489254] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  474.522215] CR2: 00007f2e74716090 CR3: 00000005c085e000 CR4:
> 00000000000207f0
> [  474.556058] Stack:
> [  474.584325]  ffff8805c0ac3c98 ffffffff811b549b ffff8805c0ac3c98
> ffff8805f1190a40
> [  474.618913]  ffff8805a6202f08 ffff8805c2b74e88 00068800d0464990
> ffff8805e8aac860
> [  474.653955]  ffff8805c0ac3cb8 000700068113833a ffff880606c75060
> ffff8805c0ac3d94
> [  474.690461] Call Trace:
> [  474.723779]  [<ffffffff811b549b>] ? lookup_fast+0x1cd/0x22a
> [  474.778049]  [<ffffffff81468824>] security_compute_av+0xf4/0x20b
> [  474.811398]  [<ffffffff8196f419>] avc_compute_av+0x2a/0x179
> [  474.843813]  [<ffffffff8145727b>] avc_has_perm+0x45/0xf4
> [  474.875694]  [<ffffffff81457d0e>] inode_has_perm+0x2a/0x31
> [  474.907370]  [<ffffffff81457e76>] selinux_inode_getattr+0x3c/0x3e
> [  474.938726]  [<ffffffff81455cf6>] security_inode_getattr+0x1b/0x22
> [  474.970036]  [<ffffffff811b057d>] vfs_getattr+0x19/0x2d
> [  475.000618]  [<ffffffff811b05e5>] vfs_fstatat+0x54/0x91
> [  475.030402]  [<ffffffff811b063b>] vfs_lstat+0x19/0x1b
> [  475.061097]  [<ffffffff811b077e>] SyS_newlstat+0x15/0x30
> [  475.094595]  [<ffffffff8113c5c1>] ? __audit_syscall_entry+0xa1/0xc3
> [  475.148405]  [<ffffffff8197791e>] system_call_fastpath+0x16/0x1b
> [  475.179201] Code: 00 48 85 c0 48 89 45 b8 75 02 0f 0b 48 8b 45 a0 48=

> 8b 3d 45 d0 b6 00 8b 40 08 89 c6 ff ce e8 d1 b0 06 00 48 85 c0 49 89 c7=

> 75 02 <0f> 0b 48 8b 45 b8 4c 8b 28 eb 1e 49 8d 7d 08 be 80 01 00 00 e8
> [  475.255884] RIP  [<ffffffff814681c7>]
> context_struct_compute_av+0xce/0x308
> [  475.296120]  RSP <ffff8805c0ac3c38>
> [  475.328734] ---[ end trace f076482e9d754adc ]---
>=20
>=20
>=20
>=20
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho.n=
sa.gov.
>=20
sorry, forgot to add, this is for 3.13.0 as well.

ls ./.config/ipython/profile_default/
Segmentation fault

--=20
-- Matthew Thode


--HjoO4HNDsF5JT6Q8KJGBheuMLqe0C9e8a
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS6LfJAAoJECRx6z5ArFrD/CkP/AgK+Uf/0Wo6g2rl1YP6UMoq
yu7pes1wdGh7iAg14ullERgfA+a0A+/UqWC+DgkMgezIpVXEZ2MxacJIYIfLVXSD
ZYjXmE6Qxe8lmRfy4/xjWdabb+fIyy7ct/57lM0HeJcFpq0g2Ngg7uGKPZMxZKJq
+kGa8VyM8GUuSLfzzK7WEpeTL0GvV9MVI0j8J0ZtTPWy6X2p45eesZdepOOM/yfR
8s6/LM85SabnidMnIqqyDKcONwPxJGwvEFagC0mOCndHq+cKyXnJVz8sAr7pr77l
1zOa850uOZzK48bB2YPLq+FPihnrM/xHO8Vo4KVfRHK8HjB19HyHh1j+6OqUogkD
epjNTYOEjB4VlDX88FdBPaCSe3gGsC7cjCbRY17+Jnx9+0+sSYZKFTDKUOVP4opr
jJjbi6OOkSujivS1S4AAxEXOxgmqatkxr6ooO4bOFDm8/XIentF5MJnmHjM9yrTo
SlamFaREd2tAFnliAx/Jpg+hTcyHSqlmpj+oXb3z8WKulWxQTp7yx170gNOtyotL
Wczb7UwTDTPzAuT6z97Q6SCom5kadnyocF2HSBS7HbcXfsniiWaa727KR2/FdWrG
JVdaTIE9gO/bHXiQZ2MDSFHVRDRr15maDqpa0yiJF2EIi+gbApzZN3YIPPygSW7v
PFYeSDs/jh+lPNTPRopx
=qt0y
-----END PGP SIGNATURE-----

--HjoO4HNDsF5JT6Q8KJGBheuMLqe0C9e8a--
