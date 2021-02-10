Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FFEEC433DB
	for <selinux@archiver.kernel.org>; Wed, 10 Feb 2021 23:52:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DFF1A64DE3
	for <selinux@archiver.kernel.org>; Wed, 10 Feb 2021 23:52:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234165AbhBJXwC (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 10 Feb 2021 18:52:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234132AbhBJXvu (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 10 Feb 2021 18:51:50 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC719C0613D6
        for <selinux@vger.kernel.org>; Wed, 10 Feb 2021 15:51:09 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id jj19so7264787ejc.4
        for <selinux@vger.kernel.org>; Wed, 10 Feb 2021 15:51:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1M0KC3p1meyDQrYPzDqxypfZ2M1GwZFs8VgujKNOBPw=;
        b=UIZslfjRO/9DuoX7z8lTy1KL6HjZR0/5cZp7deUc8QMR5nfUEzG0dNExmyqkCF4f6y
         WLuSVQFYypxlJksG9emU4luaA9tYyJoc4XeLGX9vvp0DsPHPWlRAX08NmSH3Em3Npnzi
         i6iNNUSZb3Y+yXgHisVAAwJbuv/ojTbhWwRvsEwwHpBhA0zUx6WxjzQq0/7TJKZSE3AX
         5cDtGCSGgyeevLu7cFf9ClQ+7YMuvrqDjLA48QSG9YsoX308kU025vSB2l3zBylA/QGJ
         1rOrBJcb8cq9EkaHm8TzfDTNpHuTzvxKHvX//Us6R88Zkjh/sGRis+1qMIzrTukYe3p+
         Wgdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1M0KC3p1meyDQrYPzDqxypfZ2M1GwZFs8VgujKNOBPw=;
        b=fVCfVbioFSMTSlSHlQRLL/UaJVm3Oj07Y9DKRvZ6dw+YLw0LYDxqh26fZmQ4vXRaRI
         F9aINS9oRnXRKr62YGZYgND9TA715N5ldTJmGRQBqrevaTruLiszw7tqZjeG7SLAXgnS
         ZjIJy6S8WmGOqruBwEADXSQVPEBRFzDYqM6mS/Mv2HwCrL2NpyMoc68cnsJcWF1zExpq
         wCa3fSKOT9QHtBpJLn4ztJZzEThSibeVPZp9Kt4hlMxGvzgN0tde5BRGn0dZ753e414P
         8geZP9B/g6FFunhPJWW0JDdzj0+1nd6O5ugCCgeyVMpv4qn8VrW57bwpeZvbStmt3bYT
         z2JA==
X-Gm-Message-State: AOAM530UXrBpcvVNQEtQC+c8DPgGEAUCf4jjMtn0oOt8LyH90OjrIWHJ
        cKNQdTKSG0N3lXLF1PEGDHfyOtne2JGoBX87GeVg
X-Google-Smtp-Source: ABdhPJxbvum50dPhfmLT6PkFvr4im9qOS4UUgVDGP9cifAfcGFXDb/3Tanc5Hf/SztMBKxtZQyI0XsTmkWCqIuEM5Jk=
X-Received: by 2002:a17:906:8519:: with SMTP id i25mr5590393ejx.106.1613001068566;
 Wed, 10 Feb 2021 15:51:08 -0800 (PST)
MIME-Version: 1.0
References: <20210209200233.GF3171@redhat.com>
In-Reply-To: <20210209200233.GF3171@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 10 Feb 2021 18:50:57 -0500
Message-ID: <CAHC9VhQYE3ga53AiK2r-568_=2U0BJe+L4g9U_J0dLinzJqXYA@mail.gmail.com>
Subject: Re: [PATCH] selinux: Allow context mounts for unpriviliged overlayfs
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     selinux@vger.kernel.org, linux-unionfs@vger.kernel.org,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Daniel J Walsh <dwalsh@redhat.com>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Giuseppe Scrivano <gscrivan@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Feb 9, 2021 at 3:02 PM Vivek Goyal <vgoyal@redhat.com> wrote:
>
> Now overlayfs allow unpriviliged mounts. That is root inside a non-init
> user namespace can mount overlayfs. This was added in 5.10 kernel.
>
> Giuseppe tried to mount overlayfs with option "context" and it failed
> with error -EACCESS.
>
> $ su test
> $ unshare -rm
> $ mkdir -p lower upper work merged
> $ mount -t overlay -o lowerdir=lower,workdir=work,upperdir=upper,userxattr,context='system_u:object_r:container_file_t:s0' none merged
>
> This fails with -EACCESS. It works if option "-o context" is not specified.
>
> Little debugging showed that selinux_set_mnt_opts() returns -EACCESS.
>
> So this patch adds "overlay" to the list, where it is fine to specific
> context from non init_user_ns.
>
> Reported-by: Giuseppe Scrivano <gscrivan@redhat.com>
> Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
> ---
>  security/selinux/hooks.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

This seems reasonable, but since we are at -rc7 this week it will need
to wait until after the upcoming merge window.  It's too late in the
cycle for new features.

-- 
paul moore
www.paul-moore.com
