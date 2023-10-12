Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 027FDCDB46E
	for <selinux@archiver.kernel.org>; Thu, 12 Oct 2023 17:53:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441905AbjJLRx7 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 12 Oct 2023 13:53:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442006AbjJLRx5 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 12 Oct 2023 13:53:57 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F592BB
        for <selinux@vger.kernel.org>; Thu, 12 Oct 2023 10:53:55 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-50305abe5f0so1739540e87.2
        for <selinux@vger.kernel.org>; Thu, 12 Oct 2023 10:53:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697133233; x=1697738033; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9cLcFDQrk0vGi73rtt0e5bABl3iDa4K/CvBoXvqfdLw=;
        b=DzJqeFyp+k3b5x/mLTeQ/uZXRKhFZgX3whChPTc+aNGX4JgBE6KiTul2PGWaiLZS96
         pMHus8zWD+ikA9+dtMnnGUXFG6xKdVsi4Gm1YC+QbeUr/JZlUCUwPGs+lepO4wlp8Dj2
         Wu4NaLwPYXEBXfVnHbJX26MSxdE0neiMsD0ENYPPERXuAlNcjfeI+U9x/7Fw6rIpx0K2
         C2l6v+fBEH5iCk8/6TqXhg2PwCVwbf7PC4AJznfT/koNEoVYj+eEkaykqpbTsZWyJInI
         gaHXqvRhGeVPDFIctE//StL2hkgLXCo4jRHQWK6HlR1BvzDhCC2DQ07zHFThmOtYA2jX
         Op6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697133233; x=1697738033;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9cLcFDQrk0vGi73rtt0e5bABl3iDa4K/CvBoXvqfdLw=;
        b=XIEyXbdcudg5Ah+46AnZk5pKCNQrdEn7atnTxOQZhnxsa7oq5U4Dry9qQl1yBfkR74
         nzQN5RbOFkSHoiMphc66Qsx3Y5VFngExtKoLy1c5p62OJ3CeO6PWMvB9YcT1AJ7VKeQ7
         Po72h0z5FRBoNPT4X4bGTflyjKpFHqw8kQZhJgdkQKCN4nBSpsTQxxc0sUKoUGZKoYcQ
         mL4oklL/Qb8eMxp31tsZ6PvhzU+wUytPhLmrQCn6BbOTe/RCwPgcsTOr2sTDei4arQfb
         tzwXMVXHa/qPdCi1BUrORPCyc9ftAoG9IjQ6B+mDHGLMHBGpa99F4B0bOQ4avOxO9teA
         6LkA==
X-Gm-Message-State: AOJu0YyiXI7yxUdNYw9XqPTWCwp9QwZsftOxT0YMLvWFtOwk2BjFa3T+
        CKKfcjmr+gF1zldHDA8yabnb4CVl/aULV7+AkOBvGfvHQkQ=
X-Google-Smtp-Source: AGHT+IEFuXuPsY6iKwmFaeDeMbadHff3O6ALW0Tt4WjSEHLFy2qTQr+jCT4Am4t6n4ol5YrS24ZZKHwv64coqUI9qmk=
X-Received: by 2002:a05:6512:3488:b0:4fd:fd97:a77b with SMTP id
 v8-20020a056512348800b004fdfd97a77bmr17755324lfr.50.1697133233236; Thu, 12
 Oct 2023 10:53:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230814132025.45364-1-cgzones@googlemail.com>
 <20230814132025.45364-8-cgzones@googlemail.com> <CAP+JOzSrYQuSVKxu6dFGBOA2ZCESgbwos0_wPxjORZ7ZAqT1Gw@mail.gmail.com>
In-Reply-To: <CAP+JOzSrYQuSVKxu6dFGBOA2ZCESgbwos0_wPxjORZ7ZAqT1Gw@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Thu, 12 Oct 2023 13:53:42 -0400
Message-ID: <CAP+JOzSmY5wFFV9vAPZueVuYN4orDHBe1d1pon3ag-=9vokGug@mail.gmail.com>
Subject: Re: [RFC PATCH v2 07/27] libselinux: constify selabel_cmp(3) parameters
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Oct 2, 2023 at 2:11=E2=80=AFPM James Carter <jwcart2@gmail.com> wro=
te:
>
> On Mon, Aug 14, 2023 at 9:42=E2=80=AFAM Christian G=C3=B6ttsche
> <cgzones@googlemail.com> wrote:
> >
> > Comparing two selabel handles should (and currently does) not modify
> > them.
> >
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Acked-by: James Carter <jwcart2@gmail.com>
>
Merged.
Thanks,
Jim

