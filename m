Return-Path: <SRS0=RDES=B7=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7080C433DF
	for <selinux@archiver.kernel.org>; Fri, 21 Aug 2020 13:43:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C05620FC3
	for <selinux@archiver.kernel.org>; Fri, 21 Aug 2020 13:43:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="C2OOoRUP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726975AbgHUNnh (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 21 Aug 2020 09:43:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727843AbgHUNna (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 21 Aug 2020 09:43:30 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 365A3C061573
        for <selinux@vger.kernel.org>; Fri, 21 Aug 2020 06:43:30 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id a26so2348518ejc.2
        for <selinux@vger.kernel.org>; Fri, 21 Aug 2020 06:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NwPYAaAyjgcgcGgiOAPq785/sNM+j+6uNMAeEOCCIYQ=;
        b=C2OOoRUPg5JdyGi7R5v6jL/8I86rGRKKmib3ykTZ0jPM0l/xCiP70gNgQ8B4g5hHQv
         ZFzl2WMy1xx/1z6vsSe8+7aqo2+QIg4gzsHK8sYUsUL+cGrp3U1eXJKXa37HkA4maezX
         j0E49FnfY0OH1MBnWAPtpyJcFN4V7/Db3nLRO07/8qxfyU2fySzHPgYhm9fAxxUVA/lM
         /sExE5yM4HxU04sB6tro+bFD3+YgcsCT2E5nS3gXC5eafDZwCXtQsGAV9jCGIRvL83Wv
         PE/SNyEJrs5HzxVh7NoSNIp0067uwpbq3tLIsX5v5drqTXc3OSXg07nZl6jS1akSqkw7
         OVBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NwPYAaAyjgcgcGgiOAPq785/sNM+j+6uNMAeEOCCIYQ=;
        b=JP1e/dLb/1sPn4EGcg5l0eDXKnf/CNak+zmvvu7H3I+HR0AL3eq8rhVjsUrUGhs781
         JvpRvVfJF/sm7R9k2CmSbsTMsteX+AlcIjn2+QgN7jkcOoOOhqkgGiz5SUR3iu1WiwSM
         T/cIG4mzGfyhywnkn0CQv6uhWzsVw4Wg4tUXPLhJb9JJfK7uQ47vZK8p5MYtDUKPRMoc
         6re88mJw3PfHZDBnaD8xe+NbmdoT8Oil8z5Cl8TEkuDhl7YW3D8huJpRtC3B463wnRIF
         uHnaFIS9mAJbTP+f7XB6S4Z3HEKeVxAJJdTp21eCDvP3w0MiAD8w41BsRg0+o/KBCH4B
         1b4A==
X-Gm-Message-State: AOAM533IYt9x8+4hvzsWnjstx+EG5W9/tHF3cuzx/tR/T5gWtDiA4pSr
        4E8sAZsnLaWtzphHxmuqoD/VobZK7cJCo78B9bzyVnKJRbDX
X-Google-Smtp-Source: ABdhPJx/JW++1YCyrYu7jShC9KtWQ5VmMfCwSPJyKTJ5baRc9q/Nu4UyhcADgnYRthpWL2h2Cv6KRIuFOvH/lc/C7mI=
X-Received: by 2002:a17:906:c1d8:: with SMTP id bw24mr2924861ejb.91.1598017408415;
 Fri, 21 Aug 2020 06:43:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200819195935.1720168-1-dburgener@linux.microsoft.com> <20200819195935.1720168-2-dburgener@linux.microsoft.com>
In-Reply-To: <20200819195935.1720168-2-dburgener@linux.microsoft.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 21 Aug 2020 09:43:16 -0400
Message-ID: <CAHC9VhTi1F9XgZvOkRgx7zTXLQx8mN8oEBLKdDfTKRntiRx0Fg@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] selinux: Create function for selinuxfs directory cleanup
To:     Daniel Burgener <dburgener@linux.microsoft.com>
Cc:     selinux@vger.kernel.org,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Aug 19, 2020 at 3:59 PM Daniel Burgener
<dburgener@linux.microsoft.com> wrote:
>
> Separating the cleanup from the creation will simplify two things in
> future patches in this series.  First, the creation can be made generic,
> to create directories not tied to the selinux_fs_info structure.  Second,
> we will ultimately want to reorder creation and deletion so that the
> deletions aren't performed until the new directory structures have already
> been moved into place.
>
> Signed-off-by: Daniel Burgener <dburgener@linux.microsoft.com>
> ---
>  security/selinux/selinuxfs.c | 39 +++++++++++++++++++++++-------------
>  1 file changed, 25 insertions(+), 14 deletions(-)

Merged into selinux/next, thanks!

-- 
paul moore
www.paul-moore.com
