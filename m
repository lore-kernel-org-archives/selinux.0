Return-Path: <SRS0=Kf9N=CD=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C91BC433E3
	for <selinux@archiver.kernel.org>; Tue, 25 Aug 2020 16:47:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D2FC207F7
	for <selinux@archiver.kernel.org>; Tue, 25 Aug 2020 16:47:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DbZ/bgUd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726356AbgHYQrL (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 25 Aug 2020 12:47:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725805AbgHYQrK (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 25 Aug 2020 12:47:10 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16F2AC061574;
        Tue, 25 Aug 2020 09:47:10 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id f42so5824784otf.13;
        Tue, 25 Aug 2020 09:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sdpM88ZBe1eamSpmEuD+p0dBuOgUUwlS0HGwX/1cLuU=;
        b=DbZ/bgUd0LNqxa6SHNAp9vhfMapWEVb254+1FqeLQdq7Em+KP6Q1kepjCzUcu75GzU
         DIJ8nuS/CRSboThl6sVhmozLQng65IwWa7oaM6Yq3GqBcJ/SoZJVcl7Dq9Nv5nvgpMf2
         BNAuQp3C5yMPjA8nivDSn9wXUaML3qScfuZts/k0KydAQJS3N3tGvCJO93lnszzU6s0e
         vZd0013JiVLayg8Z4mewUzHHL2DgUsPEcAmAbXreU3yEDyZl6Escm139sMwv73b9/jgv
         3G9UEV1PTNRI1OfwatGfMZK2W8MlZOFRSVLAt68BRJotB5oKEOa8qdYvRn2XGj/+8azC
         nB0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sdpM88ZBe1eamSpmEuD+p0dBuOgUUwlS0HGwX/1cLuU=;
        b=QPZPCrVOnbKPZNYBGl+fD6oe8vrGrRjpZsJLhMFWmT4ISTSIvdlVGEuuHINGaKbMl4
         JQj8LPrRnAz4L7rFaqeDVA3Q5wQT5S8ynXhZKkLEq69ZZsLInNy5GBVIZQEVSJc6lwLP
         k5I71V4V+TWMILsNP1pyqiRqwvforTr3Sk2HwEjpwdETOApffBYAlB0uyHY0qi3AVzvU
         CJc4A28lyoFoC7mKtc30cAtl+GLmboF4axSb1eBQB97V2iiuZmlQyJI+O4gepDnF/2gn
         Caf4WjPJ3pASf1zmL0/7dytAL1O8Oz/FKVDnfvshZUv1bCC5K+MZRgOisdKNsUVBvp/9
         EkIA==
X-Gm-Message-State: AOAM533cWltdyrLiKNW0T8qio+rHPZDw5KePhQnY8g2S+uBPpKHDSHYn
        D75v791KFa0TWCIXiuTcJX20TCkUtWmMHklfIBAaHxjlDJE=
X-Google-Smtp-Source: ABdhPJwVOgpJQjUDINlc0ARiD1G0Z5B/HzFSVlm4XW9PYlV8EciumI1oJIQIybZ1aFMVSuW5ALfMjKMtK7XfLh2vr38=
X-Received: by 2002:a9d:25:: with SMTP id 34mr5265062ota.135.1598374029471;
 Tue, 25 Aug 2020 09:47:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200825152045.1719298-1-omosnace@redhat.com> <20200825152045.1719298-4-omosnace@redhat.com>
In-Reply-To: <20200825152045.1719298-4-omosnace@redhat.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Tue, 25 Aug 2020 12:45:43 -0400
Message-ID: <CAEjxPJ54cS+HOPxb839UWu3UiCbv=eMRAfyRHbCy_5bAxU0a6A@mail.gmail.com>
Subject: Re: [RFC PATCH 3/3] selinux: track policy lifetime with refcount
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        rcu@vger.kernel.org, "Paul E . McKenney" <paulmck@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Aug 25, 2020 at 11:20 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> Instead of holding the RCU read lock the whole time while accessing the
> policy, add a simple refcount mechanism to track its lifetime. After
> this, the RCU read lock is held only for a brief time when fetching the
> policy pointer and incrementing the refcount. The policy struct is then
> guaranteed to stay alive until the refcount is decremented.
>
> Freeing of the policy remains the responsibility of the task that does
> the policy reload. In case the refcount drops to zero in a different
> task, the policy load task is notified via a completion.

That's an interesting pattern.  Is this approach used anywhere else in
the kernel?  I didn't see any examples of it in the RCU documentation.

> The advantage of this change is that the operations that access the
> policy can now do sleeping allocations, since they don't need to hold
> the RCU read lock anymore. This patch so far only leverages this in
> security_read_policy() for the vmalloc_user() allocation (although this
> function is always called under fsi->mutex and could just access the
> policy pointer directly). The conversion of affected GFP_ATOMIC
> allocations to GFP_KERNEL is left for a later patch, since auditing
> which code paths may still need GFP_ATOMIC is not very easy.

Technically we don't need this patch for that purpose because
rcu_read_lock() isn't actually needed at all in
security_read_policy(), so I think we're better off just getting rid
of it there and letting it use rcu_dereference_check(..., 1) or
rcu_dereference_protected() instead.
