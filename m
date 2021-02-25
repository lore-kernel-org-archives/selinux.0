Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E885C433E0
	for <selinux@archiver.kernel.org>; Thu, 25 Feb 2021 18:15:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A5FA64F03
	for <selinux@archiver.kernel.org>; Thu, 25 Feb 2021 18:15:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231335AbhBYSPx (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 25 Feb 2021 13:15:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231604AbhBYSPv (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 25 Feb 2021 13:15:51 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB1E2C061574
        for <selinux@vger.kernel.org>; Thu, 25 Feb 2021 10:15:09 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id g3so8071776edb.11
        for <selinux@vger.kernel.org>; Thu, 25 Feb 2021 10:15:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kARKYLR0rlQHE7+CKYucwKbsRbm32GeX0q6RXfy6ufE=;
        b=Y1ycZ3pIKleTp/X3gUQJ05LvyfQxzXa8IjjHVBqdle9Fba8jJoNFQr8d99sFOuzQY5
         coOBrynpbifFUqBRMLl2vpbyDr6PmfT7J/4/7ttLfO1nSAQJ8wNmYbL0y10cr4L0DyR8
         ieiHWL8pKSOkgTztZkPelt+vaow7bB4NrbVz6DYi87pTu72jgBLWKjLfnb1KYiG8CJ14
         aWVxfjQv5CrgSp1hP1O/od94q770Rpbj9L9sAxT3J7d6nUr0h/K9mi0M65BZaflUsf0r
         pJjdDipL5awjkR3lpUeJgTOTtGOadDLGzLIc7v4UyOo95eZ/IF32I3OiVSkzLyJ3tj+G
         An3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kARKYLR0rlQHE7+CKYucwKbsRbm32GeX0q6RXfy6ufE=;
        b=Pf18udx7Q4Dftjr2UbJ3DOF+GeNetLwP8m8yEedSKe2yKqr3fFelelCr7XRp4XrBys
         Ji0r4PtQLouKDZccLPKX84doWLr+7f2ODIOJVlu12hu1Z9+2KAvdFczFLQgNPgvRaOOU
         8ug810Ng0Lply+wcpNboQrvP5xIxhF/sWFo2VXrKy+kHOfv37+SJtEGBh5UbhGND3nQG
         2TiEDo1aKOj/RjpjDbZWaAAdG58RdlJOMSPEQ/yDU4hOKbv8olAB4z0Q6aO0nq8PMSnT
         WXP9GDRbIFnn8ZG000rM1VbkgrxbXC+YEpuzbvDvnZjJMOKUXnVNb3ujK3sWcqJCZI26
         Lc+w==
X-Gm-Message-State: AOAM5308zgvjir8TxqUowAVtOY7qkjbZwG0tdQEJTFusfFnXTJ7iZ+1b
        RZ2RbXY22UHPnxlrEM7aniRZU83RpxoZCtlG70Au
X-Google-Smtp-Source: ABdhPJwUPBYiGusXvIiy1Loq7YIbaeyY0d1zknNkR05LATJttSHU+djmvp+n674YDORlfKrwI06SbLMnZIMmVE8xeQA=
X-Received: by 2002:a05:6402:c96:: with SMTP id cm22mr4319127edb.128.1614276908300;
 Thu, 25 Feb 2021 10:15:08 -0800 (PST)
MIME-Version: 1.0
References: <20210212185930.130477-1-omosnace@redhat.com> <20210212185930.130477-2-omosnace@redhat.com>
In-Reply-To: <20210212185930.130477-2-omosnace@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 25 Feb 2021 13:14:57 -0500
Message-ID: <CAHC9VhQLJKjY0KSC+=f4b=8d8n-m29j_9J5r_VQ_1BpSY8WD2w@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] selinux: don't log MAC_POLICY_LOAD record on
 failed policy load
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     selinux@vger.kernel.org,
        Stephen Smalley <stephen.smalley.work@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Feb 12, 2021 at 1:59 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> If sel_make_policy_nodes() fails, we should jump to 'out', not 'out1',
> as the latter would incorrectly log an MAC_POLICY_LOAD audit record,
> even though the policy hasn't actually been reloaded. The 'out1' jump
> label now becomes unused and can be removed.
>
> Fixes: 02a52c5c8c3b ("selinux: move policy commit after updating selinuxfs")
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>  security/selinux/selinuxfs.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
> index 01a7d50ed39b..340711e3dc9a 100644
> --- a/security/selinux/selinuxfs.c
> +++ b/security/selinux/selinuxfs.c
> @@ -651,14 +651,13 @@ static ssize_t sel_write_load(struct file *file, const char __user *buf,
>         length = sel_make_policy_nodes(fsi, newpolicy);
>         if (length) {
>                 selinux_policy_cancel(fsi->state, newpolicy);
> -               goto out1;
> +               goto out;

This looks good, especially with AUDIT_MAC_POLICY_LOAD recording
"res=1".  However, now that I'm looking at the error path here, we
don't display anything if sel_make_policy_nodes() fails, do we?  If
security_load_policy fails we at least do a printk(), but if this
fails it silently kills the policy load; at the very least I think we
want a `pr_warn_ratelimited("SELinux: failed to load policy due to
selinuxfs failures")` or something similar.

>         }
>
>         selinux_policy_commit(fsi->state, newpolicy);
>
>         length = count;
>
> -out1:
>         audit_log(audit_context(), GFP_KERNEL, AUDIT_MAC_POLICY_LOAD,
>                 "auid=%u ses=%u lsm=selinux res=1",
>                 from_kuid(&init_user_ns, audit_get_loginuid(current)),
> --
> 2.29.2

-- 
paul moore
www.paul-moore.com
