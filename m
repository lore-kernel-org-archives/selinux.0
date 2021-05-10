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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E751FC433ED
	for <selinux@archiver.kernel.org>; Mon, 10 May 2021 09:00:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8ED660FE8
	for <selinux@archiver.kernel.org>; Mon, 10 May 2021 09:00:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230153AbhEJJBq (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 10 May 2021 05:01:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbhEJJBp (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 10 May 2021 05:01:45 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EC44C061573
        for <selinux@vger.kernel.org>; Mon, 10 May 2021 02:00:41 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id v12so15729281wrq.6
        for <selinux@vger.kernel.org>; Mon, 10 May 2021 02:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qkfjI9YUbexJzEPRdnA5xzicAgkcOQYcyghdacpdvRQ=;
        b=XfG6wkONn5oXwU9AqAqRBathsd65NV7DhEaC7VyHc6loD02yAzKjqufhmOWEQbfjBZ
         WPWsxFP0/mRvb2ccWKO24lTwwaopyvXiYAQ773iEc99CT16IfT9xC6gsX/jdDHBq7nwT
         fdpMAYXbMz1OS57QaecsXEQwNwuDHmwQ0CF1ygTkBadNhLOQRlkOkV+h8XC+eitTb5gu
         4E3vFNdlgNxpT/xZyMZOXwa3TGSHcXbplQZUe3Sh11HYgGoPB9E4JZ6MeI505ZX4vgGG
         Lsmw2anocG9MItapFLG0Xu638NdyLTr1ZYoHk7FLnpgpucezYCn6TXGVZoZIX4jbhoPY
         QX1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qkfjI9YUbexJzEPRdnA5xzicAgkcOQYcyghdacpdvRQ=;
        b=rI2naeXZV5o+EhpFgnc231RMUO7ei+G18u0PsHiSeK/3wbl4yNv4whm1xCzzf+UDPv
         c/ye9b6nSLEhpDLFOX7GVfI2HL/KEQFldSofI0L0lwTADOmspKI3mS+vYQf1BmvJcmpP
         XrAvnixZFkqjGDcBfzTct7TyaA5hJTISE9hxmynD4DHAQzTccQPEpH4Cl348psvoNo6h
         by2fg0l/flDeOzVMSTs615ADXMd0Ie7/a3PEIE5q8aGtcAHcHHakh2LsSTMkUScHWlzw
         JOPAB3Euri4rIvZmcxgrkLJKMnsQC5l4Bdy/dQ0FEY8kH3C9Kv5EvTpog8ZR6WS0bkOh
         Hmgw==
X-Gm-Message-State: AOAM5302vhbzDH5BL46CUe5nK1VNKspDm7UNznPcjrM9W3UCkOMS0S/N
        9C0h1mVYLAE1a0SS18nK60jVeA==
X-Google-Smtp-Source: ABdhPJw08iic8l7bnDM6TO3foC9vqU2kLHT4YA45mJsAQGMdAXaeSiRo9bAeV+OiMW4RSf08FT3moQ==
X-Received: by 2002:adf:ce12:: with SMTP id p18mr29500119wrn.228.1620637239368;
        Mon, 10 May 2021 02:00:39 -0700 (PDT)
Received: from google.com (216.131.76.34.bc.googleusercontent.com. [34.76.131.216])
        by smtp.gmail.com with ESMTPSA id k11sm24247119wmj.1.2021.05.10.02.00.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 May 2021 02:00:38 -0700 (PDT)
Date:   Mon, 10 May 2021 09:00:35 +0000
From:   David Brazdil <dbrazdil@google.com>
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>
Subject: Re: [PATCH testsuite] Add AF_VSOCK SOCK_STREAM client/server tests
Message-ID: <YJj2M+DyfRmvoK8Q@google.com>
References: <20210329183939.1964411-1-dbrazdil@google.com>
 <CAFqZXNuQJmXSiche8JiFadTM_YZ6fa1zyPWX79dMYhtUF97QMQ@mail.gmail.com>
 <CAFqZXNsj7ioO80hNUfwnZY9YZ0jOxc7b0UimCMtySVNnou=B+g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFqZXNsj7ioO80hNUfwnZY9YZ0jOxc7b0UimCMtySVNnou=B+g@mail.gmail.com>
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Sat, May 08, 2021 at 09:27:01PM +0200, Ondrej Mosnacek wrote:
> On Sat, May 8, 2021 at 7:28 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > On Mon, Mar 29, 2021 at 8:39 PM David Brazdil <dbrazdil@google.com> wrote:
> > > If AF_VSOCK and vsock_loopback are supported by the system, run tests
> > > that exchange a byte of data between a client and a server listening on
> > > VMADDR_CID_LOCAL and a random port.
> > >
> > > Various permissions are removed from the client/server between runs and
> > > it is checked that the corresponding syscalls returned error.
> > >
> > > A newly created vsock_socket inherits the SID of the current process and
> > > it is tested that the vsock_socket returned by accept() inherits the same
> > > SID from its parent.
> > >
> > > SOCK_DGRAM is not tested as it is only supported in the VMCI transport.
> > >
> > > These tests depend on an upstream commit 1f935e8e72ec ("selinux: vsock:
> > > Set SID for socket returned by accept()"). It was first released in v5.12
> > > and backported to all the stable branches.
> > >
> > > Signed-off-by: David Brazdil <dbrazdil@google.com>
> > > ---
> > > This is also posted on GitHub as pull request #75:
> > >   https://github.com/SELinuxProject/selinux-testsuite/pull/75
> > >
> > > The patch that fixes the vsock_socket bug has been merged to 5.12 and
> > > backported to 5.10-stable and 5.11-stable. Backport all the way back
> > > to 4.4-stable is awaiting merging here:
> > >   https://lkml.kernel.org/stable/20210329182443.1960963-1-dbrazdil@google.com
> > > Since the expectation is that all stable kernels will soon have the patch,
> > > I skipped a kernel version check in this test.
> > >
> > >  policy/Makefile                  |   2 +-
> > >  policy/test_vsock_socket.te      |  52 ++++++++++++
> > >  tests/Makefile                   |   2 +-
> > >  tests/vsock_socket/.gitignore    |   3 +
> > >  tests/vsock_socket/Makefile      |   7 ++
> > >  tests/vsock_socket/check_vsock.c |  47 +++++++++++
> > >  tests/vsock_socket/client.c      | 129 ++++++++++++++++++++++++++++
> > >  tests/vsock_socket/server.c      | 140 +++++++++++++++++++++++++++++++
> > >  tests/vsock_socket/test          | 118 ++++++++++++++++++++++++++
> > >  9 files changed, 498 insertions(+), 2 deletions(-)
> > >  create mode 100644 policy/test_vsock_socket.te
> > >  create mode 100644 tests/vsock_socket/.gitignore
> > >  create mode 100644 tests/vsock_socket/Makefile
> > >  create mode 100644 tests/vsock_socket/check_vsock.c
> > >  create mode 100644 tests/vsock_socket/client.c
> > >  create mode 100644 tests/vsock_socket/server.c
> > >  create mode 100755 tests/vsock_socket/test
> >
> > Sorry for the late review... I finally looked at the patch and all
> > looks good, so I applied it (I used the version from the pull
> > request):
> > https://github.com/SELinuxProject/selinux-testsuite/commit/0a3f86ab841efa0f2bbd048243a801915d6808ba
Brilliant, thanks!

> 
> Actually, I missed that there were two compiler warnings when
> compiling the C code. They were trivial, so I pushed a fix:
> https://github.com/SELinuxProject/selinux-testsuite/commit/db6c1cc4c9631e1b44ee5a0c40ec7ede68ab43f9

Oops, thanks for fixing those.

> 
> I also enabled -Werror in CI, so that they are more visible in the future:
> https://github.com/SELinuxProject/selinux-testsuite/commit/0b78a9d433e8c4f956d18dc0db901f0a1a58c003
> 
> -- 
> Ondrej Mosnacek
> Software Engineer, Linux Security - SELinux kernel
> Red Hat, Inc.
> 
