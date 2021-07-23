Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11645C4320E
	for <selinux@archiver.kernel.org>; Fri, 23 Jul 2021 08:39:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F1B1C60E77
	for <selinux@archiver.kernel.org>; Fri, 23 Jul 2021 08:39:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234386AbhGWH7W (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 23 Jul 2021 03:59:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:26070 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234586AbhGWH7V (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 23 Jul 2021 03:59:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627029595;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0R6geRNUNQC0kRoF+lSv0pifLg2KS6M6ylGJCMhofy4=;
        b=gZUldsYXEkdpe/4hGdjHeWiQLhYdBvSYDdJUY2Ny4NnLgfBu6TD8kzwA3BfRuYYDtwO+AG
        g9ahe2PxhRJ+stgBHFkBoLdFLDBAMREjK74sAOQdeRXdXTUppLF01q392Ec/Ll8SAUouLP
        DJ9ACnO/LLwVay0GjnWn3XI6Y1XPwy8=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-530-e78xadQ_PhCnsVKqVkPURQ-1; Fri, 23 Jul 2021 04:39:51 -0400
X-MC-Unique: e78xadQ_PhCnsVKqVkPURQ-1
Received: by mail-yb1-f197.google.com with SMTP id 16-20020a250b100000b029055791ebe1e6so991356ybl.20
        for <selinux@vger.kernel.org>; Fri, 23 Jul 2021 01:39:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0R6geRNUNQC0kRoF+lSv0pifLg2KS6M6ylGJCMhofy4=;
        b=h8wF4pLk/4qqj0CEbTWTvXJ9A1JgAY56crV+lVJyyzYn0iUaj/wEmoIQZxLljFqDoo
         F3dDQj5LMI9hwrNmwkPsZcl8nz/wvmaOfzgl9A0pDTEoajEW1tSkKyQQax2Nt2bqG60E
         NQjyG2EJBBmKaazeeoN0LUo2G63g20r7JhkqcrZvGs8adhzfZ8b8KrPcofVCrlBRc1lg
         5Jcj3Nyzm0u8v6+a8RJ5EZtcQSnX5UpdCt9qpjk8USxQJhdmI4aXiKZ57MrI0bG+9VlF
         /NL9SaVvqJq8jVVIzpRnJme5LbETE1U1XAyFmF2VTO+gIW4kE2y/jFmZupZ8UFPVQYVP
         BemA==
X-Gm-Message-State: AOAM531ZVyZ5p8F+UTaqlaGTEoxyXKq5I3ir+i/qvxe9SObf/MGBlzvO
        Hq1V+nDTHclCtBMzUTlGJX3lau/U5bkmr7baQX7jmeFqSLKLdrgZtAYLlAk+LDz9mfSDX1Zfvlp
        fUX0ZhBJ0Y14AHTXHID24EfyBbJ6RfcnZdw==
X-Received: by 2002:a25:ad06:: with SMTP id y6mr4824945ybi.439.1627029591446;
        Fri, 23 Jul 2021 01:39:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwoipMlzBA/c+4YtmIWldiJukH66ZNqDaJOTH+DaPJOdlJ6BqCck6ROt8is3ynzWvQ2IC9DyGQaGkkj7dNqS/Y=
X-Received: by 2002:a25:ad06:: with SMTP id y6mr4824924ybi.439.1627029591301;
 Fri, 23 Jul 2021 01:39:51 -0700 (PDT)
MIME-Version: 1.0
References: <20210624152515.1844133-1-omosnace@redhat.com>
In-Reply-To: <20210624152515.1844133-1-omosnace@redhat.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Fri, 23 Jul 2021 10:39:40 +0200
Message-ID: <CAFqZXNtb-VdL9f8Ntg3RLZtP0x-7ZgEP1D0qL9fWCM7SPWcHXQ@mail.gmail.com>
Subject: Re: [RFC PATCH] userfaultfd: open userfaultfds with O_RDONLY
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     Andrea Arcangeli <aarcange@redhat.com>,
        Lokesh Gidra <lokeshgidra@google.com>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        SElinux list <selinux@vger.kernel.org>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        "Robert O'Callahan" <roc@ocallahan.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Jun 24, 2021 at 5:25 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> Since userfaultfd doesn't implement a write operation, it is more
> appropriate to open it read-only.
>
> When userfaultfds are opened read-write like it is now, and such fd is
> passed from one process to another, SELinux will check both read and
> write permissions for the target process, even though it can't actually
> do any write operation on the fd later.
>
> Inspired by the following bug report, which has hit the SELinux scenario
> described above:
> https://bugzilla.redhat.com/show_bug.cgi?id=1974559
>
> Reported-by: Robert O'Callahan <roc@ocallahan.org>
> Fixes: 86039bd3b4e6 ("userfaultfd: add new syscall to provide memory externalization")
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>
> I marked this as RFC, because I'm not sure if this has any unwanted side
> effects. I only ran this patch through selinux-testsuite, which has a
> simple userfaultfd subtest, and a reproducer from the Bugzilla report.
>
> Please tell me whether this makes sense and/or if it passes any
> userfaultfd tests you guys might have.
>
>  fs/userfaultfd.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
> index 14f92285d04f..24e14c36068f 100644
> --- a/fs/userfaultfd.c
> +++ b/fs/userfaultfd.c
> @@ -986,7 +986,7 @@ static int resolve_userfault_fork(struct userfaultfd_ctx *new,
>         int fd;
>
>         fd = anon_inode_getfd_secure("[userfaultfd]", &userfaultfd_fops, new,
> -                       O_RDWR | (new->flags & UFFD_SHARED_FCNTL_FLAGS), inode);
> +                       O_RDONLY | (new->flags & UFFD_SHARED_FCNTL_FLAGS), inode);
>         if (fd < 0)
>                 return fd;
>
> @@ -2088,7 +2088,7 @@ SYSCALL_DEFINE1(userfaultfd, int, flags)
>         mmgrab(ctx->mm);
>
>         fd = anon_inode_getfd_secure("[userfaultfd]", &userfaultfd_fops, ctx,
> -                       O_RDWR | (flags & UFFD_SHARED_FCNTL_FLAGS), NULL);
> +                       O_RDONLY | (flags & UFFD_SHARED_FCNTL_FLAGS), NULL);
>         if (fd < 0) {
>                 mmdrop(ctx->mm);
>                 kmem_cache_free(userfaultfd_ctx_cachep, ctx);
> --
> 2.31.1

Ping? Any comments on this patch?

-- 
Ondrej Mosnacek
Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

