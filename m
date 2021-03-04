Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E6DFC43603
	for <selinux@archiver.kernel.org>; Thu,  4 Mar 2021 10:32:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2056D64F32
	for <selinux@archiver.kernel.org>; Thu,  4 Mar 2021 10:32:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238559AbhCDKcA (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 4 Mar 2021 05:32:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:32318 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238555AbhCDKbh (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 4 Mar 2021 05:31:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614853811;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tiR7H5yTlAR7RNOEilGBsL/vs/yFx2s0kPMtdWdDxmI=;
        b=R4Dce//UxTTZ3Fb9Aimed2x0mw2phVy/Drhx8risCunx9cP8iA5KFxUV8zNrcc4PCVyGrX
        6v1kRVZ/jPwoqHMaRfZMrt0Mgud6F2O4QbAVdkNNhG7+s4Sb8X6VLW7ggV9Q++XyixYufP
        B5oUFbCneJLQWofQuUJC7lfgn95jzA0=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-264-vfsLmVBmNT29rBLE7jkStg-1; Thu, 04 Mar 2021 05:30:10 -0500
X-MC-Unique: vfsLmVBmNT29rBLE7jkStg-1
Received: by mail-yb1-f197.google.com with SMTP id l10so30498736ybt.6
        for <selinux@vger.kernel.org>; Thu, 04 Mar 2021 02:30:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=tiR7H5yTlAR7RNOEilGBsL/vs/yFx2s0kPMtdWdDxmI=;
        b=MfpKVaonGQeAlnYlp9Q7+yB/EWd4gPYNo8eD9MzStz+6vHtmzvyaZNHCyhxkiF/BkY
         e4dtPgORFTuxi+VB+dPm8RP37HdNR82I3SeIY6UP/V8Ah8qMBWcX6uvX42VYmLMrKcjs
         NNu0A43C3A0l31wdvuYPdgIzAF75Uj+W+dIWeNfUXuGmGvlHUTMNN67wvKN/e0iHn33P
         NJo9A9TOy/ZlWu1y8CP2wSOm3CQPS18ACwBGqhYDRRXLwtxmbt1fG5eClE2QI9NL2rRl
         9Z8j518UafIYJq7n6H/ihYUb8ZPWTnu+zRQdfkghAG5KRKo154TBnd+xvK/Omy3mS421
         o+4g==
X-Gm-Message-State: AOAM531hrf8n1RViqoakOATlqWkGMmvRsZM+ch38a2nR4RnTSw1n+bzo
        Esq3/NX0G1W4THadX0ktnW1e1VOwfmznUQ/7t76qub4kVqIfu6k2Wa//GiyrqOTnu856mHfgWzf
        O/sX7R9KEi50KavkKcLPKK+y9dK4w2sNCjg==
X-Received: by 2002:a5b:ac2:: with SMTP id a2mr5353520ybr.81.1614853809823;
        Thu, 04 Mar 2021 02:30:09 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz8mvfEbMp/mavOsFKu/HgPgYdtD3ocb6v767tbC1H5yL1Bo+NgaE/rhi3MGLPRA19zCN7lF2iLrbU2z5ZrB3A=
X-Received: by 2002:a5b:ac2:: with SMTP id a2mr5353486ybr.81.1614853809445;
 Thu, 04 Mar 2021 02:30:09 -0800 (PST)
MIME-Version: 1.0
References: <20210302172114.443689-1-omosnace@redhat.com>
In-Reply-To: <20210302172114.443689-1-omosnace@redhat.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Thu, 4 Mar 2021 11:29:58 +0100
Message-ID: <CAFqZXNs7JsX7GJ8P4OOaQo0LbA6Q+4MQA8YicUBB=9Mf3q3Pww@mail.gmail.com>
Subject: Re: [PATCH testsuite 0/3] perf_event: fixes and cleanups
To:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Mar 2, 2021 at 6:21 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> See individual patches for details.
>
> Ondrej Mosnacek (3):
>   perf_event: measure CPU 0 rather than CPU 1
>   perf_event: fix wrong use of perf_event_open(2) API
>   perf_event: fix CAP_SYS_ADMIN references
>
>  tests/perf_event/perf_event.c | 18 +++++++++++-----
>  tests/perf_event/test         | 39 ++++++++++++++++++++++-------------
>  2 files changed, 38 insertions(+), 19 deletions(-)
>
> --
> 2.29.2

These are now merged as well, and we have a green CI again \o/  (At
least in my fork; CI on upstream master is still running.)

-- 
Ondrej Mosnacek
Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

