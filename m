Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l097Ha46023945
	for <selinux@tycho.nsa.gov>; Tue, 9 Jan 2007 02:17:37 -0500
Received: from mail.and.org (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l097IPMl024992
	for <selinux@tycho.nsa.gov>; Tue, 9 Jan 2007 07:18:25 GMT
Subject: Re: [RFC] Support for bzip compressed modules
From: James Antill <jantill@redhat.com>
To: Karl MacMillan <kmacmillan@mentalrootkit.com>
Cc: SELinux Mail List <selinux@tycho.nsa.gov>
In-Reply-To: <45A2AADC.1090907@mentalrootkit.com>
References: <45A2AADC.1090907@mentalrootkit.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-+s+APtVbrIx6w3i1lJ28"
Date: Tue, 09 Jan 2007 02:18:18 -0500
Message-Id: <1168327098.22423.93.camel@code.and.org>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-+s+APtVbrIx6w3i1lJ28
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2007-01-08 at 15:34 -0500, Karl MacMillan wrote:

> The patch implements this support by changing sepol_policy_file_t to=20
> support decompressing files or memory areas into a private memory copy.=20
> This support is optional - dlopen is used so that a hard dependency to=20
> libbz2 is not introduced. I took the approach of decompressing the=20
> entire file or memory area because:

 Why don't we want to depend on libbz, if we are building with bz2
support?=20

> * It is very simple
> * The current code depends on the ability to seek within policy files -=20
> this is not really possible within compressed streams using the bzip2=20
> library.
>=20
> The downsides are:
>=20
> * Increased memory usage
> * No transparent support for compressed writing with an fd based policy=20
> file.
>=20
> I didn't want to add additional set functions - I would have preferred=20
> to allow sepol_policy_file_set_[mem,fd] to transparently open compressed=20
> streams with functions to set other behaviors as options stored in=20
> sepol_policy_file_t structs. This was not possible becuase the current=20
> set functions do not return errors.

 Do we really care about the memory usage, my instinct would be to drop
the FILE specific code and just dump everything into memory and then
call the mem_set function and thus. have only one decompression loop
(adding the fd version is simple then too).
 Calling fstat(fileno(fp)) to read the policy in is probably easier than
a loop.

> Comments appreciated. Some very crude benchmarking below (note that I am=20
> using a patched semodule to allow the globbing syntax - patch for that=20
> to follow). The summary is that there is substantial space savings at=20
> the expense of some increase in time to complete common actions. An=20
> acceptable trade-off in my opinion.
>=20
> Anyone have suggestions for something as simple as time but for max=20
> memory usage?

 There's memusage in glibc-utils.

---- code ----

 The bz2 code looks fine, although the +=3D BUFSIZE in one loop and *=3D 2
in the other is weird, and there's a couple of minor nits in the
interface:

. check is always true in callers, and I'm not sure why you'd have it
zero.

. All code paths have:

 if (set_foo_bz2() =3D=3D FAILED)
  set_foo();

...which tells me set_foo_bz2() should do that ... in fact it seems sane
to just change set_foo() to check of bz2ness and do the right thing,
without having to alter the callers.

. A personal minor nit is that free(NULL) works fine, so don't work
around it (this idiom seems to be used in sepol).

. sepol_policy_file_free_data() is also called multiple times at the end
of the set_foo_bz2() functions (once inside set_foo() and then
explicitly immediately after).


 I assume the only reason you went with bzip2 over gzip is the "have to
init yourself in the set_mem case"? I've done that before[1], so I can
help you get that bit done if you want ... this will drop
CPU/memory/dependency requirements (although expecting all Linux to have
libbz now isn't a big deal, IMO).


[1] http://www.and.org/vstr/examples/ex_zcat.c


--=20
James Antill <jantill@redhat.com>

--=-+s+APtVbrIx6w3i1lJ28
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBFo0G611eXTEMrxtQRApqAAJ4oUHSqknhh3MW0UnihV8EMd2/VGwCfW/tl
GV49PSg99TKqIAy56Mp15zI=
=m4dg
-----END PGP SIGNATURE-----

--=-+s+APtVbrIx6w3i1lJ28--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
