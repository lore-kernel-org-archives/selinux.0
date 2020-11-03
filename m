Return-Path: <SRS0=PQdl=EJ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAAFCC2D0A3
	for <selinux@archiver.kernel.org>; Tue,  3 Nov 2020 09:44:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A7B8223BD
	for <selinux@archiver.kernel.org>; Tue,  3 Nov 2020 09:44:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RmOiXyWg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727109AbgKCJo5 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 3 Nov 2020 04:44:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:48353 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727901AbgKCJo4 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 3 Nov 2020 04:44:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604396695;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=m6CW1zn3Tu/ohBbZSWDIKUp3TWO4knmgJA3jzTyDZPM=;
        b=RmOiXyWgJbL/wTGyUj5xVI2qiSOCAoDwdTlC7tDoYqICJgNWQZjckilOwN1ly04TV6apSm
        tJQkGeQu+wb6K2yoLnHzsg40YqI2E4RR4JqCxJYfjH/AEqaf8qdntwpe6pdXPs/3rEZQtu
        9v/rGLjarlT8oqaNuKumm4AE1ICywc0=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-481-hgzBgFKnM3WsXainPcUDKQ-1; Tue, 03 Nov 2020 04:44:51 -0500
X-MC-Unique: hgzBgFKnM3WsXainPcUDKQ-1
Received: by mail-lj1-f197.google.com with SMTP id r5so4136653ljd.19
        for <selinux@vger.kernel.org>; Tue, 03 Nov 2020 01:44:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m6CW1zn3Tu/ohBbZSWDIKUp3TWO4knmgJA3jzTyDZPM=;
        b=CQzPP2Fk7KBriCRrh4BtZFDl9beF+JvM0vA7imrnn9NZgOH2hOs5TfuIQ2dQ1TGgUa
         dmx4bDq0H6uJFwlHn6pgeDW+rmAsAdYCLFDllfthWNjjsBa4jrRqIAMAOWJ0v/m5P+4E
         2QhcBy2Gki9iHUTIRlWHoAbVwn22Yh3b3Bze7Nppo/IUw+jzRztI25xG6t5VA8nUAMGx
         FSJsXwIptS6qWewxDl3h5NbBCNbixwQDxAOFGv6QnXOIwIpKb4qK7JCthLWGPA6Uh0+h
         drO8N4BHpeJhAZRaXa7Qqex41Z0N87tnBeNFCKH4rvj/rZ7ThuGA+4iIhHRfMe2B77DK
         SQ2A==
X-Gm-Message-State: AOAM532I8BfEJwAP3npBgeTLxge1P6b945OvxxSVWDBFzBLO9HUgIzsi
        NZuhacYJ4FPnv502dG2Ma9/xCWh+uCKii2pybwPISk2LCvDdT/gxu2FuEjGv+syNmirKj1XRuY9
        j9zIHOuNbFyBKprml7pBEnYVgfqa9SBI62w==
X-Received: by 2002:a05:6512:6c3:: with SMTP id u3mr7886698lff.9.1604396689849;
        Tue, 03 Nov 2020 01:44:49 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwwUmVJkRiSbFe25UqZqv9EIEfuQ+is88ZNrg7suHpE2Pn+bDlrwCfvPRL0obYF338Xll1mMzwyhiKR7ax/lxw=
X-Received: by 2002:a05:6512:6c3:: with SMTP id u3mr7886689lff.9.1604396689590;
 Tue, 03 Nov 2020 01:44:49 -0800 (PST)
MIME-Version: 1.0
References: <20201102083516.477149-1-omosnace@redhat.com> <83bf40215c21e67489a6379fcd1c89dcd7e2e031.camel@btinternet.com>
In-Reply-To: <83bf40215c21e67489a6379fcd1c89dcd7e2e031.camel@btinternet.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Tue, 3 Nov 2020 10:44:38 +0100
Message-ID: <CAFqZXNvpCPMoPPwZdwNq_TrOBgUin_hixDQX=qpbHTZt5Ea4oQ@mail.gmail.com>
Subject: Re: [PATCH testsuite v2 0/4] Test all filesystems by default
To:     Richard Haines <richard_c_haines@btinternet.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Nov 2, 2020 at 1:05 PM Richard Haines
<richard_c_haines@btinternet.com> wrote:
> On Mon, 2020-11-02 at 09:35 +0100, Ondrej Mosnacek wrote:
> > This series enables testing all filesystems currently supported by
> > the
> > testsuite (ext4, xfs, jfs, vfat) using the [fs_]filesystem subtests
> > without the need to run the tests manually or move to a different
> > filesystem. The filesystems not available on the tested kernel are
> > automatically excluded.
> >
> > The series also updates dependencies with the packages containing the
> > required mkfs.* programs, fixes the mkfs.* invocation to not get
> > stuck
> > when testing jfs, and fixes error output appearing during a
> > successful
> > vfat test.
> >
> > Note: The F32 CI will start failing after this and the kernel update
> > patches are merged (the old kernel on the image doesn't have the XFS
> > quota fix). It will be necessary to bump the stable Fedora testing to
> > F33.
> >
> > v2 changes:
> >  - added a patch to fix the vfat tests output
> >  - fixed behavior when fs tests are executed directly
> >  - simplified the code changed/added by the last patch
> >
> > Ondrej Mosnacek (4):
> >   README,travis: add e2fsprogs, jfsutils, and dosfstools to deps
> >   tests/filesystem: pipe "yes" to mkfs.* to fix jfs test
> >   tests/[fs_]filesystem: fix unwanted error output when testing vfat
> >   tests/[fs_]filesystem: test all filesystems
>
>
> Apart from the minor nit in patch 1, all fs types tested okay so:
>
> Acked-by: Richard Haines <richard_c_haines@btinternet.com>

Thanks, all four patches are now applied:
https://github.com/SELinuxProject/selinux-testsuite/commits/071ec9c5e5f0442aae0b14f455ea6e6b34ada1e0

>
> >
> >  README.md                      |  6 ++++
> >  tests/Makefile                 |  8 +++--
> >  tests/filesystem/Filesystem.pm |  2 +-
> >  tests/filesystem/ext4          |  1 +
> >  tests/filesystem/jfs           |  1 +
> >  tests/filesystem/test          | 58 +++++++++++++++---------------
> >  tests/filesystem/vfat          |  1 +
> >  tests/filesystem/xfs           |  1 +
> >  tests/fs_filesystem/ext4       |  1 +
> >  tests/fs_filesystem/jfs        |  1 +
> >  tests/fs_filesystem/test       | 64 ++++++++++++++++--------------
> > ----
> >  tests/fs_filesystem/vfat       |  1 +
> >  tests/fs_filesystem/xfs        |  1 +
> >  travis-ci/run-testsuite.sh     |  3 ++
> >  14 files changed, 83 insertions(+), 66 deletions(-)
> >  create mode 120000 tests/filesystem/ext4
> >  create mode 120000 tests/filesystem/jfs
> >  create mode 120000 tests/filesystem/vfat
> >  create mode 120000 tests/filesystem/xfs
> >  create mode 120000 tests/fs_filesystem/ext4
> >  create mode 120000 tests/fs_filesystem/jfs
> >  create mode 120000 tests/fs_filesystem/vfat
> >  create mode 120000 tests/fs_filesystem/xfs
> >
>

-- 
Ondrej Mosnacek
Software Engineer, Platform Security - SELinux kernel
Red Hat, Inc.

