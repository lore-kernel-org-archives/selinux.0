Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j0PEpbsj005319
	for <selinux@tycho.nsa.gov>; Tue, 25 Jan 2005 09:51:38 -0500 (EST)
Received: from vds-320151.amen-pro.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j0PEpeak008726
	for <selinux@tycho.nsa.gov>; Tue, 25 Jan 2005 14:51:40 GMT
Subject: Re: [PATCH] dpkg helper for libselinux
From: Lorenzo =?ISO-8859-1?Q?Hern=E1ndez_?= =?ISO-8859-1?Q?Garc=EDa-Hierro?= <lorenzo@gnu.org>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: selinux@tycho.nsa.gov, Daniel J Walsh <dwalsh@redhat.com>,
   Russell Coker <russell@coker.com.au>, Joshua Brindle <jbrindle@tresys.com>
In-Reply-To: <1106655718.21318.5.camel@moss-spartans.epoch.ncsc.mil>
References: <1106610654.3778.9.camel@localhost.localdomain>
	 <1106655718.21318.5.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-R3a7jpgPPmX8rXQeeqKu"
Date: Tue, 25 Jan 2005 15:50:53 +0100
Message-Id: <1106664654.3778.14.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-R3a7jpgPPmX8rXQeeqKu
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

El mar, 25-01-2005 a las 07:21 -0500, Stephen Smalley escribi=F3:
> On Mon, 2005-01-24 at 18:50, Lorenzo Hern=E1ndez Garc=EDa-Hierro wrote:
> > Attached you can find a patch that adds Debian package manager (dpkg)
> > helper code to libselinux so It will work under the proper dpkg_t
> > context type (as Russell defines on his policy packages for Debian).
> > Man page updated and such.
>=20
> Thanks.  However, rather than adding another special purpose helper, I'd
> prefer to create a general function that will work for both rpm and
> dpkg, and any other package management software.  The only aspect that
> is truly rpm-specific of rpm_execcon is the default type, and this could
> be read from a config file instead; however, changing it to use a
> configuration file needs to be done carefully because of the
> bootstrapping problem, i.e. rpm_execcon has to work even for an initial
> installation from scratch (and we are now also encountering an issue
> with getting it to work in a chroot'd environment for rpm --root).  That
> isn't too different than the issue with having file_contexts available
> for matchpathcon(); the solution IIUC there was to change the installer
> (anaconda) to create an initial file_contexts configuration for
> bootstrapping; it could also create a pkghelper_context configuration
> file or similar.  I've cc'd the list and several other people as I think
> this is a issue of general interest.

Right, I think that the configuration file support seems the best
solution but also we may want to add a "default" configuration,
compiled-in, that gets used when no "external" configuration is
available, this could help to avoid unexpected errors due to
bootstrapping and such.

Thanks for your interest, It was nothing more than a simple idea but
seems going to be more interesting ;)

Cheers,
--=20
Lorenzo Hern=E1ndez Garc=EDa-Hierro <lorenzo@gnu.org>=20
[1024D/6F2B2DEC] & [2048g/9AE91A22][http://tuxedo-es.org]

--=-R3a7jpgPPmX8rXQeeqKu
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Esta parte del mensaje =?ISO-8859-1?Q?est=E1?= firmada
	digitalmente

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBB9lzNDcEopW8rLewRAn/vAJ4p+5tUmSI4muGxb+0WJ84d/SXlRQCgp8bR
7XKuQvphnvEX/jYiaJHhx3U=
=fljD
-----END PGP SIGNATURE-----

--=-R3a7jpgPPmX8rXQeeqKu--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
