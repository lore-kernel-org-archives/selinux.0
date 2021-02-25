Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2036C433E0
	for <selinux@archiver.kernel.org>; Thu, 25 Feb 2021 19:24:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 391B364E21
	for <selinux@archiver.kernel.org>; Thu, 25 Feb 2021 19:24:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229993AbhBYTYE (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 25 Feb 2021 14:24:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233811AbhBYTVL (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 25 Feb 2021 14:21:11 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91FCBC06174A
        for <selinux@vger.kernel.org>; Thu, 25 Feb 2021 11:20:19 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id t11so10724579ejx.6
        for <selinux@vger.kernel.org>; Thu, 25 Feb 2021 11:20:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eq1qUFSUBrIyWXbKhScI5MKq1mKXDMwpHAizP40dn0E=;
        b=fQBEDsrpOgcMkxIqLG0zQhmuHOeD9t6OlOD5Roi4L841JJmwe6sky/E7qBoUvZh0P5
         R4D711ioS3ZpacICUoGqY8kX/FcwXuV9Vl/1bCyqTp34JXtXzBA4/lmhBAa5zxj5QKcx
         RKwi5KyG160RvAbq3wd8cpg0Sb+eKaecenxwcBvzmGd/1Vb7QIAHIzpgvE888jscUSEe
         v66fR0M2vjo6XK4Y1FMOhuK0NdJI9BEL2LIm7mtX39v1ShAcgGxjKiioipIb2gObiQsu
         zQ2SxH6mW5gCQuYoTBvNwnkcmWCJPgpj6D9k7Ydv4U7UdkPn4MBoIp705iX6mIjvf6PC
         Nwgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eq1qUFSUBrIyWXbKhScI5MKq1mKXDMwpHAizP40dn0E=;
        b=K6MIIr2p2KZvFxHTPZfmQj28d2GFW4k3A3HSBK76dxWzlT76gEO04+Eg1p6YBvAjMY
         Y8xVsgTMmOCaHDUwOzXQe8XXK4ytlnB1MGVsmx92dX9hNIdK6YYYjswrfg2uNsI5FCY5
         0hdoUeKuQcGAcA0DchEck/Vpg1v/VbnUC3n5/UhdPzyVlgvDgoPtIDPlAkz7ROWs8wFm
         FHPNC+ux3+ExF2xugBY1AeMaJj6iknBdaYBzfvI2K6DCdCXBZ8JUyzCID7Hn/Sz4jqY3
         BJ2elFjLobxj0U27hH7lXRxWe9mBsbFP1Po0DWJWF6vdDBpuUggV9obdjXqyilYDk42U
         n++w==
X-Gm-Message-State: AOAM532JrepStIF4LhiOtvnNln81CTI+pBShhnafpAJivi2NlU6Wjec8
        B05L+FNB9FS7xnlX24VY7MK/imFGd0Dz6qUCjx2H
X-Google-Smtp-Source: ABdhPJwDSZY70/O1XZEHHgv01DJQViCxQHt1fiGX9fmxoWREADG7FgvMRGsVCNiagJH0McLqPtP2PsKNMt1RMO+Lkgo=
X-Received: by 2002:a17:906:3b84:: with SMTP id u4mr4121066ejf.431.1614280818188;
 Thu, 25 Feb 2021 11:20:18 -0800 (PST)
MIME-Version: 1.0
References: <20210212185930.130477-1-omosnace@redhat.com> <20210212185930.130477-3-omosnace@redhat.com>
In-Reply-To: <20210212185930.130477-3-omosnace@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 25 Feb 2021 14:20:07 -0500
Message-ID: <CAHC9VhTfEekRYo=_-RMNHqKenkVdjBr9bA1bgm3EMXojgandZw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] selinux: fix variable scope issue in live sidtab conversion
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     selinux@vger.kernel.org,
        Stephen Smalley <stephen.smalley.work@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Feb 12, 2021 at 1:59 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> Commit 02a52c5c8c3b ("selinux: move policy commit after updating
> selinuxfs") moved the selinux_policy_commit() call out of
> security_load_policy() into sel_write_load(), which caused a subtle yet
> rather serious bug.
>
> The problem is that security_load_policy() passes a reference to the
> convert_params local variable to sidtab_convert(), which stores it in
> the sidtab, where it may be accessed until the policy is swapped over
> and RCU synchronized. Before 02a52c5c8c3b, selinux_policy_commit() was
> called directly from security_load_policy(), so the convert_params
> pointer remained valid all the way until the old sidtab was destroyed,
> but now that's no longer the case and calls to sidtab_context_to_sid()
> on the old sidtab after security_load_policy() returns may cause invalid
> memory accesses.
>
> This can be easily triggered using the stress test from commit
> ee1a84fdfeed ("selinux: overhaul sidtab to fix bug and improve
> performance"):
> ```
> function rand_cat() {
>         echo $(( $RANDOM % 1024 ))
> }
>
> function do_work() {
>         while true; do
>                 echo -n "system_u:system_r:kernel_t:s0:c$(rand_cat),c$(rand_cat)" \
>                         >/sys/fs/selinux/context 2>/dev/null || true
>         done
> }
>
> do_work >/dev/null &
> do_work >/dev/null &
> do_work >/dev/null &
>
> while load_policy; do echo -n .; sleep 0.1; done
>
> kill %1
> kill %2
> kill %3
> ```
>
> Fix this by allocating the temporary sidtab convert structures
> dynamically and passing them among the
> selinux_policy_{load,cancel,commit} functions.
>
> Note that this commit also fixes the minor issue of logging a
> MAC_POLICY_LOAD audit record in case sel_make_policy_nodes() fails (in
> which case the new policy isn't actually loaded).

I think you forgot to remove the paragraph above :)

Other than that, and a small nit (below), this looks good to me.

> Fixes: 02a52c5c8c3b ("selinux: move policy commit after updating selinuxfs")
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>  security/selinux/include/security.h | 15 ++++++---
>  security/selinux/selinuxfs.c        | 10 +++---
>  security/selinux/ss/services.c      | 51 +++++++++++++++++++----------
>  3 files changed, 49 insertions(+), 27 deletions(-)

...

> diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
> index 5e08ce2c5994..fada4ebc7ef8 100644
> --- a/security/selinux/ss/services.c
> +++ b/security/selinux/ss/services.c
> @@ -2157,8 +2157,13 @@ static void selinux_policy_cond_free(struct selinux_policy *policy)
>         kfree(policy);
>  }
>
> +struct selinux_policy_convert_data {
> +       struct convert_context_args args;
> +       struct sidtab_convert_params sidtab_params;
> +};

I generally prefer structs up at the top of the source file, before
the forward declarations please.

-- 
paul moore
www.paul-moore.com
