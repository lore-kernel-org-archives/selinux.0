Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CA28EB64DC
	for <selinux@archiver.kernel.org>; Tue, 11 Jul 2023 18:45:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbjGKSpd (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 11 Jul 2023 14:45:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbjGKSpc (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 11 Jul 2023 14:45:32 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F6E61704
        for <selinux@vger.kernel.org>; Tue, 11 Jul 2023 11:45:31 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2b70bfc8db5so82679451fa.2
        for <selinux@vger.kernel.org>; Tue, 11 Jul 2023 11:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689101129; x=1691693129;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZA6SMFjg2bTyGisaU76+BcsnpbI6oEdcMlstz6LqdpY=;
        b=D5oaDaVgMMqSD4c2iSE/JgvmswUDKk28vraO2Wd2v5UrG6OgNPSGxBTr4oLsSup97F
         JdIpNkkdMyCgTUYIYd9SzrM3GT4g36uznSrvhH3XRLpFrOOw7L6Dy5h8ZJIF+WGZ3xt8
         j4/ub/Kh/vKUI9epN05M0+EagK8M68kDJvWIi0t1ep1VP2/ImGnQ3GPnTTWzKx10dApD
         rV/wJ823YCzqJFMT1IETO9w8IZ+36roC5utaMOqyHXl64j1lOLwu7fZd425PBoa6g1PU
         +O017dm52R9yW2GAB4BlK8MTIG0Ci45D3ERuws9M4r4m4SzuO6p/O0Umb43cQz5C7bK9
         M4NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689101129; x=1691693129;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZA6SMFjg2bTyGisaU76+BcsnpbI6oEdcMlstz6LqdpY=;
        b=Awo13FnchTcsSX1gNwyCSu4wc086YdpViULDsWj+2pE0LeBkV23dqanKP7djdPCPlx
         g+qkuSvH4w+XekwQCW8qcmk5Ao0cAexQzdF1aBaL2rDQcNFon7XJEXOfUDtIWBU3xh+n
         KipVrA7abt7OyAtnGWyuWl3qLEBs1gjP29yil/yc6MUcQ7uI6kKNj84CeUrMBquDy138
         smmfSVw6E0fZ1Kkt1GTxnFpMoWHj/KBj7bnTJffcNyJa1C3UztbYfd2/PeTxDVHHBsO5
         guULdrrjs9LnrRsFgabf9OtQTRwYCNnItwrWmfLohxo0bCkOqYBZGLoXlFmJSvHOQD26
         MALw==
X-Gm-Message-State: ABy/qLZZbJIvvU67rTrcF4RXYKamKyAyHeIev8Dh1otrKKcJfBHg9XNy
        HtYfXFHMKfTR+wmDTXg+lsIhYYre6GxJbmQkLSvsDP+WgQQ=
X-Google-Smtp-Source: APBJJlHXAdOIsRz/yWHJjYh2f3mwMOwRcvilTkYLUgjotfomJiJYmfp2PCwdMcXa6epT8d3vxFEKcKhpfjhQZ0OylWo=
X-Received: by 2002:a2e:a41a:0:b0:2b6:fe54:2a4b with SMTP id
 p26-20020a2ea41a000000b002b6fe542a4bmr13412951ljn.37.1689101129211; Tue, 11
 Jul 2023 11:45:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230706135221.43544-1-cgzones@googlemail.com>
In-Reply-To: <20230706135221.43544-1-cgzones@googlemail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Tue, 11 Jul 2023 14:45:17 -0400
Message-ID: <CAP+JOzQM=PEaTsbcPX1wnhTx=t_dqoiuRAo+RMq+mT4Wj7gTQQ@mail.gmail.com>
Subject: Re: [PATCH] libsepol: free initial sid names
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Jul 6, 2023 at 10:01=E2=80=AFAM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> Commit 55b75a2c ("libsepol: stop translating deprecated intial SIDs to
> strings") dropped several names of obsolete initial sids ans replaced
> them with NULL.  This leads to their printable string being dynamically
> allocated but not free'd.
> Instead of keeping track of which name was allocated dynamically and
> which not, allocate all on the heap, which simplifies the later cleanup.
>
> While on it also free the name in case of a strs_add_at_index() failure.
>
> Reported-by: oss-fuzz (issue 60271)
> Fixes: 55b75a2c ("libsepol: stop translating deprecated intial SIDs to st=
rings")
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libsepol/src/kernel_to_cil.c  | 18 ++++++++----------
>  libsepol/src/kernel_to_conf.c | 16 +++++++---------
>  2 files changed, 15 insertions(+), 19 deletions(-)
>
> diff --git a/libsepol/src/kernel_to_cil.c b/libsepol/src/kernel_to_cil.c
> index a3d8d139..8fcc385d 100644
> --- a/libsepol/src/kernel_to_cil.c
> +++ b/libsepol/src/kernel_to_cil.c
> @@ -569,18 +569,19 @@ static int write_sids_to_cil(FILE *out, const char =
*const *sid_to_str,
>         for (isid =3D isids; isid !=3D NULL; isid =3D isid->next) {
>                 i =3D isid->sid[0];
>                 if (i < num_sids && sid_to_str[i]) {
> -                       sid =3D (char *)sid_to_str[i];
> +                       sid =3D strdup(sid_to_str[i]);
>                 } else {
>                         snprintf(unknown, 18, "%s%u", "UNKNOWN", i);
>                         sid =3D strdup(unknown);
> -                       if (!sid) {
> -                               ERR(NULL, "Out of memory");
> -                               rc =3D -1;
> -                               goto exit;
> -                       }
> +               }
> +               if (!sid) {
> +                       ERR(NULL, "Out of memory");
> +                       rc =3D -1;
> +                       goto exit;
>                 }
>                 rc =3D strs_add_at_index(strs, sid, i);
>                 if (rc !=3D 0) {
> +                       free(sid);
>                         goto exit;
>                 }
>         }
> @@ -611,10 +612,7 @@ static int write_sids_to_cil(FILE *out, const char *=
const *sid_to_str,
>         sepol_printf(out, "))\n");
>
>  exit:
> -       for (i=3Dnum_sids; i<strs_num_items(strs); i++) {
> -               sid =3D strs_read_at_index(strs, i);
> -               free(sid);
> -       }
> +       strs_free_all(strs);
>         strs_destroy(&strs);
>         if (rc !=3D 0) {
>                 ERR(NULL, "Error writing sid rules to CIL");
> diff --git a/libsepol/src/kernel_to_conf.c b/libsepol/src/kernel_to_conf.=
c
> index 0710572d..b0ae16d9 100644
> --- a/libsepol/src/kernel_to_conf.c
> +++ b/libsepol/src/kernel_to_conf.c
> @@ -466,17 +466,18 @@ static int write_sids_to_conf(FILE *out, const char=
 *const *sid_to_str,
>         for (isid =3D isids; isid !=3D NULL; isid =3D isid->next) {
>                 i =3D isid->sid[0];
>                 if (i < num_sids && sid_to_str[i]) {
> -                       sid =3D (char *)sid_to_str[i];
> +                       sid =3D strdup(sid_to_str[i]);
>                 } else {
>                         snprintf(unknown, sizeof(unknown), "%s%u", "UNKNO=
WN", i);
>                         sid =3D strdup(unknown);
> -                       if (!sid) {
> -                               rc =3D -1;
> -                               goto exit;
> -                       }
> +               }
> +               if (!sid) {
> +                       rc =3D -1;
> +                       goto exit;
>                 }
>                 rc =3D strs_add_at_index(strs, sid, i);
>                 if (rc !=3D 0) {
> +                       free(sid);
>                         goto exit;
>                 }
>         }
> @@ -490,10 +491,7 @@ static int write_sids_to_conf(FILE *out, const char =
*const *sid_to_str,
>         }
>
>  exit:
> -       for (i=3Dnum_sids; i<strs_num_items(strs); i++) {
> -               sid =3D strs_read_at_index(strs, i);
> -               free(sid);
> -       }
> +       strs_free_all(strs);
>         strs_destroy(&strs);
>         if (rc !=3D 0) {
>                 ERR(NULL, "Error writing sid rules to policy.conf");
> --
> 2.40.1
>
