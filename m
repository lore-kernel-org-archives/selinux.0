Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id uBT9UgUu032509
 for <selinux@tycho.nsa.gov>; Thu, 29 Dec 2016 04:30:42 -0500
Received: by mail-wm0-f47.google.com with SMTP id m1so30585920wme.0
 for <selinux@tycho.nsa.gov>; Thu, 29 Dec 2016 01:30:38 -0800 (PST)
Received: from [192.168.1.21] (84-245-30-81.dsl.cambrium.nl. [84.245.30.81])
 by smtp.gmail.com with ESMTPSA id d85sm64747768wmd.17.2016.12.29.01.30.35
 for <selinux@tycho.nsa.gov>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 29 Dec 2016 01:30:36 -0800 (PST)
Subject: Re: libsemanage: special handling of the identity reserved to system
 objects
To: selinux@tycho.nsa.gov
References: <1482966318.30976.5.camel@trentalancia.net>
From: Dominick Grift <dac.override@gmail.com>
Message-ID: <dba3b2de-d089-8719-9f0c-f8da0ff9b7e9@gmail.com>
Date: Thu, 29 Dec 2016 10:30:22 +0100
MIME-Version: 1.0
In-Reply-To: <1482966318.30976.5.camel@trentalancia.net>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="blaIEfsaXcX3PvOdjEGpniLHrAKCQbDch"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--blaIEfsaXcX3PvOdjEGpniLHrAKCQbDch
Content-Type: multipart/mixed; boundary="mVRHbWF32Clq7WCxQ1HewFPaCGLeJLCNW";
 protected-headers="v1"
From: Dominick Grift <dac.override@gmail.com>
To: selinux@tycho.nsa.gov
Message-ID: <dba3b2de-d089-8719-9f0c-f8da0ff9b7e9@gmail.com>
Subject: Re: libsemanage: special handling of the identity reserved to system
 objects
References: <1482966318.30976.5.camel@trentalancia.net>
In-Reply-To: <1482966318.30976.5.camel@trentalancia.net>

--mVRHbWF32Clq7WCxQ1HewFPaCGLeJLCNW
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 12/29/2016 12:05 AM, Guido Trentalancia wrote:
> The following patch makes sure that the SELinux identity
> reserved for system processes and objects is skipped
> when adding users and that no prefix is associated to it.
>=20
> A warning is produced when a Unix identity is found to be
> equal to the SELinux user identity for system processes
> and objects.
>=20
> Signed-off-by: Guido Trentalancia <guido@trentalancia.net>
> ---
>  include/semanage/user_record.h |    2 ++
>  src/genhomedircon.c            |   20 ++++++++++++++++----
>  src/user_record.c              |   15 ++++++++++++---
>  3 files changed, 30 insertions(+), 7 deletions(-)
>=20
> diff -pru libsemanage-2.6-orig/include/semanage/user_record.h libsemana=
ge-2.6/include/semanage/user_record.h
> --- libsemanage-2.6-orig/include/semanage/user_record.h	2016-10-14 17:3=
1:26.000000000 +0200
> +++ libsemanage-2.6/include/semanage/user_record.h	2016-12-28 23:22:50.=
848589870 +0100
> @@ -6,6 +6,8 @@
>  #include <stddef.h>
>  #include <semanage/handle.h>
> =20
> +#define SYS_OBJECTS_USERID	"system_u"

SELinux is supposed to be a flexible and customizable framework that
allow for fine-grained mandatory access control.

hard-coding customizable identifiers is frowned upon by some of us

