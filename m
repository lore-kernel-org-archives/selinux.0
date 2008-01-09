Date: Wed, 9 Jan 2008 12:30:01 +0300
From: Andrey Markelov <andrey@markelov.net>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: SELinux@tycho.nsa.gov, Daniel J Walsh <dwalsh@redhat.com>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>
Subject: Re: Man pages translation (Russian) policycoreutils and reference
 policy
Message-Id: <20080109123001.f8b6ab56.andrey@markelov.net>
In-Reply-To: <1199796599.2944.268.camel@moss-spartans.epoch.ncsc.mil>
References: <20071229145711.b16ceab7.andrey@markelov.net>
	<1199737002.2944.257.camel@moss-spartans.epoch.ncsc.mil>
	<20080108012439.7ce2ec99.andrey@markelov.net>
	<1199796599.2944.268.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Wed__9_Jan_2008_12_30_01_+0300_H7k2lORLdlaf_lqt"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--Signature=_Wed__9_Jan_2008_12_30_01_+0300_H7k2lORLdlaf_lqt
Content-Type: text/plain; charset=Windows-1251
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Ok. If you possible in future have plans to re-structures source tree,
you may keep in mind this option for mans internalization.

On Tue, 08 Jan 2008 07:49:59 -0500
Stephen Smalley <sds@tycho.nsa.gov> wrote:

>=20
> On Tue, 2008-01-08 at 01:24 +0300, Andrey Markelov wrote:
> > It could be placed into in man/COUNTRY_CODE_ISO3166/man1...man8 like in=
 rpm packages.
> > For example in mc (http://www.ibiblio.org/mc/) and rpm (http://www.rpm.=
org/)
> > source tarballs Russian (and some other) man pages is present.
>=20
> Currently the policycoreutils man pages are colocated with the
> individual programs in the individual program subdirectories in the
> source tree, e.g.
> policycoreutils/newrole/newrole.1
> policycoreutils/semanage/semanage.8
> policycoreutils/semodule/semodule.8
>=20
> I suppose we could change that, but we'd have to rearrange the source
> tree, update the makefiles, etc.
>=20
> > On Mon, 07 Jan 2008 15:16:42 -0500
> > Stephen Smalley <sds@tycho.nsa.gov> wrote:
> > >=20
> > > On Sat, 2007-12-29 at 14:57 +0300, Andrey Markelov wrote:
> > > > Hello!
> > > >=20
> > > > I have translated all man pages from policycoreutils and from refer=
ence policy to Russian language.
> > > > Now all of thous is in Rawhide/Fedora 8 (selinux-policy and policyc=
oreutils RPMs).
> > > > Is it possible to include Russian translations in main stream of NS=
A=92s package policycoreutils
> > > > and reference policy package of Tresys?
> > > > I hope it will be useful for security specialists who work with oth=
er distributions than Fedora.
> > > > Here is archives of man pages in attachment. My next goal for trans=
lation is libselinux.
> > >=20
> > > We only provide source tarballs - not sure how we would package up
> > > multiple translations for the man pages.=20
> > >=20
> > > --=20
> > > Stephen Smalley
> > > National Security Agency
> > >=20
> --=20
> Stephen Smalley
> National Security Agency
>=20

--Signature=_Wed__9_Jan_2008_12_30_01_+0300_H7k2lORLdlaf_lqt
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQFHhJQZ8hmtVPyc4x4RAj/iAJ9PteQtxtvoUKkVDjtVWPV2glRY5ACfXASb
jXsoOZULe1et0kJwJUd+QiE=
=IMpV
-----END PGP SIGNATURE-----

--Signature=_Wed__9_Jan_2008_12_30_01_+0300_H7k2lORLdlaf_lqt--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
