Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id FAA18279
	for <selinux@tycho.nsa.gov>; Mon, 8 Jul 2002 05:24:45 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id JAA03180
	for <selinux@tycho.nsa.gov>; Mon, 8 Jul 2002 09:24:11 GMT
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by jazzswing.ncsc.mil  with SMTP id JAA03176
	for <selinux@tycho.nsa.gov>; Mon, 8 Jul 2002 09:24:10 GMT
Message-Id: <200207080924.JAA03176@jazzswing.ncsc.mil>
From: Carsten Grohmann <carstengrohmann@gmx.de>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Well, Make errors for real this time -- in text-utils
Date: Mon, 8 Jul 2002 11:19:58 +0200
References: <200207080141.32415.jw@centraltexasit.com>
In-Reply-To: <200207080141.32415.jw@centraltexasit.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_A9BXUPXOIW94GZF93FN4"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--------------Boundary-00=_A9BXUPXOIW94GZF93FN4
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: 

Hi,

this is an SuSE specific problem. You could use follow 2 patches to solve=
 the=20
problem.

cd selinux=20
patch -p0 < utils_libncurses.diff
patch -p0 < utils_makefile_uselargefile.diff

The problem in this package is the missing of libtermcap.so. I think SuSE=
 use=20
libncurses instead and the Makefile recognize this lib correct.

Carsten=20

Am Montag, 8. Juli 2002 08:41 schrieb JW:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> Sorry about the last false alarm, but this is a genuine error.
>
> ccs001:/usr/src/selinux/utils # gcc --version
> 2.95.3
>
>
> make[1]: Leaving directory `/usr/src/selinux/utils/run_init'
> cd util-linux-2.11f && ./configure
>
> configuring util-linux-2.11f
> <snip>
> make[2]: Entering directory
> `/usr/src/selinux/utils/util-linux-2.11f/text-utils' cc -c -O
> -D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE -I../lib -Wall
> -Wmissing-prototypes -Wstrict-prototypes -DNCH=3D1 -I/usr/include/slang
> -D_FILE_OFFSET_BITS=3D64 -DSBINDIR=3D\"/sbin\" -DUSRSBINDIR=3D\"/usr/sb=
in\"
> -DLOGDIR=3D\"/var/log\" -DVARPATH=3D\"/var\" -DLOCALEDIR=3D\"/usr/share=
/locale\"
> -DMOREHELPFILE=3D\"/usr/share/misc/more.help\" more.c -o more.o cc -O
> -D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE -I../lib -Wall
> -Wmissing-prototypes -Wstrict-prototypes -DNCH=3D1 -I/usr/include/slang
> -D_FILE_OFFSET_BITS=3D64 -DSBINDIR=3D\"/sbin\" -DUSRSBINDIR=3D\"/usr/sb=
in\"
> -DLOGDIR=3D\"/var/log\" -DVARPATH=3D\"/var\" -DLOCALEDIR=3D\"/usr/share=
/locale\"
> -DMOREHELPFILE=3D\"/usr/share/misc/more.help\" -s more.o ../lib/xstrncp=
y.o -o
> more more.o: In function `my_putstring':
> more.o(.text+0xe): undefined reference to `putp'
> more.o: In function `my_setupterm':
> more.o(.text+0x36): undefined reference to `setupterm'
> more.o: In function `my_tgetnum':
> more.o(.text+0x4e): undefined reference to `tigetnum'
> more.o: In function `my_tgetflag':
> more.o(.text+0x6e): undefined reference to `tigetflag'
> more.o: In function `my_tgetstr':
> more.o(.text+0x8e): undefined reference to `tigetstr'
> more.o: In function `my_tgoto':
> more.o(.text+0xb6): undefined reference to `tparm'
> more.o: In function `initterm':
> more.o(.text+0x2f56): undefined reference to `PC'
> more.o: In function `reset_tty':
> more.o(.text+0x3819): undefined reference to `tputs'
> collect2: ld returned 1 exit status
> make[2]: *** [more] Error 1
> make[2]: Leaving directory
> `/usr/src/selinux/utils/util-linux-2.11f/text-utils' make[1]: *** [all]
> Error 1
> make[1]: Leaving directory `/usr/src/selinux/utils/util-linux-2.11f'
> make: *** [xutil-linux] Error 2
> ccs001:/usr/src/selinux/utils #
>
> - --
>
> - ----------------------------------------------------
> Jonathan Wilson
> System Administrator
> Cedar Creek Software     http://www.cedarcreeksoftware.com
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.0.6 (GNU/Linux)
> Comment: For info see http://www.gnupg.org
>
> iD8DBQE9KTQcQ5u80xXOLBcRArcOAKDFz34whgRLwZneuNIvSh0Nfsm1LACdFqVy
> 18seIyOH5mWPjQUXP2v+Jac=3D
> =3Doxxq
> -----END PGP SIGNATURE-----

--------------Boundary-00=_A9BXUPXOIW94GZF93FN4
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="utils_makefile_uselargefile.diff"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="utils_makefile_uselargefile.diff"

