Message-ID: <5502E81C.50208@redhat.com>
Date: Fri, 13 Mar 2015 14:37:32 +0100
From: Petr Lautrbach <plautrba@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov
Subject: Re: [PATCH] Fix -Wformat errors
References: <1426251329-23672-1-git-send-email-plautrba@redhat.com>
 <5502E02C.7060306@tycho.nsa.gov>
In-Reply-To: <5502E02C.7060306@tycho.nsa.gov>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="Frjb8n2M50WWwJP5K34tAR97GtleMMaQ3"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Frjb8n2M50WWwJP5K34tAR97GtleMMaQ3
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/13/2015 02:03 PM, Stephen Smalley wrote:
> On 03/13/2015 08:55 AM, Petr Lautrbach wrote:
>> Fixes two types of errors which appear when building with gcc-5.0.0
>>
>> - format =E2=80=98%d=E2=80=99 expects argument of type =E2=80=98int=E2=
=80=99, but argument X has type =E2=80=98unsigned int=E2=80=99
>> - format =E2=80=98%a=E2=80=99 expects argument of type =E2=80=98float =
*=E2=80=99, but argument X has type =E2=80=98char **=E2=80=99
>=20
> %a is the dynamic allocation conversion specified in glibc, at least
> prior to glibc 2.7, and is available if _GNU_SOURCE is specified (which=

> is set in CFLAGS in libselinux/src/Makefile).  So your change will brea=
k
> on older glibc IIUC.
>=20

%ms format string is already used in
libselinux/utils/sefcontext_compile.c and policycoreutils/hll/pp/pp.c


The other way to fix it would be to use -std=3Dgnu89 everywhere since
gcc-5 defaults to -std=3Dgnu11.

Petr
--
Petr Lautrbach



--Frjb8n2M50WWwJP5K34tAR97GtleMMaQ3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVAuggAAoJEGOorUuYLENztr0P/R2RHdW+dDzLvFY9cGPKoJPk
zwUuBgb2cdsypcli2hfAO5uWHCrHWt+b77ZjjHYTZXRPEHbTOS7A3PkFuq/uNPAA
K80jHqi4blTpMvBEWBSJV3Gm9s4UjDjqonFGZ7QDpyN7of8whOjS0a3d97DMbDlx
iYfaYepqArbIlB5dYgA/hwmikCJbhTPWtr0QH+2uBuVuhR3rAPdfwz0hNAbKZ5DA
aTmmNrnPRiVyIK4g6HSex5lUAvPKrm8lWVMRcHQGQ74tZXZUaOJb6Cxqj9vtPLfE
Cx4CNDwtDi+R5d8fxN1Ul2I8Y2tyhAlgyTI6TJH3svMhKjQJcBqLK+KEKzo4mnLF
r+1s4Ia44uEXDKCiohifYNlWl3uXpnZfJyjG94A+7DxR7sbBCpllEkIM1wrb5yie
FVszEJo6Q1uqSnj6YJbslhyXTkUr4osUCF6Nxtr1RvyqU7gVfowYI4ng7jTmzAnh
rJVTE9a7KetYikpjt5g+5LuPImiqcpuhKFq0oMk4fQXH/6RRrNTSMHw6rEH3d6kY
jTgOrXjrNDiO3uLciA0WuHlTslTOArFHfZ873MKAHV2xlltJMNhFf53eBI7hq5tK
WqdR6GWs9w7Jz5AqE6/qq4K7IrLJwz7gtk5GKlErS2Ue3gkNLhn7YGdDIQm/x6c7
mhpEFaKYJK0AvKa41vaK
=AOX7
-----END PGP SIGNATURE-----

--Frjb8n2M50WWwJP5K34tAR97GtleMMaQ3--
