Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w44DGucW027089
 for <selinux@tycho.nsa.gov>; Fri, 4 May 2018 09:16:56 -0400
Received: by mail-wm0-f48.google.com with SMTP id l1-v6so4755785wmb.2
 for <selinux@tycho.nsa.gov>; Fri, 04 May 2018 06:16:46 -0700 (PDT)
Received: from julius.enp8s0.d30 ([217.19.26.10])
 by smtp.gmail.com with ESMTPSA id h30-v6sm9129997edh.73.2018.05.04.06.16.44
 for <selinux@tycho.nsa.gov>
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 04 May 2018 06:16:44 -0700 (PDT)
Date: Fri, 4 May 2018 15:16:43 +0200
From: Dominick Grift <dac.override@gmail.com>
To: selinux@tycho.nsa.gov
Message-ID: <20180504131643.GB3263@julius.enp8s0.d30>
References: <27be33f6-67d1-38bf-0351-4ea5af2fb1e1@tycho.nsa.gov>
 <83e8bd2a-a2c9-5d2e-4667-e98ab2821cd9@tycho.nsa.gov>
 <709e6b08-2a3a-84ec-da43-f514469d45f7@tycho.nsa.gov>
 <20180504121915.GA3263@julius.enp8s0.d30>
 <4b96edef-b5cd-c547-b57f-64e13564bd4c@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="8P1HSweYDcXXzwPJ"
In-Reply-To: <4b96edef-b5cd-c547-b57f-64e13564bd4c@tycho.nsa.gov>
Subject: Re: Last call for selinux userspace 2.8 release
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--8P1HSweYDcXXzwPJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 04, 2018 at 09:09:20AM -0400, Stephen Smalley wrote:
> On 05/04/2018 08:19 AM, Dominick Grift wrote:
> > On Thu, May 03, 2018 at 10:52:24AM -0400, Stephen Smalley wrote:
> >> Hi,
> >>
> >> If you have encountered any unreported problems with the 2.8-rcX relea=
ses or have any
> >> pending patches you believe should be included in the 2.8 release, ple=
ase post them soon.
> >> Also, let us know of any additions or changes that should be made to t=
he release notes;
> >> the current draft is as follows.
> >>
> >> User-visible changes:
> >=20
> > One might see processes "validate_context" where they didnt before
> >=20
> > Generally processes that use lgetfilecon/lsetfilecon i suspect (like lv=
m, various systemd components etc)
>=20
> That should no longer be true as of -rc2 since I reverted the libselinux:=
 verify file_contexts when using restorecon change.

Oh thanks, yes fedora is still on RC1.

>=20
> >=20
> >>
> >> * semanage fcontext -l now also lists home directory entries from
> >> file_contexts.homedirs.
> >>
> >> * semodule can now enable or disable multiple modules in the same
> >> operation by specifying a list of modules after -e or -d, making them
> >> consistent with the -i/u/r/E options.
> >>
> >> * CIL now supports multiple declarations of types, attributes, and
> >> (non-conflicting) object contexts (e.g. genfscon), enabled via the -m
> >> or --multiple-decls option to secilc.
> >>
> >> * libsemanage no longer deletes the tmp directory if there is an error
> >> while committing the policy transaction, so that any temporary files
> >> can be further inspected for debugging purposes (e.g. to examine a
> >> particular line of the generated CIL module).  The tmp directory will
> >> be deleted upon the next transaction, so no manual removal is needed.
> >>
> >> * Support was added for SCTP portcon statements. The corresponding
> >> kernel support was introduced in Linux 4.17, and is only active if the
> >> extended_socket_class policy capability is enabled in the policy.
> >>
> >> * sepol_polcap_getnum/name() were exported as part of the shared libse=
pol
> >> interface, initially for use by setools4.
> >>
> >> * semodule_deps was removed since it has long been broken and is not u=
seful
> >> for CIL modules.
> >>
> >> Packaging-relevant changes:
> >>
> >> * When overriding PREFIX, BINDIR, SBINDIR, SHLIBDIR, LIBEXECDIR, etc.,
> >> DESTDIR has to be removed from the definition. For example on Arch
> >> Linux, SBINDIR=3D"${pkgdir}/usr/bin" was changed to SBINDIR=3D"/usr/bi=
n".
> >>
> >> * Defining variable LIBSEPOLA (to /usr/lib/libsepol.a, for example) is
> >> no longer mandatory (thanks to the switch to "-l:libsepol.a" in
> >> Makefiles).
> >>
> >> * PYSITEDIR has been renamed PYTHONLIBDIR (and its definition changed).
> >>
> >> * selinux-gui (i.e. system-config-selinux GUI application) is now
> >> compatible with Python 3. Doing this required migrating away from
> >> PyGTK to the supported PyGI library. This means that selinux-gui now
> >> depends on python-gobject, Gtk+ 3 and selinux-python. It no longer
> >> requires PyGtk or Python 2.
> >=20
>=20

--=20
Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B02
https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B6B02
Dominick Grift

--8P1HSweYDcXXzwPJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCAAdFiEEujmXliIBLFTc2Y4AJXSOVTf5R2kFAlrsXTcACgkQJXSOVTf5
R2mRsQwAt1DzLNvux9NfAC9UapuEAWC3iTAQCVFTKOhu38xIGzqLl3zTfLM3nZla
u/C0bFyQ1hOe6thTbrWBZcn+j2uV/1hZG3jCf2jmsl4yRIgLKjcEXI8EdQGTbZQC
C4zdBwqTao5sKaBLuZFeV/zNZrT7/0Ip4wK2o65dxE22zULlS4jAUaLUmpTFCTal
jxKlRmuGXrPCPecpCXCWsJG48vL7jnjkg6veknD2YH2D18YEadC9IEFOg+Aq8AyR
np8CHuiQaKkttEGYnBoJacsAlRRaCoCf2shGVEGUTlRlXEdsrpemrB16J5OPVk1O
YinhP2G5E915L0lfM5lFB0nXG83sYUpD6H0s1oF1+8xQVnCSQ483PVKqVLpGM9+W
tziQbP0HzDIz78FVKqGqj2ReiTKB9pKuoZFfF2ME4rCs76674PAWsNnix7GFB4yo
Wr6PHPcZSEnBeCCOI7PPmgmeEmtzL5gtvG+ES1xpGGYPfkIX7IC3k9ayAdIUeBg0
EcnRRFrU
=Po6/
-----END PGP SIGNATURE-----

--8P1HSweYDcXXzwPJ--
