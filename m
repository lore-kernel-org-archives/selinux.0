Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i9HC2CrT016066
	for <selinux@tycho.nsa.gov>; Sun, 17 Oct 2004 08:02:12 -0400 (EDT)
Received: from mailrelay2.lrz-muenchen.de (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i9HC2C8B028020
	for <selinux@tycho.nsa.gov>; Sun, 17 Oct 2004 12:02:12 GMT
Received: from cobalt.jmh.mhn.de ([192.168.10.2] [192.168.10.2]) by mailout.lrz-muenchen.de for selinux@tycho.nsa.gov; Sun, 17 Oct 2004 14:02:11 +0200
Date: Sun, 17 Oct 2004 14:02:48 +0200
From: Thomas Bleher <bleher@informatik.uni-muenchen.de>
To: SELinux ML <selinux@tycho.nsa.gov>
Subject: kernel oops
Message-Id: <20041017120245.GB2537@jmh.mhn.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="R3G7APHDIzY6R/pk"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--R3G7APHDIzY6R/pk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I realize that this oops report may be almost useless because it
happened on a system with loaded nvidia binary driver. Nevertheless,
maybe one of the kernel gurus can tell if SELinux is at fault here or if
I should blame nvidia.
The oops happened on a vanilla 2.6.8.1 box while loading policy. After
the oops, load_policy hang in D state.

Here is the oops:

Unable to handle kernel paging request at virtual address 0d5b7746
 printing eip:
c0252b34
*pde =3D 00000000
Oops: 0000 [#1]
PREEMPT SMP
Modules linked in: snd_pcm_oss snd_mixer_oss agpgart nvidia snd_seq snd_via=
82xx snd_ac97_codec snd_pcm snd_timer snd_page_alloc snd_mpu401_uart snd_ra=
wmidi snd_seq_device snd
CPU:    0
EIP:    0060:[<c0252b34>]    Tainted: P
EFLAGS: 00010206   (2.6.8.1)
EIP is at hashtab_map+0x34/0x70
eax: efd607e0   ebx: 0d5b7742   ecx: 00000009   edx: 00000020
esi: 0000001a   edi: db30abc0   ebp: db30ccc0   esp: de01bd3c
ds: 007b   es: 007b   ss: 0068
Process load_policy (pid: 29095, threadinfo=3Dde01a000 task=3De0647410)
Stack: db30ab40 db30ab60 db30ccc0 db30cc00 00000000 db30abe0 db30aba0 c0257=
281
       db30abc0 c0257180 db30ccc0 ed2943a0 0000001a e18048e0 de01bdfc c0252=
b44
       db30aba0 db30abe0 de01bdfc de01bdb4 de01bdbc de01bdfc c05df7a4 c0257=
5e5
Call Trace:
 [<c0257281>] validate_class+0x91/0x140
 [<c0257180>] validate_perm+0x0/0x70
 [<c0252b44>] hashtab_map+0x44/0x70
 [<c02575e5>] security_load_policy+0x125/0x330
 [<c02571f0>] validate_class+0x0/0x140
 [<f0f656f6>] _nv001140rm+0x10a/0x118 [nvidia]
 [<c0108899>] handle_IRQ_event+0x49/0x80
 [<c0108cfa>] do_IRQ+0xea/0x1a0
 [<c0106d48>] common_interrupt+0x18/0x20
 [<c0277f92>] __copy_from_user_ll+0x42/0x80
 [<c0278094>] copy_from_user+0x54/0x80
 [<c024fe97>] sel_write_load+0xb7/0x110
 [<c024fde0>] sel_write_load+0x0/0x110
 [<c016d47c>] vfs_write+0xec/0x150
 [<c016d5b1>] sys_write+0x51/0x80
 [<c01063db>] syscall_call+0x7/0xb
Code: 8b 43 04 89 44 24 04 8b 03 89 04 24 ff 54 24 24 85 c0 75 11

Thanks,
Thomas

--=20
http://www.cip.ifi.lmu.de/~bleher/selinux/ - my SELinux pages
GPG-Fingerprint: BC4F BB16 30D6 F253 E3EA  D09E C562 2BAE B2F4 ABE7

--R3G7APHDIzY6R/pk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBcl9lxWIrrrL0q+cRAmrtAKCNi5W80YYXp6IjhLO2FvyZm//G2QCcCW4b
qjo1K10Z6rU5oEWRBevp18c=
=r5tO
-----END PGP SIGNATURE-----

--R3G7APHDIzY6R/pk--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
