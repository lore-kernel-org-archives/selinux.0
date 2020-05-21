Return-Path: <SRS0=ZZHY=7D=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCCABC433DF
	for <selinux@archiver.kernel.org>; Thu, 21 May 2020 19:16:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9BB0120738
	for <selinux@archiver.kernel.org>; Thu, 21 May 2020 19:16:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729829AbgEUTQf convert rfc822-to-8bit (ORCPT
        <rfc822;selinux@archiver.kernel.org>);
        Thu, 21 May 2020 15:16:35 -0400
Received: from mx1.polytechnique.org ([129.104.30.34]:55472 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729625AbgEUTQf (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 21 May 2020 15:16:35 -0400
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 05D3A561275
        for <selinux@vger.kernel.org>; Thu, 21 May 2020 21:16:29 +0200 (CEST)
Received: by mail-ot1-f53.google.com with SMTP id x22so6405189otq.4
        for <selinux@vger.kernel.org>; Thu, 21 May 2020 12:16:28 -0700 (PDT)
X-Gm-Message-State: AOAM531g4lSPpQLVsngPcGQMsDH/uUUkp+PkNKJqfIkUSqlbHPIIKbax
        Qe19BJ9QuGYvQoJlG23fMy5Y8oOnFENAQvyUFbw=
X-Google-Smtp-Source: ABdhPJy9fW8hQpIE2DEPQkLwjSAW7mQUWR2HUR8R4oqo8aqL+gi9VsNmZBiLhpaHniZDCGSLKhFwuuBcJHoC9O9zgxw=
X-Received: by 2002:a9d:476:: with SMTP id 109mr7749576otc.96.1590088587856;
 Thu, 21 May 2020 12:16:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200521152448.148333-1-jwcart2@gmail.com> <20200521152448.148333-2-jwcart2@gmail.com>
In-Reply-To: <20200521152448.148333-2-jwcart2@gmail.com>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Thu, 21 May 2020 21:16:16 +0200
X-Gmail-Original-Message-ID: <CAJfZ7=nEpgceRy6tDZL6XUBsVhX9Y+u-hCaYpUCiREgJiCxONA@mail.gmail.com>
Message-ID: <CAJfZ7=nEpgceRy6tDZL6XUBsVhX9Y+u-hCaYpUCiREgJiCxONA@mail.gmail.com>
Subject: Re: [PATCH 2/3] libsepol: Improve writing CIL sensitivity rules
To:     James Carter <jwcart2@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Thu May 21 21:16:29 2020 +0200 (CEST))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, May 21, 2020 at 5:25 PM James Carter <jwcart2@gmail.com> wrote:
>
> Improves writing of CIL sensitivity rules when converting MLS kernel
> policy to CIL. No changes to functionality, but eliminate useless
> checks for sensitivity aliases when using the p_sens_val_to_name
> array, find the actual number of aliases before allocating memory,
> and skip the sensitivity alias rules if there are no aliases.
>
> Signed-off-by: James Carter <jwcart2@gmail.com>
> ---
>  libsepol/src/kernel_to_cil.c | 59 ++++++++++++++++++------------------
>  1 file changed, 29 insertions(+), 30 deletions(-)
>
> diff --git a/libsepol/src/kernel_to_cil.c b/libsepol/src/kernel_to_cil.c
> index cca77251..6103c1a6 100644
> --- a/libsepol/src/kernel_to_cil.c
> +++ b/libsepol/src/kernel_to_cil.c
> @@ -782,6 +782,17 @@ static void write_default_mls_level(FILE *out)
>         sepol_printf(out, "(level %s (s0))\n", DEFAULT_LEVEL);
>  }
>
> +static int map_count_sensitivity_aliases(char *key, void *data, void *args)
> +{
> +       level_datum_t *sens = data;
> +       unsigned *count = args;
> +
> +       if (sens->isalias)
> +               (*count)++;
> +
> +       return SEPOL_OK;
> +}

Hello,
This patch looks good to me, but building fails because of an unused
parameter (here and in other patches),
https://travis-ci.org/github/fishilico/selinux/jobs/689760790#L2029 :

