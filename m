Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w44DQbNZ027839
 for <selinux@tycho.nsa.gov>; Fri, 4 May 2018 09:26:37 -0400
Received: by mail-wm0-f42.google.com with SMTP id a137-v6so7017583wme.1
 for <selinux@tycho.nsa.gov>; Fri, 04 May 2018 06:26:32 -0700 (PDT)
Received: from julius.enp8s0.d30 ([217.19.26.10])
 by smtp.gmail.com with ESMTPSA id w1-v6sm9510293edk.82.2018.05.04.06.26.30
 for <selinux@tycho.nsa.gov>
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 04 May 2018 06:26:30 -0700 (PDT)
Date: Fri, 4 May 2018 15:26:29 +0200
From: Dominick Grift <dac.override@gmail.com>
To: selinux@tycho.nsa.gov
Message-ID: <20180504132629.GC3263@julius.enp8s0.d30>
References: <27be33f6-67d1-38bf-0351-4ea5af2fb1e1@tycho.nsa.gov>
 <83e8bd2a-a2c9-5d2e-4667-e98ab2821cd9@tycho.nsa.gov>
 <709e6b08-2a3a-84ec-da43-f514469d45f7@tycho.nsa.gov>
 <20180504075510.GB5101@baraddur.perfinion.com>
 <3c51abc9-2d3a-3cef-2ba1-d976dee651c5@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="UPT3ojh+0CqEDtpF"
In-Reply-To: <3c51abc9-2d3a-3cef-2ba1-d976dee651c5@tycho.nsa.gov>
Subject: Re: Last call for selinux userspace 2.8 release
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--UPT3ojh+0CqEDtpF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 04, 2018 at 09:08:36AM -0400, Stephen Smalley wrote:
> On 05/04/2018 03:55 AM, Jason Zaman wrote:
> > On Thu, May 03, 2018 at 10:52:24AM -0400, Stephen Smalley wrote:
> >> Hi,
> >>
> >> If you have encountered any unreported problems with the 2.8-rcX relea=
ses or have any
> >> pending patches you believe should be included in the 2.8 release, ple=
ase post them soon.
> >=20
> > the rc2 release has been fine for me for several days now. And I havent
> > heard any issues from any gentoo users either so we're probably good to
> > go. -rc1 failed to boot properly for me because some important things in
> > /run or /dev didnt get labeled but that was fixed in rc2.
>=20
> Hmm...I'd like to understand that better. The change was verifying file_c=
ontexts when using restorecon,
> which was reverted in -rc2.  But the fact that it prevented labeling file=
s in -rc1 means that either
> you have a bug in your file_contexts configuration or there is some other=
 bug there.

If it cannot validate_context then it will be unhappy:

[root@julius ~]# dnf history info last
Transaction ID : 364
Begin time     : Fri 04 May 2018 01:12:36 PM CEST
Begin rpmdb    : 1404:e739a03c49fec80ed41a1ea4c599d8f877b01d76
End time       : Fri 04 May 2018 01:14:01 PM CEST (85 seconds)
End rpmdb      : 1404:27bd40dce7edbf226ffad80f482cd75231f1b6ab **
User           : kcinimod <kcinimod>
Return-Code    : Success
Command Line   : update --exclude efi-filesystem
Transaction performed with:
    Installed     dnf-2.7.5-12.fc29.noarch @rawhide
        Installed     rpm-4.14.1-8.fc28.x86_64 @tmp-rawhide
	Packages Altered:
	    Upgraded cockpit-166-1.fc29.x86_64                      @rawhide
=2E.. snip ...
Scriptlet output:
   1 restorecon: /etc/selinux/dssp2-standard/contexts/files/file_contexts: =
has invalid context sys.id:sys.role:files.generic_boot.boot_file:s0
      2 restorecon: /etc/selinux/dssp2-standard/contexts/files/file_context=
s: has invalid context sys.id:sys.role:files.generic_boot.boot_file:s0
         3 restorecon: /etc/selinux/dssp2-standard/contexts/files/file_cont=
exts: has invalid context sys.id:sys.role:files.generic_boot.boot_file:s0
	    4 restorecon: /etc/selinux/dssp2-standard/contexts/files/file_contexts=
: has invalid context sys.id:sys.role:files.generic_boot.boot_file:s0
	       5 restorecon: /etc/selinux/dssp2-standard/contexts/files/file_conte=
xts: has invalid context sys.id:sys.role:files.generic_boot.boot_file:s0

>=20
> >=20
> >> Also, let us know of any additions or changes that should be made to t=
he release notes;
> >> the current draft is as follows.
> >>
> >> User-visible changes:
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
> >=20
> > Perhaps also note that the sctp stuff is in refpolicy and this 2.8
> > release is required to compile it.
> >=20
> > I tried doing a release of the gentoo policy (we merge from HEAD fairly
> > frequently not only the big releases) and it fails to compile. I will
> > add the sctp stuff back into gentoo's policy later then make the
> > policies require >=3D2.8.
> >=20
> > -- Jason
> >=20
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

--UPT3ojh+0CqEDtpF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCAAdFiEEujmXliIBLFTc2Y4AJXSOVTf5R2kFAlrsX4EACgkQJXSOVTf5
R2mbZQwAlFH9qUiFJYV0QMDhPzDqD4cAkFL6WjpNDFr9lYly9pFIB5YWIO3+iykt
CmZdGKNu3MMQwHe2yfKRzJ9z40gGg7qazyWdm7gkLIhFmPfRPgkvOEoghu3eGB4B
dH88UcPEM5JUqfZlRPVo641Ne+rdY2iCpijU2WJAm9yEqDEsue1cZldUsSPcdZDj
3OF8TN1zD9riceq9ZM/0IMRxxS0ya4NMMDeINssbdyaDZhfLjBjSS6D/VhAFEZ2e
tCUNLPxWhjBJpAnjeX97XFs29VXv9ri24MbzVqecDhsP21ShnPKsE0wKPu2uE28i
mxbKzX/j/JG1jJGv48EsYlrtHd8W12EK0IuzzTtb5qBMy5wzZWTirAOkFxcBXTQD
kM3ZLAwv20SThbv0uBm6W/ndWGNuCTdj0ZBktI3jcIUkRekxVCNmC9NJGKP32SoG
ecII4AwIr5lQVJgoSHMpwSffEfvgU4BDnmHRZ/eK3F/danpug1V5mHOQIwwg5vSz
fKyaZ0jU
=gohY
-----END PGP SIGNATURE-----

--UPT3ojh+0CqEDtpF--
