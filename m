Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i81I7lrT023137
	for <selinux@tycho.nsa.gov>; Wed, 1 Sep 2004 14:07:47 -0400 (EDT)
Subject: Re: DBus session bus -> separate security class?
From: Colin Walters <walters@redhat.com>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: selinux@tycho.nsa.gov, Daniel J Walsh <dwalsh@redhat.com>,
   Russell Coker <rcoker@redhat.com>
In-Reply-To: <1094056754.13328.73.camel@moss-spartans.epoch.ncsc.mil>
References: <1094054625.11084.34.camel@nexus.verbum.private>
	 <1094056754.13328.73.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-M5s5nQAMdCjKgZme0Eru"
Date: Wed, 01 Sep 2004 14:08:59 -0400
Message-Id: <1094062139.11084.49.camel@nexus.verbum.private>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-M5s5nQAMdCjKgZme0Eru
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2004-09-01 at 12:39 -0400, Stephen Smalley wrote:
> On Wed, 2004-09-01 at 12:03, Colin Walters wrote:
> > I'm working on updating the DBus policy to handle the addition of the
> > user session DBus instance.
>=20
> In its own derived domain, using a macro, I hope.  $1_dbusd_t for $1 in
> userdomain.

Yes.

> It seems like a more general solution would be to alter the manner in
> which dbusd labels its connections.  Instead of simply labeling them
> with the peer context, you could call security_compute_create (which
> internally maps to the kernel's security_transition_sid interface and
> uses type_transition rules) on the peer context and the bus context, and
> define type transition rules to map to derived types based on the pair
> of contexts.

That does sound more general.  So were this implemented, the policy
might look like this:

type_transition cupsd_t $1_t:dbus $1_cupsd_t;
allow $1_cupsd_t $1_t:dbus { send_msg };

Is that correct?


--=-M5s5nQAMdCjKgZme0Eru
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBBNhA7OIkJWWp2WGURAkRlAJ47EO6zPna60H/gD1fbJm9TDb+R1gCaAlio
j9oBP1h0AC4gE5TBe3+dJaU=
=pSQB
-----END PGP SIGNATURE-----

--=-M5s5nQAMdCjKgZme0Eru--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
