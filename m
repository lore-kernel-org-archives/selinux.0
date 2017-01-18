Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v0IKxCn4029249
 for <selinux@tycho.nsa.gov>; Wed, 18 Jan 2017 15:59:12 -0500
Received: by mail-lf0-f68.google.com with SMTP id v186so3309619lfa.2
 for <selinux@tycho.nsa.gov>; Wed, 18 Jan 2017 12:58:50 -0800 (PST)
Received: from [192.168.1.21] (84-245-30-81.dsl.cambrium.nl. [84.245.30.81])
 by smtp.gmail.com with ESMTPSA id h23sm816735lji.34.2017.01.18.12.58.47
 for <selinux@tycho.nsa.gov>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 18 Jan 2017 12:58:47 -0800 (PST)
Subject: Re: [PATCH] checkpolicy: Fix bug in handling type declaration in
 optional block.
To: selinux@tycho.nsa.gov
References: <1484772829-15960-1-git-send-email-jwcart2@tycho.nsa.gov>
From: Dominick Grift <dac.override@gmail.com>
Message-ID: <02cc173e-2a1a-3e7c-5de8-639b82585610@gmail.com>
Date: Wed, 18 Jan 2017 21:58:36 +0100
MIME-Version: 1.0
In-Reply-To: <1484772829-15960-1-git-send-email-jwcart2@tycho.nsa.gov>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="DdhliUtVHPqenM7LbWSwbAUBCGpPUxXGI"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--DdhliUtVHPqenM7LbWSwbAUBCGpPUxXGI
Content-Type: multipart/mixed; boundary="emvGFe9jktqBgt6BqB1l2HuiBGpVUF4Vb";
 protected-headers="v1"
From: Dominick Grift <dac.override@gmail.com>
To: selinux@tycho.nsa.gov
Message-ID: <02cc173e-2a1a-3e7c-5de8-639b82585610@gmail.com>
Subject: Re: [PATCH] checkpolicy: Fix bug in handling type declaration in
 optional block.
References: <1484772829-15960-1-git-send-email-jwcart2@tycho.nsa.gov>
In-Reply-To: <1484772829-15960-1-git-send-email-jwcart2@tycho.nsa.gov>

--emvGFe9jktqBgt6BqB1l2HuiBGpVUF4Vb
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 01/18/2017 09:53 PM, James Carter wrote:
> Nicolas Iooss discovered that requiring a type in an optional block
> after the type has already been declared in another optional block
> results in a duplicate declaration error.
>=20

from what i have been told and from experience, types cannot, reliably,
be declared in optional blocks.

if the above is true, then the compiler should not allow one to declare
a type in an optional block in the first place

> The following policy will trigger the error.
>=20
> optional {
>   type T1;
> }
>=20
> optional {
>   require { type T1; }
> }
>=20
> In this case, although symtab_insert() in libsepol properly identifies
> that the first T1 is a declaration while the second is a require, it
> will return -2 which is the return value for a duplicate declaration
> and expect the calling code to properly handle the situation. The
> caller is require_symbol() in checkpolicy and it checks if the previous=

> declaration is in the current scope. If it is, then the require can be
> ignored. It also checks to see if the declaration is a type and the
> require an attribute or vice versa which is an error. The problem is
> that -2 is returned if the declaration is not in scope which is
> interpreted as a duplicate declaration error.
>=20
> The function should return 1 instead which means that they symbol was n=
ot
> added and needs to be freed later.
>=20
> Signed-off-by: James Carter <jwcart2@tycho.nsa.gov>
> ---
>  checkpolicy/module_compiler.c | 16 +++-------------
>  1 file changed, 3 insertions(+), 13 deletions(-)
>=20
> diff --git a/checkpolicy/module_compiler.c b/checkpolicy/module_compile=
r.c
> index 6e5483c..bb60f34 100644
> --- a/checkpolicy/module_compiler.c
> +++ b/checkpolicy/module_compiler.c
> @@ -647,7 +647,6 @@ int require_symbol(uint32_t symbol_type,
>  	} else if (retval =3D=3D -2) {
>  		/* ignore require statements if that symbol was
>  		 * previously declared and is in current scope */
> -		int prev_declaration_ok =3D 0;
>  		if (is_id_in_scope(symbol_type, key)) {
>  			if (symbol_type =3D=3D SYM_TYPES) {
>  				/* check that previous symbol has same
> @@ -661,23 +660,14 @@ int require_symbol(uint32_t symbol_type,
>  								    table, key);
>  				assert(old_datum !=3D NULL);
>  				unsigned char old_isattr =3D old_datum->flavor;
> -				prev_declaration_ok =3D
> -				    (old_isattr =3D=3D new_isattr ? 1 : 0);
> -			} else {
> -				prev_declaration_ok =3D 1;
> +				if (old_isattr !=3D new_isattr)
> +					return -2;
>  			}
> -		}
> -		if (prev_declaration_ok) {
>  			/* ignore this require statement because it
>  			 * was already declared within my scope */
>  			stack_top->require_given =3D 1;
> -			return 1;
> -		} else {
> -			/* previous declaration was not in scope or
> -			 * had a mismatched type/attribute, so
> -			 * generate an error */
> -			return -2;
>  		}
> +		return 1;
>  	} else if (retval < 0) {
>  		return -3;
>  	} else {		/* fall through possible if retval is 0 or 1 */
>=20


--=20
Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B02
https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B6B0=
2
Dominick Grift


--emvGFe9jktqBgt6BqB1l2HuiBGpVUF4Vb--

--DdhliUtVHPqenM7LbWSwbAUBCGpPUxXGI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQGcBAEBCAAGBQJYf9cBAAoJECV0jlU3+UdpoZcMAJbUbqfmkdu9gyFgwYY2RH0s
jf2qGpmVza+NJGLyg3wcKHUgNdELTayJb99S5HljQQtOhO+GE7UuRtY4hkLq2ayX
2a/Kjvz/M9w36uXYiogQCs/fscMDfw/WSOaq6/NuLfvPjbGXEL9uqxnObDXHH+92
jfnV92SD5D2G9HuWmquutHfIJrkgnWWEDj04nOf4po1IlHMbk2EHaTbgIvzTHPCQ
FMfhWa3jLNq4nTovQV/Gvn3IRMMzDgWadFUAz4NfRHnvdO+9BQWR8jxJobCMTZV3
fHW87XZelbtnhprVHIAup5y+bAsKtPqgGrEVpq44OOOJ3ze+ccLgQNDenBOe/zvB
oT0RXFYdHZXXDC421RNyJcRl9ueMiTxyMUei/Z7dG7oMQX8v+j6uJGH35vsREoTz
I6w4QxZWjVaQdja1gf7rCnK5P1IL0BJC01nKxsLI1dlQDIQMnBb0xvKaR1QgLAzM
EyJBMlcAYYyVxITBPZsjxEGTLPKYPRChUXkfJDLvJg==
=Vu2r
-----END PGP SIGNATURE-----

--DdhliUtVHPqenM7LbWSwbAUBCGpPUxXGI--
