Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-28.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F97DC433E0
	for <selinux@archiver.kernel.org>; Thu, 21 Jan 2021 00:17:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E308A23718
	for <selinux@archiver.kernel.org>; Thu, 21 Jan 2021 00:17:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731486AbhAUAQ7 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 20 Jan 2021 19:16:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390959AbhATXQ4 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 20 Jan 2021 18:16:56 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CBEBC06138F
        for <selinux@vger.kernel.org>; Wed, 20 Jan 2021 15:03:04 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id s11so276751edd.5
        for <selinux@vger.kernel.org>; Wed, 20 Jan 2021 15:03:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WP9juxggNgm/ZU4W3IOxT8V8SGbmsKt93fwjo6QByr0=;
        b=fkI8sN1lAhZIoIXLlVy3UeTGj8HhoExPOyxiACxIEsggmw4R5o/TlfJCacgmVQrBx7
         gDvvShzdUcIT3cHwOkc4xNtEUmoRRpua2cWWXQtY3awYlfJk9TWpc+nhFD8YXpely5Ar
         kI1EgUZoGiE8r2zcd2OXQPNC/HXWBrjNk7j/wL2fpAet5C/0AimAd7ZFq85ZLRd7ZUzX
         vBwg0Iv2PdlsG0seck/p9WijBuTbgOAW+Br61OukcB7P+PlAVbS649KsylipZAH4e9uA
         QhhkZ9uB8+uEStdZrerg3XCXfWBLB10j1BopTpyAIBpQFIZEdhTzDHaTaJQ7msp1onWo
         Y0og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WP9juxggNgm/ZU4W3IOxT8V8SGbmsKt93fwjo6QByr0=;
        b=dMa4ZTessgqZZLVgktRz1qNXmiMdSJCcOchEC4sCXqTAGLbD3u+Q41j4xMGqvw/Wno
         QLHFNQeSvkBSlhIQV3MuGrUKr+hXTE72QZiH5YYlQFYZQZBJ5U0A2YJWJHbAWDuD0xuc
         XOWMtOU+Jp5DWQqaV4PNSfXIo7u/dLiE3vNtB4X2taUhju91AW8CccJilYscJx8UxA3p
         xqnC8FxGPzosdaWcfY7YnLlogpW8JSp3JPWJH88wyR1kks5X54E1GUMrCyCVhzMsghnk
         ESkVbgXdm0no62nmZjMggJUbhNklvF7qNwP2FIl4C8FkumOZ/xLYiliX4PMWVhRwuUS3
         dEAw==
X-Gm-Message-State: AOAM531qBXr9lelpj9IW8/0jmmMARA/9UOr4H3Sh1RoQyWLUrAb3mHZD
        gc1c2d0dB78WYkFpXSMnC2UFjhl6tmzxNu2IEWIEiw==
X-Google-Smtp-Source: ABdhPJxN/CFyIYQV2cGdD+yaQNuq6yyb/UFIXiual4MfH660fX1YtSKcQBnrvwZr2GKJn9b1MA0j5LLPyehiXhsSkSc=
X-Received: by 2002:aa7:d39a:: with SMTP id x26mr8688484edq.51.1611183782947;
 Wed, 20 Jan 2021 15:03:02 -0800 (PST)
MIME-Version: 1.0
References: <20210108023803.684639-1-lokeshgidra@google.com> <CAFqZXNtCV60-i9mFYudns+vfXYQDj1K5Rw4_Gz5r6fU0WCU2QQ@mail.gmail.com>
In-Reply-To: <CAFqZXNtCV60-i9mFYudns+vfXYQDj1K5Rw4_Gz5r6fU0WCU2QQ@mail.gmail.com>
From:   Lokesh Gidra <lokeshgidra@google.com>
Date:   Wed, 20 Jan 2021 15:02:52 -0800
Message-ID: <CA+EESO6+kz3xS=064a2-Hxak2wWvVNYntrjZDhHTy4_e6uBtXA@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] selinux-testsuite: Add userfaultfd test
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     Paul Moore <paul@paul-moore.com>,
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

On Wed, Jan 20, 2021 at 2:39 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> On Fri, Jan 8, 2021 at 3:38 AM Lokesh Gidra <lokeshgidra@google.com> wrote:
> >
> > Confirm SELinux policies are enforced on userfaultfd operations
> > via secure anon-inode interface.
> >
> > Signed-off-by: Lokesh Gidra <lokeshgidra@google.com>
> > ---
> >  policy/Makefile                 |   4 +-
> >  policy/test_userfaultfd.cil     |  52 ++++++++++
> >  policy/test_userfaultfd.te      |  52 ++++++++++
> >  tests/Makefile                  |   2 +-
> >  tests/userfaultfd/Makefile      |   5 +
> >  tests/userfaultfd/test          |  44 ++++++++
> >  tests/userfaultfd/userfaultfd.c | 177 ++++++++++++++++++++++++++++++++
> >  7 files changed, 333 insertions(+), 3 deletions(-)
> >  create mode 100644 policy/test_userfaultfd.cil
> >  create mode 100644 policy/test_userfaultfd.te
> >  create mode 100644 tests/userfaultfd/Makefile
> >  create mode 100755 tests/userfaultfd/test
> >  create mode 100644 tests/userfaultfd/userfaultfd.c
>
> Sorry for the long delay... This version is already almost there, I
> just had to fix some style issues and added checks so that the test is
> skipped on old systems (when <linux/usefaultfd.h> doesn't exist or
> userfaultfd(2) returns -ENOSYS).
>
Thanks so much for fixing these issues. And I apologize for missing them.

> You can review the changes at
> https://github.com/WOnder93/selinux-testsuite/commits/uffd3 and if you
> (or others) have no objections, I'll fold them into the patch and
> merge it with a note that it was edited by me.

LGTM
>
> If you prefer, you can also fetch the branch via the command-line:
> git fetch https://github.com/WOnder93/selinux-testsuite uffd3:uffd3
>
> Thank you for being patient with us :)

Thank you for the reviews. It was a very learning experience for me :)
>
> --
> Ondrej Mosnacek
> Software Engineer, Platform Security - SELinux kernel
> Red Hat, Inc.
>
