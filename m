Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j13DhL53029822
	for <selinux@tycho.nsa.gov>; Thu, 3 Feb 2005 08:43:21 -0500 (EST)
Received: from vds-320151.amen-pro.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j13DhNf1029782
	for <selinux@tycho.nsa.gov>; Thu, 3 Feb 2005 13:43:23 GMT
Subject: Re: Advice on bringing up SE Linux
From: Lorenzo =?ISO-8859-1?Q?Hern=E1ndez_?= =?ISO-8859-1?Q?Garc=EDa-Hierro?= <lorenzo@gnu.org>
To: russell@coker.com.au
Cc: "Villalovos, John L" <john.l.villalovos@intel.com>,
   Stephen Smalley <sds@epoch.ncsc.mil>, selinux@tycho.nsa.gov
In-Reply-To: <200502031820.54692.russell@coker.com.au>
References: <60C14C611F1DDD4198D53F2F43D8CA3B035B559E@orsmsx410>
	 <200502031820.54692.russell@coker.com.au>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-cgutvPERF0dujW6ZWrGU"
Date: Thu, 03 Feb 2005 14:42:50 +0100
Message-Id: <1107438170.3754.162.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-cgutvPERF0dujW6ZWrGU
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

El jue, 03-02-2005 a las 18:20 +1100, Russell Coker escribi=F3:
> On Wednesday 02 February 2005 07:51, "Villalovos, John L"=20
> <john.l.villalovos@intel.com> wrote:
> > > /sbin/init is what normally loads the policy during startup.  Are you
> > > using the modified /sbin/init (included in Fedora)?  What is in your
> > > /etc/selinux/config?
> >
> > Okay.  We are using Busybox for the init.  So it does not have the SE
> > Linux stuff in it.
>=20
> The upstream developer of busybox was accepting of SE Linux patches, I ha=
d=20
> some SE Linux patches in the busybox CVS at one time (not sure if they ar=
e=20
> still there).  If I get a bit of spare time I'll do some more work on Bus=
ybox=20
> SE Linux support, it's good to have for recovery purposes and I think I'v=
e=20
> still got some patches hanging around that I never got sorted out properl=
y=20
> for release.
>=20
> Also you may want to check out the paper I presented at OLS on getting SE=
=20
> Linux running on iPaQ's, the stuff about wrapping busybox etc will probab=
ly=20
> be of interest to you.
>=20
> If you get the JFFS2 support written I'll be very interested, I have a co=
uple=20
> of iPaQ's I want to get running SE Linux again.

I've been studying the code from both mtd and Linux-2.6 sources of
JFFS2	.
Also talked with some people from the Gentoo project that could help
with it.
We can try to bring up a work module on the SELinux CVS and start doing
something there.

AFAIK, and from the conversations I had with one of the Hardened Gentoo
guys (solar), xattr takes an additional 32bytes or 1 block which makes
it an overhead that needs to be studied, and noticeable on devices with
*limited* storage capacity, such as iPAQs.

Anyways, I would like to discuss this with some kernel hackers before
getting into the job.
The best start is having such device for testing, and I don't own an
iPAQ, also using machine emulators is pretty a crap solution, in my
opinion.
(I have no experience working with ARM, so, sure I'm forgetting
something)

Cheers,
--=20
Lorenzo Hern=E1ndez Garc=EDa-Hierro <lorenzo@gnu.org>=20
[1024D/6F2B2DEC] & [2048g/9AE91A22][http://tuxedo-es.org]

--=-cgutvPERF0dujW6ZWrGU
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Esta parte del mensaje =?ISO-8859-1?Q?est=E1?= firmada
	digitalmente

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBCAipaDcEopW8rLewRAgpwAJ9rSt7R4zgXqiZnRUcX3bhRTVD+SQCeM4Om
gFu6IMfCXkaYo4jKB0CpGd4=
=Zou8
-----END PGP SIGNATURE-----

--=-cgutvPERF0dujW6ZWrGU--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