> > ---
> >  libselinux/include/selinux/label.h |  4 ++--
> >  libselinux/src/label.c             |  4 ++--
> >  libselinux/src/label_file.c        | 22 +++++++++++-----------
> >  libselinux/src/label_internal.h    |  4 ++--
> >  4 files changed, 17 insertions(+), 17 deletions(-)
> >
> > diff --git a/libselinux/include/selinux/label.h b/libselinux/include/se=
linux/label.h
> > index e8983606..ce189a3a 100644
> > --- a/libselinux/include/selinux/label.h
> > +++ b/libselinux/include/selinux/label.h
> > @@ -153,8 +153,8 @@ enum selabel_cmp_result {
> >   * if @h1 is identical to @h2, %SELABEL_SUPERSET if @h1 is a superset
> >   * of @h2, and %SELABEL_INCOMPARABLE if @h1 and @h2 are incomparable.
> >   */
> > -extern enum selabel_cmp_result selabel_cmp(struct selabel_handle *h1,
> > -                                          struct selabel_handle *h2);
> > +extern enum selabel_cmp_result selabel_cmp(const struct selabel_handle=
 *h1,
> > +                                          const struct selabel_handle =
*h2);
> >
> >  /**
> >   * selabel_stats - log labeling operation statistics.
> > diff --git a/libselinux/src/label.c b/libselinux/src/label.c
> > index a2efa99c..c0f586a2 100644
> > --- a/libselinux/src/label.c
> > +++ b/libselinux/src/label.c
> > @@ -333,8 +333,8 @@ int selabel_lookup_best_match_raw(struct selabel_ha=
ndle *rec, char **con,
> >         return *con ? 0 : -1;
> >  }
> >
> > -enum selabel_cmp_result selabel_cmp(struct selabel_handle *h1,
> > -                                   struct selabel_handle *h2)
> > +enum selabel_cmp_result selabel_cmp(const struct selabel_handle *h1,
> > +                                   const struct selabel_handle *h2)
> >  {
> >         if (!h1->func_cmp || h1->func_cmp !=3D h2->func_cmp)
> >                 return SELABEL_INCOMPARABLE;
> > diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c
> > index 461abc61..5ac23e1f 100644
> > --- a/libselinux/src/label_file.c
> > +++ b/libselinux/src/label_file.c
> > @@ -1237,7 +1237,7 @@ out:
> >         return lr;
> >  }
> >
> > -static enum selabel_cmp_result incomp(struct spec *spec1, struct spec =
*spec2, const char *reason, int i, int j)
> > +static enum selabel_cmp_result incomp(const struct spec *spec1, const =
struct spec *spec2, const char *reason, int i, int j)
> >  {
> >         selinux_log(SELINUX_INFO,
> >                     "selabel_cmp: mismatched %s on entry %d: (%s, %x, %=
s) vs entry %d: (%s, %x, %s)\n",
> > @@ -1247,21 +1247,21 @@ static enum selabel_cmp_result incomp(struct sp=
ec *spec1, struct spec *spec2, co
> >         return SELABEL_INCOMPARABLE;
> >  }
> >
> > -static enum selabel_cmp_result cmp(struct selabel_handle *h1,
> > -                                  struct selabel_handle *h2)
> > +static enum selabel_cmp_result cmp(const struct selabel_handle *h1,
> > +                                  const struct selabel_handle *h2)
> >  {
> > -       struct saved_data *data1 =3D (struct saved_data *)h1->data;
> > -       struct saved_data *data2 =3D (struct saved_data *)h2->data;
> > +       const struct saved_data *data1 =3D (const struct saved_data *)h=
1->data;
> > +       const struct saved_data *data2 =3D (const struct saved_data *)h=
2->data;
> >         unsigned int i, nspec1 =3D data1->nspec, j, nspec2 =3D data2->n=
spec;
> > -       struct spec *spec_arr1 =3D data1->spec_arr, *spec_arr2 =3D data=
2->spec_arr;
> > -       struct stem *stem_arr1 =3D data1->stem_arr, *stem_arr2 =3D data=
2->stem_arr;
> > +       const struct spec *spec_arr1 =3D data1->spec_arr, *spec_arr2 =
=3D data2->spec_arr;
> > +       const struct stem *stem_arr1 =3D data1->stem_arr, *stem_arr2 =
=3D data2->stem_arr;
> >         bool skipped1 =3D false, skipped2 =3D false;
> >
> >         i =3D 0;
> >         j =3D 0;
> >         while (i < nspec1 && j < nspec2) {
> > -               struct spec *spec1 =3D &spec_arr1[i];
> > -               struct spec *spec2 =3D &spec_arr2[j];
> > +               const struct spec *spec1 =3D &spec_arr1[i];
> > +               const struct spec *spec2 =3D &spec_arr2[j];
> >
> >                 /*
> >                  * Because sort_specs() moves exact pathnames to the
> > @@ -1297,8 +1297,8 @@ static enum selabel_cmp_result cmp(struct selabel=
_handle *h1,
> >                 if (spec2->stem_id =3D=3D -1 && spec1->stem_id !=3D -1)
> >                         return incomp(spec1, spec2, "stem_id", i, j);
> >                 if (spec1->stem_id !=3D -1 && spec2->stem_id !=3D -1) {
> > -                       struct stem *stem1 =3D &stem_arr1[spec1->stem_i=
d];
> > -                       struct stem *stem2 =3D &stem_arr2[spec2->stem_i=
d];
> > +                       const struct stem *stem1 =3D &stem_arr1[spec1->=
stem_id];
> > +                       const struct stem *stem2 =3D &stem_arr2[spec2->=
stem_id];
> >                         if (stem1->len !=3D stem2->len ||
> >                             strncmp(stem1->buf, stem2->buf, stem1->len)=
)
> >                                 return incomp(spec1, spec2, "stem", i, =
j);
> > diff --git a/libselinux/src/label_internal.h b/libselinux/src/label_int=
ernal.h
> > index 273a630a..bc5a6928 100644
> > --- a/libselinux/src/label_internal.h
> > +++ b/libselinux/src/label_internal.h
> > @@ -98,8 +98,8 @@ struct selabel_handle {
> >                                                     const char *key,
> >                                                     const char **aliase=
s,
> >                                                     int type);
> > -       enum selabel_cmp_result (*func_cmp)(struct selabel_handle *h1,
> > -                                           struct selabel_handle *h2);
> > +       enum selabel_cmp_result (*func_cmp)(const struct selabel_handle=
 *h1,
> > +                                           const struct selabel_handle=
 *h2);
> >
> >         /* supports backend-specific state information */
> >         void *data;
> > --
> > 2.40.1
> >
