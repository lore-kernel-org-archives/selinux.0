Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v48Kf0d6015090
 for <selinux@tycho.nsa.gov>; Mon, 8 May 2017 16:41:00 -0400
Received: by mail-wm0-f54.google.com with SMTP id m123so78138201wma.0
 for <selinux@tycho.nsa.gov>; Mon, 08 May 2017 13:40:57 -0700 (PDT)
Received: from julius (84-245-30-81.dsl.cambrium.nl. [84.245.30.81])
 by smtp.gmail.com with ESMTPSA id w44sm2465999edd.53.2017.05.08.13.40.54
 for <selinux@tycho.nsa.gov>
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 08 May 2017 13:40:55 -0700 (PDT)
Date: Mon, 8 May 2017 22:40:53 +0200
From: Dominick Grift <dac.override@gmail.com>
To: selinux@tycho.nsa.gov
Subject: Re: Announcing SPAN: SELinux Policy Analysis Notebook
Message-ID: <20170508204053.GC7367@julius>
References: <20170506161956.GA20145@julius> <20170506171920.GB20145@julius>
 <590F3B98.406@quarksecurity.com> <20170507154759.GA31890@julius>
 <590F78BA.5040800@quarksecurity.com> <20170508085555.GA3701@julius>
 <20170508093229.GB3701@julius>
 <B4D29110-19AF-4378-A933-DDA41D5B2A0B@gmail.com>
 <20170508194931.GB7367@julius>
 <8AE6E08C-5E9B-4166-AD82-EB57DF4CAE5C@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="TiqCXmo5T1hvSQQg"
In-Reply-To: <8AE6E08C-5E9B-4166-AD82-EB57DF4CAE5C@gmail.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--TiqCXmo5T1hvSQQg
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 08, 2017 at 04:09:16PM -0400, Karl MacMillan wrote:
>=20
> > On May 8, 2017, at 3:49 PM, Dominick Grift <dac.override@gmail.com> wro=
te:
> >=20
> > On Mon, May 08, 2017 at 03:36:21PM -0400, Karl MacMillan wrote:
> >>=20
> >>>=20
> >>=20
> >> I think it=E2=80=99s best to think of these as having three basic laye=
rs:
> >>=20
> >> 1. Basic tools for SELinux policy analysis in Jupyter - these are usab=
le for any policy and make no assumptions about the presence of any types, =
attributes, object classes, or permissions. So things like the rule searchi=
ng and information flow analysis fit into this group. This is a large part =
of the value of SPAN.
> >>=20
> >> 2. Higher-level policy analysis methods - these are things like the do=
main_types method and the domain / type summaries. These make some minimal =
assumptions about attributes like domain. I=E2=80=99ll just mention that th=
ese assumptions are very minimal and have been around for a _long_ time. Do=
main long pre-dates the reference policy, for example. More than attributes=
 this layer is tied to the Linux object classes and permissions.
> >>=20
> >> 3. Example notebooks - the two example notebooks are just that - examp=
les. They probably provide a useful starting point, but as Josh points out,=
 should simply be modified for your specific use case.
> >>=20
> >> So the question, then, is should the second layer (the higher-level po=
licy analysis methods) be made configurable. Honestly I think it would be m=
ore work than just creating your own versions for a policy that breaks the =
assumptions. To me, that=E2=80=99s the great advantage of this versus other=
 analysis tools. It=E2=80=99s so simple to create quick tools that meet you=
r needs. And given that the vast majority of Linux and Android systems meet=
 the assumptions I think that this is a reasonable approach.
> >=20
> > I don't think it will work with android. Some of it maybe but not all o=
f it. for example the source functionality appends "modules" to the search =
path. So i suspect that will break that functionality for Android.
>=20
> We=E2=80=99ve not tested it for Android policies so I=E2=80=99m sure ther=
e will be some breakage. But I hope it will be fixed to work by us or someo=
ne soon.
>=20
> > Thank you for giving me your opinion. At least now I know where I stand.
>=20
> Where you stand? I=E2=80=99m not certain what you mean and was not trying=
 to say something about you personally.

I didnt take it personal, That is not what I meant. To me SELinux is bigger=
 then any single policy be it refpolicy, sepolicy, or dssp
The perfect tool would support any policy (setools goes a long way there). =
=46rom your comments I sensed that you might not fully agree with that or t=
hat you might not have the ambition for SPAN to be perfect.
What I am saying is that after your comment I no longer have any illusions =
that SPAN will ever be perfect (or close to perfect)

