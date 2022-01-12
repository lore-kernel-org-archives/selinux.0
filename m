Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3124CC433EF
	for <selinux@archiver.kernel.org>; Wed, 12 Jan 2022 15:28:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240264AbiALP2d (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 12 Jan 2022 10:28:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240181AbiALP2d (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 12 Jan 2022 10:28:33 -0500
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 129B7C06173F
        for <selinux@vger.kernel.org>; Wed, 12 Jan 2022 07:28:33 -0800 (PST)
Received: by mail-oi1-x22d.google.com with SMTP id s22so3760092oie.10
        for <selinux@vger.kernel.org>; Wed, 12 Jan 2022 07:28:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=pjYcyfgadb1nMP1k76MaGZ6yHQL2Ya1uIiZFke6hQSU=;
        b=Jw1dZJyOb0hgJlLZXp2r/XPoQJ6EfrVtOdcBith6DEmivvSVODRrPkkEHU08HolJnE
         CPLc8wIkFfFZbL5KkgpS6vicVTCq8gT8Sz/xQbKUsqExX3eFDURpJH/6C8CcVb82EkXD
         UQSp18kDlGbuvq1afZR/Tg6flom0AexNZ2J2Eeia7GrMfckHq6t/oCvZUwN9Qis3UIGf
         Rb/zLKIsq9PVupSLx+h5bPLVgQzC7hYj45BQGbWdH6Z5/mqkxW95XCMjcq/xYI/YYdiF
         XHqMXKhjfWqcIgffdvLqu4+JMGdpA5UEgIYeFigdgTG2EBkrNqx4prfJ1LspsUjxrB6E
         RBZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=pjYcyfgadb1nMP1k76MaGZ6yHQL2Ya1uIiZFke6hQSU=;
        b=HK/FSje2SWZWitFACdxJQcSQeWTJzdl0y4OxXD6rMBAZQd/hpAWhls64D+m0bdErEN
         58f7S95QTI4Ii9F5VfXskiWIM+LeMug0yi3K2KYUBWPknNxOjjfYKd2hwXHcQuMVdNan
         DyoyjwLryHK+U8zkuFQsDuRG55IcIH7R83CEDaW1AJ1j+hnZamTNnTySFizJiV3FvvSo
         quqLJjoKJ9P33RBDuebtYROCH+Z9SfrZ1dRTpdNf/MYq5SUg0rNyDKJZohCT+Tq8MZkh
         EEUzNU3Zw0s94T3pZgMRHmxmpoWNHECFfE1/9yUl9y/AcV7He06WOxwc6ZGCQV4HssaP
         FO9Q==
X-Gm-Message-State: AOAM532qbMx74z9mSYn5nbAfwJKJfW/YmN5CvyeIu7an5+/zdtlR7srR
        WIsYDyuFZfVtq9keRsFy+EjioQoywRVpYv1Ccrs=
X-Google-Smtp-Source: ABdhPJybjb7Y9OaXk4NC6OGNslMDMK4esr6D3pshOO+PtEl8homQ5FvgrKb8O0TAjGx8kiRADqT7BNfTXpMqvR2ViuM=
X-Received: by 2002:a05:6808:1784:: with SMTP id bg4mr2714801oib.138.1642001312444;
 Wed, 12 Jan 2022 07:28:32 -0800 (PST)
MIME-Version: 1.0
References: <20220106204336.147180-1-cgzones@googlemail.com>
In-Reply-To: <20220106204336.147180-1-cgzones@googlemail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Wed, 12 Jan 2022 10:28:21 -0500
Message-ID: <CAP+JOzSvJR+Lueox=OC9c398cvLJT3CRC=mzQ=SdxkjPVrhkmg@mail.gmail.com>
Subject: Re: [PATCH] libsepol: check for saturated class name length
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Jan 7, 2022 at 1:58 PM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> Check the from the polciy read length value to guard allocations.
>
> In the fuzzer build the value will also be bounded to avoid oom reports.
>
>     =3D=3D143646=3D=3DERROR: AddressSanitizer: allocator is out of memory=
 trying to allocate 0xd60000000 bytes
>         #0 0x4dac18 in __interceptor_calloc (./out/binpolicy-fuzzer+0x4da=
c18)
>         #1 0x55d388 in scope_index_read ./libsepol/src/policydb.c:3945:7
>         #2 0x550097 in avrule_decl_read ./libsepol/src/policydb.c:3984:6
>         #3 0x550097 in avrule_block_read ./libsepol/src/policydb.c:4044:8
>         #4 0x54b3ac in policydb_read ./libsepol/src/policydb.c:4456:7
>         #5 0x518fd9 in LLVMFuzzerTestOneInput ./libsepol/fuzz/binpolicy-f=
uzzer.c:35:6
>         #6 0x43f623 in fuzzer::Fuzzer::ExecuteCallback(unsigned char cons=
t*, unsigned long) (./out/binpolicy-fuzzer+0x43f623)
>         #7 0x42910f in fuzzer::RunOneTest(fuzzer::Fuzzer*, char const*, u=
nsigned long) (./out/binpolicy-fuzzer+0x42910f)
>         #8 0x42ee76 in fuzzer::FuzzerDriver(int*, char***, int (*)(unsign=
ed char const*, unsigned long)) (./out/binpolicy-fuzzer+0x42ee76)
>         #9 0x458ff2 in main (./out/binpolicy-fuzzer+0x458ff2)
>         #10 0x7fd37b7931c9 in __libc_start_call_main csu/../sysdeps/nptl/=
libc_start_call_main.h:58:16
>
> Found by oss-fuzz (#42909)
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libsepol/src/policydb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/libsepol/src/policydb.c b/libsepol/src/policydb.c
> index 79aba3af..562e044e 100644
> --- a/libsepol/src/policydb.c
> +++ b/libsepol/src/policydb.c
> @@ -3937,7 +3937,7 @@ static int scope_index_read(scope_index_t * scope_i=
ndex,
>         if (rc < 0)
>                 return -1;
>         scope_index->class_perms_len =3D le32_to_cpu(buf[0]);
> -       if (scope_index->class_perms_len =3D=3D 0) {
> +       if (zero_or_saturated(scope_index->class_perms_len)) {
>                 scope_index->class_perms_map =3D NULL;
>                 return 0;
>         }
> --
> 2.34.1
>
