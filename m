Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id uA974x7e022716
 for <selinux@tycho.nsa.gov>; Wed, 9 Nov 2016 02:05:00 -0500
Received: by mail-wm0-f68.google.com with SMTP id a20so16492943wme.2
 for <selinux@tycho.nsa.gov>; Tue, 08 Nov 2016 23:04:58 -0800 (PST)
Date: Wed, 9 Nov 2016 09:04:55 +0200
From: Leon Romanovsky <leonro@mellanox.com>
To: Dan Jurgens <danielj@mellanox.com>
Cc: chrisw@sous-sol.org, paul@paul-moore.com, sds@tycho.nsa.gov,
 eparis@parisplace.org, dledford@redhat.com, sean.hefty@intel.com,
 hal.rosenstock@gmail.com, selinux@tycho.nsa.gov,
 linux-security-module@vger.kernel.org, linux-rdma@vger.kernel.org,
 yevgenyp@mellanox.com, liranl@mellanox.com
Subject: Re: [PATCH v4 9/9] selinux: Add a cache for quicker retreival of
 PKey SIDs
Message-ID: <20161109070455.GF27883@leon.nu>
References: <1478639185-47521-1-git-send-email-danielj@mellanox.com>
 <1478639185-47521-10-git-send-email-danielj@mellanox.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="3oCie2+XPXTnK5a5"
In-Reply-To: <1478639185-47521-10-git-send-email-danielj@mellanox.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--3oCie2+XPXTnK5a5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 08, 2016 at 11:06:25PM +0200, Dan Jurgens wrote:
> From: Daniel Jurgens <danielj@mellanox.com>
>
> It is likely that the SID for the same PKey will be requested many
> times. To reduce the time to modify QPs and process MADs use a cache to
> store PKey SIDs.
>
> This code is heavily based on the "netif" and "netport" concept
> originally developed by James Morris <jmorris@redhat.com> and Paul Moore
> <paul@paul-moore.com> (see security/selinux/netif.c and
> security/selinux/netport.c for more information)
>
> issue: 736423
> Change-Id: I176c3079d5d84d06839b4f750100ac47a6081e94

It doesn't belong to commit message.

> Signed-off-by: Daniel Jurgens <danielj@mellanox.com>

--3oCie2+XPXTnK5a5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJYIsqXAAoJEORje4g2clintVwP/jLkWFgE/+kE9TMZszjjEkGX
acV1ZHDEFIdsatLztMqsdAD9hMvnMpGTOB/0EmMmIeVePkdPSTZRKo7ts+RCfu07
eZeN3UuCrZ1z4uvC7CREAPsv0q5XUU3Z5jbINNHQIsCte3bJN6xFjAJcdHhBhPPr
R4od1JNyG1ZlXiYRUIYhwzXnRPePEoQeEwVivAlrMjdcgPu4U4j0T3nlR4QAJb8G
m2+CmZD/VneCzDJTZkhePbJoDVUkvUFUFLbd3MXSNBrYRDvb0nPypfGhzgLTldLQ
V9+R0cIelrdG/FNj1J8+YAeOphav9sS2j8p76cY+5hjlx1IzOJCKQB5UEqT5j21X
9wq1ODXUmlYJ0KwoftLnk16yrTEJZzYK42NStZw3Y50ID8vuBRVkhDgC99Nsv6v+
mM2LIoKKSB+yFgC33EaKPIewaieEpVuBHJP80AyfqiHtyU4IhOFUlSaVW7J1Bz5G
v4/mISojGL56BCfJDD3WF6sOSOHRZCsaqlRSr1RCa0glvmGcm44OwRifGFsLIyhW
sdxwCqHZhO63dfLbr06B0sEnzCRbaPGNrq89DqgxqYK6U+uuNaNI3l/OJgOx4Dn2
FUYMLRO/QBw2jKWD5Gvog9TyAIDsjm2pMaVUkC/3QEDJVG8hxx5JhTo2osoKA3ZY
LTnUr+G3ov2qdtNyYkXj
=uWFs
-----END PGP SIGNATURE-----

--3oCie2+XPXTnK5a5--
