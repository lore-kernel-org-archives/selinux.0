Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE9D3C4332F
	for <selinux@archiver.kernel.org>; Wed, 23 Nov 2022 15:32:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238840AbiKWPcv (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 23 Nov 2022 10:32:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239114AbiKWPcW (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 23 Nov 2022 10:32:22 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A077758BDA
        for <selinux@vger.kernel.org>; Wed, 23 Nov 2022 07:32:10 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id b8so14546778edf.11
        for <selinux@vger.kernel.org>; Wed, 23 Nov 2022 07:32:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=aFN1kFJ+Jjx6OAU3r9N7vXnDyMpfnhmFuWCwaq889PI=;
        b=dYJw304YpRbWGmfXdhK1HAUwW4HxZ69DRnrIN0BMOxwf59IsSGjY22AO5RwJtVQGTc
         Ozoj3ckD1zwxu/Fw8ioWsGJArlFklej8S7ADSg64ERdNEcDMzDncW02uan8XPvU4k1AD
         BtWCv7yrnD/MV78eMcacTQew1ctpGIBujYCpD6V0gORr/Y3EheInPCbsPM4PpcwAWxoW
         zvfNMbBAf/SANfO6nOOk3eHkbYSYoiK1ZtqQPZeqT7ZahxbtqPWLuLnA/cdArw1u5lTZ
         oAxoZY+F776f7ehycCLD9mRjTlgNLZCJN9dOUrANJ3oy4ARW/ZpLq6y75mY1iSXCKv43
         2G1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aFN1kFJ+Jjx6OAU3r9N7vXnDyMpfnhmFuWCwaq889PI=;
        b=CJ2tZbHqlOjWZcJ7gdF+2PAP7lgQyEetMKOtUD/al+fjN5sR6T7GyxpA5zj/K7yaEJ
         n4ffL4VilpGCsERv7b+QJt5e50iD9fen5VZPkeId/YmQieRWF0UodY1RopmQHlYtAkVQ
         5FGxp+bQkzwPcOLG5g9xqf2IWQpWZsA6cFtsY1Y7H4/ydNNMY+t0H9R8reSyu96rfevh
         7QZZiFPFcj1j8dn7NnMBEISSAE67tFwD3GzTMltjnlMfo+FsiKFyEnG3loAULg3z3pFX
         vHn2fNG4gujkxIvRPJqsqtzUQPynJHTBvUsNHhLgDuopqqn4TmyHi8QyzauI+zL9FHSW
         FhOA==
X-Gm-Message-State: ANoB5pm1OtNBfFgG7MHSxwa6rsJn0UPP9yZUshDlUcHgkIIaQGGVfXru
        kiHv5EpWWzrbMZO6LdYLeryU+D+wMTt/x6ovQWusCGGbNMI=
X-Google-Smtp-Source: AA0mqf56jq3n3rmLpC3cKZl6YMvkqTm1Z+WdqK1RdjeZCxVCCUU5PtFu2AkdOZOEs+gHs4w8xZQhOCzD9oU7pr4jMe0=
X-Received: by 2002:a50:d09a:0:b0:46a:48de:c8d7 with SMTP id
 v26-20020a50d09a000000b0046a48dec8d7mr1308468edd.36.1669217528833; Wed, 23
 Nov 2022 07:32:08 -0800 (PST)
MIME-Version: 1.0
References: <20221122052110.2433833-1-lujie54@huawei.com>
In-Reply-To: <20221122052110.2433833-1-lujie54@huawei.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Wed, 23 Nov 2022 10:31:57 -0500
Message-ID: <CAP+JOzRJPWenEVwwNLSeqZEG7HExP0r3kPQC93VdpwAgMB-AOw@mail.gmail.com>
Subject: Re: [PATCH v2] libselinux: fix some memory issues in db_init
To:     Jie Lu <lujie54@huawei.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Nov 22, 2022 at 3:05 AM Jie Lu <lujie54@huawei.com> wrote:
>
> 1. check the return of strdup to avoid a potential NULL reference.
> 2. make sure line_buf is freed.
>
> Signed-off-by: Jie Lu <lujie54@huawei.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
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
