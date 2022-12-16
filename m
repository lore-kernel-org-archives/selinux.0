Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5C4EC001B2
	for <selinux@archiver.kernel.org>; Fri, 16 Dec 2022 16:07:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbiLPQHF (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 16 Dec 2022 11:07:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231996AbiLPQGX (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 16 Dec 2022 11:06:23 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 151D5FCB
        for <selinux@vger.kernel.org>; Fri, 16 Dec 2022 08:03:56 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id qk9so7245524ejc.3
        for <selinux@vger.kernel.org>; Fri, 16 Dec 2022 08:03:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=25/1XV4MK0Oct8Abk3cZ1akMkM4mFc+IsyETtrodzd8=;
        b=lL7bRwjsKV7+j7eWyM5WNZny76YEUQYuYOxGBTneLOxgJn7SB5Hn8cp6lbXf3r2gDI
         wKnR50EzMfp3upyJb1pdAa0825zZX/8c4mf3hAUtkr4XRto48J3MkiJrGtqphmHk8RKb
         qZbtGNYCsgYjZ/YyziFBd+2CEA6oq4rNrMASvZdNRZXtCfY93nq1DaRBcbZgjmLKoeGS
         wa6eNxiVsHNQMPvMLRoi1lLdjx6pVKFO/2avjKEtPKILUzJymdKlTwWRKq03695uYLyy
         sfhz+yHJQCodjzaEjqMPEsyO0hVKBZ6dCN0qACUiVVxSWPRQ9xVbEfgMCPset0jx5FTE
         +NTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=25/1XV4MK0Oct8Abk3cZ1akMkM4mFc+IsyETtrodzd8=;
        b=N2LMZuYPmzgIuq0sk6ZeNDEz1aHNqSvHkut0ly9uvpsBctOtjpeJYw4jqsp0LfO3ih
         dkL+GBvCbtsAizGRddPUhZmE8Wp/WMK43n0XqbLSWeDXlichTv8jt5bmqWGn7EME3rVw
         efXeS1GxYXagItZjYMZjduBiMQMLRQla/6tYvWHmmnw26mv/pyX6Qk/apsH0kQQseC+3
         VMaldOx1RpetwfA9JKLB8Afx/nEFmQck8qzIIRZDH8zWczxSSKsmi3sVuua3fUw3UkG8
         RPEgjMjVN7y2dyiCoW5+VzPnrC3V0peK9fGfTbtYqn1JGQOHS7gXXFvqxMGpYojcyomE
         acxg==
X-Gm-Message-State: ANoB5pmKmyyDQ9zJZnUbZDmeA66knrdeb8+cdmXieMzvIv0fbjTuUTna
        J9VDO3QnRbNSCSzn2gPs4Q/fYSxoY7qC0hhZbFnWap3y
X-Google-Smtp-Source: AA0mqf7rRWvSnRBMSXa74+bWWeI4z3KIpa8m2ro+NhHcTdJFWRTfoJFpMhLFXp8SmCkRPpwaqE+UWIvPIDExl9ow2eo=
X-Received: by 2002:a17:907:6d8c:b0:7c1:675d:2620 with SMTP id
 sb12-20020a1709076d8c00b007c1675d2620mr2945430ejc.100.1671206634554; Fri, 16
 Dec 2022 08:03:54 -0800 (PST)
MIME-Version: 1.0
References: <20221205093644.703107-1-lujie54@huawei.com>
In-Reply-To: <20221205093644.703107-1-lujie54@huawei.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Fri, 16 Dec 2022 11:03:43 -0500
Message-ID: <CAP+JOzSPuRUj9mHQnoFJyCUqcUB+KX6GKJ+rA-9PYhdbUHQgQA@mail.gmail.com>
Subject: Re: [PATCH 1/3] libselinux: fix potential NULL reference and memory
 leak in audit2why
To:     Jie Lu <lujie54@huawei.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Dec 5, 2022 at 7:13 AM Jie Lu <lujie54@huawei.com> wrote:
>
> In audit2why.c add return check for memory allocation. And free every element
> in the boollist when function fails.
>
> Signed-off-by: Jie Lu <lujie54@huawei.com>
> ---
>  libselinux/src/audit2why.c | 26 ++++++++++++++++++++++++--
>  1 file changed, 24 insertions(+), 2 deletions(-)
>
> diff --git a/libselinux/src/audit2why.c b/libselinux/src/audit2why.c
> index ba1a66eb..742b4ff5 100644
> --- a/libselinux/src/audit2why.c
> +++ b/libselinux/src/audit2why.c
> @@ -55,7 +55,16 @@ static int load_booleans(const sepol_bool_t * boolean,
>                          void *arg __attribute__ ((__unused__)))
>  {
>         boollist[boolcnt] = malloc(sizeof(struct boolean_t));
> +       if (!boollist[boolcnt]) {
> +               PyErr_SetString( PyExc_MemoryError, "Out of memory\n");
> +               return -1;
> +       }
>         boollist[boolcnt]->name = strdup(sepol_bool_get_name(boolean));
> +       if (!boollist[boolcnt]->name) {
> +               PyErr_SetString( PyExc_MemoryError, "Out of memory\n");
> +               free(boollist[boolcnt]);
> +               return -1;
> +       }
>         boollist[boolcnt]->active = sepol_bool_get_value(boolean);
>         boolcnt++;
>         return 0;
> @@ -149,6 +158,11 @@ static int check_booleans(struct boolean_t **bools)
>
>         if (fcnt > 0) {
>                 *bools = calloc(sizeof(struct boolean_t), fcnt + 1);
> +               if (!*bools) {
> +                       PyErr_SetString( PyExc_MemoryError, "Out of memory\n");
> +                       free(foundlist);
> +                       return 0;
> +               }
>                 struct boolean_t *b = *bools;
>                 for (i = 0; i < fcnt; i++) {
>                         int ctr = foundlist[i];
> @@ -278,14 +292,22 @@ static int __policy_init(const char *init_path)
>         return 0;
>
>  err:
> -       if (boollist)
> -               free(boollist);
> +       if (boollist) {
> +               for (i = 0; i < boolcnt; i++) {
> +                        free(boollist[i]->name);
> +                        free(boollist[i]);
> +                }
> +                free(boollist);
> +                boollist = NULL;
> +                boolcnt = 0;
> +       }

i is not declared and it is indented with spaces rather than tabs.

Thanks,
Jim


>         if (avc){
>                 if (avc->handle)
>                         sepol_handle_destroy(avc->handle);
>                 if (avc->policydb)
>                         sepol_policydb_free(avc->policydb);
>                 free(avc);
> +               avc = NULL;
>         }
>         if (pf)
>                 sepol_policy_file_free(pf);
> --
> 2.27.0
>
