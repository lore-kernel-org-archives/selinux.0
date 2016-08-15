Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u7F8qcE8020146
 for <selinux@tycho.nsa.gov>; Mon, 15 Aug 2016 04:52:38 -0400
Received: by mail-wm0-f65.google.com with SMTP id o80so10002569wme.0
 for <selinux@tycho.nsa.gov>; Mon, 15 Aug 2016 01:52:34 -0700 (PDT)
Received: from [84.245.30.81] (84-245-30-81.dsl.cambrium.nl. [84.245.30.81])
 by smtp.gmail.com with ESMTPSA id p83sm15425424wma.18.2016.08.15.01.52.32
 for <selinux@tycho.nsa.gov>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 15 Aug 2016 01:52:33 -0700 (PDT)
Subject: Re: [PATCH 2/2] semanage: default to "s0" if serange empty for port
 modify
To: selinux@tycho.nsa.gov
References: <1471250698-16573-1-git-send-email-mvadkert@redhat.com>
 <1471250698-16573-2-git-send-email-mvadkert@redhat.com>
From: Dominick Grift <dac.override@gmail.com>
Message-ID: <4bc07f02-6fde-fe57-e65b-153b1185e440@gmail.com>
Date: Mon, 15 Aug 2016 10:52:27 +0200
MIME-Version: 1.0
In-Reply-To: <1471250698-16573-2-git-send-email-mvadkert@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="5i6C5q2KPLMKpjv2l9Iu1EogjMCFUqlKA"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--5i6C5q2KPLMKpjv2l9Iu1EogjMCFUqlKA
Content-Type: multipart/mixed; boundary="LDk5B1VF3D3GBEIEsppsPjm9QiLt4TVkM"
From: Dominick Grift <dac.override@gmail.com>
To: selinux@tycho.nsa.gov
Message-ID: <4bc07f02-6fde-fe57-e65b-153b1185e440@gmail.com>
Subject: Re: [PATCH 2/2] semanage: default to "s0" if serange empty for port
 modify
References: <1471250698-16573-1-git-send-email-mvadkert@redhat.com>
 <1471250698-16573-2-git-send-email-mvadkert@redhat.com>
In-Reply-To: <1471250698-16573-2-git-send-email-mvadkert@redhat.com>

--LDk5B1VF3D3GBEIEsppsPjm9QiLt4TVkM
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 08/15/2016 10:44 AM, Miroslav Vadkerti wrote:
> In case serange is empty, but the record is beeing modified
> (setype was supplied), use default "s0" range. With the original
> code the audit event would be printed with no range (i.e.
> "system_u:object_r:ssh_port_t:")
>=20
> Note that default "s0" is currently used in other places
> of seobject.py.
>=20

Note-to-self: when we deal with refpolicy specific identifiers like
system_u remember to also deal with these. Since these are essentially
also refpolicy specific identifiers.

> Signed-off-by: Miroslav Vadkerti <mvadkert@redhat.com>
> ---
>  policycoreutils/semanage/seobject.py | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>=20
> diff --git a/policycoreutils/semanage/seobject.py b/policycoreutils/sem=
anage/seobject.py
> index 538ff0a..a6681f0 100644
> --- a/policycoreutils/semanage/seobject.py
> +++ b/policycoreutils/semanage/seobject.py
> @@ -1161,8 +1161,11 @@ class portRecords(semanageRecords):
> =20
>          con =3D semanage_port_get_con(p)
> =20
> -        if (is_mls_enabled =3D=3D 1) and (serange !=3D ""):
> -            semanage_context_set_mls(self.sh, con, untranslate(serange=
))
> +        if is_mls_enabled =3D=3D 1:
> +            if serange =3D=3D "":
> +                serange =3D "s0"
> +            else:
> +                semanage_context_set_mls(self.sh, con, untranslate(ser=
ange))
>          if setype !=3D "":
>              semanage_context_set_type(self.sh, con, setype)
> =20
>=20


--=20
Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B02
https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B6B0=
2
Dominick Grift


--LDk5B1VF3D3GBEIEsppsPjm9QiLt4TVkM--

--5i6C5q2KPLMKpjv2l9Iu1EogjMCFUqlKA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQGcBAEBCAAGBQJXsYLMAAoJECV0jlU3+UdpofcL/iPP+0wCwP7CTKgOa+X4DYLt
oiRetY23bYnYVmO8H2HVleqZQbxeKK49Ee0u2MPtr+d0nSodAMSVAcMByCf74Y48
PULl+spAc58UfqJe6BrvK/wwaRUgAYC10BHNeTbtjNvFoXSIg5tv+DHFrW+pDAap
AkOVdHozW2ja9+SpnlhIzHSBtaSXYqkxroNnzds54jP4nOaDENaJQIl5JiDxb+DU
2/hHQ4RZQ0B1oCo5p3OtZy6JC7ub1Juqhwldqv38c6/sbzsodL/0K7BGi3LVsJYF
+7MOhNJR42C0gXlhit8Jmk17JnANpSRCf6N4078b0aS1Xs5bBZpGVB6IPCnPLBT3
JcAdFplsyJFI7WLSFdzhvtPJSz+c0XGn0JgNbQ1R0i0MSyTT9Z45elfUL2OGxDa8
VNAlnKMICMF8VqcT388zRp4IfHdRb5bmuOrBvW2ddFWro8jpW/R8mKa2u1Znvs20
phfcEKmxaBngVaPYqrquhrDvsZ1ICguKZq3VigsQuw==
=GrKk
-----END PGP SIGNATURE-----

--5i6C5q2KPLMKpjv2l9Iu1EogjMCFUqlKA--
