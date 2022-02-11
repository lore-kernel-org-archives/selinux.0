Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 820ECC433EF
	for <selinux@archiver.kernel.org>; Fri, 11 Feb 2022 21:52:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353816AbiBKVwF (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 11 Feb 2022 16:52:05 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbiBKVwE (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 11 Feb 2022 16:52:04 -0500
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFACBC66
        for <selinux@vger.kernel.org>; Fri, 11 Feb 2022 13:52:02 -0800 (PST)
Received: by mail-oi1-x235.google.com with SMTP id u3so11036306oiv.12
        for <selinux@vger.kernel.org>; Fri, 11 Feb 2022 13:52:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/zMHgb4OkHICAftWY8AkhC5byLykgutCMKxv0XmdckI=;
        b=DgQTha+IKEfKa5O0p4APjtub9QhebLov9U25I9JXEOHGJg5C57pfdV+pRZKI8X77Dj
         Hpu+JG/S/q7UhWM45bHKa8q0A+j1AQD2UbVTUmkV/gWrmrl7GaslNUSVDGvXynz8b8oe
         0e0kAFZkkJPchQ6qY4E6KuTRZzpswjRaIWG7IlwZbPzuTHIvBW2umnnevictUf9lnKPN
         FfP269vUcl4suQQK0sYV65wQ5b17G8wd4Bss0+ZThpKnFtv3/ShSclwPC+kAoq1rwLMx
         92xAn2reXRYarLm2sHqMYlIqpk7dowduoO++w/VyaKZ0agrBzq2fZfxaOoR32PPSJq5d
         BlIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/zMHgb4OkHICAftWY8AkhC5byLykgutCMKxv0XmdckI=;
        b=RNQFf7m64jepgHRsltLDLI5LzkMaqxwXon8UvaJhnkInjFyndpoTVpFoYLZReyoZvt
         TGcpl7Y9Doco7hE6ASc5x1zn/egGiZUfOc3TK4uAZPvZkLLoRaN6Z/4LzgBQahJaPkSL
         ZmkaJZI5miPjtesRWiNh+Lt1qUivYmEsJCcoeLWHPQUI+6nc96KnrHFBHKc8jt4GSJ+a
         jEOEoTniombDO2aIjsmNM66az3iLTq0p0RBixqzMm0SyEP58pIz0jg5RJ6WJxenRYKHP
         yYRONYDIebxmCijsczmpEQgUD3u0tnwkwfSFXOJePfez319BwkjIxgVYYpxu67nH61Cs
         NI1g==
X-Gm-Message-State: AOAM530Wntqj5G7G2NaNHp9voU9CWbswHqKmU5I6wbhAbf3FmIru9GZ9
        z2DKcyFJrnMKALPNKRMY3FLI56eAFu0TiQ08FwL3oseCP1g=
X-Google-Smtp-Source: ABdhPJxKOotcBDHd03S8jRd+nQ/bn7nM2zCqr7k2bWAcIaZpv1/GuYPWM0RRXfz8kl3fGBBl/35DO2F8E0e96oW62IE=
X-Received: by 2002:a05:6808:1147:: with SMTP id u7mr1158235oiu.189.1644616322289;
 Fri, 11 Feb 2022 13:52:02 -0800 (PST)
MIME-Version: 1.0
References: <20220203165327.213601-1-omosnace@redhat.com> <20220203165327.213601-2-omosnace@redhat.com>
In-Reply-To: <20220203165327.213601-2-omosnace@redhat.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Fri, 11 Feb 2022 16:51:51 -0500
Message-ID: <CAP+JOzSQA4+jjBboSmVOFKnc+r5m6TC3_rOrn=m1Tk_r0Bo7cA@mail.gmail.com>
Subject: Re: [PATCH userspace v2 1/6] libsemanage: add missing include to boolean_record.c
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Feb 4, 2022 at 3:46 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> It uses asprintf(3), but doesn't directly include <stdio.h> - fix it.
>
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>

For this series:
Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libsemanage/src/boolean_record.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/libsemanage/src/boolean_record.c b/libsemanage/src/boolean_record.c
> index 95f3a862..40dc6545 100644
> --- a/libsemanage/src/boolean_record.c
> +++ b/libsemanage/src/boolean_record.c
> @@ -7,6 +7,9 @@
>   */
>
>  #include <string.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +
>  #include <sepol/boolean_record.h>
>
>  typedef sepol_bool_t semanage_bool_t;
> @@ -20,7 +23,6 @@ typedef semanage_bool_key_t record_key_t;
>  #include "boolean_internal.h"
>  #include "handle.h"
>  #include "database.h"
> -#include <stdlib.h>
>  #include <selinux/selinux.h>
>
>  /* Key */
> --
> 2.34.1
>