> +
>  struct semanage_user;
>  typedef struct semanage_user semanage_user_t;
> =20
> diff -pru libsemanage-2.6-orig/src/genhomedircon.c libsemanage-2.6/src/=
genhomedircon.c
> --- libsemanage-2.6-orig/src/genhomedircon.c	2016-10-14 17:31:26.000000=
000 +0200
> +++ libsemanage-2.6/src/genhomedircon.c	2016-12-28 23:34:38.510319855 +=
0100
> @@ -998,14 +998,26 @@ static int add_user(genhomedircon_settin
>  		homedir_role =3D prefix;
>  	}
> =20
> +	/* There should be no Unix identity corresponding
> +	 * to SELinux user reserved for system processes
> +	 * and objects */
>  	retval =3D getpwnam_r(name, &pwstorage, rbuf, rbuflen, &pwent);
> -	if (retval !=3D 0 || pwent =3D=3D NULL) {
> -		if (retval !=3D 0 && retval !=3D ENOENT) {
> +	if (strcmp(name, SYS_OBJECTS_USERID)) {
> +		if (retval !=3D 0 || pwent =3D=3D NULL) {
> +			if (retval !=3D 0 && retval !=3D ENOENT) {
> +				goto cleanup;
> +			}
> +
> +			WARN(s->h_semanage,
> +			     "user %s not in password file", name);
> +			retval =3D STATUS_SUCCESS;
>  			goto cleanup;
>  		}
> +	} else {
> +		if (retval)
> +			WARN(s->h_semanage,
> +			     "There should be no Unix identity \"%s\" !", SYS_OBJECTS_USERI=
D);
> =20
> -		WARN(s->h_semanage,
> -		     "user %s not in password file", name);
>  		retval =3D STATUS_SUCCESS;
>  		goto cleanup;
>  	}
> diff -pru libsemanage-2.6-orig/src/user_record.c libsemanage-2.6/src/us=
er_record.c
> --- libsemanage-2.6-orig/src/user_record.c	2016-10-14 17:31:26.00000000=
0 +0200
> +++ libsemanage-2.6/src/user_record.c	2016-12-28 23:30:51.544449423 +01=
00
> @@ -348,9 +348,18 @@ hidden int semanage_user_join(semanage_h
>  		if (semanage_user_extra_set_name(handle, tmp_user->extra, name)
>  		    < 0)
>  			goto err;
> -		if (semanage_user_extra_set_prefix
> -		    (handle, tmp_user->extra, "user") < 0)
> -			goto err;
> +
> +		/* The user identity reserved for system processes
> +		 * and objects shall have no prefix */
> +		if (strcmp(name, SYS_OBJECTS_USERID)) {
> +			if (semanage_user_extra_set_prefix
> +			    (handle, tmp_user->extra, "user") < 0)
> +				goto err;
> +		} else {
> +			if (semanage_user_extra_set_prefix
> +			    (handle, tmp_user->extra, "") < 0)
> +				goto err;
> +		}
>  	}
> =20
>  	if (semanage_user_set_name(handle, tmp_user, name) < 0)
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho.n=
sa.gov.
>=20


--=20
Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B02
https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B6B0=
2
Dominick Grift


--mVRHbWF32Clq7WCxQ1HewFPaCGLeJLCNW--

--blaIEfsaXcX3PvOdjEGpniLHrAKCQbDch
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQGcBAEBCAAGBQJYZNe2AAoJECV0jlU3+UdpxqsL/0XkPuJu8/QhmxEnajR2H4zf
hGE8aprKlbJYTUymAIXNmGYewVef55mFRnDGT//OTPOwIaSJQIL2ya+3kz6JuAkR
6eaYjzN6plDtPFnoAYv6YTUlOZd8uS1CfDgOcx1xh+nD1pJsny9sT24OmfDKu1lv
Y2PmKcl9k46PxlixN1r/l3CA8MoNVL9zgerh5hPKaltZTyCfWNwnKW/TE2n9N51Q
eO9YyTy3qrVroOgv8VSdg2SxYdW7zyUu9zJGPSu3D3PaRXvZqWohL/LdqOBHxVly
S/bYdBXkHfFokylKWx9NuumryRbnIZKf+E0GfEbUrAlxpHagiwNKsg5FHPB9h+HD
QinuHnuvoUqSaDlDzc/inOoUlJ4F2VE7GM9v7TxZDiyq5cFXSjgzcH8JXHTJyZin
1haecLhaUtDtGThbZLj6Zze40Im138lYrslzLrHvdF8se/UwymcdKW1DWMHfA19n
DF8Yt8q0vnXsrKeYRw391oQbyQcQPV8HRl4Qen3Kdg==
=f2fw
-----END PGP SIGNATURE-----

--blaIEfsaXcX3PvOdjEGpniLHrAKCQbDch--
