Return-Path: <SRS0=r6Mn=CE=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FAC0C433DF
	for <selinux@archiver.kernel.org>; Wed, 26 Aug 2020 14:12:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A8C22078D
	for <selinux@archiver.kernel.org>; Wed, 26 Aug 2020 14:12:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XX2FTcI7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727781AbgHZOMC (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 26 Aug 2020 10:12:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726894AbgHZOL5 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 26 Aug 2020 10:11:57 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E548C061574
        for <selinux@vger.kernel.org>; Wed, 26 Aug 2020 07:11:56 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id z22so1639728oid.1
        for <selinux@vger.kernel.org>; Wed, 26 Aug 2020 07:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=d2RgNA89GOBkURUyK0kRhuN81qHz+7NV1KvEiyfexFY=;
        b=XX2FTcI7suegm8ovEMjpK4KgzfCtkrC3Xs5y9BhgMI9TYg6Js7Y2eVsKzO01Gj1bVq
         y7pdfV/F5RJ+Yp1uIkq9MSZ2WjyRnZz5VoLsvICwXCkCMJSPnP7OKvMcsOHn5Lt32OuZ
         ygncH4HxdOMEwmztm3p3V4YuJ19j5gh4ahn/CGgVn92eJ0l3RjDm8qrvaV/99jLVn4J8
         n69hcqboqyFPJ2/f0MrWQRqcXP1HxLMbWMg6iYT0MGwxmSA/tq+bPKzSEvv+qk4asRdy
         AtMVUxtsZGs9Iq8Qb/se37yE9+CRva0r/8bbUrSFQ00BEOdYuXsr6pRiC+/I1qrnPY7i
         TPBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d2RgNA89GOBkURUyK0kRhuN81qHz+7NV1KvEiyfexFY=;
        b=Pa3RpGuEpXma2/EPBcbtHkOrhF+nfk8LzOVbm6KilCYIxZUKgfom214BjqW3hHj/2j
         bvlw7Bn4NdWIQCzWZOo7rrJxajswHr0c/ovZ7EcDDpCDYDCfOYQGw/DQ4/CvH/f5PZFi
         VUzQSSYe40a+EjpxTjgWXoQu6Kk2BwF7s5Ee8laL++4H2L7wv8aJsE1Yz8k8gbt2kcDO
         qb+u2zWkpBsSQXDRqamRSAiN+GxwKcXlUxyL6EIpdbnl6BdXBZOesHvYUhjV6k5zSxrD
         wDC36KjVah33wdzKrmq8RpcRE6A8BEd1RLZ42mXpbROsSmLmLFMGoJb6allixRtwaZU4
         xtbw==
X-Gm-Message-State: AOAM533xcDrMyeUpjsoHvoQ0gd3Om3wSG7BgyKrDcM90qg1lokJVsaDA
        J1jVrorJ+MA3WbfKsnqBt9vhogn7e8y7r+cu+uw=
X-Google-Smtp-Source: ABdhPJx0adqKF47kFHIRLZq5o20I8A0fbYsZjlnKdyFoqHePjGHteWYII/PazX39xdjmEVNk8esDl7DSof0DZcePJao=
X-Received: by 2002:a05:6808:310:: with SMTP id i16mr3097645oie.160.1598451115905;
 Wed, 26 Aug 2020 07:11:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200826135906.1912186-1-omosnace@redhat.com> <20200826135906.1912186-3-omosnace@redhat.com>
In-Reply-To: <20200826135906.1912186-3-omosnace@redhat.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Wed, 26 Aug 2020 10:11:45 -0400
Message-ID: <CAEjxPJ7V3XW+wCVpNUitD_cc2GoVjM0mm-zWrDWcxLd7wcv_Eg@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] selinux: eliminate the redundant policycap array
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Aug 26, 2020 at 9:59 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> The policycap array in struct selinux_state is redundant and can be
> substituted by calling security_policycap_supported().
>
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---

> diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
> index 7cc2f7486c18f..e82a2cfe171f3 100644
> --- a/security/selinux/ss/services.c
> +++ b/security/selinux/ss/services.c
> @@ -2113,30 +2113,6 @@ bad:
>         return 0;
>  }
>
> -static void security_load_policycaps(struct selinux_state *state,
> -                               struct selinux_policy *policy)
> -{
> -       struct policydb *p;
> -       unsigned int i;
> -       struct ebitmap_node *node;
> -
> -       p = &policy->policydb;
> -
> -       for (i = 0; i < ARRAY_SIZE(state->policycap); i++)
> -               state->policycap[i] = ebitmap_get_bit(&p->policycaps, i);
> -
> -       for (i = 0; i < ARRAY_SIZE(selinux_policycap_names); i++)
> -               pr_info("SELinux:  policy capability %s=%d\n",
> -                       selinux_policycap_names[i],
> -                       ebitmap_get_bit(&p->policycaps, i));
> -
> -       ebitmap_for_each_positive_bit(&p->policycaps, node, i) {
> -               if (i >= ARRAY_SIZE(selinux_policycap_names))
> -                       pr_info("SELinux:  unknown policy capability %u\n",
> -                               i);
> -       }
> -}
> -

Two requests:
1. Can you do a little benchmarking to confirm that calling
security_policycap_supported() each time doesn't cause any significant
overheads?  Networking benchmark might be of interest.

2. Can you retain the logging of the policy capability values?  Just
drop the first part of the function and rename it e.g.
security_log_policycaps().
