Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j2RC6LDo019770
	for <selinux@tycho.nsa.gov>; Sun, 27 Mar 2005 07:06:22 -0500 (EST)
Received: from crisium.vnl.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j2RC36Tl011047
	for <selinux@tycho.nsa.gov>; Sun, 27 Mar 2005 12:03:06 GMT
Date: Sun, 27 Mar 2005 13:05:32 +0100
From: Dale Amon <amon@vnl.com>
To: Colin Walters <walters@verbum.org>
Cc: Lorenzo Hern?ndez Garc?a-Hierro <lorenzo@gnu.org>,
   ubuntu-hardened@lists.ubuntu.com, rcoker@redhat.com, dwalsh@redhat.com,
   selinux@tycho.nsa.gov, ubuntu-devel@lists.ubuntu.com
Subject: Re: selinux-policy-targeted (1:1.22-2) available
Message-ID: <20050327120532.GC7660@vnl.com>
References: <1111884872.27644.228.camel@localhost.localdomain> <1111887665.16952.22.camel@nexus.verbum.private>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UoPmpPX/dBe4BELn"
In-Reply-To: <1111887665.16952.22.camel@nexus.verbum.private>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--UoPmpPX/dBe4BELn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 26, 2005 at 08:41:05PM -0500, Colin Walters wrote:
> I assume you mean this:
>=20
> +        print "Do you want $file:" . substr($line, 6);
> +        print "Yes/No/Display [Y/n/d]? ";
>=20
> I suggest that you simply delete this code entirely, and install
> every .te file.  It's outdated for several reasons:
>
> 3) It's always been annoying as hell :)

Yeah, an automatic install/configurator project
I was working on in spare time foundered on that
ever changing reef of dependencies and name changes...

--=20
------------------------------------------------------
   Dale Amon     amon@islandone.org    +44-7802-188325
       International linux systems consultancy
     Hardware & software system design, security
    and networking, systems programming and Admin
	      "Have Laptop, Will Travel"
------------------------------------------------------

--UoPmpPX/dBe4BELn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFCRqGMZHES7UL0zXERAg3LAJ4mIQdvKYagUxJGNQsWNzcDvnAtxwCbB4EM
WoPRn6KmoFLBq9x8iqWX0xM=
=cUsv
-----END PGP SIGNATURE-----

--UoPmpPX/dBe4BELn--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
