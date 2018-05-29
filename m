Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w4TCkkKE018134
 for <selinux@tycho.nsa.gov>; Tue, 29 May 2018 08:46:46 -0400
Received: by mail-wm0-f53.google.com with SMTP id m129-v6so40123858wmb.3
 for <selinux@tycho.nsa.gov>; Tue, 29 May 2018 05:46:38 -0700 (PDT)
Received: from julius.enp8s0.d30 ([217.19.26.10])
 by smtp.gmail.com with ESMTPSA id c46-v6sm5322758edc.34.2018.05.29.05.46.35
 for <selinux@tycho.nsa.gov>
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 29 May 2018 05:46:35 -0700 (PDT)
Date: Tue, 29 May 2018 14:46:33 +0200
From: Dominick Grift <dac.override@gmail.com>
To: selinux@tycho.nsa.gov
Message-ID: <20180529124633.GA20202@julius.enp8s0.d30>
References: <CABCvxxp040XVs4K_GGSJeNnTr9sNmeEfw62QoXVjF==xm9bNXg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="qMm9M+Fa2AknHoGS"
In-Reply-To: <CABCvxxp040XVs4K_GGSJeNnTr9sNmeEfw62QoXVjF==xm9bNXg@mail.gmail.com>
Subject: Re: Invalid security context while executing
 audit2alllow.orig
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--qMm9M+Fa2AknHoGS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 29, 2018 at 05:09:53PM +0530, bhawna goel wrote:
>  Hi Team,
>=20
> We are getting below error while creating policies using command
> audit2allow.orig. Can you help in identifying what could be the possible
> reason of such error.

The context "specialuser_u:system_r:ssh_t:s0" is invalid.

Either "specialuser_u" is not authorized to associate with "system_r" role,=
 or the system_r role is not allowed to associate with "ssh_t" type.

seinfo -xuspecialuser_u | grep system_r
seinfo -xrsystem_r | grep ssh_t

>=20
> Error:
> libsepol.context_from_record: invalid security context:
> "specialuser_u:system_r:ssh_t:s0"
> libsepol.context_from_record: could not create context structure
> libsepol.context_from_string: could not create context structure
> libsepol.sepol_context_to_sid: could not convert
> specialuser_u:system_r:ssh_t:s0 to sid
>=20
> Thanks in Advance
>=20
> Regards,
> Bhawna

> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho.nsa=
=2Egov.


--=20
Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B02
https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B6B02
Dominick Grift

--qMm9M+Fa2AknHoGS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCAAdFiEEujmXliIBLFTc2Y4AJXSOVTf5R2kFAlsNS6YACgkQJXSOVTf5
R2kGtgwAgYZIFpTBGgmvX5vGlVzEYlWCzRbdtbtCRIpwPs8Plk/i+QLii5Mfzol2
z1dGrf0B8Y6AIy2R6BnCIURQGIDtRNcec5bUVkD9Sfe+o9FXUD8MfdTGm2qWM8Os
zjgjc3WBWjlIvO7AO1WuR6iqWEnudkoR/mBxF7xNhCbCYQozDH4H6e/Nbr3hc7e6
ikNkWV1Vn96o/hrnqKqlxi+4Xe316b5z3Xgkmahk1av8v7GBzZfnBbpYi+UyGjYk
fz/JozcBSvY/aoW/eNFVrnyupPtnSZ3nV2XXNTyrZVYrPfREks867ydhWZ1p86QQ
ij0uL6ER3ELw5mXpIQF17yX49x3Q7AOhr8KtBFUU1+SxCIHnJG/dksIwce9FheE5
OhXfbxoInh38oVPO9lRaNvpVj45xQoxg6LB0i8Z/Ff0lw2HplEblATq27oxY6AHa
Iy3+wifbD8dOnPZzXnhHMVkgUYwk6oOmuDyFbVjdRXrnaTI+aAQcg45mS/h7naNF
vCUPXaDo
=4zrt
-----END PGP SIGNATURE-----

--qMm9M+Fa2AknHoGS--
