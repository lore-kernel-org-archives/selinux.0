Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDD8CC4332F
	for <selinux@archiver.kernel.org>; Mon, 21 Nov 2022 19:27:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbiKUT1T (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 21 Nov 2022 14:27:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231174AbiKUT1S (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 21 Nov 2022 14:27:18 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 498C78CBA4
        for <selinux@vger.kernel.org>; Mon, 21 Nov 2022 11:27:17 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id vv4so21570928ejc.2
        for <selinux@vger.kernel.org>; Mon, 21 Nov 2022 11:27:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8xBe62LwFyOA8e7YrsetIV9IsCE1W6NGFKZtAqD1qbI=;
        b=MJwyxWWUFpBHIIkKtMLtEjn3C3nr1jiveHYvRC7VnVN0ASxshLKXqWhLgELCXWkND/
         U8VXw28VJgkh/+kQIxnv3W4lqiuO6j3ACV4a2PauJ+KNUCaacLWSCgrQfcrJhTx1Sslj
         2SS/nTEMQG6iiP+T7oZ+xzO6pr1k7nMSbkn2RVyi5Q4nNW2WUE3nH0icqtSIRmDPoYIU
         JPOZF/rWgkOf8NpCWyehxEyreJP1M5Hf8LdJ+Fr5imovm/NlgI84W1occP8xmZGA1lm+
         9KH4IamDKKlFrz6yVQLipSN8rn0Gv2QXZGztas9km3Ctg0cfoL2dtb6HzGuJNb5meFSf
         CfIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8xBe62LwFyOA8e7YrsetIV9IsCE1W6NGFKZtAqD1qbI=;
        b=cEKLqbXgRJG1MAicOnc02nBBOBCXmbBnzZKMyFALRwH6OETmNnI4VwVJ2jfLYnAf5D
         MJHyg2me3mJN63KvneZeeoOpEvTKCxAvCY1H+RI7zWTfqKNO+qa9VJzohpPqFRlnuFMb
         JbGhABKAF6bO2JKF1ndMr6Li5REosHmOG4Z90Cq4YU2uHnFDDbUOk/UUMXmI1Mkjkl+r
         No4GhpVM9HO7uYFBlHQNnz0MSfygBpXgX/yoE30DMeJXqb5JbsyiynYIXzrjv3igu1WG
         eyUbesYbeIWh/ozLeLI+3byTRTwjSO5ZFtwGk8hobgsyCuhnUiFBMeuMcCnCpQF3L+IY
         SBTA==
X-Gm-Message-State: ANoB5plagbOlBE2q3c+kOlPKRtCbORZ6h8lSB29xx8ZdUiHG4mXu8B5t
        4eRWwVkZiPftqynQ3U7q670aK1j4PuuKVdDcLeY=
X-Google-Smtp-Source: AA0mqf49cwzQsZjgz1OzR3Jfli4xaz4241kgFW9KSAMWn0zRSaH4wcPn+3wv+0ae6P1vQw06GfT72CfTe+s0sN2lEpk=
X-Received: by 2002:a17:906:a148:b0:7ad:b286:8ee2 with SMTP id
 bu8-20020a170906a14800b007adb2868ee2mr16558490ejb.511.1669058835758; Mon, 21
 Nov 2022 11:27:15 -0800 (PST)
MIME-Version: 1.0
References: <20221121122947.2079109-1-lujie54@huawei.com>
In-Reply-To: <20221121122947.2079109-1-lujie54@huawei.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Mon, 21 Nov 2022 14:27:04 -0500
Message-ID: <CAP+JOzQ-tdxY5_f45WjV4cs=YUdYKqATo+QJ5Ueo5d_6-Ry05g@mail.gmail.com>
Subject: Re: [PATCH] libselinux: fix some memory issues in db_init
To:     Jie Lu <lujie54@huawei.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Nov 21, 2022 at 10:15 AM Jie Lu <lujie54@huawei.com> wrote:
>
> In db_init()
> add the interpretation of the return value of strdup()
> fix line_buf memory leak if process_line() < 0
> ---

You need to add a signed-off-by line. Everything else looks fine.
Thanks,
Jim

>  libselinux/src/label_db.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/libselinux/src/label_db.c b/libselinux/src/label_db.c
> index 94c05c6d..bd73201c 100644
> --- a/libselinux/src/label_db.c
> +++ b/libselinux/src/label_db.c
> @@ -293,6 +293,11 @@ db_init(const struct selinux_opt *opts, unsigned nopts,
>                 return NULL;
>         }
>         rec->spec_file = strdup(path);
> +       if (!rec->spec_file) {
> +                free(catalog);
> +                fclose(filp);
> +                return NULL;
> +       }
>
>         /*
>          * Parse for each lines
> @@ -322,18 +327,19 @@ db_init(const struct selinux_opt *opts, unsigned nopts,
>                 if (process_line(path, line_buf, ++line_num, catalog) < 0)
>                         goto out_error;
>         }
> -       free(line_buf);
>
>         if (digest_add_specfile(rec->digest, filp, NULL, sb.st_size, path) < 0)
>                 goto out_error;
>
>         digest_gen_hash(rec->digest);
>
> +       free(line_buf);
>         fclose(filp);
>
>         return catalog;
>
>  out_error:
> +       free(line_buf);
>         for (i = 0; i < catalog->nspec; i++) {
>                 spec_t         *spec = &catalog->specs[i];
>
> --
> 2.27.0
>
