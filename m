Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u7IBpTp0014457
 for <selinux@tycho.nsa.gov>; Thu, 18 Aug 2016 07:51:29 -0400
Received: by mail-wm0-f65.google.com with SMTP id i5so5276371wmg.2
 for <selinux@tycho.nsa.gov>; Thu, 18 Aug 2016 04:51:26 -0700 (PDT)
Received: from [192.168.1.21] (84-245-30-81.dsl.cambrium.nl. [84.245.30.81])
 by smtp.gmail.com with ESMTPSA id jd4sm1919050wjb.6.2016.08.18.04.51.24
 for <selinux@tycho.nsa.gov>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 18 Aug 2016 04:51:24 -0700 (PDT)
Subject: Re: [PATCH] semanage: fix error message for fcontext -m
To: selinux@tycho.nsa.gov
References: <1471519081-26417-1-git-send-email-mvadkert@redhat.com>
From: Dominick Grift <dac.override@gmail.com>
Message-ID: <a910016c-e086-cb75-464b-a17b992167e8@gmail.com>
Date: Thu, 18 Aug 2016 13:51:14 +0200
MIME-Version: 1.0
In-Reply-To: <1471519081-26417-1-git-send-email-mvadkert@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="qxbK2CWBLVDgs9ESOFjfbs1TnIoIesea1"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--qxbK2CWBLVDgs9ESOFjfbs1TnIoIesea1
Content-Type: multipart/mixed; boundary="K5sFxEXQSQkv3j2OnN6Mk6nLsvqrmgqkd"
From: Dominick Grift <dac.override@gmail.com>
To: selinux@tycho.nsa.gov
Message-ID: <a910016c-e086-cb75-464b-a17b992167e8@gmail.com>
Subject: Re: [PATCH] semanage: fix error message for fcontext -m
References: <1471519081-26417-1-git-send-email-mvadkert@redhat.com>
In-Reply-To: <1471519081-26417-1-git-send-email-mvadkert@redhat.com>

--K5sFxEXQSQkv3j2OnN6Mk6nLsvqrmgqkd
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 08/18/2016 01:18 PM, Miroslav Vadkerti wrote:
> The type must be a file of device type, not a port type.
>=20
> Signed-off-by: Miroslav Vadkerti <mvadkert@redhat.com>
> ---
>  policycoreutils/semanage/seobject.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/policycoreutils/semanage/seobject.py b/policycoreutils/sem=
anage/seobject.py
> index a6681f0..a34d20d 100644
> --- a/policycoreutils/semanage/seobject.py
> +++ b/policycoreutils/semanage/seobject.py
> @@ -1937,7 +1937,7 @@ class fcontextRecords(semanageRecords):
>          if serange =3D=3D "" and setype =3D=3D "" and seuser =3D=3D ""=
:
>              raise ValueError(_("Requires setype, serange or seuser"))
>          if setype and setype not in self.valid_types:
> -            raise ValueError(_("Type %s is invalid, must be a port typ=
e") % setype)
> +            raise ValueError(_("Type %s is invalid, must be a file or =
device type") % setype)
> =20
>          self.validate(target)
> =20
>=20

Hard-coded reference policy specific type attributes in seobject
(self.valid_types)


--=20
Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B02
https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B6B0=
2
Dominick Grift


--K5sFxEXQSQkv3j2OnN6Mk6nLsvqrmgqkd--

--qxbK2CWBLVDgs9ESOFjfbs1TnIoIesea1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQGcBAEBCAAGBQJXtaE3AAoJECV0jlU3+Udp+WkL/jbP/bhTDhZ3G39Fd5pNej6f
W9zEE9AVvmWd0ftXaFiam91mE67hEcEWYGKy7QgTDadIi/QcT6Ffg+aTKpxuPd58
s7ou8Hv2NZ7caRwXK76gn1qVzobq3fD80Xg2tGmcsWq9mc9jKvdphwC8YzzxgoBQ
GFZrlN/xXiKa9EY9H/zm9ZZPBwTLoP5K1pSkBLicLrJ+xbZpKYYGW4Ju/oElwjdj
aEi6YGjbaqKZXVzQQgikQmtMDHjWAwTZ1MC8U2kl6KNQ7DG7hoO/dFD/B/UZM7az
XCsxqyNbDrnrQKzIb1wIc6Af1IywmpSu8oveqmq47Jeapxa05AgPXrJOADE+fVJC
LhN7ng8s5h3sFQ6TWQ/tkvkzdELJYwC++GJL2TtsHPfFnLlhSV8xRNZH35P2UZOW
u4K9AZzC/mLUgP9Ss1z3kWS9HCsTijv32mPjPgPymMdcxO9vHaslXQcVW3zWuAc2
KJl7Xn4MLa2NiOr60Png4iTqF3sKzatJoCDOWumsXw==
=nxzH
-----END PGP SIGNATURE-----

--qxbK2CWBLVDgs9ESOFjfbs1TnIoIesea1--
