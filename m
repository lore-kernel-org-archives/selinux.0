Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i82NTFrT003955
	for <selinux@tycho.nsa.gov>; Thu, 2 Sep 2004 19:29:15 -0400 (EDT)
Subject: Re: Proposed Hardware File Context file.
From: Colin Walters <walters@redhat.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: Stephen Smalley <sds@epoch.ncsc.mil>, SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <41377F4B.3010608@redhat.com>
References: <200408241818.40064.russell@coker.com.au>
	 <41371628.2020408@redhat.com>
	 <1094130607.17265.47.camel@moss-spartans.epoch.ncsc.mil>
	 <200409022338.20644.russell@coker.com.au>
	 <1094136369.17265.128.camel@moss-spartans.epoch.ncsc.mil>
	 <413741A3.3070305@redhat.com>
	 <1094153919.17265.375.camel@moss-spartans.epoch.ncsc.mil>
	 <41377927.3080703@redhat.com>
	 <1094155198.17265.389.camel@moss-spartans.epoch.ncsc.mil>
	 <41377DD5.8010500@redhat.com>
	 <1094155749.17265.392.camel@moss-spartans.epoch.ncsc.mil>
	 <41377F4B.3010608@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-vY+mVo3WF0tLrU/k9f9A"
Date: Thu, 02 Sep 2004 19:30:21 -0400
Message-Id: <1094167821.24091.25.camel@nexus.verbum.private>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-vY+mVo3WF0tLrU/k9f9A
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2004-09-02 at 16:15 -0400, Daniel J Walsh wrote:
> Stephen Smalley wrote:
>=20
> >On Thu, 2004-09-02 at 16:08, Daniel J Walsh wrote:
> > =20
> >
> >>Ok so the original context as specified in the file context file with=20
> >>hardware type.   IE
> >>PATH  MODETYPE CONTEXT HARDWARE
> >>/dev/hd.* -b  system_u:object_r:removable_disk_device_t     cdrom
> >>/dev/hd.* -b  system_u:object_r:fixed_disk_device_t              disk
> >>   =20
> >>
> >
> >No, I meant just a separate config with 'hardware unit context' or
> >similar.  No pathname regexes or modes.
> >
> > =20
> >
> Ok I don't know what you mean by unit then.

I think "unit" in this context should be a regular expression which can
match an arbitrary identification string.  udev would extract the e.g.
the USB model number for this purpose.  This wouldn't actually be
supplied in the sample policy, but system administrators could use it to
customize the policy at a more granular level than "cdrom".


--=-vY+mVo3WF0tLrU/k9f9A
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBBN60NOIkJWWp2WGURAn8lAKCAo5gwv2Z7+z031lWldAJlNpu+tQCfQ8aU
Ar1JYxUx1sLFE5uC6L6UzDI=
=K8IW
-----END PGP SIGNATURE-----

--=-vY+mVo3WF0tLrU/k9f9A--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
