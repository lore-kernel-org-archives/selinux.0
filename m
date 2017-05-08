Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v48M1Nuj009051
 for <selinux@tycho.nsa.gov>; Mon, 8 May 2017 18:01:23 -0400
Received: by mail-wm0-f50.google.com with SMTP id 142so80471080wma.1
 for <selinux@tycho.nsa.gov>; Mon, 08 May 2017 15:01:20 -0700 (PDT)
Received: from julius (84-245-30-81.dsl.cambrium.nl. [84.245.30.81])
 by smtp.gmail.com with ESMTPSA id k17sm5374147eda.61.2017.05.08.15.01.18
 for <selinux@tycho.nsa.gov>
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 08 May 2017 15:01:18 -0700 (PDT)
Date: Tue, 9 May 2017 00:01:17 +0200
From: Dominick Grift <dac.override@gmail.com>
To: selinux@tycho.nsa.gov
Subject: Re: Announcing SPAN: SELinux Policy Analysis Notebook
Message-ID: <20170508220117.GE7367@julius>
References: <590F3B98.406@quarksecurity.com> <20170507154759.GA31890@julius>
 <590F78BA.5040800@quarksecurity.com> <20170508085555.GA3701@julius>
 <20170508093229.GB3701@julius>
 <B4D29110-19AF-4378-A933-DDA41D5B2A0B@gmail.com>
 <20170508194931.GB7367@julius>
 <8AE6E08C-5E9B-4166-AD82-EB57DF4CAE5C@gmail.com>
 <20170508204053.GC7367@julius> <20170508214714.GD7367@julius>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="hwvH6HDNit2nSK4j"
In-Reply-To: <20170508214714.GD7367@julius>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--hwvH6HDNit2nSK4j
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 08, 2017 at 11:47:14PM +0200, Dominick Grift wrote:
> On Mon, May 08, 2017 at 10:40:53PM +0200, Dominick Grift wrote:
> > On Mon, May 08, 2017 at 04:09:16PM -0400, Karl MacMillan wrote:
> > >=20
> > > > On May 8, 2017, at 3:49 PM, Dominick Grift <dac.override@gmail.com>=
 wrote:
> > > >=20
> > > > On Mon, May 08, 2017 at 03:36:21PM -0400, Karl MacMillan wrote:
> > > >>=20
> > > >>>=20
> > > >>=20
> > > >> I think it=E2=80=99s best to think of these as having three basic =
layers:
> > > >>=20
> > > >> 1. Basic tools for SELinux policy analysis in Jupyter - these are =
usable for any policy and make no assumptions about the presence of any typ=
es, attributes, object classes, or permissions. So things like the rule sea=
rching and information flow analysis fit into this group. This is a large p=
art of the value of SPAN.
> > > >>=20
> > > >> 2. Higher-level policy analysis methods - these are things like th=
e domain_types method and the domain / type summaries. These make some mini=
mal assumptions about attributes like domain. I=E2=80=99ll just mention tha=
t these assumptions are very minimal and have been around for a _long_ time=
=2E Domain long pre-dates the reference policy, for example. More than attr=
ibutes this layer is tied to the Linux object classes and permissions.
> > > >>=20
> > > >> 3. Example notebooks - the two example notebooks are just that - e=
xamples. They probably provide a useful starting point, but as Josh points =
out, should simply be modified for your specific use case.
> > > >>=20
> > > >> So the question, then, is should the second layer (the higher-leve=
l policy analysis methods) be made configurable. Honestly I think it would =
be more work than just creating your own versions for a policy that breaks =
the assumptions. To me, that=E2=80=99s the great advantage of this versus o=
ther analysis tools. It=E2=80=99s so simple to create quick tools that meet=
 your needs. And given that the vast majority of Linux and Android systems =
