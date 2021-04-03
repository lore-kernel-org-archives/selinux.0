Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64BFBC433B4
	for <selinux@archiver.kernel.org>; Sat,  3 Apr 2021 14:33:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A37C61242
	for <selinux@archiver.kernel.org>; Sat,  3 Apr 2021 14:33:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231681AbhDCOdd (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 3 Apr 2021 10:33:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236431AbhDCOdc (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sat, 3 Apr 2021 10:33:32 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E532C061788
        for <selinux@vger.kernel.org>; Sat,  3 Apr 2021 07:33:28 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id r12so10932152ejr.5
        for <selinux@vger.kernel.org>; Sat, 03 Apr 2021 07:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PKvsSUnLc1lwCYoNX9nYiZPdPvhVQHWnDlTVl94e+8E=;
        b=Qru8VSCrqSAjD7o+EOa552SvpBAaP8nt7nYoCJODXb+JBwYR/u5NgH46hBGm/YQIKA
         73BzYkX9jUwnhNohQIvFieOgBxjiPuz4xhlOobQSKmVJAypfx/yaGaGner00oVxYD0Je
         TRGWqIHvevW6VWzTxx4vVJ3sopdLaI6V5p+6QXdZwBCYVsUKe2lQDOMabtbWyL1kGauG
         /Y8UBbW1SEfVU9o1LhVy/BQJyPEuW7vl7xVKtSspYtQxTlgRWBtnNV5k5S4DThE1F/Bx
         +xbLdP1nA2KCw6ePO6jDTVxdVHkqv4yanSeSBenoq1YwL6n4i70O1b5AXNFmb0Bh28b/
         svyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PKvsSUnLc1lwCYoNX9nYiZPdPvhVQHWnDlTVl94e+8E=;
        b=LMJf1OG+OrWfuz26NlcJodEWEZkW3O8l/FHl3SyywcI+mZxuGVCRnc8hAbCCZ4NO7Z
         yTBXlNFVkr1X5hJeKnlXPk3P4zVIwLlF8+5eFC44UQmzRonwNOy/5cDWFJR/fEQ/Bhei
         Wvfv0WHetJ8CWPAd4ACrropfPyiC2dMGRn5RZcNVM/KK6Xw4wkMEgp+l2bWld9F4Ec/6
         WZiIdGhQB1fLW6hUm8y+0ipzpi4hctX6ZomGBZPSGzQcMs/dRJpBjeE6B+48ykpXUYs8
         nQQ+kVddxHpemxe8RcqyvaOzDa881FQPv38iBtLLIOc9W/6vjUm2gILkDDa8CzDvLZGb
         Hidg==
X-Gm-Message-State: AOAM530HzIQLQAApmg8qzuzKHi1Zt4Od8UeylfxziMyk7A9W+894F3Wa
        3uerQlcM07Evwt617q/iUow7WlZ6YmOPRJSHj45iJTVwQqCG
X-Google-Smtp-Source: ABdhPJzeDtKTRi8R6rfLL7dQf2L79CQQqmOB0lLBHTMxvkOcLKkWagq/cNB9gf47WxPCqf6dMYGqo1FSNqd/k3AotFM=
X-Received: by 2002:a17:906:f283:: with SMTP id gu3mr18829894ejb.91.1617460406662;
 Sat, 03 Apr 2021 07:33:26 -0700 (PDT)
MIME-Version: 1.0
References: <3c63e34b-e54f-9b01-bad4-8fde8528a64d@linux.microsoft.com>
In-Reply-To: <3c63e34b-e54f-9b01-bad4-8fde8528a64d@linux.microsoft.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Sat, 3 Apr 2021 10:33:15 -0400
Message-ID: <CAHC9VhTD2iXw7CkxgwnOx1zNN_AqMV+x1Vy8FijdMQE1m4AOJA@mail.gmail.com>
Subject: Re: [BUG] Oops in sidtab_context_to_sid
To:     Vijay Balakrishna <vijayb@linux.microsoft.com>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        Ondrej Mosnacek <omosnace@redhat.com>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        selinux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Apr 2, 2021 at 6:35 PM Vijay Balakrishna
<vijayb@linux.microsoft.com> wrote:
>
> Seeing oops in 5.4.83 sidtab_context_to_sid().  I checked with Tyler (copied),  he said it might be
>
> https://lore.kernel.org/selinux/CAFqZXNu8s5edDbSZuSutetTsy58i08vPuP2h-n9=kT34HcPc4w@mail.gmail.com/
>
> Ondrej, can you confirm?  Unfortunately, we don't have a on demand repro.

I'm guessing this may be the problem that Tyler reported earlier and
which appeared to be fixed by the patch below:

https://lore.kernel.org/selinux/20210318215303.2578052-3-omosnace@redhat.com

... which was merged into Linus' tree during the v5.12-rcX development
phase, any chance you could try that patch to see if it resolves your
issue?  There are still some issues to be sorted out, but if you
aren't reloading policy it shouldn't be a concern.

Tyler, since both of you are at Microsoft, do you have a patched
kernel that Vijay could try?

-- 
paul moore
www.paul-moore.com
