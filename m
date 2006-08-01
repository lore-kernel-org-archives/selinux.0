Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k71JJGpT002573
	for <selinux@tycho.nsa.gov>; Tue, 1 Aug 2006 15:19:17 -0400
Received: from mail.and.org (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k71JJBvL020367
	for <selinux@tycho.nsa.gov>; Tue, 1 Aug 2006 19:19:11 GMT
Subject: Re: gnuTAR support for SELinux context (beta)
From: James Antill <jantill@redhat.com>
To: Stephen John Smoogen <smooge@gmail.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <80d7e4090608011150u48b0e124m1046145a1450b8a3@mail.gmail.com>
References: <1154453240.2103.27.camel@code.and.org>
	 <1154456909.3582.139.camel@moss-spartans.epoch.ncsc.mil>
	 <80d7e4090608011150u48b0e124m1046145a1450b8a3@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-Rgttu3UOwlKTLpF1/mJJ"
Date: Tue, 01 Aug 2006 15:19:14 -0400
Message-Id: <1154459954.2103.82.camel@code.and.org>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-Rgttu3UOwlKTLpF1/mJJ
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2006-08-01 at 12:50 -0600, Stephen John Smoogen wrote:

> Doesn't the xattr support use an internally different tar format than
> the normal one? [From my reading of the star pages.] Would this stop
> it being readable from say Debian, Solaris etc that didn't know about
> this format

 No, star requires you set the archive format to exustar ... my patches
for GNUtar only require the --xattr/--selinux option(s) and to not be
using v7 format.
 Note that GNUtar can read exustar format archives, with xattr info. in
them, although I'm guessing all the details in the documentation is
still valid wrt. length limits ... and:

 tar -cvf foo.tar foo --xattr --format=3Dustar

...does produce archives that can be extracted from star (including
xattr info.).


 Saying that, debian/upstream/etc. GNUtar does issue warnings and a
delayed error exit code when it sees the xattr info. in an archive (but
it works just as though none of that info. were present). Which _could_
break scripts that expect a happy exit code, and might well confuse
users with the warnings.

--=20
James Antill <jantill@redhat.com>

--=-Rgttu3UOwlKTLpF1/mJJ
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.4 (GNU/Linux)

iD8DBQBEz6ky11eXTEMrxtQRAr/GAJ9GQuA/JP6cl3D3Pdccm7kCjUhYpACfVc9b
6MV7vtqp410v5/EeepFylFQ=
=wdKR
-----END PGP SIGNATURE-----

--=-Rgttu3UOwlKTLpF1/mJJ--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
