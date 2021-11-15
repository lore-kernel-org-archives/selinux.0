Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0516C433EF
	for <selinux@archiver.kernel.org>; Mon, 15 Nov 2021 20:34:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D862660FBF
	for <selinux@archiver.kernel.org>; Mon, 15 Nov 2021 20:34:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347266AbhKOUht (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 15 Nov 2021 15:37:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346001AbhKOT3p (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 15 Nov 2021 14:29:45 -0500
Received: from mail-ua1-x92b.google.com (mail-ua1-x92b.google.com [IPv6:2607:f8b0:4864:20::92b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87043C06F6BD
        for <selinux@vger.kernel.org>; Mon, 15 Nov 2021 11:09:00 -0800 (PST)
Received: by mail-ua1-x92b.google.com with SMTP id p37so35438950uae.8
        for <selinux@vger.kernel.org>; Mon, 15 Nov 2021 11:09:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jvluQBYx8pG/L7kJ3qRM3jtClhdDAw2+NW4Rd+v+B5o=;
        b=k8///Am4xR6opsWOw7aCBHV/G3MQR7Mj2Up2mhx14tGfDM7Y1gfWoAAULtQsAgjipv
         coMm4HggdvV8WPLJdSiXY6QbamNijHgeE/oUyK5ovxDevsW4F71x5l8lRsJE25MkSGIF
         aGZeo2Xc6BlUJRthxWxpHJbgBg/yWKnDTPGKGf5dcH+suasKmBNIdEXtdGq23h3g6VYe
         mDyWrEUOORTj72inu+bmS97F169PX/PxQxduIFcRjgL5KRUFrjDZeoHHlRVIxzqW7Edb
         09Y7ncYe/upBoCyerLk86m+RbnYLXdnWsaGEOs8AuO7GblY1Nt5MmHmSFnmnOefMZ72G
         4F2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jvluQBYx8pG/L7kJ3qRM3jtClhdDAw2+NW4Rd+v+B5o=;
        b=6FG6aN9fDObCtm3nnVt2EAV+RSbiLaUCtAlQQxGGgdVvelP6pkAb3Y8Gh/bWB7MIRk
         H9DfWgeB4l5mF+q92HGuTPiVsioCoj7AesmX0aBXegI2mCqp28kQPYPEQ69gfHuKiEGX
         fnYVerC3cb4Ky3trOa2I1rFa4dbI46ZGpZG4IGClP9q8X3pwcwQez6+LkxPYeUV9xqgx
         CDMsYStj00Ch4hvJLc12YaUPJWCcSfcqgJnVg2lJDRkFwpcY3yVl/3b7YsfS1ZXNvF4m
         YpYTNuZ+wNAlXq3pZA8dY/qaJQTyQF2fITChkoOHex5Q8MddU0ryxL48k40/d5HxU3yR
         yVYQ==
X-Gm-Message-State: AOAM533TUrG8iULIjSQqSM6PSbE4O6FI5FBopObw4em6GegYg/pxvndh
        b5vyVWgSxv51AWECI8m/ojHLeHJcvsUFSzEp8mDN4Q==
X-Google-Smtp-Source: ABdhPJzCnX/ohcFcUDAyDZuuzokLa4DCdliYRfxUxdhWLFCJ563nrBlSiSryIUu8Mjk/wdwF6WJZtyRzVaMblSajvxw=
X-Received: by 2002:a67:ba0c:: with SMTP id l12mr45155412vsn.21.1637003339474;
 Mon, 15 Nov 2021 11:08:59 -0800 (PST)
MIME-Version: 1.0
References: <20211115173850.3598768-1-adelva@google.com> <CAFqZXNvVHv8Oje-WV6MWMF96kpR6epTsbc-jv-JF+YJw=55i1w@mail.gmail.com>
In-Reply-To: <CAFqZXNvVHv8Oje-WV6MWMF96kpR6epTsbc-jv-JF+YJw=55i1w@mail.gmail.com>
From:   Alistair Delva <adelva@google.com>
Date:   Mon, 15 Nov 2021 11:08:48 -0800
Message-ID: <CANDihLEFZAz8DwkkMGiDJnDMjxiUuSCanYsJtkRwa9RoyruLFA@mail.gmail.com>
Subject: Re: [PATCH] block: Check ADMIN before NICE for IOPRIO_CLASS_RT
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        Khazhismel Kumykov <khazhy@google.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Serge Hallyn <serge@hallyn.com>, Jens Axboe <axboe@kernel.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Paul Moore <paul@paul-moore.com>,
        SElinux list <selinux@vger.kernel.org>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        "Cc: Android Kernel" <kernel-team@android.com>,
        Linux Stable maillist <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Nov 15, 2021 at 11:04 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> On Mon, Nov 15, 2021 at 7:14 PM Alistair Delva <adelva@google.com> wrote:
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
> But with this patch you in turn punish the new/better policies that
> try to avoid giving domains CAP_SYS_ADMIN unless necessary (using only
> the more granular capabilities wherever possible), which may now get a
> bogus sys_admin denial. IMHO the order is better as it is, as it
> motivates the "good" policy writing behavior - i.e. spelling out the
> capability permissions more explicitly and avoiding CAP_SYS_ADMIN.
>
> IOW, if you domain does CAP_SYS_NICE things, and you didn't explicitly
> grant it that (and instead rely on the CAP_SYS_ADMIN fallback), then
> the denial correctly flags it as an issue in your policy and
> encourages you to add that sys_nice permission to the domain. Then
> when one beautiful hypothetical day the CAP_SYS_ADMIN fallback is
> removed, your policy will be ready for that and things will keep
> working.
>
> Feel free to carry that patch downstream if patching the kernel is
> easier for you than fixing the policy, but for the upstream kernel
> this is just a step in the wrong direction.

I'm personally fine with this position, but I am curious why "never
break userspace" doesn't apply to SELinux policies. At the end of the
day, booting 5.13 or older, we don't get a denial, and there's nothing
for the sysadmin to do. On 5.14 and newer, we get denials. This is a
common pattern we see each year: some new capability or permission is
required where it wasn't required before, and there's no compatibility
mechanism to grandfather in old policies. So, we have to touch
userspace. If this is just how things are, I can certainly update our
init.te definitions.

> > Fixes: 9d3a39a5f1e4 ("block: grant IOPRIO_CLASS_RT to CAP_SYS_NICE")
> > Signed-off-by: Alistair Delva <adelva@google.com>
> > Cc: Khazhismel Kumykov <khazhy@google.com>
> > Cc: Bart Van Assche <bvanassche@acm.org>
> > Cc: Serge Hallyn <serge@hallyn.com>
> > Cc: Jens Axboe <axboe@kernel.dk>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: Paul Moore <paul@paul-moore.com>
> > Cc: selinux@vger.kernel.org
> > Cc: linux-security-module@vger.kernel.org
> > Cc: kernel-team@android.com
> > Cc: stable@vger.kernel.org # v5.14+
> > ---
> >  block/ioprio.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/block/ioprio.c b/block/ioprio.c
> > index 0e4ff245f2bf..4d59c559e057 100644
> > --- a/block/ioprio.c
> > +++ b/block/ioprio.c
> > @@ -69,7 +69,7 @@ int ioprio_check_cap(int ioprio)
> >
> >         switch (class) {
> >                 case IOPRIO_CLASS_RT:
> > -                       if (!capable(CAP_SYS_NICE) && !capable(CAP_SYS_ADMIN))
> > +                       if (!capable(CAP_SYS_ADMIN) && !capable(CAP_SYS_NICE))
> >                                 return -EPERM;
> >                         fallthrough;
> >                         /* rt has prio field too */
> > --
> > 2.34.0.rc1.387.gb447b232ab-goog
> >
>
> --
> Ondrej Mosnacek
> Software Engineer, Linux Security - SELinux kernel
> Red Hat, Inc.
>
