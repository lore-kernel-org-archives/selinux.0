Return-Path: <SRS0=fYOO=63=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB54EC433E0
	for <selinux@archiver.kernel.org>; Wed, 13 May 2020 21:55:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0AA720659
	for <selinux@archiver.kernel.org>; Wed, 13 May 2020 21:55:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="Z8L86Pfk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729709AbgEMVz1 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 13 May 2020 17:55:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729487AbgEMVz1 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 13 May 2020 17:55:27 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C12A1C061A0C
        for <selinux@vger.kernel.org>; Wed, 13 May 2020 14:55:26 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id k19so650184edv.9
        for <selinux@vger.kernel.org>; Wed, 13 May 2020 14:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bM20mxeBPT2zMRcvsCSEaGRDTvPFbA75ACFKgBsbWus=;
        b=Z8L86PfkcioF8/nbUcJOmgDCdo4FAE9iPwFQAZCSjW2fW7CJeuUSYmCCZRd8QJWAic
         vF2S9I8sKObOU1Ud9WxPJJHw7G+ZYiWW60Oogn3v+dXAwavZUydF08Nkv7Tw0SRnmV8W
         Qjo684I/ZH6v+2paKHh7ksQDxAORg5rGkvzJaS+LVcgFBr++oof1/Ezmpc3QkSr+mRvD
         K8RxwSE4WLb+j8OX9Lfe9Q+IIQQK8jTC4Mc5SgZ13Uy0nntrpkBtgErF0ByL07lmK+QU
         lANhTapfcpmA1v2US0NeMjK+ZWKO+UxalaDs5m+CL8uSIvW6kVDRC0oMH+gY01T0KywQ
         kTHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bM20mxeBPT2zMRcvsCSEaGRDTvPFbA75ACFKgBsbWus=;
        b=W9n7LKoFGz3v6P8gw1hinHMWX8hpBJ6CKLy/jo9mkuUsh1McPIucal3344BTykVOkc
         e1M6DdUzGWpEBunS6z4t6cU4cvkSr+LJ0tDeXZ6GNhMOH3ilHLd4pHCK3kSNahMjP6Jl
         B4+Zr94QpBG6gpOAr71feRqfaFKJXYkDtptkVbGjnhOJYAA/nd+iQZxX4MlwRStxORDR
         mj/8mBpkUCkmJBeiE4j5z1XUKbQ9pkVcXZ5VIKDNxrfNuo/zOqn9lPoMD/uwH22ykRWQ
         nc/1/fNqviW3qVSuDcoKaqolxQkXvbC+F1J20oFtT83z+SwumCXO5gFV5+ARFR+4KXLG
         Ij2w==
X-Gm-Message-State: AOAM533CzSmnVej9PXarSn3BFMe4/H7RUpu1X5NZizfpjInFVgyd8TMB
        PU2JRFDAiwINn3xDqfJjXDcNqRqR+Z/nwcnNoIXp
X-Google-Smtp-Source: ABdhPJwMlyKK2fpu+EpCWNyxlS2POdu5M+8MiRE+j++YItgh44pu5wYiUZC+j2uCFIHf+C8Nwr8HoPC2CkpdNVaRAsQ=
X-Received: by 2002:a05:6402:1adc:: with SMTP id ba28mr1566691edb.12.1589406924396;
 Wed, 13 May 2020 14:55:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200429202941.18320-1-siarhei.liakh@concurrent-rt.com> <20200429202941.18320-2-siarhei.liakh@concurrent-rt.com>
In-Reply-To: <20200429202941.18320-2-siarhei.liakh@concurrent-rt.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 13 May 2020 17:55:13 -0400
Message-ID: <CAHC9VhRuYa2nA18tnQCwfAUW+whce1a84W802GKk135ztoN8Cw@mail.gmail.com>
Subject: Re: [PATCH 1/2] SELinux: Add median to debug output of hash table stats
To:     siarhei.liakh@concurrent-rt.com
Cc:     selinux@vger.kernel.org, colin.king@canonical.com,
        Eric Paris <eparis@parisplace.org>, gregkh@linuxfoundation.org,
        jeffv@google.com, omosnace@redhat.com,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Apr 29, 2020 at 4:29 PM <siarhei.liakh@concurrent-rt.com> wrote:
>
> From: Siarhei Liakh <siarhei.liakh@concurrent-rt.com>
>
> This change introduces a median() function which is then used to report
> 25th, 50th, and 75th percentile metrics within distributions of hash table
> bucket chain lengths. This allows to better assess and compare relative
> effectiveness of different hash functions. Specifically, it allows to
> ensure new functions not only reduce the maximum, but also improve (or, at
> least, have no negative impact) on the median.
>
> Sample output before change:
>
> avc:
> entries: 508
> buckets used: 213/512
> longest chain: 10
>
> policydb:
> SELinux: roles:  14 entries and 6/16 buckets used, longest chain length 5
>
> Sample output after the change:
>
> avc:
> entries: 508
> buckets used: 217/512
> longest chain: 9
> non-zero chain Q1/Med/Q3: 1/2/3
>
> policydb:
> SELinux: roles:  14 entries and 6/16 buckets used, longest chain length 5
> non-zero Q1/Med/Q3 1/2/4
>
> Signed-off-by: Siarhei Liakh <siarhei.liakh@concurrent-rt.com>
> ---
> Please CC me directly on all replies.
>
>  security/selinux/Kconfig          | 10 +++++
>  security/selinux/avc.c            | 42 ++++++++++++++++---
>  security/selinux/include/median.h | 67 +++++++++++++++++++++++++++++++
>  security/selinux/ss/avtab.c       | 37 ++++++++++++++---
>  security/selinux/ss/hashtab.c     | 28 ++++++++++++-
>  security/selinux/ss/hashtab.h     |  5 +++
>  security/selinux/ss/policydb.c    | 14 ++++---
>  7 files changed, 185 insertions(+), 18 deletions(-)
>  create mode 100644 security/selinux/include/median.h
>
> diff --git a/security/selinux/Kconfig b/security/selinux/Kconfig
> index 9e921fc72538..57c427e019c9 100644
> --- a/security/selinux/Kconfig
> +++ b/security/selinux/Kconfig
> @@ -115,3 +115,13 @@ config SECURITY_SELINUX_SID2STR_CACHE_SIZE
>           conversion.  Setting this option to 0 disables the cache completely.
>
>           If unsure, keep the default value.
> +
> +config SECURITY_SELINUX_DEBUG_HASHES
> +       bool "Print additional information about hash tables"
> +       depends on SECURITY_SELINUX
> +       default n
> +       help
> +         This option allows to gather and display additional information about
> +         some of the key hash tables within SELinux.
> +
> +         If unsure, keep the default value.

I forgot to mention this earlier, but I think this is another case
where we don't need to add another Kconfig option.

-- 
paul moore
www.paul-moore.com
