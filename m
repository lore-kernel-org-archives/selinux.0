Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C232C433FE
	for <selinux@archiver.kernel.org>; Wed,  9 Feb 2022 19:29:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234898AbiBIT31 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 9 Feb 2022 14:29:27 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:55012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234955AbiBIT3I (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 9 Feb 2022 14:29:08 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3FC4DC1DC5CC
        for <selinux@vger.kernel.org>; Wed,  9 Feb 2022 11:29:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644434949;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PSmVE2OrnGrtuhAc64Sl6Sm6sVS5qZ3NhKM85vz5wJk=;
        b=iaQEsj0EN75vNynmhVwJ4Iiv4KinyE8n25VGEUFu/QN1qtnCCNFSOfX7dIFR3M7lKgvAf6
        hZrEYCNWopohCeaUejeNsieR2e4lhudLu/fiD/wQb83dakcEy+voLsgm1R1Vh4ivPT5Lwz
        Vq7HH8/3SQ20C7UGIqpQ+RDun/uv5vI=
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com
 [209.85.219.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-96-xMLhIzJ5MlqkTGhzYFn7aQ-1; Wed, 09 Feb 2022 14:29:08 -0500
X-MC-Unique: xMLhIzJ5MlqkTGhzYFn7aQ-1
Received: by mail-yb1-f200.google.com with SMTP id 127-20020a250f85000000b00611ab6484abso6723267ybp.23
        for <selinux@vger.kernel.org>; Wed, 09 Feb 2022 11:29:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=PSmVE2OrnGrtuhAc64Sl6Sm6sVS5qZ3NhKM85vz5wJk=;
        b=XyMZobrH8t7GuIOto+Rk3mdPlEDURG5xpeYafpk6l4D+4y06bXo9jtjUN7gBMPsC+g
         mfFhTsHxJfTO/twaMmjxtwcO5VCCzkrb1AusDcJoy4cn7+etm8bJdNacK+ApgrrUEocz
         Awp8xdCbuCxB63JKTulbA4hMjKjL15x068XCsYtugZ6oCzyXZPE6ZXeHmmtv9Y1nvHfe
         I+c0JZxSSJcs5+mtDaX68PbIoAq7CtsEzUFVLc42Chg9iqDUR7fdYf0VPKk7aWaN/iWi
         UlAdXMSW9ExvVapWJuUm+JMfwmawcuvKfL09lT/eWsPNpYwP7fID7FRpsp1P9LK2XBIP
         5v0Q==
X-Gm-Message-State: AOAM530DDKMk2hd6kZvN79cgFdk9D/sw4nYzyU3FLQX7lFubL7hLUrGW
        I3mozO0i7/rMIIkC01KMxaqNqA7b3YDNkJIdRz2uD1HptFi9kY5lBDVqk3eJLl1Zhm6sfFUFWyH
        vJmphCuwfyXGVPyEEMAtRiE8mpg7eVU6ubA==
X-Received: by 2002:a25:e64e:: with SMTP id d75mr3781636ybh.253.1644434947800;
        Wed, 09 Feb 2022 11:29:07 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy2zgG7RlUOSRzy+Ex+FK5e2l1/D7VBBs4SIVhYNURjgxBRP8LNUs/uz1MTTEc/TfwCj4Spc5cf5CrwWkGIuIo=
X-Received: by 2002:a25:e64e:: with SMTP id d75mr3781618ybh.253.1644434947600;
 Wed, 09 Feb 2022 11:29:07 -0800 (PST)
MIME-Version: 1.0
References: <20220209114242.2229-1-gongruiqi1@huawei.com>
In-Reply-To: <20220209114242.2229-1-gongruiqi1@huawei.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Wed, 9 Feb 2022 20:28:50 +0100
Message-ID: <CAFqZXNtMw83Hw1ygoYQo35A9wunMaCx_5XGnWO258pmpzgHTew@mail.gmail.com>
Subject: Re: [PATCH testsuite] tests/binder: Adjust kernel uapi headers check
 for building
To:     "GONG, Ruiqi" <gongruiqi1@huawei.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Wang Weiyang <wangweiyang2@huawei.com>,
        Xiu Jianfeng <xiujianfeng@huawei.com>,
        Xiang Yang <xiangyang3@huawei.com>,
        Cui Gaosheng <cuigaosheng1@huawei.com>,
        Lu Jialin <lujialin4@huawei.com>,
        Yi Yang <yiyang13@huawei.com>, Guo Zihua <guozihua@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Feb 9, 2022 at 12:22 PM GONG, Ruiqi <gongruiqi1@huawei.com> wrote:
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
> `struct binder_fd_object` were both introduced into kernel 4.11 by the
> same commit feba3900cabb ("binder: Split flat_binder_object"). Change
> the check to <linux/android/binder.h> before building binder tests to
> see if it contains the definition of `struct binder_fd_object`.
>
> Signed-off-by: GONG, Ruiqi <gongruiqi1@huawei.com>
> ---
>  tests/Makefile | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/tests/Makefile b/tests/Makefile
> index 3f7cae3..273eed8 100644
> --- a/tests/Makefile
> +++ b/tests/Makefile
> @@ -53,9 +53,11 @@ ifeq ($(shell grep -q getrlimit $(POLDEV)/include/supp=
ort/all_perms.spt && echo
>  SUBDIRS +=3D prlimit
>  endif
>
> -ifeq ($(shell grep -q binder $(POLDEV)/include/support/all_perms.spt && =
test -e $(INCLUDEDIR)/linux/android/binder.h && echo true),true)
> +ifeq ($(shell grep -q binder $(POLDEV)/include/support/all_perms.spt && =
echo true),true)
> +ifeq ($(shell grep -q 'struct binder_fd_object' $(INCLUDEDIR)/linux/andr=
oid/binder.h && echo true),true)
>  SUBDIRS +=3D binder
>  endif
> +endif
>
>  ifeq ($(shell grep -q bpf $(POLDEV)/include/support/all_perms.spt && ech=
o true),true)
>  ifneq ($(shell ./kvercmp $$(uname -r) 4.15),-1)
> --
> 2.18.0.huawei.25
>

Thanks, the patch is now applied:
https://github.com/SELinuxProject/selinux-testsuite/commit/04382a411d113353=
c3bd7b6a1d7cbb0ac050d62c

I just added -s to the grep invocation so that it doesn't print an
error when the file doesn't exist, as done by other similar checks.

--=20
Ondrej Mosnacek
Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

