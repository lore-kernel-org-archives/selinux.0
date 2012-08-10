Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q7A8wxgR015595
	for <selinux@tycho.nsa.gov>; Fri, 10 Aug 2012 04:58:59 -0400
Date: Fri, 10 Aug 2012 10:58:40 +0200
From: Ole Kliemann <ole@plastictree.net>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov
Subject: Re: Possible bug in finding default context?
Message-ID: <20120810085840.GA2296@telvanni>
References: <20120809174519.GE1643@telvanni>
 <1344534512.1175.17.camel@moss-pluto.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bp/iNruPH9dso1Pn"
In-Reply-To: <1344534512.1175.17.camel@moss-pluto.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--bp/iNruPH9dso1Pn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 09, 2012 at 01:48:32PM -0400, Stephen Smalley wrote:
> On Thu, 2012-08-09 at 19:45 +0200, Ole Kliemann wrote:
> > BTW, the exact number seems 194. 194 types associated with one=20
> > role works. 195 and it's broken.
> >=20
> > I'm doing this on Ubuntu 12.04, so it could be the crappily=20
> > maintained selinux userland here.
>=20
> We'd like to rip out all usage of security_compute_user()
> aka /sys/fs/selinux/user and everything that calls it.  Previously
> discussed on the list, although not your specific problem (presumably
> we're hitting the selinuxfs limit on size of response for /selinux/user
> transactions).  Take all of that logic to userspace and greatly simplify
> it.

Since I seem to be inclined to do strange things noone really did=20
before, I have to ask this:

This is strictly a problem only for the userspace, right? The LSM=20
can handled what ever I throw at it and will always enforce the=20
policy by the letter, no matter how many types/roles/user or=20
other strange constructs whatsoever I use?

--bp/iNruPH9dso1Pn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEARECAAYFAlAkzUAACgkQS1FjE303ERy7ywCfRuAd/YYhxxzRwWreWtmpyF49
DJ4AoIBQLwt0a0CP17bJpGCSbhlshYX5
=QzfP
-----END PGP SIGNATURE-----

--bp/iNruPH9dso1Pn--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
