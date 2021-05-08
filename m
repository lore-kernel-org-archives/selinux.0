Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B1CAC433B4
	for <selinux@archiver.kernel.org>; Sat,  8 May 2021 17:28:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5AD061154
	for <selinux@archiver.kernel.org>; Sat,  8 May 2021 17:28:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbhEHR3j (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 8 May 2021 13:29:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:23264 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229523AbhEHR3j (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sat, 8 May 2021 13:29:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620494917;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UAUFElk95f6sBR8hOLzEc1rgqfATOAb7rDamIwdY5DA=;
        b=J+p0suTfzi7GMGPxbPZf/b4lC3yKEQAqG7Rwc3+20xCjRFH8S6ufp/1JMoIZZaN+eUO9bC
        W9+mU9FAWH+jbb8d1HHcmzhjR/7lFpWQMNC8zxwHn6JwVOIOp9lxl6gu5CDphV6fwnzR+S
        hDsP468Q6vZiJu/RWFQQVJRb5+fdXtA=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-446-XX43t0TbNrS9F5_XXyxEBQ-1; Sat, 08 May 2021 13:28:34 -0400
X-MC-Unique: XX43t0TbNrS9F5_XXyxEBQ-1
Received: by mail-yb1-f198.google.com with SMTP id d20-20020a25add40000b02904f8960b23e8so4186431ybe.6
        for <selinux@vger.kernel.org>; Sat, 08 May 2021 10:28:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UAUFElk95f6sBR8hOLzEc1rgqfATOAb7rDamIwdY5DA=;
        b=hKVOy9+i9QkrXqeZ1kklyq46HoGwJG4Iz5eSFVlsL0myuAFPgB2sbTLWKY7mG10abc
         BtKlMHoH+fYyBWXfJcaB3n32uW/2TnCdyPPAyrEkUbzLg9DRoB2OxTra+QNedo9qzSy/
         J7vHoHN1baBqTDsKT0UTh2lC9t/U7tCjpjdLYXr/alvFHU99kPWPHJlZDA95Qx0mLvx9
         /blUE3+A4Aj3+c4C4s/kzXmRQbmstUtzh5pACrroJDd8d4W4RnciI0C7FSwxjwEmYFjO
         AGJ4SoKXaMsiPs9eEfDiq8dVvc1PiDKtm0v5nmWTFMhv9tCMQ7VuyI8geJCaUboFm54s
         D0zg==
X-Gm-Message-State: AOAM531M+2iyM6Cs9p9imzsVoYBox5xM0fk7R5BTp2DHtYpJ39gqEeLi
        u8tdGWJSDAw0Wf2QXx2EwElp3FKJJaFUig3Rrz8iN5h47z3exCZWBNztOVsIC3pUnu3dwLZ6GYf
        s42fidjC9NqMK80asKeSTZFJ57o/1qyufeA==
X-Received: by 2002:a25:6886:: with SMTP id d128mr21916434ybc.227.1620494914054;
        Sat, 08 May 2021 10:28:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx51IRdLREGujKPlqXCba5hqWA2wZEVfxpZdBfEp8Vvn+ChVz32OXRHfnghkdB0oiE7t3HaVIrYiTXqQLeQjWs=
X-Received: by 2002:a25:6886:: with SMTP id d128mr21916413ybc.227.1620494913835;
 Sat, 08 May 2021 10:28:33 -0700 (PDT)
MIME-Version: 1.0
References: <20210329183939.1964411-1-dbrazdil@google.com>
In-Reply-To: <20210329183939.1964411-1-dbrazdil@google.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Sat, 8 May 2021 19:28:18 +0200
Message-ID: <CAFqZXNuQJmXSiche8JiFadTM_YZ6fa1zyPWX79dMYhtUF97QMQ@mail.gmail.com>
Subject: Re: [PATCH testsuite] Add AF_VSOCK SOCK_STREAM client/server tests
To:     David Brazdil <dbrazdil@google.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Mar 29, 2021 at 8:39 PM David Brazdil <dbrazdil@google.com> wrote:
> If AF_VSOCK and vsock_loopback are supported by the system, run tests
> that exchange a byte of data between a client and a server listening on
> VMADDR_CID_LOCAL and a random port.
>
> Various permissions are removed from the client/server between runs and
> it is checked that the corresponding syscalls returned error.
>
> A newly created vsock_socket inherits the SID of the current process and
> it is tested that the vsock_socket returned by accept() inherits the same
> SID from its parent.
>
> SOCK_DGRAM is not tested as it is only supported in the VMCI transport.
>
> These tests depend on an upstream commit 1f935e8e72ec ("selinux: vsock:
> Set SID for socket returned by accept()"). It was first released in v5.12
> and backported to all the stable branches.
>
> Signed-off-by: David Brazdil <dbrazdil@google.com>
> ---
> This is also posted on GitHub as pull request #75:
>   https://github.com/SELinuxProject/selinux-testsuite/pull/75
>
> The patch that fixes the vsock_socket bug has been merged to 5.12 and
> backported to 5.10-stable and 5.11-stable. Backport all the way back
> to 4.4-stable is awaiting merging here:
>   https://lkml.kernel.org/stable/20210329182443.1960963-1-dbrazdil@google.com
> Since the expectation is that all stable kernels will soon have the patch,
> I skipped a kernel version check in this test.
>
>  policy/Makefile                  |   2 +-
>  policy/test_vsock_socket.te      |  52 ++++++++++++
>  tests/Makefile                   |   2 +-
>  tests/vsock_socket/.gitignore    |   3 +
>  tests/vsock_socket/Makefile      |   7 ++
>  tests/vsock_socket/check_vsock.c |  47 +++++++++++
>  tests/vsock_socket/client.c      | 129 ++++++++++++++++++++++++++++
>  tests/vsock_socket/server.c      | 140 +++++++++++++++++++++++++++++++
>  tests/vsock_socket/test          | 118 ++++++++++++++++++++++++++
>  9 files changed, 498 insertions(+), 2 deletions(-)
>  create mode 100644 policy/test_vsock_socket.te
>  create mode 100644 tests/vsock_socket/.gitignore
>  create mode 100644 tests/vsock_socket/Makefile
>  create mode 100644 tests/vsock_socket/check_vsock.c
>  create mode 100644 tests/vsock_socket/client.c
>  create mode 100644 tests/vsock_socket/server.c
>  create mode 100755 tests/vsock_socket/test

Sorry for the late review... I finally looked at the patch and all
looks good, so I applied it (I used the version from the pull
request):
https://github.com/SELinuxProject/selinux-testsuite/commit/0a3f86ab841efa0f2bbd048243a801915d6808ba

Since the bare F33 cloud image has quite an old kernel that doesn't
have the fix, I had to tweak the CI scripts a little so that the CI
passes:
https://github.com/SELinuxProject/selinux-testsuite/commit/aa799e6f1719d52b570a96229e3b207b9b3515d9

Thank you for the contribution!

-- 
Ondrej Mosnacek
Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

