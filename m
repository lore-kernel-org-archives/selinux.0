Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAC24C64EC4
	for <selinux@archiver.kernel.org>; Fri,  3 Mar 2023 15:13:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbjCCPNW (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 3 Mar 2023 10:13:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231262AbjCCPNS (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 3 Mar 2023 10:13:18 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B9AA1ADCA
        for <selinux@vger.kernel.org>; Fri,  3 Mar 2023 07:12:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677856351;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0xEWLQBqVbnpe7GdpRGU2Ak8qR/f2DKmilyFmaTa1pQ=;
        b=dElI10mhn1g+jGY4ZBOBsMWNaDD2fL4cedk8ZoCyqB30mRwQL8zaGE+M6dqhycRgJfKjAJ
        PSj0BjQ6cH93bHMgTqhdrXdvM4bexS0EthY7G6u0ggxZqH9NbjEutaeVcw5Y3SZFuYdTcv
        MN5vatGKHk16jVO+9/9V5z+k9lF3Qtw=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-628-fxRwckMKNZaMirQM7yQ4uw-1; Fri, 03 Mar 2023 10:12:30 -0500
X-MC-Unique: fxRwckMKNZaMirQM7yQ4uw-1
Received: by mail-pl1-f200.google.com with SMTP id c3-20020a170902724300b0019d1ffec36dso1527308pll.9
        for <selinux@vger.kernel.org>; Fri, 03 Mar 2023 07:12:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677856349;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0xEWLQBqVbnpe7GdpRGU2Ak8qR/f2DKmilyFmaTa1pQ=;
        b=JNTKMUacJdizlHeXXOkv4uPeTlQoIgI2qw8vyMYNrhAMpUi7yTv9Wdmpd53IN4LaPE
         yxqKRo9i6x2GNl70/Xu+9RajJjNsDJgBsgmJYH2yGzWnD3r/vS92cyUbjUnPp+vAEIfY
         eMZQzXrX70zl2KSjR87nod9vh68e9j0KBrHOLVRozo1CbxyfDDpTax0hV6aDcnjYo49k
         5DSbs5QyBpJCU3H315kdeHrYrBOF6oWa/XiSijFYfa85KsDzrJcbAhLpLmG0ser8dOU2
         IESiyHohAcKe1HZFHLsgzSQlhAqD4wd46fQBQKE6KFBAarVCe0ekr33QZpP77dwMV1jn
         ITUg==
X-Gm-Message-State: AO0yUKUImntM3drtbUsfC7mMZrI4BybqF2WAevhlx3gTe7vAeMD0tbIz
        DhwYQrRZ0l1cvi8Hdkjw06Ma19WZywgSj92NjNdhmFbzqEzMwdbVbLzeDANadWbRrmKUo+emfvx
        omEAqInmZ61LfyfUVeF7gMQCgIX4yCjpceQ4rr2ip1A==
X-Received: by 2002:a62:868b:0:b0:5d6:4f73:97a with SMTP id x133-20020a62868b000000b005d64f73097amr797255pfd.1.1677856348831;
        Fri, 03 Mar 2023 07:12:28 -0800 (PST)
X-Google-Smtp-Source: AK7set/PA0qmwC9gyZ5IgmxMfL2PHS2IjxQZlKTS8i12QK7ivFi4EW4QSZ/+RP+6g1Td0zF9vQi+Gx+JTPl4nC0Vocw=
X-Received: by 2002:a62:868b:0:b0:5d6:4f73:97a with SMTP id
 x133-20020a62868b000000b005d64f73097amr797249pfd.1.1677856348541; Fri, 03 Mar
 2023 07:12:28 -0800 (PST)
MIME-Version: 1.0
References: <20230303140853.1276325-1-omosnace@redhat.com>
In-Reply-To: <20230303140853.1276325-1-omosnace@redhat.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Fri, 3 Mar 2023 16:12:17 +0100
Message-ID: <CAFqZXNv_YpBLxCkY6_v0ASWmkygzPjUQh5d1ME1FJvvY_eDcSQ@mail.gmail.com>
Subject: Re: [PATCH testsuite 0/3] Infiniband test fixes/improvements
To:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Mar 3, 2023 at 3:08=E2=80=AFPM Ondrej Mosnacek <omosnace@redhat.com=
> wrote:
>
> Add missing policy rule needed on systems with strict resource limits,
> add another missing rule to reduce AVC noise, and simplify how IB tests
> are activated.
>
> Tested on an aarch64 machine with an IB device and RHEL-8.7 installed.
>
> v2: add comments explaining the newly added policy rules
>
> Ondrej Mosnacek (3):
>   policy: make sure test_ibpkey_access_t can lock enough memory
>   policy: allow test_ibpkey_access_t to use RDMA netlink sockets
>   tests/infiniband*: simplify test activation
>
>  Vagrantfile                   |  1 +
>  policy/test_ibpkey.te         |  8 +++++++
>  tests/Makefile                | 11 ++-------
>  tests/infiniband_endport/test | 39 ++++++++++++++++++-------------
>  tests/infiniband_pkey/test    | 44 ++++++++++++++++++++---------------
>  5 files changed, 59 insertions(+), 44 deletions(-)
>
> --
> 2.39.2
>

Forgot to add v2 into the subject... Please imagine it's there :)

--
Ondrej Mosnacek
Senior Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

