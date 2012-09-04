Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q84FCuNW008946
	for <selinux@tycho.nsa.gov>; Tue, 4 Sep 2012 11:12:56 -0400
Date: Tue, 4 Sep 2012 16:32:12 +0200
From: Ole Kliemann <ole@plastictree.net>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov
Subject: Re: An MCS policy
Message-ID: <20120904143212.GF2999@telmora.telvanni>
References: <20120903175904.GA25491@telmora.telvanni>
 <1346767354.30701.35.camel@moss-pluto.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5Mfx4RzfBqgnTE/w"
In-Reply-To: <1346767354.30701.35.camel@moss-pluto.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--5Mfx4RzfBqgnTE/w
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 04, 2012 at 10:02:34AM -0400, Stephen Smalley wrote:
> On Mon, 2012-09-03 at 19:59 +0200, Ole Kliemann wrote:
> > 01:		( t1 !=3D is_mcsconstrained )
> > 02:	or	( t2 !=3D is_mcsconstrained )
>=20
> Not sure if you are using TE to prevent this, but one possible concern
> with using the same invariant for source (t1) and target (t2) is with
> respect to process ptrace, transition, and dyntransition permissions.
> You want to ensure that a MCS constrained process cannot ptrace or
> transition to a MCS-unconstrained domain.

Yes, that's prevented by TE and asserted by neverallow.

> > 03:	or	(=09
> > 04:				( l1 domby h1 )=20
> > 05:			and	( l2 domby h2 )=20
>=20
> The kernel (mls_context_isvalid() in security/selinux/ss/mls.c)
> guarantees these invariants for all security contexts.cd=20

This one I saw coming.

>=20
> > 06:			and	( h1 dom h2 )=20
> > 07:			and ( h1 dom l2 )=20
>=20
> Redundant.

This one I totally missed. Under the premise of 04 and 05, the=20
source high range always dominates the target low range if it=20
already dominates the target high range -- it's transitive after=20
all.

>=20
> > 08:			and ( l1 domby l2 )=20
> > 09:		)

Thanks for having a look!

Ole

--5Mfx4RzfBqgnTE/w
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEARECAAYFAlBGEOwACgkQS1FjE303ERwD3QCfcvewyyn6xyCj/pjyNO1vJcP8
WcgAnj6TDPw6ctRhmXxQU9dQoIwZ0kbw
=qJlM
-----END PGP SIGNATURE-----

--5Mfx4RzfBqgnTE/w--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
