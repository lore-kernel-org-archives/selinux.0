Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 303DDC433F5
	for <selinux@archiver.kernel.org>; Mon, 27 Sep 2021 09:22:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 07B1161157
	for <selinux@archiver.kernel.org>; Mon, 27 Sep 2021 09:22:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233635AbhI0JYW (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 27 Sep 2021 05:24:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:40714 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233526AbhI0JYS (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 27 Sep 2021 05:24:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632734560;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lPjCHNbXOuFj1jMUqmy/jZIIsonccHsYeWZ7Nubr8gg=;
        b=ZyjDk6ldqWOR2gUGNIyDWURWPhQtZVqmyvqnge9I7r4msFkByqr0aTqGWdFpiA+3lEDh0m
        ZXGwrDGLkLXUir+CbebvMZafXw+mdQXKTumFz0wqG/TelwnqX00Y4UOSIjA4Vkzp6B/iAx
        hWwLnlSlrYfqH10/c8BKMWzE3WDB3nc=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-108-UKqZBK4VPle2PiTwh6dmLA-1; Mon, 27 Sep 2021 05:22:38 -0400
X-MC-Unique: UKqZBK4VPle2PiTwh6dmLA-1
Received: by mail-yb1-f199.google.com with SMTP id x1-20020a056902102100b005b6233ad6b5so13227114ybt.6
        for <selinux@vger.kernel.org>; Mon, 27 Sep 2021 02:22:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lPjCHNbXOuFj1jMUqmy/jZIIsonccHsYeWZ7Nubr8gg=;
        b=AAswY+w9sV5X8hFNARXdA38ql3RWqfLgcHHON+yZDRfXd2izKMcVngBtopL0iAfsY2
         l8AZK8oXezs8HdXgqRxMU3z2mXnKXlxx6ssKqtdYObg/Wd8pSovuKKI3HadtZ4/f/Wu5
         nYtRh0P+S6VnqIpjBTmMiURVV/OJuWltFc659qxkdXkuM1adnBTCJxDf1voCDmA7l0RM
         Gd9sy8DZNaPuRKSylgbD7bun0hAfVeu8ajY7paW8LAPP09iOaGxWnBbT6u96PAiNK/fa
         gmYJ78YNgiThdhCGge7iEWWlJok8NNkOwrj3xiiN+3lczoorP7s3w+21v33U6UzotHQF
         Q2xg==
X-Gm-Message-State: AOAM531g5WjdrAXuF7j0YoFHVeSEoA9KjnRfTV8S0UU3aPAHjRxl3FX+
        bawLc6QBmddRJp7H4HgXZMaEf71s4siJNh4MRHYFRViT0gWLhWDpWptcvh8/IPzLNGyJknv6Ne2
        A1sghH6smBdtO0beNdn0u6pJcEIwQ3tV0Pw==
X-Received: by 2002:a25:cc1:: with SMTP id 184mr28559223ybm.363.1632734557301;
        Mon, 27 Sep 2021 02:22:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz6bBU8VUaP7kAk0NbEtFTBs4paerReiXfrf79CWz66V+jQwE5eVVoziH1b7Pa+n1xd681OJclb+VUngSRwIrw=
X-Received: by 2002:a25:cc1:: with SMTP id 184mr28559208ybm.363.1632734557069;
 Mon, 27 Sep 2021 02:22:37 -0700 (PDT)
MIME-Version: 1.0
References: <20210927084944.7197-1-nicolas.iooss@m4x.org>
In-Reply-To: <20210927084944.7197-1-nicolas.iooss@m4x.org>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Mon, 27 Sep 2021 11:22:26 +0200
Message-ID: <CAFqZXNu=LTrN+TowDpU1f1J8NUcrFbFb_3_V-tGrwUxwHfDBpg@mail.gmail.com>
Subject: Re: [PATCH userspace] README: update continuous integration badges
To:     Nicolas Iooss <nicolas.iooss@m4x.org>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Sep 27, 2021 at 10:50 AM Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
> The CI now uses GitHub Actions to run tests and the SELinux testsuite in
> a virtual machine. Replace the Travis CI badge with the ones for these
> workflows.
>
> Fixes: https://github.com/SELinuxProject/selinux/issues/299
> Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
> ---
>  README.md | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/README.md b/README.md
> index d1338e8765d1..e1c2fe641fc9 100644
> --- a/README.md
> +++ b/README.md
> @@ -2,7 +2,8 @@ SELinux Userspace
>  =================
>
>  ![SELinux logo](https://github.com/SELinuxProject.png)
> -[![Build Status](https://travis-ci.org/SELinuxProject/selinux.svg?branch=master)](https://travis-ci.org/SELinuxProject/selinux)
> +[![Run Tests](https://github.com/SELinuxProject/selinux/actions/workflows/run_tests.yml/badge.svg)](https://github.com/SELinuxProject/selinux/actions/workflows/run_tests.yml)
> +[![Run SELinux testsuite in a virtual machine](https://github.com/SELinuxProject/selinux/actions/workflows/vm_testsuite.yml/badge.svg)](https://github.com/SELinuxProject/selinux/actions/workflows/vm_testsuite.yml)
>  [![OSS-Fuzz Status](https://oss-fuzz-build-logs.storage.googleapis.com/badges/selinux.svg)](https://oss-fuzz-build-logs.storage.googleapis.com/index.html#selinux)
>  [![CIFuzz Status](https://github.com/SELinuxProject/selinux/actions/workflows/cifuzz.yml/badge.svg)](https://github.com/SELinuxProject/selinux/actions/workflows/cifuzz.yml)
>
> --
> 2.32.0
>

Acked-by: Ondrej Mosnacek <omosnace@redhat.com>

-- 
Ondrej Mosnacek
Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

