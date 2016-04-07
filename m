Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u37KsLPG009955
 for <selinux@tycho.nsa.gov>; Thu, 7 Apr 2016 16:54:22 -0400
Received: by mail-ig0-f194.google.com with SMTP id nt3so13772647igb.0
 for <selinux@tycho.nsa.gov>; Thu, 07 Apr 2016 13:54:19 -0700 (PDT)
Date: Thu, 7 Apr 2016 23:53:06 +0300
From: Leon Romanovsky <leon@leon.nu>
To: Dan Jurgens <danielj@mellanox.com>
Cc: selinux@tycho.nsa.gov, linux-security-module@vger.kernel.org,
 linux-rdma@vger.kernel.org, yevgenyp@mellanox.com
Subject: Re: [RFC PATCH v2 12/13] ib/core: Track which QPs are using which
 port and PKey index
Message-ID: <20160407205306.GC12844@leon.nu>
Reply-To: leon@leon.nu
References: <1459985638-37233-1-git-send-email-danielj@mellanox.com>
 <1459985638-37233-13-git-send-email-danielj@mellanox.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="bAmEntskrkuBymla"
In-Reply-To: <1459985638-37233-13-git-send-email-danielj@mellanox.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--bAmEntskrkuBymla
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 07, 2016 at 02:33:57AM +0300, Dan Jurgens wrote:
> From: Daniel Jurgens <danielj@mellanox.com>
>=20
> --- a/drivers/infiniband/core/core_security.c
> +++ b/drivers/infiniband/core/core_security.c
> @@ -1,4 +1,5 @@
> -/*
> +/* NEW COMMIT TO INSERT INTO REBASE

^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Irrelevant

> + *
>   * Copyright (c) 2016 Mellanox Technologies Ltd.  All rights reserved.
>   *
>   * This software is available to you under a choice of one of two
> @@ -33,11 +34,27 @@
>  #ifdef CONFIG_SECURITY_INFINIBAND
> =20

--bAmEntskrkuBymla
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXBsixAAoJEORje4g2clinWNYP/iwtsNFvzAju4ertHHuFxBRN
Ca4bdKtB/G/UZdZLISlWn5rtwpFLyQaUep/vjb+Kd1ooRq8qLfA4eBPwjJp47CL7
9rD3KnKKi5P1WtTO4Tvto8obnU0k2Uanv/uPUpc30gA+GShVfHtf85PGOOcBlzqU
iOA03O2vfRIr7l0zvlGV7nmaMwmLLJmkepA3uKuRL/YlzWSHVMLKGn+ohXniQpja
bHwVL1Bb2Lqusnra3g6HjoP2lLtXR1eLlhg2BdnmTdo/J+kCXehba4ttlkGlvIo4
A4Yb4SSvf8GcFauKP9vKQ7rnyV0xj7vBJF7guiDqs3mpSfWZKkmQAXQzJYjY+wCE
QWk6JXaDi16aYwcQbcNhR/F3YD2g+53N7GvDBWyHWo3On83Pt4yE9Fvfry5YKh2Q
1PsH4vTm4/LPGeIaZUxGJw+pOAM+/81GeE1NEizBdmVujxHMJtcLtPgi5XwUa3+X
EoiawKx8jW8LmRK2tj7uktHPl+FQ4P957aVqVZv24eRROgKkWZ/S/x9Sj7fpKJHA
vNq4qiI1gE5F/EguvbjGVYDitMRU6V3OLg5cbYLOMBxl1RtD9c9cL4I/gKSmhkzA
CoVxZCpOlwFGy74Tk8W+BrIfmljqupqa02vYeoxHxSO8uLJjBXp2JTkv7KrkcCe+
aX4Xp4hiZPbeioe3CEpz
=b9wn
-----END PGP SIGNATURE-----

--bAmEntskrkuBymla--
