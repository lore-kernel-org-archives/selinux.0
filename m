Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v49HjGY5003092
 for <selinux@tycho.nsa.gov>; Tue, 9 May 2017 13:45:19 -0400
Received: by mail-wr0-f169.google.com with SMTP id l9so9284245wre.1
 for <selinux@tycho.nsa.gov>; Tue, 09 May 2017 10:45:11 -0700 (PDT)
Received: from julius (84-245-30-81.dsl.cambrium.nl. [84.245.30.81])
 by smtp.gmail.com with ESMTPSA id e11sm268197edd.68.2017.05.09.10.45.02
 for <selinux@tycho.nsa.gov>
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 09 May 2017 10:45:02 -0700 (PDT)
Date: Tue, 9 May 2017 19:45:00 +0200
From: Dominick Grift <dac.override@gmail.com>
To: selinux@tycho.nsa.gov
Subject: Re: Announcing SPAN: SELinux Policy Analysis Notebook
Message-ID: <20170509174500.GC13560@julius>
References: <590F78BA.5040800@quarksecurity.com> <20170508085555.GA3701@julius>
 <20170508093229.GB3701@julius>
 <B4D29110-19AF-4378-A933-DDA41D5B2A0B@gmail.com>
 <20170508194931.GB7367@julius>
 <8AE6E08C-5E9B-4166-AD82-EB57DF4CAE5C@gmail.com>
 <20170508204053.GC7367@julius>
 <DFEFDD50-622F-4563-BE88-114B90B49B8F@gmail.com>
 <20170509161543.GA13560@julius> <20170509164755.GB13560@julius>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="+nBD6E3TurpgldQp"
In-Reply-To: <20170509164755.GB13560@julius>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--+nBD6E3TurpgldQp
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 09, 2017 at 06:47:55PM +0200, Dominick Grift wrote:
> On Tue, May 09, 2017 at 06:15:43PM +0200, Dominick Grift wrote:
> > On Tue, May 09, 2017 at 11:21:23AM -0400, Karl MacMillan wrote:
> > >=20
> > > > On May 8, 2017, at 4:40 PM, Dominick Grift <dac.override@gmail.com>=
 wrote:
> > > >=20
> > > > On Mon, May 08, 2017 at 04:09:16PM -0400, Karl MacMillan wrote:
> > > >>=20
> > > >>> On May 8, 2017, at 3:49 PM, Dominick Grift <dac.override@gmail.co=
m> wrote:
> > > >>>=20
> > > >>> On Mon, May 08, 2017 at 03:36:21PM -0400, Karl MacMillan wrote:
> > > >>>>=20
> > > >>>>>=20
> > > >>>>=20
> > > >>>> I think it=E2=80=99s best to think of these as having three basi=
c layers:
> > > >>>>=20
> > > >>>> 1. Basic tools for SELinux policy analysis in Jupyter - these ar=
e usable for any policy and make no assumptions about the presence of any t=
ypes, attributes, object classes, or permissions. So things like the rule s=
earching and information flow analysis fit into this group. This is a large=
 part of the value of SPAN.
> > > >>>>=20
> > > >>>> 2. Higher-level policy analysis methods - these are things like =
the domain_types method and the domain / type summaries. These make some mi=
nimal assumptions about attributes like domain. I=E2=80=99ll just mention t=
hat these assumptions are very minimal and have been around for a _long_ ti=
me. Domain long pre-dates the reference policy, for example. More than attr=
ibutes this layer is tied to the Linux object classes and permissions.
> > > >>>>=20
> > > >>>> 3. Example notebooks - the two example notebooks are just that -=
 examples. They probably provide a useful starting point, but as Josh point=
s out, should simply be modified for your specific use case.
> > > >>>>=20
> > > >>>> So the question, then, is should the second layer (the higher-le=
vel policy analysis methods) be made configurable. Honestly I think it woul=
d be more work than just creating your own versions for a policy that break=
s the assumptions. To me, that=E2=80=99s the great advantage of this versus=
 other analysis tools. It=E2=80=99s so simple to create quick tools that me=
et your needs. And given that the vast majority of Linux and Android system=
s meet the assumptions I think that this is a reasonable approach.
> > > >>>=20
> > > >>> I don't think it will work with android. Some of it maybe but not=
 all of it. for example the source functionality appends "modules" to the s=
