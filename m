Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34F43E74901
	for <selinux@archiver.kernel.org>; Mon,  2 Oct 2023 18:11:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229487AbjJBSL2 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 2 Oct 2023 14:11:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbjJBSLY (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 2 Oct 2023 14:11:24 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EB289B
        for <selinux@vger.kernel.org>; Mon,  2 Oct 2023 11:11:21 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-50567477b29so5807345e87.3
        for <selinux@vger.kernel.org>; Mon, 02 Oct 2023 11:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696270279; x=1696875079; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CIPieEaXHk005hHTe2882OkUgauNDwjqoJ/r2hYGSwg=;
        b=MykkeRFsS4l4e7CB2gZaPhMW41jr8EvIWG4L+IQpInR+LCnPh4iWQecoL4rHDDitS7
         nY5bySSaQW7MlQ5lLvZO8/Q9uUgl0TqjzDBC9t4wK9E9UGtY7X2pq+XQDs35NDbXr3Am
         PVoDhQQge+jRHweztWYg4ljl4OI/IGLPFNzGmHVw956zi53EW6+wfQHQOa/iJ34MtV0B
         riHmlAvHtqKs6vrQz/QhjSIcwqtEQgZPsVC/bfSsYHQ8DJYFPTZbv2G3zBxMAN+G/1za
         +5n4XzsgRSrnAuvvjbRanNs0G7GpCtbXyQdmRk3IdCz4HMB0uWkRAK9TDCY6DOJaF/1X
         hdIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696270279; x=1696875079;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CIPieEaXHk005hHTe2882OkUgauNDwjqoJ/r2hYGSwg=;
        b=i3/lyDdQF/UT6mawXWPg0y0tUbaWN6lRqZk1coxLrdR3V7ZI2P5FhV2SBS6HOTaXzq
         0z63v5DCaWPN6HFZM/Sh4uL0G+2OKTiPSPGgWFF+r1QLPdNE91nMBLkAcim53uq+04Vp
         A7L7zQWxpmrlShpqHk5QXFQU0Y2laeAAQ+20lZjSoOLzWjIX+A/UArVHrVvLAKezuQWc
         AIIR/gaOJtf/3nrU3mCBg73jYAPZh16vRY4d0mMdMGJPwJCCNStafol7z9w6GLo9dWa9
         MfaPTZPNKtmGIevyGn+Y59YNQo7LZfzUexXk9xbRXSBu1+ttbXxbZe+kzZfmIl09+Yx3
         Z6kQ==
X-Gm-Message-State: AOJu0Yx1gUavIB3ajOPqtYJp4lltdqOLTpkex4of+6NgMlstF2WoGmEB
        USbc7nsA2Golu/1hvLzSGEYy/1lEVgiZmhZfLxx06f4Hutc=
X-Google-Smtp-Source: AGHT+IEKwMwIPznwzcVskp7TH+z0WlxYMYnJQYvjmTiQ8tR+rcXjHqRr65QkSm+URlQTm8l7ZmQoZSDGuW9qX1uidik=
X-Received: by 2002:a19:8c1a:0:b0:503:28ed:143b with SMTP id
 o26-20020a198c1a000000b0050328ed143bmr9581185lfd.18.1696270279207; Mon, 02
 Oct 2023 11:11:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230814132025.45364-1-cgzones@googlemail.com> <20230814132025.45364-8-cgzones@googlemail.com>
In-Reply-To: <20230814132025.45364-8-cgzones@googlemail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Mon, 2 Oct 2023 14:11:07 -0400
Message-ID: <CAP+JOzSrYQuSVKxu6dFGBOA2ZCESgbwos0_wPxjORZ7ZAqT1Gw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 07/27] libselinux: constify selabel_cmp(3) parameters
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Aug 14, 2023 at 9:42=E2=80=AFAM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> Comparing two selabel handles should (and currently does) not modify
> them.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libselinux/include/selinux/label.h |  4 ++--
>  libselinux/src/label.c             |  4 ++--
>  libselinux/src/label_file.c        | 22 +++++++++++-----------
>  libselinux/src/label_internal.h    |  4 ++--
>  4 files changed, 17 insertions(+), 17 deletions(-)
>
> diff --git a/libselinux/include/selinux/label.h b/libselinux/include/seli=
nux/label.h
> index e8983606..ce189a3a 100644
> --- a/libselinux/include/selinux/label.h
> +++ b/libselinux/include/selinux/label.h
> @@ -153,8 +153,8 @@ enum selabel_cmp_result {
>   * if @h1 is identical to @h2, %SELABEL_SUPERSET if @h1 is a superset
>   * of @h2, and %SELABEL_INCOMPARABLE if @h1 and @h2 are incomparable.
>   */
> -extern enum selabel_cmp_result selabel_cmp(struct selabel_handle *h1,
> -                                          struct selabel_handle *h2);
> +extern enum selabel_cmp_result selabel_cmp(const struct selabel_handle *=
h1,
> +                                          const struct selabel_handle *h=
2);
>
>  /**
>   * selabel_stats - log labeling operation statistics.
> diff --git a/libselinux/src/label.c b/libselinux/src/label.c
> index a2efa99c..c0f586a2 100644
> --- a/libselinux/src/label.c
> +++ b/libselinux/src/label.c
> @@ -333,8 +333,8 @@ int selabel_lookup_best_match_raw(struct selabel_hand=
le *rec, char **con,
>         return *con ? 0 : -1;
>  }
>
> -enum selabel_cmp_result selabel_cmp(struct selabel_handle *h1,
> -                                   struct selabel_handle *h2)
> +enum selabel_cmp_result selabel_cmp(const struct selabel_handle *h1,
> +                                   const struct selabel_handle *h2)
>  {
>         if (!h1->func_cmp || h1->func_cmp !=3D h2->func_cmp)
>                 return SELABEL_INCOMPARABLE;
> diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c
> index 461abc61..5ac23e1f 100644
> --- a/libselinux/src/label_file.c
> +++ b/libselinux/src/label_file.c
> @@ -1237,7 +1237,7 @@ out:
>         return lr;
>  }
>
> -static enum selabel_cmp_result incomp(struct spec *spec1, struct spec *s=
pec2, const char *reason, int i, int j)
> +static enum selabel_cmp_result incomp(const struct spec *spec1, const st=
ruct spec *spec2, const char *reason, int i, int j)
>  {
>         selinux_log(SELINUX_INFO,
>                     "selabel_cmp: mismatched %s on entry %d: (%s, %x, %s)=
 vs entry %d: (%s, %x, %s)\n",
> @@ -1247,21 +1247,21 @@ static enum selabel_cmp_result incomp(struct spec=
 *spec1, struct spec *spec2, co
>         return SELABEL_INCOMPARABLE;
>  }
>
> -static enum selabel_cmp_result cmp(struct selabel_handle *h1,
> -                                  struct selabel_handle *h2)
> +static enum selabel_cmp_result cmp(const struct selabel_handle *h1,
> +                                  const struct selabel_handle *h2)
>  {
> -       struct saved_data *data1 =3D (struct saved_data *)h1->data;
> -       struct saved_data *data2 =3D (struct saved_data *)h2->data;
> +       const struct saved_data *data1 =3D (const struct saved_data *)h1-=
>data;
> +       const struct saved_data *data2 =3D (const struct saved_data *)h2-=
>data;
>         unsigned int i, nspec1 =3D data1->nspec, j, nspec2 =3D data2->nsp=
ec;
> -       struct spec *spec_arr1 =3D data1->spec_arr, *spec_arr2 =3D data2-=
>spec_arr;
> -       struct stem *stem_arr1 =3D data1->stem_arr, *stem_arr2 =3D data2-=
>stem_arr;
> +       const struct spec *spec_arr1 =3D data1->spec_arr, *spec_arr2 =3D =
data2->spec_arr;
> +       const struct stem *stem_arr1 =3D data1->stem_arr, *stem_arr2 =3D =
data2->stem_arr;
>         bool skipped1 =3D false, skipped2 =3D false;
>
>         i =3D 0;
>         j =3D 0;
>         while (i < nspec1 && j < nspec2) {
> -               struct spec *spec1 =3D &spec_arr1[i];
> -               struct spec *spec2 =3D &spec_arr2[j];
> +               const struct spec *spec1 =3D &spec_arr1[i];
> +               const struct spec *spec2 =3D &spec_arr2[j];
>
>                 /*
>                  * Because sort_specs() moves exact pathnames to the
> @@ -1297,8 +1297,8 @@ static enum selabel_cmp_result cmp(struct selabel_h=
andle *h1,
>                 if (spec2->stem_id =3D=3D -1 && spec1->stem_id !=3D -1)
>                         return incomp(spec1, spec2, "stem_id", i, j);
>                 if (spec1->stem_id !=3D -1 && spec2->stem_id !=3D -1) {
> -                       struct stem *stem1 =3D &stem_arr1[spec1->stem_id]=
;
> -                       struct stem *stem2 =3D &stem_arr2[spec2->stem_id]=
;
> +                       const struct stem *stem1 =3D &stem_arr1[spec1->st=
em_id];
> +                       const struct stem *stem2 =3D &stem_arr2[spec2->st=
em_id];
>                         if (stem1->len !=3D stem2->len ||
>                             strncmp(stem1->buf, stem2->buf, stem1->len))
>                                 return incomp(spec1, spec2, "stem", i, j)=
;
> diff --git a/libselinux/src/label_internal.h b/libselinux/src/label_inter=
nal.h
> index 273a630a..bc5a6928 100644
> --- a/libselinux/src/label_internal.h
> +++ b/libselinux/src/label_internal.h
> @@ -98,8 +98,8 @@ struct selabel_handle {
>                                                     const char *key,
>                                                     const char **aliases,
>                                                     int type);
> -       enum selabel_cmp_result (*func_cmp)(struct selabel_handle *h1,
> -                                           struct selabel_handle *h2);
> +       enum selabel_cmp_result (*func_cmp)(const struct selabel_handle *=
h1,
> +                                           const struct selabel_handle *=
h2);
>
>         /* supports backend-specific state information */
>         void *data;
> --
> 2.40.1
>
