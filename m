Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v489WfdW012586
 for <selinux@tycho.nsa.gov>; Mon, 8 May 2017 05:32:42 -0400
Received: by mail-wm0-f42.google.com with SMTP id b84so47608986wmh.0
 for <selinux@tycho.nsa.gov>; Mon, 08 May 2017 02:32:33 -0700 (PDT)
Received: from julius (84-245-30-81.dsl.cambrium.nl. [84.245.30.81])
 by smtp.gmail.com with ESMTPSA id m9sm1944501edd.41.2017.05.08.02.32.31
 for <selinux@tycho.nsa.gov>
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 08 May 2017 02:32:31 -0700 (PDT)
Date: Mon, 8 May 2017 11:32:29 +0200
From: Dominick Grift <dac.override@gmail.com>
To: selinux@tycho.nsa.gov
Subject: Re: Announcing SPAN: SELinux Policy Analysis Notebook
Message-ID: <20170508093229.GB3701@julius>
References: <EDB27428-18DD-4A40-9A1E-AE2DC9390F99@gmail.com>
 <20170506140358.GA21008@julius> <20170506161956.GA20145@julius>
 <20170506171920.GB20145@julius> <590F3B98.406@quarksecurity.com>
 <20170507154759.GA31890@julius>
 <590F78BA.5040800@quarksecurity.com> <20170508085555.GA3701@julius>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Y7xTucakfITjPcLV"
In-Reply-To: <20170508085555.GA3701@julius>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--Y7xTucakfITjPcLV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 08, 2017 at 10:55:55AM +0200, Dominick Grift wrote:
> On Sun, May 07, 2017 at 03:42:50PM -0400, Joshua Brindle wrote:
> > Dominick Grift wrote:
> > > On Sun, May 07, 2017 at 11:22:00AM -0400, Joshua Brindle wrote:the
> > > > Dominick Grift wrote:
> > > > <snip>
> > > >=20
> > > > > The idea is nice, unfortunately its inflexible and it has hard-re=
ferences to reference policy all-over. It has potential but it is still rou=
gh.
> > > > >=20
> > > > Of course, it is an analysis of a refpolicy-based policy. If you wa=
nt to
> > > > analyze a different policy (e.g., Android or home-rolled) you will =
have to
> > > > change out all of the type sets, etc.
> > > >=20
> > > > You can't make a magic generic analysis script without knowing how =
key parts
> > > > of the system work and what types are associated with those compone=
nts.
> > >=20
> > > What do you mean? that for example that hard-coded array of "trusted"=
 types. Is that not just redundant.
> > >=20
> >=20
> > you mean the example trusted types? I'm not sure I understand your conc=
ern.
> >=20
> > > Can't i just create that array myself and use it to exlude rules with=
 types in that array? That was one does not have to hard-code it.
> > >=20
> >=20
> > It is python, you can do anything you want. The example notebook is a
> > starting point, anyone doing an analysis would probably make major chan=
ges
> > for their analysis, which is the point. You modify the notebook to buil=
d a
> > usable analysis between the starting policy and the policy you are
> > analyzing.
> >=20
> > I've thought about trying this on an Android policy but haven't made it=
 a
> > priority.
> >=20
> > > Also with regard to hardcoding the refpolicy file system (ps.load_pol=
icy_source). I mean if youre just going to `grep -r` then why do we have to=
 assume anything there and hard code file suffixed, directory structures et=
c etc?
> >=20
> >=20
>=20
> ahh.. sorry. I just noticed that it can be overriden:
>=20
> p, ps, bp, bps =3D se.load_policies_from_config("policy_paths.config")
>=20
> so i suppose i should be able to add that file to the notebook dir and sp=
ecify my own paths.
>=20
> although that still doesnt deal with any file suffixes? (.cil)


take for example: https://github.com/QuarkSecurity/SPAN/blob/master/span/sp=
an.py#L331

"domain" is a reference policy type attribute

One should expand on the "policy_paths.config" concept and allow us, via co=
nfiguration files, to override all the variables (attributes, suffixes, pat=
hs, identifiers, etc)

So that the variables can we adjusted without the need to reinstall/recompi=
le a modified SPAN

Or just rename to RPAN (reference policy analysis notebook)

>=20
> --=20
> Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B02
> https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B6B02
> Dominick Grift



--=20
Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B02
https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B6B02
Dominick Grift

--Y7xTucakfITjPcLV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCAAdFiEEujmXliIBLFTc2Y4AJXSOVTf5R2kFAlkQOykACgkQJXSOVTf5
R2lCzQv9FhwxYQ9HJVUws3HsJM9lMvHBQdKGEnpPPvf8p7GdODHx8gXvDg+OG50c
Wb/wCrFOUvdq2gEDAFNOm08HDns9K/ZB9/P9uAfXFkMH1iSOenzmlC2ilMYrqs+p
0JRSGsUKwRf62vp2HjW6WImzgIbV9G29frgtk+CjPB2TrdtTrBdivH2wNIdFeFpu
QsXnmM78zkIEKaOyx68mSJq2qcbvlW7dgN9owf7ILugJJAhItqJU1rl9HTDuHUQZ
zl7jsNhipBbHEaSA7POqDSpMp5zKbReAcCZe0kvqdj6p3yBPhZNKSR0C4HmC3VnM
d5zFsEohf9LhYsXvviQBtAJfQyIwUUgniGfFecIikE6kkNXbGBiBHktwDakFf5xr
H7CbP/EAyrsStxZHMg7CjqB8MmRLVqJ18xBblgra9N82R6uOSWApQ05/Z8XQSabh
AVs2Ulg0o8qlsHB3izJdqzC0PvZOUKlMINMQBxhUa2C2d44bGOKeMBdk02+jfsdH
5linQqjB
=pRj0
-----END PGP SIGNATURE-----

--Y7xTucakfITjPcLV--
