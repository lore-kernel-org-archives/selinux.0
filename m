Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v48LlKO9003734
 for <selinux@tycho.nsa.gov>; Mon, 8 May 2017 17:47:20 -0400
Received: by mail-wm0-f42.google.com with SMTP id 142so80183020wma.1
 for <selinux@tycho.nsa.gov>; Mon, 08 May 2017 14:47:18 -0700 (PDT)
Received: from julius (84-245-30-81.dsl.cambrium.nl. [84.245.30.81])
 by smtp.gmail.com with ESMTPSA id a56sm4744540eda.3.2017.05.08.14.47.15
 for <selinux@tycho.nsa.gov>
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 08 May 2017 14:47:15 -0700 (PDT)
Date: Mon, 8 May 2017 23:47:14 +0200
From: Dominick Grift <dac.override@gmail.com>
To: selinux@tycho.nsa.gov
Subject: Re: Announcing SPAN: SELinux Policy Analysis Notebook
Message-ID: <20170508214714.GD7367@julius>
References: <20170506171920.GB20145@julius> <590F3B98.406@quarksecurity.com>
 <20170507154759.GA31890@julius>
 <590F78BA.5040800@quarksecurity.com> <20170508085555.GA3701@julius>
 <20170508093229.GB3701@julius>
 <B4D29110-19AF-4378-A933-DDA41D5B2A0B@gmail.com>
 <20170508194931.GB7367@julius>
 <8AE6E08C-5E9B-4166-AD82-EB57DF4CAE5C@gmail.com>
 <20170508204053.GC7367@julius>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="SFyWQ0h3ruR435lw"
In-Reply-To: <20170508204053.GC7367@julius>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--SFyWQ0h3ruR435lw
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 08, 2017 at 10:40:53PM +0200, Dominick Grift wrote:
> On Mon, May 08, 2017 at 04:09:16PM -0400, Karl MacMillan wrote:
> >=20
> > > On May 8, 2017, at 3:49 PM, Dominick Grift <dac.override@gmail.com> w=
rote:
> > >=20
> > > On Mon, May 08, 2017 at 03:36:21PM -0400, Karl MacMillan wrote:
> > >>=20
> > >>>=20
> > >>=20
> > >> I think it=E2=80=99s best to think of these as having three basic la=
yers:
> > >>=20
> > >> 1. Basic tools for SELinux policy analysis in Jupyter - these are us=
able for any policy and make no assumptions about the presence of any types=
, attributes, object classes, or permissions. So things like the rule searc=
hing and information flow analysis fit into this group. This is a large par=
t of the value of SPAN.
> > >>=20
> > >> 2. Higher-level policy analysis methods - these are things like the =
domain_types method and the domain / type summaries. These make some minima=
l assumptions about attributes like domain. I=E2=80=99ll just mention that =
these assumptions are very minimal and have been around for a _long_ time. =
Domain long pre-dates the reference policy, for example. More than attribut=
es this layer is tied to the Linux object classes and permissions.
> > >>=20
> > >> 3. Example notebooks - the two example notebooks are just that - exa=
mples. They probably provide a useful starting point, but as Josh points ou=
t, should simply be modified for your specific use case.
> > >>=20
> > >> So the question, then, is should the second layer (the higher-level =
policy analysis methods) be made configurable. Honestly I think it would be=
 more work than just creating your own versions for a policy that breaks th=
e assumptions. To me, that=E2=80=99s the great advantage of this versus oth=
er analysis tools. It=E2=80=99s so simple to create quick tools that meet y=
our needs. And given that the vast majority of Linux and Android systems me=
et the assumptions I think that this is a reasonable approach.
> > >=20
> > > I don't think it will work with android. Some of it maybe but not all=
 of it. for example the source functionality appends "modules" to the searc=
h path. So i suspect that will break that functionality for Android.
> >=20
> > We=E2=80=99ve not tested it for Android policies so I=E2=80=99m sure th=
ere will be some breakage. But I hope it will be fixed to work by us or som=
eone soon.
> >=20
> > > Thank you for giving me your opinion. At least now I know where I sta=
nd.
> >=20
> > Where you stand? I=E2=80=99m not certain what you mean and was not tryi=
ng to say something about you personally.
>=20
> I didnt take it personal, That is not what I meant. To me SELinux is bigg=
er then any single policy be it refpolicy, sepolicy, or dssp
> The perfect tool would support any policy (setools goes a long way there)=
=2E From your comments I sensed that you might not fully agree with that or=
 that you might not have the ambition for SPAN to be perfect.
> What I am saying is that after your comment I no longer have any illusion=
s that SPAN will ever be perfect (or close to perfect)
>=20
> >=20
> > I was not familiar with DSSP before (I=E2=80=99ve not done much with SE=
Linux for a while), but Josh pointed it out to me. From looking at it very =
briefly and thinking through the assumptions in SPAN my guess is that it wo=
uld take very few changes to make SPAN work with DSSP, even the source poli=
cy stuff (which, honestly, is just a very small part mainly useful for diff=
ing constraints).
> >=20
> > And as a side note - it=E2=80=99s nice to see someone trying to write a=
 policy from scratch in CIL. Do you have a =E2=80=9Cdomain=E2=80=9D attribu=
te or at least a similar concept?
>=20
> Sure, but i cannot use "domain" for this because DSSP leverages namespace=
s. The equivalent in DSSP is "subj.subj_type_attribute"
>=20
> So if the configuration file would have something like:
>=20
> # process_types =3D domain
>=20
> Then i would be happy because then i could edit it like:
>=20
> process_types =3D subj.subj_type_attribute
>=20
> >=20
> > > I will not be able to leverage this solution to any significant exten=
d, and the notebook and its depenedencies are pretty expensive to have just=
 for something that only works to some extent.
