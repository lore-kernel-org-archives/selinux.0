Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FAA8EB64D9
	for <selinux@archiver.kernel.org>; Thu, 29 Jun 2023 08:48:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231835AbjF2Is3 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 29 Jun 2023 04:48:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232041AbjF2IsA (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 29 Jun 2023 04:48:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 394634483
        for <selinux@vger.kernel.org>; Thu, 29 Jun 2023 01:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688028316;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NpB4UNZNNDyUDz/GtMfHbtcEU6Qm/yGNcUKd3dNnilQ=;
        b=XmjLqxJFwgUII3n/pZkcNQZSa7QAFEHwLkpaxdbfOul+9Cs8eZsKIzZuA0fN4QErH/zDmO
        4ADKJVgEg2Zdykriyof3J3rqcbvr+R4ER7KpfYnEqSfo3e65g2N+0iGlTsdIEBcnyi8pKt
        gY5wxva3I3XrDesreNE6oq1mUHHBpyA=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-22-XXGW6tqVMc-chaDcC7rcJQ-1; Thu, 29 Jun 2023 04:45:15 -0400
X-MC-Unique: XXGW6tqVMc-chaDcC7rcJQ-1
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-76735d5eb86so44523985a.3
        for <selinux@vger.kernel.org>; Thu, 29 Jun 2023 01:45:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688028314; x=1690620314;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NpB4UNZNNDyUDz/GtMfHbtcEU6Qm/yGNcUKd3dNnilQ=;
        b=fwPyBfOzV6YAl1Lg7jP569Nycc3iT/aT4VAZ5yc7wRZfQ6NnMX7lE8GKlqVqqYB+2D
         X4XqcvcrlsRjxfdQdCQfrlSo/DYEHwT18A78RjNuVBtMXeTX7xYdq1SMynaW2U6Lkabw
         4YZSj0kokKzoHI7eltPkrXU+RTPgvI+OtQogu0Bu49PlrSpfAs9wapF7xeXWGQeIw8Ow
         qxLw/ALHMtQzj0YrbU5JgOEHly55CgNiFuSYbTGjJcZ7rlibkZZp1+tcfWLbOq9c8c0P
         3KMqtNfXcqHF2Bazg5IrXoMc0IjLaXr+hJuhhZb9jeLxT9Ay5PeMm0ax+KseYCFP2S82
         hEKQ==
X-Gm-Message-State: AC+VfDyAyGtMUN6tvubU7mKEljFhSKTmiLnKRSVfJo1Yi3/dR9YyDfHH
        o/Bprv1eZRr7iHI9MRkQna2k5JKdG7KGa96BikxL0PfBHau4T/Xil/6hUZ4u2LMDkp8jF30oSSc
        hv+UTkLPlD8kRJJCuyTAprR1f7giWr7nxj8TUcnuL+918slM=
X-Received: by 2002:a05:620a:4109:b0:765:7c13:134f with SMTP id j9-20020a05620a410900b007657c13134fmr15344785qko.69.1688028314423;
        Thu, 29 Jun 2023 01:45:14 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4dUdkMOPNLa0QQwtocm25DL2B1tHKI80y7DH3QyPj5I2hGycm54zbqCm2ygDj0gNGR2e+iLhJl29wqgVHwyA4=
X-Received: by 2002:a05:620a:4109:b0:765:7c13:134f with SMTP id
 j9-20020a05620a410900b007657c13134fmr15344777qko.69.1688028314169; Thu, 29
 Jun 2023 01:45:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230619084809.19794-1-omosnace@redhat.com>
In-Reply-To: <20230619084809.19794-1-omosnace@redhat.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Thu, 29 Jun 2023 10:45:02 +0200
Message-ID: <CAFqZXNsBzq9_7F0sp5WyAT-4MikJjZ6Z5D+F_NzXEOSWuQri7A@mail.gmail.com>
Subject: Re: [PATCH testsuite] tests/inet_socket: cover the MPTCP protocol
To:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Jun 19, 2023 at 10:48=E2=80=AFAM Ondrej Mosnacek <omosnace@redhat.c=
om> wrote:
>
> As of kernel 6.5 MPTCP should work as a drop-in replacement for TCP
> w.r.t. SELinux, so test it in addition to TCP using the same tests.
>
> This requires modifying the inet_socket test to test each protocol
> separately, using the same subdirectory symlink trick as in the
> [fs_]filesystem tests. After that, an mptcp subtest can be added easily
> by extending the programs to support it and adding a new subdirectory
> symlink for it.
>
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>  tests/Makefile              |  10 +-
>  tests/inet_socket/bind.c    |  22 +-
>  tests/inet_socket/client.c  |  33 ++-
>  tests/inet_socket/connect.c |  27 ++-
>  tests/inet_socket/mptcp     |   1 +
>  tests/inet_socket/server.c  |  33 ++-
>  tests/inet_socket/tcp       |   1 +
>  tests/inet_socket/test      | 430 +++++++++++++++++-------------------
>  tests/inet_socket/udp       |   1 +
>  9 files changed, 292 insertions(+), 266 deletions(-)
>  create mode 120000 tests/inet_socket/mptcp
>  create mode 120000 tests/inet_socket/tcp
>  create mode 120000 tests/inet_socket/udp

The new test now runs and passes on the latest secnext kernel, so I've
applied the patch:
https://github.com/SELinuxProject/selinux-testsuite/commit/4dcea27ada77f51c=
2868095e951aab790374fba9

--=20
Ondrej Mosnacek
Senior Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

