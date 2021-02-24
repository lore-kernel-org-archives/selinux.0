Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF85EC433E0
	for <selinux@archiver.kernel.org>; Wed, 24 Feb 2021 00:55:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 997C864DA1
	for <selinux@archiver.kernel.org>; Wed, 24 Feb 2021 00:55:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231274AbhBXAwF (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 23 Feb 2021 19:52:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234654AbhBXAET (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 23 Feb 2021 19:04:19 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A86CC06178B
        for <selinux@vger.kernel.org>; Tue, 23 Feb 2021 16:02:37 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id h19so429107edb.9
        for <selinux@vger.kernel.org>; Tue, 23 Feb 2021 16:02:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=teqVJhK4LXz4OZBg8usuG8VfNJnNMz+dTljcctkaNG4=;
        b=KdGZTmGsRPg0mfraFXSTSp/gtdGU7k4ammQ9upVnBXq/Xqb+ZsRIvIaqmyV3pVxo7C
         Y040vHQJmflrbsQ+9fRB7vQCenEwcGCHPxhTc+dwKFX2p3us0JRO27Zg62jUNVMeHIG9
         q1/fIVOksrqcUPr6yZH+k2Vfnjsyu0a4riSCBSB8y+ioY7q34yxUUTrq4N6GhQwKQWNu
         17d+2hkaQcEs5OfPaKnzKhA4I4Q9UJzA8VofTtNkrZG9GHTsVwnoJlnHz/zEIgRKrmmo
         bSg/NOsYK2XzYQFCIZIbQ1GGVNC3b8Ld1Y8O01y5OynRX0jDGH7IYowztBOl+KMxSQFJ
         RSmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=teqVJhK4LXz4OZBg8usuG8VfNJnNMz+dTljcctkaNG4=;
        b=oKCWCvbyQS2E6EnXKC/93hVJiR8oktWAKPVgyqXsvHZ2p3/V7udI7nUVmCWFxmHY9G
         OVHH3uQcWDIn6LBq78cRxWwFpxJDSRPZwYajtZovR/bZX26rTKdnUjPBy2yKMal6tMHL
         iUt9B2+tFZ7WSxXE5DfwzkNnIrIqRveSIrnFjtS1G42lGOeJre2mq111lvXhgPR5nfA0
         KHHBq1IQtsho+EaMbI4ttSbQ6JHrUlx9K2fORP2iGvFELyCMEWMdg6O198W5CLlYHi9k
         mwmE4iqJtN2B1UJpzswWD5LbgSbMHk/5A5qb4LkVZRdy5sY/pUfquM9IiHz10xD2/9Nv
         sapA==
X-Gm-Message-State: AOAM532EpphQDbWSYCccEGAx6HINT37En4n0cbbIXQD67yAOfA9yD2Hf
        c+v6bBuzVX4rJ40dddgTiM6DbtBUsmPPHhAuiV1F
X-Google-Smtp-Source: ABdhPJziRNGyofDZux2ELTzG6efQZEMJidRWFdAhC84nYkh3iZBsqcyVm8N/r7ln1ulYlW2a+bnT67lUDe8MhFeDwFs=
X-Received: by 2002:a05:6402:22e9:: with SMTP id dn9mr21996487edb.269.1614124956065;
 Tue, 23 Feb 2021 16:02:36 -0800 (PST)
MIME-Version: 1.0
References: <20210223214346.GB6000@sequoia> <20210223215054.GC6000@sequoia> <20210223223652.GD6000@sequoia>
In-Reply-To: <20210223223652.GD6000@sequoia>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 23 Feb 2021 19:02:25 -0500
Message-ID: <CAHC9VhRkP-ZuzWPvLbpCOiM2H-x-_FyDrKvy5fZ7TL9etwVJCA@mail.gmail.com>
Subject: Re: [BUG] Race between policy reload sidtab conversion and live conversion
To:     Tyler Hicks <tyhicks@linux.microsoft.com>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Feb 23, 2021 at 5:36 PM Tyler Hicks <tyhicks@linux.microsoft.com> wrote:
> On 2021-02-23 15:50:56, Tyler Hicks wrote:
> > On 2021-02-23 15:43:48, Tyler Hicks wrote:
> > > I'm seeing a race during policy load while the "regular" sidtab
> > > conversion is happening and a live conversion starts to take place in
> > > sidtab_context_to_sid().
> > >
> > > We have an initial policy that's loaded by systemd ~0.6s into boot and
> > > then another policy gets loaded ~2-3s into boot. That second policy load
> > > is what hits the race condition situation because the sidtab is only
> > > partially populated and there's a decent amount of filesystem operations
> > > happening, at the same time, which are triggering live conversions.
>
> Hmm, perhaps this is the same problem that's fixed by Ondrej's proposed
> change here:
>
>  https://lore.kernel.org/selinux/20210212185930.130477-3-omosnace@redhat.com/
>
> I'll put these changes through a validation run (the only place that I
> can seem to reproduce this crash) and see how it looks.

Thanks, please let us know what you find out.

-- 
paul moore
www.paul-moore.com
