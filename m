Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C04B7C433EF
	for <selinux@archiver.kernel.org>; Fri, 24 Sep 2021 13:29:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2B4361039
	for <selinux@archiver.kernel.org>; Fri, 24 Sep 2021 13:29:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346464AbhIXNbE (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 24 Sep 2021 09:31:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345335AbhIXNan (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 24 Sep 2021 09:30:43 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC8B1C110F30
        for <selinux@vger.kernel.org>; Fri, 24 Sep 2021 06:08:43 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id b20so40376506lfv.3
        for <selinux@vger.kernel.org>; Fri, 24 Sep 2021 06:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a1wyzBqCLIC20jDXoxBJUmnJwUjV93Wso11c0h6kOSU=;
        b=h3KjKDg+v1qWS9ml5kzy2jUL9ekfqyU4JfFGdcjZPaqRMqNber2nV6LGxOmszMnbKT
         cy3pdmRw2jWRlsadqjGXV5rBy2kSgQI0fuVH/5OdzSlRj4oKgGvsDm8G2CxYRkT3v/jQ
         z5MZ6VJX8BjFPGTOfFUpjiP4J4Qci2zaDy+yahCO9I/tNzqNSSUvyFDYtYMZcAWra63P
         sdKLdfzqwuePnAX9MPLOGLSfyJd+AQmHIOoCrnTfuva0Jvkvpf9CtueZPCZfWWBiOBiX
         txo7nVplBArwfIpPr8qaJwFy5KCx0HYZpUoJ0nPFNiAFnxzGJVLXWPePx88gDG1mAy6E
         nIew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a1wyzBqCLIC20jDXoxBJUmnJwUjV93Wso11c0h6kOSU=;
        b=RqodQBYaJxbZSjyo9jWvTmD9x8kkigqOS1nbxzs2OeyPyP3fvRZbDUoCDl6o4mQG/y
         MC8BN29B0k9jZTqIHmC/CWzlV/U9hAL/PoYF9frvIvKHXmAffTXG5EPZ44CiTM8nWBHw
         hTRv5tU1hItTrsKmiwFDnIkEV0PUX4p8PnM/HkZSDhvOZSw9PgqTAER7GN12hGeoQnk9
         DgB1i6hl0zOwoSRx7ktk2pSiOM5DsjoYks5C/Nww6YN3fJbwBg7Z97OPPv7OV65nF0dU
         YsbOSot1bwT/M3aWfel0/ZJXgVvapWYfmYf9yz6jUghgIanvS+ml86fjaSxwz3+Ae4wg
         eTVw==
X-Gm-Message-State: AOAM5329cI0iCZReh15n1x5QS5s2URIeHJbiDwkczBrU5J/Jl/cLftKP
        Wuyfv9tx/yls61B2TNPZKJnQ4U63T5pfGpKq0goHZ8pK
X-Google-Smtp-Source: ABdhPJyfWKJ8kYRzHhF9mFRf/Nzrdu2Gx+x4SQp13rpOwmH5eLSIVqLFUkpFQKRPu6Ib0yDxsUtnmvXPqGdcF+DgKRY=
X-Received: by 2002:a05:6512:360e:: with SMTP id f14mr9357556lfs.646.1632488922068;
 Fri, 24 Sep 2021 06:08:42 -0700 (PDT)
MIME-Version: 1.0
References: <163243191040.178880.4295195865966623164.stgit@olly>
In-Reply-To: <163243191040.178880.4295195865966623164.stgit@olly>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Fri, 24 Sep 2021 09:08:30 -0400
Message-ID: <CAEjxPJ5pxox=oE0TxmEFA-PkFGPDbAjtK_nqM3y-xaT0e3or0w@mail.gmail.com>
Subject: Re: [RFC PATCH] selinux: use SECINITSID_KERNEL as the subj/obj in the
 lockdown hook
To:     Paul Moore <paul@paul-moore.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Sep 23, 2021 at 5:18 PM Paul Moore <paul@paul-moore.com> wrote:
>
> The original SELinux lockdown implementation in 59438b46471a
> ("security,lockdown,selinux: implement SELinux lockdown") used the
> current task's credentials as both the subject and object in the
> SELinux lockdown hook, selinux_lockdown().  Unfortunately that
> proved to be incorrect in a number of cases as the core kernel was
> calling the LSM lockdown hook in places where the credentials from
> the "current" task_struct were not the correct credentials to use
> in the SELinux access check.
>
> Attempts were made to resolve this by adding a credential pointer
> to the LSM lockdown hook as well as suggesting that the single hook
> be split into two: one for user tasks, one for kernel tasks; however
> neither approach was deemed acceptable by Linus.
>
> In order to resolve the problem of an incorrect SELinux domain being
> used in the lockdown check, this patch makes the decision to perform
> all of the lockdown access control checks against the
> SECINITSID_KERNEL domain.  This is far from ideal, but it is what
> we have available to us at this point in time.
>
> Fixes: 59438b46471a ("security,lockdown,selinux: implement SELinux lockdown")
> Signed-off-by: Paul Moore <paul@paul-moore.com>
>
> --
>
> NOTES: While trivial, this patch is completely untested; I'm posting
> this simply to see what comments there may be within the SELinux
> community to such an approach as the current code is flawed and needs
> to be corrected.
> ---
>  security/selinux/hooks.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 6517f221d52c..4f016a49e3a6 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -7016,7 +7016,7 @@ static void selinux_bpf_prog_free(struct bpf_prog_aux *aux)
>  static int selinux_lockdown(enum lockdown_reason what)
>  {
>         struct common_audit_data ad;
> -       u32 sid = current_sid();
> +       u32 sid = SECINITSID_KERNEL;
>         int invalid_reason = (what <= LOCKDOWN_NONE) ||
>                              (what == LOCKDOWN_INTEGRITY_MAX) ||
>                              (what >= LOCKDOWN_CONFIDENTIALITY_MAX);

Kind of begs the question of whether it is even worth keeping the check at all.
This could potentially break an existing policy where lockdown has
been defined and only allowed as needed but I suspect it is already
allowed in Fedora and Android.
