Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i38HUBRb019256
	for <selinux@tycho.nsa.gov>; Thu, 8 Apr 2004 13:30:11 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i38HS9Ub006047
	for <selinux@tycho.nsa.gov>; Thu, 8 Apr 2004 17:28:10 GMT
Subject: Re: strange labeling problem
From: Colin Walters <walters@redhat.com>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: selinux@tycho.nsa.gov, Russell Coker <russell@coker.com.au>,
   James Morris <jmorris@redhat.com>
In-Reply-To: <1081431133.6379.99.camel@moss-spartans.epoch.ncsc.mil>
References: <1081376404.9215.13.camel@nexus.verbum.private>
	 <1081431133.6379.99.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-HHjRLCAbV3CI8h7iAxJy"
Message-Id: <1081445224.3361.107.camel@nexus.verbum.private>
Mime-Version: 1.0
Date: Thu, 08 Apr 2004 13:27:05 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-HHjRLCAbV3CI8h7iAxJy
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2004-04-08 at 09:32, Stephen Smalley wrote:

> This typically means that the type wasn't defined in the policy when the
> inode was last brought in-core.  So ls -Z (or getfilecon or getfattr)
> will continue to report the actual attribute value from the disk, but
> SELinux is handling it as unlabeled_t since it had no definition for the
> type when the inode was brought in-core.

Ahh, I see.

> > I had tried rerunning chcon -t gconfd_exec_t /usr/libexec/gconfd-2
> > several times.  I verified that the stored xattr was correct; i.e. a
> > getfattr -d -m . /usr/libexec/gconfd-2 showed gconfd_exec_t.
>=20
> chcon likely never called setfilecon at all, since getfilecon would have
> told it that the file already had the right context. =20

Ok, and this is basically an optimization, so we don't have to rewrite
the xattr on disk?

> Try setfilecon instead. =20

It's kind of confusing that there can be this kind of desynchronization
between chcon and ls -Z.  It will probably be a pretty rare case - it'll
likely only hit people who are developing policy. =20

--=-HHjRLCAbV3CI8h7iAxJy
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQBAdYtoOIkJWWp2WGURAqITAJ9LMidx34+Nzah9Nhz5XvicQMQitgCdF6jG
G8P2WUFDnWBRoyd5TQqqI0c=
=ldED
-----END PGP SIGNATURE-----

--=-HHjRLCAbV3CI8h7iAxJy--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
