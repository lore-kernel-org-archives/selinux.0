Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC520C433DB
	for <selinux@archiver.kernel.org>; Thu, 21 Jan 2021 00:16:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B04CB23716
	for <selinux@archiver.kernel.org>; Thu, 21 Jan 2021 00:16:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731903AbhAUAQJ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 20 Jan 2021 19:16:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:26062 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390842AbhATW53 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 20 Jan 2021 17:57:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611183362;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KUt8bgU4wALHcT7jqTaHJ30RV+A2bVkz3veJZyF1Be0=;
        b=BeOAkEJcNpRsl37UTrh3cOk9CDRss1eRmODLnZsY/hiMXhZvFROskvWhvcUT0J659HsnRW
        jNkjI8E3D+foZpSYXTl8jQY3U2cgbb2w4Ct0Vh2oWsBcMZ7ui0ZpbMBEWNVAjOUQ8rtxDh
        uv7wMQ5TEPu05ElVh6EoL5C5LGjrOCo=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-465-vA4Wvb7MO0SxiD8YbHAkow-1; Wed, 20 Jan 2021 17:39:09 -0500
X-MC-Unique: vA4Wvb7MO0SxiD8YbHAkow-1
Received: by mail-lf1-f72.google.com with SMTP id i7so1416lfi.4
        for <selinux@vger.kernel.org>; Wed, 20 Jan 2021 14:39:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KUt8bgU4wALHcT7jqTaHJ30RV+A2bVkz3veJZyF1Be0=;
        b=lDTh+Q+MMuRARNnorKgxP9St15z+zM/b6Kymsc/ucj85icxPsuztq2mr1Gvu8qorta
         skT1XQzTmyBh5zKlunSKkzphz0Qzeco5dpVQ9OFtjRc/bxWLTL0ertH6X3sDC3MPyMVp
         bqBC0I0mc2MkAFEanKc8B3umz7rMNX+G4xb+Mclwl3Cl9Gtd1vMJZDrGzN08NvKk8CC8
         f9xkY6y1IjcxseiQiD/47H8tdBxwrbeQImZfaV+Tr8oPgMef8YLF4/xdMuw2WaJsSox6
         R7Dzmjs+5P0d5+qUDr2Gh1i2MBBZ4FivPBnARi+tS0HMALv9Jldot+v99Y+4cLYhjfWi
         OqdA==
X-Gm-Message-State: AOAM533FcWzenwTnvrNLlDqije4nqeQLr4eiiEhiMWM2zRrdKy208/6o
        OuEQafWiQWWyDcm+k8R5q7qoLgxjpilscLcwSnqAfXXa2tDuPAXBLd8QidK51CjvSIRA7OP5nDe
        iOuYtCCX4AdAxBnD3v1/nVvbiuJ/bNVc/1Q==
X-Received: by 2002:a05:6512:ad3:: with SMTP id n19mr5199743lfu.328.1611182348305;
        Wed, 20 Jan 2021 14:39:08 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw454QRxDRnflq1eVDJYn27i3u/AEiMcC2ivOZSon4tHr4EXV+1VNpVMcvNTk58CONgH/Z1Ct3phn/+aqAJ4vw=
X-Received: by 2002:a05:6512:ad3:: with SMTP id n19mr5199730lfu.328.1611182348086;
 Wed, 20 Jan 2021 14:39:08 -0800 (PST)
MIME-Version: 1.0
References: <20210108023803.684639-1-lokeshgidra@google.com>
In-Reply-To: <20210108023803.684639-1-lokeshgidra@google.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Wed, 20 Jan 2021 23:38:57 +0100
Message-ID: <CAFqZXNtCV60-i9mFYudns+vfXYQDj1K5Rw4_Gz5r6fU0WCU2QQ@mail.gmail.com>
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

On Fri, Jan 8, 2021 at 3:38 AM Lokesh Gidra <lokeshgidra@google.com> wrote:
>
> Confirm SELinux policies are enforced on userfaultfd operations
> via secure anon-inode interface.
>
> Signed-off-by: Lokesh Gidra <lokeshgidra@google.com>
> ---
>  policy/Makefile                 |   4 +-
>  policy/test_userfaultfd.cil     |  52 ++++++++++
>  policy/test_userfaultfd.te      |  52 ++++++++++
>  tests/Makefile                  |   2 +-
>  tests/userfaultfd/Makefile      |   5 +
>  tests/userfaultfd/test          |  44 ++++++++
>  tests/userfaultfd/userfaultfd.c | 177 ++++++++++++++++++++++++++++++++
>  7 files changed, 333 insertions(+), 3 deletions(-)
>  create mode 100644 policy/test_userfaultfd.cil
>  create mode 100644 policy/test_userfaultfd.te
>  create mode 100644 tests/userfaultfd/Makefile
>  create mode 100755 tests/userfaultfd/test
>  create mode 100644 tests/userfaultfd/userfaultfd.c

Sorry for the long delay... This version is already almost there, I
just had to fix some style issues and added checks so that the test is
skipped on old systems (when <linux/usefaultfd.h> doesn't exist or
userfaultfd(2) returns -ENOSYS).

You can review the changes at
https://github.com/WOnder93/selinux-testsuite/commits/uffd3 and if you
(or others) have no objections, I'll fold them into the patch and
merge it with a note that it was edited by me.

If you prefer, you can also fetch the branch via the command-line:
git fetch https://github.com/WOnder93/selinux-testsuite uffd3:uffd3

Thank you for being patient with us :)

-- 
Ondrej Mosnacek
Software Engineer, Platform Security - SELinux kernel
Red Hat, Inc.

