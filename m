Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v74JLpKV017975
 for <selinux@tycho.nsa.gov>; Fri, 4 Aug 2017 15:21:51 -0400
Received: by mail-wm0-f53.google.com with SMTP id t201so26923001wmt.1
 for <selinux@tycho.nsa.gov>; Fri, 04 Aug 2017 12:21:44 -0700 (PDT)
Received: from julius.enp8s0.d30 ([217.19.26.10])
 by smtp.gmail.com with ESMTPSA id a68sm3859286edf.92.2017.08.04.12.21.41
 for <selinux@tycho.nsa.gov>
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 04 Aug 2017 12:21:41 -0700 (PDT)
Date: Fri, 4 Aug 2017 21:21:39 +0200
From: Dominick Grift <dac.override@gmail.com>
To: selinux@tycho.nsa.gov
Message-ID: <20170804192139.GB24924@julius.enp8s0.d30>
References: <1497028696.26846.9.camel@tycho.nsa.gov>
 <1501873040.23158.3.camel@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="1LKvkjL3sHcu1TtY"
In-Reply-To: <1501873040.23158.3.camel@tycho.nsa.gov>
Subject: Re: ANN: SELinux userspace release 20170804 / 2.7
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--1LKvkjL3sHcu1TtY
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 04, 2017 at 02:57:20PM -0400, Stephen Smalley wrote:
> The 20170804 / 2.7 release for the SELinux userspace release is now
> available from:
> https://github.com/SELinuxProject/selinux/wiki/Releases

Thanks for bringing us this new release!

