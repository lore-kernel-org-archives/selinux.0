Return-Path: <SRS0=d3z6=4V=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A69D2C3F2CE
	for <selinux@archiver.kernel.org>; Wed,  4 Mar 2020 19:09:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 858482146E
	for <selinux@archiver.kernel.org>; Wed,  4 Mar 2020 19:09:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727543AbgCDTJM (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 4 Mar 2020 14:09:12 -0500
Received: from agnus.defensec.nl ([80.100.19.56]:47058 "EHLO agnus.defensec.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726440AbgCDTJM (ORCPT <rfc822;selinux@vger.kernel.org>);
        Wed, 4 Mar 2020 14:09:12 -0500
Received: from brutus.lan (brutus.lan [IPv6:2001:985:d55d::438])
        by agnus.defensec.nl (Postfix) with ESMTPSA id 95D87132004B;
        Wed,  4 Mar 2020 20:09:09 +0100 (CET)
Date:   Wed, 4 Mar 2020 20:09:07 +0100
From:   Dominick Grift <dominick.grift@defensec.nl>
To:     James Carter <jwcart2@gmail.com>
Cc:     Dominick Grift <dac.override@gmail.com>, selinux@vger.kernel.org
Subject: Re: Fwd: strange issue with name-base type trans
Message-ID: <20200304190907.GF1032355@brutus.lan>
Mail-Followup-To: James Carter <jwcart2@gmail.com>,
        Dominick Grift <dac.override@gmail.com>, selinux@vger.kernel.org
References: <CAB9W1A3-z1YokQUHusrgeuaX2SGyRuh+4X7b_GMEgEo5xe6k_Q@mail.gmail.com>
 <65b5e705-3d42-57c9-6502-973486b3c3c8@tycho.nsa.gov>
 <CAP+JOzSZoUwi8Lfioiu7PRgmexU=0h73p-rkpRConE_jEXboSA@mail.gmail.com>
 <87v9nrbyge.fsf@gmail.com>
 <CAP+JOzTwO6zNA1o=ztKkO627TT8f9tp7dG=amde8Thx5wu+6JQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="yH1ZJFh+qWm+VodA"
Content-Disposition: inline
In-Reply-To: <CAP+JOzTwO6zNA1o=ztKkO627TT8f9tp7dG=amde8Thx5wu+6JQ@mail.gmail.com>
User-Agent: Every email client sucks, this one just sucks less.
X-PGP-Key: https://sks-keyservers.net/pks/lookup?op=get&search=0xDA7E521F10F64098
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org


--yH1ZJFh+qWm+VodA
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

Thanks! I feel a little bad that it is a bug in my policy that brings this =
to light (and that I couldnt find the bug in the policy myself)
Hopefully this event will help improve things.

Thanks again

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
>=20
> Jim

--=20
gpg --locate-keys dominick.grift@defensec.nl
Key fingerprint =3D FCD2 3660 5D6B 9D27 7FC6  E0FF DA7E 521F 10F6 4098
Dominick Grift

--yH1ZJFh+qWm+VodA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEe2FOk94VrgBPlhBrAlFoDzf+eRMFAl5f/M0ACgkQAlFoDzf+
eRN5qA//UT6EhkcH/XUNL01eDeklbBDIN/fjDcuTBeS0JVR8qF5RV+ytTKokYUGb
W2xY+vLk7iYiGNfzXxjSZn1iTNj56ZYXY0ZtDP+h87r6dOt6O7A/idbHPFjnz+7g
SRGoo87b2y8h9Jc8a6PZu2cPUmcxE7bltamHyRIhIkagnDnWj5TYQwgrua0cGzLS
NjCaNWFamo7wywnnKdRgZJnXFOUqR8VTfuPrz/Kz6sRl9XguPCjz5rWe0ahI9E53
bVdU5/1FC0KkXqVIoJWCOxyzH4Lxzsu+z7zPzJpgHX7mCcppZQcRN7Y+P14YJ6+j
4xeaEluzXPlICpqNxgjdc8xZ1zY95aM1uHyuaQjvSYAaKcg9lQOjRwzuHEOyfU0C
s4/Gfq3WnkWE+tUfvr0FlPYSYnZDRBQROUQtc30S6EjUX90N5dfkb67gN3O7SzuM
+WTcrwVLCN1WY+aUk5pd4dZTe79v6AyvJBVjtxzOohnG6t1GsI2SyfaHV/1OYlEl
74U5jGj2AsU73+Jd5FZ8cslPa+lxzOKO7uPdoDSnOlg8Vvh4yFrRDrlTE5F4Co2D
P0pD7my5L0wMzC6SGNsNBbeEg9VTLoBFiYrHT3fGJNYCWKQawD2X616Kovt6fovX
H6ATZ/SbUG0XMku+Y4D5qFqeKCIKDQHhK34YEf/AFzr91a4I2dM=
=ekU0
-----END PGP SIGNATURE-----

--yH1ZJFh+qWm+VodA--
