Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j6T4IPgA027432
	for <selinux@tycho.nsa.gov>; Fri, 29 Jul 2005 00:18:27 -0400 (EDT)
Received: from estila.tuxedo-es.org (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j6T4CWC2029946
	for <selinux@tycho.nsa.gov>; Fri, 29 Jul 2005 04:12:33 GMT
Subject: Re: SELinux for embedded devices...
From: Lorenzo =?ISO-8859-1?Q?Hern=E1ndez_?= =?ISO-8859-1?Q?Garc=EDa-Hierro?= <lorenzo@gnu.org>
To: "Sriram, Kannan" <ksriram@ti.com>
Cc: SELinux Mail List <selinux@tycho.nsa.gov>
In-Reply-To: <45F366B1BC4F7C4A895F0F34C41E61A5511366@dbde01.ent.ti.com>
References: <45F366B1BC4F7C4A895F0F34C41E61A5511366@dbde01.ent.ti.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-gJ+WIOivhhvf5SBVyf6b"
Date: Fri, 29 Jul 2005 06:12:29 +0200
Message-Id: <1122610349.14844.21.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-gJ+WIOivhhvf5SBVyf6b
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

El vie, 29-07-2005 a las 07:50 +0530, Sriram, Kannan escribi=F3:
> Hello all,
>=20
>  I'm a newbie to SELinux, trying to figure out if SELinux is applicable/
> suitable to embedded system security, especially mobile terminals/
> smartphones. I have the following very basic questions... Pls help me
> out, or redirect me to the appropriate forum.
>=20
> 1. Is SELinux applicable and suitable for mobile equipment, where the
> end user always has root privileges? Has SELinux been ported to any
> embedded device yet (some ARM platform??).

SELinux itself doesn't need to be ported to ARM processors, but the
file-systems in which the labeling relies.

The problem of NAND flash chips and other flash memory components is
that they have a limited writable times. Hence, the use of specific file
systems is needed in order to *not* reach such limit in a short period
of time.

Currently, there's a problem about this. Maybe you can think on ext3,
XFS, etc, and all of those nice "bullet-proof" file-systems with
journaling. The problem is that, such file-systems make an exhaustive
use of the memory/storage device they are running on with each
operation, reaching the limit of writes and thus turning the flash
memory chip unusable.

There are file systems specifically designed to be "small" and efficient
on these scenarios. Notable examples are JFFS2 and the
still-under-design JFFS3 maintained by the Linux-MTD project.

I was working on the design of extended attributes for JFFS2 (in which
SELinux relies for labeling file-system objects), even got help from an
Intel guy, but I got stuck at it, without any resources for testing, and
the Intel guy who was willing to work together with me was requested for
legal approbation before doing anything. Thus, time passed and I
couldn't go a step further on doing anything serious about it.

Someday I may re-start the little project, but that's unlikely to happen
until I get the needed time and resources for testing, designing and
implementing this.

> 2. Assuming I have made the kernel on the flash to be tamperproof (can't
> replace the SElinux image on the flash with the "SE" part disabled),
> isn't  it still possible at runtime to disable the security server?

If correctly configured policy and enforcement mode turned on present,
"de-activating the SS" (more like going into permissive mode or just
disabling SELinux at runtime via selinuxfs) wont be possible.

Also, what do you mean my "tamper-proof" in this context? Physically
protecting the chip which serves as storage for it? That sounds strange.

> 3. Same as above, is it possible to change the security policy files, or
> reload a different set of policies (given root access).

Under SELinux root is just another user with access to certain roles. Be
them user_r or sysadm_r, doesn't matter, it's all your choice and you
can turn root into a non privileged user.

> And now the big question, is there a way to prevent both (2) and (3)??
> Or have I completely misunderstood the whole thing??

On 2 and 3, SELinux stuff with correct configuration (policy,
enforcement mode by default, etc), you would prevent both. In any case,
physical protection of the storage media is more important.

Just think if someone with access to the proper resources (ie. anyone
studying an electrical engineering degree or with some knowledge on the
field and money to waste) could dump an image of the flash memory chip
after de-assembling it form the circuit, and post-analyzing the obtained
data? Neither SELinux nor file-system labeling will be able to do
anything against that. Many times these methods are used to
reverse-engineer firmware and the like.

I hope it helped.

Cheers,
--=20
Lorenzo Hern=E1ndez Garc=EDa-Hierro <lorenzo@gnu.org>
[1024D/6F2B2DEC] & [2048g/9AE91A22][http://tuxedo-es.org]

--=-gJ+WIOivhhvf5SBVyf6b
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBC6aysDcEopW8rLewRAuXzAJ4vqD5FHTM7havJGgCXugM5EE9l3ACfXBd0
tDoIY+7+KLXUcSd4lBNyfXQ=
=WUgB
-----END PGP SIGNATURE-----

--=-gJ+WIOivhhvf5SBVyf6b--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
