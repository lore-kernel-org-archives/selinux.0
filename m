Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B5C5C00144
	for <selinux@archiver.kernel.org>; Mon,  1 Aug 2022 09:06:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230087AbiHAJGb (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 1 Aug 2022 05:06:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230320AbiHAJGb (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 1 Aug 2022 05:06:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 20DAA32DB5
        for <selinux@vger.kernel.org>; Mon,  1 Aug 2022 02:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659344789;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KjciaUseXeya76AcpXke56RrL9+AzZBFfaBkfdUOkuE=;
        b=bbmW/1sh4jg5f84iKEk/nUVqoz17tCdudWvLyd8wH5qKO5fsTkOfrYg+DKL11PwbUmT/5J
        Q5Czce+8ZS2ZJWWAGzbtUz/gdvwzoeAUkbiqKVxRp7yj6N3LKgMVH9GBJSyCjwZm5wyaeJ
        hS/pgZyQnvOuWIJX1Z4t4HRv767N6CY=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-62-V0Oxb4miODGDQVBJ4YRZVw-1; Mon, 01 Aug 2022 05:06:27 -0400
X-MC-Unique: V0Oxb4miODGDQVBJ4YRZVw-1
Received: by mail-yb1-f197.google.com with SMTP id m11-20020a5b040b000000b0066fcc60d1a0so8236547ybp.19
        for <selinux@vger.kernel.org>; Mon, 01 Aug 2022 02:06:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc;
        bh=KjciaUseXeya76AcpXke56RrL9+AzZBFfaBkfdUOkuE=;
        b=wWbT/cxq0yO2yZWUb4Wp7Wm9dqLsG6CdxMshEHnelVEpqdK4vQXQoW+UmR1sb3wXCm
         7jFUv9KaEUA+1b8pYdJjohpdRo9cl2wJv0Nht7W55qXa19nj9n50Gh3ZaCei297e9LmR
         Q2kEbBF+bp3XlzXSq6EWJK++7wmNtzd5l8eRPt/tKMhWQ0xGOmN+7JboINFLu58u9Cqj
         K0HQFatE7Bud5y3kmezB17tajX6gnrfWX5QbX7aO5E9YYjvI43XfY7hRqbh+dCJVSpL3
         kkRFMAovte1w/LheNBzAWwvqlxma3TBTvv47pKzPngpYr+8e+0QOnz0dDfPKH+Co0q3E
         wzQw==
X-Gm-Message-State: ACgBeo358eUQNVZfird3xMGSaP+ArNuBvWXhVfhBPsF1bEzb/qd4uMmE
        IqMWbWsre9iUmT7/TmP+72U2nyT7HZDF98aiwErHfEzQ5hw/F5zyonT6T5oWH8CRXdAZp/mT2Cj
        IYzNF7nbCsjq8EdmKChp23ty94YhOK8nQPg==
X-Received: by 2002:a0d:d513:0:b0:31f:5267:f9c4 with SMTP id x19-20020a0dd513000000b0031f5267f9c4mr11962948ywd.247.1659344786903;
        Mon, 01 Aug 2022 02:06:26 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7up0CnstDpI9spVNqKGiUd467hDUYjKzhTvKgARH+E7uPCjIW7cXc4UVu45pZJlNcrAMPvOmquPgmiv5FBSzc=
X-Received: by 2002:a0d:d513:0:b0:31f:5267:f9c4 with SMTP id
 x19-20020a0dd513000000b0031f5267f9c4mr11962934ywd.247.1659344786615; Mon, 01
 Aug 2022 02:06:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220718105120.674121-1-omosnace@redhat.com>
In-Reply-To: <20220718105120.674121-1-omosnace@redhat.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Mon, 1 Aug 2022 11:06:15 +0200
Message-ID: <CAFqZXNubrxhFhL=RsReTRRSx7j7rpKdoA=8gYyYX=8gOSkmgJA@mail.gmail.com>
Subject: Re: [PATCH testsuite] tests/module_load: detect the linker to use for
 module build
To:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Jul 18, 2022 at 12:51 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> Similar to the compiler, matching the linker used to compile the kernel
> is also important for an external kernel module build. Add code to
> detect the linker from the kernel config similar to the existing
> compiler detection.
>
> Speicifically, this fixes kernel module builds under kernels built with
> clang and with LTO enabled.
>
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>  tests/module_load/Makefile | 30 +++++++++++++++++++++++-------
>  1 file changed, 23 insertions(+), 7 deletions(-)
>
> diff --git a/tests/module_load/Makefile b/tests/module_load/Makefile
> index 272872d..0839532 100644
> --- a/tests/module_load/Makefile
> +++ b/tests/module_load/Makefile
> @@ -4,12 +4,15 @@ TARGETS = finit_load init_load
>  LDLIBS += -lselinux
>  KDIR = /lib/modules/$(shell uname -r)/build
>
> -# Make sure to use the same compiler as the kernel was built with.
> -# If the compilers don't match, the build will fail on unsupported compiler
> +# Make sure to use the same compiler+linker as the kernel was built with.
> +# If the compilers/linkers don't match, the build could fail on unsupported
>  # flags and even if not, the resulting module would likely fail to load.
> -# If the kernel was compiled with neither GCC nor clang (currently the only
> -# supported compilers), fall back to the default compiler and hope for the best.
> -# In all cases allow the user to override the compiler via the KCC variable.
> +# If the kernel was compiled with a compiler other than GCC or clang or a
> +# linker other than ld.bfd or ld.lld, fall back to the default compiler/linker
> +# and hope for the best.
> +# In all cases allow the user to override the compiler via the KCC/KLD
> +# variables.
> +
>  DETECTED_KCC = unknown
>  ifeq ($(shell grep -qFx CONFIG_CC_IS_GCC=y $(KDIR)/.config && echo true),true)
>         DETECTED_KCC = gcc
> @@ -23,9 +26,22 @@ else
>         KCC ?= $(CC)
>  endif
>
> +DETECTED_KLD = unknown
> +ifeq ($(shell grep -qFx CONFIG_LD_IS_BFD=y $(KDIR)/.config && echo true),true)
> +       DETECTED_KLD = ld.bfd
> +endif
> +ifeq ($(shell grep -qFx CONFIG_LD_IS_LLD=y $(KDIR)/.config && echo true),true)
> +       DETECTED_KLD = ld.lld
> +endif
> +ifneq ($(DETECTED_KLD),unknown)
> +       KLD ?= $(DETECTED_KLD)
> +else
> +       KLD ?= $(LD)
> +endif
> +
>  all: $(TARGETS)
> -       $(MAKE) -C $(KDIR) CC=$(KCC) M=$(PWD)
> +       $(MAKE) -C $(KDIR) CC=$(KCC) LD=$(KLD) M=$(PWD)
>
>  clean:
>         rm -f $(TARGETS)
> -       $(MAKE) -C $(KDIR) CC=$(KCC) M=$(PWD) clean
> +       $(MAKE) -C $(KDIR) CC=$(KCC) LD=$(KLD) M=$(PWD) clean
> --
> 2.36.1

Whoops, forgot about this patch... Now applied as:
https://github.com/SELinuxProject/selinux-testsuite/commit/deeff9d73d9abf84fbb76a019186de06004e121e

-- 
Ondrej Mosnacek
Senior Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

