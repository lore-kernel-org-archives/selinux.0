Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B83D8C433B4
	for <selinux@archiver.kernel.org>; Sat,  1 May 2021 07:55:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A5A5613EA
	for <selinux@archiver.kernel.org>; Sat,  1 May 2021 07:55:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230363AbhEAHzw (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 1 May 2021 03:55:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:49532 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230195AbhEAHzv (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sat, 1 May 2021 03:55:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619855701;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GTBNmI738g8Y2wOE9WHOqoybDB/V963P6pfN5bFLdgE=;
        b=feAR5LD+Rt9ZjMCjWpwYyxLJU/R9zUiF7DHT6ZEV0+4Te79Kw+eaSd2d9CINVeglR2UVD+
        BDGRc52gI2po22VycMxPFrQiKuhXpTkt9k0t5v/mA/w/Dn8dFZIA78TVsH0c7qcifBMPJf
        1AvS0wHqH8YLcBPfOsDw7iJ8n0Ppr6E=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-312-9qovUx0rPoa53Ue16iK0gg-1; Sat, 01 May 2021 03:54:59 -0400
X-MC-Unique: 9qovUx0rPoa53Ue16iK0gg-1
Received: by mail-yb1-f197.google.com with SMTP id i8-20020a0569020688b02904ef3bd00ce7so1105991ybt.7
        for <selinux@vger.kernel.org>; Sat, 01 May 2021 00:54:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=GTBNmI738g8Y2wOE9WHOqoybDB/V963P6pfN5bFLdgE=;
        b=bm63vqBemtVoG6ir106biXzfxOx9ByXGWhDDNZu0lqMKdZhY9CmZgl7L4IKLrEvd5E
         bhwxJL+tf6ZQC16r4WPrIYr1BfxRHWwLMlyhj5eqaRp7fcRNKV1Ffg/jrg2VTRlh5jzY
         0mA9W+xfExfh3xWpKnvBK+xtoPORjYczMIzK0p4mOtDqENbFTkBTnyHdUSl9OdcIA0zN
         cDRHAIZmaq+aPyVpbxaZwyW34aQKwYJ+9gkG55+Q361NdyqMyJ/9mOHIcuReiNrJs8iQ
         fXh3Q4izLTpdWu49N3qqtociOwAm/XJBfpOfp2klN05dtbvwNX57+HlWOhH/D2AJCf0P
         PFOA==
X-Gm-Message-State: AOAM533/rmX0tSLDEjZpr/V5ujklpLjtleLIQYoYvc6ThFzdMqBm+Utd
        R/QqOOZ/jCDCdebRZawHFcuOdEEoN6ARoxBZ+LdhILXcZkPSzXNsR5eJKnsBzTi3c3kjYz9ts4v
        NJ0eqc5R/Ut3HLqZ3AhSPwEC/kS6jfUm6kQ==
X-Received: by 2002:a25:d090:: with SMTP id h138mr12186658ybg.227.1619855698305;
        Sat, 01 May 2021 00:54:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyd67qReCX2kivOi+Dnp0lTUwCme1lDbr/KifzPlsc5T0lDGf9qDCx0r15E7ZwgqVP/L0NXR5u3x+3Ed+Y1dG0=
X-Received: by 2002:a25:d090:: with SMTP id h138mr12186642ybg.227.1619855697995;
 Sat, 01 May 2021 00:54:57 -0700 (PDT)
MIME-Version: 1.0
References: <20210430091119.607754-1-omosnace@redhat.com>
In-Reply-To: <20210430091119.607754-1-omosnace@redhat.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Sat, 1 May 2021 09:54:46 +0200
Message-ID: <CAFqZXNui9rVq9TcaJno8wmYcL_xT0jc=5=O9zLryLxj-bdUnyA@mail.gmail.com>
Subject: Re: [PATCH testsuite] policy: only define anon_inode class if not
 defined in system policy
To:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Apr 30, 2021 at 11:11 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> When the system policy already defines this class, loading the test
> policy fails with:
>
> Re-declaration of class anon_inode
> Previous declaration of class at /var/lib/selinux/targeted/tmp/modules/100/base/cil:1003
> Bad class declaration at /var/lib/selinux/targeted/tmp/modules/400/test_userfaultfd/cil:2
> /usr/sbin/semodule:  Failed!
>
> Fix this by only including the anon_inode class declarations when it's
> not found in the system policy headers.
>
> Fixes: 2ea007924363 ("selinux-testsuite: Add userfaultfd test")
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>  policy/Makefile                  | 3 +++
>  policy/test_anon_inode_class.cil | 4 ++++
>  policy/test_userfaultfd.cil      | 5 -----
>  3 files changed, 7 insertions(+), 5 deletions(-)
>  create mode 100644 policy/test_anon_inode_class.cil
>
> diff --git a/policy/Makefile b/policy/Makefile
> index 91364d5..dee55a2 100644
> --- a/policy/Makefile
> +++ b/policy/Makefile
> @@ -39,6 +39,9 @@ ifeq ($(SUPPORTS_CIL),y)
>  CIL_TARGETS = test_mlsconstrain.cil test_overlay_defaultrange.cil
>  # userfaultfd test policy uses also xperms
>  ifeq ($(shell [ $(MOD_POL_VERS) -ge 18 -a $(MAX_KERNEL_POLICY) -ge 30 ] && echo true),true)
> +ifneq ($(shell grep -q anon_inode $(POLDEV)/include/support/all_perms.spt && echo true),true)
> +CIL_TARGETS += test_anon_inode_class.cil
> +endif
>  CIL_TARGETS += test_userfaultfd.cil
>  TARGETS += test_userfaultfd.te
>  endif
> diff --git a/policy/test_anon_inode_class.cil b/policy/test_anon_inode_class.cil
> new file mode 100644
> index 0000000..3e36599
> --- /dev/null
> +++ b/policy/test_anon_inode_class.cil
> @@ -0,0 +1,4 @@
> +; Define new class anon_inode
> +(class anon_inode ())
> +(classcommon anon_inode file)
> +(classorder (unordered anon_inode))
> diff --git a/policy/test_userfaultfd.cil b/policy/test_userfaultfd.cil
> index 18d5f3f..f6a6791 100644
> --- a/policy/test_userfaultfd.cil
> +++ b/policy/test_userfaultfd.cil
> @@ -1,8 +1,3 @@
> -; Define new class anon_inode
> -(class anon_inode ())
> -(classcommon anon_inode file)
> -(classorder (unordered anon_inode))
> -
>  ; Allow all anonymous inodes
>  (typeattributeset cil_gen_require test_notransition_uffd_t)
>  (allow test_notransition_uffd_t self (anon_inode (create getattr ioctl read)))
> --
> 2.30.2

Now applied:
https://github.com/SELinuxProject/selinux-testsuite/commit/9267bc9fbc1b31107eac42b0870075507c5a2e6c

-- 
Ondrej Mosnacek
Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