meet the assumptions I think that this is a reasonable approach.
> > > >=20
> > > > I don't think it will work with android. Some of it maybe but not a=
ll of it. for example the source functionality appends "modules" to the sea=
rch path. So i suspect that will break that functionality for Android.
> > >=20
> > > We=E2=80=99ve not tested it for Android policies so I=E2=80=99m sure =
there will be some breakage. But I hope it will be fixed to work by us or s=
omeone soon.
> > >=20
> > > > Thank you for giving me your opinion. At least now I know where I s=
tand.
> > >=20
> > > Where you stand? I=E2=80=99m not certain what you mean and was not tr=
ying to say something about you personally.
> >=20
> > I didnt take it personal, That is not what I meant. To me SELinux is bi=
gger then any single policy be it refpolicy, sepolicy, or dssp
> > The perfect tool would support any policy (setools goes a long way ther=
e). From your comments I sensed that you might not fully agree with that or=
 that you might not have the ambition for SPAN to be perfect.
> > What I am saying is that after your comment I no longer have any illusi=
ons that SPAN will ever be perfect (or close to perfect)
> >=20
> > >=20
> > > I was not familiar with DSSP before (I=E2=80=99ve not done much with =
SELinux for a while), but Josh pointed it out to me. From looking at it ver=
y briefly and thinking through the assumptions in SPAN my guess is that it =
would take very few changes to make SPAN work with DSSP, even the source po=
licy stuff (which, honestly, is just a very small part mainly useful for di=
ffing constraints).
> > >=20
> > > And as a side note - it=E2=80=99s nice to see someone trying to write=
 a policy from scratch in CIL. Do you have a =E2=80=9Cdomain=E2=80=9D attri=
bute or at least a similar concept?
> >=20
> > Sure, but i cannot use "domain" for this because DSSP leverages namespa=
ces. The equivalent in DSSP is "subj.subj_type_attribute"
> >=20
> > So if the configuration file would have something like:
> >=20
> > # process_types =3D domain
> >=20
> > Then i would be happy because then i could edit it like:
> >=20
> > process_types =3D subj.subj_type_attribute
> >=20
> > >=20
> > > > I will not be able to leverage this solution to any significant ext=
end, and the notebook and its depenedencies are pretty expensive to have ju=
st for something that only works to some extent.
> > >=20
> > > I=E2=80=99m curious what you mean by =E2=80=9Conly works to some exte=
nt=E2=80=9D. Any bug reports would be welcome.
> >=20
> > Let me rephrase then: "not to the fullest extent"
> >=20
> > But you gave me the impression that not all bug reports would be "welco=
me" when you said: "the vast majority of Linux and Android systems meet the=
 assumptions I think that this is a reasonable approach."
> >=20
> > >=20
> > > And if you mean specifically in the context of DSSP, like I said I be=
t the changes would be minimal. So if you are interested in giving it a try=
 I=E2=80=99ll be happy to look at the changes needed and give you a hand.
> >=20
> > I agree, and ive said that when I said: "a few rough edges" Its close t=
he usable with DSSP. It just needs to deal with some of the current assumpt=
ions:
> >=20
> > ill point out some:
> >=20
> > 1. return self.grep(name, "*.te", self.modules_path) # what about .cil =
suffixed files?
>=20
> We should make this customizable something like: source_policy_suffix =3D
>=20
> Because we would need to catch *.conf , *.te , *.cil and any future high =
level source policy files that leverage cil
>=20
> > 2. return self.find_def("attribute " + name) # in CIL this is typeattri=
bute
>=20
> CIL is a native language so we use a statement for something then we need=
 to make sure that also its CIL equivalent is caught
>=20
> > 3. return self.grep(type_name, "*.fc", self.modules_path) # CIL has its=
 context specs in the .cil suffixed file
>=20
> We should make this customizable: file_contexts_suffix =3D
> to catch *.fc as well as *.cil and any future high level file_context suf=
fixes
> When this suffix is used we should also alway take "file_contexts" into a=
ccount as this is where to look in monolitic policy
>=20
> > 4.=20
> > return self.diff_relative("/policy/mls", other_source) # these should b=
e customizable
>=20
> mls_constraints =3D
>=20
> > return self.diff_relative("/policy/mcs", other_source) # these should b=
e customizable
>=20
> mcs_constraints =3D
>=20
> > return self.diff_relative("/policy/constraints", other_source) # these =
should be customizable
>=20
> constraints =3D
>=20
> or maybe dont even differentiate between the various different constraint=
s and just pile them all together in:
>=20
> constraints =3D [ "", "", "", ... ]

