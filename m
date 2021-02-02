Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D96F2C433E9
	for <selinux@archiver.kernel.org>; Tue,  2 Feb 2021 15:50:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9387464ECE
	for <selinux@archiver.kernel.org>; Tue,  2 Feb 2021 15:50:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235724AbhBBPuF (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 2 Feb 2021 10:50:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51743 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235740AbhBBPr5 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 2 Feb 2021 10:47:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612280789;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2CmmX+E2sQ34787TqvZ81D8VShUJdU2FHhG+UNgYHug=;
        b=YaF8Gx1i+TI+BjF9YAFvIOcRqQOdw9drZNiPHgtiiSVF6atEFCze15ceI1WpGSGM0rbDUr
        ojFmv/2bvMz56iqx7YsgrzzMs0FSHmQuOCbNlIqIYz7pwInI3Rp5rcXoRrkV8xdvRZPrx/
        hViTT0TQEmufWfgqEjfgG8ZVGHFxXls=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-557-Jv-OY3ouOhaX7cYM1BVI6Q-1; Tue, 02 Feb 2021 10:46:24 -0500
X-MC-Unique: Jv-OY3ouOhaX7cYM1BVI6Q-1
Received: by mail-lf1-f70.google.com with SMTP id z18so1786968lfh.21
        for <selinux@vger.kernel.org>; Tue, 02 Feb 2021 07:46:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=2CmmX+E2sQ34787TqvZ81D8VShUJdU2FHhG+UNgYHug=;
        b=gcVXMGsZVfTjOzKcGyChR5AhHROpyFScz2r0p/QbrlwAI2ckj+C1EPZ9TqUvfbivQX
         jcv9ZaTMPAkz5NjrgxTFMWB8qwlLpDUltZZMbTQ3+hQ0tirvjjq7tkyMmPFwEKRHHQlq
         VgiJKz8IYYLbQ7+g6ZDSKIsv3Yd3mAYuJ3HKVuDfu9Fv5M1irqUYo/wRWW2CUGR/pyE3
         UqthUk5WkQbG8LM0bTKAxXvpQ3xEhJhxkCttB0PaMq76CyXIBPfm6b7fe8AIHfogRqzo
         TV/C8aKzl8MTF6drRxXEUN/RCHnVndkMSsxevSutQWaXGEAgGsuSwEIN0Kz3PnhtnDy+
         Z52Q==
X-Gm-Message-State: AOAM530COV3zL5OKsjH7ai4v8T8e1riRw/w5Lee8+dK11va0Q8MzNFUN
        vn9Lsj9qO6ONBtG2foOZSk+Z4OfFkKBpvHTvTIQ4HAYEP45PPy2AOyD8vjDOg3SdsmO9ew8/J2A
        2T/lt7+wlJEx47SU3Uz1jhjqMZe+9KXgiHQ==
X-Received: by 2002:a05:6512:ad3:: with SMTP id n19mr11676951lfu.328.1612280783166;
        Tue, 02 Feb 2021 07:46:23 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxeL1IkMnePTX+DYZNVsPdgqfEZyeItxt5KJs8+jW+NJ73CEkH30ZPDFZ13VeGw2cf+AT+8u9fj2utA/ZIucp4=
X-Received: by 2002:a05:6512:ad3:: with SMTP id n19mr11676945lfu.328.1612280782994;
 Tue, 02 Feb 2021 07:46:22 -0800 (PST)
MIME-Version: 1.0
References: <20210125214416.446813-1-omosnace@redhat.com>
In-Reply-To: <20210125214416.446813-1-omosnace@redhat.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Tue, 2 Feb 2021 16:46:11 +0100
Message-ID: <CAFqZXNvpwNyt6Pcq7tWsp6VSutbtXEFZYhn8ATrxeWy4Y6K=Hw@mail.gmail.com>
Subject: Re: [PATCH testsuite] ci: run testsuite also against the secnext kernel
To:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Jan 25, 2021 at 10:44 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> Add another CI job that tests against Paul Moore's kernel-secnext
> builds, which contain the latest SELinux patches staged for the next
> Linux kernel release.
>
> Since the rawhide image doesn't currently boot under macOS and/or
> Virtualbox and/or Vagrant (shrug), use the stable F33 image with rawhide
> repo enabled. We will often need at least linux-firmware and glibc from
> rawhide anyway, and for verifying new tests for recently developed
> features it might be better to have the other userspace dependencies
> installed from rawhide, too.
>
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>  .github/workflows/checks.yml |  8 +++++++-
>  Vagrantfile                  | 16 +++++++++++++---
>  2 files changed, 20 insertions(+), 4 deletions(-)

Since the secnext kernel is now built with a fixed dwarves package and
passes testing now, I merged this patch:
https://github.com/SELinuxProject/selinux-testsuite/commit/ce647decaadf3347fca0610297a679a40cfcab45

--
Ondrej Mosnacek
Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

