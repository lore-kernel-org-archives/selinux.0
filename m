Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BADCC433F5
	for <selinux@archiver.kernel.org>; Mon, 31 Jan 2022 13:48:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376324AbiAaNsO (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 31 Jan 2022 08:48:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:43779 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1358762AbiAaNsO (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 31 Jan 2022 08:48:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643636893;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gPadflRndKn1I0aulaiG2If4pJroMwlVKCCuMQRLHvU=;
        b=BIyrCTW3aHiT66QWAOA66u4JoI+aEcPQzzCK4xON145iq2ToPAu/FdcUp4EzgtfBxAhgph
        6znj+aYox8K35f1r3ylIsFqiaFxKo7itEW4FlWZ32MNh/XNkNAymQwLqoZVnmO7thx9qTO
        mrcfAzNvnfuuct+wRcxG6z2C9hhgrO8=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-532-cVQch2EXN5OAcU6QME114g-1; Mon, 31 Jan 2022 08:48:12 -0500
X-MC-Unique: cVQch2EXN5OAcU6QME114g-1
Received: by mail-yb1-f197.google.com with SMTP id 127-20020a250f85000000b00611ab6484abso26686960ybp.23
        for <selinux@vger.kernel.org>; Mon, 31 Jan 2022 05:48:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=gPadflRndKn1I0aulaiG2If4pJroMwlVKCCuMQRLHvU=;
        b=764S1Ajj48uf4KnfqGp21lLZNyWR6xGYhTPIW+5nprCiKAQN1fTDzWyGJ7UXNYsyrP
         mohrXPCMztpEJQAXUaCb4cfcHiIxefHKjOKYpsd8v2qRRxZDqtpoCTcxnKpNc8QQkpB8
         jnTnJ3NZIbsf/LO+zxaqE1+6tJ0DUBXZ+xzqGxiE6QX2SYiICz+j0INyNxDbYDcNNQaj
         sEG6aHipMtpepMed+yx4XQCmE8Qd1XoSCkbRdA42d7nHyToCnBOXbMtQyN8S5SO/9uB3
         C+d6d/JLREw/Hjg2tie6vVVMwUTgRvzAgfim9uo7/gukrcrgl8VxASvg5HOeW0rwya1V
         MFIw==
X-Gm-Message-State: AOAM53308zqK86Fz8ZK31N4J4qU79Pr2B+Ku0OHkdNhZufncgFDC/vUW
        27VgM2mlgs0IVKMFKpPY9feOYN9+7hPs7BggYdZ0Nk+WruH0fEf3YhsgMNujwDC9JSJH3boA2Hc
        g4haBRUj1LDOYdX5deNUR/GYSWUzBx6Nylw==
X-Received: by 2002:a25:d90a:: with SMTP id q10mr30238038ybg.253.1643636891951;
        Mon, 31 Jan 2022 05:48:11 -0800 (PST)
X-Google-Smtp-Source: ABdhPJywnnnroVBO0TW4dFJ/flJ9I+2bsntouiv5TEL9eqaIGOjgf+JUP8x4fWdGklL+0E0h+MLx+jw2hdl1hbYLTtM=
X-Received: by 2002:a25:d90a:: with SMTP id q10mr30238016ybg.253.1643636891752;
 Mon, 31 Jan 2022 05:48:11 -0800 (PST)
MIME-Version: 1.0
References: <20220113020915.13560-1-gongruiqi1@huawei.com>
In-Reply-To: <20220113020915.13560-1-gongruiqi1@huawei.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Mon, 31 Jan 2022 14:47:54 +0100
Message-ID: <CAFqZXNsCMkxeGrvXrWRr71FByV-cKJL2zK+o1Xr=AKPY8mjS4g@mail.gmail.com>
Subject: Re: [PATCH testsuite] tests/binder: Build only for 4.11 and later kernels
To:     "GONG, Ruiqi" <gongruiqi1@huawei.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Wang Weiyang <wangweiyang2@huawei.com>,
        Xiu Jianfeng <xiujianfeng@huawei.com>,
        Xiang Yang <xiangyang3@huawei.com>,
        Cui Gaosheng <cuigaosheng1@huawei.com>,
        Lu Jialin <lujialin4@huawei.com>, Yi Yang <yiyang13@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Jan 13, 2022 at 2:48 AM GONG, Ruiqi <gongruiqi1@huawei.com> wrote:
> Following compilation errors occur when building the tests with
> userspace headers exported from kernel 4.4:
>
> binder_common.c:111:14: error: =E2=80=98const struct flat_binder_object=
=E2=80=99 has no
> member named =E2=80=98hdr=E2=80=99
>    switch (obj->hdr.type) {
>               ^
> client.c:58:9: error: dereferencing pointer to incomplete type
>   if (obj->hdr.type !=3D BINDER_TYPE_FD) {
>          ^
>
> It's been checked that member `hdr` of `struct flat_binder_object` and
> `struct binder_fd_object` were both introduced by commit feba3900cabb
> ("binder: Split flat_binder_object") in kernel v4.11-rc1. Fix this
> by adding kernel version check at compile time.

Sorry for the late reaction... In a corner case, one might be on a
system where the kernel UAPI headers don't match the running kernel
version 100%, so I'd prefer to grep the header for 'struct
binder_fd_object' over a kernel version check here. In this case the
actual ABI is the same before and after the kernel commit, so it makes
sense to only check if we have a <linux/android/binder.h> that we can
compile against.

Something like:

ifeq ($(shell grep -q 'struct binder_fd_object'
$(INCLUDEDIR)/linux/android/binder.h && echo true),true)
...
endif

> Signed-off-by: GONG, Ruiqi <gongruiqi1@huawei.com>
>
> ---
>  tests/Makefile | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/tests/Makefile b/tests/Makefile
> index 3f7cae3..22458a7 100644
> --- a/tests/Makefile
> +++ b/tests/Makefile
> @@ -54,8 +54,10 @@ SUBDIRS +=3D prlimit
>  endif
>
>  ifeq ($(shell grep -q binder $(POLDEV)/include/support/all_perms.spt && =
test -e $(INCLUDEDIR)/linux/android/binder.h && echo true),true)
> +ifneq ($(shell ./kvercmp $$(uname -r) 4.11),-1)
>  SUBDIRS +=3D binder
>  endif
> +endif
>
>  ifeq ($(shell grep -q bpf $(POLDEV)/include/support/all_perms.spt && ech=
o true),true)
>  ifneq ($(shell ./kvercmp $$(uname -r) 4.15),-1)
> --
> 2.17.1
>

--
Ondrej Mosnacek
Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