As a matter of fact, constraints could be anywhere. So probably better to f=
ind a different way to get all the constraints

in cil you can have your constraints whereever you want. For example : I ha=
ve my dbus constraints in dbus.cil with the other dbus policy
This is not unique. This is how it should be with CIL or any high level pol=
icy on top of CIL
it was a limitation of module policy that we couldnt have constraints in mo=
dules in the past

>=20
> This is because there may be other constraints (for example i have role-b=
ase access control seperation constraints)
>=20
> > 5. any references to type attributes should be customizable: ie. proces=
s_types =3D ... filesystem_types =3D ... etc
>=20
> I do not consider Linux access vectors to be customizable, unlike types ,=
attributes, booleans, tunables etc)
>=20
> So one does not have to worry about the hard coding of classes and permis=
sion, However i would probably still try to find a way
> make that more easily customizable. Because new permissions get added to =
existing classes and if you have you access vector declarations in a single=
 place then that is easier to maintain then when you have to add then in co=
de scathered accross the project
>=20
> >=20
> > >=20
> > > Thanks - Karl
> > >=20
> > > > Atleast this inspired me to implement policy for pip and notebook i=
n my personal security policy. So it was not all in vain.
> > > >=20
> > > >>=20
> > > >> Thanks - Karl
> > > >>=20
> > > >>>=20
> > > >>>>=20
> > > >>>> --=20
> > > >>>> Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7=
B 6B02
> > > >>>> https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F=
1D2C7B6B02 <https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5=
F1D2C7B6B02> <https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6=
C5F1D2C7B6B02 <https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B=
6C5F1D2C7B6B02>>
> > > >>>> Dominick Grift
> > > >>>=20
> > > >>>=20
> > > >>>=20
> > > >>> --=20
> > > >>> Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B=
 6B02
> > > >>> https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1=
D2C7B6B02 <https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F=
1D2C7B6B02> <https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C=
5F1D2C7B6B02 <https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6=
C5F1D2C7B6B02>>
> > > >>> Dominick Grift
> > > >>=20
> > > >=20
> > > > --=20
> > > > Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6=
B02
> > > > https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2=
C7B6B02 <https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D=
2C7B6B02>
> > > > Dominick Grift
> > >=20
> >=20
> > --=20
> > Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B02
> > https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B6=
B02
> > Dominick Grift
>=20
>=20
>=20
> --=20
> Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B02
> https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B6B02
> Dominick Grift



--=20
Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B02
https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B6B02
Dominick Grift

--hwvH6HDNit2nSK4j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCAAdFiEEujmXliIBLFTc2Y4AJXSOVTf5R2kFAlkQ6qkACgkQJXSOVTf5
R2mU2gv9HkkTQcMMlmLNyCz9CF2qpT/oM1b+GQvF8MZVAj0sF3lqUmMM5AJbH7Rr
NgZhAwecsiGr02LVwKna16DvtRje4ijlWvW2JMhIpsA/+uAg8ABTKGMBJyDLw8jL
jhjRoVEwmqEdSirKCnuQD8eKXvxSa+vAMAywocDpz0OTMtB2n+H/IqmHFE46k9rb
VNZuMsfJ2N8Y9xNnfLG/lgCGVDDEUSoHrE//QxavpOsBFck/cXjfge/ezErO53pK
qdOWw5mJf0c0ble6WohgONtE2qZKnkEiT0bxgICCN+qg1DH+7d2r3+/VloZ0yGKS
bxLMj+73bJGcuslLbctzHgTtQqT3OgifsfD9I20NzqJKsfg1Md7WMnJEtCxmTKwR
8Z3HrJ4XBLPvLp1qcFtJUtkf8Tb7i7rd3zPEtZ0Juz6SOgXR+K7cG2rr/zteq+S9
vNQq+fYqGynvmHamArLva8ZGJST4L2cOCauGbxqKStd8QQhUi/HuQ2Jygt2vvRRQ
1xVZ4lfZ
=U8bt
-----END PGP SIGNATURE-----

--hwvH6HDNit2nSK4j--