earch path. So i suspect that will break that functionality for Android.
> > > >>=20
> > > >> We=E2=80=99ve not tested it for Android policies so I=E2=80=99m su=
re there will be some breakage. But I hope it will be fixed to work by us o=
r someone soon.
> > > >>=20
> > > >>> Thank you for giving me your opinion. At least now I know where I=
 stand.
> > > >>=20
> > > >> Where you stand? I=E2=80=99m not certain what you mean and was not=
 trying to say something about you personally.
> > > >=20
> > > > I didnt take it personal, That is not what I meant. To me SELinux i=
s bigger then any single policy be it refpolicy, sepolicy, or dssp
> > > > The perfect tool would support any policy (setools goes a long way =
there). From your comments I sensed that you might not fully agree with tha=
t or that you might not have the ambition for SPAN to be perfect.
> > > > What I am saying is that after your comment I no longer have any il=
lusions that SPAN will ever be perfect (or close to perfect)
> > > >=20
> > >=20
> > > Shrug. SELinux is =E2=80=9Cbigger=E2=80=9D than the current set of ob=
ject classes and access vectors or the components of the security context. =
Yet we still have to write policy using those. Abstraction is a useful tool=
, but too much abstraction interferes with getting work done clearly.
> > >=20
> > > Ultimately SPAN has to make some assumptions about how policy works t=
o do any higher-level analysis (a problem that SETools doesn=E2=80=99t real=
ly have because it doesn=E2=80=99t do much of the higher-level analysis tha=
t I=E2=80=99m talking about). Making that somewhat configurable is fine, bu=
t not at the cost of comprehensibility. When we hit that point it=E2=80=99s=
 better just to split the higher-level analysis methods into different vers=
ions based the policy type.
> > >=20
> > > Either way, I=E2=80=99m open to including the customizations or separ=
ate code in SPAN.
> > >=20
> > > >>=20
> > > >> I was not familiar with DSSP before (I=E2=80=99ve not done much wi=
th SELinux for a while), but Josh pointed it out to me. From looking at it =
very briefly and thinking through the assumptions in SPAN my guess is that =
it would take very few changes to make SPAN work with DSSP, even the source=
 policy stuff (which, honestly, is just a very small part mainly useful for=
 diffing constraints).
> > > >>=20
> > > >> And as a side note - it=E2=80=99s nice to see someone trying to wr=
ite a policy from scratch in CIL. Do you have a =E2=80=9Cdomain=E2=80=9D at=
tribute or at least a similar concept?
> > > >=20
> > > > Sure, but i cannot use "domain" for this because DSSP leverages nam=
espaces. The equivalent in DSSP is =E2=80=9Csubj.subj_type_attribute"
> > > >=20
> > >=20
> > > This is just my opinion of course, but it seems counterproductive to =
put what is clearly a global concept into a namespace. And _every_ policy t=
hat I know of for something like two decades has had a domain attribute. Do=
 you really get enough benefits out of this change to outweigh the pain cau=
sed by changing such a long-running convention?
>=20
> With DSSP, except for the initial sids i suppose, nothing is global. (see=
 dssp-base) It is modular and if you dont want to differentiate between sub=
ject and object than you can do so with DSSP. It is modular. just remove th=
e subject module and its dependencies. CIL allows one to do this because it=
 makes dependency resolving usable.
