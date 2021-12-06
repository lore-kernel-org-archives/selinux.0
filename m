Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 088EEC433EF
	for <selinux@archiver.kernel.org>; Mon,  6 Dec 2021 09:13:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240182AbhLFJRD (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 6 Dec 2021 04:17:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:50562 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240250AbhLFJPJ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 6 Dec 2021 04:15:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638781901;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BHD3qToPk7EZG6B8F7l2aAUjQbLaPPbFqrNXh6cpkC0=;
        b=BlWk1HX2KzXAiBddlVrw2Ghlh9T+pnJ9lxKusatWiM9l+uGtxWF5HPZUYZjO3Ster2tD3o
        qy4nshzEG1y+x3NFRYZUBwfRcGewGegsNMCpJLF3hKO+QcWOgW6Gjibs5GFKONP8FQYTSC
        DBTejUQtSucWTv4q8b72f6P62YS/g3Y=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-519-TgTRVxtVMR-s48BFACSnkw-1; Mon, 06 Dec 2021 04:11:39 -0500
X-MC-Unique: TgTRVxtVMR-s48BFACSnkw-1
Received: by mail-yb1-f198.google.com with SMTP id g25-20020a25b119000000b005c5e52a0574so18762235ybj.5
        for <selinux@vger.kernel.org>; Mon, 06 Dec 2021 01:11:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BHD3qToPk7EZG6B8F7l2aAUjQbLaPPbFqrNXh6cpkC0=;
        b=BeZEQLtFFNtB8duA/CCUIRejB7gnynrl0pnxP/tKKutGgxSGZ3Gzi+TwOk3PGdP63a
         kWWA6gzg6ABV0M1Jq+rSbEAvqyNyamgMksFY6y5sk7a9Uz4GLAkFxVnn8vKB0bJzovdI
         wa9nPruB96aLsJoWg/JZ98Ey+fWMMITEH8anSsZHOKCH4M5k8Heg7LP1rDccdf0/LvoP
         zUaz15DKm8eR7jz2zFOxufdbW2Sxkl0idyNMwNUB32sZnDiF0En0QSCsDsK7vwHgstZy
         BKxBfLsYAcBRtM7CdLyI2QCklZ882OKhnGqtAmFXUT9nvY5jqNqo2gsNp2phaRYqaW5I
         0kXA==
X-Gm-Message-State: AOAM531pe65mERY9LjXguQj8lC3Q9BEBbCeSmMKwbiXrc2Il1yDOV7CK
        iHQavrFXubEuLwLv+B1EGqHWtDJd4RUih0aftA9lnlQUwGgSkrHrnp7IOEABUC5egeNLPmIMf6N
        O27uLpRQI4vauf3mnBnMPR7JbEf+iOwb+Xg==
X-Received: by 2002:a05:6902:1503:: with SMTP id q3mr44544188ybu.253.1638781899311;
        Mon, 06 Dec 2021 01:11:39 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwSiZ805eXonWwuF8UZ9ePfxEuiPRoeq7GGZkcyhPUKl9ZsHciyOtMGZmTN8b6u+YMbYXNGisr5uZhvCN0AtDs=
X-Received: by 2002:a05:6902:1503:: with SMTP id q3mr44544162ybu.253.1638781899073;
 Mon, 06 Dec 2021 01:11:39 -0800 (PST)
MIME-Version: 1.0
References: <20211206071859.324729-1-bernard@vivo.com>
In-Reply-To: <20211206071859.324729-1-bernard@vivo.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Mon, 6 Dec 2021 10:11:28 +0100
Message-ID: <CAFqZXNs1QzHh6Kekg76PkgUHk1a8_awB0xBqD-=Y9sH=cYz5UQ@mail.gmail.com>
Subject: Re: [PATCH v2] security/selinux: fix potential memleak in error branch
To:     Bernard Zhao <bernard@vivo.com>
Cc:     Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        SElinux list <selinux@vger.kernel.org>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Dec 6, 2021 at 8:19 AM Bernard Zhao <bernard@vivo.com> wrote:
> This patch try to fix potential memleak in error branch.
>
> Signed-off-by: Bernard Zhao <bernard@vivo.com>
> ---
>  security/selinux/hooks.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 62d30c0a30c2..8dc140399a23 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -983,18 +983,22 @@ static int selinux_sb_clone_mnt_opts(const struct super_block *oldsb,
>  static int selinux_add_opt(int token, const char *s, void **mnt_opts)
>  {
>         struct selinux_mnt_opts *opts = *mnt_opts;
> +       bool is_alloc_opts = false;
>
>         if (token == Opt_seclabel)      /* eaten and completely ignored */
>                 return 0;
>
> +       if (!s)
> +               return -ENOMEM;
> +
>         if (!opts) {
>                 opts = kzalloc(sizeof(struct selinux_mnt_opts), GFP_KERNEL);
>                 if (!opts)
>                         return -ENOMEM;
>                 *mnt_opts = opts;
> +               is_alloc_opts = true;
>         }
> -       if (!s)
> -               return -ENOMEM;
> +
>         switch (token) {
>         case Opt_context:
>                 if (opts->context || opts->defcontext)
> @@ -1019,6 +1023,8 @@ static int selinux_add_opt(int token, const char *s, void **mnt_opts)
>         }
>         return 0;
>  Einval:
> +       if (is_alloc_opts)
> +               kfree(opts);
>         pr_warn(SEL_MOUNT_FAIL_MSG);
>         return -EINVAL;
>  }
> --
> 2.33.1

The problem is a bit more tricky... As is, this patch will lead to
double frees in some cases. Look at security_sb_eat_lsm_opts()
callers, for example - some of them don't do anything when error is
returned, some call security_free_mnt_opts() on the opts regardless,
some will let it store the opts in fc->security, where
put_fs_context() will eventually call security_free_mnt_opts() on
them.

You need to at least *mnt_opts = NULL after kfree(opts), but it would
be also nice to make the LSM hook callers more consistent in what they
do in the error path and document the fact that *mnt_opts will be NULL
on error in lsm_hooks.h (in case of the sb_eat_lsm_opts hook).

-- 
Ondrej Mosnacek
Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

