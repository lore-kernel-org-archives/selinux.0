Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72117C2BBCA
	for <selinux@archiver.kernel.org>; Thu, 10 Dec 2020 23:08:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 499D22332A
	for <selinux@archiver.kernel.org>; Thu, 10 Dec 2020 23:08:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394178AbgLJWbX (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 10 Dec 2020 17:31:23 -0500
Received: from mail-ej1-f68.google.com ([209.85.218.68]:35904 "EHLO
        mail-ej1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405119AbgLJWYn (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 10 Dec 2020 17:24:43 -0500
Received: by mail-ej1-f68.google.com with SMTP id lt17so9640430ejb.3
        for <selinux@vger.kernel.org>; Thu, 10 Dec 2020 14:24:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=km88cQXiF549rOPq4xvXGGCtUyt+9VhAV/iiy7O/zzI=;
        b=aABrlD6t1qtEXqetyuWDkumVy2A3NyeWzMpAh7ugfHqVxfHC4zvlNOL8xyJNgk+Hb1
         TttEG4rIkts+QSePP5z5ek9kV0bRMeQoAhqJAwT5UK2DpxRsrpT4H6IundCgqnCC7OLS
         yfhK+gzOmtCIAOnw/SO4akWjDZ2vgHnZZSjYt3Tl0mamFhjz6MBWSGpLBOlpiEOh7tM8
         Ssp1GEId2E2Sog7l/4ngu5gLt2ngpm5AtsiQByfybvS4oj8MHpweELIWSvfI1ROkT8VY
         nPLj1afwy+htJXJybY7AoITm2Q4xAEIl3q9URmmvF4mWVUw8qPcvhWcxWBWv8F6PZgRM
         wt5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=km88cQXiF549rOPq4xvXGGCtUyt+9VhAV/iiy7O/zzI=;
        b=FZCPuyW3xMTKaD6MfJNgedDlFfks9yIyEev9GXSjSA0gwaaFzV+33vN9T5f2XEa+D3
         NHZvok2NWHP4eeTnkqQacsLhOUz2hh5X1xa1JUO2/oorMUp3Z0FPcUirWIM3NhLLrHwr
         snMP5U9rjgfFdJgzfx+TVRUGvxhokHTOXnVSLD1xSB0Rkt3YE472lapm9HL2yNiK1Kh8
         zwysqthxH4PU7lfTaUBtl2CPs4MDxj6qfZ3NFnnPBN0iHth4Ve7hnEgICawPkTbucfDJ
         Kh3dD8wrczLWI2kclExjz5c4Em8uiatDTP//BV5h5gSXWMR52S7EUcXPb5mKGLQmxs3w
         zY4g==
X-Gm-Message-State: AOAM5309yolMQ2yYQsUMB+r3zrnMOcGNVo2599qX/y+4TI6/Znv2RdRj
        l4C4tBbEJsHB0pDyQS5zv/gGjHYTfDwmJGeuqo3j
X-Google-Smtp-Source: ABdhPJwahVX1mu4U5CL+q5ScvLetgGqQVom03/st6erIuYxzU4hZeVKZuUh7B4eHQLzzeBeeqe8PkRI+pwR8bhIKMNM=
X-Received: by 2002:a17:906:1393:: with SMTP id f19mr8307567ejc.431.1607638980807;
 Thu, 10 Dec 2020 14:23:00 -0800 (PST)
MIME-Version: 1.0
References: <20201125125402.211692-1-lokeshgidra@google.com>
 <CAFqZXNsry1zqGND-iBaYmwb_KeCvoat-LQFywf04TAp998sqXQ@mail.gmail.com>
 <CAHC9VhQWXtLZfhwBppH_aFqipwED4u0qOCLX=LQL2YZ6P3CvMQ@mail.gmail.com> <CA+EESO52Gj0hpqfzZZb1GidP3cMbgT7Co0yp1ChW82-rAsF1DA@mail.gmail.com>
In-Reply-To: <CA+EESO52Gj0hpqfzZZb1GidP3cMbgT7Co0yp1ChW82-rAsF1DA@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 10 Dec 2020 17:22:49 -0500
Message-ID: <CAHC9VhR8Zg=nnBntVnKRc_-P7J8vHS-5dmu7Pb7jP4YHPsjh8g@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] selinux-testsuite: Add userfaultfd test
To:     Lokesh Gidra <lokeshgidra@google.com>
Cc:     Ondrej Mosnacek <omosnace@redhat.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        SElinux list <selinux@vger.kernel.org>,
        Kalesh Singh <kaleshsingh@google.com>,
        Calin Juravle <calin@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Jeff Vander Stoep <jeffv@google.com>,
        "Cc: Android Kernel" <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Dec 9, 2020 at 10:27 PM Lokesh Gidra <lokeshgidra@google.com> wrote:
> On Wed, Dec 9, 2020 at 6:45 PM Paul Moore <paul@paul-moore.com> wrote:
> > On Fri, Nov 27, 2020 at 9:09 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > > On Wed, Nov 25, 2020 at 1:54 PM Lokesh Gidra <lokeshgidra@google.com> wrote:
> > > > Confirm SELinux policies are enforced on userfaultfd operations
> > > > via secure anon-inode interface.
> > > >
> > > > Signed-off-by: Lokesh Gidra <lokeshgidra@google.com>
> >
> > ...
> >
> > > This is a good start, but it is only a very basic test :)
> > >
> > > I would expect at least these tests here:
> > > 1. ...
> >
> > Since it has been a while I wanted to check-in and see how this was
> > going?  Having a good test in place in the test suite is an important
> > part of getting the kernel code merged.
> >
>
> Sorry for the delay. I got caught up in some other work. I'll send
> another patch addressing all the comments from Ondrej by the end of
> this week.

No problem, thanks for the update.

-- 
paul moore
www.paul-moore.com
