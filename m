Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v2FKUwWR028088
 for <selinux@tycho.nsa.gov>; Wed, 15 Mar 2017 16:30:58 -0400
Received: by mail-wr0-f175.google.com with SMTP id g10so18834200wrg.2
 for <selinux@tycho.nsa.gov>; Wed, 15 Mar 2017 13:30:56 -0700 (PDT)
Received: from t450.enp8s0.d30 (84-245-30-81.dsl.cambrium.nl. [84.245.30.81])
 by smtp.gmail.com with ESMTPSA id
 l41sm3591225wre.23.2017.03.15.13.30.54 for <selinux@tycho.nsa.gov>
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 15 Mar 2017 13:30:54 -0700 (PDT)
Date: Wed, 15 Mar 2017 21:30:53 +0100
From: Dominick Grift <dac.override@gmail.com>
To: selinux@tycho.nsa.gov
Subject: Re: portcon in policy modules
Message-ID: <20170315203053.GA18934@t450.enp8s0.d30>
References: <531c2329-9a0a-d6f6-5fe4-8b4614711552@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="vtzGhvizbBRQ85DL"
In-Reply-To: <531c2329-9a0a-d6f6-5fe4-8b4614711552@gmail.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--vtzGhvizbBRQ85DL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 15, 2017 at 02:52:29PM -0500, Ian Pilcher wrote:
> 10 years later, is this still accurate?

No:

echo "(portcon tcp 12345 (system_u object_r http_port_t ((s0)(s0))))" > myp=
ort.cil && semodule -i myport.cil



>=20
>    http://danwalsh.livejournal.com/10607.html
>=20
> --=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> Ian Pilcher                                         arequipeno@gmail.com
> -------- "I grew up before Mark Zuckerberg invented friendship" --------
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
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

--vtzGhvizbBRQ85DL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCAAdFiEEujmXliIBLFTc2Y4AJXSOVTf5R2kFAljJpHgACgkQJXSOVTf5
R2k2Rgv/TOFLPqJO+MjLvEXyuVAUP85jQ2ws7tIOahdk76gESqSQmpP9fUenl/bq
j9eyQ/3Is036jqvLxAKCIx3DatvMXGZC7dMZntTxAFzpA9WQDKZXLjeMGD/Cxxij
v3a7cuCxcjl6woGqmc+pvbhgiaG43d8dcfn2Ew4eC90JzI/PhgT2EvwzuSWO3vmX
abaHAz2wyh6wWRQmTwggSOon+8L+viNIyjgrLXPEXFZtZRdmhdUSWX7V/6gSVZsr
adI6rkOlZMqbNhStvrf2Eyy8D25jDKUFM1sUC3tw10xaVVk7ju2mj8PFMqHpaipG
rIW10jPm5SC5JlxZ3Mdh8efhBuFZlPXxZ+w2myLsEjjupbyui365GTTL6crsaiTI
QI5OtGkby9YE5CBysFBb22Soc2vq3Fu8zB4yzMTpd2sWGYvx4MWHvSkWMI/1EMjG
lopdJRH++Cla4g1IGLZtoVWeOC8xKrpUbDT1Uxnqap/pzr3VVqk8qEqariVZCjIA
Ha9KP9dy
=EmGD
-----END PGP SIGNATURE-----

--vtzGhvizbBRQ85DL--
