Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 230BBC433B4
	for <selinux@archiver.kernel.org>; Fri, 30 Apr 2021 11:35:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E91CD613F0
	for <selinux@archiver.kernel.org>; Fri, 30 Apr 2021 11:35:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230149AbhD3LgJ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 30 Apr 2021 07:36:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229874AbhD3LgI (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 30 Apr 2021 07:36:08 -0400
Received: from agnus.defensec.nl (agnus.defensec.nl [IPv6:2001:985:d55d::711])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 316BCC06174A
        for <selinux@vger.kernel.org>; Fri, 30 Apr 2021 04:35:18 -0700 (PDT)
Received: from brutus (brutus.lan [IPv6:2001:985:d55d::438])
        by agnus.defensec.nl (Postfix) with ESMTPSA id E94A52A0CF2;
        Fri, 30 Apr 2021 13:35:14 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 agnus.defensec.nl E94A52A0CF2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=defensec.nl;
        s=default; t=1619782515;
        bh=Hp7AotHGQYjNXpyfnrMojUwTM3zV5AWG31xn3MN+OQg=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=hvHrY/p/5mkTnZRLCoFtlyI795sSV8mIC5N6QRZ6L3ReZV6hzE3XO9TNd91563nbt
         IYqiMm0ThUMvIhoDKQgxgB5B3Ab0ZyOIVuzDfCizLWx5JBs/JZvQDct4PMLWY+V8qa
         Ck6T3gA0bFLiHMUlXeC0LzOemYqG0gPy4i1MQOfQ=
From:   Dominick Grift <dominick.grift@defensec.nl>
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     selinux@vger.kernel.org
Subject: Re: [PATCH testsuite] policy: only define anon_inode class if not
 defined in system policy
In-Reply-To: <20210430091119.607754-1-omosnace@redhat.com> (Ondrej Mosnacek's
        message of "Fri, 30 Apr 2021 11:11:19 +0200")
References: <20210430091119.607754-1-omosnace@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
Date:   Fri, 30 Apr 2021 13:35:09 +0200
Message-ID: <87bl9wyphu.fsf@defensec.nl>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Ondrej Mosnacek <omosnace@redhat.com> writes:

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

Reference policy does not have a "all_perms.spt" AFAIK. This might only work
with Fedora.

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

-- 
gpg --locate-keys dominick.grift@defensec.nl
Key fingerprint = FCD2 3660 5D6B 9D27 7FC6  E0FF DA7E 521F 10F6 4098
https://sks-keyservers.net/pks/lookup?op=get&search=0xDA7E521F10F64098
Dominick Grift
