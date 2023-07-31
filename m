Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7564FC41513
	for <selinux@archiver.kernel.org>; Mon, 31 Jul 2023 13:52:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232040AbjGaNwp (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 31 Jul 2023 09:52:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231743AbjGaNwL (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 31 Jul 2023 09:52:11 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D41C719A1
        for <selinux@vger.kernel.org>; Mon, 31 Jul 2023 06:51:45 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2b9e6cc93c6so18017891fa.2
        for <selinux@vger.kernel.org>; Mon, 31 Jul 2023 06:51:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690811504; x=1691416304;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5EO/7sPL9Jam6MjvPJknMxFIWejtALmfL6vveBYoL1w=;
        b=APUalQ7/cTHmLJ4GbZPIlbZkJxVH1Njb58vJbR9Ui7/2k8I8jDlkEDCwHuoSa/0Vg7
         bC5b7/aHoHihxioWBzmoCc4Jw83jk7Q7BpFugpOjFjU2JBUSogvUOl18Alc22jvQAndp
         vUu4/BPzz4jwPA2jqTiJkI6BR+uG0MPKj7ZE+sBd+HfvgQXcwTPz3jsX+o/vrd4RhiVk
         kNVZ2HRgOaBiQfbKl4XGgczUVY2wonyRBq3LDB/8RgK3Le4DEkmrVRWb/khVFepS6g3y
         q0nVAr0yZW7qmkM8S9saB9ABLM8+ShlE/sNgpuNU56ecDLRiUk6ri6PsesGDUi4eVD6N
         JJfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690811504; x=1691416304;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5EO/7sPL9Jam6MjvPJknMxFIWejtALmfL6vveBYoL1w=;
        b=M1Fd+3In3zD330b+hcACeCSGowSqKlvGFpDMFQrsaYqWQuU9353rUTUBWrVc3XjTUF
         vEP7QturolE5N4jVfRxnqeJ/y6A63UJa9jy+0HVtZVaPr+RNLX9W6R9/Qrmv7cRYNn4Y
         SjHo1RypVOrxUty2mtnN1zJUDbotc9vDCG03G08RdLMFbeu3qudwn+VAxq/4lPUGEvOq
         9dSXr2rR1Yb8QyD9LXkXW6Gp1oE5zN3sjvsnIK840vv6NAxD/QsqJluockvhZ53ARjVY
         zNNHA4seEGf/eSL193l/hDPp305pye03AD0uZ+tYg9ix5x7xPoSlmdoLmZFbKmIZGIkS
         zYEQ==
X-Gm-Message-State: ABy/qLbpp5GAa9HGgH3eXstN7jtp2SR57UTuV/TZxSqU8OouboRMa8PD
        HHL+AioKY3p2UyihlrqxwCuvkNxEGKC28V/8vuTewhgsYYE=
X-Google-Smtp-Source: APBJJlGhZEQxF1Xco7MGZNjtg/S83IewlADEG+CmQRaxXQqkvRoY5UM5JCVgi70nl1n86SeBb5V/FwmjNODQ3f8Zg5w=
X-Received: by 2002:a2e:3307:0:b0:2b6:ba54:cc8 with SMTP id
 d7-20020a2e3307000000b002b6ba540cc8mr16002ljc.30.1690811503762; Mon, 31 Jul
 2023 06:51:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230706141329.57661-1-cgzones@googlemail.com>
In-Reply-To: <20230706141329.57661-1-cgzones@googlemail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Mon, 31 Jul 2023 09:51:32 -0400
Message-ID: <CAP+JOzRq7qM0m40=2G44nZkxEmga48QwbVBGXWFvK=Yw0cKkPA@mail.gmail.com>
Subject: Re: [RFC PATCH] libsepol/cil: support parallel neverallow checks
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Jul 6, 2023 at 10:22=E2=80=AFAM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> Add support to check for neverallow assertions in parallel.  Since the
> policy is not modified during those checks there needs to be no
> extensive locking.
>
> The checks are run by semodule(8) if the semanage.conf(5) setting
> expand-check is set.
>
> Implement the parallel procedure via OpenMP, to minimize code changes
> and to allow users a simple way to enable or disable the functionality
> at build time.  Currently the support opt-in.
>
> Example benchmark:
>
>     Benchmark 1: ./test_load_wip.sh (serial)
>       Time (mean =C2=B1 =CF=83):      3.485 s =C2=B1  0.019 s    [User: 0=
.003 s, System: 0.002 s]
>       Range (min =E2=80=A6 max):    3.455 s =E2=80=A6  3.501 s    5 runs
>
>     Benchmark 1: ./test_load_wip.sh (parallel)
>       Time (mean =C2=B1 =CF=83):      2.443 s =C2=B1  0.035 s    [User: 0=
.004 s, System: 0.001 s]
>       Range (min =E2=80=A6 max):    2.411 s =E2=80=A6  2.500 s    5 runs
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Needs a "-fopenmp" when building.

I am not seeing very much change (1.8 sec originally, 1.6 sec with this pat=
ch).
Jim

> ---
>  libsepol/cil/src/cil_binary.c | 60 ++++++++++++++++++++++++++++-------
>  1 file changed, 48 insertions(+), 12 deletions(-)
>
> diff --git a/libsepol/cil/src/cil_binary.c b/libsepol/cil/src/cil_binary.=
c
> index c4ee2380..7f6212e3 100644
> --- a/libsepol/cil/src/cil_binary.c
> +++ b/libsepol/cil/src/cil_binary.c
> @@ -4828,8 +4828,11 @@ static int cil_check_neverallow(const struct cil_d=
b *db, policydb_t *pdb, struct
>
>                 rc =3D check_assertion(pdb, rule);
>                 if (rc =3D=3D CIL_TRUE) {
> -                       *violation =3D CIL_TRUE;
> -                       rc =3D __cil_print_neverallow_failure(db, node);
> +                       #pragma omp critical (output)
> +                       {
> +                               *violation =3D CIL_TRUE;
> +                               rc =3D __cil_print_neverallow_failure(db,=
 node);
> +                       }
>                         if (rc !=3D SEPOL_OK) {
>                                 goto exit;
>                         }
> @@ -4850,8 +4853,11 @@ static int cil_check_neverallow(const struct cil_d=
b *db, policydb_t *pdb, struct
>                         rule->xperms =3D item->data;
>                         rc =3D check_assertion(pdb, rule);
>                         if (rc =3D=3D CIL_TRUE) {
> -                               *violation =3D CIL_TRUE;
> -                               rc =3D __cil_print_neverallow_failure(db,=
 node);
> +                               #pragma omp critical (output)
> +                               {
> +                                       *violation =3D CIL_TRUE;
> +                                       rc =3D __cil_print_neverallow_fai=
lure(db, node);
> +                               }
>                                 if (rc !=3D SEPOL_OK) {
>                                         goto exit;
>                                 }
> @@ -4876,18 +4882,48 @@ exit:
>
>  static int cil_check_neverallows(const struct cil_db *db, policydb_t *pd=
b, struct cil_list *neverallows, int *violation)
>  {
> -       int rc =3D SEPOL_OK;
> -       struct cil_list_item *item;
> +       int rc_sync =3D SEPOL_OK;
> +
> +       #pragma omp parallel
> +       {
> +
> +               #pragma omp single
> +               {
> +
> +                       struct cil_list_item *item;
> +                       cil_list_for_each(item, neverallows) {
> +
> +                               struct cil_tree_node *node =3D item->data=
;
> +                               int rc_test;
> +
> +                               #pragma omp task default(none) firstpriva=
te(node, db, pdb, violation) shared(rc_sync) untied
> +                               {
> +                                       int rc_task =3D cil_check_neveral=
low(
> +                                               db,
> +                                               pdb,
> +                                               node,
> +                                               violation);
> +
> +                                       if (rc_task !=3D SEPOL_OK) {
> +                                               #pragma omp atomic write
> +                                               rc_sync =3D rc_task;
> +                                       }
> +                               }
> +
> +                               #pragma omp atomic read
> +                               rc_test =3D rc_sync;
> +
> +                               if (rc_test !=3D SEPOL_OK)
> +                                       break;
> +
> +                       }
>
> -       cil_list_for_each(item, neverallows) {
> -               rc =3D cil_check_neverallow(db, pdb, item->data, violatio=
n);
> -               if (rc !=3D SEPOL_OK) {
> -                       goto exit;
>                 }
> +
> +               #pragma omp taskwait
>         }
>
> -exit:
> -       return rc;
> +       return rc_sync;
>  }
>
>  static struct cil_list *cil_classperms_from_sepol(policydb_t *pdb, uint1=
6_t class, uint32_t data, struct cil_class *class_value_to_cil[], struct ci=
l_perm **perm_value_to_cil[])
> --
> 2.40.1
>
