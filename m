Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k7GH5qjH004728
	for <selinux@tycho.nsa.gov>; Wed, 16 Aug 2006 13:05:52 -0400
Received: from mail.and.org (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k7GH5cjK027003
	for <selinux@tycho.nsa.gov>; Wed, 16 Aug 2006 17:05:39 GMT
From: James Antill <jantill@redhat.com>
To: Jim Meyering <jim@meyering.net>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <87mzabgyrk.fsf@rho.meyering.net>
References: <87mzabgyrk.fsf@rho.meyering.net>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-W+OyEbwHd5X/ouKYAsE9"
Date: Wed, 16 Aug 2006 13:05:47 -0400
Message-Id: <1155747947.11138.18.camel@code.and.org>
Mime-Version: 1.0
Subject: Re: justifying --context=CTX (-Z) for upstream coreutils, like
	mkdir
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-W+OyEbwHd5X/ouKYAsE9
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2006-08-11 at 15:58 +0200, Jim Meyering wrote:
> For a little context on why, ...
> I'm also considering the xattr patch that's been floating around for
> years.  Currently it's part of SuSE's coreutils patch set.  It ensures
> that mv and cp -p preserve any (selected) XATTR attributes.

 Note that I did a patch, which is different from the SuSE patch ... it
doesn't include the regexp handling but mv does Do The Right
Thing(tm)[1]:

https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=3D201088
http://people.redhat.com/jantill/patches/coreutils-5.97-xattrs.patch

 It also makes preservation of xattrs a hard error, unless it's because
of ENOTSUPP ... and there's no way to turn just preservation of xattrs
off (would you want this before accepting upstream)?


[1] If you "mv src x/dst" and x is a different fs, then you need to
remove all the xattrs from dst so you _only_ get the ones from src ...
which is what rename would do.

--=20
James Antill <jantill@redhat.com>

--=-W+OyEbwHd5X/ouKYAsE9
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBE41Br11eXTEMrxtQRAr2KAKCrcTUkt71zgkMCtfmYNML95CYvhgCgvno/
Bp977UCvlgez+UcsNgzOv7g=
=PumM
-----END PGP SIGNATURE-----

--=-W+OyEbwHd5X/ouKYAsE9--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
