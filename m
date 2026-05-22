Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 207923A641C
	for <selinux@vger.kernel.org>; Fri, 22 May 2026 13:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779456226; cv=pass; b=Yxa56yPqxlL7X2/C0rHsVvvz2vLFmav4RxsYXwA2dKRL9ky7Lcswf8KO3giuw2TYaKpCI/Yp467aDXlhJJ143bfm7X8hJfwby7a9C0V90Pt/lfx4+JTs+8qtZKnX3tloqqgar+Tss3kc93cWQY16SGK5hyUifTBv1WZkXo2iYao=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779456226; c=relaxed/simple;
	bh=ony/GMRSy+GT95Aa4j6hEJjcW2GoJzQvEUn2qR2j8Kg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OLEFK/hQ7RJDkC4rKMyoTsVQI20rkFAlETItiWOeBO5MiXaV3t/oFX0V5lymMp329jv/XfvOZAfUkuAZoLVSOKdpNH6me01XAzCqd1IDk0k4HNFCLjQK2ve/nwzk+YkwcW/ZAWYg4k1JzJRd4Qo1ebTHKFCFUBv0styQEq0x6U0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mmxXOG5H; arc=pass smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mmxXOG5H"
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-393d6025f99so76107541fa.0
        for <selinux@vger.kernel.org>; Fri, 22 May 2026 06:23:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779456222; cv=none;
        d=google.com; s=arc-20240605;
        b=UfhVCkK69zbVhfJcvZN3zi5RhvKsknXfw9Ps5mpiao2GskcPobGAMzYQ5xw+ylxJXZ
         0saA89tYSxuGOaYLaectITEBje4fBGJGyOwg/JXpGhykaBS/eVHOuhlBAAXeXeg3JKja
         28mfxpiNfuC7u9oGNhfT/NDzhXZuRvG8P6ann+9LBBYcSFe7f87E2KT76MZ5zNw42yY0
         iCQ3/yc8OQ6bVKahPM1iraMuSTvg4+TN1N2Y/dbYlKg1TkkE/nelym8nSCmNPO5hIf0t
         HUHVZpxvb4w9zW1roBbGW3ZNBiSehrda5Hbh39m4onVqPG1C1XlxoQ9LdsS0s0gpHSNT
         Pv8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=l1Qn3jfTt2Pc/5ZHVOU6+5D6k2t8lrTBWEG/5Mx2jB8=;
        fh=8+t9IPeQTqyGiWySCZ7zSKsVGC0IZExJx19zfd5jlQs=;
        b=M4p06XwV2u5OPz0Vtm74ABhw93AzpMRfd57YrAHowU82yS8qUa2WXURq4S1x2pF1kr
         6wbdigSFVzbfPSk2r/DJa344STujI8/6oUpxRdcW9rn6iRhfCTY4dYCKli0kO4qVbTD/
         YYijFXyungloDnhl06sP84gKej5IkwhxYw3EsffwT8Dw9JbrlHAN3reGQkNU07Qfuoj1
         8iTfJIgjgtz59OXRmVYEd1TQ3otL2qKZvQ2GByhFtqUC1CZRZtAZm8Stxu7JhprLYG0Y
         legPPgd2y0Rvn0QK53AveQhHgh6ahtpIi+upwl9jC8IeFxsmjScUKLGt4lFgmTz6+QZb
         u/9A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779456222; x=1780061022; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l1Qn3jfTt2Pc/5ZHVOU6+5D6k2t8lrTBWEG/5Mx2jB8=;
        b=mmxXOG5H5fFAnkGMNl6aOI8Kcu8vfsrbr08RhAxmwBYeliKyHeXx0w+9MKwqJG4ujK
         ebNA9NFVi98KkE4HHGROG3tpaDtK7mZJwQKaqJc2ep0nDZ/vfUkT1wh22HvRAZhmNhIw
         kkPU85Hrdt6hwFkJpdz1h6Dh1ytyucuNW5VgudjW7tuizsn1qgrlTvurdcgHAI1n7p4E
         rsSMy8eFqpBcNqrZnGBdYXvNGbm3PieO+yRCN0VmPJXULHsKS51LmJZTCVlcY2IBuI32
         6HZ64ZbOC+dg+cusW0Z7Ej4P6bY5e8FZ+gZpyISsT9EEk1oXNsQHTgmmKkE91eHzuWos
         YWIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779456222; x=1780061022;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=l1Qn3jfTt2Pc/5ZHVOU6+5D6k2t8lrTBWEG/5Mx2jB8=;
        b=jQ2lRlNNL+cTfmB0xD5AelA6ws3H9dZzFDAL/DK5Xmf1Et9O6qlklIe19KrCUnhYSe
         quY9hklZd35wLmZkr0mR8n6ijEqtQsS/QuAP2DAfsVA56ra3Gyy0cKtlrkH28ukcnF98
         CVlV6sYQJDvABRvWpBbuAu1yZqGD8kE2VXLu5eQmf4WrqqMmdta6ZMlfLzXyXtJeD9xO
         GB6La4qkhSXX9tl7krKxL9NdHu3s/ktLprlGv3CAHlwzoEWaINef6/+BPVlJCzYPx/NR
         /Be/PzR3NuPDb/pYPXVptTPXPJMtI4pK1h+1JM+1iFR5hNjuKKMoq8QRute59PLpz9c2
         6vhg==
