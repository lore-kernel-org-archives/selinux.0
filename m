Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iBI2ZiIi006112
	for <selinux@tycho.nsa.gov>; Fri, 17 Dec 2004 21:35:45 -0500 (EST)
Date: Fri, 17 Dec 2004 20:35:41 -0600
From: Greg Norris <haphazard@kc.rr.com>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: SELinux <selinux@tycho.nsa.gov>
Subject: Re: setting boolean values
Message-ID: <20041218023541.GA17033@yggdrasil.localdomain>
References: <20041217013648.GB11330@yggdrasil.localdomain> <1103291222.3437.19.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BOKacYhQ+x31HxR3"
In-Reply-To: <1103291222.3437.19.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--BOKacYhQ+x31HxR3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 17, 2004 at 08:47:02AM -0500, Stephen Smalley wrote:
> Yes, the current patch for /sbin/init calls sepol_genbools() to rewrite
> the boolean initial values in the binary policy based on your booleans
> config file prior to calling security_load_policy().  That was
> introduced during FC3 development, so the Debian patch for init might
> not be up-to-date.

Yep, that was it.  I'll see about rebuilding sysvinit with the updated=20
patch over the next few days.

Thanx!


--BOKacYhQ+x31HxR3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBw5d9grEMyr8Cx2YRAvdFAJ4y+ZqWx96vzrWlaAWJiIE4mMWjlwCaAoFG
aBVkIGghwptbzirxlXd1WZ0=
=zStW
-----END PGP SIGNATURE-----

--BOKacYhQ+x31HxR3--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
