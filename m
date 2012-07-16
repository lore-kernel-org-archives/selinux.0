Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q6GMId1O022673
	for <selinux@tycho.nsa.gov>; Mon, 16 Jul 2012 18:18:39 -0400
Date: Tue, 17 Jul 2012 00:18:18 +0200
From: Ole Kliemann <ole@plastictree.net>
To: Russell Coker <russell@coker.com.au>
Cc: selinux@tycho.nsa.gov
Subject: Re: Information about XSELinux
Message-ID: <20120716221818.GA16156@telvanni>
References: <20120716161006.GA14824@telvanni>
 <201207170423.14495.russell@coker.com.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="fdj2RfSjLxBAspz7"
In-Reply-To: <201207170423.14495.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--fdj2RfSjLxBAspz7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 17, 2012 at 04:23:14AM +1000, Russell Coker wrote:
> On Tue, 17 Jul 2012, Ole Kliemann <ole@plastictree.net> wrote:
> > Is it included in any major distributions? (Currently using=20
> > Ubuntu 12.04)
>=20
> Unless Ubuntu have done some significant enhancements over my Debian work=
=20
> without telling me then it's not going to work.

I'm no expert, but as far as I can tell, it's just not there in=20
Ubuntu.

I understood from a bug report on this list that it's included in=20
Fedora. So I installed it on a test system and could reproduce=20
the bug (X server fails to start when xserver_object_manager is=20
set).=20

I'm willing to switch to whatever distribution is providing the=20
means to seperate user contexts under X.

--fdj2RfSjLxBAspz7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEARECAAYFAlAEkyoACgkQS1FjE303ERyh8ACfReubYGS5gyc88fXXEyk4Mg9o
oTsAn0/23Z0cd8qaNlphafmjA+hAvk9v
=iq7X
-----END PGP SIGNATURE-----

--fdj2RfSjLxBAspz7--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