X-Gm-Message-State: AOJu0YwJFz0KGgmU6k2JUW7H10+B6FxzLKzghW0De7bcnX0l7dm0LHHd
	o4YDHXpw6+OLmSnIcx9z7X7rCM90v7F8fO/8fAFUn2nS/BV6QHLx8pdxi1a9ok32Wv+3KPPBKxb
	+mFRVR3UH7jTWfKfDIAlLt5+I8+F8gPA5fg==
X-Gm-Gg: Acq92OHKfwohgMWwT8aF+oF19R+9Q5tENyfoh8mv3DqvX4Y6VG9E7xvsFRAu3OwgU0v
	CbhvbkJz8iTUlZgT+ZfUfpEA43PP04jFT4t2B8beMQ72Eir8bDyG8B4d5eP2Klrh3hTOIhRTjm+
	xw9NuOtERvO1oomBC4xPdPmc90Z+in90WvB9pV8c4SZiMzsdRy5Gsn0Mps0SsyyZR1+MS8Oe2t4
	1gfMkls/PZe3SOewN9d3Yrc/5NOwdGZCw0WfqJmPNgsyDgHEARhuxAxL0W1dvvKFnrtbHyZ5lH1
	dGa+
X-Received: by 2002:a2e:8506:0:b0:393:cbfb:6f1c with SMTP id
 38308e7fff4ca-395d8ec419cmr8654641fa.14.1779456221905; Fri, 22 May 2026
 06:23:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260427195546.91395-1-jwcart2@gmail.com> <CA+zpnLeGVzFqeWijirYhROz-yVXk0yJ7Q+90Hd7aUuTHi4pqUg@mail.gmail.com>
In-Reply-To: <CA+zpnLeGVzFqeWijirYhROz-yVXk0yJ7Q+90Hd7aUuTHi4pqUg@mail.gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Fri, 22 May 2026 09:23:30 -0400
X-Gm-Features: AVHnY4IT6OSlYDhlODg-roslY2IYs4A1UBAjoj2AhAe6cMP9ZOeC2Cq4-VeAfro
Message-ID: <CAP+JOzTbQK9AOZE8mWph6YQ9qtRoEQCobOs31qmaSrP7CD21=Q@mail.gmail.com>
Subject: Re: [RFC PATCH 1/3] libsepol/cil: Add function to check CIL
 neverallows against binary policy
To: =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 21, 2026 at 7:48=E2=80=AFPM Thi=C3=A9baud Weksteen <tweek@googl=
e.com> wrote:
>
> Thanks for taking the time to write this RFC. Again, the approach
> looks good to me.
>
> On Tue, Apr 28, 2026 at 5:55=E2=80=AFAM James Carter <jwcart2@gmail.com> =
wrote:
> >
> > Add the function cil_check_neverallows_against_pdb() that will extract
> > the neverallows from a CIL db and check them against a kernel policydb.
>
> It might be worth adding a bit more background here? Feel free to pull
> in some of the commit message from my RFC.
>

It could use more background and I will make use of your commit message.