> >=20
> > I=E2=80=99m curious what you mean by =E2=80=9Conly works to some extent=
=E2=80=9D. Any bug reports would be welcome.
>=20
> Let me rephrase then: "not to the fullest extent"
>=20
> But you gave me the impression that not all bug reports would be "welcome=
" when you said: "the vast majority of Linux and Android systems meet the a=
ssumptions I think that this is a reasonable approach."
>=20
> >=20
> > And if you mean specifically in the context of DSSP, like I said I bet =
the changes would be minimal. So if you are interested in giving it a try I=
=E2=80=99ll be happy to look at the changes needed and give you a hand.
>=20
> I agree, and ive said that when I said: "a few rough edges" Its close the=
 usable with DSSP. It just needs to deal with some of the current assumptio=
ns:
>=20
> ill point out some:
>=20
> 1. return self.grep(name, "*.te", self.modules_path) # what about .cil su=
ffixed files?

We should make this customizable something like: source_policy_suffix =3D

Because we would need to catch *.conf , *.te , *.cil and any future high le=
vel source policy files that leverage cil

> 2. return self.find_def("attribute " + name) # in CIL this is typeattribu=
te

CIL is a native language so we use a statement for something then we need t=
o make sure that also its CIL equivalent is caught

> 3. return self.grep(type_name, "*.fc", self.modules_path) # CIL has its c=
ontext specs in the .cil suffixed file

We should make this customizable: file_contexts_suffix =3D
to catch *.fc as well as *.cil and any future high level file_context suffi=
xes
When this suffix is used we should also alway take "file_contexts" into acc=
ount as this is where to look in monolitic policy

> 4.=20
> return self.diff_relative("/policy/mls", other_source) # these should be =
customizable

mls_constraints =3D

> return self.diff_relative("/policy/mcs", other_source) # these should be =
customizable

mcs_constraints =3D

> return self.diff_relative("/policy/constraints", other_source) # these sh=
ould be customizable

constraints =3D

or maybe dont even differentiate between the various different constraints =
and just pile them all together in:

constraints =3D [ "", "", "", ... ]

This is because there may be other constraints (for example i have role-bas=
e access control seperation constraints)

> 5. any references to type attributes should be customizable: ie. process_=
types =3D ... filesystem_types =3D ... etc

I do not consider Linux access vectors to be customizable, unlike types ,at=
tributes, booleans, tunables etc)

So one does not have to worry about the hard coding of classes and permissi=
on, However i would probably still try to find a way
make that more easily customizable. Because new permissions get added to ex=
isting classes and if you have you access vector declarations in a single p=
lace then that is easier to maintain then when you have to add then in code=
 scathered accross the project

>=20
> >=20
> > Thanks - Karl
> >=20
> > > Atleast this inspired me to implement policy for pip and notebook in =
my personal security policy. So it was not all in vain.
> > >=20
> > >>=20
> > >> Thanks - Karl
> > >>=20
> > >>>=20
> > >>>>=20
> > >>>> --=20
> > >>>> Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B =
6B02
> > >>>> https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D=
2C7B6B02 <https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1=
D2C7B6B02> <https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5=
F1D2C7B6B02 <https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C=
5F1D2C7B6B02>>
> > >>>> Dominick Grift
> > >>>=20
> > >>>=20
> > >>>=20
> > >>> --=20
> > >>> Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6=
B02
> > >>> https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2=
C7B6B02 <https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D=
2C7B6B02> <https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F=
1D2C7B6B02 <https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5=
F1D2C7B6B02>>
> > >>> Dominick Grift
> > >>=20
> > >=20
> > > --=20
> > > Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B02
> > > https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7=
B6B02 <https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C=
7B6B02>
> > > Dominick Grift
> >=20
>=20
> --=20
> Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B02
> https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B6B02
> Dominick Grift



--=20
Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B02
https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B6B02
Dominick Grift

--SFyWQ0h3ruR435lw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCAAdFiEEujmXliIBLFTc2Y4AJXSOVTf5R2kFAlkQ510ACgkQJXSOVTf5
R2mK2Qv9GYBXunIDM/XfTMC0ksa5z8jezyChOD7jmDg4vC9SjTV7hLMHdmLaXr9c
Ox6BPuOvlP6lH5t9T31tZIiPKsz/0OW7/afJlFH+l4tN0AIooxTSFj3xlxj07qdo
RdIQPFJrbRbi+aMHY5Mr4ZuP1LM9qHgvQzuq5jwGHVlDc+mOH46N/84SYxoI+cK1
9+8pCWgTJ/EbBnAi40IhbrMevwQa9VAp7ruIVb3AtkfrGgcXZPELL96/SK8hJYyu
Tn+rSLzv+j8PzTfd4Wh4ktss59WWosVPU7vw+mLDziJgW/4ys1XQPgQun2MTWGZj
5SRrYPBpKNm5NqKKPrnbmYHpvPsJAdXZTpLgxR5eEEcmR56mENHcDiaRy6hZMW3k
EgRmu2GpBd7GndeREEIkw1wZM4rkcP9HPFBOcxpDEE8Udtvq6UavrnsMxYAUdrxU
hbUflyjyK5zeRFkZ5wUa7eq3IsKgnVz9RFV6RMT9wZy85KgrM5aFLhNCugFl4ipp
m60oPGKQ
=4f27
-----END PGP SIGNATURE-----

--SFyWQ0h3ruR435lw--
