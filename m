Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B06EFC433FE
	for <selinux@archiver.kernel.org>; Tue, 14 Dec 2021 22:59:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235157AbhLNW7e (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 14 Dec 2021 17:59:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235047AbhLNW7d (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 14 Dec 2021 17:59:33 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F054C06173E
        for <selinux@vger.kernel.org>; Tue, 14 Dec 2021 14:59:33 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id z9so13401754edb.5
        for <selinux@vger.kernel.org>; Tue, 14 Dec 2021 14:59:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=khVptH+M0tfn36lg9TBFDzwD3VeLdbUmAWzNh6/qLO0=;
        b=rJsbXgWLM3XVCagULFVF8jOXjqBhzFe4TGokRhLqIumiOWwYYAWMmkeXiQHhYh/Ihf
         51DpW6Wy6mANL4BR0LqusesI0F4cnrPBmfX05RyU5zKCDTmvKz6+dXRrKgr7UXT+EAzl
         yyuMhzhNCFa7hH5IPayUhM6IFvXZCyKqkUgv5yGFBp4S4NOOVGrj0w3JakoeSbKSqpqP
         tVfDPb7ltetkGxdOSPgrdFnVh/aUB71mp0fhrp+OZbdMRIDlfVHecvoHt28yMo/vzH6I
         HTHwDxd8BFGTI7OnhucdsHJ/+2D8S5rtq+McqwUgqd1aaI3peOFv0MPOIPI5qAaoLs7t
         nyzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=khVptH+M0tfn36lg9TBFDzwD3VeLdbUmAWzNh6/qLO0=;
        b=d0f9HZrfkcpr+JtYn8vphmlJTUzkKakhTEa9tHNAm9yAVIw6B/3sbh/jQEygwPh1od
         C9zhQjx3boCwcMdlCznYKE3/GqQw4y1JkfdZf3ljktSB/AN88eUFYWI7IkczmGwhQ4Go
         XQdS+ZjT1KqONEF7aFsb9ufJKWbfz4927zRf+HHJ0gz5b7RkB0KD2f1mNtMQy32q4PxG
         Gng6Hvr1pmPfjHfR8BmgsFwBgdykQVlyMGwXrdHz6g/UBwIIGkpMdO8S4eCBZ31bZ+oT
         Gc49mnM9tGFBf13c0p0EbouwTtDxv4hwYp78Fo5IWlodgy7yi9fUCe4TGBqAAoHbB1cj
         jPXg==
X-Gm-Message-State: AOAM532PYrfNqhQA4T5GOe0MItUhcnBYfuMP70izfTGLZQVsJFl7ANsx
        RtThXDi4f23X+XPAMpOWyi5WHmTmB9h1gUP/+Pu95VB+wg==
X-Google-Smtp-Source: ABdhPJwDaxZJiRGG8M2ITTDZmRyH/uAtqgn33PJ7PGjh9HnVGALZ16WyupWf4FRPUBGuiIBz54Ny1EOXpoRuxkdI4bk=
X-Received: by 2002:a05:6402:520e:: with SMTP id s14mr11437825edd.213.1639522772037;
 Tue, 14 Dec 2021 14:59:32 -0800 (PST)
MIME-Version: 1.0
References: <tencent_D0F3F07E25927F681055E6A35C038E168A07@qq.com>
In-Reply-To: <tencent_D0F3F07E25927F681055E6A35C038E168A07@qq.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 14 Dec 2021 17:59:21 -0500
Message-ID: <CAHC9VhRa3H7_CxP_pTsXPgmkTt908k6epMUaK84-FWyvikofpA@mail.gmail.com>
Subject: Re: [PATCH] selinux: check the return value of audit_log_start()
To:     xkernel.wang@foxmail.com
Cc:     stephen.smalley.work@gmail.com, eparis@parisplace.org,
        selinux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Dec 14, 2021 at 1:20 AM <xkernel.wang@foxmail.com> wrote:
>
> From: Xiaoke Wang <xkernel.wang@foxmail.com>
>
> audit_log_start() returns audit_buffer pointer on success or NULL on
> error. It is better to check the return value of it so to prevent
> potential memory access error.

The audit_log_start() function can return NULL in normal use, it does
not always indicate an error; returning NULL simply indicates that no
auditing should be done for this particular instance, e.g. an audit
filter is excluding the record.  Further, there is no potential memory
access error as the audit_log_*() functions are designed to accept a
NULL audit_buffer and return without error.

There have been some cases where we check for a NULL audit_buffer and
skip the following audit_log_*() calls, but that is typically in
performance critical code where the additional function calls would
have an impact (small as they might be).  In the case below, this is
not a critical code path, it is an error path, and here I would rather
have the code as it currently stands; I believe it is cleaner and
easier to read this way.

Regardless, thank you for taking the time to submit a patch.

> Signed-off-by: Xiaoke Wang <xkernel.wang@foxmail.com>
> ---
>  security/selinux/ss/services.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
>
> diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
> index e5f1b27..759d878 100644
> --- a/security/selinux/ss/services.c
> +++ b/security/selinux/ss/services.c
> @@ -3277,11 +3277,13 @@ int security_sid_mls_copy(struct selinux_state *state,
>                                 ab = audit_log_start(audit_context(),
>                                                      GFP_ATOMIC,
>                                                      AUDIT_SELINUX_ERR);
> -                               audit_log_format(ab,
> -                                                "op=security_sid_mls_copy invalid_context=");
> -                               /* don't record NUL with untrusted strings */
> -                               audit_log_n_untrustedstring(ab, s, len - 1);
> -                               audit_log_end(ab);
> +                               if (ab) {
> +                                       audit_log_format(ab,
> +                                                       "op=security_sid_mls_copy invalid_context=");
> +                                       /* don't record NUL with untrusted strings */
> +                                       audit_log_n_untrustedstring(ab, s, len - 1);
> +                                       audit_log_end(ab);
> +                               }
>                                 kfree(s);
>                         }
>                         goto out_unlock;

-- 
paul moore
www.paul-moore.com
