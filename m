Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j2PIE5Do010931
	for <selinux@tycho.nsa.gov>; Fri, 25 Mar 2005 13:14:05 -0500 (EST)
Received: from vds-320151.amen-pro.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j2PIB754025381
	for <selinux@tycho.nsa.gov>; Fri, 25 Mar 2005 18:11:08 GMT
Subject: Re: [RFC] selinux-support (1.0.1) available
From: Lorenzo =?ISO-8859-1?Q?Hern=E1ndez_?= =?ISO-8859-1?Q?Garc=EDa-Hierro?= <lorenzo@gnu.org>
To: Colin Walters <walters@verbum.org>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, ubuntu-hardened@lists.ubuntu.com,
   selinux@tycho.nsa.gov
In-Reply-To: <1111764692.3932.45.camel@nexus.verbum.private>
References: <1111704432.27644.62.camel@localhost.localdomain>
	 <1111759697.15280.53.camel@moss-spartans.epoch.ncsc.mil>
	 <1111761662.27644.121.camel@localhost.localdomain>
	 <1111764692.3932.45.camel@nexus.verbum.private>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-oyr4sxFyPbx02590dN/+"
Date: Fri, 25 Mar 2005 19:13:14 +0100
Message-Id: <1111774394.27644.141.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-oyr4sxFyPbx02590dN/+
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

El vie, 25-03-2005 a las 10:31 -0500, Colin Walters escribi=F3:
> On Fri, 2005-03-25 at 15:41 +0100, Lorenzo Hern=E1ndez Garc=EDa-Hierro
> wrote:
>=20
> > In my opinion, it's going to be Ubuntu specific until it's back-accepte=
d
> > in Debian, anyways, I expect to have, at least, the user-land ready for
> > SELinux support within the Ubuntu Linux distribution, for the Hoary+1
> > release (Breezy).
>=20
> That's probably reasonable.  If Ubuntu can get SELinux working well on a
> Debian-derived system out of the box, it will probably be easier for
> Debian to then pull all of the current patches into their distribution.
>=20
> Nevertheless, I encourage you to work with Debian on this as much as
> possible.  SELinux, like any access control system worth something,
> requires extensive integration with the rest of the OS.  And core parts
> of the OS at that.  You do not want to be deviating much from the Debian
> core for packages such as dpkg and coreutils in the long term. =20

I agree, the changes are not that difficult to give back for Debian,
Ubuntu is also not that different when talking about core stuff.

In short, I keep in mind both Debian and Ubuntu, just that Manoj is
doing a great job within Debian.

> Also, I strongly suggest that you look at the "targeted" policy shipping
> with Fedora.  I had a glance at the Ubuntu wiki page for SELinux and it
> seems the proposed policy is "selinux-policy-default", which IIRC is the
> "strict" policy.  The experience with Fedora is that strict is not yet
> workable as the default for a general-purpose OS, as Ubuntu is.  If you
> can get the targeted policy as the Ubuntu default and most importantly
> *on* by default, then "Hardened Ubuntu" becomes just s/targeted/strict/,
> and perhaps a few other features.  Much less work for the "Hardened"
> team.  Getting as many features of "Hardened" into the core should be
> your goal anyways; I think that permanently-forked "Hardened" variants
> are basically wrong.  They're kind of inherently doomed to be only used
> by a very small subset of users.  You want it to be more of a proving
> ground or staging area than a fork.

Right, I agree.

I'm still getting in touch with the policy language and so on, no real
work done, but I think I will be able to work on it without difficulties
soon.

The current "selinux-policy-default" package needs to be *re-worked*,
the configuration method is a mess, painful and not easy at all, even
for maintenance.

I would like to know the opinion on separate policy packages.

> We're doing a lot of work in Fedora to make targeted work well, and I
> think we could work together on it to good effect.

Sure, I will take a look at it.

> I haven't really done any Debian development in a year, but I think I
> still remember much of how things work, so I'd be happy to help with any
> integration issues you might have.  I'm sure the same is true of
> Russell.  Posting to selinux@tycho.nsa.gov is probably your best bet.

Right, I will CC related messages to both ubuntu-hardened and selinux
lists.

There's no formal recruitment, but if it's not all clear, everybody can
feel free to contribute and help with the work.

We are just 2 guys working on this, and I've been doing most of the
work, so, we would really appreciate help.

Thanks for the comments, cheers.
--=20
Lorenzo Hern=E1ndez Garc=EDa-Hierro <lorenzo@gnu.org>=20
[1024D/6F2B2DEC] & [2048g/9AE91A22][http://tuxedo-es.org]

--=-oyr4sxFyPbx02590dN/+
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBCRFS6DcEopW8rLewRAsvYAJ4ij9uM6ghbLIhF7iHAVYfKTAakXQCeOaa0
gwfFwUfcuUm6ds3m0g4/l/I=
=wWkN
-----END PGP SIGNATURE-----

--=-oyr4sxFyPbx02590dN/+--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
