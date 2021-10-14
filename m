Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 624CEC433F5
	for <selinux@archiver.kernel.org>; Thu, 14 Oct 2021 21:40:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 44DD260E97
	for <selinux@archiver.kernel.org>; Thu, 14 Oct 2021 21:40:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbhJNVmt (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 14 Oct 2021 17:42:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233867AbhJNVmt (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 14 Oct 2021 17:42:49 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BA44C061755
        for <selinux@vger.kernel.org>; Thu, 14 Oct 2021 14:40:43 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id r19so31731054lfe.10
        for <selinux@vger.kernel.org>; Thu, 14 Oct 2021 14:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Bc/19Sw3gCuiuNL5yxr53ROwuXXqpzpfHWWhYwbvjUo=;
        b=kJBigErm8oj6naJt86CzR6I4CvyMKAEXIVyQZPIrMf9IoLfG6qoK2Nq9bXwvpuHo2J
         Lg08sgiU6TkZK1UvhW0mdBh5Q6WXOe6Sg2Kim3mdWddM4s0AeL5swVZ9//9wagHv1vru
         dKFtjaT5p68KyiXkhio3E5UpjxsKFkLvwyorZ7jYbL0T4QtRHO+lqnrOGSBYfJQeEmAB
         flP3P3UXqw3OSfk2f7NqFdB1B0cqZ2wiR4JUYJa76vUInbAI10oirsmSkwmdO0WMoSJX
         BqqkLINBbUlLRUwRI8ft2z3Qk5rShAsQGnFJqE6kcQrS+pNAELb8WaTBBINwKDNZzja7
         5aKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Bc/19Sw3gCuiuNL5yxr53ROwuXXqpzpfHWWhYwbvjUo=;
        b=jlbcH4yHgZ09gNM9lZ+r4DQ+tuPCe3JgEw14kU7uhYDm1A8IoDopwdXa/LfnE6VN4B
         voMVc6iSWfOF8xNGBdXjyD68Gta21gy/mm7hsiMuT7SzSRQtgTPcZpSBPQlKSFY53JcQ
         Itb/FCgb6uEKMOLyZCq+60eD/+/WR0p8/ZISmRJUzn9JPaM7jYo9lwPL4/OK6kcIN19Q
         691E8QqsMwmLBqtUm9UhUNu40kgBbpZVHd9O7n9L/4wU2YOLdo83bVoXGOkFEolfD7Qg
         QHXXRyIcNxTqTS2oFRtByHzxXTZrkDqXOhSMiTSWIXB/XYYI0sNKyJbC21s+wC5Kg1AW
         Dp4w==
X-Gm-Message-State: AOAM531otqs93bEwx5JCU+qUk7N51Sq4MR70fciV0i2oBZgcaik9BwMt
        /zrjk4Zx3uFnEJ+u5gRLYFdc+Y5zlHKjXDr82/PvHg==
X-Google-Smtp-Source: ABdhPJxPLLk8qMtDlWK65ixYe3AxwSYOuLQWzgY8dPGbhyExlDVFcUshw6mboG8LnO3GIAmGuyVWP85em6Bc1cncdkE=
X-Received: by 2002:a05:6512:13a5:: with SMTP id p37mr7406070lfa.403.1634247641451;
 Thu, 14 Oct 2021 14:40:41 -0700 (PDT)
MIME-Version: 1.0
References: <20211012165614.2873369-1-tkjos@google.com> <CAHC9VhQ6W=8rX6hryk_d+iTc90MAoZOw=KVDhjXsXE5Laccn_A@mail.gmail.com>
In-Reply-To: <CAHC9VhQ6W=8rX6hryk_d+iTc90MAoZOw=KVDhjXsXE5Laccn_A@mail.gmail.com>
From:   Todd Kjos <tkjos@google.com>
Date:   Thu, 14 Oct 2021 14:40:27 -0700
Message-ID: <CAHRSSEwjFicpr2=4S37KmVTav+aNQqFwy1eUo8r_z1OPSX1LFw@mail.gmail.com>
Subject: Re: [PATCH v5 0/3] binder: use cred instead of task for security context
To:     Paul Moore <paul@paul-moore.com>
Cc:     gregkh@linuxfoundation.org, arve@android.com, tkjos@android.com,
        maco@android.com, christian@brauner.io,
        James Morris <jmorris@namei.org>,
        Serge Hallyn <serge@hallyn.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>, keescook@chromium.org,
        jannh@google.com, Jeffrey Vander Stoep <jeffv@google.com>,
        zohar@linux.ibm.com, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, joel@joelfernandes.org,
        kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Oct 14, 2021 at 2:34 PM Paul Moore <paul@paul-moore.com> wrote:
>
> On Tue, Oct 12, 2021 at 12:56 PM Todd Kjos <tkjos@google.com> wrote:
> >
> > This series fixes the possible use of an incorrect security context
> > when checking selinux permissions, getting a security ID, or lookup
> > up the euid.
> >
> > The previous behavior was to save the group_leader 'struct task_struct'
> > in binder_open() and using that to obtain security IDs or euids.
> >
> > This has been shown to be unreliable, so this series instead saves the
> > 'struct cred' of the task that called binder_open(). This cred is used
> > for these lookups instead of the task.
>
> Hi Todd,
>
> I just merged all three patches into selinux/next, thanks for your
> help patience on this patchset.  Ultimately I merged these patches
> into selinux/next as opposed to selinux/stable-5.15 because I felt
> that a couple of weeks in -next before going to Linus would be a good
> thing.  I'm also not certain how widespread binder is outside of
> Android so I figured the practical difference between next and
> stable-5.15 is likely very small.  Regardless, all of your Fixes and
> stable tags remain in the patches so as soon as they go up to Linus
> during the next merge window the stable folks will be notified.

Thanks Paul. This all sounds fine.

>
> --
> paul moore
> www.paul-moore.com
