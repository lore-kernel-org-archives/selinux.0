Return-Path: <SRS0=Kf9N=CD=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABAF1C433E1
	for <selinux@archiver.kernel.org>; Tue, 25 Aug 2020 15:01:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 82CEB2075F
	for <selinux@archiver.kernel.org>; Tue, 25 Aug 2020 15:01:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gqNVhc0k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726351AbgHYPBZ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 25 Aug 2020 11:01:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726230AbgHYPBZ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 25 Aug 2020 11:01:25 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2550EC061574
        for <selinux@vger.kernel.org>; Tue, 25 Aug 2020 08:01:25 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id 5so7780554otp.12
        for <selinux@vger.kernel.org>; Tue, 25 Aug 2020 08:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Snxb+UgligIpU8k+EZ2wf7YV8lj+aJ7y1Oq+0nTSd24=;
        b=gqNVhc0kkK7iAKTbsccy0lCSdPo4Mt3HTLyjxTnwTIfJYvhirdcha9fxzWzrXeDRV1
         oyrvbB1mI4VY2YYcIPCZAfdsixXq0uX3JGuaNRZF9uZXXE/rKlBe7an3bbawGBbO/YoW
         XXlpm01h6Q01mF/5b+ZhoCdEFslLd6lgqMEyW6/MEVWpQK8nJDOGURZ5ugJLF4xkro2T
         f+c2Vi/C4aKbJbaHH9YIMLM4zLMabaftXcTR/3qOoY8Wz1Fo07eBhdVm8UTgR3ghcMTd
         fKwWJM8j6Z5YUqvoNxfwJGrydHg9uPIJ42ONDOjW/HkA++sCo0gFYd23ytgG1COqUqaV
         Xz2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Snxb+UgligIpU8k+EZ2wf7YV8lj+aJ7y1Oq+0nTSd24=;
        b=gOA55L0PDbsotW6TYAgHrbEi4SU16j2Y5F+yPTI4zERr6h3lqbAxQz9sEfq6fV8St0
         Cp1aoU0uJ2bH03Ktleb6zQII/KgKlsilGuhdkawrdBbzMB607EE8xDcKuRG069k5N0JB
         nPMuaywpLEveHySXRYYmgGhCvBmnqYx5fmvX/4kHOCIY0xNbjiliNpHPJetAd2+bN3+l
         kzqbCj/Ykf6KK7Xlm0DgzfmjayFV+Ivoht6zG7RlmXehLogkC+XKhcseylowr+U3SX8W
         bBSQdWC7e+/DGvjyaylbCSj2i1JxATb4890+fNQc86f/R1G5rvm1KMSGUa+s8gS2/Grh
         WV7g==
X-Gm-Message-State: AOAM531sf5aPqSTztgNWDb6ON0gqvtglc3J6/7TEycraE0s12du9jaJj
        0rTi79LWu8lxIfmb2urmq9vjzRfSmecYFvJEqwc=
X-Google-Smtp-Source: ABdhPJwQsqeQbRPjE7UppM5s9OFMYnP97/rs9AZ2FQwmBzaM6sRGJIR6odpk5VU9MGKFeKFrJB9HUBOifM+O9AyqnF8=
X-Received: by 2002:a05:6830:16d8:: with SMTP id l24mr6721215otr.89.1598367684494;
 Tue, 25 Aug 2020 08:01:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200825065953.1566718-1-omosnace@redhat.com> <20200825065953.1566718-2-omosnace@redhat.com>
In-Reply-To: <20200825065953.1566718-2-omosnace@redhat.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Tue, 25 Aug 2020 10:59:57 -0400
Message-ID: <CAEjxPJ4JKHKFgF9VobJTrMBDhaqC0EKorC=qfm=t77Krd-Npsw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] selinux: switch unnecessary GFP_ATOMIC allocs to GFP_KERNEL
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Aug 25, 2020 at 3:00 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> There seems to be no reason to use GFP_ATOMIC in these cases.
>
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>  security/selinux/hooks.c       |  6 +++---
>  security/selinux/ss/policydb.c | 10 +++++-----
>  security/selinux/ss/services.c |  4 ++--
>  3 files changed, 10 insertions(+), 10 deletions(-)
>
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 89d3753b7bd5d..4de962daffbde 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -6854,7 +6854,7 @@ static int selinux_lockdown(enum lockdown_reason what)
>
>         if (WARN(invalid_reason, "Invalid lockdown reason")) {
>                 audit_log(audit_context(),
> -                         GFP_ATOMIC, AUDIT_SELINUX_ERR,
> +                         GFP_KERNEL, AUDIT_SELINUX_ERR,
>                           "lockdown_reason=invalid");
>                 return -EINVAL;
>         }

Have you audited all callers of security_locked_down() to ensure that
they are never holding any locks around the call?  That's the only one
I saw that might be a problem now or in the future.

> diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
> index a48fc1b337ba9..fa61a54bc1440 100644
> --- a/security/selinux/ss/services.c
> +++ b/security/selinux/ss/services.c
> @@ -109,7 +109,7 @@ static int selinux_set_mapping(struct policydb *pol,
> @@ -2982,7 +2982,7 @@ int security_set_bools(struct selinux_state *state, u32 len, int *values)
>                 int old_state = newpolicy->policydb.bool_val_to_struct[i]->state;
>
>                 if (new_state != old_state) {
> -                       audit_log(audit_context(), GFP_ATOMIC,
> +                       audit_log(audit_context(), GFP_KERNEL,
>                                 AUDIT_MAC_CONFIG_CHANGE,
>                                 "bool=%s val=%d old_val=%d auid=%u ses=%u",
>                                 sym_name(&newpolicy->policydb, SYM_BOOLS, i),

Note that this one shouldn't be back-ported prior to my refactoring
patches because previously this was called while holding the policy
rwlock.
