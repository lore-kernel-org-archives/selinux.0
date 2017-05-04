Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v44HgkgI003872
 for <selinux@tycho.nsa.gov>; Thu, 4 May 2017 13:42:47 -0400
Received: by mail-wm0-f68.google.com with SMTP id u65so4883315wmu.3
 for <selinux@tycho.nsa.gov>; Thu, 04 May 2017 10:42:44 -0700 (PDT)
Received: from julius (84-245-30-81.dsl.cambrium.nl. [84.245.30.81])
 by smtp.gmail.com with ESMTPSA id t4sm768393edh.5.2017.05.04.10.42.42
 for <selinux@tycho.nsa.gov>
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 04 May 2017 10:42:42 -0700 (PDT)
Date: Thu, 4 May 2017 19:42:40 +0200
From: Dominick Grift <dac.override@gmail.com>
To: selinux@tycho.nsa.gov
Subject: Re: Policy capabilities: when to use and complications with using
Message-ID: <20170504174240.GD29905@julius>
References: <1493828056.15269.9.camel@tycho.nsa.gov>
 <20170503165137.GA15940@julius>
 <CAHC9VhRizNfJBVBYdbE3m2b6ik0VdcDHntSDTEDqfZisk5_YAg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="mJm6k4Vb/yFcL9ZU"
In-Reply-To: <CAHC9VhRizNfJBVBYdbE3m2b6ik0VdcDHntSDTEDqfZisk5_YAg@mail.gmail.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--mJm6k4Vb/yFcL9ZU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 04, 2017 at 11:50:15AM -0400, Paul Moore wrote:
> On Wed, May 3, 2017 at 12:51 PM, Dominick Grift <dac.override@gmail.com> =
wrote:
> > On Wed, May 03, 2017 at 12:14:16PM -0400, Stephen Smalley wrote:
> >> Part of the reason that we tend to not introduce a new policy
> >> capability more often is that it is painful to do so currently.  We
> >> have to patch libsepol to recognize the new capability and patch the
> >> policy to declare it (although for the latter we can now declare them
> >> via a CIL module without modifying the base policy).  And since the
> >> policy or module won't build without the updated libsepol, we can't
> >> turn on the capability by default in refpolicy without making it
> >> dependent on a new libsepol version.  That's why extended_socket_class
> >> isn't yet enabled in refpolicy, for example.  That causes enablement
> >> and adoption to lag behind.  It also makes it harder to test the new
> >> kernel feature in the first place.
> >
> > I would like to see Fedora package the RC's in Rawhide as well (other d=
istributions could help by packaging the RC's in unstable as well). That wo=
uld atleast make the RC's a bit more accessible.
> > In Fedora it is usually not the kernel that is the problem, it is user =
space that is generally to old. And as you've said policy is no longer a pr=
oblem with CIL.
>=20
> [NOTE: I'm still thinking about the rest of Stephen's email, and the
> follow up comments, but I wanted to reply to this particular comment
> separately.]
>=20
> I'm not sure I want to see SELinux userspace release candidates in
> normal Rawhide, but I think creating a COPR repository to
> build/distribute release candidates could be a good thing.  We already
> do something similar for the kernel patches and it has been helpful in
> my opinion.

Thanks, Yes i suppose you are right. Release Candidates would probably pote=
ntially cause too much disruption even in Rawhide.
COPR should do the job, although will not be as accessible as Rawhide. It w=
on't get the same kind of attention, but it will do for me.

>=20
> https://copr.fedorainfracloud.org
> https://copr.fedorainfracloud.org/coprs/pcmoore/kernel-secnext
>=20
> --=20
> paul moore
> www.paul-moore.com

--=20
Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B02
https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B6B02
Dominick Grift

--mJm6k4Vb/yFcL9ZU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCAAdFiEEujmXliIBLFTc2Y4AJXSOVTf5R2kFAlkLaAwACgkQJXSOVTf5
R2lkjAv8C9Q8WkpUeEc3WWoPE57b9sFMMzBtQRuCQ3F1cuGzBSLqLur2pCr0bxDw
zfr8rX1uRkdDBgSKuc53xcBZQi0Zc8jb7sEfsNeZLcAQ4Jah/COjHhprMeE6/u8h
qlBVxtQTYMy6Hwpi9e2d0KFeBLyVNfoUKxqfkOoxrGnJxb+Gt03Rk6TNI1p/FhPy
Pd+tzpNWMksubPSl15YRywGC6xXJsvGzuHguFyPDFKKgFf1tSBpm9IVM82IPWfeo
sGePPeOiOjxFDiSQHpBa9g20fQopt6O/FFKlIbGfaYoIBY1wRbtRZhdSyL4zBAOL
WtcQzv29zX1blN9ERL2+sPKqjAHNOH+dy5oPFfOnoWF6xfn53+Yos+nBYSoD1u7o
NQqx7lL/SHxFJRdvE8i/yh9VU0u1Nv3RSSCQCEjRt/oDG82y6TSWke2ihcXn4MBw
syfEK2FOXpw+m8u24onGqHWpeBWEqD/kyYhA8nmWi4DKZXRORenP6UUBCSewlV2W
kUihAL0+
=lofl
-----END PGP SIGNATURE-----

--mJm6k4Vb/yFcL9ZU--
