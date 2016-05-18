Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u4I7vrYI008244
 for <selinux@tycho.nsa.gov>; Wed, 18 May 2016 03:57:53 -0400
Subject: Re: [PATCH] semodule: Fix the --list-modules=full example in the
 manpage
To: Laurent Bigonville <bigon@debian.org>, selinux@tycho.nsa.gov
References: <1463498859-5911-1-git-send-email-bigon@debian.org>
From: Petr Lautrbach <plautrba@redhat.com>
Message-ID: <d0b9cdf7-a58f-5639-805b-721412d1ed76@redhat.com>
Date: Wed, 18 May 2016 09:57:47 +0200
MIME-Version: 1.0
In-Reply-To: <1463498859-5911-1-git-send-email-bigon@debian.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="aQ5W9PrdGWlM9JiQaWAuBBrk4mCqD6lhx"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--aQ5W9PrdGWlM9JiQaWAuBBrk4mCqD6lhx
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 05/17/2016 05:27 PM, Laurent Bigonville wrote:
> From: Laurent Bigonville <bigon@bigon.be>
>=20
> ---
>  policycoreutils/semodule/semodule.8 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/policycoreutils/semodule/semodule.8 b/policycoreutils/semo=
dule/semodule.8
> index 68e95ab..7b07c45 100644
> --- a/policycoreutils/semodule/semodule.8
> +++ b/policycoreutils/semodule/semodule.8
> @@ -116,7 +116,7 @@ $ semodule \-d alsa
>  # Install a module at a specific priority.
>  $ semodule \-X 100 \-i alsa.pp
>  # List all modules.
> -$ semodule \-l full
> +$ semodule \-\-list-modules=3Dfull


It works without " " before full:

$ semodule -lfull

What about:

policycoreutils/semodule/semodule.8:

 .TP
-.B  \-l,\-\-list-modules=3D[KIND]
+.B  \-l[KIND],\-\-list-modules[=3DKIND]
 display list of installed modules (other than base)

 # List all modules.
-$ semodule \-l full
+$ semodule \-lfull
 # Set an alternate path for the policy root


policycoreutils/semodule/semodule.c:

        printf("  -r,--remove=3DMODULE_NAME   remove existing module\n");=

-       printf("  -l,--list-modules=3D[KIND]  display list of installed
modules\n");
+       printf("  -l[KIND],--list-modules[=3DKIND]  display list of
installed modules\n");
        printf("     KIND:  standard  list highest priority, enabled
modules\n");



--=20
Petr Lautrbach



--aQ5W9PrdGWlM9JiQaWAuBBrk4mCqD6lhx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXPCB8AAoJEGOorUuYLENzrxwP/3Nq36Yb2PojjXRvPw45a0cC
w1rg8zC0yoZTprC/dov8udYVgw0YMmjanEyoAO1Q0lf3xJ/RnH6mG4ePemXdUt5F
Lhq7qyxjepUgN0QZQ/lFkj8tg31RZZXxfRwbbRlRvpEeNzRTqMWSDSDpkBpQZxTd
9/45FkJM9T38rbwNoh5+4nxxAqrVZ8vPLUzB6E7UsLFhbEWm/QEeRsrBtabDnIEV
d7EYcbgC1wkxkUEZtyES9vbu4jWfaO2Sd2plgKbmMvJBNEeUff4U4f6iiPhi20HL
4IwIKPW/JB8iXwO/1oY/MIzPi29yxRfG78XKVjgR5aQ2E7XkAzTX5z7Y3jcnGcsR
IpkneRV1tbqfMXXZ9cAji0KjDwECm3C4ynYfULscN2w54BqbxjKxMqm1V7Ulbe8O
BFmV0mI60CZk5BpPd1+ZI75C70WVnrx6AQ9sR5xRwxOZ5wE0eF8PlWx3A+MEJjKa
yxQ2loxSR9HvXZmB5nld1De/9kLDo/YaA1f7gSh/RwXIiXLOXI+hU3jzDo/2Sh1r
50jdooWotAw3b0JOeGyRd5Gnfpm3bwt8fVzH/2Bt5llN5QzfzkpsTJs02OO+zn6Y
3i3vcGK1gurFa6cEnUDZO5I4ic6kKxKFO+XAQCe5TbiY4eiXIfu2P6WxlFGNuc4w
TsGlFnmRrcy8Qvgu+lvd
=mqPL
-----END PGP SIGNATURE-----

--aQ5W9PrdGWlM9JiQaWAuBBrk4mCqD6lhx--
