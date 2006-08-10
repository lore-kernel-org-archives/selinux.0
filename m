Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k7AG0Ffr008236
	for <selinux@tycho.nsa.gov>; Thu, 10 Aug 2006 12:00:16 -0400
Received: from mail.and.org (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k7AG06mM025025
	for <selinux@tycho.nsa.gov>; Thu, 10 Aug 2006 16:00:06 GMT
Subject: Re: does mv need a --context=CTX (-Z) option, too?
From: James Antill <jantill@redhat.com>
To: Jim Meyering <jim@meyering.net>
Cc: kmacmillan@mentalrootkit.com, selinux@tycho.nsa.gov
In-Reply-To: <87y7twk4fb.fsf@rho.meyering.net>
References: <87hd0kc308.fsf@rho.meyering.net>
	 <Pine.LNX.4.64.0608100843530.4511@tachyon.snu.edu>
	 <87y7twk4fb.fsf@rho.meyering.net>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-I7GPf5hpmR0S1YhVSQ0w"
Date: Thu, 10 Aug 2006 12:00:08 -0400
Message-Id: <1155225608.2496.7.camel@code.and.org>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-I7GPf5hpmR0S1YhVSQ0w
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2006-08-10 at 17:15 +0200, Jim Meyering wrote:
> kmacmillan@mentalrootkit.com wrote:
> > On Thu, 10 Aug 2006, Jim Meyering wrote:
> >
> >> It might make sense to add a --context=3DCTX (-Z) option to mv.  Curre=
ntly,
> >> cp, install, mkdir, mknod, mkfifo all have that option, but not mv.
> >> Most of the time, mv would have no need, since it simply calls rename.
> >> But when that fails, it reverts to using the very same copying code
> >> (copy.c) that cp uses.  It is trivial to add this option to mv, with t=
he
> >> understanding that it'd take effect solely for e.g., cross-device move=
s.
> >> I.e., if you want to simulate a cross device move, you'd have to use
> >> cp -pr and rm -rf, so if it makes sense for cp to have the --context=
=3DCTX
> >> (-Z) option, then it follows that mv must accept it as well.
> >>
> >
> > I think that mv should have that option. Actually, I think that the mor=
e
> > pressing option is --preserve so that users can simulate the rename cas=
e
> > across devices.
>=20
> Why would mv need a new --preserve option?
> mv already tries to preserve as much as possible when
> performing any cross-device copy.

 Then, IMO, it should preserve xattrs and SELinux context by default
too. It already seems to try and do ACLs (although it's a bit
weird[1]) ... so this seems natural. I really wouldn't want to explain
what a mv -Z call did to someone.

> Admittedly, mv doesn't fail if it cannot preserve some attribute,
> but that's a POSIX requirement (cp -p *does*).  Maybe you'd like
> --preserve to change that?  I added a comment suggesting
> just such a change years ago.  From coreutils/src/mv.c:
>   x->require_preserve =3D false;  /* FIXME: maybe make this an option */
> but no one has been motivated to do that.
> SELinux might be the necessary prod.

 That might be useful, esp. with ACLs and SELinux context.


[1] strace shows:

getxattr("/boot/james/abcd", "system.posix_acl_access", 0xbfdbd580, 132) =
=3D -1 EOPNOTSUPP (Operation not supported)
setxattr("./abcd", "system.posix_acl_access", "\x02\x00\x00\x00\x01\x00\x06=
\x00\xff\xff\xff\xff\x04\x00\x04\x00\xff\xff\xff\xff \x00\x04\x00\xff\xff\x=
ff\xff", 28, 0) =3D 0

...which is pretty surprising.

--=20
James Antill <jantill@redhat.com>

--=-I7GPf5hpmR0S1YhVSQ0w
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBE21gH11eXTEMrxtQRAqpKAJ40xA8CMXkuqP0EVj8TfAURF9ud4ACeLq24
AAKFL+96ejjKA/srjg4HozU=
=4t6i
-----END PGP SIGNATURE-----

--=-I7GPf5hpmR0S1YhVSQ0w--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
