Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j0I0WNIi016954
	for <selinux@tycho.nsa.gov>; Mon, 17 Jan 2005 19:32:23 -0500 (EST)
Date: Mon, 17 Jan 2005 18:31:39 -0600
From: Greg Norris <haphazard@kc.rr.com>
To: Stephen Smalley <sds@epoch.ncsc.mil>, SELinux <selinux@tycho.nsa.gov>,
   Ingo Molnar <mingo@elte.hu>
Cc: Russell Coker <russell@coker.com.au>
Subject: Re: lots of execmem failures with 2.6.10
Message-ID: <20050118003139.GA13553@yggdrasil.localdomain>
References: <20050112112630.GA12730@yggdrasil.localdomain> <1105541256.22495.57.camel@moss-spartans.epoch.ncsc.mil> <20050113030755.GA24828@yggdrasil.localdomain> <20050116015332.GA9811@yggdrasil.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="J/dobhs11T7y2rNN"
In-Reply-To: <20050116015332.GA9811@yggdrasil.localdomain>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--J/dobhs11T7y2rNN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 15, 2005 at 07:53:32PM -0600, Greg Norris wrote:
> I've built a SELinux-enabled coreutils 5.2.1 package for Debian, and
> I'm happy to report that it does indeed resolve my issue.  I want to
> do a bit more testing before making the package generally available (I
> just rebooted to 2.6.10 about 15 minutes ago), but I'll upload it
> either tomorrow or Monday if no show-stoppers turn up.

No problems so far, so I've posted the i386 binary package and source=20
components at "http://people.debian.org/~adric/selinux/coreutils/". =20
I'll look into making it apt-get'able tomorrow.

--J/dobhs11T7y2rNN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFB7FjrgrEMyr8Cx2YRAuhDAJwKfgUAtnmk3aWBIXa3L49eNkYKXgCeJLql
vTXr88bjQttQkQ8kqYtUAfo=
=i9Rk
-----END PGP SIGNATURE-----

--J/dobhs11T7y2rNN--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
