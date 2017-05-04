Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v44HobMC006651
 for <selinux@tycho.nsa.gov>; Thu, 4 May 2017 13:50:37 -0400
Received: by mail-wm0-f67.google.com with SMTP id u65so4923389wmu.3
 for <selinux@tycho.nsa.gov>; Thu, 04 May 2017 10:50:34 -0700 (PDT)
Received: from julius (84-245-30-81.dsl.cambrium.nl. [84.245.30.81])
 by smtp.gmail.com with ESMTPSA id b6sm833953eda.46.2017.05.04.10.50.32
 for <selinux@tycho.nsa.gov>
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 04 May 2017 10:50:32 -0700 (PDT)
Date: Thu, 4 May 2017 19:50:31 +0200
From: Dominick Grift <dac.override@gmail.com>
To: selinux@tycho.nsa.gov
Subject: Re: Policy capabilities: when to use and complications with using
Message-ID: <20170504175031.GE29905@julius>
References: <1493828056.15269.9.camel@tycho.nsa.gov>
 <20170503165137.GA15940@julius>
 <CAHC9VhRizNfJBVBYdbE3m2b6ik0VdcDHntSDTEDqfZisk5_YAg@mail.gmail.com>
 <20170504174240.GD29905@julius>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="10jrOL3x2xqLmOsH"
In-Reply-To: <20170504174240.GD29905@julius>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--10jrOL3x2xqLmOsH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 04, 2017 at 07:42:40PM +0200, Dominick Grift wrote:
> On Thu, May 04, 2017 at 11:50:15AM -0400, Paul Moore wrote:
> > On Wed, May 3, 2017 at 12:51 PM, Dominick Grift <dac.override@gmail.com=
> wrote:
> > > On Wed, May 03, 2017 at 12:14:16PM -0400, Stephen Smalley wrote:
> > >> Part of the reason that we tend to not introduce a new policy
> > >> capability more often is that it is painful to do so currently.  We
> > >> have to patch libsepol to recognize the new capability and patch the
> > >> policy to declare it (although for the latter we can now declare them
> > >> via a CIL module without modifying the base policy).  And since the
> > >> policy or module won't build without the updated libsepol, we can't
> > >> turn on the capability by default in refpolicy without making it
> > >> dependent on a new libsepol version.  That's why extended_socket_cla=
ss
> > >> isn't yet enabled in refpolicy, for example.  That causes enablement
> > >> and adoption to lag behind.  It also makes it harder to test the new
> > >> kernel feature in the first place.
> > >
> > > I would like to see Fedora package the RC's in Rawhide as well (other=
 distributions could help by packaging the RC's in unstable as well). That =
would atleast make the RC's a bit more accessible.
> > > In Fedora it is usually not the kernel that is the problem, it is use=
r space that is generally to old. And as you've said policy is no longer a =
problem with CIL.
> >=20
> > [NOTE: I'm still thinking about the rest of Stephen's email, and the
> > follow up comments, but I wanted to reply to this particular comment
> > separately.]
> >=20
> > I'm not sure I want to see SELinux userspace release candidates in
> > normal Rawhide, but I think creating a COPR repository to
> > build/distribute release candidates could be a good thing.  We already
> > do something similar for the kernel patches and it has been helpful in
> > my opinion.
>=20
> Thanks, Yes i suppose you are right. Release Candidates would probably po=
tentially cause too much disruption even in Rawhide.
> COPR should do the job, although will not be as accessible as Rawhide. It=
 won't get the same kind of attention, but it will do for me.

With COPR though we might be able to package more frequent and not just RC'=
s (weekly's/nightly's)? If that can somehow be automated  then we also do n=
ot have to worrie so much about keeping things maintained over time

>=20
> >=20
> > https://copr.fedorainfracloud.org
> > https://copr.fedorainfracloud.org/coprs/pcmoore/kernel-secnext
> >=20
> > --=20
> > paul moore
> > www.paul-moore.com
>=20
> --=20
> Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B02
> https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B6B02
> Dominick Grift



--=20
Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B02
https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B6B02
Dominick Grift

--10jrOL3x2xqLmOsH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCAAdFiEEujmXliIBLFTc2Y4AJXSOVTf5R2kFAlkLaeMACgkQJXSOVTf5
R2ny/Qv/So9ROSI6VlhcsNYkhs5t3dyuwSw+UfMSViyPbtM8kFQQk0J24/gSFrxM
DytycXvUpia9I0Gw3nhJHVvNoQ3Re5opbjhvgnvbw67XSA90Kmwwqjg0voJkzJ3p
a4r0LLPlkXxDb9HvXu8sadx1P9xCdti31e715QTt6cUTHU/XEvXepoHWib72O4Py
G5iNnmtvJRu22I2PUdOCW65RAZs7Iu+MUbOc0c37SyyMYJ1f/v6k5DuQZFLQgdAR
EYkeDFe5udocOqwcA4ma9svvX/LI2KIze2I3+1ZNZnIPtAg8Q+f4OiOxds4VytvL
v9g2ls+CdcrLC+CGk6NJZLffFvOQSBnFnJBwebQKjj4HSWyqgEX+7/lXiAXqyZW2
L8yyCKpng4723aZrELCCvqpgUc0JWyU9nFhH/A1blGIwN84m70WqSQ2ROANdP7Nw
EgLmNwJvJU191jJnT5shBQ4WTi+qdNZFtWgV7dLzspH4hvIxQuQlqmVYuEanPl//
77MquQLa
=q0FO
-----END PGP SIGNATURE-----

--10jrOL3x2xqLmOsH--
