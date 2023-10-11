Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10063CDB491
	for <selinux@archiver.kernel.org>; Wed, 11 Oct 2023 18:49:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233274AbjJKSts (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 11 Oct 2023 14:49:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233287AbjJKStl (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 11 Oct 2023 14:49:41 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54E3AAF
        for <selinux@vger.kernel.org>; Wed, 11 Oct 2023 11:49:29 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-50481a0eee7so1590887e87.0
        for <selinux@vger.kernel.org>; Wed, 11 Oct 2023 11:49:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697050167; x=1697654967; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FcTyqt4b54tHFtF138iLGtw6FJSlLvTxQNHLC3TYvH0=;
        b=CZQ5fYp46/WBZQ+8L1p8HB5nBwIsUPmtaOLESKjHW7sAoNM3C/baVgAM4fGHEA8ZEV
         Uf6gEms6wx6Xq/+bpWvkP/VkpuTWp0VLmzkQdyA1cx9664rlgNFBtbgku6s1oEKBUzZo
         K3h6tRDF2EDUnRfetHkt1zMgl6aaFWTNPbbnnSQZj/F8KLbIe9Wcm6t+iQePHl9F+2Nq
         qFJCDRqzEag0CBLdmLR5s4jWS8rhWcQ84QK28oWZi5XvDUXaTKxI3lriZcdhYTH2EZ67
         4ZPRxU7kMp6XyZ4wLtDgyI1MPyFzm9MVm6krgDkh+F+PPO2EfeE0yw2MWBLonnWWxnNw
         K7hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697050167; x=1697654967;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FcTyqt4b54tHFtF138iLGtw6FJSlLvTxQNHLC3TYvH0=;
        b=COOp49Uyp1PWr9QYR2HZJ/3l8dCo2WexdTpj+4tt1lOJfuJTXZvgoCHanQm5K6+e7P
         sMAns75kjDVcf5ujs4PBZ+M/lxP0Q6i0uo7abmyRiIu8gKXN6HjhA5PnN/SVcruKRa3P
         cjbOHTt67nmJEQI5U8DpBc+NEHkDgm7wfJucyKbOGJnm8lHhVeZYuVt1tAaiJI2CAvXl
         oWfqOQzfk8UJ4mR7oSmtZVGdywR2UCCjqdworn0+8Et/hIIrm2f07ZSwmk1pZvFMD9aO
         Lh09lWZw4/zCfpuV8UtudKitUqdjnUXNlq4Lu6TwgriyXFBbaRJyPmzuMnMQaeUk8kRF
         wv5A==
X-Gm-Message-State: AOJu0YxuF/Ldj07CzjcTq4dJx3BDbjpWphxo8jRKfA3k68oMTxHCYmO8
        IeaRPMP2Kslo2CTgsLEDk29hd+qQvI21yenks73+m4OXrNw=
X-Google-Smtp-Source: AGHT+IFpln8PLoo49gwemShCqaqBGkOTHeSfIuSdxo5xV5gxo9pa259N00efAtiQdVcIDujpmn+ayCardcmwORR02e8=
X-Received: by 2002:a05:6512:2308:b0:4ff:839b:5355 with SMTP id
 o8-20020a056512230800b004ff839b5355mr14844903lfu.18.1697050167233; Wed, 11
 Oct 2023 11:49:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230814132025.45364-1-cgzones@googlemail.com> <20230814132025.45364-22-cgzones@googlemail.com>
In-Reply-To: <20230814132025.45364-22-cgzones@googlemail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Wed, 11 Oct 2023 14:49:16 -0400
Message-ID: <CAP+JOzQqYAUo1=XNyD5DirbkrGeQwiq4DFyueOHQP-HocME7ug@mail.gmail.com>
Subject: Re: [RFC PATCH v2 21/27] libselinux: simplify internal
 selabel_validate prototype
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
> Move the check whether to validate or not to the caller, to avoid all
> having to carry the complete selabel_handle around.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libselinux/src/label.c                  | 5 ++---
>  libselinux/src/label_backends_android.c | 2 +-
>  libselinux/src/label_file.c             | 2 +-
>  libselinux/src/label_internal.h         | 3 +--
>  libselinux/src/matchpathcon.c           | 7 ++++---
>  5 files changed, 9 insertions(+), 10 deletions(-)
>
> diff --git a/libselinux/src/label.c b/libselinux/src/label.c
> index 9a972f79..1ea9bdcd 100644
> --- a/libselinux/src/label.c
> +++ b/libselinux/src/label.c
> @@ -119,12 +119,11 @@ static inline int selabel_is_validate_set(const str=
uct selinux_opt *opts,
>         return 0;
>  }
>
> -int selabel_validate(const struct selabel_handle *rec,
> -                    struct selabel_lookup_rec *contexts)
> +int selabel_validate(struct selabel_lookup_rec *contexts)
>  {
>         int rc =3D 0;
>
> -       if (!rec->validating || contexts->validated)
> +       if (contexts->validated)
>                 goto out;
>
>         rc =3D selinux_validate(&contexts->ctx_raw);
> diff --git a/libselinux/src/label_backends_android.c b/libselinux/src/lab=
el_backends_android.c
> index 6494f3cd..cd3875fc 100644
> --- a/libselinux/src/label_backends_android.c
> +++ b/libselinux/src/label_backends_android.c
> @@ -126,7 +126,7 @@ static int process_line(struct selabel_handle *rec,
>                 spec_arr[nspec].lr.ctx_raw =3D context;
>
>                 if (rec->validating) {
> -                       if (selabel_validate(rec, &spec_arr[nspec].lr) < =
0) {
> +                       if (selabel_validate(&spec_arr[nspec].lr) < 0) {
>                                 selinux_log(SELINUX_ERROR,
>                                             "%s:  line %u has invalid con=
text %s\n",
>                                             path, lineno, spec_arr[nspec]=
.lr.ctx_raw);
> diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c
> index a5677411..64b58d42 100644
> --- a/libselinux/src/label_file.c
> +++ b/libselinux/src/label_file.c
> @@ -404,7 +404,7 @@ end_arch_check:
>                 spec->lr.ctx_raw =3D str_buf;
>
>                 if (strcmp(spec->lr.ctx_raw, "<<none>>") && rec->validati=
ng) {
> -                       if (selabel_validate(rec, &spec->lr) < 0) {
> +                       if (selabel_validate(&spec->lr) < 0) {
>                                 selinux_log(SELINUX_ERROR,
>                                             "%s: context %s is invalid\n"=
,
>                                             path, spec->lr.ctx_raw);
> diff --git a/libselinux/src/label_internal.h b/libselinux/src/label_inter=
nal.h
> index bc5a6928..ea60cd9a 100644
> --- a/libselinux/src/label_internal.h
> +++ b/libselinux/src/label_internal.h
> @@ -118,8 +118,7 @@ struct selabel_handle {
>   * Validation function
>   */
>  extern int
> -selabel_validate(const struct selabel_handle *rec,
> -                struct selabel_lookup_rec *contexts) ;
> +selabel_validate(struct selabel_lookup_rec *contexts);
>
>  /*
>   * Compatibility support
> diff --git a/libselinux/src/matchpathcon.c b/libselinux/src/matchpathcon.=
c
> index 971ace62..4ed25ce9 100644
> --- a/libselinux/src/matchpathcon.c
> +++ b/libselinux/src/matchpathcon.c
> @@ -46,8 +46,8 @@ int compat_validate(const struct selabel_handle *rec,
>                 rc =3D myinvalidcon(path, lineno, *ctx);
>         else if (mycanoncon)
>                 rc =3D mycanoncon(path, lineno, ctx);
> -       else {
> -               rc =3D selabel_validate(rec, contexts);
> +       else if (rec->validating) {
> +               rc =3D selabel_validate(contexts);
>                 if (rc < 0) {
>                         if (lineno) {
>                                 COMPAT_LOG(SELINUX_WARNING,
> @@ -58,7 +58,8 @@ int compat_validate(const struct selabel_handle *rec,
>                                             "%s: has invalid context %s\n=
", path, *ctx);
>                         }
>                 }
> -       }
> +       } else
> +               rc =3D 0;
>
>         return rc ? -1 : 0;
>  }
> --
> 2.40.1
>
