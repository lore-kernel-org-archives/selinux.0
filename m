Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A72AC4332F
	for <selinux@archiver.kernel.org>; Tue, 16 Nov 2021 00:52:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29AA061ABF
	for <selinux@archiver.kernel.org>; Tue, 16 Nov 2021 00:52:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345230AbhKPAzx (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 15 Nov 2021 19:55:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343548AbhKOTVT (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 15 Nov 2021 14:21:19 -0500
Received: from mail-ua1-x92b.google.com (mail-ua1-x92b.google.com [IPv6:2607:f8b0:4864:20::92b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF887C03D78B
        for <selinux@vger.kernel.org>; Mon, 15 Nov 2021 10:17:43 -0800 (PST)
Received: by mail-ua1-x92b.google.com with SMTP id b17so36907179uas.0
        for <selinux@vger.kernel.org>; Mon, 15 Nov 2021 10:17:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+a8ZktNn6ZKD5SR+F36fH6n6kb1h7BS7jd1Wp45NaFM=;
        b=gKjpO0lLV7NAzCVw+nwCxA8yC44R21WAWD2XjYYi0XvHIj7m390XTLd0lEN5Nn7rcB
         BuK4C1Cfgw1j9IVR5y4ccOOC9HnZhA9Q9ERm3Q22nj0xyYhHPPZ+IYpHX27qbjUCyDa9
         FjBo+0o5USkN9WjUnl/bLBY+ePanR03FsUeaamVOMTsyk1ZuvITwcd6QcOScign6Qmun
         u7WUTMpODzERw1+OGJLsaUtAupMXVPh3UXvanz5tAdren74UjX5wDmMwtt0tuKXcncWg
         TUyJQc40cjABQb16NUrbV/xR8FV0L6K9gaV5knCQzF0+juocFBSz2mXCLAEddrjvWuAo
         708w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+a8ZktNn6ZKD5SR+F36fH6n6kb1h7BS7jd1Wp45NaFM=;
        b=XJNuOyz3+Go6hipJcyh9D+Elp1PtPvWWAYyFJEkqC1UH45F9w4UTOVa6nx6y4zf+fY
         Wb1xZ3+VgCe6o0Xq3iUScOxM1g9tFTFdAqbaE0n5A4ssIUeqWQFreWVt9B2PF6HSiaKT
         1VMZui52wbaFrZFeQqj/zDuHXG3klg9KncOSEz3rfC27vUx8OqnYKNDga8ukywvmQDay
         Csy5+s9qyL6aik5gQYTpVilsGQaFU3Z6IlQJGJTkZpp0HucgogN5eFSoYyGAO2wEujke
         Ndxo8lYV5IS6ZLKMOKVP2z9akTRv2yeVfaUCFsi4UI+AASRSXxtqEVDEiKm2PvOq1ki7
         FBrg==
X-Gm-Message-State: AOAM532ecuhuAxNDAg/x9tMT47WojlJBZkqucBZt3ueZEmbI1SZrkLDB
        UGcC7vyGOfA6URhpJy47QMl1tzltaYRlmC3aodam5A==
X-Google-Smtp-Source: ABdhPJya8J9a4P+RjZgEeXSNntVJy86MJNmzIPw9P4CUF+9L+z4wnWDoOasaaQi9RrdEFaJXT3F+c+2vxQUEakzHjTg=
X-Received: by 2002:a67:df96:: with SMTP id x22mr46045260vsk.9.1637000262835;
 Mon, 15 Nov 2021 10:17:42 -0800 (PST)
MIME-Version: 1.0
References: <20211115173850.3598768-1-adelva@google.com> <74179f08-3529-7502-db33-2ea18cab3f58@kernel.dk>
In-Reply-To: <74179f08-3529-7502-db33-2ea18cab3f58@kernel.dk>
From:   Alistair Delva <adelva@google.com>
Date:   Mon, 15 Nov 2021 10:17:30 -0800
Message-ID: <CANDihLE5oO2=MDiPtGmUzZgaPuzT2_X7da-vKe+ybBJkXgnsAQ@mail.gmail.com>
Subject: Re: [PATCH] block: Check ADMIN before NICE for IOPRIO_CLASS_RT
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-kernel@vger.kernel.org,
        Khazhismel Kumykov <khazhy@google.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Serge Hallyn <serge@hallyn.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Paul Moore <paul@paul-moore.com>, selinux@vger.kernel.org,
        linux-security-module@vger.kernel.org, kernel-team@android.com,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Nov 15, 2021 at 10:04 AM Jens Axboe <axboe@kernel.dk> wrote:
>
> On 11/15/21 10:38 AM, Alistair Delva wrote:
> > Booting to Android userspace on 5.14 or newer triggers the following
> > SELinux denial:
> >
> > avc: denied { sys_nice } for comm="init" capability=23
> >      scontext=u:r:init:s0 tcontext=u:r:init:s0 tclass=capability
> >      permissive=0
> >
> > Init is PID 0 running as root, so it already has CAP_SYS_ADMIN. For
> > better compatibility with older SEPolicy, check ADMIN before NICE.
>
> Seems a bit wonky to me, but the end result is the same.

No argument from me..

> In any case,
> this warrants a comment above it detailing why the ordering is
> seemingly important.

Sent v2.

> --
> Jens Axboe
>
