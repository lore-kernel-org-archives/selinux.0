Subject: Re: [PATCH] libsemanage: genhomedircon: only set MLS level if MLS is
 enabled
To: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov
References: <1476466802-8500-1-git-send-email-sds@tycho.nsa.gov>
From: Dominick Grift <dac.override@gmail.com>
Message-ID: <cdda0ea5-0753-05a4-69c4-b28ecf19e214@gmail.com>
Date: Fri, 14 Oct 2016 20:52:46 +0200
MIME-Version: 1.0
In-Reply-To: <1476466802-8500-1-git-send-email-sds@tycho.nsa.gov>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="23tQRGJE8BWJuQsVoggOGEB6CeHR7ttvN"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--23tQRGJE8BWJuQsVoggOGEB6CeHR7ttvN
Content-Type: multipart/mixed; boundary="vQTqNQF1Imcvr5wgLmHXV5UsueDAKsc78";
 protected-headers="v1"
From: Dominick Grift <dac.override@gmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov
Cc: gary.tierney@gmx.com
Message-ID: <cdda0ea5-0753-05a4-69c4-b28ecf19e214@gmail.com>
Subject: Re: [PATCH] libsemanage: genhomedircon: only set MLS level if MLS is
 enabled
References: <1476466802-8500-1-git-send-email-sds@tycho.nsa.gov>
In-Reply-To: <1476466802-8500-1-git-send-email-sds@tycho.nsa.gov>

--vQTqNQF1Imcvr5wgLmHXV5UsueDAKsc78
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 10/14/2016 07:40 PM, Stephen Smalley wrote:
> When a non-MLS policy was used with genhomedircon context_from_record()=

> in sepol would report an error because an MLS level was present when ML=
S
> is disabled.  Based on a patch by Gary Tierney, amended to use
> sepol_policydb_mls_enabled rather than semanage_mls_enabled because
> we are testing the temporary working policy, not the active policy.
>=20
> Reported-by: Jason Zaman <jason@perfinion.com>
> Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
> ---
>  libsemanage/src/genhomedircon.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>=20
> diff --git a/libsemanage/src/genhomedircon.c b/libsemanage/src/genhomed=
ircon.c
> index 6991fff..5e9d722 100644
> --- a/libsemanage/src/genhomedircon.c
> +++ b/libsemanage/src/genhomedircon.c
> @@ -638,7 +638,11 @@ static int write_contexts(genhomedircon_settings_t=
 *s, FILE *out,
>  			goto fail;
>  		}
> =20
> -		if (sepol_context_set_user(sepolh, context, user->sename) < 0 ||
> +		if (sepol_context_set_user(sepolh, context, user->sename) < 0) {
> +			goto fail;
> +		}
> +
> +		if (sepol_policydb_mls_enabled(s->policydb) &&
>  		    sepol_context_set_mls(sepolh, context, user->level) < 0) {
>  			goto fail;
>  		}
>=20

I could not get this to work:

libsemanage.validate_handler: seuser mapping [kcinimod -> (wheel.id,
s0-s0:c0.c1023)] is invalid (No such file or directory).
libsemanage.dbase_llist_iterate: could not iterate over records (No such
file or directory)
semodule: failed!

--=20
Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B02
https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B6B0=
2
Dominick Grift


--vQTqNQF1Imcvr5wgLmHXV5UsueDAKsc78--

--23tQRGJE8BWJuQsVoggOGEB6CeHR7ttvN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQGcBAEBCAAGBQJYASl/AAoJECV0jlU3+UdpfhIL/idJScgNrV4+ssDBCkdyp5mF
5AcwIxKyNuRKxIgZk1RErvmQYiN/+P7Sh8cXdK1i6q62kSKKZJL9dvr+zs/qz2TR
VV2+uDc0x7iGH3qOE/DJYie+RtLMDQY/q920cmdwotQszB7m33b5HpQG3eSx3VPp
wymx+WYXc7PkIszUMeCYdH77OiVb5waXuRkHqdtTi19TzMl3UPxThoYrvrFguNdS
nPS/i9sTWNgR706jo0+U3IjxpVsnEM2SIdcRAUFLs9UId7WN7Qn5QUpC7LDiQOWy
UBEnusCH+juQjc7CgCVq0p5XYyka2BrFYSsTZbN9o7HcWyxNPQFcbEyO4SBhA8g5
acK29oQhSN85pMD8KNLM+B9sMZLvn+9XL5M6mxavPiHYfS4McMn42yx1hCZQ9ZSV
JmcVYPM4xSRvLdtPV49Td3dpHIItgocvsHpKgD/Qd70g6XE3xFU8daTLhNVX1Mec
zGqPyFHO6tUWzpLdTbAIISc6aI1VWWDwuByr2X9eWg==
=vIJB
-----END PGP SIGNATURE-----

--23tQRGJE8BWJuQsVoggOGEB6CeHR7ttvN--
