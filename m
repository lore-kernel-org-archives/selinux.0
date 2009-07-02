Subject: Re: request for review of, and collaboration on SELinux models
 wiki entry
From: Dominick Grift <domg472@gmail.com>
To: Sebastian Pfaff <sebastian.pfaff@gmail.com>
Cc: selinux@tycho.nsa.gov, Stephen Smalley <sds@tycho.nsa.gov>
In-Reply-To: <7DB3E8B4-9FFF-4FE1-873D-1A99C6EEF0AA@gmail.com>
References: <1246542053.26320.15.camel@notebook2.grift.internal>
	 <1246544997.13464.314.camel@moss-pluto.epoch.ncsc.mil>
	 <7DB3E8B4-9FFF-4FE1-873D-1A99C6EEF0AA@gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-tfh8TyEHql8FqogB+Pgo"
Date: Thu, 02 Jul 2009 17:49:48 +0200
Message-Id: <1246549788.26320.42.camel@notebook2.grift.internal>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-tfh8TyEHql8FqogB+Pgo
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2009-07-02 at 17:25 +0200, Sebastian Pfaff wrote:
> hello,
>=20
> from http://selinuxproject.org/page/SELinux_models (Multi Category =20
> Security):
>=20
> [...] Multi Category Security and Multi Level Security are mutually =20
> exclusive.
>=20
> > - MCS and MLS are just particular configurations of constraints for =20
> > the
> > MLS engine and thus share the same field and engine logic.  MCS was an
> > attempt to make the MLS field and engine useful for general users, and
> > is being leveraged by sandbox and by svirt for separating multiple
> > instances of sandboxes or guest VMs.
>=20
> In other words: MCS and MLS are not mutally exclusiv?! Not in SELinux =20
> and not in gernal? For me, MCS in SELinux is an "extra",  which  you =20
> can use with MLS (or MLS engine) at the same time. Please correct me, =20
> if i'm wrong.
>=20
> Imho, MCS uses "compartments" or categories to realize the need to =20
> know principle and MLS uses vertical levels to achieve (at least in =20
> SELinux) confidentiality (BLP model). Imo compartments and levels are =20
> not mutally exclusive.

MCS and MLS are SELinux models (MCS and MLS are just particular
configurations of constraints for the MLS engine and thus share the same
field and engine logic.)

The MCS configuration of constraints conflict with the MLS configuration
of constraints.

In MCS the usage of assigned compartments is to the discretion of the
user

In MLS the usage of assigned compartments is mandatory.

As far as i know MCS and MLS are mutually exclusive.=20

> --
> Sebastian Pfaff
>=20
>=20
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov =
with
> the words "unsubscribe selinux" without quotes as the message.

--=-tfh8TyEHql8FqogB+Pgo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkpM1xYACgkQMlxVo39jgT9V4QCgmrKCxMU9TRtELR0Wsb+CWaju
rkYAn1JK4kwhwvnMUeawub+NUTTAwg7v
=m5x4
-----END PGP SIGNATURE-----

--=-tfh8TyEHql8FqogB+Pgo--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
