Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AC98C48BD1
	for <selinux@archiver.kernel.org>; Fri, 11 Jun 2021 17:01:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4AF2960FE9
	for <selinux@archiver.kernel.org>; Fri, 11 Jun 2021 17:01:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231549AbhFKRDo (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 11 Jun 2021 13:03:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231613AbhFKRDf (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 11 Jun 2021 13:03:35 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57AE7C061574
        for <selinux@vger.kernel.org>; Fri, 11 Jun 2021 10:01:37 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id k25so5529854eja.9
        for <selinux@vger.kernel.org>; Fri, 11 Jun 2021 10:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rF3RW+vRTBdayrkEmU143aymaoHBMTIDi13FY84zy6k=;
        b=fNCIy4gcV+jUjxgmOzD8+ule7JxCtIt9PlXXjCK/F5siLoXPXuKRveEXNmmAyyi2kp
         Aa/Y1cOXgLGrmKSCs5TjzoQgx9OoRxhmez/7qIZ0M2gu8IoIV2SH/mEMObTWa20aiNTG
         UTjBUuQt/pW9UXnxcZFlDnWeQFf9oBAnC+KCqrGgI03xpR+BWXJzkobcLWyXfWmkirip
         PZlS9weU5Ou9WPDMeXhh9ljNAHqSVyQ3SMp/tbNmSSczT4B9oXFrIuGdmQY572uOsqiy
         UAG6+Yi2MG9BQCUS/Kh+CLe9vMwwObrYg2/CKtE5oFhZQhivA3gC25RWfWrTaeD9XLDZ
         GMVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rF3RW+vRTBdayrkEmU143aymaoHBMTIDi13FY84zy6k=;
        b=VU1Pa2BMSTis0OEaZSmZrvJISeOHlME6YDymrUIyGFjM3Si1KiHwCeexYit5whQ2f/
         sGFzlswjVQjNRLqyJnjldRa5jcNWosDjmFuZRdl6yjHpIBIjhaJKG4jwWjv9N+Dt6mdh
         kr37PmuUyIElnAGDXEt1FB3/CaYeG7lyViI7mVTLE+RyjG295AZAOgsbmwazhh77rjku
         qg7vXeFzQMRA4uzaAZgZvSZHRnWmmeiF6KukSrPYJjHEQUSbm1y0XrZmIVfN3eV9J9jz
         6QDuw3bb8tw3lS0jK3UF0n0S32COicjlx+PfmRRo25mdLJT9WGaC77Zn9OYelA+eoWZz
         BJDA==
X-Gm-Message-State: AOAM5333El42rJezANaniEH0Momp3VbX1b/xv9Ut1+gez3avIL8muIYg
        o0RBSLujcWUXZKujoEjV9OUToAYKxyR6FhGyNT2E
X-Google-Smtp-Source: ABdhPJwmTNWPO4JGLsdadACYta6CeOAq/UXMknSjqgw0d3bEuEX+uGxP6oYimSVp5XzRcQC4L7uXqr5Q+aU9AobwCl4=
X-Received: by 2002:a17:907:3d8e:: with SMTP id he14mr4663408ejc.178.1623430895727;
 Fri, 11 Jun 2021 10:01:35 -0700 (PDT)
MIME-Version: 1.0
References: <1623406567-51427-1-git-send-email-yang.lee@linux.alibaba.com>
In-Reply-To: <1623406567-51427-1-git-send-email-yang.lee@linux.alibaba.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 11 Jun 2021 13:01:24 -0400
Message-ID: <CAHC9VhT2mmgL8Vnrb35BEJkq+Wo2fT3Fc-HD51PwMyNGmsAWJQ@mail.gmail.com>
Subject: Re: [PATCH -next v2] selinux: Fix kernel-doc
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>, nathan@kernel.org,
        ndesaulniers@google.com, selinux@vger.kernel.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Jun 11, 2021 at 6:16 AM Yang Li <yang.lee@linux.alibaba.com> wrote:
>
> Fix function name and add comment for parameter state in ss/services.c
> kernel-doc to remove some warnings found by running make W=1 LLVM=1.
>
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> ---
>
> Change in v2
> --Add comment for parameter state
>
>  security/selinux/ss/services.c | 23 ++++++++++++++++++++++-
>  1 file changed, 22 insertions(+), 1 deletion(-)

Merged into selinux/next - thanks!

-- 
paul moore
www.paul-moore.com
