Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABF63C433DB
	for <selinux@archiver.kernel.org>; Tue, 12 Jan 2021 15:18:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 62FDF23130
	for <selinux@archiver.kernel.org>; Tue, 12 Jan 2021 15:18:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390851AbhALPSy (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 12 Jan 2021 10:18:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390809AbhALPSx (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 12 Jan 2021 10:18:53 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3963DC061575
        for <selinux@vger.kernel.org>; Tue, 12 Jan 2021 07:18:12 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id c7so2706700edv.6
        for <selinux@vger.kernel.org>; Tue, 12 Jan 2021 07:18:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jJG29ph/Ugx0dR9hj/JzxougdawYmaCx65Nqn6vY+wY=;
        b=t9t1/I/AFm9MpO4SQ96u2xiiKSsJqzeG2NzqSiCXW87qbsFBW7trEhVMNEoYzvXMrA
         Wk95NmaXVYmLf0C6d5u9hfkV6zX1dbIroQP7XbgzN58d2FUtP9RansxlSy+oUFLjX7CC
         sxpbrl0fwNtuAtvNd8MAkwVfcVnbBkzW5trUNEO+UYW10MdT8GBrUQTOrjjtT+lzKM9X
         4OHSHblyhuCIk5Pug8Ys5G4XlonOaG/FOXn1gbX+HxA/HbdOaCzJ+gnvLcaQUsxRqJJB
         AM9Emka/4zH2NWk4UiLxpzLRmDkH7Qi4E9rmwuVyOYQJPUr81tLEwjqrk7ZYplMJ8Ov9
         1eiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jJG29ph/Ugx0dR9hj/JzxougdawYmaCx65Nqn6vY+wY=;
        b=fVRONNzEkb5wIiGd905a2afnFw702iT27J3XE7k+7hXmBN4g8Vk/u2InPM57q4bUzO
         u4KyxHihJ6mgOsB2LpMBahXVjqItEQrTvbUYaskADrLoy/+aMtfruXm+V3v+xPKa3AAD
         RsFDBO6LNLxtzd2d9Cw4Ibmrs+PqKzWWGlStGHxn6jm76kM4edYmS1rfyelnRgzd9xWr
         3S+6TNLbhrEKWZw9xbMWcd0ZkvR8gaDWSVDKyP1BsdjQMeA3HFiBQR+U03ww6GroVbA8
         hLmK5F7R5pgfYa9DZ9j02oDSCU1bSLWCYQA7VBffpNe98MphXVtfP6lpcOAcaoDzndvg
         A/7w==
X-Gm-Message-State: AOAM530twvk3L3vY3ydErwjlaWKPBHFhBOQ/S9+zMYJJr3SSlqCZAfBv
        E1wu3NRUKZA9HFw6eTdVQQ5hCBgstX0YeKTGG3LpY2a+Hw==
X-Google-Smtp-Source: ABdhPJxAobFMprk5SLYt/vj2YBRUWAhhN5QLreWk3EFbFqvDRM9akqR7rJ6J0MY6+AgJQxX5tY6f68SozG3IKcaUYy4=
X-Received: by 2002:aa7:d64d:: with SMTP id v13mr3898077edr.196.1610464690856;
 Tue, 12 Jan 2021 07:18:10 -0800 (PST)
MIME-Version: 1.0
References: <20210106132622.1122033-1-omosnace@redhat.com> <20210106132622.1122033-6-omosnace@redhat.com>
In-Reply-To: <20210106132622.1122033-6-omosnace@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 12 Jan 2021 10:18:00 -0500
Message-ID: <CAHC9VhQ5_Ckv_HUubh9zHGY2vNSPyx-37A7N7X8h=9q15XQ67g@mail.gmail.com>
Subject: Re: [PATCH 5/5] selinux: mark selinux_xfrm_refcount as __read_mostly
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     selinux@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Jan 6, 2021 at 8:26 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> This is motivated by a perfomance regression of selinux_xfrm_enabled()
> that happened on a RHEL kernel due to false sharing between
> selinux_xfrm_refcount and (the late) selinux_ss.policy_rwlock (i.e. the
> .bss section memory layout changed such that they happened to share the
> same cacheline). Since the policy rwlock's memory region was modified
> upon each read-side critical section, the readers of
> selinux_xfrm_refcount had frequent cache misses, eventually leading to a
> significant performance degradation under a TCP SYN flood on a system
> with many cores (32 in this case, but it's detectable on less cores as
> well).
>
> While upstream has since switched to RCU locking, so the same can no
> longer happen here, selinux_xfrm_refcount could still share a cacheline
> with another frequently written region, thus marking it __read_mostly
> still makes sense. __read_mostly helps, because it will put the symbol
> in a separate section along with other read-mostly variables, so there
> should never be a clash with frequently written data.
>
> Since selinux_xfrm_refcount is modified only in case of an explicit
> action, it should be safe to do this (i.e. it shouldn't disrupt other
> read-mostly variables too much).
>
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>  security/selinux/xfrm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Even on a system that is using labeled IPsec, which is likely very
rare, the refcount should really only be changing when the SPD or SAD
changes which should be measured in minutes or seconds on a loaded
system.  If the __read_mostly tag proves to be a problem we can always
look into other solutions.

Merged into selinux/next, thanks.

-- 
paul moore
www.paul-moore.com
