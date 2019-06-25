Return-Path: <SRS0=B9fV=UY=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46155C48BD5
	for <selinux@archiver.kernel.org>; Tue, 25 Jun 2019 16:01:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AF01208CB
	for <selinux@archiver.kernel.org>; Tue, 25 Jun 2019 16:01:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iu5VfaGC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732519AbfFYQBH (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 25 Jun 2019 12:01:07 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:35272 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731459AbfFYQBH (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 25 Jun 2019 12:01:07 -0400
Received: by mail-io1-f68.google.com with SMTP id m24so1114088ioo.2
        for <selinux@vger.kernel.org>; Tue, 25 Jun 2019 09:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GpDJWuxFddxQSJLEevQk05HKltrcQJRfyTi5uTeuodk=;
        b=iu5VfaGCJFdyt7DhEWYbdZIh4DGPQVKlYEScKKp7yvWIEX0Vn9jaxzysW55G/Fv1sj
         7LBZVCKX/BBgmx6+/4YaJPUKZsx44yrPoN6Cg0ekxcfJI29YkeL5JWHrRj5gzVxZwYOG
         s7M0fDU58kwdKbnwrEFYniudQ49E1iIiYfdECir3GmJ//Yp5Wpsfx8L5Zgq+DrLu10Wj
         NHQY2L81USbwAxCAjpuJV7Z4ibjA3Ht408i1bG0fTnrzMyTKbSjmgF7aLNvwapDytKLN
         KrQ0zPWx99d+gP4fwHfZ/Y/NGR9wBcbExGzD/L/6TEsXIQ7SGH5BSLCFwcMS5oS/ZT7a
         aH7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GpDJWuxFddxQSJLEevQk05HKltrcQJRfyTi5uTeuodk=;
        b=jygrBpDOW9DJiozJC3aXPp4P/Qt2hf5wp7lB10PzcsCZ6oncghqGj/wQkg78cmvpjZ
         J+WiIUX+XulK/RxtroEOys5ZfQFCvbs+HOdmzb7TuB0vEz53mENUHevgGtSBnPNyvWOj
         5yE+atorelcggq+T5i2O7sWbBEOG9vhumXKqCM4R5gQjiMjauptvAw82D1OujYW3hbpx
         DNN4bz3orHUkkxImBnm34fIdcxs8M4Z+t7TcCjSd6JWdvo4/m+I2fOUb7NyUPoZUrcHe
         1ON+GLNj3ThquQZKBxjojN2UyHsN19FnElTfHb/z7fGm8BnrKp8t4ksk61+h2KZ2Oe4m
         RnHQ==
X-Gm-Message-State: APjAAAXNYQqynIynRx+J8T4yxptGzsftLGMXgWLWsIrKzvuaUKxHkjKf
        e77moQ38iGX6e/N4OqmAGdCfOlp2nbC6m5cz2N8=
X-Google-Smtp-Source: APXvYqx1b02Hue7S6fvAjsp16TH30LqTUnAg3QDkzVsbJ0T1kXsZPJvMJNIHc1yBy2iXtp3R4CZMYDo+5hdFLfzVl14=
X-Received: by 2002:a02:3f1d:: with SMTP id d29mr27739832jaa.116.1561478466056;
 Tue, 25 Jun 2019 09:01:06 -0700 (PDT)
MIME-Version: 1.0
References: <20190624193154.8453-1-nicolas.iooss@m4x.org>
In-Reply-To: <20190624193154.8453-1-nicolas.iooss@m4x.org>
From:   William Roberts <bill.c.roberts@gmail.com>
Date:   Tue, 25 Jun 2019 09:00:48 -0700
Message-ID: <CAFftDdrgMfG_xvozsKAwQGPZ6pPnVGMx4jefdnSVWbEaBA+=KQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] libsepol: include module.c internal header in module_to_cil.c
To:     Nicolas Iooss <nicolas.iooss@m4x.org>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

ack, you going to to merge this?

On Mon, Jun 24, 2019 at 2:58 PM Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
>
> In module_to_cil.c, sepol_ppfile_to_module_package() calls functions
> from module.c without including the internal header. This makes building
> libsepol with "gcc -flto -fuse-ld=gold" fails when linking libsepol.so:
>
>     /tmp/ccHYAKVZ.ltrans21.ltrans.o:<artificial>:function
>     sepol_ppfile_to_module_package: error: undefined reference to
>     'sepol_module_package_free'
>     /tmp/ccHYAKVZ.ltrans21.ltrans.o:<artificial>:function
>     sepol_ppfile_to_module_package: error: undefined reference to
>     'sepol_module_package_create'
>     /tmp/ccHYAKVZ.ltrans21.ltrans.o:<artificial>:function
>     sepol_ppfile_to_module_package: error: undefined reference to
>     'sepol_module_package_create'
>     collect2: error: ld returned 1 exit status
>
> Fixes: https://github.com/SELinuxProject/selinux/issues/165
>
> Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
> ---
>  libsepol/src/module_to_cil.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/libsepol/src/module_to_cil.c b/libsepol/src/module_to_cil.c
> index da62c8aaf0ef..1af166c9abd0 100644
> --- a/libsepol/src/module_to_cil.c
> +++ b/libsepol/src/module_to_cil.c
> @@ -54,6 +54,7 @@
>
>  #include "kernel_to_common.h"
>  #include "private.h"
> +#include "module_internal.h"
>
>  #ifdef __GNUC__
>  #  define UNUSED(x) UNUSED_ ## x __attribute__((__unused__))
> --
> 2.22.0
>
