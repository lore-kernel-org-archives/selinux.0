Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64841C54EBC
	for <selinux@archiver.kernel.org>; Thu, 12 Jan 2023 12:12:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233227AbjALMMb (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 12 Jan 2023 07:12:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229839AbjALMMH (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 12 Jan 2023 07:12:07 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 465F425EE
        for <selinux@vger.kernel.org>; Thu, 12 Jan 2023 04:06:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673525191;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CmOD3nMIkOkDtyMs2Cj3I2iqI3g33yjrsofCSblZrqc=;
        b=JCiUasHENbQYLdyA9ZhylLqFtnmKLWItr9Quxb2aeuSAYuJBXENb50xMzIRGa9q1pfppfP
        0THZLmylKrIPi7x5hBe6PX27fH8ljx4MWqsTrx3mjffMus5JR/W++0g4el6swyue2v0mK8
        ou2faegI7osTv4H6g9nuM32hOZGxSVo=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-54-io1oLTE0NQ-Oa1n0SXiBHw-1; Thu, 12 Jan 2023 07:06:30 -0500
X-MC-Unique: io1oLTE0NQ-Oa1n0SXiBHw-1
Received: by mail-pj1-f70.google.com with SMTP id b16-20020a17090a551000b00225aa26f1dbso7979311pji.8
        for <selinux@vger.kernel.org>; Thu, 12 Jan 2023 04:06:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CmOD3nMIkOkDtyMs2Cj3I2iqI3g33yjrsofCSblZrqc=;
        b=KIQrx8S78qkHRmjKjIZd/LkWkI50X65eV/mUSj8Z77pZ2svSm6aGcCZSo3UIpi4/Tc
         KWpdoDVYhgwfsLTou9zJxuesUuUuNSS8vOUUUNbSBP5zUrbT4fNm/uVWhTzanPjBEWRi
         xHV540wt6tfO+8T6pSV87QglLU68HK+5as+EXPtfx47YMP55RMIpoMRfXRRIrwggaVmn
         rUSBlHDYeO24lWOeNi/dmAh28ISIY5EkPiXLULED55NUQYFDOk6m1jotLiIhd3kXMcMN
         lIOP/agO1UBaKU9REBSB0vWUcf03iXuHhXw/tJmrXfJMz2ET10Nl900GWIzsY6yVjfvp
         qTfA==
X-Gm-Message-State: AFqh2kry1+LZWAmcES39B5mH0uNIkrp8LbPbQx76SsOQPtyTBQvf6tMb
        EG8qfiyEiuQJe3h6EGTL0NVAEmy6k0wl1vzv1jDhzbQJwTna7ZfEHenArQ9f7oXJ9ZhBVV20ufI
        F9N+m3rGKkxCclTu/NisKhh+Vuz8/7Wn7zQ==
X-Received: by 2002:a17:902:e849:b0:191:317e:c108 with SMTP id t9-20020a170902e84900b00191317ec108mr5080660plg.154.1673525188981;
        Thu, 12 Jan 2023 04:06:28 -0800 (PST)
X-Google-Smtp-Source: AMrXdXvH2cNXaSzT3OSgCPjaf2vkKAGiU6x0Ry/tDImbwZ6PZeIGrQBvc0lvuwkmAHfro57BN0ccWQC29Gj38QSeS84=
X-Received: by 2002:a17:902:e849:b0:191:317e:c108 with SMTP id
 t9-20020a170902e84900b00191317ec108mr5080658plg.154.1673525188683; Thu, 12
 Jan 2023 04:06:28 -0800 (PST)
MIME-Version: 1.0
References: <20230110135513.56005-1-omosnace@redhat.com>
In-Reply-To: <20230110135513.56005-1-omosnace@redhat.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Thu, 12 Jan 2023 13:06:16 +0100
Message-ID: <CAFqZXNufUm3_676wWV48F9pdrcfxyy2M1nSq8DsXpqVbdRj5wQ@mail.gmail.com>
Subject: Re: [PATCH testsuite] tests/filesystem: use native quota support for ext4
To:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Jan 10, 2023 at 2:55 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> Use of external quota files is now deprecated for ext4 in favor of
> native quota support, which can be enabled by passing -O quota to
> mkfs.ext4 when creating the filesystem.
>
> To accommodate to that, modify the [fs_]filesystem tests such that the
> native quota support is used on kernels that support it (3.6+ according
> to kernel's git history).
>
> The EXT4 native quota support is similar to the XFS one in that it
> doesn't require calling quotacheck(8) and the quota support is turned on
> implicitly when the filesystem is mounted. However, contrary to XFS it
> doesn't use special quota commands. This means that a new helper program
> is needed to test the quota operations (neither quotas_test nor
> xfs_quotas_test can be reused).
>
> Fixes issue #83.
>
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>  tests/filesystem/.gitignore           |  1 +
>  tests/filesystem/Filesystem.pm        |  4 +-
>  tests/filesystem/Makefile             |  2 +-
>  tests/filesystem/native_quotas_test.c | 94 +++++++++++++++++++++++++++
>  tests/filesystem/test                 | 86 ++++++++++++++++--------
>  tests/fs_filesystem/test              | 88 +++++++++++++++++--------
>  6 files changed, 217 insertions(+), 58 deletions(-)
>  create mode 100644 tests/filesystem/native_quotas_test.c

Applied:
https://github.com/SELinuxProject/selinux-testsuite/commit/bbab270f66c3fc33b4fdc7cec8beb0003afbb4ee

-- 
Ondrej Mosnacek
Senior Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

