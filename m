Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6617C4332F
	for <selinux@archiver.kernel.org>; Thu,  6 Oct 2022 14:17:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232035AbiJFOR1 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 6 Oct 2022 10:17:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231922AbiJFOQt (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 6 Oct 2022 10:16:49 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4821CB56CC
        for <selinux@vger.kernel.org>; Thu,  6 Oct 2022 07:14:15 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id p70so1340277iod.13
        for <selinux@vger.kernel.org>; Thu, 06 Oct 2022 07:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uPoSw2DcS8I2PL1GAxLCIjBZkmIbahmymE7q5ESqNH4=;
        b=J9UmphxOwRlKuKwKJGEStMq2njru+PiIwGVLUfPBPq5L+NiQWR0X0ph0BMc2W5nbt8
         4fY0afnp5OGHoR48WDeXsZwHxoMN5k4f3cAvRzRwXhvGYbcMUIpKQGeu62j2J2SnGy+J
         Xj/w4pUH+FdGPKiKioCFBigar50r6VlCGptHXogYu0vEHZthEC9POAERgLfXsIlNUJAT
         4LL5lhcH/9QJf5wjtvXr093IFQ5FVgHnW9DKsbH5n9oFVp8IFEYJH/pVve/xHlsOIZTb
         JrrThpZZTRv6pIFAUlojtCkCpeK6hrRAxbyXE8fkyWQe0FnS13WwHzjaGBDQmYXcBSxS
         r/Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uPoSw2DcS8I2PL1GAxLCIjBZkmIbahmymE7q5ESqNH4=;
        b=gCeFSqolx6DjsZsK+YeaU93MoWoAlFSoRiUO0d/RyXCeoMppTiC0ifB4MPRlFaiy8Z
         NkXND2feS/S8UZcje7Ry0r0isIfxw0vqVt2oDuw0Rc3w14QWIbYD4/V/1v0tjIu7qd4Z
         VUUFGgNdu2uU7QNPjY5IRmfiape0w9vMpjB7xpmDjJMSJ8/1AOSDBVQoM9ZvfsYyFDnP
         q6CvPmMHg9659Tfl950xbTdORwU4Ore9mNcenHxgcbLluQDlkgZyjSgDE6AY5E4y2qgR
         DInJuX5n3UEh0s3Qzs8c+tQuEgghvMR0V0qtTSplGktfS3jlmMU0lWNuDdf2FaKuhCr3
         eSpw==
X-Gm-Message-State: ACrzQf16p0z/wEugI6XfdHeN3Xb9TQQL2ijyTVZBCT8lkjCQfp2XwSQ6
        YRqCqkvf1VUW7oS5IJYVX4Zetx60Qj/AcJcfRIgOCQ==
X-Google-Smtp-Source: AMsMyM6kii+MO2rLiB+gLKVkRtdEKc2Fqc0GkifGVmj9R/yf+5vbD7WJTCsBBNNUYIzb2JEn4WLbsp9vBGxMSZlBt2Y=
X-Received: by 2002:a6b:5d07:0:b0:6bb:7253:a439 with SMTP id
 r7-20020a6b5d07000000b006bb7253a439mr37286iob.2.1665065653849; Thu, 06 Oct
 2022 07:14:13 -0700 (PDT)
MIME-Version: 1.0
References: <20221006082735.1321612-1-keescook@chromium.org>
 <20221006082735.1321612-2-keescook@chromium.org> <20221006090506.paqjf537cox7lqrq@wittgenstein>
In-Reply-To: <20221006090506.paqjf537cox7lqrq@wittgenstein>
From:   Jann Horn <jannh@google.com>
Date:   Thu, 6 Oct 2022 16:13:37 +0200
Message-ID: <CAG48ez0sEkmaez9tYqgMXrkREmXZgxC9fdQD3mzF9cGo_=Tfyg@mail.gmail.com>
Subject: Re: [PATCH 1/2] fs/exec: Explicitly unshare fs_struct on exec
To:     Christian Brauner <brauner@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Jorge Merlino <jorge.merlino@canonical.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org,
        John Johansen <john.johansen@canonical.com>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Richard Haines <richard_c_haines@btinternet.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Xin Long <lucien.xin@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Todd Kjos <tkjos@google.com>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        Prashanth Prahlad <pprahlad@redhat.com>,
        Micah Morton <mortonm@chromium.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Andrei Vagin <avagin@gmail.com>, linux-kernel@vger.kernel.org,
        apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Oct 6, 2022 at 11:05 AM Christian Brauner <brauner@kernel.org> wrote:
> On Thu, Oct 06, 2022 at 01:27:34AM -0700, Kees Cook wrote:
> > The check_unsafe_exec() counting of n_fs would not add up under a heavily
> > threaded process trying to perform a suid exec, causing the suid portion
> > to fail. This counting error appears to be unneeded, but to catch any
> > possible conditions, explicitly unshare fs_struct on exec, if it ends up
>
> Isn't this a potential uapi break? Afaict, before this change a call to
> clone{3}(CLONE_FS) followed by an exec in the child would have the
> parent and child share fs information. So if the child e.g., changes the
> working directory post exec it would also affect the parent. But after
> this change here this would no longer be true. So a child changing a
> workding directoro would not affect the parent anymore. IOW, an exec is
> accompanied by an unshare(CLONE_FS). Might still be worth trying ofc but
> it seems like a non-trivial uapi change but there might be few users
> that do clone{3}(CLONE_FS) followed by an exec.

I believe the following code in Chromium explicitly relies on this
behavior, but I'm not sure whether this code is in active use anymore:

https://source.chromium.org/chromium/chromium/src/+/main:sandbox/linux/suid/sandbox.c;l=101?q=CLONE_FS&sq=&ss=chromium
