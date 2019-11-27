Return-Path: <SRS0=LgiC=ZT=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BECAC432C0
	for <selinux@archiver.kernel.org>; Wed, 27 Nov 2019 12:21:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F363720722
	for <selinux@archiver.kernel.org>; Wed, 27 Nov 2019 12:21:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cSE7T38Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726526AbfK0MVa (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 27 Nov 2019 07:21:30 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:45930 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726383AbfK0MVa (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 27 Nov 2019 07:21:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574857288;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lLIGzO8tegQ90chT7fYzmrxGeEaNY+uVdGFdt8NPyKA=;
        b=cSE7T38ZCM8OpoimzdBVtcpipCeyEKVZ5D4pHevykUxwl5A+Yh2CH9iSnNjGnVf4rwSkLX
        jNhFGDf1hCrQisO6PFNNL3OuQJd0Xm2dceOhQxWo/dM+3KvhZKQplmPxUr3u+JezWnkXRC
        KspzwnqWshHdZfXMydk58OLhJdtoxqA=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-58-Pd_GZfnbNqmnt36GYNtdog-1; Wed, 27 Nov 2019 07:21:27 -0500
Received: by mail-ot1-f71.google.com with SMTP id z13so7985645otp.7
        for <selinux@vger.kernel.org>; Wed, 27 Nov 2019 04:21:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FjpVga20A7mcH0ng/vmgMkQlqgmES9iOu/NUByKqXwo=;
        b=G9FY97CYqj2k4strozqfh1ws7n4jKNdGA5qcEHO8dTYA/i8BuqmXyiGXHUMWdyakyW
         Qn0ATxKrf+gMxQcZdEyj1hNVsVoMhyVFjXP5KRMOwTRxgwJyft8VugXdzjA+nGm7+mGb
         7gkxjmfQnxFa0MgoDn67Oe/ezBcipCzcURZNHEDf3kbm2VTtz/wrWjqOu606iSEQDQ6O
         /uhuJd3FUPf5+VdaaPPHlhHWRz02UxbzScnF352z62phxEpVRQ1DOfM/RPaW3eHctPYf
         Te+/PvpcBHx7NKQG+zwP6i9Ixk8ZKRlsfvUqS82K6QrLOzYybzA4hcZ+19onpkwFmKMm
         To5g==
X-Gm-Message-State: APjAAAU4s3KSofa8p1XJNz4xW8U051kiuO2c25V4UB8N3W3LBY/I79F0
        J7xWzyF2A4yy/O1lxrPMHM5xASKNDlSMQ/glpFIM4t1z9qjcgGXaXgMt20hYOsgG4BU19cMyyAE
        9buE/yE47h5eeLL9s/ue36S5ptrTkRZEUZQ==
X-Received: by 2002:a9d:313:: with SMTP id 19mr3378116otv.197.1574857286695;
        Wed, 27 Nov 2019 04:21:26 -0800 (PST)
X-Google-Smtp-Source: APXvYqxxcfoHIR1AlsqeqqVziIZ14cjDgRz/S6uflYRpm5Gmqg44khrjBOAW3UwqWKbJqepHjWoMbYzsGAXt7z2Ou7Y=
X-Received: by 2002:a9d:313:: with SMTP id 19mr3378098otv.197.1574857286422;
 Wed, 27 Nov 2019 04:21:26 -0800 (PST)
MIME-Version: 1.0
References: <20191122164719.98943-1-richard_c_haines@btinternet.com>
In-Reply-To: <20191122164719.98943-1-richard_c_haines@btinternet.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Wed, 27 Nov 2019 13:21:29 +0100
Message-ID: <CAFqZXNvYikN+QNXxLcUis8VQ7z5+DAYeoenK_oM5sLZ_0n7EmQ@mail.gmail.com>
Subject: Re: [PATCH V5] selinux-testsuite: Add kernel module tests
To:     Richard Haines <richard_c_haines@btinternet.com>
Cc:     SElinux list <selinux@vger.kernel.org>
X-MC-Unique: Pd_GZfnbNqmnt36GYNtdog-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Nov 22, 2019 at 5:47 PM Richard Haines
<richard_c_haines@btinternet.com> wrote:
> Test kernel module loading permissions.
>
> Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
> ---
> V2 Change:
> Check permission denial module_load versus module_request by using a
> test kernel module for each.
> Note: Rawhide (with secnext kernel) adds built-in.a and built-in.a.cmd wh=
en
> building modules, therefore added to Makefile and .gitignore.
> V3 Changes:
> As requested in [1] except policy change, coalesced type attributes inste=
ad.
> V4 Change:
> Combine the original initmoddoman and finitmoddomain type
> attribute for both sets of types
> V5 Change:
> Do not run on kernels < 4.7 as module loading not supported.
>
> [1] https://lore.kernel.org/selinux/CAFqZXNtm_X+YssnX_3_5ThkVZY+9SBeQC5Qo=
78s+geSsBok8=3DQ@mail.gmail.com/
>
>  policy/Makefile                           |   4 +
>  policy/test_module_load.te                |  72 +++++++++++++
>  tests/Makefile                            |   6 ++
>  tests/module_load/.gitignore              |  11 ++
>  tests/module_load/Makefile                |  12 +++
>  tests/module_load/finit_load.c            |  94 +++++++++++++++++
>  tests/module_load/init_load.c             | 123 ++++++++++++++++++++++
>  tests/module_load/setest_module_load.c    |  18 ++++
>  tests/module_load/setest_module_request.c |  22 ++++
>  tests/module_load/test                    |  62 +++++++++++
>  10 files changed, 424 insertions(+)
>  create mode 100644 policy/test_module_load.te
>  create mode 100644 tests/module_load/.gitignore
>  create mode 100644 tests/module_load/Makefile
>  create mode 100644 tests/module_load/finit_load.c
>  create mode 100644 tests/module_load/init_load.c
>  create mode 100644 tests/module_load/setest_module_load.c
>  create mode 100644 tests/module_load/setest_module_request.c
>  create mode 100755 tests/module_load/test

Now applied:

https://github.com/SELinuxProject/selinux-testsuite/commit/a68d583c2a70e5d4=
34f4f24d1fcf73b3e22d289e

--=20
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.

