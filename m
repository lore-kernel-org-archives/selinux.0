Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l09GnI2n012023
	for <selinux@tycho.nsa.gov>; Tue, 9 Jan 2007 11:49:19 -0500
Received: from mail.and.org (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l09Go7PN003709
	for <selinux@tycho.nsa.gov>; Tue, 9 Jan 2007 16:50:08 GMT
Subject: Re: [RFC] Support for bzip compressed modules
From: James Antill <jantill@redhat.com>
To: Karl MacMillan <kmacmillan@mentalrootkit.com>
Cc: SELinux Mail List <selinux@tycho.nsa.gov>
In-Reply-To: <45A3BA1B.9000908@mentalrootkit.com>
References: <45A2AADC.1090907@mentalrootkit.com>
	 <1168327098.22423.93.camel@code.and.org>
	 <45A3BA1B.9000908@mentalrootkit.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-t+HQ/h0GO71fYpzxDHX7"
Date: Tue, 09 Jan 2007 11:50:05 -0500
Message-Id: <1168361406.13080.12.camel@code.and.org>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-t+HQ/h0GO71fYpzxDHX7
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2007-01-09 at 10:51 -0500, Karl MacMillan wrote:
> James Antill wrote:
> > On Mon, 2007-01-08 at 15:34 -0500, Karl MacMillan wrote:

> >> I didn't want to add additional set functions - I would have preferred=
=20
> >> to allow sepol_policy_file_set_[mem,fd] to transparently open compress=
ed=20
> >> streams with functions to set other behaviors as options stored in=20
> >> sepol_policy_file_t structs. This was not possible becuase the current=
=20
> >> set functions do not return errors.
> >=20
> >  Do we really care about the memory usage, my instinct would be to drop
> > the FILE specific code and just dump everything into memory and then
> > call the mem_set function and thus. have only one decompression loop
> > (adding the fd version is simple then too).
> >  Calling fstat(fileno(fp)) to read the policy in is probably easier tha=
n
> > a loop.
> >=20
>=20
> Not certain what you are getting at - both code paths result in an=20
> uncompressed copy of the compressed data in memory. The only difference=20
> is whether we are decompressing from an fd or from another memory buffer.

 Just that it seems easier to have the set_fp() function load all the
data into memory and call the set_mem() function, and have all of the
bz2 stuff in just the set_mem() function.

> > . check is always true in callers, and I'm not sure why you'd have it
> > zero.
> >=20
>=20
> The magic number checking seems fragile - I'm assuming it might be=20
> necessary to force the stream as compressed at some point. Since we are=20
> maintaining ABI for this library (and these functions), seems better to=20
> be safe.

 Do policy files not have a magic value, then? You can also (for bz2)
check that the next value is between 1 and 9 (it's the compression
ratio).
 I assume this means you'd rely on anything ending in ".bz2" being
compressed, and not otherwise ... do we always have a filename?

> > . All code paths have:
> >=20
> >  if (set_foo_bz2() =3D=3D FAILED)
> >   set_foo();
> >=20
> > ...which tells me set_foo_bz2() should do that ... in fact it seems san=
e
> > to just change set_foo() to check of bz2ness and do the right thing,
> > without having to alter the callers.
> >=20
>=20
> Note my comments with the original patch - this isn't possible because=20
> set_foo() has a void return and we want to maintain binary compatibility.

 Right, but as I said the error paths always just try again without
compression ... so why not just try the compression at the start of the
set_foo() code. You get the same behaviour.

> >  I assume the only reason you went with bzip2 over gzip is the "have to
> > init yourself in the set_mem case"?
>=20
> No - just better compression.
>=20
> [kmacmill@localhost ~]$ ls -l base.pp.*
> -rw-r--r-- 1 kmacmill kmacmill  86379 Jan  9 10:50 base.pp.bz2
> -rw-r--r-- 1 kmacmill kmacmill 167382 Jan  9 10:50 base.pp.gz

 Wow ... that's better than usual. Do you have the same difference for
smaller modules?

--=20
James Antill <jantill@redhat.com>

--=-t+HQ/h0GO71fYpzxDHX7
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBFo8e911eXTEMrxtQRAnGWAJ9susj9Kk7smOfqtHCG6Hy+uuxkjwCgnBdX
QGPjF70wqEAZYZ6eh3zfINM=
=Asdf
-----END PGP SIGNATURE-----

--=-t+HQ/h0GO71fYpzxDHX7--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
