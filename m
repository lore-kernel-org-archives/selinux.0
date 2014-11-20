Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id sAKFxhBY023902
 for <selinux@tycho.nsa.gov>; Thu, 20 Nov 2014 10:59:43 -0500
Received: by mail-wi0-f175.google.com with SMTP id l15so9211250wiw.8
 for <selinux@tycho.nsa.gov>; Thu, 20 Nov 2014 07:59:41 -0800 (PST)
Received: from e145.network2 ([84.245.1.4])
 by mx.google.com with ESMTPSA id gy4sm4645631wib.11.2014.11.20.07.59.40
 for <selinux@tycho.nsa.gov>
 (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
 Thu, 20 Nov 2014 07:59:40 -0800 (PST)
Date: Thu, 20 Nov 2014 16:59:38 +0100
From: Dominick Grift <dac.override@gmail.com>
To: selinux@tycho.nsa.gov
Subject: Re: [RFC] systemd the userspace object manager
Message-ID: <20141120155937.GA19689@e145.network2>
References: <546B760D.8070407@tresys.com>
 <20141118192010.GA32498@e145.network2>
 <546DF23A.2000300@tresys.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="VbJkn9YxBvnuCH5J"
In-Reply-To: <546DF23A.2000300@tresys.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--VbJkn9YxBvnuCH5J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 20, 2014 at 08:52:58AM -0500, Christopher J. PeBenito wrote:
>=20
> Why would those daemons need to be treated specially?  In the end
> they're still services; they may have special system features, but in
> that case you don't allow just anyone to stop/start them.
>=20

You're probably right. It looks that way, but i suppose the only way to be =
determine is to view the code.
--=20
Dominick Grift

--VbJkn9YxBvnuCH5J
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQGcBAEBCgAGBQJUbg/kAAoJENAR6kfG5xmcXQYMAKaqgf4tCl0oWIqtD0xPxC9v
iE3+xSvnTB3OjGsEW2BJ4Oybb3XmYTkgWVCJ3swpMDZILvipQ6NU/xOD8A5jDXkS
09PKsPmZzCeCqblktu0BjjBX4K2OjhGHJUZbt5Lsh0mvAOBkssWXvAQWij8wi7j+
kT0Pn3Cm6KgIfVOASoLd5xQTkeun2k/8InCeNCmJfsbtpgCj5vmg8j942ov5oftg
dKVXOgFXKjy4O+U9tJ+8EI4W89GlCttVQ+gP7ROWkPHGrbfXqupclekO1HSzqBtb
yRD12FWNJBnwqiKgnVeSGPT+J7wOmhYLQK6RdU+emetKO9alFoJRNqEh1CzzgMJO
vvT3wltD62e29BFiaX1dodwAFCdQ6mmPFknAX/D+OuNJsYL0Lx9g07O/+9rvftkV
UTaImnuhoFh2RF0KFmdEncCayfMjIKfb04SaWj0kgFKdQoeHeB8nNmkL+8sy82zl
9qG0edleoRv0QuxtIpPK9T3VWTyv0yzlPaVjQbEn4g==
=vrYr
-----END PGP SIGNATURE-----

--VbJkn9YxBvnuCH5J--
