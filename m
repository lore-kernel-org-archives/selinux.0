Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o5RBUoiK024633
	for <selinux@tycho.nsa.gov>; Sun, 27 Jun 2010 07:30:51 -0400
Received: from mail-wy0-f181.google.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id o5RBTvdD001792
	for <selinux@tycho.nsa.gov>; Sun, 27 Jun 2010 11:29:58 GMT
Received: by wyg36 with SMTP id 36so560501wyg.12
        for <selinux@tycho.nsa.gov>; Sun, 27 Jun 2010 04:30:48 -0700 (PDT)
Message-ID: <4C27365A.9040604@gmail.com>
Date: Sun, 27 Jun 2010 13:30:34 +0200
From: Dominick Grift <domg472@gmail.com>
MIME-Version: 1.0
To: Joshua Kramer <josh@globalherald.net>
CC: selinux@tycho.nsa.gov
Subject: Re: Rebuilding Modified Base Policy on RHEL6 (was  on-Computing Abstractions
 & An Issue Thereof)
References: <289557.20002.qm@web87003.mail.ird.yahoo.com> <4C2652F3.8010309@globalherald.net> <4C2687E7.5000705@globalherald.net>
In-Reply-To: <4C2687E7.5000705@globalherald.net>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig1D45817C4DF5CE03D6E1E7F1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig1D45817C4DF5CE03D6E1E7F1
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 06/27/2010 01:06 AM, Joshua Kramer wrote:
>=20
>> Is the method for rebuilding policy explained in the following guide,
>> still effective for RHEL6?
>> http://danwalsh.livejournal.com/26428.html
>>
> Ok, so I followed the instructions on the noted page; specifically, nea=
r
> the bottom.  This line works to rebuild policy on RHEL6:
>=20
> *make validate UNK_PERMS=3Dallow NAME=3Dstrict TYPE=3Dmcs DISTRO=3Dredh=
at UBAC=3Dn
> DIRECT_INITRC=3Dy MONOLITHIC=3Dn POLY=3Dy MLS_CATS=3D1024 MCS_CATS=3D10=
24 base
>=20
> However, if I do this*, to switch the build from strict to targeted:
>=20
> cd ~/sources/BUILD/serefpolicy-VERSION
> make UNK_PERMS=3Dallow NAME=3Dtargeted TYPE=3Dmcs DISTRO=3Dredhat UBAC=3D=
n
> DIRECT_INITRC=3Dy MONOLITHIC=3Dn POLY=3Dy MLS_CATS=3D1024 MCS_CATS=3D10=
24 bare
> make conf
> make UNK_PERMS=3Dallow NAME=3Dtargeted TYPE=3Dmcs DISTRO=3Dredhat UBAC=3D=
n
> DIRECT_INITRC=3Dy MONOLITHIC=3Dn POLY=3Dy MLS_CATS=3D1024 MCS_CATS=3D10=
24 conf
>=20
> ...the make breaks with this error:
>=20
> Creating targeted base module base.conf
> cat tmp/pre_te_files.conf tmp/all_attrs_types.conf tmp/global_bools.con=
f
> tmp/only_te_rules.conf tmp/all_post.conf > base.conf
> Compiling targeted base module
> /usr/bin/checkmodule -M -U allow base.conf -o tmp/base.mod
> /usr/bin/checkmodule:  loading policy configuration from base.conf
> policy/modules/kernel/domain.te":195:ERROR 'type selinux_config_t is no=
t
> within scope' at token ';' on line 9468:
> #line 195
>     dontaudit domain selinux_config_t:dir { getattr search open };
> /usr/bin/checkmodule:  error(s) encountered while parsing configuration=

> make: *** [tmp/base.mod] Error 1
>=20
> It breaks even with a non-modified policy (i.e. install src.rpm and run=

> this make command).
>=20
> Do I need to do this, even if I only want to build a modified "targeted=
"
> version of the policy?  Is it "strict" by default?
>=20
> Thanks,
> -Josh

that is because with redhat policy some of the modules need to be in
base i believe. You should use the selinux-policy.spec that is shipped
in the selinux-policy.src.rpm, modify it if required.

The spec replaces the modules*.conf. redhat ships modules.conf files
that are modified (some modules get moved to base to avoid these out of
scope issues)

in short, use the selinux-policy.spec provided by redhat.

basically you download the source rpm, extract it, apply the include
patch to the serefpolicy.tgz (extract it, apply patch, edit it, create
new serefpolicy.tgz. Than copy all of it to ~/rpmbuild/SOURCES/ (minus
the patch). modify the spec : (remove all patch entries (two i think).
Also copy the spec to ~/rpmbuild/SPECS/

rpmbuild -ba ~/rpmbuild/SPECS/selinux-policy.spec




--------------enig1D45817C4DF5CE03D6E1E7F1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.14 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAkwnNmUACgkQMlxVo39jgT/1rwCfU0oahEFGbVvjcxLOghCfS9JF
dM4An0q2MIgUgMDxPLHWQg89N7WH4aCw
=K6ts
-----END PGP SIGNATURE-----

--------------enig1D45817C4DF5CE03D6E1E7F1--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
