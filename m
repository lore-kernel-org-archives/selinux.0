Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w44EUIXd000916
 for <selinux@tycho.nsa.gov>; Fri, 4 May 2018 10:30:18 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 535C1402385D
 for <selinux@tycho.nsa.gov>; Fri,  4 May 2018 14:30:12 +0000 (UTC)
Received: from workstation (unknown [10.43.12.4])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E08ED7C49
 for <selinux@tycho.nsa.gov>; Fri,  4 May 2018 14:30:11 +0000 (UTC)
Date: Fri, 4 May 2018 16:30:09 +0200
From: Petr Lautrbach <plautrba@redhat.com>
To: selinux@tycho.nsa.gov
Message-ID: <20180504143009.GB15778@workstation>
References: <27be33f6-67d1-38bf-0351-4ea5af2fb1e1@tycho.nsa.gov>
 <83e8bd2a-a2c9-5d2e-4667-e98ab2821cd9@tycho.nsa.gov>
 <709e6b08-2a3a-84ec-da43-f514469d45f7@tycho.nsa.gov>
 <20180504121915.GA3263@julius.enp8s0.d30>
 <4b96edef-b5cd-c547-b57f-64e13564bd4c@tycho.nsa.gov>
 <20180504131643.GB3263@julius.enp8s0.d30>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="5/uDoXvLw7AC5HRs"
In-Reply-To: <20180504131643.GB3263@julius.enp8s0.d30>
Subject: Re: Last call for selinux userspace 2.8 release
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--5/uDoXvLw7AC5HRs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 04, 2018 at 03:16:43PM +0200, Dominick Grift wrote:
> On Fri, May 04, 2018 at 09:09:20AM -0400, Stephen Smalley wrote:
> > On 05/04/2018 08:19 AM, Dominick Grift wrote:
> > > On Thu, May 03, 2018 at 10:52:24AM -0400, Stephen Smalley wrote:
> > >> Hi,
> > >>
> > >> If you have encountered any unreported problems with the 2.8-rcX rel=
eases or have any
> > >> pending patches you believe should be included in the 2.8 release, p=
lease post them soon.
> > >> Also, let us know of any additions or changes that should be made to=
 the release notes;
> > >> the current draft is as follows.
> > >>
> > >> User-visible changes:
> > >=20
> > > One might see processes "validate_context" where they didnt before
> > >=20
> > > Generally processes that use lgetfilecon/lsetfilecon i suspect (like =
lvm, various systemd components etc)
> >=20
> > That should no longer be true as of -rc2 since I reverted the libselinu=
x: verify file_contexts when using restorecon change.
>=20
> Oh thanks, yes fedora is still on RC1.

I've just built the following packages in Rawhide:

libselinux-2.8-0.rc2.1.fc29 - https://koji.fedoraproject.org/koji/taskinfo?=
taskID=3D26767629
libsemanage-2.8-0.rc2.1.fc29 - https://koji.fedoraproject.org/koji/taskinfo=
?taskID=3D26767782
policycoreutils-2.8-0.rc2.1.fc29 - https://koji.fedoraproject.org/koji/task=
info?taskID=3D26767903


> >=20
> > >=20
> > >>
> > >> * semanage fcontext -l now also lists home directory entries from
> > >> file_contexts.homedirs.
> > >>
> > >> * semodule can now enable or disable multiple modules in the same
> > >> operation by specifying a list of modules after -e or -d, making them
> > >> consistent with the -i/u/r/E options.
> > >>
> > >> * CIL now supports multiple declarations of types, attributes, and
> > >> (non-conflicting) object contexts (e.g. genfscon), enabled via the -m
> > >> or --multiple-decls option to secilc.
> > >>
> > >> * libsemanage no longer deletes the tmp directory if there is an err=
or
> > >> while committing the policy transaction, so that any temporary files
> > >> can be further inspected for debugging purposes (e.g. to examine a
> > >> particular line of the generated CIL module).  The tmp directory will
> > >> be deleted upon the next transaction, so no manual removal is needed.
> > >>
> > >> * Support was added for SCTP portcon statements. The corresponding
> > >> kernel support was introduced in Linux 4.17, and is only active if t=
he
> > >> extended_socket_class policy capability is enabled in the policy.
> > >>
> > >> * sepol_polcap_getnum/name() were exported as part of the shared lib=
sepol
> > >> interface, initially for use by setools4.
> > >>
> > >> * semodule_deps was removed since it has long been broken and is not=
 useful
> > >> for CIL modules.
> > >>
> > >> Packaging-relevant changes:
> > >>
> > >> * When overriding PREFIX, BINDIR, SBINDIR, SHLIBDIR, LIBEXECDIR, etc=
=2E,
> > >> DESTDIR has to be removed from the definition. For example on Arch
> > >> Linux, SBINDIR=3D"${pkgdir}/usr/bin" was changed to SBINDIR=3D"/usr/=
bin".
> > >>
> > >> * Defining variable LIBSEPOLA (to /usr/lib/libsepol.a, for example) =
is
> > >> no longer mandatory (thanks to the switch to "-l:libsepol.a" in
> > >> Makefiles).
> > >>
> > >> * PYSITEDIR has been renamed PYTHONLIBDIR (and its definition change=
d).
> > >>
> > >> * selinux-gui (i.e. system-config-selinux GUI application) is now
> > >> compatible with Python 3. Doing this required migrating away from
> > >> PyGTK to the supported PyGI library. This means that selinux-gui now
> > >> depends on python-gobject, Gtk+ 3 and selinux-python. It no longer
> > >> requires PyGtk or Python 2.
> > >=20
> >=20
>=20
> --=20
> Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B02
> https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B6B02
> Dominick Grift



--5/uDoXvLw7AC5HRs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE1qW2HJpVNBaCkttnviIJHj72InUFAlrsbmoACgkQviIJHj72
InXHThAAiafDBHOJlIfDXROeqia1ZiOaZlG1FlV/KnEHxsOZgSQoTGt7qXuP/Q6R
O2oNH1YmutNmEqBvNbVzaXKFbeaWiAOH3yVG1WEx+ATBk9NCcSr4MegEocvKQNO/
WTiDM5St3b45YjeUncVSojp1XBP+WfBcx7KGkU7UxYMz7p/cKUnKQiSETVKrmkbh
keCCEvsk8LocBaYePJZlEo9+0b94RpMv16PqPTs1bOCq7rDxHtQH9jicxaRNLaX1
Z0rVfKvj2Vr8rStCxXA/F+mH8Xqz4loeLl+AhgR3KxPMu6AL0NF4JYZgwvwCKbEc
W8XMdwTGaY3IOTuZow+hDp6hKqCAnamwKJwx84lr9I3s5q5PaNLTHP3PnlPnb7RF
EWhZubnPwry4Y8VGS03nx38hchPGjt9jMd9FctoxMh7zibd6C69NQxTcb4F/xn6B
Qf/29HLNAwPlOxrfCioa9Yk+b+NdpI/mjesf5cyOvaSx0wPStH6wdnMGaYGch/Zf
qFrIKtuJ6gYLgkbScZcWE6ibZ7PmbqYL4YBYDGFNLOiTe0LtplQvk1qatC4X17if
l9YFcFrLd+ssuE41NW6cVeBFoMhTRYqf6u3MziiHrWiepqyuK0KOuYu+fJoMsZqy
s4RvM94soMU6F9Ut/EwceljoTjg+bBnSJGXoti1EBeZUkVrmqMc=
=ZlJc
-----END PGP SIGNATURE-----

--5/uDoXvLw7AC5HRs--
