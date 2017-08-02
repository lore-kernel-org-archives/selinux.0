Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v72Ka23l007734
 for <selinux@tycho.nsa.gov>; Wed, 2 Aug 2017 16:36:02 -0400
Received: by mail-wm0-f51.google.com with SMTP id m85so46445224wma.0
 for <selinux@tycho.nsa.gov>; Wed, 02 Aug 2017 09:38:45 -0700 (PDT)
Received: from julius.enp8s0.d30 ([217.19.26.10])
 by smtp.gmail.com with ESMTPSA id x11sm13424352edi.13.2017.08.02.09.38.42
 for <selinux@tycho.nsa.gov>
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 02 Aug 2017 09:38:42 -0700 (PDT)
Date: Wed, 2 Aug 2017 18:38:41 +0200
From: Dominick Grift <dac.override@gmail.com>
To: selinux@tycho.nsa.gov
Message-ID: <20170802163841.GB16782@julius.enp8s0.d30>
References: <CAENH-vA_rbUf8UyDcGmCto3-R9zNPy1jMMoH+XKwRqx7c4P-qQ@mail.gmail.com>
 <20170802163500.GA16782@julius.enp8s0.d30>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="/NkBOFFp2J2Af1nK"
In-Reply-To: <20170802163500.GA16782@julius.enp8s0.d30>
Subject: Re: httpd_graceful_shutdown makes httpd_can_network_connect
 mostly mute
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--/NkBOFFp2J2Af1nK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 02, 2017 at 06:35:00PM +0200, Dominick Grift wrote:
> On Wed, Aug 02, 2017 at 04:41:00PM +0100, Carlos Rodrigues wrote:
> > Hi,
> >=20
> > I don't know if this a too basic question to ask here, or the proper
> > place, but here it goes:
> >=20
> > I've been chasing some weird (to me) behavior with the targeted policy
> > on a VM running nginx as a reverse proxy. What happens is that the
> > "httpd_can_network_connect" boolean needs to be enabled for nginx to
> > be able to reach its upstream servers. So far, so good.
> >=20
> > However, if the upsteam server happens to be listening in one of the
> > "http_port_t" ports, "httpd_can_network_connect" isn't needed because
> > the "httpd_graceful_shutdown" (default enabled) provides the required
> > allow rule ("name_connect").
> >=20
> > This seems strange to me. Is this supposed to be like this? I would
> > expect nginx to be totally unable to establish outbound connections by
> > default.
> >=20
> > Best regards,
> >=20
> > Carlos Rodrigues
> >=20
> > PS: I just spent a few hours on this, wondering why one machine needed
> > "httpd_can_network_connect" and another did not. I guess I've mostly
> > been setting up reverse proxies for "http_port_t" upstreams on CentOS
> > all this time...
>=20
> I think the "httpd_graceful_shutdown" is an apache thing (probably for "a=
pachectl graceful-stop"). However I cannot reproduce this behavior with htt=
pd-2.4.27-4.fc27.

Also "httpd_can_network_connect" grants broader network access to httpd


By the way: refpolicy questions should be directed to the refpolicy maillis=
t: http://oss.tresys.com/mailman/listinfo/refpolicy

>=20
> --=20
> Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B02
> https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B6B02
> Dominick Grift



--=20
Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B02
https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B6B02
Dominick Grift

--/NkBOFFp2J2Af1nK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCAAdFiEEujmXliIBLFTc2Y4AJXSOVTf5R2kFAlmCAAwACgkQJXSOVTf5
R2npRgv/aFxmJTBse/WOuzxviO37bgdeRtH1vHFNOVu/5cjzdp1B+g3CHUV0WJWC
8uqq3f4PaPAjbVQuD/vVF9ZkEaKjf5eThfDTtpvqbxW0U1YlSbrUlzBxBW4wSFNZ
7yh+f0RUGa59KQZ5wxZ3RexFbwDkuA5mUpa6dM8Njbf2sdaqbXvXre8K6QOmhq2L
RL9kyXLf7DO0awmOHSNjWVeEhJRhFtrG9A+Xb+BY+PjIV+KRg2KBz6EtNfSjnC1E
cmHs5697FJGeJFy6CyVMQF6HNj83N5N8t+iVtcHXvezdHd+WHKz9iOr0KuDOGakG
PrB303aRRPXSysLtM0bzs9HdXXXkuRXIFv0Oa5OZ0y7aU/k+yLIdvybSg9nWNcG3
EMkHCeiCkG83nQlqSXLgYPvL/TISxCJPfZdENtzO4+jJAFf4AhKSCFSX/ktptZr6
e18aOFigfaMWtT1b/IQN3MgMthrUgz7SDsQPL2rruBGy3Rmbl9BLspH6uKZYn1Hy
cokXpjgu
=jmBl
-----END PGP SIGNATURE-----

--/NkBOFFp2J2Af1nK--
