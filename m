Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v44Jj3JX011450
 for <selinux@tycho.nsa.gov>; Thu, 4 May 2017 15:45:03 -0400
Received: by mail-wm0-f48.google.com with SMTP id w64so6493039wma.0
 for <selinux@tycho.nsa.gov>; Thu, 04 May 2017 12:44:40 -0700 (PDT)
Received: from julius (84-245-30-81.dsl.cambrium.nl. [84.245.30.81])
 by smtp.gmail.com with ESMTPSA id c47sm1301586ede.32.2017.05.04.12.44.38
 for <selinux@tycho.nsa.gov>
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 04 May 2017 12:44:38 -0700 (PDT)
Date: Thu, 4 May 2017 21:44:37 +0200
From: Dominick Grift <dac.override@gmail.com>
To: selinux@tycho.nsa.gov
Subject: Re: Policy capabilities: when to use and complications with using
Message-ID: <20170504194437.GF29905@julius>
References: <1493828056.15269.9.camel@tycho.nsa.gov>
 <20170503165137.GA15940@julius>
 <CAHC9VhRizNfJBVBYdbE3m2b6ik0VdcDHntSDTEDqfZisk5_YAg@mail.gmail.com>
 <20170504174240.GD29905@julius> <20170504175031.GE29905@julius>
 <a6d7dd71-9951-93e8-d9b5-22f4775badb2@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Zs/RYxT/hKAHzkfQ"
In-Reply-To: <a6d7dd71-9951-93e8-d9b5-22f4775badb2@redhat.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--Zs/RYxT/hKAHzkfQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 04, 2017 at 09:22:22PM +0200, Petr Lautrbach wrote:
> On 05/04/2017 07:50 PM, Dominick Grift wrote:
> > On Thu, May 04, 2017 at 07:42:40PM +0200, Dominick Grift wrote:
> >> On Thu, May 04, 2017 at 11:50:15AM -0400, Paul Moore wrote:
> >>> On Wed, May 3, 2017 at 12:51 PM, Dominick Grift <dac.override@gmail.c=
om> wrote:
> >>>> On Wed, May 03, 2017 at 12:14:16PM -0400, Stephen Smalley wrote:
> >>>>> Part of the reason that we tend to not introduce a new policy
> >>>>> capability more often is that it is painful to do so currently.  We
> >>>>> have to patch libsepol to recognize the new capability and patch the
> >>>>> policy to declare it (although for the latter we can now declare th=
em
> >>>>> via a CIL module without modifying the base policy).  And since the
> >>>>> policy or module won't build without the updated libsepol, we can't
> >>>>> turn on the capability by default in refpolicy without making it
> >>>>> dependent on a new libsepol version.  That's why extended_socket_cl=
ass
> >>>>> isn't yet enabled in refpolicy, for example.  That causes enablement
> >>>>> and adoption to lag behind.  It also makes it harder to test the new
> >>>>> kernel feature in the first place.
> >>>>
> >>>> I would like to see Fedora package the RC's in Rawhide as well (othe=
r distributions could help by packaging the RC's in unstable as well). That=
 would atleast make the RC's a bit more accessible.
> >>>> In Fedora it is usually not the kernel that is the problem, it is us=
er space that is generally to old. And as you've said policy is no longer a=
 problem with CIL.
> >>>
> >>> [NOTE: I'm still thinking about the rest of Stephen's email, and the
> >>> follow up comments, but I wanted to reply to this particular comment
> >>> separately.]
> >>>
> >>> I'm not sure I want to see SELinux userspace release candidates in
> >>> normal Rawhide, but I think creating a COPR repository to
> >>> build/distribute release candidates could be a good thing.  We already
> >>> do something similar for the kernel patches and it has been helpful in
> >>> my opinion.
> >>
> >> Thanks, Yes i suppose you are right. Release Candidates would probably=
 potentially cause too much disruption even in Rawhide.
> >> COPR should do the job, although will not be as accessible as Rawhide.=
 It won't get the same kind of attention, but it will do for me.
> >=20
> > With COPR though we might be able to package more frequent and not just=
 RC's (weekly's/nightly's)? If that can somehow be automated  then we also =
do not have to worrie so much about keeping things maintained over time
>=20
>=20
> I'm just building new set of updates in my COPR plautrba/selinux
> repository [1]. It's based on latest upstream sources with some Fedora
> patches on the top of it currently tracked in my github tree [2]. But
> there are some problems and it's not ready yet.

Most of the fedora specific patches I will probably not be able to test. I =
don't (can't) use semanage, policycoreutils-GUI etc.
I am mainly able to test libselinux, libsepol and policycoreutils

>=20
> I used to build vanilla upstream sources [3] but the latest build is 15
> months old. I can restart this project if there's an interest.

That would be nice, especially if it could be automated. So that I have som=
e kind of assurance that it is maintained.
I dont add COPRs much but when i do i intent to keep using them consistentl=
y. I wouldnt want to have dead COPR repositories to worry about.

>=20
> Since COPR provides API with an authentication token, builds can
> automated and I have few scripts I used before.
>=20
> I think it could even work for Rawhide with less frequent update cycle.

I would prefer Rawhide because then we reach a broader audience.

>=20
> [1] https://copr.fedorainfracloud.org/coprs/plautrba/selinux/
> [2] https://github.com/bachradsusi/selinux/tree/WIP-master
> [3] https://copr.fedorainfracloud.org/coprs/plautrba/selinux-master/build=
s/
>=20
> Petr

Thanks!

--=20
Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B02
https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B6B02
Dominick Grift

--Zs/RYxT/hKAHzkfQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCAAdFiEEujmXliIBLFTc2Y4AJXSOVTf5R2kFAlkLhKAACgkQJXSOVTf5
R2ln6gv9G+STUo6YAw5r5YEq/Qw1wZH1c+xodagvIlNut49d1X7YxBYKeYywImji
EFRA4IiNEWx6WPvl5x9ajn2OjVHFYUgLgo0MvL/jAc5JgdaDawFgiNCViZUyzYXw
5JmG52iPnc1W5oKCVKliQs4/xEXvc139BWqbsRwNbvY6ugibsedJznnt8wTs3wqo
eECxCpgD1mgbLuAu4WPTW+HL8nooN2RY3XCOmF1fyDLeFrmxANRaseisQhxYjvbg
4xC6SVROegYAFT+eNYfeUsGNVum7z76R9AldbuYecY2Sx/4ft429Vr3U5Z4JH9Te
/fMHhS4dd05dItOiqzk6Kffk2MXnDoez/XHfd6xyMM/+omhjd7XUGQPAAbZO0esW
kMtinyEMpLgvgeb8SBDTlWk0ZXLeao49jLQzchayt1PshGwqJr5yFjF0dWS6GrWm
uixBioIylckHHV0NxTaFdV5/VdP+hUzxQoPxZvRHQNaVmS1tURqTOVPJWFV54W34
11bR1GyB
=9Igm
-----END PGP SIGNATURE-----

--Zs/RYxT/hKAHzkfQ--
