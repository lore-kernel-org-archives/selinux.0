Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q7AFiIHY006704
	for <selinux@tycho.nsa.gov>; Fri, 10 Aug 2012 11:44:18 -0400
Date: Fri, 10 Aug 2012 17:43:45 +0200
From: Ole Kliemann <ole@plastictree.net>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov, Eric Paris <eparis@redhat.com>
Subject: Re: SELinux performance depending on type count
Message-ID: <20120810154345.GG2296@telvanni>
References: <20120807130244.GE2085@telvanni>
 <20120810121113.GE2296@telvanni>
 <1344603615.10631.26.camel@moss-pluto.epoch.ncsc.mil>
 <20120810143656.GF2296@telvanni>
 <1344611147.10631.65.camel@moss-pluto.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="nO3oAMapP4dBpMZi"
In-Reply-To: <1344611147.10631.65.camel@moss-pluto.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--nO3oAMapP4dBpMZi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 10, 2012 at 11:05:47AM -0400, Stephen Smalley wrote:
> On Fri, 2012-08-10 at 16:36 +0200, Ole Kliemann wrote:
> > So we have choke_u:choke_r:choke_t. Although all other types are=20
> > in choke_r, that alone causes nothing. But as soon as there are
> > these 1000 attributes on choke_t the fun starts. Actually you=20
> > don't even need the 1000 types. Just 1000 attributes on one type=20
> > produces a measurable slowdown (7sec) and lags. Having 1000 types=20
> > beside just makes it a lot worse. But there absolutely no=20
> > slowdown with just 1000 types and no attributes.
>=20
> Interesting.  We would expect some slowdown on an AVC cache miss in that
> situation, although the amount seems troubling.  Things to consider:
> - Does the AVC cache need to be increased or otherwise tuned?  You can
> see some information via the avcstat utility or by directly looking
> at /sys/fs/selinux/avc.

Just having 'avcstat 3' running and peeping at it:

calling 'id' without lag takes about 400 lookups, all in cache.

If I reload the policy, the first call to 'id' lags for maybe=20
500ms. avcstat shows for that period 400 lookups and maybe 20=20
misses.

Consequent calls to id do not lag and have no misses.

About the same is for 'ls ~'

But: calling 'id' from a not attribute-spammed domain after=20
reload shows about 5 misses too. But there is absolutely no lag.

>=20
> - Does security_compute_av(), which is called on a cache miss, need some
> profiling and tuning?  Particularly the logic within
> context_struct_compute_av(), where we are iterating through the type
> attribute ebitmaps.
>=20
> In Fedora 17, most types only have a few attributes (as shown by seinfo
> -t -x).  unconfined_t has a larger number of attributes than most, but
> even it only has 46 attributes.  So we likely don't see this behavior
> there.

--nO3oAMapP4dBpMZi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEARECAAYFAlAlLDAACgkQS1FjE303ERzdpQCfeYd6grLXW379z2mVUtIvKWXX
GQQAn18iQnklyr7FoqX80LOaE+yNxdu+
=OMz3
-----END PGP SIGNATURE-----

--nO3oAMapP4dBpMZi--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