>=20
> the subj.subj_type_attribute might sound useless but its part of the bigg=
er picture. Consistency accros the policy (another core concept of dssp is =
comprehensiveness. A lot is the same and this makes writing policy an intui=
tive experience. only the name spaces are different. the macros , attribute=
s are all the same. Not going to deviate from that for "domain"
>=20
> > >=20
> > > > So if the configuration file would have something like:
> > > >=20
> > > > # process_types =3D domain
> > > >=20
> > > > Then i would be happy because then i could edit it like:
> > > >=20
> > > > process_types =3D subj.subj_type_attribute
> > > >=20
> > >=20
> > > I just committed a change that adds a domain_attribute instance varia=
ble into the Policy class, allowing you to change this. You would use it li=
ke this:
> > >=20
> > > p =3D span.load_policy(=E2=80=9Csome_dssp_policy.cil=E2=80=9D)
> > > p.domain_attribute =3D =E2=80=9Csubj.subj_type_attribute=E2=80=9D
> > > p.domain_types() # This now looks for the subj.subj_type_attribute in=
stead of domain
> >=20
> > Thanks!
> >=20
> > I spent all day working on my analysis of unconfined access: https://gi=
thub.com/DefenSec/dssp2-standard/blob/master/Analysis_of_unconfined_access.=
ipynb
> >=20
> > Its not so easy:
> >=20
> > 1. first i had to get familiar with notebook and aqcuire in a such a wa=
y that i can use it
> > 2. then i had to get familiar with span
> > 3. in order to use span i have to get familiar with python (i do not li=
ke python but this endevour does push me to play with it more)
> > 4. then i have to actually use span to get some useful and much needed =
analysis done in DSSP
> > 5. then i have to maintain DSSP is self (which isnt an attempt to write=
 cil policy from scratch i might add, its a policy that i use)
> >=20
> > if and once i get to any significant extent productive with python then=
 span will probably be the first project i contribute to. Since my python s=
kill is 0.75 and since theres only 24 hours in a day it probably, unfortuna=
tely, wont happen overnight
> >=20
> >=20
> > As for the domain vs subj.subj_type_attribute issue: i think it is wort=
h it yes.
> >=20
> > Having a small set of consistent type attributes that get additional me=
aning by using them in different name spaces.
> >=20
> > subj.subj_type_attribute (any process)
> > user.subj_type_attribute (any user process
> > user.unpriv.subj_type_attribute (any unpriv user process)
> >=20
> > i have hundreds of these in DSSP. Theyre pretty much all consistently n=
amed.
> >=20
> > >=20
> > > If you want to send patches for similar changes I=E2=80=99ll be happy=
 to review them.
> > >=20
> > > Note that a configuration file is not really appropriate I don=E2=80=
=99t think. This is a Python library and it=E2=80=99s better to just do the=
 configuration in code. If you have several changes that are needed for a d=
ssp policy feel free to propose a load_dssp_policy top-level function that =
sets the defaults as necessary.
> > >=20
> > > >>=20
> > > >>> I will not be able to leverage this solution to any significant e=
xtend, and the notebook and its depenedencies are pretty expensive to have =
just for something that only works to some extent.
> > > >>=20
> > > >> I=E2=80=99m curious what you mean by =E2=80=9Conly works to some e=
xtent=E2=80=9D. Any bug reports would be welcome.
> > > >=20
> > > > Let me rephrase then: "not to the fullest extent"
> > > >=20
> > > > But you gave me the impression that not all bug reports would be "w=
elcome" when you said: "the vast majority of Linux and Android systems meet=
 the assumptions I think that this is a reasonable approach.=E2=80=9D
> > > >=20
> > >=20
> > > These are not =E2=80=9Cbugs=E2=80=9D they are design decisions to pri=
oritize the policies that are on shipping systems.
> > >=20
> > > I=E2=80=99m open to contributions, but can=E2=80=99t really add suppo=
rt for DSSP on my own as I have no experience with it.

I am not asking you to support DSSP (how can i make this any more clear). I=
 am just asking to not tie your product to a any single policy but instead =
to set the right example.

This idea of yours to split the policy model specifics out of base sounds r=
eally good to me. Nothing wrong with refpolicy specific functionality, but =
just be clear about it and make it optional

I am worried about the precendence here. It starts with a project here and =
there hard-coding policy specifics and branding it "selinux", then some of =
that stuff slips into the upstream and before you know it selinux users spa=
ce becomes unusable with anything but refpolicy unless you strip out half o=
f it like sds did with seandroid.

And then one wonders why SELinux is judged by the policy it is enforcing , =
rather than for what it is: a flexible, customizable framework that allows =
for fine grained MAC

> > >=20
> > > >>=20
> > > >> And if you mean specifically in the context of DSSP, like I said I=
 bet the changes would be minimal. So if you are interested in giving it a =
try I=E2=80=99ll be happy to look at the changes needed and give you a hand.
> > > >=20
> > > > I agree, and ive said that when I said: "a few rough edges" Its clo=
se the usable with DSSP. It just needs to deal with some of the current ass=
umptions:
> > > >=20
> > > > ill point out some:
> > > >=20
> > > > 1. return self.grep(name, "*.te", self.modules_path) # what about .=
cil suffixed files?
> > > > 2. return self.find_def("attribute " + name) # in CIL this is typea=
ttribute
> > > > 3. return self.grep(type_name, "*.fc", self.modules_path) # CIL has=
 its context specs in the .cil suffixed file
> > > > 4.=20
> > > > return self.diff_relative("/policy/mls", other_source) # these shou=
ld be customizable
> > > > return self.diff_relative("/policy/mcs", other_source) # these shou=
ld be customizable
> > > > return self.diff_relative("/policy/constraints", other_source) # th=
ese should be customizable
> > >=20
> > > These are from the small policy source object - which is very tied to=
 reference policy. I=E2=80=99ve just renamed that to RefPolicySource. Feel =
free to send a patch to add a DsspPolicySource.
> > >=20
> > > > 5. any references to type attributes should be customizable: ie. pr=
ocess_types =3D ... filesystem_types =3D =E2=80=A6 etc
> > > >=20
> > >=20
> > > The only one I really saw was domain, which I=E2=80=99ve made configu=
rable. But I didn=E2=80=99t search exhaustively. Again, feel free to send p=
atches.

I think your idea is better. i.e. split the refpolicy specific bits out and=
 put it in python3-span-refpolicy

> > >=20
> > > Thanks - Karl
> > >=20
> > > >>=20
> > > >> Thanks - Karl
> > > >>=20
> > > >>> Atleast this inspired me to implement policy for pip and notebook=
 in my personal security policy. So it was not all in vain.
> > > >>>=20
> > > >>>>=20
> > > >>>> Thanks - Karl
> > > >>>>=20
> > > >>>>>=20
> > > >>>>>>=20
> > > >>>>>> --=20
> > > >>>>>> Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2=
C7B 6B02
> > > >>>>>> https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C=
5F1D2C7B6B02 <https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6=
C5F1D2C7B6B02> <https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3=
B6C5F1D2C7B6B02 <https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x=
3B6C5F1D2C7B6B02>>
> > > >>>>>> Dominick Grift
> > > >>>>>=20
> > > >>>>>=20
> > > >>>>>=20
> > > >>>>> --=20
> > > >>>>> Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C=
7B 6B02
> > > >>>>> https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5=
F1D2C7B6B02 <https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C=
5F1D2C7B6B02> <https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B=
6C5F1D2C7B6B02 <https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3=
B6C5F1D2C7B6B02>>
> > > >>>>> Dominick Grift
> > > >>>>=20
> > > >>>=20
> > > >>> --=20
> > > >>> Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B=
 6B02
> > > >>> https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1=
D2C7B6B02 <https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F=
1D2C7B6B02>
> > > >>> Dominick Grift
> > > >>=20
> > > >=20
> > > > --=20
> > > > Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6=
B02
> > > > https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2=
C7B6B02
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

--+nBD6E3TurpgldQp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCAAdFiEEujmXliIBLFTc2Y4AJXSOVTf5R2kFAlkSABgACgkQJXSOVTf5
R2lOugv/ZVTJgY1Kyv64pl4rJSgrkyXm10SpQXugwn4QQDNmEhAhIiTirfGmWfSk
y7U8uflRL5W/PxN+kG6aBRVza2Y0DSlaku2vUQW4D8q+E6miXqizCq0PAhi5Q8Vm
AWRF8dAly5KQVQGc8DHbF/3XC++61OuCUK8Uf/PCyq85tiNMnLIug8W7Sr52v7Nc
wJ0k2Q3ygGbsegOsP5W/fWaxC38anwgkN6Q2Ee+M17362OQXLWnU3VTX1TfANhMj
U5P0842pSljP3IpmjNlwoOr5OSzv6YVNXBdd2Qtq+zOoUjwjx5Af367/jaA7qBjX
X444RbxFwZ5RahBj2u+Iuvec65sYM2dGp+G+IF7aAbLtB9eFh6DxaR+9igC0W/2e
BHWS4WaTHQ1/hbUz7o61z903RmJEqTXFBQoU0ylQNzhJjv0wu2JmV+3haE1clYm+
tFs8tJa73FkD2U77oKXS2GChIb4ETxqy2S5cMSWEJi7JZbdSDsnZnYA+9EXVQBJ4
6EOOcIGm
=q56L
-----END PGP SIGNATURE-----

--+nBD6E3TurpgldQp--
