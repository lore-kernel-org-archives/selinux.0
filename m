Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-23.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07E8CC433E9
	for <selinux@archiver.kernel.org>; Tue, 16 Feb 2021 18:10:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D17E664E28
	for <selinux@archiver.kernel.org>; Tue, 16 Feb 2021 18:10:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229807AbhBPSKP (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 16 Feb 2021 13:10:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229937AbhBPSKK (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 16 Feb 2021 13:10:10 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DB0AC0613D6
        for <selinux@vger.kernel.org>; Tue, 16 Feb 2021 10:09:30 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id w36so17404550lfu.4
        for <selinux@vger.kernel.org>; Tue, 16 Feb 2021 10:09:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HJy2hlVhbXbbO3XQqhTLd/RinhfpQEahlpeQ17PFZcA=;
        b=L4ps34pC9zMLRN4q3K40Mbitkt7IUdJq+gpX9gRZ9ZriSf8T4NiT5YGzjwCBTWxLzy
         +OUVt/K9HisrleBEka0SqsIz0sHlNh6jfnYKOi4vYlgz9z4IU0MnT4JxzCey7N/aExnu
         TjBABvyD7CcPMBeyDsSknuzSAmqPYAbHQ964r8UiBoj9KApb2i30jjZA9mnmSh8s6w+B
         lF4t5qUki8WGKskp2DSgkeb6Qeng7bjuKPW8++FdsZyXf2rei+wX7PQGJVtEo/hEHq8R
         KCCJeSuRuvoynZoZ9vhEeBdAnhaMsjCdZoCk6yJjlFEu6Gik5ymqi/0Y9p/wtrJzCjUw
         SFeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HJy2hlVhbXbbO3XQqhTLd/RinhfpQEahlpeQ17PFZcA=;
        b=iy5AsEIk9oRPszXBb4cZ1ZO8kYh10fm03ddBYIo0boaUPCx8ZsTK7gMHSC2D73HJWl
         MQyZheTE2ovfrTe7GPvMJdofu9sm/pMOfy6IFRtvYwAs0rlP6d635G1M3/2pi2zK6J/a
         3pZ0I3gTjzPERao0A2D3bIynWxaOYhVkratfynuUoYNQUo6Z1qWWD9EYSaxEPHcC2At4
         zNervpry8AYzB3MxC6S6vN2T2lxycIV7WeAzvazI6qYm5mT8YzUOk7iGrfg3iP99Tb8a
         0qfeQn4/0oKk8yTTreeBcLyWZnNI54Sit5E7RGoJ+is10h0QWVUqs/XFqS2zfeR/TB9M
         9gDg==
X-Gm-Message-State: AOAM531M2JVrVWr+YqGJZnWGTL/Dojm1wysnZ3kKVYvOEcPVxb2y35j1
        zqyLrK8vS9brPIkP6HlV0QkVJ61z5QbZWamLnBXjWA==
X-Google-Smtp-Source: ABdhPJzDE9ztNc8qU4bAglK6q5SoxGPRF+so6E+ARstq0NF2f9wE9Il93pLhnLoZ9srjX3iPAvwsVJSw/9mpPmq85+8=
X-Received: by 2002:a05:6512:2e3:: with SMTP id m3mr12673941lfq.547.1613498967925;
 Tue, 16 Feb 2021 10:09:27 -0800 (PST)
MIME-Version: 1.0
References: <1613470672-3069-1-git-send-email-pnagar@codeaurora.org>
In-Reply-To: <1613470672-3069-1-git-send-email-pnagar@codeaurora.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 16 Feb 2021 10:09:16 -0800
Message-ID: <CAKwvOdkTkTV6U7zv1WyndLwK_JCB5ptTz64UbqAEwRMV5o7dLw@mail.gmail.com>
Subject: Re: [PATCH] RTIC: selinux: ARM64: Move selinux_state to a separate page
To:     Preeti Nagar <pnagar@codeaurora.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Paul Moore <paul@paul-moore.com>,
        stephen.smalley.work@gmail.com, eparis@parisplace.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-arch <linux-arch@vger.kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        David Howells <dhowells@redhat.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Prasad Sodagudi <psodagud@codeaurora.org>,
        Will Deacon <will@kernel.org>, nmardana@codeaurora.org,
        rkavati@codeaurora.org, vsekhar@codeaurora.org,
        mreichar@codeaurora.org, johan@kernel.org,
        Joe Perches <joe@perches.com>, Jessica Yu <jeyu@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Eric Biggers <ebiggers@google.com>,
        Joel Galenson <jgalenson@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Feb 16, 2021 at 2:19 AM Preeti Nagar <pnagar@codeaurora.org> wrote:
>
> The changes introduce a new security feature, RunTime Integrity Check
> (RTIC), designed to protect Linux Kernel at runtime. The motivation
> behind these changes is:
> 1. The system protection offered by Security Enhancements(SE) for
> Android relies on the assumption of kernel integrity. If the kernel
> itself is compromised (by a perhaps as yet unknown future vulnerability),
> SE for Android security mechanisms could potentially be disabled and
> rendered ineffective.
> 2. Qualcomm Snapdragon devices use Secure Boot, which adds cryptographic
> checks to each stage of the boot-up process, to assert the authenticity
> of all secure software images that the device executes.  However, due to
> various vulnerabilities in SW modules, the integrity of the system can be
> compromised at any time after device boot-up, leading to un-authorized
> SW executing.
>
> The feature's idea is to move some sensitive kernel structures to a
> separate page and monitor further any unauthorized changes to these,
> from higher Exception Levels using stage 2 MMU. Moving these to a
> different page will help avoid getting page faults from un-related data.
> The mechanism we have been working on removes the write permissions for
> HLOS in the stage 2 page tables for the regions to be monitored, such
> that any modification attempts to these will lead to faults being
> generated and handled by handlers. If the protected assets are moved to
> a separate page, faults will be generated corresponding to change attempts
> to these assets only. If not moved to a separate page, write attempts to
> un-related data present on the monitored pages will also be generated.
>
> Using this feature, some sensitive variables of the kernel which are
> initialized after init or are updated rarely can also be protected from
> simple overwrites and attacks trying to modify these.
>
> Currently, the change moves selinux_state structure to a separate page.
> The page is 2MB aligned not 4K to avoid TLB related performance impact as,
> for some CPU core designs, the TLB does not cache 4K stage 2 (IPA to PA)
> mappings if the IPA comes from a stage 1 mapping. In future, we plan to
> move more security-related kernel assets to this page to enhance
> protection.
>
> Signed-off-by: Preeti Nagar <pnagar@codeaurora.org>

This addresses my feedback from the RFC regarding the section symbols.
No comment on whether there is a better approach, or the 2MB vs page
alignment, but perhaps other folks cc'ed can please take a look.

Acked-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
> The RFC patch reviewed available at:
> https://lore.kernel.org/linux-security-module/1610099389-28329-1-git-send-email-pnagar@codeaurora.org/
> ---
>  include/asm-generic/vmlinux.lds.h | 10 ++++++++++
>  include/linux/init.h              |  6 ++++++
>  security/Kconfig                  | 11 +++++++++++
>  security/selinux/hooks.c          |  2 +-
>  4 files changed, 28 insertions(+), 1 deletion(-)
>
> diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
> index b97c628..d1a5434 100644
> --- a/include/asm-generic/vmlinux.lds.h
> +++ b/include/asm-generic/vmlinux.lds.h
> @@ -770,6 +770,15 @@
>                 *(.scommon)                                             \
>         }
>
> +#ifdef CONFIG_SECURITY_RTIC
> +#define RTIC_BSS                                                       \
> +       . = ALIGN(SZ_2M);                                               \
> +       KEEP(*(.bss.rtic))                                              \
> +       . = ALIGN(SZ_2M);
> +#else
> +#define RTIC_BSS
> +#endif
> +
>  /*
>   * Allow archectures to redefine BSS_FIRST_SECTIONS to add extra
>   * sections to the front of bss.
> @@ -782,6 +791,7 @@
>         . = ALIGN(bss_align);                                           \
>         .bss : AT(ADDR(.bss) - LOAD_OFFSET) {                           \
>                 BSS_FIRST_SECTIONS                                      \
> +               RTIC_BSS                                                \
>                 . = ALIGN(PAGE_SIZE);                                   \
>                 *(.bss..page_aligned)                                   \
>                 . = ALIGN(PAGE_SIZE);                                   \
> diff --git a/include/linux/init.h b/include/linux/init.h
> index e668832..e6d452a 100644
> --- a/include/linux/init.h
> +++ b/include/linux/init.h
> @@ -300,6 +300,12 @@ void __init parse_early_options(char *cmdline);
>  /* Data marked not to be saved by software suspend */
>  #define __nosavedata __section(".data..nosave")
>
> +#ifdef CONFIG_SECURITY_RTIC
> +#define __rticdata  __section(".bss.rtic")
> +#else
> +#define __rticdata
> +#endif
> +
>  #ifdef MODULE
>  #define __exit_p(x) x
>  #else
> diff --git a/security/Kconfig b/security/Kconfig
> index 7561f6f..1af913a 100644
> --- a/security/Kconfig
> +++ b/security/Kconfig
> @@ -291,5 +291,16 @@ config LSM
>
>  source "security/Kconfig.hardening"
>
> +config SECURITY_RTIC
> +       bool "RunTime Integrity Check feature"
> +       depends on ARM64
> +       help
> +         RTIC(RunTime Integrity Check) feature is to protect Linux kernel
> +         at runtime. This relocates some of the security sensitive kernel
> +         structures to a separate RTIC specific page.
> +
> +         This is to enable monitoring and protection of these kernel assets
> +         from a higher exception level(EL) against any unauthorized changes.
> +
>  endmenu
>
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 644b17e..59d7eee 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -104,7 +104,7 @@
>  #include "audit.h"
>  #include "avc_ss.h"
>
> -struct selinux_state selinux_state;
> +struct selinux_state selinux_state __rticdata;
>
>  /* SECMARK reference count */
>  static atomic_t selinux_secmark_refcount = ATOMIC_INIT(0);
> --
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
> of Code Aurora Forum, hosted by The Linux Foundation
>


-- 
Thanks,
~Nick Desaulniers
