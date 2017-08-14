Date: Mon, 14 Aug 2017 19:00:50 +0800
From: Yanhao Mo <yanhaocs@gmail.com>
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov,
 Alexey Dobriyan <adobriyan@gmail.com>,
 Daniel Jurgens <danielj@mellanox.com>, Eric Paris <eparis@parisplace.org>,
 James Morris <james.l.morris@oracle.com>,
 Junil Lee <junil0814.lee@lge.com>, Paul Moore <paul@paul-moore.com>,
 "Serge E. Hallyn" <serge@hallyn.com>, Stephen Smalley <sds@tycho.nsa.gov>,
 William Roberts <william.c.roberts@intel.com>,
 LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
Message-ID: <20170814110048.eqn23wzy6dxbpzsj@sid>
References: <e9f47cc9-fda7-dc54-bca9-cae6488914e0@users.sourceforge.net>
 <b74d176c-b028-7e82-80c6-a3014d57d648@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="66pdskfie4bwia7t"
In-Reply-To: <b74d176c-b028-7e82-80c6-a3014d57d648@users.sourceforge.net>
Subject: Re: [PATCH 4/4] selinux: Adjust five checks for null
 pointers
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--66pdskfie4bwia7t
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 13, 2017 at 04:50:07PM +0200, SF Markus Elfring wrote:
>=20
> Comparison to NULL could be written =E2=80=A6
>=20
> Thus fix affected source code places.

I think this is just a matter of personal preference.

--66pdskfie4bwia7t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEb9bJQfCTGv6uM2+ujv2XAviIsq4FAlmRguAACgkQjv2XAviI
sq5CDw//eewgeM88mhq4cBC4SSRyuyHSeGm3u1x4m/GJHjctfLlcJKu4xfgzxbKa
6CZnwOIZ9fO8kcmw0e1q1gWZ0uyMdsCIgcW1zyX1Dge+dAIcSNdU/Vdt6a5oUmDk
DnDpGCYdNp1nh8CNMRnlMsIkAIx1RsgaXgTntnb28BM/yCMiwdcoxKujBWZZII59
UVV7XoIedaM+cRTN6yZtGAViIIOCZL1kH7J+9d65rdCY2cgCMu56jUrJrN3q1iTY
ZifjThMRodvv4MFvoOk5cmobyuJtPql+NqsGIWRUK4+xpMvY3JHXBeY7yLXP/S45
+97EOEQ5Mbu3hHelsNVpfFqR2QNrVuW8J97uvYJanuFBFUrmJO5fxalETEljxCYH
yXty0HczNLHCJWGUAs0PRZ+u7Y2lMxy3qNk9J9+LUL+KApMsxKAUCfwsnrHYhYsR
vZaWZB/v5OQwG1hE2ElGsWL8TdIGd3T2l4uHPnSq8EG+4mj++tO6mA7zBMWHrNnX
6O2SuBbIM9ZTJG+u30C6KXaWU2dAvHdXuVlS6LS5+m22cpCDrEDwW5A9LWUTn6TY
VInoCSei7k/usPfegKdjQ43pccqbSk/N4yve8J5B5ajPHMV2JSW+tuSg6bl90kTx
ERIkagRt/r9BomAcqM6ksDP2JjROYTnsmjUUVUBtrZBO14CA8mc=
=u+dx
-----END PGP SIGNATURE-----

--66pdskfie4bwia7t--