> >
> > Signed-off-by: James Carter <jwcart2@gmail.com>
> > ---
> >  libsepol/cil/include/cil/cil.h |  1 +
> >  libsepol/cil/src/cil_binary.c  | 46 ++++++++++++++++++++++++++++++++++
> >  libsepol/cil/src/cil_binary.h  | 12 +++++++++
> >  libsepol/src/libsepol.map.in   |  5 ++++
> >  4 files changed, 64 insertions(+)
> >
> > diff --git a/libsepol/cil/include/cil/cil.h b/libsepol/cil/include/cil/=
cil.h
> > index 88e47e79..fc9cc504 100644
> > --- a/libsepol/cil/include/cil/cil.h
> > +++ b/libsepol/cil/include/cil/cil.h
> > @@ -65,6 +65,7 @@ extern int cil_write_parse_ast(FILE *out, cil_db_t *d=
b);
> >  extern int cil_write_build_ast(FILE *out, cil_db_t *db);
> >  extern int cil_write_resolve_ast(FILE *out, cil_db_t *db);
> >  extern int cil_write_post_ast(FILE *out, cil_db_t *db);
> > +extern int cil_check_neverallows_against_pdb(const struct cil_db *db, =
policydb_t *pdb, int *violation);
> >
> >  enum cil_log_level {
> >         CIL_ERR =3D 1,
> > diff --git a/libsepol/cil/src/cil_binary.c b/libsepol/cil/src/cil_binar=
y.c
> > index 74ec3cd5..21cb07ad 100644
> > --- a/libsepol/cil/src/cil_binary.c
> > +++ b/libsepol/cil/src/cil_binary.c
> > @@ -5143,6 +5143,52 @@ exit:
> >         return rc;
> >  }
> >
> > +static int __cil_collect_neverallows_helper(struct cil_tree_node *node=
, uint32_t *finished, void *extra_args)
> > +{
> > +       if (node->flavor =3D=3D CIL_BLOCK) {
> > +               struct cil_block *blk =3D node->data;
> > +               if (blk->is_abstract =3D=3D CIL_TRUE) {
> > +                       *finished =3D CIL_TREE_SKIP_HEAD;
> > +               }
> > +       } else if (node->flavor =3D=3D CIL_MACRO) {
> > +               *finished =3D CIL_TREE_SKIP_HEAD;
> > +       } else if (node->flavor =3D=3D CIL_BOOLEANIF) {
> > +               *finished =3D CIL_TREE_SKIP_HEAD;
> > +       } else if (node->flavor =3D=3D CIL_AVRULE || node->flavor =3D=
=3D CIL_AVRULEX) {
> > +               struct cil_avrule *rule =3D node->data;
> > +               if (rule->rule_kind =3D=3D CIL_AVRULE_NEVERALLOW) {
> > +                       struct cil_list *neverallows =3D extra_args;
> > +                       cil_list_prepend(neverallows, CIL_LIST_ITEM, no=
de);
> > +               }
> > +       }
> > +
> > +       return SEPOL_OK;
> > +}
> > +
> > +int cil_check_neverallows_against_pdb(const struct cil_db *db, policyd=
b_t *pdb, int *violation)
> > +{
> > +       int rc =3D SEPOL_OK;
> > +       struct cil_list *neverallows;
> > +
> > +       if (db =3D=3D NULL || pdb =3D=3D NULL) {
> > +               cil_log(CIL_ERR,"CIL db and/or Policy db is NULL\n");
> > +               return SEPOL_ERR;
> > +       }
> > +
> > +       cil_list_init(&neverallows, CIL_LIST_ITEM);
> > +       rc =3D cil_tree_walk(db->ast->root, __cil_collect_neverallows_h=
elper, NULL, NULL, neverallows);
> > +       if (rc !=3D SEPOL_OK) {
> > +               cil_log(CIL_INFO, "Failure collecting neverallows\n");
> > +               goto exit;
> > +       }
> > +
> > +       rc =3D cil_check_neverallows(db, pdb, neverallows, violation);
>
> I think violation might not be set if nothing is found. For the other
> existing caller (cil_binary_create_allocated_pdb), violation is
> manually set to false before calling cil_check_neverallows. We should
> do the same here?
>

I believe that you are correct.

> > +
> > +exit:
> > +       cil_list_destroy(&neverallows, CIL_FALSE);
> > +       return rc;
> > +}
> > +
> >  static struct cil_list *cil_classperms_from_sepol(policydb_t *pdb, uin=
t16_t class, uint32_t data, struct cil_class *class_value_to_cil[], struct =
cil_perm **perm_value_to_cil[])
> >  {
> >         struct cil_classperms *cp;
> > diff --git a/libsepol/cil/src/cil_binary.h b/libsepol/cil/src/cil_binar=
y.h
> > index e6826221..e8fff9b4 100644
> > --- a/libsepol/cil/src/cil_binary.h
> > +++ b/libsepol/cil/src/cil_binary.h
> > @@ -36,6 +36,18 @@
> >  #include "cil_tree.h"
> >  #include "cil_list.h"
> >
> > +
> > +/**
> > + * Check neverallows from a cil database against a policy database
>
> Same here, maybe we can add some context on why this function exists?
> Do we have a strict requirement that all definitions from pdb are in
> db?
>

I could definitely add more context here.

The key is that CIL uses libsepol to check neverallows, so it just
converts the CIL neverallow to the policydb neverallow. The CIL db
just has to have the declarations needed for the CIL neverallow. I
should check to make sure appropriate errors are reported if the
policydb does not have a type, class, or permission from the CIL
neverallow.

Thanks for the review!
Jim

> > + *
> > + * @param[in] db The cil database.
> > + * @param[in] pdb The policy database.
> > + * @param[out] violation 1 if a neverallow violation was found, 0 othe=
rwise
> > + *
> > + * @return SEPOL_OK upon success or an error otherwise.
> > + */
> > +int cil_check_neverallows_against_pdb(const struct cil_db *db, policyd=
b_t *pdb, int *violation);
> > +
> >  /**
> >   * Create a binary policydb from the cil db.
> >   *
> > diff --git a/libsepol/src/libsepol.map.in b/libsepol/src/libsepol.map.i=
n
> > index e5e6608c..2b103993 100644
> > --- a/libsepol/src/libsepol.map.in
> > +++ b/libsepol/src/libsepol.map.in
> > @@ -294,3 +294,8 @@ LIBSEPOL_3.6 {
> >    global:
> >         cil_write_post_ast;
> >  } LIBSEPOL_3.4;
> > +
> > +LIBSEPOL_3.11 {
> > +  global:
> > +       cil_check_neverallows_against_pdb;
> > +} LIBSEPOL_3.6;
> > --
> > 2.53.0
> >
