Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7NFSerT018751
	for <selinux@tycho.nsa.gov>; Mon, 23 Aug 2004 11:28:40 -0400 (EDT)
Subject: Re: conflict between libselinux and libsepol
From: Colin Walters <walters@redhat.com>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1093274109.27211.102.camel@moss-spartans.epoch.ncsc.mil>
References: <1092942083.1721.101.camel@moss-spartans.epoch.ncsc.mil>
	 <1092972342.29540.35.camel@nexus.verbum.private>
	 <1093002523.16585.31.camel@moss-spartans.epoch.ncsc.mil>
	 <1093013527.9495.0.camel@nexus.verbum.private>
	 <1093015484.16585.199.camel@moss-spartans.epoch.ncsc.mil>
	 <1093028441.16585.265.camel@moss-spartans.epoch.ncsc.mil>
	 <1093030667.4212.4.camel@nexus.verbum.private>
	 <1093035295.4212.9.camel@nexus.verbum.private>
	 <1093274109.27211.102.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-OybYjWyS7EKRWWFsHHC/"
Date: Mon, 23 Aug 2004 11:29:35 -0400
Message-Id: <1093274975.20301.15.camel@nexus.verbum.private>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-OybYjWyS7EKRWWFsHHC/
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2004-08-23 at 11:15 -0400, Stephen Smalley wrote:
> On Fri, 2004-08-20 at 16:54, Colin Walters wrote:
> > And a patch for the policy Makefile to cause it to verify the file
> > contexts under the "policy" target.  I think this makes sense because
> > conceptually the file contexts is part of the whole system security
> > policy.
>=20
> Committed, with s/setfiles/$(SETFILES)/.

Great, thanks.

> Note however that the 'policy' target is not used in common practice
> once the policy is installed, so if someone does local customization and
> does a make (=3D=3D make install by default), it won't be validated in th=
is
> manner.  The spec file does a 'make policy' in the %build, so it will
> perform such validation, but manual usage of the policy target is
> typically limited to testing/development.

My personal habit has always been to do "make policy && make reload".
But maybe we should move the validation to the $(FCPATH) target?


--=-OybYjWyS7EKRWWFsHHC/
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBBKg1fOIkJWWp2WGURApGnAJ9THl9lfmASSzVgzzyNSZoTbV8vWQCeK/3c
9grYAtOOEzhVw/r3S2i7p+Y=
=gOtk
-----END PGP SIGNATURE-----

--=-OybYjWyS7EKRWWFsHHC/--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
