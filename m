Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44D97C4743C
	for <selinux@archiver.kernel.org>; Mon, 21 Jun 2021 20:55:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1ECCA6102A
	for <selinux@archiver.kernel.org>; Mon, 21 Jun 2021 20:55:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230102AbhFUU5S (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 21 Jun 2021 16:57:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbhFUU5R (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 21 Jun 2021 16:57:17 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C86AC061574
        for <selinux@vger.kernel.org>; Mon, 21 Jun 2021 13:55:02 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id r16so8889208oiw.3
        for <selinux@vger.kernel.org>; Mon, 21 Jun 2021 13:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=UHGxG6rJ89D+/o5PGwBR/oKs9iLhOJuggkfDscgQo6U=;
        b=gLZ45B8Ij8YAUApeQflTFlzJo1j5snnvPJUu7ymsyQkex3CMvg6P8qeZLbK+lAHYZ3
         +FLfjwcpqA1Z+k8dj2cp8pfZWFOT4r+N3y1IJh2uXS8yHW2dZDJy+cO1OvQQDD0pJh3X
         TU/b7fltJTp/zBDqrLkBILAOWJEO0jjTbpo+gGAqHt+g47TgX7xNNMU5IK01HFaajvOy
         Z6odSzYWY6Eaun6ilSaBL9pIwfVqJt5QOobs7DmLsttWlJlaGh4dfecxniOezBtGT4Jo
         BAkV2kQMDeugdpOZvEmPbUHmYIGrReDg10bd8LzqpqOUnmLgnafpWIbhLCLTxBRrsB7N
         93FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=UHGxG6rJ89D+/o5PGwBR/oKs9iLhOJuggkfDscgQo6U=;
        b=CMT+uZhTQcNM+Etb40GE35akzDS9+sZZIR46vemhyDcEiBwWrzN/jlT/hdB7ySzGpN
         wsBvJ2/ieWpMQz8ep8EBKzjg0V1Uw1BaGzVRVqAjk2+qPrh6p9Ii2jl4P0j/SiNi2w8F
         kAmR/eUTLbZp1RcVSY57aACUwakwGVDxGZq7AipuoXnybpPRN90lzeRxSfxOx79DVPDz
         oawNjRjstovP4Jy7ic/gfrulA8DPvboFld1HyNZmqNBL9ulBxMR29nGGg7E40cdQNZJu
         rmDVctPAZ9PXs6YhS7Ggk5pbYn0wLtF7R7QzAPf/yCZn8fKw3Pywkp3eAhmDbw6c8JVq
         ZCMQ==
X-Gm-Message-State: AOAM530NUmZp6g+KiCxaO+K+cxZzZzyKmG0iaaduPF2Dt8+R33ffm4WF
        /HTmJ4zod78CJS1nyMGuhDciVId8KkILTbdFg/U=
X-Google-Smtp-Source: ABdhPJxgSixJwUkGWBD0jZc9r0Z9coX5WVIMBh9viypx/KV5/3lAAw0NfpINGlPbr45bRXUyTFcjjo1kBLeJzKcZOAI=
X-Received: by 2002:aca:1c0d:: with SMTP id c13mr282595oic.128.1624308902060;
 Mon, 21 Jun 2021 13:55:02 -0700 (PDT)
MIME-Version: 1.0
References: <20210608155912.32047-1-cgzones@googlemail.com> <20210608155912.32047-21-cgzones@googlemail.com>
In-Reply-To: <20210608155912.32047-21-cgzones@googlemail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Mon, 21 Jun 2021 16:54:51 -0400
Message-ID: <CAP+JOzTYkJHj++TfdM=BQw6cbwocxkPRKXn5PU2GZn6NfbMxYQ@mail.gmail.com>
Subject: Re: [PATCH 20/23] libsepol: drop repeated semicolons
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Jun 8, 2021 at 12:00 PM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libsepol/src/kernel_to_cil.c | 2 +-
>  libsepol/src/module.c        | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/libsepol/src/kernel_to_cil.c b/libsepol/src/kernel_to_cil.c
> index 17b5ebf0..238a2483 100644
> --- a/libsepol/src/kernel_to_cil.c
> +++ b/libsepol/src/kernel_to_cil.c
> @@ -1050,7 +1050,7 @@ static char *cats_ebitmap_to_str(struct ebitmap *ca=
ts, char **val_to_name)
>         p =3D catsbuf;
>
>         *p++ =3D '(';
> -       remaining--;;
> +       remaining--;
>
>         range =3D 0;
>         ebitmap_for_each_positive_bit(cats, node, i) {
> diff --git a/libsepol/src/module.c b/libsepol/src/module.c
> index 836da308..9b53bc47 100644
> --- a/libsepol/src/module.c
> +++ b/libsepol/src/module.c
> @@ -82,7 +82,7 @@ static int policy_file_length(struct policy_file *fp, s=
ize_t *out)
>                 break;
>         case PF_USE_MEMORY:
>                 *out =3D fp->size;
> -               break;;
> +               break;
>         default:
>                 *out =3D 0;
>                 break;
> --
> 2.32.0
>