>=20
> Below are some notes on this release for packagers and users of the
> SELinux userspace.=A0=A0git log and git shortlog output for all changes
> since the 20161014 / 2.6 release are linked from the release page.=20
> Thanks to all the contributors to this release!
>=20
> If you notice corrections or additional items that should be added to
> the release notes (below and also linked from the releases page), reply
> to this message with your suggested changes/additions and we'll add
> them to the one linked from the releases page too.
>=20
> * This is the first release with the split up policycoreutils (see
> https://www.mail-archive.com/selinux@tycho.nsa.gov/msg02914.html and
> the rest of that thread). Fedora already packages many of these
> components separately, although not always with the same organization
> and naming scheme.=A0=A0Note that a number of these components are not
> necessary for basic use of SELinux and likely should not be installed
> by default, e.g. selinux-dbus, selinux-gui, mcstrans, restorecond,
> selinux-sandbox.
>=20
> * libsepol now has binary module support for ioctl xperms rules
> (module version 18), making it possible to use allowxperm rules in
> modularly built refpolicy-based policies. Previously, ioctl xperms
> rules were only supported in monolithic policy and in CIL modules.=A0
> This change means that refpolicy and/or policies derived from it can
> begin to leverage ioctl whitelisting, which has already been leveraged
> for some time in Android policies, which do not rely on binary modules.
>=20
> * This release introduces support for Infiniband object labeling,
> including support for kernel policy version 31 and module version 19,
> policy.conf and CIL language support, and semanage support.=A0=A0The
> corresponding kernel support was introduced in Linux v4.13.
>=20
> * This release introduces support for building policies with the
> extended_socket_class, cgroup_seclabel, and nnp_nosuid_transition
> policy
> capabilities enabled:
>=20
> ** The extended_socket_class policy capability allows distinctions to
> be made in policy among socket address families that were previously
> mapped to the generic socket class (e.g. bluetooth, nfc, and many
> other socket address families that previously did not have their own
> distinct security class) as well as for SCTP and ICMP/ping sockets
> that were previously mapped to the rawip_socket class.=A0=A0This policy
> capability is supported by Linux v4.11 and later. Enabling this
> capability
> in policy requires reviewing existing rules on socket and rawip_socket
> classes to determine whether they should be duplicated for the new
> classes.
>=20
> ** The cgroup_seclabel policy capability allows userspace to set
> labels on cgroup/cgroup2 files, enabling fine-grained labeling of
> cgroup files by userspace.=A0=A0This policy capability is also supported
> by Linux v4.11 and later. Note that enabling this capability will
> break current Android userspace/policy and requires introducing
> appropriate file_contexts definitions for cgroup files (or a change to
> the Android init program's handling of them) in order to avoid
> mislabeling them.
>=20
> ** The nnp_nosuid_transition policy capability enables SELinux domain
> transitions to occur under no_new_privs (NNP) or on nosuid mounts if
> the corresponding permission (nnp_transition for NNP,
> nosuid_transition for nosuid; both in the newly defined process2
> security class / access vector) is allowed between the old and new
> contexts.=A0=A0This change was motivated by the increasing use of NNP by
> systemd for confining system services and the desire to be able to
> leverage NNP/nosuid-provided protections in combination with SELinux
> rather than having to make undesirable tradeoffs in security. With
> this policy capability enabled and the corresponding permissions
> allowed where required, it should be possible to use upstream systemd
> unit files without modification on SELinux-enabled systems.
> NB: Allowing nnp_transition between two contexts opens up the
> potential for the old context to subvert the new context by
> installing seccomp filters before the execve.=A0=A0Allowing
> nosuid_transition between two contexts opens up the potential for
> a context transition to occur on a file from an untrusted
> filesystem (e.g. removable media or remote filesystem).=A0=A0Use with
> care.

Linux support is expected with 4.14

>=20
> * checkpolicy now supports generating CIL or policy.conf from a
> kernel binary policy.=A0=A0Sample usage is checkpolicy -M -C -b policy.N =
-o
> policy.cil and checkpolicy -M -F -b policy.N -o policy.conf.=A0=A0There is
> also now a secil2conf program that can generate policy.conf from CIL,
> e.g. secil2conf -o policy.conf policy.cil.
>=20
> * Attribute generation and expansion has changed in several ways in
> order to address kernel runtime performance issues that occur when
> types have many attributes assigned to them while ensuring preservation
> of attributes where desired.=A0=A0Binary module to CIL conversion now
> ensures that duplicate attributes are not generated for the same type
> set. secilc now supports -G and -X options to force expansion of
> automatically generated attributes (-G) and/or attributes that have
> fewer than a specified number of types (-X number).=A0=A0secilc will also
> now more aggressively expand attributes based on whether they will
> actually be used by the kernel, are needed for debugging denials by
> audit2allow/why, or are needed for neverallow checking of binary
> policies (in Android).=A0=A0New statements are supported in policy.conf
> (expandattribute) and in CIL (expandtypeattribute) to support
> specifying in source policy that specific attributes should always be
> expanded or never be expanded in order to override the default
> behaviors in checkpolicy and secilc.

This statement (expandtypeattribute) should probably be documented in the s=
ecilc docs:

https://github.com/SELinuxProject/selinux/tree/master/secilc/docs

>=20
> * checkpolicy/checkmodule now treats it as an error if a type is
> declared as an attribute or vice versa in a require block.=A0=A0Such
> mismatches between declarations and require statements are an error in
> policy and should be corrected in policy; refpolicy master should
> already be fixed.
>=20
> * A change to libsepol-internal data structures breaks the build of
> setools4.=A0=A0This is fixed by setools4 commit
> 743d2a0eaaae7d99302dd3099549ca7ad868eab on the master branch.=A0=A0The
> change was to align the libsepol structures with the kernel in order to
> allow direct comparison of libsepol-generated policy files against
> /sys/fs/selinux/policy after normalizing them through checkpolicy.
>=20
> * audit2why now understands type bounds failures and reports them as
> such, although it does not yet provide detailed reporting.=A0=A0Detailed
> bounds violation reporting can be obtained already by enabling expand-
> check=3D1 in semanage.conf or by running semodule_expand (without -a) at
> policy validation time.
>=20
> * libsemanage now saves the linked policy and skips re-linking
> whenever possible.=A0=A0This significantly improves the performance and
> memory overhead of semanage commands that do not affect policy modules
> (setting booleans and adding, deleting, or modifying local context
> mappings). Previously, libsemanage only skipped re-linking when setting
> booleans as a special case, but this was found to have a bug that could
> yield duplicate object context entries (e.g. portcon) in policy.=A0=A0That
> optimization was therefore reverted and replaced with this one, which
> both fixes the bug and generalizes the optimization beyond just setting
> booleans.=A0=A0The change does bring an associated storage cost, primarily
> storing an extra copy of the kernel policy file (if a concern, this
> could be made optional but it seems well worth it). The first semanage
> or setsebool -P command run with the new libsemanage will not
> demonstrate any improvement due to needing to generate the linked
> policy for the first time, but subsequent commands will leverage the
> saved linked policy.
>=20
> * libsemanage no longer depends on ustr.
>=20
> * libselinux/utils Makefile now uses SBINDIR instead of USRBINDIR.
>=20
> * mcstrans/utils Makefile now uses SBINDIR instead of BINDIR.
>=20
> * Some packages (libselinux, checkpolicy, selinux-python,
> semodule-utils and mcstrans) require LIBSEPOLA to be set to the
> absolute path to libsepol.a when building with DESTDIR set.
>=20
> * policycoreutils make install no longer creates a symlink from
> /usr/sbin/load_policy to /sbin/load_policy.
>=20

--=20
Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B02
https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B6B02
Dominick Grift

--1LKvkjL3sHcu1TtY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCAAdFiEEujmXliIBLFTc2Y4AJXSOVTf5R2kFAlmEyT8ACgkQJXSOVTf5
R2lN5wwAj+h/nHgxvh8rMPSPAwf61jvr/dap/htRehlg5TNP24HGkz3aqnBhHnkJ
4BkNIslYvUesBjqWvbjjAjaYqZp1SEnVECURx4NZYtfSKVwa6QCJOIGlZx5mdosh
uX1AWzU7FQN18BC1qD2mqH01tzliEGzWQvAuxfQ8d8yp33fP7Y338FxceuWOX7GW
GZL8TjXLeH4E/DL7thuQkn7pV3IVoDoEhXpIaefGvGYSDn/laUoc2M8LhRbw8dD/
nj8VVMvuQOPLqyokrNl4W+z2TqWLNfXDvqHoX9A546Z/GTR2O/P5h1zFs+xVseuw
gSQAjs2xcLbTe6fnpmtccQmtBijFnLNf1Gcv5ZIImD/xpaT1qa6HEkEDW5IIUkVV
urZo4JeynkvJc2g5HfJGikESLrk1U/pXnpBEkL8XNK5dttbs7JhShtHNz+W3QbE5
VddepOLEEyRbZmi+cc33YBKq87WRn75i95vkpOJ9rY+5nvBHRObP5tcGUmd+CMas
lkhxsXQ+
=MOoV
-----END PGP SIGNATURE-----

--1LKvkjL3sHcu1TtY--
