Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k8DHLTKU003193
	for <selinux@tycho.nsa.gov>; Wed, 13 Sep 2006 13:21:29 -0400
Received: from wp050.webpack.hosteurope.de (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k8DHL3Pt019577
	for <selinux@tycho.nsa.gov>; Wed, 13 Sep 2006 17:21:03 GMT
Date: Wed, 13 Sep 2006 19:21:24 +0200
From: Uwe Hermann <uwe@hermann-uwe.de>
To: selinux@tycho.nsa.gov
Subject: Re: More policy changes from Debian
Message-ID: <20060913172124.GE11017@aragorn>
References: <1158157098.1594.29.camel@wintermute.xmldesign.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="N1GIdlSm9i+YlY4t"
In-Reply-To: <1158157098.1594.29.camel@wintermute.xmldesign.de>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--N1GIdlSm9i+YlY4t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Sep 13, 2006 at 04:18:18PM +0200, Erich Schubert wrote:
> # just for /etc/localtime symlink, but I mean... it's just etc_t
[...] =20
> +files_read_etc_files(sxid_t)

I'm pretty new to SELinux, so maybe I'm wrong, but isn't the general goal
of SELinux + refpolicy to implement the strictest possible ruleset
per default where-ever possible? If yes, I'd rather explicitly only
allow access to that single file, rather than all of /etc.


Uwe.
--=20
Uwe Hermann=20
http://www.hermann-uwe.de
http://www.it-services-uh.de  | http://www.crazy-hacks.org=20
http://www.holsham-traders.de | http://www.unmaintained-free-software.org

--N1GIdlSm9i+YlY4t
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFFCD4UXdVoV3jWIbQRAutMAJ4w6sxSxQhgukAWMC9iCwrrQ+7oIgCglTgw
Buv+LT3CbX5UmSw83k9Fjns=
=vuHT
-----END PGP SIGNATURE-----

--N1GIdlSm9i+YlY4t--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
