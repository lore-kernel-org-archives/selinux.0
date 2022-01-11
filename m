Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9945C433F5
	for <selinux@archiver.kernel.org>; Tue, 11 Jan 2022 14:18:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241089AbiAKOSz (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 11 Jan 2022 09:18:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241433AbiAKOSy (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 11 Jan 2022 09:18:54 -0500
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3735C06173F
        for <selinux@vger.kernel.org>; Tue, 11 Jan 2022 06:18:54 -0800 (PST)
Received: by mail-yb1-xb29.google.com with SMTP id j83so47820695ybg.2
        for <selinux@vger.kernel.org>; Tue, 11 Jan 2022 06:18:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pfzYkqLK9xVF6ORcrhKybyEnzLMeefVDPl0TLduuDpg=;
        b=Zl8Dw+yqW04tAxhUWYnlqBVRZeyYNsMn+ZY9DBAZA5eSPYIo5/Y6tYeJBvb54KK+vt
         Nq/+3pcRl7Merr1zZNn4UZAZrZEQ3apFD9+kwbRam1WQshqotDuAozmL/DXQ7X5/BI7H
         YhbH6OJK04e/CbQ/uNkJdmYTVLA7XujMbTTKF8c8qAHjSImOuqiEzYaaFtrqoq080EON
         utSSEfD/HhvqWKDiv5/eVfcyeEbBG2ebMwbctC4mIIkITBLj/ulG18gACSFnChKYRiDr
         jR7fWGKMVbxb5Y/NN2XH2Q+8USwPxWmVx/imjnQzmDZt3hWt5H9fxrx50vUVpOctD3cM
         O20A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pfzYkqLK9xVF6ORcrhKybyEnzLMeefVDPl0TLduuDpg=;
        b=AUvkEktIaT1Tl9DNM7xILC8OUS32rsFC7o0s1GPT3k5UI1uiGsfuEcVym15pvR4UDX
         NXHrG6LavehGn5KZHkbP0VdmDcFeurlq60vBDmK/efZny2kd08s7kSPVSW4ISmrQMV/9
         GBaMYTIo8hrxvP+Fri07NjAbgsuMmqX4ICHpJXv8cXVqfFdf0ydh39qWF7S6e/vTGWu/
         gU1MAFnXGeeJ2sEa4ysjtbLlqbOxXXVHobEI6Qn4UTrMoiLOEu3AVoljiET4u11D4PfD
         aoIVW7rpysSdYq/2x2OOmbMQn7BaXleGX33Ej1TuZh9v7fQAn27Kid+GKJ/ZioB5Fbmx
         lyDA==
X-Gm-Message-State: AOAM530D1aZbEQ37AKpL7Al+nCR9GaTFvwwgfowEiBT6Zdcotg53Xje8
        3yJIUNLp28YODPvTW9zb2PCFFN/zfw18BCc3o+9KFgB8mbM=
X-Google-Smtp-Source: ABdhPJzwcvUOaeAO3fxlfH2sSklu/pydAs/R4JsGHTZ58VnKGRMzYot9Go0d39S5WPIR6XQ0nH63y8rpnv2GHWG5I40=
X-Received: by 2002:a25:c691:: with SMTP id k139mr6110179ybf.327.1641910733899;
 Tue, 11 Jan 2022 06:18:53 -0800 (PST)
MIME-Version: 1.0
References: <20220110173527.582954-1-vmojzis@redhat.com>
In-Reply-To: <20220110173527.582954-1-vmojzis@redhat.com>
From:   William Roberts <bill.c.roberts@gmail.com>
Date:   Tue, 11 Jan 2022 08:18:42 -0600
Message-ID: <CAFftDdqxdrfp2ekq8feF4+naYUwf1=c1anu5-i9hpEu3tpCWqw@mail.gmail.com>
Subject: Re: [PATCH] policycoreutils: Improve error message when selabel_open fails
To:     Vit Mojzis <vmojzis@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Jan 10, 2022 at 9:32 PM Vit Mojzis <vmojzis@redhat.com> wrote:
>
> When selabel_open fails to locate file_context files and
> selabel_opt_path is not specified (e.g. when the policy type is
> missconfigured in /etc/selinux/config), perror only prints
> "No such file or directory".
> This can be confusing in case of "restorecon" since it's
> not apparent that the issue is in policy store.
>
> Before:
>   \# restorecon -v /tmp/foo.txt
>   No such file or directory
> After:
>   \# restorecon -v /tmp/foo.txt
>   /etc/selinux/yolo/contexts/files/file_contexts: No such file or directory
>
> Signed-off-by: Vit Mojzis <vmojzis@redhat.com>
> ---
>  policycoreutils/setfiles/restore.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/policycoreutils/setfiles/restore.c b/policycoreutils/setfiles/restore.c
> index 74d48bb3..e9ae33ad 100644
> --- a/policycoreutils/setfiles/restore.c
> +++ b/policycoreutils/setfiles/restore.c
> @@ -29,7 +29,7 @@ void restore_init(struct restore_opts *opts)
>
>         opts->hnd = selabel_open(SELABEL_CTX_FILE, selinux_opts, 3);
>         if (!opts->hnd) {
> -               perror(opts->selabel_opt_path);
> +               perror(opts->selabel_opt_path ? opts->selabel_opt_path : selinux_file_context_path());
>                 exit(1);
>         }
>
> --
> 2.34.1
>

Acked-by: William Roberts <bill.c.roberts@gmail.com>
