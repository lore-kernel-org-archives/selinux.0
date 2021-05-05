Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9805AC433B4
	for <selinux@archiver.kernel.org>; Wed,  5 May 2021 12:18:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A6946139A
	for <selinux@archiver.kernel.org>; Wed,  5 May 2021 12:18:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233118AbhEEMSz (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 5 May 2021 08:18:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:48703 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233348AbhEEMSV (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 5 May 2021 08:18:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620217044;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hrmCA/J3sB6HOBms8xIZgNMww4dgcHpRb4C4wTEbSKQ=;
        b=PN3+jA1g0VIGFsMnBhWLmSgGTMIdfPDaWbAm7k9W/1dVjyAPE+XVR+QogY34F724NZcZZc
        kasfPNdqeuxaOGVR0Nr5iMhJIYUIk2NHqU3mw7BrjtJBfjOUTut0FMeeK74Iu+SicXjsrL
        FA/gUmliRfO06vkEPJaW+9ADUmDBV0k=
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com
 [209.85.219.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-587-k4OE5NdAOnaqGAZ42ffW6g-1; Wed, 05 May 2021 08:17:23 -0400
X-MC-Unique: k4OE5NdAOnaqGAZ42ffW6g-1
Received: by mail-yb1-f200.google.com with SMTP id a7-20020a5b00070000b02904ed415d9d84so2145173ybp.0
        for <selinux@vger.kernel.org>; Wed, 05 May 2021 05:17:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hrmCA/J3sB6HOBms8xIZgNMww4dgcHpRb4C4wTEbSKQ=;
        b=oz0otvIyzMVdQoIRw+cTZA3NFhrVvBaiWCEk4nk7vCZdAfjDGwmJELZtzdiOnjPoW+
         Ba69t7gwgQDOGmob0y4Iseqp0n5d7j9/LNR/GHkv7f7ZHKrJz2sD7UkybR4XNoVncQtJ
         o6r66p1rrbvzq+JEFK8XkgjZV0iPsCRWfyM0hKpsciNmFwGCuyjX9mP85sDpA4ys8g5g
         OUcpuxM9/Q3GPPEyj4dtA/wEnABjd257cUYP9mFV7bkUzp0bBo5p/0Fe84FkE9s1cSFw
         DVM9e4WRVNgabVCDZBLrKXZ84K9eNNNIwUmY6H++y8WLyE0QZplGGriZrHHOKg/kSPI4
         pYdQ==
X-Gm-Message-State: AOAM5339jj/3clfOoeaeZSv0rKPpC0WWTxcOtjgAFEVEqaxXs8PtNFiW
        Khk6npxqZ41u2MofLK1AQn9Q6ZJzgMyLh82uLOBBi1LKN2paSE5BRG62RdtUtodvNd0LN5001+I
        FicRR7vfCGUtqt79j5sIaT6CAoBtkC5lhkw==
X-Received: by 2002:a25:6983:: with SMTP id e125mr32862081ybc.81.1620217042295;
        Wed, 05 May 2021 05:17:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyyXeBR96lH3iVFbY/+rJ0h396WwWdih4nDRG+1jiXjzn6xS5pJGc1DuzsshMbTJtAoPECXuDvPkoN8bT4VL4s=
X-Received: by 2002:a25:6983:: with SMTP id e125mr32862061ybc.81.1620217042093;
 Wed, 05 May 2021 05:17:22 -0700 (PDT)
MIME-Version: 1.0
References: <CAFqZXNvt-ezC2hwLC1zOVfgkRwd4483=dXw3k2ALkuRYfR4okA@mail.gmail.com>
 <YJJ8g0IKSz1UkZ/Q@kroah.com>
In-Reply-To: <YJJ8g0IKSz1UkZ/Q@kroah.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Wed, 5 May 2021 14:17:08 +0200
Message-ID: <CAFqZXNvrYW+oqBez6wUxWPbMiMSPBbNnvVNpDXST47-i0qS6ZQ@mail.gmail.com>
Subject: Re: Stable backport request - perf/core: Fix unconditional
 security_locked_down() call
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linux Stable maillist <stable@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, May 5, 2021 at 1:07 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> On Wed, May 05, 2021 at 12:58:24PM +0200, Ondrej Mosnacek wrote:
> > Hello,
> >
> > please consider backporting commit 08ef1af4de5f ("perf/core: Fix
> > unconditional security_locked_down() call") to stable kernels, as
> > without it SELinux requires an extraneous permission for
> > perf_event_open(2) calls with PERF_SAMPLE_REGS_INTR unset.
> >
> > The range of target kernel versions is implied by the Fixes: tag.
>
> Now queued up, thanks.
>
> greg k-h
>

Wow, that was fast :) Thanks, Greg!

--
Ondrej Mosnacek
Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