kernel_to_cil.c: In function ‘map_count_sensitivity_aliases’:
kernel_to_cil.c:785:48: error: unused parameter ‘key’ [-Werror=unused-parameter]
 static int map_count_sensitivity_aliases(char *key, void *data, void *args)
                                                ^~~
kernel_to_cil.c: In function ‘map_count_category_aliases’:
kernel_to_cil.c:889:45: error: unused parameter ‘key’ [-Werror=unused-parameter]
 static int map_count_category_aliases(char *key, void *data, void *args)
                                             ^~~
kernel_to_cil.c: In function ‘map_count_type_aliases’:
kernel_to_cil.c:1368:41: error: unused parameter ‘key’
[-Werror=unused-parameter]
 static int map_count_type_aliases(char *key, void *data, void *args)
                                        ^~~

Other functions use __attribute__((unused)) so you could probably use
it too in these functions.

Thanks,
Nicolas

> +
>  static int map_sensitivity_aliases_to_strs(char *key, void *data, void *args)
>  {
>         level_datum_t *sens = data;
> @@ -799,26 +810,13 @@ static int write_sensitivity_rules_to_cil(FILE *out, struct policydb *pdb)
>  {
>         level_datum_t *level;
>         char *prev, *name, *actual;
> -       struct strs *strs;
> -       unsigned i, num;
> +       struct strs *strs = NULL;
> +       unsigned i, num = 0;
>         int rc = 0;
>
> -       rc = strs_init(&strs, pdb->p_levels.nprim);
> -       if (rc != 0) {
> -               goto exit;
> -       }
> -
>         /* sensitivities */
>         for (i=0; i < pdb->p_levels.nprim; i++) {
>                 name = pdb->p_sens_val_to_name[i];
> -               if (!name) continue;
> -               level = hashtab_search(pdb->p_levels.table, name);
> -               if (!level) {
> -                       rc = -1;
> -                       goto exit;
> -               }
> -               if (level->isalias) continue;
> -
>                 sepol_printf(out, "(sensitivity %s)\n", name);
>         }
>
> @@ -827,14 +825,6 @@ static int write_sensitivity_rules_to_cil(FILE *out, struct policydb *pdb)
>         prev = NULL;
>         for (i=0; i < pdb->p_levels.nprim; i++) {
>                 name = pdb->p_sens_val_to_name[i];
> -               if (!name) continue;
> -               level = hashtab_search(pdb->p_levels.table, name);
> -               if (!level) {
> -                       rc = -1;
> -                       goto exit;
> -               }
> -               if (level->isalias) continue;
> -
>                 if (prev) {
>                         sepol_printf(out, "%s ", prev);
>                 }
> @@ -845,6 +835,22 @@ static int write_sensitivity_rules_to_cil(FILE *out, struct policydb *pdb)
>         }
>         sepol_printf(out, "))\n");
>
> +       rc = hashtab_map(pdb->p_levels.table, map_count_sensitivity_aliases, &num);
> +       if (rc != 0) {
> +               goto exit;
> +       }
> +
> +       if (num == 0) {
> +               /* No aliases, so skip sensitivity alias rules */
> +               rc = 0;
> +               goto exit;
> +       }
> +
> +       rc = strs_init(&strs, num);
> +       if (rc != 0) {
> +               goto exit;
> +       }
> +
>         rc = hashtab_map(pdb->p_levels.table, map_sensitivity_aliases_to_strs, strs);
>         if (rc != 0) {
>                 goto exit;
> @@ -852,16 +858,9 @@ static int write_sensitivity_rules_to_cil(FILE *out, struct policydb *pdb)
>
>         strs_sort(strs);
>
> -       num = strs_num_items(strs);
> -
>         /* sensitivity aliases */
>         for (i=0; i < num; i++) {
>                 name = strs_read_at_index(strs, i);
> -               level = hashtab_search(pdb->p_levels.table, name);
> -               if (!level) {
> -                       rc = -1;
> -                       goto exit;
> -               }
>                 sepol_printf(out, "(sensitivityalias %s)\n", name);
>         }
>
> --
> 2.25.4
>

