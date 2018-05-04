Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w44CJPES022439
 for <selinux@tycho.nsa.gov>; Fri, 4 May 2018 08:19:25 -0400
Received: by mail-wm0-f46.google.com with SMTP id n10-v6so4416860wmc.1
 for <selinux@tycho.nsa.gov>; Fri, 04 May 2018 05:19:21 -0700 (PDT)
Received: from julius.enp8s0.d30 ([217.19.26.10])
 by smtp.gmail.com with ESMTPSA id h51-v6sm7130120eda.88.2018.05.04.05.19.19
 for <selinux@tycho.nsa.gov>
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 04 May 2018 05:19:19 -0700 (PDT)
Date: Fri, 4 May 2018 14:19:15 +0200
From: Dominick Grift <dac.override@gmail.com>
To: selinux@tycho.nsa.gov
Message-ID: <20180504121915.GA3263@julius.enp8s0.d30>
References: <27be33f6-67d1-38bf-0351-4ea5af2fb1e1@tycho.nsa.gov>
 <83e8bd2a-a2c9-5d2e-4667-e98ab2821cd9@tycho.nsa.gov>
 <709e6b08-2a3a-84ec-da43-f514469d45f7@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="GvXjxJ+pjyke8COw"
In-Reply-To: <709e6b08-2a3a-84ec-da43-f514469d45f7@tycho.nsa.gov>
Subject: Re: Last call for selinux userspace 2.8 release
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--GvXjxJ+pjyke8COw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 03, 2018 at 10:52:24AM -0400, Stephen Smalley wrote:
> Hi,
>=20
> If you have encountered any unreported problems with the 2.8-rcX releases=
 or have any
> pending patches you believe should be included in the 2.8 release, please=
 post them soon.
> Also, let us know of any additions or changes that should be made to the =
release notes;
> the current draft is as follows.
>=20
> User-visible changes:

One might see processes "validate_context" where they didnt before

Generally processes that use lgetfilecon/lsetfilecon i suspect (like lvm, v=
arious systemd components etc)

>=20
> * semanage fcontext -l now also lists home directory entries from
> file_contexts.homedirs.
>=20
> * semodule can now enable or disable multiple modules in the same
> operation by specifying a list of modules after -e or -d, making them
> consistent with the -i/u/r/E options.
>=20
> * CIL now supports multiple declarations of types, attributes, and
> (non-conflicting) object contexts (e.g. genfscon), enabled via the -m
> or --multiple-decls option to secilc.
>=20
> * libsemanage no longer deletes the tmp directory if there is an error
> while committing the policy transaction, so that any temporary files
> can be further inspected for debugging purposes (e.g. to examine a
> particular line of the generated CIL module).  The tmp directory will
> be deleted upon the next transaction, so no manual removal is needed.
>=20
> * Support was added for SCTP portcon statements. The corresponding
> kernel support was introduced in Linux 4.17, and is only active if the
> extended_socket_class policy capability is enabled in the policy.
>=20
> * sepol_polcap_getnum/name() were exported as part of the shared libsepol
> interface, initially for use by setools4.
>=20
> * semodule_deps was removed since it has long been broken and is not usef=
ul
> for CIL modules.
>=20
> Packaging-relevant changes:
>=20
> * When overriding PREFIX, BINDIR, SBINDIR, SHLIBDIR, LIBEXECDIR, etc.,
> DESTDIR has to be removed from the definition. For example on Arch
> Linux, SBINDIR=3D"${pkgdir}/usr/bin" was changed to SBINDIR=3D"/usr/bin".
>=20
> * Defining variable LIBSEPOLA (to /usr/lib/libsepol.a, for example) is
> no longer mandatory (thanks to the switch to "-l:libsepol.a" in
> Makefiles).
>=20
> * PYSITEDIR has been renamed PYTHONLIBDIR (and its definition changed).
>=20
> * selinux-gui (i.e. system-config-selinux GUI application) is now
> compatible with Python 3. Doing this required migrating away from
> PyGTK to the supported PyGI library. This means that selinux-gui now
> depends on python-gobject, Gtk+ 3 and selinux-python. It no longer
> requires PyGtk or Python 2.

--=20
Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B02
https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B6B02
Dominick Grift

--GvXjxJ+pjyke8COw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCAAdFiEEujmXliIBLFTc2Y4AJXSOVTf5R2kFAlrsT8AACgkQJXSOVTf5
R2l+FAwAtRAFCuLcNM7EqhvHG6ShdNtwsGyjyFoO/k61eWpbIO95wH2dapamf7Zc
nl36pl7dxdXmlreq9Qxj7F5aD82DJzv9UxNu81CjijkktFqZccJ1Fc7wf5REI+RC
HXeWD5gKHH8AntPcV4USnH0zHARVLrOtqfip4FA+RZBdnbumeTQOB84Ri8D3P6RJ
FQ/oDIjUbGgZJe7qAVz4LOErYeXh9ZFU+RVboWTMRAfEsQclTQ7wYivXMHQkCg0l
6wUSYkM512HsOEZsgSe+SPIwfmhiRZs/Ts59PTWb/FxV8+/PTbXqsGXYz9++Bj1u
vzzwgwUr312BBkJd/QTIdz1n4qjAp8EJ4jPw7Jp+iwCxqA1k6MAMQh3vQs1YXvwu
x5H1BWSyJcoVvuigMw1cBIV4SmTs4ur1dJsoh+6ixqf1rw6YIV74yYWClfMoceOZ
ZYdI0OopYtsjrqMIzt5doJgWBv61Wm2KpGfiqM2zkkSg7zM0BAYKnDnm2zyCBpqQ
bTiEUbRf
=oEiY
-----END PGP SIGNATURE-----

--GvXjxJ+pjyke8COw--
