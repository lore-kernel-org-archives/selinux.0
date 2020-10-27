Return-Path: <SRS0=znNI=EC=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3B75C61DD8
	for <selinux@archiver.kernel.org>; Tue, 27 Oct 2020 17:06:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7050121D24
	for <selinux@archiver.kernel.org>; Tue, 27 Oct 2020 17:06:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AtV7lraW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1775322AbgJ0PGe (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 27 Oct 2020 11:06:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:38969 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1789760AbgJ0PCs (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 27 Oct 2020 11:02:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603810967;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=paen6LPJGadxGKzJ4bKtPZoQTiF+OV5vFNTGlE5DdVM=;
        b=AtV7lraWgjiP7fRVKNwD3PslRV52EJi8Forou3t39HlUPNb9YqJimbRKU5OQYUp+ps01kK
        8kgcidfUuYMOZTvlw3V6w/syhQdg+B6wo2mLvPzBJsbJ79qxgUr0pHUg5E4X1xwgPhX3OG
        bO3uOINveq4nqy745qTnN3/uQ0Dc5Z4=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-46-UedZGXDhOVqqohcSRmQ3xA-1; Tue, 27 Oct 2020 11:02:43 -0400
X-MC-Unique: UedZGXDhOVqqohcSRmQ3xA-1
Received: by mail-lj1-f197.google.com with SMTP id f4so952483ljn.2
        for <selinux@vger.kernel.org>; Tue, 27 Oct 2020 08:02:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=paen6LPJGadxGKzJ4bKtPZoQTiF+OV5vFNTGlE5DdVM=;
        b=giPexmxTJKPdroNoICl3YloIDY9LtX3qq1mixYmGCOuk9HUQBZoomMS9F7JA0WYAfw
         XniXv7GFFCtAB3XGqfjO8UPaK8t3adA/YElHBRi85nDHbY9jNxmaZyNC8HpGUXacTIEK
         rbSGkUHjXxgVQfs1AGwTlS+x7jVegKraSEXDSUYEov0TLwargUBKic8NUmwSY4nOPK/H
         5Kw8EY6j1iHGwXGfslFEXddC7ws238wzEvaME/HasE2KEFu1UC58zM7CixWsAKdlyam7
         mYtSa9oGTE8uPwNrws7Onw15+v88CFeYBG0M+8h/8hY3Q3BiT/4KFGzfmumVg//ZnG6I
         X/Mg==
X-Gm-Message-State: AOAM530pH7r+s5WnqY6b3F7dESWErC3+P/9DWW+X7csCyNqkkTo8Kr35
        i4u4fYHZuPBFuMbHXmHU9zLgzyLDWhjrJ3nUpjnuIAs9QXwvjqzqujiFhprxV2r6Ay0LogbRl83
        ypxW4JXUJElwrSgcZoS2yhy7CQh4vMwIkxQ==
X-Received: by 2002:a2e:b009:: with SMTP id y9mr1206386ljk.372.1603810962055;
        Tue, 27 Oct 2020 08:02:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxFvqOD3Heb3NCRwRiAz2iNqSNeAiu1gIc5JBoJ/41Vgt6E94zgbiX1KwTzhjAxzXa7ronlij8Qi/FGd9k9/Nk=
X-Received: by 2002:a2e:b009:: with SMTP id y9mr1206372ljk.372.1603810961798;
 Tue, 27 Oct 2020 08:02:41 -0700 (PDT)
MIME-Version: 1.0
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Tue, 27 Oct 2020 16:02:31 +0100
Message-ID: <CAFqZXNuy+Q1F9rT8NJKX+Wgnp2JEROHwCdzu0pmOuWdeRe1iDg@mail.gmail.com>
Subject: selinux_file_permission() on pipes/pseudo-files - performance issue
To:     SElinux list <selinux@vger.kernel.org>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>
Cc:     Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Hello,

It has been reported to me that read/write syscalls on a pipe created
via the pipe(2) family of syscalls spend a large percentage of time in
avc_lookup() via selinux_file_permission(). This is specific to pipes
(and also accept(2)'d sockets, I think) because these pipe fds are
created using alloc_file_pseudo() as opposed to do_dentry_open(),
which means that the security_file_open() hook is never called on
them.

In SELinux, this means that in selinux_file_permission() the
read/write permission is always revalidated, leading to suboptimal
performance, because SELinux re-checks the read/write perms of an open
file only if the subject/target label or policy is different from when
these permissions were checked during selinux_file_open().

So I decided to try and see what would happen if I add a
security_file_open() call to alloc_file(). This worked well for pipes
- all domains that call pipe(2) seem to already have the necessary
permissions to pass the open check, at least in Fedora policy - but I
got lots of denials from accept(2), which also calls alloc_file()
under the hood to create the new socket fd. The problem there is that
programs usually call only recvmsg(2)/sendmsg(2) on fds returned by
accept(2), thereby avoiding read/write checks on sock_file, which
means that the domains don't normally have such permissions. Only
programs that open actual socket files on the filesystem would
unavoidably need read/write (or so I think), yet they wouldn't need
them for the subsequent recvmsg(2)/sendmsg(2) calls.

So I'm wondering if anyone has any idea how this could be fixed
(optimized) without introducing regressions or awkward exceptions in
the code. At this point, I don't see any way to do it regression-free
without either adding a new hook or changing security_file_open() to
distinguish between do_dentry_open() and alloc_file() + calling it
from both places...

-- 
Ondrej Mosnacek
Software Engineer, Platform Security - SELinux kernel
Red Hat, Inc.

