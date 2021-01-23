Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 332C9C433DB
	for <selinux@archiver.kernel.org>; Sat, 23 Jan 2021 09:58:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EEC2722CB9
	for <selinux@archiver.kernel.org>; Sat, 23 Jan 2021 09:58:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726866AbhAWJ6E (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 23 Jan 2021 04:58:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:47525 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726653AbhAWJ5f (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sat, 23 Jan 2021 04:57:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611395767;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Cath6HUpuJ8iGvEFGRca8w+L4mShl0BxIvm8FXxmhHA=;
        b=aPFgGjechpBdmxQxIKUcoVXMDuWaGbn5FEaNeBWpwVInLhOd3laWN/UTWbYWtrXn7EO2TQ
        f10Br/APyC+OaO5RUlxozYQfQ8F8m2wyFXNgNeR7B/APi1xu49XoJcjtrOi+mgBlDtvVhq
        PK8dUgVuIK/aP6nuUEbdkBiJDu9Nl94=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-333-QuWt4ImBP-2nXr4AxI9cVA-1; Sat, 23 Jan 2021 04:56:04 -0500
X-MC-Unique: QuWt4ImBP-2nXr4AxI9cVA-1
Received: by mail-lj1-f200.google.com with SMTP id a2so3533126ljm.23
        for <selinux@vger.kernel.org>; Sat, 23 Jan 2021 01:56:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Cath6HUpuJ8iGvEFGRca8w+L4mShl0BxIvm8FXxmhHA=;
        b=hlw3taaoT8D1zEqk02R4ANoA0KWMxl1XbJbpZWGgVUIrpY3lUVgGek/HcYG5XoZ+RY
         z5AwJbP7R3siOffKD8+dvB/lq+jfegnmO4yY7Rz0kXOocZ2LK5gSwov3wijN5hFiNL35
         J6Zj8yWYou0gmEITpaMdqI3iF1x8ZQngC+ZxM0Btme9svwO7IENhMq2mld3nJG1iYrIe
         XIeUV2Zibh0snzscAWKKPGAAjizZtFZTxqSYHkN3ipV/OwSSt787oDncW2tDfb6RBr/S
         JhwcxiP4NGlSuHG/XgVP26KUf4Iwe6l4IA+d96gC5dMB+WRTlMWCxCe1yFx/7sNfD0Qd
         Ylnw==
X-Gm-Message-State: AOAM532ZAHi7c/o9A6+fDVjFpMuTWiwmMHgy3a7+SIcYgYjcp9D3zmbh
        in8FSM9AwbVyethxYP8ta9JiDriqnNhef2+LTGgoNMiPWmjhkqioVLtZsYFVi1H8kNUu1iJX0so
        LyM3m5ogtDub+Xy0CjXlPCJcreFg0EFltMw==
X-Received: by 2002:a19:2206:: with SMTP id i6mr132946lfi.600.1611395762549;
        Sat, 23 Jan 2021 01:56:02 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwIeWO5fiG10U9bRtJy30kzMZU1QdZwajHa7vY5ZUGm2FLb2lM/qdMviStlk5c0VqySeb67SFqSJnYAIsH5G78=
X-Received: by 2002:a19:2206:: with SMTP id i6mr132935lfi.600.1611395762356;
 Sat, 23 Jan 2021 01:56:02 -0800 (PST)
MIME-Version: 1.0
References: <20210108023803.684639-1-lokeshgidra@google.com>
 <CAFqZXNtCV60-i9mFYudns+vfXYQDj1K5Rw4_Gz5r6fU0WCU2QQ@mail.gmail.com> <CA+EESO6+kz3xS=064a2-Hxak2wWvVNYntrjZDhHTy4_e6uBtXA@mail.gmail.com>
In-Reply-To: <CA+EESO6+kz3xS=064a2-Hxak2wWvVNYntrjZDhHTy4_e6uBtXA@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Sat, 23 Jan 2021 10:55:52 +0100
Message-ID: <CAFqZXNs=p1S9mhJFom2iHgC3H0sRTMz7Htgi4Uhu-KGb-Yyi+Q@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] selinux-testsuite: Add userfaultfd test
To:     Lokesh Gidra <lokeshgidra@google.com>
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

On Thu, Jan 21, 2021 at 12:03 AM Lokesh Gidra <lokeshgidra@google.com> wrote:
>
> On Wed, Jan 20, 2021 at 2:39 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> >
> > On Fri, Jan 8, 2021 at 3:38 AM Lokesh Gidra <lokeshgidra@google.com> wrote:
> > >
> > > Confirm SELinux policies are enforced on userfaultfd operations
> > > via secure anon-inode interface.
> > >
> > > Signed-off-by: Lokesh Gidra <lokeshgidra@google.com>
> > > ---
> > >  policy/Makefile                 |   4 +-
> > >  policy/test_userfaultfd.cil     |  52 ++++++++++
> > >  policy/test_userfaultfd.te      |  52 ++++++++++
> > >  tests/Makefile                  |   2 +-
> > >  tests/userfaultfd/Makefile      |   5 +
> > >  tests/userfaultfd/test          |  44 ++++++++
> > >  tests/userfaultfd/userfaultfd.c | 177 ++++++++++++++++++++++++++++++++
> > >  7 files changed, 333 insertions(+), 3 deletions(-)
> > >  create mode 100644 policy/test_userfaultfd.cil
> > >  create mode 100644 policy/test_userfaultfd.te
> > >  create mode 100644 tests/userfaultfd/Makefile
> > >  create mode 100755 tests/userfaultfd/test
> > >  create mode 100644 tests/userfaultfd/userfaultfd.c
> >
> > Sorry for the long delay... This version is already almost there, I
> > just had to fix some style issues and added checks so that the test is
> > skipped on old systems (when <linux/usefaultfd.h> doesn't exist or
> > userfaultfd(2) returns -ENOSYS).
> >
> Thanks so much for fixing these issues. And I apologize for missing them.
>
> > You can review the changes at
> > https://github.com/WOnder93/selinux-testsuite/commits/uffd3 and if you
> > (or others) have no objections, I'll fold them into the patch and
> > merge it with a note that it was edited by me.
>
> LGTM

Thanks, I have now merged the final patch:
https://github.com/SELinuxProject/selinux-testsuite/commit/2ea0079243635d7e4232deab7af8b90106474cec

> >
> > If you prefer, you can also fetch the branch via the command-line:
> > git fetch https://github.com/WOnder93/selinux-testsuite uffd3:uffd3
> >
> > Thank you for being patient with us :)
>
> Thank you for the reviews. It was a very learning experience for me :)
> >
> > --
> > Ondrej Mosnacek
> > Software Engineer, Platform Security - SELinux kernel
> > Red Hat, Inc.
> >
>

--
Ondrej Mosnacek
Software Engineer, Platform Security - SELinux kernel
Red Hat, Inc.

