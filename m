Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v49GFw4f002180
 for <selinux@tycho.nsa.gov>; Tue, 9 May 2017 12:15:58 -0400
Received: by mail-lf0-f46.google.com with SMTP id 99so4943841lfu.1
 for <selinux@tycho.nsa.gov>; Tue, 09 May 2017 09:15:47 -0700 (PDT)
Received: from julius (84-245-30-81.dsl.cambrium.nl. [84.245.30.81])
 by smtp.gmail.com with ESMTPSA id b3sm447469ede.9.2017.05.09.09.15.44
 for <selinux@tycho.nsa.gov>
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 09 May 2017 09:15:44 -0700 (PDT)
Date: Tue, 9 May 2017 18:15:43 +0200
From: Dominick Grift <dac.override@gmail.com>
To: selinux@tycho.nsa.gov
Subject: Re: Announcing SPAN: SELinux Policy Analysis Notebook
Message-ID: <20170509161543.GA13560@julius>
References: <590F3B98.406@quarksecurity.com> <20170507154759.GA31890@julius>
 <590F78BA.5040800@quarksecurity.com> <20170508085555.GA3701@julius>
 <20170508093229.GB3701@julius>
 <B4D29110-19AF-4378-A933-DDA41D5B2A0B@gmail.com>
 <20170508194931.GB7367@julius>
 <8AE6E08C-5E9B-4166-AD82-EB57DF4CAE5C@gmail.com>
 <20170508204053.GC7367@julius>
 <DFEFDD50-622F-4563-BE88-114B90B49B8F@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="xHFwDpU9dbj6ez1V"
In-Reply-To: <DFEFDD50-622F-4563-BE88-114B90B49B8F@gmail.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--xHFwDpU9dbj6ez1V
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 09, 2017 at 11:21:23AM -0400, Karl MacMillan wrote:
>=20
> > On May 8, 2017, at 4:40 PM, Dominick Grift <dac.override@gmail.com> wro=
te:
> >=20
> > On Mon, May 08, 2017 at 04:09:16PM -0400, Karl MacMillan wrote:
> >>=20
> >>> On May 8, 2017, at 3:49 PM, Dominick Grift <dac.override@gmail.com> w=
rote:
> >>>=20
> >>> On Mon, May 08, 2017 at 03:36:21PM -0400, Karl MacMillan wrote:
> >>>>=20
> >>>>>=20
> >>>>=20
> >>>> I think it=E2=80=99s best to think of these as having three basic la=
yers:
> >>>>=20
> >>>> 1. Basic tools for SELinux policy analysis in Jupyter - these are us=
able for any policy and make no assumptions about the presence of any types=
, attributes, object classes, or permissions. So things like the rule searc=
hing and information flow analysis fit into this group. This is a large par=
t of the value of SPAN.
> >>>>=20
> >>>> 2. Higher-level policy analysis methods - these are things like the =
domain_types method and the domain / type summaries. These make some minima=
l assumptions about attributes like domain. I=E2=80=99ll just mention that =
these assumptions are very minimal and have been around for a _long_ time. =
Domain long pre-dates the reference policy, for example. More than attribut=
es this layer is tied to the Linux object classes and permissions.
> >>>>=20
> >>>> 3. Example notebooks - the two example notebooks are just that - exa=
mples. They probably provide a useful starting point, but as Josh points ou=
t, should simply be modified for your specific use case.
> >>>>=20
> >>>> So the question, then, is should the second layer (the higher-level =
policy analysis methods) be made configurable. Honestly I think it would be=
 more work than just creating your own versions for a policy that breaks th=
e assumptions. To me, that=E2=80=99s the great advantage of this versus oth=
er analysis tools. It=E2=80=99s so simple to create quick tools that meet y=
our needs. And given that the vast majority of Linux and Android systems me=
et the assumptions I think that this is a reasonable approach.
> >>>=20
> >>> I don't think it will work with android. Some of it maybe but not all=
 of it. for example the source functionality appends "modules" to the searc=
h path. So i suspect that will break that functionality for Android.
> >>=20
> >> We=E2=80=99ve not tested it for Android policies so I=E2=80=99m sure t=
here will be some breakage. But I hope it will be fixed to work by us or so=
meone soon.
> >>=20
> >>> Thank you for giving me your opinion. At least now I know where I sta=
nd.
> >>=20
> >> Where you stand? I=E2=80=99m not certain what you mean and was not try=
ing to say something about you personally.
> >=20
> > I didnt take it personal, That is not what I meant. To me SELinux is bi=
gger then any single policy be it refpolicy, sepolicy, or dssp
> > The perfect tool would support any policy (setools goes a long way ther=
e). From your comments I sensed that you might not fully agree with that or=
 that you might not have the ambition for SPAN to be perfect.
