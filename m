Return-Path: <SRS0=d3z6=4V=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8252FC3F2D1
	for <selinux@archiver.kernel.org>; Wed,  4 Mar 2020 19:26:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6026720870
	for <selinux@archiver.kernel.org>; Wed,  4 Mar 2020 19:26:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726561AbgCDT01 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 4 Mar 2020 14:26:27 -0500
Received: from agnus.defensec.nl ([80.100.19.56]:47076 "EHLO agnus.defensec.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726440AbgCDT00 (ORCPT <rfc822;selinux@vger.kernel.org>);
        Wed, 4 Mar 2020 14:26:26 -0500
Received: from brutus.lan (brutus.lan [IPv6:2001:985:d55d::438])
        by agnus.defensec.nl (Postfix) with ESMTPSA id 16DC61320611;
        Wed,  4 Mar 2020 20:26:24 +0100 (CET)
Date:   Wed, 4 Mar 2020 20:26:23 +0100
From:   Dominick Grift <dominick.grift@defensec.nl>
To:     James Carter <jwcart2@gmail.com>
Cc:     Dominick Grift <dac.override@gmail.com>, selinux@vger.kernel.org
Subject: Re: Fwd: strange issue with name-base type trans
Message-ID: <20200304192623.GG1032355@brutus.lan>
Mail-Followup-To: James Carter <jwcart2@gmail.com>,
        Dominick Grift <dac.override@gmail.com>, selinux@vger.kernel.org
References: <CAB9W1A3-z1YokQUHusrgeuaX2SGyRuh+4X7b_GMEgEo5xe6k_Q@mail.gmail.com>
 <65b5e705-3d42-57c9-6502-973486b3c3c8@tycho.nsa.gov>
 <CAP+JOzSZoUwi8Lfioiu7PRgmexU=0h73p-rkpRConE_jEXboSA@mail.gmail.com>
 <87v9nrbyge.fsf@gmail.com>
 <CAP+JOzTwO6zNA1o=ztKkO627TT8f9tp7dG=amde8Thx5wu+6JQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="yQbNiKLmgenwUfTN"
Content-Disposition: inline
In-Reply-To: <CAP+JOzTwO6zNA1o=ztKkO627TT8f9tp7dG=amde8Thx5wu+6JQ@mail.gmail.com>
User-Agent: Every email client sucks, this one just sucks less.
X-PGP-Key: https://sks-keyservers.net/pks/lookup?op=get&search=0xDA7E521F10F64098
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org


--yQbNiKLmgenwUfTN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 04, 2020 at 01:53:47PM -0500, James Carter wrote:
> On Thu, Feb 27, 2020 at 2:51 PM Dominick Grift <dac.override@gmail.com> w=
rote:
> >
> > James Carter <jwcart2@gmail.com> writes:
> >
> > > Sorry, email problems has made life a bit difficult over the past
> > > week. Steve had to forward this to me.
> > >
> > > So far, I am unable to duplicate what you are seeing.
> >
> > You can try it with my dssp3 policy:
> >
> > git clone git://defensec.nl/dssp3.git
> > cd dssp3
> > [kcinimod@brutus dssp3 (master=3D)]$ secilc `find . -name "*.cil"`
> > [kcinimod@brutus dssp3 (master=3D)]$ sesearch policy.32 -T | grep sudo =
| grep tmp
> > type_transition sudo.subj file.log:file pam.faillog.log btmp;
> > type_transition sudo.subj file.tmp:file sudo.tmp;
> > [kcinimod@brutus dssp3 (master=3D)]$ sed -i 's/(call obj_type_transitio=
n_tmp_fixme (subj file))/(call obj_type_transition_tmp (subj file "*"))/' p=
oli
> > cy/app/s/sudo.cil
> > [kcinimod@brutus dssp3 (master *=3D)]$ secilc `find . -name "*.cil"`
> > [kcinimod@brutus dssp3 (master *=3D)]$ sesearch policy.32 -T | grep sud=
o | grep tmp
> > type_transition sudo.subj file.log:file pam.faillog.log btmp;
> > type_transition sudo.subj file.tmp:file sudo.tmp ARG3;
> >
> > Note the "ARG3" in the latter result
> >
>=20
> I found the problem. In dssp3/policy/user/user_runtimeuser.cil there
> is the following macro definition.
>=20
>     (macro obj_type_transition_runtimeuser ((type ARG1)(class ARG2)(name =
ARG2))
>            (call .file.runtimeuser_obj_type_transition
>                  (ARG1 runtimeuser ARG2 ARG3)))
>=20
> Notice that ARG2 is used twice and ARG3 is not actually an argument
> and is taken as a name.
>=20
> There are a couple of bugs here. First, CIL should give an error for
> the duplicate argument names and, second, CIL should be checking if a
> name is actually a macro parameter before it checks whether that name
> is already in the name symbol table.
>=20
> You were seeing what you saw because the macro above is never called
> but it does put ARG3 into the symbol table so that it is not
> recognized as a parameter later.

It should have been called though AFAIK some lines above:

https://defensec.nl/gitweb/dssp3.git/commitdiff/113b367e6bba8c18166eb34b6b6=
7858fc17a0a8d#patch3

Regardless I can confirm that this fixes the issue

>=20
> Jim

--=20
gpg --locate-keys dominick.grift@defensec.nl
Key fingerprint =3D FCD2 3660 5D6B 9D27 7FC6  E0FF DA7E 521F 10F6 4098
Dominick Grift

--yQbNiKLmgenwUfTN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEe2FOk94VrgBPlhBrAlFoDzf+eRMFAl5gANkACgkQAlFoDzf+
eRP7yBAAnNAUG3ISzlGfAGt7d1TBKpKUVQ/vHWIAWLN7KdK27eUbiUl/0zyO5PXq
+F/2t/urvCp+RRxbNDbDdqa7VDzMs8ATK0qRIQ8uLX6ZlQamkXNcvThFtXCHQ2jU
kZNhoE7Ctclt6QfmcTLhPox3Q5gONYBuN8oAYSPpjm/Uy6T8ksJCF6Km6KLDm94Y
jhdseOwhQxVsUwVq2qGqY2d0vXeZB7wiiFOYDYdrcsXMUzYBNYcRr7VDNkLQ4SeX
BsIM8dCBbNMBE5y5US7E0OPTbW4IK1T+FhBcVFWxzoP5K6N32uiJlIUVjp177pde
pW5cbV5VW6rec2kEuhVUzQ30lIUb7IIN/xJTIoA/3P5kQxfBnx5mQhpPhW5fYWBr
r5mWmxS4qN5tmJHKybboXAYsqp1jq95+mZTDVehNtkO19TvrA5KXskYtYRKpz7gT
0QhbLZurtIO0Fo2VxAwUxybI/fhoOuez5QGsDOSGgF1uvwy6rSoYKxNGyqLhLmZz
eC7rnpwqLppn9Opt48qtP7dCFhoUqSEnU4li1jtF4Tw2eNEq50LVLbQ/qACNP/XF
cQ4oIXpwvU/tE69zGTQRQDSAtrPtpGLTdtdqzNb03GBzus+92y9xw10kaHvCyg5R
vDmbgrpcV3JG+cNDsm1d2y4iB1wJPELdgKQYZebZOGoEz68HAcg=
=SbF4
-----END PGP SIGNATURE-----

--yQbNiKLmgenwUfTN--
