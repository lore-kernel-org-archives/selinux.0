Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D58B3C433E0
	for <selinux@archiver.kernel.org>; Mon, 22 Feb 2021 20:10:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A7ED464E2E
	for <selinux@archiver.kernel.org>; Mon, 22 Feb 2021 20:10:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbhBVUKd (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 22 Feb 2021 15:10:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbhBVUKc (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 22 Feb 2021 15:10:32 -0500
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7DF0C061574
        for <selinux@vger.kernel.org>; Mon, 22 Feb 2021 12:09:52 -0800 (PST)
Received: by mail-oi1-x22f.google.com with SMTP id w1so15353254oic.0
        for <selinux@vger.kernel.org>; Mon, 22 Feb 2021 12:09:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=SzkyZehzTSLqsJhUv3yKceNO3DNALtsq9IxZjINymFc=;
        b=BI26s7D4A5HG6+kUNv0juvE+j2dMUhATS/QpZgFZvUGgtjgNDBBW/qYrAhNrOmIGdk
         c9lqpqAXXtWgFQOsITwN2CNromaAxbUb9243nukyfmamMFEW/pRFTrLJlRdMiDyoGF+z
         cnPkrQyH893/9LvkF7u/t0ie4286xEXILBqEKInWSn4C3dSSndeGOB/7vWw/0km4Vkki
         NxghwQ/EYXQOCtFgnxS3lfNNf7cEiiFX1/DT0KCj7Klm8oprnXDKSb4rt9wyV17ZXqsT
         F4UK0cQI2AMipq4npomniSVqP8xrWT2S/hREq1za2aSnSRGkBOWJytt7Y4UoK6T/gT9+
         YoBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=SzkyZehzTSLqsJhUv3yKceNO3DNALtsq9IxZjINymFc=;
        b=hYSK7qjgSd0pAu6e2P9PsMT1f8Pwf6jcZ8UHzFKZdvIo1sxgmJKTyfz7IOG9HTyF78
         Wzt3BIkhzni1E+IrfFm3zJv3mZgFdnOSTmgEEigYNmlIIINkXkxufo0tPHXwRdypJjB+
         BIS7VENCEcSoTfDW4y7e4GDodMmOhJhE88zN8WPrponhVQfiu8tENhU4zQiwQU1N+Dez
         ymyFQZ+MRuxkU1nzYXEFBbyk/ZI6+NhJkBJvRVZlpRSwxst6i/92LB5WR0Ox940qzqhZ
         G4OVxSS2qCfNVP40FLCidSfltqMdlBj5AHT99DfrtZpo8Q0ZXR5eRfmYUZk8q75sjWIN
         50kQ==
X-Gm-Message-State: AOAM532ByzwJqkuHPwXzB6x83Zlfza032pmSsr4UXWuRY8e/BWq/XSlz
        YRFkzvCzdvw1GynoNrb30K+qghz0yuFhDRUbLF5oW+Ns/P+/aA==
X-Google-Smtp-Source: ABdhPJyiK+6eRvPAGEx2nISVU2MH3sQ6k5vKVEHwRWJzdRcWWUwfBXK72tqXcEk1JRB+dm3NNfepWqCkY+F7xQeYycM=
X-Received: by 2002:a05:6808:130c:: with SMTP id y12mr17055577oiv.128.1614024592194;
 Mon, 22 Feb 2021 12:09:52 -0800 (PST)
MIME-Version: 1.0
References: <20210220190806.22139-1-cgzones@googlemail.com>
In-Reply-To: <20210220190806.22139-1-cgzones@googlemail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Mon, 22 Feb 2021 15:09:41 -0500
Message-ID: <CAP+JOzQCP4XzGZ57o8zixzWQzEsn-7AiqV7Db6tGQp7sanRKfA@mail.gmail.com>
Subject: Re: [PATCH] libsepol/cil: handle SID without assigned context when
 writing policy.conf
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Sat, Feb 20, 2021 at 2:13 PM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> CIL permits not assigning a context to a SID, e.g. to an unused initial
> SID, e.g. 'any_socket'.
>
> When using the example policy from the SELinux Notebook,
> https://github.com/SELinuxProject/selinux-notebook/blob/main/src/notebook=
-examples/cil-policy/cil-policy.cil,
> secilc logs:
>
>     No context assigned to SID any_socket, omitting from policy at cil-po=
licy.cil:166
>
> But secil2conf segfaults when writing the policy.conf:
>
>     ../cil/src/cil_policy.c:274:2: runtime error: member access within nu=
ll pointer of type 'struct cil_context'
>
> Only print the assigned context if actually available.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libsepol/cil/src/cil_policy.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/libsepol/cil/src/cil_policy.c b/libsepol/cil/src/cil_policy.=
c
> index 30d507f1..863636c7 100644
> --- a/libsepol/cil/src/cil_policy.c
> +++ b/libsepol/cil/src/cil_policy.c
> @@ -1661,7 +1661,9 @@ static void cil_sid_contexts_to_policy(FILE *out, s=
truct cil_list *sids, int mls
>         cil_list_for_each(i1, sids) {
>                 sid =3D i1->data;
>                 fprintf(out, "sid %s ", sid->datum.fqn);
> -               cil_context_to_policy(out, sid->context, mls);
> +               if (sid->context) {
> +                       cil_context_to_policy(out, sid->context, mls);
> +               }
>                 fprintf(out,"\n");
>         }
>  }
> --
> 2.30.1
>