> > What I am saying is that after your comment I no longer have any illusi=
ons that SPAN will ever be perfect (or close to perfect)
> >=20
>=20
> Shrug. SELinux is =E2=80=9Cbigger=E2=80=9D than the current set of object=
 classes and access vectors or the components of the security context. Yet =
we still have to write policy using those. Abstraction is a useful tool, bu=
t too much abstraction interferes with getting work done clearly.
>=20
> Ultimately SPAN has to make some assumptions about how policy works to do=
 any higher-level analysis (a problem that SETools doesn=E2=80=99t really h=
ave because it doesn=E2=80=99t do much of the higher-level analysis that I=
=E2=80=99m talking about). Making that somewhat configurable is fine, but n=
ot at the cost of comprehensibility. When we hit that point it=E2=80=99s be=
tter just to split the higher-level analysis methods into different version=
s based the policy type.
>=20
> Either way, I=E2=80=99m open to including the customizations or separate =
code in SPAN.
>=20
> >>=20
> >> I was not familiar with DSSP before (I=E2=80=99ve not done much with S=
ELinux for a while), but Josh pointed it out to me. From looking at it very=
 briefly and thinking through the assumptions in SPAN my guess is that it w=
ould take very few changes to make SPAN work with DSSP, even the source pol=
icy stuff (which, honestly, is just a very small part mainly useful for dif=
fing constraints).
> >>=20
> >> And as a side note - it=E2=80=99s nice to see someone trying to write =
a policy from scratch in CIL. Do you have a =E2=80=9Cdomain=E2=80=9D attrib=
ute or at least a similar concept?
> >=20
> > Sure, but i cannot use "domain" for this because DSSP leverages namespa=
ces. The equivalent in DSSP is =E2=80=9Csubj.subj_type_attribute"
> >=20
>=20
> This is just my opinion of course, but it seems counterproductive to put =
what is clearly a global concept into a namespace. And _every_ policy that =
I know of for something like two decades has had a domain attribute. Do you=
 really get enough benefits out of this change to outweigh the pain caused =
by changing such a long-running convention?
>=20
> > So if the configuration file would have something like:
> >=20
> > # process_types =3D domain
> >=20
> > Then i would be happy because then i could edit it like:
> >=20
> > process_types =3D subj.subj_type_attribute
> >=20
>=20
> I just committed a change that adds a domain_attribute instance variable =
into the Policy class, allowing you to change this. You would use it like t=
his:
>=20
> p =3D span.load_policy(=E2=80=9Csome_dssp_policy.cil=E2=80=9D)
> p.domain_attribute =3D =E2=80=9Csubj.subj_type_attribute=E2=80=9D
> p.domain_types() # This now looks for the subj.subj_type_attribute instea=
d of domain

Thanks!

I spent all day working on my analysis of unconfined access: https://github=
=2Ecom/DefenSec/dssp2-standard/blob/master/Analysis_of_unconfined_access.ip=
ynb

Its not so easy:

1. first i had to get familiar with notebook and aqcuire in a such a way th=
at i can use it
2. then i had to get familiar with span
3. in order to use span i have to get familiar with python (i do not like p=
ython but this endevour does push me to play with it more)
4. then i have to actually use span to get some useful and much needed anal=
ysis done in DSSP
5. then i have to maintain DSSP is self (which isnt an attempt to write cil=
 policy from scratch i might add, its a policy that i use)

if and once i get to any significant extent productive with python then spa=
n will probably be the first project i contribute to. Since my python skill=
 is 0.75 and since theres only 24 hours in a day it probably, unfortunately=
, wont happen overnight


As for the domain vs subj.subj_type_attribute issue: i think it is worth it=
 yes.

Having a small set of consistent type attributes that get additional meanin=
g by using them in different name spaces.