>=20
> I was not familiar with DSSP before (I=E2=80=99ve not done much with SELi=
nux for a while), but Josh pointed it out to me. From looking at it very br=
iefly and thinking through the assumptions in SPAN my guess is that it woul=
d take very few changes to make SPAN work with DSSP, even the source policy=
 stuff (which, honestly, is just a very small part mainly useful for diffin=
g constraints).
>=20
> And as a side note - it=E2=80=99s nice to see someone trying to write a p=
olicy from scratch in CIL. Do you have a =E2=80=9Cdomain=E2=80=9D attribute=
 or at least a similar concept?

Sure, but i cannot use "domain" for this because DSSP leverages namespaces.=
 The equivalent in DSSP is "subj.subj_type_attribute"

So if the configuration file would have something like:

# process_types =3D domain

Then i would be happy because then i could edit it like:

process_types =3D subj.subj_type_attribute

>=20
> > I will not be able to leverage this solution to any significant extend,=
 and the notebook and its depenedencies are pretty expensive to have just f=
or something that only works to some extent.
>=20
> I=E2=80=99m curious what you mean by =E2=80=9Conly works to some extent=
=E2=80=9D. Any bug reports would be welcome.

Let me rephrase then: "not to the fullest extent"

But you gave me the impression that not all bug reports would be "welcome" =
when you said: "the vast majority of Linux and Android systems meet the ass=
umptions I think that this is a reasonable approach."

>=20
> And if you mean specifically in the context of DSSP, like I said I bet th=
e changes would be minimal. So if you are interested in giving it a try I=
=E2=80=99ll be happy to look at the changes needed and give you a hand.

I agree, and ive said that when I said: "a few rough edges" Its close the u=
sable with DSSP. It just needs to deal with some of the current assumptions:

ill point out some:

1. return self.grep(name, "*.te", self.modules_path) # what about .cil suff=
ixed files?
2. return self.find_def("attribute " + name) # in CIL this is typeattribute
3. return self.grep(type_name, "*.fc", self.modules_path) # CIL has its con=
text specs in the .cil suffixed file
4.=20
return self.diff_relative("/policy/mls", other_source) # these should be cu=
stomizable
return self.diff_relative("/policy/mcs", other_source) # these should be cu=
stomizable
return self.diff_relative("/policy/constraints", other_source) # these shou=
ld be customizable
5. any references to type attributes should be customizable: ie. process_ty=
pes =3D ... filesystem_types =3D ... etc

>=20
> Thanks - Karl
>=20
> > Atleast this inspired me to implement policy for pip and notebook in my=
 personal security policy. So it was not all in vain.
> >=20
> >>=20
> >> Thanks - Karl
> >>=20
> >>>=20
> >>>>=20
> >>>> --=20
> >>>> Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B=
02
> >>>> https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C=
7B6B02 <https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2=
C7B6B02> <https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1=
D2C7B6B02 <https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F=
1D2C7B6B02>>
> >>>> Dominick Grift
> >>>=20
> >>>=20
> >>>=20
> >>> --=20
> >>> Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B02
> >>> https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7=
B6B02 <https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C=
7B6B02> <https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D=
2C7B6B02 <https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1=
D2C7B6B02>>
> >>> Dominick Grift
> >>=20
> >=20
> > --=20
> > Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B02
> > https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B6=
B02 <https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B=
6B02>
> > Dominick Grift
>=20

--=20
Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B02
https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B6B02
Dominick Grift

--TiqCXmo5T1hvSQQg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCAAdFiEEujmXliIBLFTc2Y4AJXSOVTf5R2kFAlkQ19EACgkQJXSOVTf5
R2nRbQv+PepFIDDKoWcLt6JW4XsXIK1RCV2+5o80It8QZ20WtPhCh8duSdDr6DBn
3FOy9of9WRmrIynMRgLn5ao69+Dt9yiBqU8go616pGFckm/DO8wVnjF5cx0Dkj+C
Kv73uiexQAouIWd+6CYrCkq4KG0jG6Y6NTU18ZhtIj7rTtwD8zGIbe/DD7J/Q10e
3H+K9XvtirstqyrTwW29YiXAn0oENFHBWQc6j5C2cNeiXbHCwgs/g69qT4ZAJqiJ
xZrEd15HgO/nhmF2M5aqRjVBVHVmzlQ5FsVMnOxnuR93apquhWw4Y/7aWGtUfonj
Y6ekykV0OudFx5nAe/LNY0/i8yab6u303c1BuEg8T5YvhLT20inHFL5RAQawgAkq
d7mbLqK0Y4oyAUY1Aeth/fzg5ph/xciqvsNAGzwr1/pH1OzMSwiOjdzcbiLgj9UG
vk8NwwzGMPndKHZSkRb3zgA7WsfhInShmFX1sGIUiI1/JL5WdMcv6l18juRKW32G
Maqf86eS
=nGAT
-----END PGP SIGNATURE-----

--TiqCXmo5T1hvSQQg--
