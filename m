Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j2R1foDo018226
	for <selinux@tycho.nsa.gov>; Sat, 26 Mar 2005 20:41:50 -0500 (EST)
Received: from monk.area614.net (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j2R1cda7028767
	for <selinux@tycho.nsa.gov>; Sun, 27 Mar 2005 01:38:39 GMT
Subject: Re: selinux-policy-targeted (1:1.22-2) available
From: Colin Walters <walters@verbum.org>
To: Lorenzo =?ISO-8859-1?Q?Hern=E1ndez_?= =?ISO-8859-1?Q?Garc=EDa-Hierro?= <lorenzo@gnu.org>
Cc: ubuntu-hardened@lists.ubuntu.com, rcoker@redhat.com, dwalsh@redhat.com,
   selinux@tycho.nsa.gov, ubuntu-devel@lists.ubuntu.com
In-Reply-To: <1111884872.27644.228.camel@localhost.localdomain>
References: <1111884872.27644.228.camel@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-Im2UXRKe1MdtdZzPD6Wp"
Date: Sat, 26 Mar 2005 20:41:05 -0500
Message-Id: <1111887665.16952.22.camel@nexus.verbum.private>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-Im2UXRKe1MdtdZzPD6Wp
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sun, 2005-03-27 at 01:54 +0100, Lorenzo Hern=C3=A1ndez Garc=C3=ADa-Hierr=
o
wrote:

> I'm (very) glad to announce the availability of the first targeted
> policy package for Debian and more concretely Ubuntu Linux=20

Very cool, I'm excited about this.

> The policy source itself has nothing to do Russell Coker's old
> selinux-policy-default, but the package is based on his one, this mean,s
> same configuration method.

I assume you mean this:

+        print "Do you want $file:" . substr($line, 6);
+        print "Yes/No/Display [Y/n/d]? ";

I suggest that you simply delete this code entirely, and install
every .te file.  It's outdated for several reasons:

1) With the new dynamic boolean support, SELinux enforcement for a
   particular daemon can be turned off at runtime, instead of
   at policy build time.
2) The targeted policy is significantly smaller than the strict, so
   there are no space/size concerns. =20
3) It's always been annoying as hell :)


--=-Im2UXRKe1MdtdZzPD6Wp
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBCRg8wOIkJWWp2WGURAkhZAJ4xfuVM4qZUguQ7EWygXJJi2SFnMACeJ8Yo
/5UY0rfuAz83fawipUnTxM0=
=atat
-----END PGP SIGNATURE-----

--=-Im2UXRKe1MdtdZzPD6Wp--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