subj.subj_type_attribute (any process)
user.subj_type_attribute (any user process
user.unpriv.subj_type_attribute (any unpriv user process)

i have hundreds of these in DSSP. Theyre pretty much all consistently named.

>=20
> If you want to send patches for similar changes I=E2=80=99ll be happy to =
review them.
>=20
> Note that a configuration file is not really appropriate I don=E2=80=99t =
think. This is a Python library and it=E2=80=99s better to just do the conf=
iguration in code. If you have several changes that are needed for a dssp p=
olicy feel free to propose a load_dssp_policy top-level function that sets =
the defaults as necessary.
>=20
> >>=20
> >>> I will not be able to leverage this solution to any significant exten=
d, and the notebook and its depenedencies are pretty expensive to have just=
 for something that only works to some extent.
> >>=20
> >> I=E2=80=99m curious what you mean by =E2=80=9Conly works to some exten=
t=E2=80=9D. Any bug reports would be welcome.
> >=20
> > Let me rephrase then: "not to the fullest extent"
> >=20
> > But you gave me the impression that not all bug reports would be "welco=
me" when you said: "the vast majority of Linux and Android systems meet the=
 assumptions I think that this is a reasonable approach.=E2=80=9D
> >=20
>=20
> These are not =E2=80=9Cbugs=E2=80=9D they are design decisions to priorit=
ize the policies that are on shipping systems.
>=20
> I=E2=80=99m open to contributions, but can=E2=80=99t really add support f=
or DSSP on my own as I have no experience with it.
>=20
> >>=20
> >> And if you mean specifically in the context of DSSP, like I said I bet=
 the changes would be minimal. So if you are interested in giving it a try =
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
> > 2. return self.find_def("attribute " + name) # in CIL this is typeattri=
bute
> > 3. return self.grep(type_name, "*.fc", self.modules_path) # CIL has its=
 context specs in the .cil suffixed file
> > 4.=20
> > return self.diff_relative("/policy/mls", other_source) # these should b=
e customizable
> > return self.diff_relative("/policy/mcs", other_source) # these should b=
e customizable
> > return self.diff_relative("/policy/constraints", other_source) # these =
should be customizable
>=20
> These are from the small policy source object - which is very tied to ref=
erence policy. I=E2=80=99ve just renamed that to RefPolicySource. Feel free=
 to send a patch to add a DsspPolicySource.
>=20
> > 5. any references to type attributes should be customizable: ie. proces=
s_types =3D ... filesystem_types =3D =E2=80=A6 etc
> >=20
>=20
> The only one I really saw was domain, which I=E2=80=99ve made configurabl=
e. But I didn=E2=80=99t search exhaustively. Again, feel free to send patch=
es.
>=20
> Thanks - Karl
>=20
> >>=20
> >> Thanks - Karl
> >>=20
> >>> Atleast this inspired me to implement policy for pip and notebook in =
my personal security policy. So it was not all in vain.
> >>>=20
> >>>>=20
> >>>> Thanks - Karl
> >>>>=20
> >>>>>=20
> >>>>>>=20
> >>>>>> --=20
> >>>>>> Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B =
6B02
> >>>>>> https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D=
2C7B6B02 <https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1=
D2C7B6B02> <https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5=
F1D2C7B6B02 <https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C=
5F1D2C7B6B02>>
> >>>>>> Dominick Grift
> >>>>>=20
> >>>>>=20
> >>>>>=20
> >>>>> --=20
> >>>>> Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6=
B02
> >>>>> https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2=
C7B6B02 <https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D=
2C7B6B02> <https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F=
1D2C7B6B02 <https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5=
F1D2C7B6B02>>
> >>>>> Dominick Grift
> >>>>=20
> >>>=20
> >>> --=20
> >>> Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B02
> >>> https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7=
B6B02 <https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C=
7B6B02>
> >>> Dominick Grift
> >>=20
> >=20
> > --=20
> > Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B02
> > https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B6=
B02
> > Dominick Grift
>=20

--=20
Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B02
https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B6B02
Dominick Grift

--xHFwDpU9dbj6ez1V
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCAAdFiEEujmXliIBLFTc2Y4AJXSOVTf5R2kFAlkR6ysACgkQJXSOVTf5
R2kzAwwAlYCiY9wRhevvyMBhbnrY0oGQMo6uWhBIbSKVuGth3YPyyx3dvCYyDssr
7A1K4INKJoRxdXOYxUlp0VytyfIcZpNMIJuaNGmFR2R+AaWt8QwbpH4snuArDwVF
7p9e1Kz5KCkEEZrQYZhNKQje85sFvr2hsGzwMnX5eTmgiPj7Ad0aVVWgUhgiqKnm
KcBjfJMAQdaks8NLhwavAbvs4EiIl/C5+F+hW9oE/aPikI3nWZ2/nVHs1h1TV82s
USI6bWHcIK4ASE+cCnUjK5KAGtkLqsrkY7m5ywaHMqtHr1bGD3xBlCpMiaWyvxp/
8NQ5vzcagz3KwUJiP3HZjMtR7lEM8YebCs+y83onh6RGxLVbjtQYOrgGxEelNAVM
H4neuDRDgeqEws7XZiizzo5qraBelGBmKPa2pFUE/N6bZL6rKLwqMZZZY0kYei93
sXsycUyZXlpVT8UFd64sgSwG2hWYRoqb/Z0bx4SaJ3WxedsmtWERtVakr3Z8WQGV
MTfxYkFo
=GSGm
-----END PGP SIGNATURE-----

--xHFwDpU9dbj6ez1V--
