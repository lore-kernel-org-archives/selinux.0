Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v2UEKZhg014994
 for <selinux@tycho.nsa.gov>; Thu, 30 Mar 2017 10:20:36 -0400
Received: by mail-wr0-f179.google.com with SMTP id w43so62811153wrb.0
 for <selinux@tycho.nsa.gov>; Thu, 30 Mar 2017 07:20:21 -0700 (PDT)
Received: from t450.enp8s0.d30 (84-245-30-81.dsl.cambrium.nl. [84.245.30.81])
 by smtp.gmail.com with ESMTPSA id
 j2sm502502wrd.26.2017.03.30.07.20.16 for <selinux@tycho.nsa.gov>
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 30 Mar 2017 07:20:16 -0700 (PDT)
Date: Thu, 30 Mar 2017 16:20:14 +0200
From: Dominick Grift <dac.override@gmail.com>
To: selinux@tycho.nsa.gov
Subject: Re: label for /proc directory (before mounting)
Message-ID: <20170330142014.GA4406@t450.enp8s0.d30>
References: <1490821242.510644.927878696.6DEBD3A9@webmail.messagingengine.com>
 <1490881474.18002.3.camel@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="cWoXeonUoKmBZSoM"
In-Reply-To: <1490881474.18002.3.camel@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--cWoXeonUoKmBZSoM
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 30, 2017 at 09:44:34AM -0400, Stephen Smalley wrote:
> On Wed, 2017-03-29 at 17:00 -0400, Colin Walters wrote:
> > Hi, see: https://github.com/ostreedev/ostree/pull/768
> >=20
> > TL;DR: Policy (at least Fedora's version) does not specify
> > a label for /proc on disk (as distinct from the `proc_t` from
> > the genfscon).
> >=20
> > This causes some breakage in rpm-ostree (which I can work
> > around), but I'd like a better fix than what I did above.
> > Any suggestions?=A0=A0It probably doesn't
> > matter too much what the actual type is since systemd will
> > overmount it - should I make it the same type as e.g. `/mnt`?
>=20
> You shouldn't hardcode security contexts, ever.  Why can't one just fix
> the Fedora policy?  Do we still even need the <<none>> entries for
> /proc in file_contexts in Fedora policy, given that restorecon is now
> smart enough to skip any filesystem that lacks seclabel in
> /proc/mounts? Android doesn't use <<none>> in its file_contexts at all.

It is not alway's as simple in my experience though (although for "/proc -d=
" it probably is)

<<none>> is a reliable way to trick unreliable "selinux aware" applications=
 into thinking that they shouldnt bother with setfscreatecon(_default)

There can be various reasons why one might want to do that. One of which is=
 that these selinux aware applications might or might not reset customizabl=
e identifiers (roles and ids)
Another reason would be to avoid inconsistent labels, where a process shoul=
d use setfscreatecon but where it doesnt. (you could anticipate this in pol=
icy in other way's as well but <<none>> does the trick there as well)

>=20
> As to what type it should have, I would try to keep it in whatever type
> it is presently being assigned in Fedora during an install to avoid
> breakage.  Not sure offhand what that is.
>=20
> There is a more general problem here though, in that we don't presently
> have an unambiguous way to specify a different security context for a
> mountpoint directory vs a mounted directory in file_contexts.  That's
> been previously noted as an issue in Android.  Probably requires some
> new syntax in file_contexts to distinguish.
>=20
>=20
>=20
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

--cWoXeonUoKmBZSoM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCAAdFiEEujmXliIBLFTc2Y4AJXSOVTf5R2kFAljdFBoACgkQJXSOVTf5
R2mnOgv/WsmCcvQUY9Erlj1o+gII/upNE1lECQIc+kQgg1aEH2IIR7McZaMcsq+p
BBMcozpWh7Y/WkEIOS6sg9uofxTDUM/TO8I7cDsBnmBgvbaIqKcNWfzPdwskPqkP
GAZvDS9VuEFxe7Mj5LAXsP9JywZj1Bpon9gz2IBHMgh4eXpioGn09qOCfMoBi6AO
VhXRMv/Uk+zG9kLtuIiOH3G2v/OoK13tah6zbDYVdjZwr3Tgj3VbSBCmAVz+8eRv
z0BxZXeDIpoBTdXpoeKMarFsZfCJ4ntHF+KtBIqvRF/2KIwilxnuCNKcWJzT+PzX
cvMG98IcUhkIBoySHhczuV8QWdZJoyQDUJHnrEwuPhgYORdzwf6r8IEuDI9LifD+
ucsoDfHobvQrtYuBNUqF0pilAaTZXENVGRPs8GxRxg8Ww+qGqMSUVpDRNQuGdHV8
WI/Ub9vjSx+vfuqwUmK7zjzqYO9Iqycj7SzQuFjy6YOUHMtWPLatSy6mCJeomtbH
mrROYGes
=JuSd
-----END PGP SIGNATURE-----

--cWoXeonUoKmBZSoM--
