Return-Path: <SRS0=axcH=7H=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C41F7C433DF
	for <selinux@archiver.kernel.org>; Mon, 25 May 2020 21:53:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4AD72071C
	for <selinux@archiver.kernel.org>; Mon, 25 May 2020 21:53:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iY2tvaDk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388994AbgEYVxj (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 25 May 2020 17:53:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389092AbgEYVxi (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 25 May 2020 17:53:38 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A12EC08C5C0
        for <selinux@vger.kernel.org>; Mon, 25 May 2020 14:53:38 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id m18so22161160ljo.5
        for <selinux@vger.kernel.org>; Mon, 25 May 2020 14:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3v101aASCPTejbg2jVfRLiyg4GeM0gg8VBZ5PDSH1ag=;
        b=iY2tvaDk5p5YH0iGs/a+wJsGtGT8KQPYOcxHmPLgAU+qx+6O5I1SNr/jyAMm1ptXcs
         xB2MhF2XN8ymMN9NU6RqOYL/nI4prBnS1vmF+82k4BLMwvUR52gZ+UZp7b0cY4BonHyO
         gRuXV1eHfIMukPkHZeKrfWm6c9UlUSn/xs5bz5Bxb4RQ3HwEcPWS1oKeh0PVT0L7NFNT
         +N+PVSjfZj+VOxFegAc8rIHKmBEdKt0LQVlwRP2nOjsyiiOCiV3fXky+4n8lQ6FCeMLv
         qbkkqo1rA9z49AODENtIvaT2c6gHV7EXS0TVRHz5BbstuWtgWAPRxmMCBUow6rRHEK0q
         B7UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3v101aASCPTejbg2jVfRLiyg4GeM0gg8VBZ5PDSH1ag=;
        b=sarK54XBbYEOalfbJGTaQB2/10k9dgZqUw6lsTRfEuBAvLQFBsY3MLJHrZYudOBjDo
         Gcz6XP7mXRzaHg8LyPI9uho71SIegPCjAPWL0EC1ZExWTr2/ZRh8ZjtB36xtQmE9JHpO
         2adFFT0raWvDPhDW70NJX+YHyv9PhfZd1rOoKnxXSpbEFTnXDGOQiARECGDWuv49ykSM
         as3x3v4EgdRUmyiKhhESSLKBzxvVEw2kC4ZF8iCAlM5aY1J3tRU3UCzNnmYmABRhM05V
         LpLr/sppGH4oIJ4KnzgsZSI0Z2ACNrGyJ0OtU50dGU7Typku3bcVfqx2WUDFPg5hpLnp
         2QUw==
X-Gm-Message-State: AOAM533O67LG5LSs3DAD/kMKBCx/KqCxVO8/0zN1I+3iUUm+INvw3fQJ
        4mGM+iJtfXSvuKL7+6tyx3mNOOvCEmRi8OI1RaLGVg==
X-Google-Smtp-Source: ABdhPJyKnh55r9ZmX+xYxnzN5U0nGuxPhLb6UCsL+iO/1S19+yDruhYy4O1R6Zoj4FsxXdc6DmU+OY95cKBKyVGfyqM=
X-Received: by 2002:a2e:9455:: with SMTP id o21mr2832190ljh.415.1590443616555;
 Mon, 25 May 2020 14:53:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200522055350.806609-1-areber@redhat.com>
In-Reply-To: <20200522055350.806609-1-areber@redhat.com>
From:   Jann Horn <jannh@google.com>
Date:   Mon, 25 May 2020 23:53:10 +0200
Message-ID: <CAG48ez3rh2a3PYRRkcu50LU9qPCaeOE8BJL=AmTwDD3qcA+xFA@mail.gmail.com>
Subject: Re: [PATCH] capabilities: Introduce CAP_RESTORE
To:     Adrian Reber <areber@redhat.com>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Pavel Emelyanov <ovzxemul@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Andrei Vagin <avagin@gmail.com>,
        Nicolas Viennot <Nicolas.Viennot@twosigma.com>,
        =?UTF-8?B?TWljaGHFgiBDxYJhcGnFhHNraQ==?= <mclapinski@google.com>,
        Kamil Yurtsever <kyurtsever@google.com>,
        Dirk Petersen <dipeit@gmail.com>,
        Christine Flood <chf@redhat.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Radostin Stoyanov <rstoyanov1@gmail.com>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        Serge Hallyn <serge@hallyn.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Sargun Dhillon <sargun@sargun.me>,
        Arnd Bergmann <arnd@arndb.de>,
        Aaron Goidel <acgoide@tycho.nsa.gov>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        SElinux list <selinux@vger.kernel.org>,
        Eric Paris <eparis@parisplace.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, May 22, 2020 at 7:55 AM Adrian Reber <areber@redhat.com> wrote:
> This enables CRIU to checkpoint and restore a process as non-root.
>
> Over the last years CRIU upstream has been asked a couple of time if it
> is possible to checkpoint and restore a process as non-root. The answer
> usually was: 'almost'.
>
> The main blocker to restore a process was that selecting the PID of the
> restored process, which is necessary for CRIU, is guarded by CAP_SYS_ADMIN.

And if you were restoring the process into your own PID namespace, so
that you actually have a guarantee that this isn't going to blow up in
your face because one of your PIDs is allocated for a different
process, this part of the problem could be simplified.

I don't get why your users are fine with a "oh it kinda works 99% of
the time but sometimes it randomly doesn't and then you have to go
reboot or whatever" model.
