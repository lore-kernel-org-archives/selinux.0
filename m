Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l0A56BlJ004540
	for <selinux@tycho.nsa.gov>; Wed, 10 Jan 2007 00:06:11 -0500
Received: from mail.and.org (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l0A570uY002675
	for <selinux@tycho.nsa.gov>; Wed, 10 Jan 2007 05:07:01 GMT
Subject: Re: [RFC] Support for bzip compressed modules
From: James Antill <jantill@redhat.com>
To: Karl MacMillan <kmacmillan@mentalrootkit.com>
Cc: SELinux Mail List <selinux@tycho.nsa.gov>
In-Reply-To: <1168377502.4983.12.camel@localhost.localdomain>
References: <45A2AADC.1090907@mentalrootkit.com>
	 <1168327098.22423.93.camel@code.and.org>
	 <45A3BA1B.9000908@mentalrootkit.com>
	 <1168361406.13080.12.camel@code.and.org>
	 <1168377502.4983.12.camel@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-AYmZ3ijoJrl/FJOPUyaZ"
Date: Wed, 10 Jan 2007 00:06:57 -0500
Message-Id: <1168405617.13080.22.camel@code.and.org>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-AYmZ3ijoJrl/FJOPUyaZ
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2007-01-09 at 16:18 -0500, Karl MacMillan wrote:
> On Tue, 2007-01-09 at 11:50 -0500, James Antill wrote:
> >  Do policy files not have a magic value, then?
>=20
> They do, but there is no real restriction that these policy file things
> get used for files containing policy. Currently they are used for a
> variety of file types and I would hate to hard code a list valid file
> types into this function.

 I don't think I'm intelligent enough to understand this sentence :).
What I meant was if they have magic values, they'll never clash so it's
always ok to do the check, no?
 Or in the other direction, if you can't differentiate on magic value or
the filename how can any piece of code tell whether it should decompress
it or treat it as raw data?

> >  You can also (for bz2)
> > check that the next value is between 1 and 9 (it's the compression
> > ratio).
>=20
> Ok. Could this be used for sizing the buffer in the memory case?

 No, it's just the "how hard did you want to try" value. So something
compressed with "bzip2 -1" will have a '1' and likewise "bzip2 -9" will
have a '9' after the magic.

> >  Right, but as I said the error paths always just try again without
> > compression ... so why not just try the compression at the start of the
> > set_foo() code. You get the same behaviour.
> >=20
>=20
> It is not about returning information about the compression. It is
> because the compression routines have other error paths (failure to load
> libbz2, memory allocation, etc.). There is no good way to indicate those
> errors without changing the prototypes. Even if we didn't change the
> prototypes, it is valid to not check the current functions for error, so
> we can't change them in any way that has potential error paths.

 Yes, I know that ... but there isn't a difference in the return value
between "bz2_init() failed" and "is_bz2_file() returned NO". So all the
callers just assume the later for all errors, if that's the case we
might as well combine it back into set_foo().

--=20
James Antill - <james.antill@redhat.com>
setsockopt(fd, IPPROTO_TCP, TCP_CONGESTION, ...);
setsockopt(fd, IPPROTO_TCP, TCP_DEFER_ACCEPT, ...);
setsockopt(fd, SOL_SOCKET,  SO_ATTACH_FILTER, ...);


--=-AYmZ3ijoJrl/FJOPUyaZ
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBFpHRw11eXTEMrxtQRAg5kAJ48qiWSwuNKARxnpc1arut81IonGQCfdvxi
pAo31hvlqkyrrx9m+4VBNLg=
=3HRd
-----END PGP SIGNATURE-----

--=-AYmZ3ijoJrl/FJOPUyaZ--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
