Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j8IM2TNs012848
	for <selinux@tycho.nsa.gov>; Sun, 18 Sep 2005 18:02:29 -0400 (EDT)
Received: from crisium.vnl.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j8ILwb1I028359
	for <selinux@tycho.nsa.gov>; Sun, 18 Sep 2005 21:58:37 GMT
Date: Sun, 18 Sep 2005 22:58:41 +0100
From: Dale Amon <amon@vnl.com>
To: Dale Amon <amon@vnl.com>, selinux@tycho.nsa.gov
Subject: Re: State of Debian SELinux
Message-ID: <20050918215841.GA7480@vnl.com>
References: <20050917233111.GA17916@vnl.com> <20050918001512.GR9092@lkcl.net> <20050918095806.GC25649@vnl.com> <20050918104219.GW9092@lkcl.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="k1lZvvs/B4yU6o8G"
In-Reply-To: <20050918104219.GW9092@lkcl.net>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--k1lZvvs/B4yU6o8G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 18, 2005 at 11:42:19AM +0100, Luke Kenneth Casson Leighton wrot=
e:
> On Sun, Sep 18, 2005 at 10:58:07AM +0100, Dale Amon wrote:
> > Ouch. Well, I'm only interested in getting it up on rack mount
> > server class machines with no fancy workstation apps on them.=20
> > Nothing but LAMP's.
>   then you would do well to consider gentoo/hardened instead!!

Not an option. The software driving the active the site was
written specifically for debian and in debian packages. I'd
hate to have to go back to them and say, well, you know those
really neat debian packages I did last year...

> > I'm picking that up from Russel's repository during the upgrade
> > and it does install okay.
>=20
>  look for manoj's stuff.

I will, but just in case, do you have a url?
=20
>  okay, you need to reboot first with ... damn it's been a while...
>=20
>  selinux=3D1 enabled=3D0

Actually, its enforcing=3D0. And unfortuneately that doesn't help.
I still get the same error messages as before. =20
=20
>  it's something to do with failures in the make process which i never
>  got to the bottom of - probably some of the libselinux / sepol
>  libraries detecting that selinux wasn't enabled, and not allowing
>  the build process to proceed properly.

There is definitely something I am missing with libsepol because
there is an error about it which means absolutely nothing to me
that causes dselect to give up on installing the default policy.
It also seems to mean nothing to Google so I guess it has not come
up on the mail list either:

	/usr/bin/checkpolicy: loading policy configuration from policy.conf
	libsepol.expand_avtab_insert: Type conflict!
	Out of memory - unable to check assertions.
	Check assertions failed.

Highly informative, n'est-ce pas? I can reproduce it manually:

	cd /etc/selinux/src/
	/usr/bin/checkpolicy

>  most people only build and install selinux on already-useable
>  selinux systems.

*amon turns to watch a chicken racing an egg across the road...

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
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFDLeMRZHES7UL0zXERAh3iAJ490OBu+0c1wuG7b1xw8UBX5zCkIACfeDfy
q62RnhpTqxteRUwzUae4b/8=
=fdj9
-----END PGP SIGNATURE-----

--k1lZvvs/B4yU6o8G--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
