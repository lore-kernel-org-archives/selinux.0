Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 119C0C433F5
	for <selinux@archiver.kernel.org>; Wed, 19 Jan 2022 18:11:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345812AbiASSLd (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 19 Jan 2022 13:11:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234280AbiASSLd (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 19 Jan 2022 13:11:33 -0500
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C97D7C061574
        for <selinux@vger.kernel.org>; Wed, 19 Jan 2022 10:11:32 -0800 (PST)
Received: by mail-ot1-x32c.google.com with SMTP id y11-20020a0568302a0b00b0059a54d66106so4286302otu.0
        for <selinux@vger.kernel.org>; Wed, 19 Jan 2022 10:11:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+PF7AMHE03i+1X970bJU+AqTn3nuzaoftVp+GSJ54y4=;
        b=Kgz10OfPEqfXsMlbjtOvTVx8zx3CGqEauhD5v1d3HdrUqzrR0UAIsCIgvVtALuVeON
         wgWis47px9VItaqXJY7mlQTBPk0Si7uC9iXvogSIKg6qIUZJc6Ig17cAbvoWXfh5eOHI
         MtuyKiR8C9kLH5UtXLiSaVR1vxI+WVste2/TGoCPoJWdE4kIwWqclqKNWzsNatYRBa7M
         P888ubs2q8BG0zf7zGcjftmrSEJ9jJCiZkLC6lrRCVwFsK1D8iDi7VIS2069wN3mXUNf
         wr/nPA/DRTWQXFa+t6KmBn0w0qa8tX+Wt1oxnddXbCJBuu2TQCdInJBj7edhkQPa/nrl
         FUZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+PF7AMHE03i+1X970bJU+AqTn3nuzaoftVp+GSJ54y4=;
        b=dGLG5AjcJVmrsGxV6TiDM5x7or2y31FaQTYVqOGeYzkujQ023zxkSYf1Bh3EhrKAoS
         wNiUmxT0qx1yqGmYiSjUBzV26953uztDEhVCFcEWeWFX9icBY0zJ+BEmmlRCaD19gqFE
         5RwUVFzRI2/yelL4lyGqoD78nv6hQ8GqtUtLqiW5Y1F9dv2dwH1EpKdRJ9NFzJKqa7Ke
         YNYvPtajSHxu8wbEPSULrhwgMPTHXwi4YJybHk09qyuV5k6BYBQdO3x/QMx7PGilmGH4
         rKUtTE7tKIICf8ylRrq4twGUJq/7EZDGUdNH/QDVnKEQImYh3BD+aYVijovT5OBCQvpG
         +tsQ==
X-Gm-Message-State: AOAM5335ltJoCmDSknfPTedf54DcU92Nva6JmI2zxPI2hmx2DgEwfHfb
        c+IM4KXzXG39Rp1sE5Fpw9tBpga+SDPIqWNND9QhSwHD
X-Google-Smtp-Source: ABdhPJzslb75oLn6ZaQiOU0CzHtcWmaRBLCd2tGc0jDc4neKBt44QOtDv5PjZ0WlGc12xpGIDTNX42sg/4Y+gVQ1D58=
X-Received: by 2002:a05:6830:224e:: with SMTP id t14mr25290816otd.154.1642615891933;
 Wed, 19 Jan 2022 10:11:31 -0800 (PST)
MIME-Version: 1.0
References: <20211223185004.77862-1-cgzones@googlemail.com>
 <20220106204226.146879-1-cgzones@googlemail.com> <CAP+JOzR1KidV3suFZA6VVhZKd1K_E0kDUazSMqRrBj3+dPGR+Q@mail.gmail.com>
 <CAJ2a_Dd3za43B6ufjjjex4b2Gxp3Yu65Ey5-1Q4JZ7fuRjSaLw@mail.gmail.com>
In-Reply-To: <CAJ2a_Dd3za43B6ufjjjex4b2Gxp3Yu65Ey5-1Q4JZ7fuRjSaLw@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Wed, 19 Jan 2022 13:11:21 -0500
Message-ID: <CAP+JOzTrRRHfnK6th9FpgkVcETQVBVp5uUtDnEH=xfj4u0rzSg@mail.gmail.com>
Subject: Re: [PATCH v2] libsepol: handle type gaps
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Jan 19, 2022 at 10:43 AM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> On Wed, 12 Jan 2022 at 16:55, James Carter <jwcart2@gmail.com> wrote:
> >
> > On Fri, Jan 7, 2022 at 1:57 PM Christian G=C3=B6ttsche
> > <cgzones@googlemail.com> wrote:
> > >
> > > For policy versions between 20 and 23 the type_val_to_struct array mi=
ght
> > > contain gaps. Skip those gaps to avoid NULL pointer dereferences:
> > >
> > >     =3D=3D1250=3D=3DERROR: AddressSanitizer: SEGV on unknown address =
0x000000000008 (pc 0x00000058560b bp 0x7ffdca60c110 sp 0x7ffdca60bfc0 T0)
> > >     =3D=3D1250=3D=3DThe signal is caused by a READ memory access.
> > >     =3D=3D1250=3D=3DHint: address points to the zero page.
> > >         #0 0x58560b in build_type_map selinux/libsepol/src/optimize.c=
:107:33
> > >         #1 0x58560b in policydb_optimize selinux/libsepol/src/optimiz=
e.c:441:13
> > >         #2 0x55e63e in LLVMFuzzerTestOneInput selinux/libsepol/fuzz/b=
inpolicy-fuzzer.c:42:10
> > >         #3 0x455283 in fuzzer::Fuzzer::ExecuteCallback(unsigned char =
const*, unsigned long) cxa_noexception.cpp:0
> > >         #4 0x440ec2 in fuzzer::RunOneTest(fuzzer::Fuzzer*, char const=
*, unsigned long) /src/llvm-project/compiler-rt/lib/fuzzer/FuzzerDriver.cpp=
:324:6
> > >         #5 0x44671c in fuzzer::FuzzerDriver(int*, char***, int (*)(un=
signed char const*, unsigned long)) cxa_noexception.cpp:0
> > >         #6 0x46f522 in main /src/llvm-project/compiler-rt/lib/fuzzer/=
FuzzerMain.cpp:20:10
> > >         #7 0x7f9c160d00b2 in __libc_start_main /build/glibc-eX1tMB/gl=
ibc-2.31/csu/libc-start.c:308:16
> > >         #8 0x41f67d in _start
> > >
> > > Found by oss-fuzz (#42697)
> > >
> > > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> > > ---
> > > @Jim:
> > >     I hope I have interpreted and implemented your feedback correctly=
, but I
> > >     am not sure I have seen through the whole gaps logic yet.
> > > ---
> > >  libsepol/src/kernel_to_cil.c  | 40 +++++++++++++++++++++++++++++++++=
++
> > >  libsepol/src/kernel_to_conf.c | 32 ++++++++++++++++++++++++++++
> > >  libsepol/src/optimize.c       | 18 +++++++++++++++-
> > >  3 files changed, 89 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/libsepol/src/kernel_to_cil.c b/libsepol/src/kernel_to_ci=
l.c
> > > index 18294a9a..1353e77f 100644
> > > --- a/libsepol/src/kernel_to_cil.c
> > > +++ b/libsepol/src/kernel_to_cil.c
> > > @@ -1227,6 +1227,14 @@ static int write_type_attributes_to_cil(FILE *=
out, struct policydb *pdb)
> > >
> > >         for (i=3D0; i < pdb->p_types.nprim; i++) {
> > >                 type =3D pdb->type_val_to_struct[i];
> > > +               /* Gap in types for policy versions between 20 and 23=
 */
> > > +               if (!type) {
> > > +                       if (pdb->policyvers <=3D POLICYDB_VERSION_PER=
MISSIVE) {
> > > +                               rc =3D -1;
> > > +                               goto exit;
> > > +                       }
> > > +                       continue;
> > > +               }
> >
> > There is already a check in sepol_kernel_policydb_to_cil() and an
> > error is returned if the policy version is between 20 and 23.
> > While no policy that is written by libsepol will have gaps in this
> > array, the validate_policydb() only checks that gaps are not referred
> > to by any rules, so there does need to be a check for a NULL here.
> >
> > I would make the line below to be "if (type && type->flavor ..."
> >
> > >                 if (type->flavor =3D=3D TYPE_ATTRIB) {
> > >                         rc =3D strs_add(strs, pdb->p_type_val_to_name=
[i]);
> > >                         if (rc !=3D 0) {
> > > @@ -1357,6 +1365,14 @@ static int write_type_decl_rules_to_cil(FILE *=
out, struct policydb *pdb)
> > >
> > >         for (i=3D0; i < pdb->p_types.nprim; i++) {
> > >                 type =3D pdb->type_val_to_struct[i];
> > > +               /* Gap in types for policy versions between 20 and 23=
 */
> > > +               if (!type) {
> > > +                       if (pdb->policyvers <=3D POLICYDB_VERSION_PER=
MISSIVE) {
> > > +                               rc =3D -1;
> > > +                               goto exit;
> > > +                       }
> > > +                       continue;
> > > +               }
> >
> > Same here.
> >
> > >                 if (type->flavor =3D=3D TYPE_TYPE && type->primary) {
> > >                         rc =3D strs_add(strs, pdb->p_type_val_to_name=
[i]);
> > >                         if (rc !=3D 0) {
> > > @@ -1486,6 +1502,14 @@ static int write_type_bounds_rules_to_cil(FILE=
 *out, struct policydb *pdb)
> > >
> > >         for (i=3D0; i < pdb->p_types.nprim; i++) {
> > >                 type =3D pdb->type_val_to_struct[i];
> > > +               /* Gap in types for policy versions between 20 and 23=
 */
> > > +               if (!type) {
> > > +                       if (pdb->policyvers <=3D POLICYDB_VERSION_PER=
MISSIVE) {
> > > +                               rc =3D -1;
> > > +                               goto exit;
> > > +                       }
> > > +                       continue;
> > > +               }
> >
> > And here.
> >
> > >                 if (type->flavor =3D=3D TYPE_TYPE) {
> > >                         if (type->bounds > 0) {
> > >                                 rc =3D strs_add(strs, pdb->p_type_val=
_to_name[i]);
> > > @@ -1540,6 +1564,14 @@ static int write_type_attribute_sets_to_cil(FI=
LE *out, struct policydb *pdb)
> > >
> > >         for (i=3D0; i < pdb->p_types.nprim; i++) {
> > >                 attr =3D pdb->type_val_to_struct[i];
> > > +               /* Gap in types for policy versions between 20 and 23=
 */
> > > +               if (!attr) {
> > > +                       if (pdb->policyvers <=3D POLICYDB_VERSION_PER=
MISSIVE) {
> > > +                               rc =3D -1;
> > > +                               goto exit;
> > > +                       }
> > > +                       continue;
> > > +               }
> >
> > And here.
> >
> > >                 if (attr->flavor !=3D TYPE_ATTRIB) continue;
> > >                 name =3D pdb->p_type_val_to_name[i];
> > >                 typemap =3D &pdb->attr_type_map[i];
> > > @@ -2273,6 +2305,14 @@ static int write_role_decl_rules_to_cil(FILE *=
out, struct policydb *pdb)
> > >
> > >         for (i=3D0; i < pdb->p_types.nprim; i++) {
> > >                 type_datum =3D pdb->type_val_to_struct[i];
> > > +               /* Gap in types for policy versions between 20 and 23=
 */
> > > +               if (!type_datum) {
> > > +                       if (pdb->policyvers <=3D POLICYDB_VERSION_PER=
MISSIVE) {
> > > +                               rc =3D -1;
> > > +                               goto exit;
> > > +                       }
> > > +                       continue;
> > > +               }
> >
> > And here.
> >
> > >                 if (type_datum->flavor =3D=3D TYPE_TYPE && type_datum=
->primary) {
> > >                         rc =3D strs_add(strs, pdb->p_type_val_to_name=
[i]);
> > >                         if (rc !=3D 0) {
> > > diff --git a/libsepol/src/kernel_to_conf.c b/libsepol/src/kernel_to_c=
onf.c
> > > index a92ba9fd..235b4556 100644
> > > --- a/libsepol/src/kernel_to_conf.c
> > > +++ b/libsepol/src/kernel_to_conf.c
> > > @@ -1210,6 +1210,14 @@ static int write_type_attributes_to_conf(FILE =
*out, struct policydb *pdb)
> > >
> > >         for (i=3D0; i < pdb->p_types.nprim; i++) {
> > >                 type =3D pdb->type_val_to_struct[i];
> > > +               /* Gap in types for policy versions between 20 and 23=
 */
> > > +               if (!type) {
> > > +                       if (pdb->policyvers <=3D POLICYDB_VERSION_PER=
MISSIVE) {
> > > +                               rc =3D -1;
> > > +                               goto exit;
> > > +                       }
> > > +                       continue;
> > > +               }
> >
> > Same thing here. sepol_kernel_policydb_to_conf() already does a check
> > and returns an error if the policy version is between 20 and 23. All
> > the same comments above apply here.
> >
> > >                 if (type->flavor =3D=3D TYPE_ATTRIB) {
> > >                         rc =3D strs_add(strs, pdb->p_type_val_to_name=
[i]);
> > >                         if (rc !=3D 0) {
> > > @@ -1340,6 +1348,14 @@ static int write_type_decl_rules_to_conf(FILE =
*out, struct policydb *pdb)
> > >
> > >         for (i=3D0; i < pdb->p_types.nprim; i++) {
> > >                 type =3D pdb->type_val_to_struct[i];
> > > +               /* Gap in types for policy versions between 20 and 23=
 */
> > > +               if (!type) {
> > > +                       if (pdb->policyvers <=3D POLICYDB_VERSION_PER=
MISSIVE) {
> > > +                               rc =3D -1;
> > > +                               goto exit;
> > > +                       }
> > > +                       continue;
> > > +               }
> > >                 if (type->flavor =3D=3D TYPE_TYPE && type->primary) {
> > >                         rc =3D strs_add(strs, pdb->p_type_val_to_name=
[i]);
> > >                         if (rc !=3D 0) {
> > > @@ -1460,6 +1476,14 @@ static int write_type_bounds_rules_to_conf(FIL=
E *out, struct policydb *pdb)
> > >
> > >         for (i=3D0; i < pdb->p_types.nprim; i++) {
> > >                 type =3D pdb->type_val_to_struct[i];
> > > +               /* Gap in types for policy versions between 20 and 23=
 */
> > > +               if (!type) {
> > > +                       if (pdb->policyvers <=3D POLICYDB_VERSION_PER=
MISSIVE) {
> > > +                               rc =3D -1;
> > > +                               goto exit;
> > > +                       }
> > > +                       continue;
> > > +               }
> > >                 if (type->flavor =3D=3D TYPE_TYPE) {
> > >                         if (type->bounds > 0) {
> > >                                 rc =3D strs_add(strs, pdb->p_type_val=
_to_name[i]);
> > > @@ -1583,6 +1607,14 @@ static int write_type_attribute_sets_to_conf(F=
ILE *out, struct policydb *pdb)
> > >
> > >         for (i=3D0; i < pdb->p_types.nprim; i++) {
> > >                 type =3D pdb->type_val_to_struct[i];
> > > +               /* Gap in types for policy versions between 20 and 23=
 */
> > > +               if (!type) {
> > > +                       if (pdb->policyvers <=3D POLICYDB_VERSION_PER=
MISSIVE) {
> > > +                               rc =3D -1;
> > > +                               goto exit;
> > > +                       }
> > > +                       continue;
> > > +               }
> > >                 if (type->flavor !=3D TYPE_TYPE || !type->primary) co=
ntinue;
> > >                 if (ebitmap_cardinality(&pdb->type_attr_map[i]) =3D=
=3D 1) continue;
> > >
> > > diff --git a/libsepol/src/optimize.c b/libsepol/src/optimize.c
> > > index 8a048702..f8c28313 100644
> > > --- a/libsepol/src/optimize.c
> > > +++ b/libsepol/src/optimize.c
> > > @@ -104,6 +104,13 @@ static struct type_vec *build_type_map(const pol=
icydb_t *p)
> > >                 if (type_vec_init(&map[i]))
> > >                         goto err;
> > >
> > > +               /* Gap in types for policy versions between 20 and 23=
 */
> > > +               if (!p->type_val_to_struct[i]) {
> > > +                       if (p->policyvers <=3D POLICYDB_VERSION_PERMI=
SSIVE)
> > > +                               goto err;
> > > +                       continue;
> > > +               }
> > > +
> >
> > I want the same sort of check for the policy version done in
> > policydb_optimize(), not throughout the code.
>
> Something like
>
>     diff --git a/libsepol/src/optimize.c b/libsepol/src/optimize.c
>     index 8a048702..059c61f2 100644
>     --- a/libsepol/src/optimize.c
>     +++ b/libsepol/src/optimize.c
>     @@ -438,6 +443,15 @@ int policydb_optimize(policydb_t *p)
>            if (p->policy_type !=3D POLICY_KERN)
>                    return -1;
>
>     +       if (p->policyvers >=3D POLICYDB_VERSION_AVTAB &&
> p->policyvers <=3D POLICYDB_VERSION_PERMISSIVE)
>     +               /*
>     +                * For policy versions between 20 and 23,
> attributes exist in the policy,
>     +                * but only in the type_attr_map. This means that
> there are gaps in both
>     +                * the type_val_to_struct and p_type_val_to_name
> arrays and policy rules
>     +                * can refer to those gaps.
>     +                */
>     +               return FIXME;
>     +
>            type_map =3D build_type_map(p);
>            if (!type_map)
>                    return -1;
>

Yes.

> ?
> Should it return 0 and silently not optimize or fail with -1?
> In case of a failure should there be a message, e.g.
>
>     ERR(NULL, "Optimizing policy versions between 20 and 23 is not suppor=
ted");
>
> ?
>

Fail with -1 and the error message you have there.

Thanks,
Jim


> > Can still check for NULL.
> >
> > >                 if (p->type_val_to_struct[i]->flavor !=3D TYPE_ATTRIB=
) {
> > >                         ebitmap_for_each_positive_bit(&p->type_attr_m=
ap[i],
> > >                                                       n, k) {
> > > @@ -114,11 +121,20 @@ static struct type_vec *build_type_map(const po=
licydb_t *p)
> > >                         ebitmap_t *types_i =3D &p->attr_type_map[i];
> > >
> > >                         for (k =3D 0; k < p->p_types.nprim; k++) {
> > > -                               ebitmap_t *types_k =3D &p->attr_type_=
map[k];
> > > +                               ebitmap_t *types_k;
> > > +
> > > +                               /* Gap in types for policy versions b=
etween 20 and 23 */
> > > +                               if (!p->type_val_to_struct[k]) {
> > > +                                       if (p->policyvers <=3D POLICY=
DB_VERSION_PERMISSIVE)
> > > +                                               goto err;
> > > +                                       continue;
> > > +                               }
> >
> > Same here.
> >
> > Thanks,
> > Jim
> >
> > >
> > >                                 if (p->type_val_to_struct[k]->flavor =
!=3D TYPE_ATTRIB)
> > >                                         continue;
> > >
> > > +                               types_k =3D &p->attr_type_map[k];
> > > +
> > >                                 if (ebitmap_contains(types_k, types_i=
)) {
> > >                                         if (type_vec_append(&map[i], =
k))
> > >                                                 goto err;
> > > --
> > > 2.34.1
> > >