LS0tIG9sZC91dGlscy9NYWtlZmlsZQlUaHUgTWF5IDMwIDE2OjI5OjU5IDIwMDIKKysrIHV0aWxz
L01ha2VmaWxlCVdlZCBKdW4gIDUgMTM6Mzk6MTEgMjAwMgpAQCAtNTcsNyArNTcsNyBAQAogCXRv
dWNoIHh1dGlsLWxpbnV4LWNvbmZpZwogCiB4dXRpbC1saW51eDogeHV0aWwtbGludXgtY29uZmln
Ci0JJChNQUtFKSAtQyB1dGlsLWxpbnV4LSQoVVRJTExJTlVYX1ZFUikgIk9QVD0tRF9MQVJHRUZJ
TEVfU09VUkNFIC1EX0xBUkdFRklMRTY0X1NPVVJDRSIKKwkkKE1BS0UpIC1DIHV0aWwtbGludXgt
JChVVElMTElOVVhfVkVSKSAiT1BUPS1EX0xBUkdFRklMRV9TT1VSQ0UgLURfTEFSR0VGSUxFNjRf
U09VUkNFIC1EX19VU0VfTEFSR0VGSUxFNjQiCiAKIHhvcGVuc3NoLWNvbmZpZzoKIAljZCBvcGVu
c3NoLSQoT1BFTlNTSF9WRVIpICYmIFwK

--------------Boundary-00=_A9BXUPXOIW94GZF93FN4
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="utils_libncurses.diff"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="utils_libncurses.diff"

LS0tIG9sZC91dGlscy91dGlsLWxpbnV4LTIuMTFmL2NvbmZpZ3VyZQlGcmkgT2N0IDE5IDA0OjE1
OjI2IDIwMDEKKysrIHV0aWxzL3V0aWwtbGludXgtMi4xMWYvY29uZmlndXJlCVRodSBKdW4gIDYg
MTg6Mzg6MTEgMjAwMgpAQCAtMzUxLDYgKzM1MSw3IEBACiAJCWVjaG8gIllvdSBkb24ndCBoYXZl
IHRlcm1jYXAgLSBJIHdpbGwgbm90IG1ha2UgbW9yZS4iCiAJZWxzZQogCQllY2hvICJZb3UgZG9u
J3QgaGF2ZSB0ZXJtY2FwIgorCSAgICAgICAgZWNobyAiTElCVEVSTUNBUD0tbG5jdXJzZXMiID4+
IG1ha2VfaW5jbHVkZQkJCQogCWZpCiBmaQogcm0gLWYgY29uZnRlc3QgY29uZnRlc3QuYwotLS0g
b2xkL3V0aWxzL2ZpbGV1dGlscy00LjEvc3JjL01ha2VmaWxlLmluCVR1ZSBOb3YgMjAgMTU6Mzk6
NTIgMjAwMQorKysgdXRpbHMvZmlsZXV0aWxzLTQuMS9zcmMvTWFrZWZpbGUuaW4JVGh1IEp1biAy
NyAxNDo0Njo0NyAyMDAyCkBAIC0xMzksMTAgKzEzOSwxMCBAQAogREVGUyA9IC1ETE9DQUxFRElS
PVwiJChsb2NhbGVkaXIpXCIgLURTSEFSRURJUj1cIiQoZGF0YWRpcilcIiAtREZMQVNLX0xJTlVY
IEBERUZTQAogTERBREQgPSBASU5UTExJQlNAIC4uL2xpYi9saWJmZXRpc2guYSAvdXNyL2xvY2Fs
L3NlbGludXgvbGliL2xpYnNlY3VyZS5hCiAKLWRpcl9MREFERCA9ICQoTERBREQpIC1sdGVybWNh
cAotbHNfTERBREQgPSAkKExEQUREKSAtbHRlcm1jYXAKK2Rpcl9MREFERCA9ICQoTERBREQpIC1s
bmN1cnNlcworbHNfTERBREQgPSAkKExEQUREKSAtbG5jdXJzZXMKIHNocmVkX0xEQUREID0gJChM
REFERCkKLXZkaXJfTERBREQgPSAkKExEQUREKSAtbHRlcm1jYXAKK3ZkaXJfTERBREQgPSAkKExE
QUREKSAtbG5jdXJzZXMKIAogIyBVc2UgYGdpbnN0YWxsJyBpbiB0aGUgZGVmaW5pdGlvbiBvZiBQ
Uk9HUkFNUyBhbmQgaW4gZGVwZW5kZW5jaWVzIHRvIGF2b2lkCiAjIGNvbmZ1c2lvbiB3aXRoIHRo
ZSBgaW5zdGFsbCcgdGFyZ2V0LiAgVGhlIGluc3RhbGwgcnVsZSB0cmFuc2Zvcm1zIGBnaW5zdGFs
bCcK

--------------Boundary-00=_A9BXUPXOIW94GZF93FN4--

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
