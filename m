Subject: Re: RFC: jail functionality
From: Colin Walters <walters@verbum.org>
To: serue@us.ibm.com
Cc: James Morris <jmorris@redhat.com>, Stephen Smalley <sds@tycho.nsa.gov>,
   linux-security-module@wirex.com, SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <20050629184224.GC19299@serge.austin.ibm.com>
References: <1120062900.3553.151.camel@moss-spartans.epoch.ncsc.mil>
	 <Xine.LNX.4.44.0506291402040.12494-100000@thoron.boston.redhat.com>
	 <20050629184224.GC19299@serge.austin.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-py6vrG2Dhvt9j9RqpJut"
Date: Thu, 30 Jun 2005 09:19:34 -0400
Message-Id: <1120137574.4524.70.camel@nexus.verbum.private>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-py6vrG2Dhvt9j9RqpJut
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2005-06-29 at 13:42 -0500, serue@us.ibm.com wrote:
> Quoting James Morris (jmorris@redhat.com):
> > On Wed, 29 Jun 2005, Stephen Smalley wrote:
> >=20
> > > > The attached task-lookup patches?
> > >=20
> > > Not sure it provides much value.
> >=20
> > If yoy need this, why not look at proper isolation via Xen?
>=20
> Xen may be overkill for some cases, as you need (almost) a whole OS
> for each jail.  Zones and bsd jails (I believe) should easily be
> able to run hundreds of jails - provided of course they don't all
> peak at once.

What you are saying is: Xen is a heavyweight virtualization solution
that doesn't scale well when the user wants many instances of the exact
same OS, as opposed to potentially different OSes.

However, solving this (or at least drastically reducing the overhead) is
on the Xen roadmap:

http://www.cl.cam.ac.uk/Research/SRG/netos/xen/roadmap.html

(Shared buffer-cache and VM 'forks')

> And jails require some amount of access control.  I don't want to
> introduce a new LSM for this, but just put together the various
> existing (and not-yet-existing) pieces into an easy to use package.

I think this is useful, actually.  For some uses like build system
chroots, all the user really wants is some integrity protection against
accidental damage from poorly-written code, they don't need resource
management or any strong guarantees of integrity in the face of
malicious code. =20

But you should be aware that for a lot of the zone use cases, resource
management is very important, and SELinux doesn't provide that.  You
mention CKRM, but that's a whole other kernel patch.  Xen definitely
seems to be the approach that's winning here.


--=-py6vrG2Dhvt9j9RqpJut
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBCw/FmOIkJWWp2WGURAiF8AJwM/zi0tfA0bu/bq6AJhwDiEjRgSwCfcgZN
86GLLNyZbB4yxOMQ5aK8Uic=
=BK6P
-----END PGP SIGNATURE-----

--=-py6vrG2Dhvt9j9RqpJut--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
