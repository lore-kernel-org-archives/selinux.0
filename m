Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i879TgrT024898
	for <selinux@tycho.nsa.gov>; Tue, 7 Sep 2004 05:29:42 -0400 (EDT)
Received: from crisium.vnl.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i879Tfll004034
	for <selinux@tycho.nsa.gov>; Tue, 7 Sep 2004 09:29:41 GMT
Date: Tue, 7 Sep 2004 10:29:39 +0100
From: Dale Amon <amon@vnl.com>
To: Chris PeBenito <pebenito@gentoo.org>
Cc: stefano.zanarini@yacme.com, SELinux Mail List <selinux@tycho.nsa.gov>
Subject: Re: SuSE 9.1 SELinux
Message-ID: <20040907092939.GA22688@vnl.com>
References: <OF93C1DDD2.9FAF1403-ON49256F06.00517E1E-49256F07.0007F249@jp.ibm.com> <1094456102.2213.3.camel@pignoletto.cantina.yacme> <1094479285.11718.31.camel@gorn.pebenito.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="k1lZvvs/B4yU6o8G"
In-Reply-To: <1094479285.11718.31.camel@gorn.pebenito.net>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--k1lZvvs/B4yU6o8G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 06, 2004 at 10:01:25AM -0400, Chris PeBenito wrote:
> > I'm interested in doing the same thing ,even in suse 9.0 with a custom
> > kernel and in 9.1 with defoult one ,but this could be a real problem for
> > me ... why doesn't it work with reiserfs ? is there a patch or a
> > workaround to make it works ? have you tryed ?=20
>=20
> This same question was answered a few days ago.  There's a deadlock in
> the reiserfs code, and there's no workaround.  To quote Steve:
>=20
> On Fri, 2004-09-03 at 09:53, Stephen Smalley wrote:=20
> > reiserfs is known to not work with SELinux.  There is a deadlock in the
> > reiserfs xattr code when interacting with SELinux, and there is no way
> > presently for reiserfs to inform SELinux that it shouldn't try to
> > mediate access to the internal directories and files used to store the
> > xattrs.  reiserfs maintainers know about the issues, but not clear that
> > they care...

That explains the trouble I had with my xattr's patch
I did here a year or two ago. It worked but I had, at=20
the time, unexplicable problems.

--=20
------------------------------------------------------
   Dale Amon     amon@islandone.org    +44-7802-188325
       International linux systems consultancy
     Hardware & software system design, security
    and networking, systems programming and Admin
	      "Have Laptop, Will Travel"
------------------------------------------------------

--k1lZvvs/B4yU6o8G
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFBPX+DZHES7UL0zXERAqJ0AJ9WGrtCjMCLaBre1SQSgS0cEo1OcgCggZ/G
s/m8NK7QlOXGAwFE7uWAULM=
=FyJC
-----END PGP SIGNATURE-----

--k1lZvvs/B4yU6o8G--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
