Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A15EEC433B4
	for <selinux@archiver.kernel.org>; Sat,  8 May 2021 19:27:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79D8F60234
	for <selinux@archiver.kernel.org>; Sat,  8 May 2021 19:27:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbhEHT2W (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 8 May 2021 15:28:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:46176 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229549AbhEHT2W (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sat, 8 May 2021 15:28:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620502039;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=r4JUrndVVzeLYFVudjxB9ieoRupKUGGWn2OSDSVO4eg=;
        b=G5cfh1lkrWtO1TvU71b2SRKRi4BsNlWbxdfU6uWqovu9CXl09yfjjSjCgkaUiiwPMbFdAF
        it+LljOB9fodnYrLv6OnEhlN+yuvWq+LFEXszg5LX8bWfFUTvuHbqUiGVDQhI4jq5rc/qm
        99GcHKakM2G1mkfMdsIcNjERU/nC36w=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-122-NTHQtHv_ONO7VFlrdmYnRw-1; Sat, 08 May 2021 15:27:17 -0400
X-MC-Unique: NTHQtHv_ONO7VFlrdmYnRw-1
Received: by mail-yb1-f197.google.com with SMTP id p64-20020a2529430000b02904f838e5bd13so14574433ybp.20
        for <selinux@vger.kernel.org>; Sat, 08 May 2021 12:27:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r4JUrndVVzeLYFVudjxB9ieoRupKUGGWn2OSDSVO4eg=;
        b=WUAI4xP81DjVcKvbls2aYOobWAXkjAe7BSyWKVrhYdkHBM3t3i9rb15PTpX37x4zXr
         iQRNi3kL4iUFS67MW07dE0AJk0SHV83T7B4KufEGvcoOPkUHQGUGry8M8JAkINKE9tMm
         i46j7jCZ2nTAGWBVPJzdu2yYlch63/bAfGtiDtsQFwvon9b554AeTugNblx6XHbUZA81
         QgH8Oyr0Gc05iPcIngIL8a49HiEjBG97AmxZI+m9dEbeCsNFHm2AGQLIcLv1VT5gNZ+a
         OxZOax16qTOT33kgCvIYn2bHEtEzTO5vHX92yhkht9kGCvDlnUeAvjdaTF559HjEJ4bN
         LgyA==
X-Gm-Message-State: AOAM532C8tHjZJqbNOJdIRVo4RkKxduDZnkmVM6sS/pX02OGe4IrxqWa
        0fF2dQyte5szXpVn/euKhsCCAdv/o6loryR6yyIsgO8j9SOyAijbg61UFwk+QV4GIIZzPqA7XW4
        BUdzsProDs1pt/6swAJ6lJbCoWRKhx2LOVQ==
X-Received: by 2002:a25:640f:: with SMTP id y15mr22435797ybb.436.1620502036453;
        Sat, 08 May 2021 12:27:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy0nX9pyz5oXu8eDctG6MZoNHm4vPK4rRlD2LK8qQn9XTPGANISUPWNegB2bhGkPdaeBNFsjBaoB5njV83ElWc=
X-Received: by 2002:a25:640f:: with SMTP id y15mr22435778ybb.436.1620502036183;
 Sat, 08 May 2021 12:27:16 -0700 (PDT)
MIME-Version: 1.0
References: <20210329183939.1964411-1-dbrazdil@google.com> <CAFqZXNuQJmXSiche8JiFadTM_YZ6fa1zyPWX79dMYhtUF97QMQ@mail.gmail.com>
In-Reply-To: <CAFqZXNuQJmXSiche8JiFadTM_YZ6fa1zyPWX79dMYhtUF97QMQ@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Sat, 8 May 2021 21:27:01 +0200
Message-ID: <CAFqZXNsj7ioO80hNUfwnZY9YZ0jOxc7b0UimCMtySVNnou=B+g@mail.gmail.com>
Subject: Re: [PATCH testsuite] Add AF_VSOCK SOCK_STREAM client/server tests
To:     David Brazdil <dbrazdil@google.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Sat, May 8, 2021 at 7:28 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> On Mon, Mar 29, 2021 at 8:39 PM David Brazdil <dbrazdil@google.com> wrote:
> > If AF_VSOCK and vsock_loopback are supported by the system, run tests
> > that exchange a byte of data between a client and a server listening on
> > VMADDR_CID_LOCAL and a random port.
> >
> > Various permissions are removed from the client/server between runs and
> > it is checked that the corresponding syscalls returned error.
> >
> > A newly created vsock_socket inherits the SID of the current process and
> > it is tested that the vsock_socket returned by accept() inherits the same
> > SID from its parent.
> >
> > SOCK_DGRAM is not tested as it is only supported in the VMCI transport.
> >
> > These tests depend on an upstream commit 1f935e8e72ec ("selinux: vsock:
> > Set SID for socket returned by accept()"). It was first released in v5.12
> > and backported to all the stable branches.
> >
> > Signed-off-by: David Brazdil <dbrazdil@google.com>
> > ---
> > This is also posted on GitHub as pull request #75:
> >   https://github.com/SELinuxProject/selinux-testsuite/pull/75
> >
> > The patch that fixes the vsock_socket bug has been merged to 5.12 and
> > backported to 5.10-stable and 5.11-stable. Backport all the way back
> > to 4.4-stable is awaiting merging here:
> >   https://lkml.kernel.org/stable/20210329182443.1960963-1-dbrazdil@google.com
> > Since the expectation is that all stable kernels will soon have the patch,
> > I skipped a kernel version check in this test.
> >
> >  policy/Makefile                  |   2 +-
> >  policy/test_vsock_socket.te      |  52 ++++++++++++
> >  tests/Makefile                   |   2 +-
> >  tests/vsock_socket/.gitignore    |   3 +
> >  tests/vsock_socket/Makefile      |   7 ++
> >  tests/vsock_socket/check_vsock.c |  47 +++++++++++
> >  tests/vsock_socket/client.c      | 129 ++++++++++++++++++++++++++++
> >  tests/vsock_socket/server.c      | 140 +++++++++++++++++++++++++++++++
> >  tests/vsock_socket/test          | 118 ++++++++++++++++++++++++++
> >  9 files changed, 498 insertions(+), 2 deletions(-)
> >  create mode 100644 policy/test_vsock_socket.te
> >  create mode 100644 tests/vsock_socket/.gitignore
> >  create mode 100644 tests/vsock_socket/Makefile
> >  create mode 100644 tests/vsock_socket/check_vsock.c
> >  create mode 100644 tests/vsock_socket/client.c
> >  create mode 100644 tests/vsock_socket/server.c
> >  create mode 100755 tests/vsock_socket/test
>
> Sorry for the late review... I finally looked at the patch and all
> looks good, so I applied it (I used the version from the pull
> request):
> https://github.com/SELinuxProject/selinux-testsuite/commit/0a3f86ab841efa0f2bbd048243a801915d6808ba

Actually, I missed that there were two compiler warnings when
compiling the C code. They were trivial, so I pushed a fix:
https://github.com/SELinuxProject/selinux-testsuite/commit/db6c1cc4c9631e1b44ee5a0c40ec7ede68ab43f9

I also enabled -Werror in CI, so that they are more visible in the future:
https://github.com/SELinuxProject/selinux-testsuite/commit/0b78a9d433e8c4f956d18dc0db901f0a1a58c003

-- 
Ondrej Mosnacek
Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

