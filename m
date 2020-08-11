Return-Path: <SRS0=GpsN=BV=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 823ECC433E0
	for <selinux@archiver.kernel.org>; Tue, 11 Aug 2020 17:47:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 53B852076B
	for <selinux@archiver.kernel.org>; Tue, 11 Aug 2020 17:47:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CWXjpiYx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728862AbgHKRrz (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 11 Aug 2020 13:47:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728554AbgHKRrz (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 11 Aug 2020 13:47:55 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27247C06174A
        for <selinux@vger.kernel.org>; Tue, 11 Aug 2020 10:47:55 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id d14so12407696qke.13
        for <selinux@vger.kernel.org>; Tue, 11 Aug 2020 10:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=fjRpGkmD0TES77Tu+mBPC89FFzgZHpVAcnKyX76pCic=;
        b=CWXjpiYxQ4dQ5O3OT0GqlRXqVGgZuCHVZBhfm3eNyLbBiInT1ZCDlvzQIrpRhlV/U0
         DDEpqppYWLr5PC3ENQhgfg0AZszmYEeEim7BFLuuOGpozkknjWN2V2/po690E8Eq29e+
         AwnNLDhsW5D0FowqK9wCKF7+WLbsuZJXuWblpNpb1+zeIklM4tYBJwATfww2UCzKj50H
         8G3NkTvUdVbqvuvwvsAI8Y3DuVAYksxNj4d3tv/iqfA9kmfr27gz33PxgKeeRbXu0rzH
         Ea0jOUd0lXcjd7huJ8Mt1ONOTuXZNPuCwgsZzFszo1lAX1xlrPU+4XXadTJSq7Uo2IcV
         FfMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=fjRpGkmD0TES77Tu+mBPC89FFzgZHpVAcnKyX76pCic=;
        b=LrgoUNRcMVHknj9T2r7F8/qAXLO1hF9doZGN3iMhVohJuj4kElvqlMfpySknwZyb3S
         H5xZ1h61BdIZxWwi/XNflvLDHX5uKfQ2nr9ihHwobicOTWLxLuCovs4fy9ELBd9dTnka
         x7F+pmLuoYmF7tyaf3iczSdUhoEJMCDPVlCqzy04oZZzR6VRhQua9Mw4FOl3FkS+Xw8j
         N84aZKAPPE0O3AH3F2pT6HSoAK4+2pbRMRBGFzqsvLKDslEQP4aVQBlOqSfJ/VXQlmsf
         yfK4zTAuhKadle21CG9VZpSbbGjGhNPc3AflqwMN2saWhyNbk70W9IHmVsgIR9fVKsu7
         F7mw==
X-Gm-Message-State: AOAM533uhoSbHY5h6GEJtQezEJgBEMECU42nHozKJb5Z9xw1ykBoP1Zp
        rGWaZbhOIO1BFERva9qrWhEcyOF4
X-Google-Smtp-Source: ABdhPJy/6wCd2Wl6hjht2LlX5CX+PC0j9oldSc7p8+su3jGgQd36qyrCZEop2IFpv7llPrpfO0Gofg==
X-Received: by 2002:a05:620a:4045:: with SMTP id i5mr2343326qko.108.1597168073634;
        Tue, 11 Aug 2020 10:47:53 -0700 (PDT)
Received: from [192.168.1.190] (pool-68-134-6-11.bltmmd.fios.verizon.net. [68.134.6.11])
        by smtp.gmail.com with ESMTPSA id t8sm21220021qtc.50.2020.08.11.10.47.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Aug 2020 10:47:53 -0700 (PDT)
Subject: Re: [PATCH testsuite v2 2/2] travis: run the full testsuite on a
 Fedora VM
To:     Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org
References: <20200811084555.105374-1-omosnace@redhat.com>
 <20200811084555.105374-3-omosnace@redhat.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Message-ID: <a7e521af-48ba-47d1-c752-1222ecc135ad@gmail.com>
Date:   Tue, 11 Aug 2020 13:47:51 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200811084555.105374-3-omosnace@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 8/11/20 4:45 AM, Ondrej Mosnacek wrote:

> This patch removes the old hackery to test-build the testsuite and
> replaces it with scripts that run the full testsuite on a Fedora VM. The
> scripts are based on William Roberts' work on SELinux userspace CI [1],
> which does a similar thing.
>
> This patch enables testing on Fedora 32 (the image ships with kernel
> 5.6.6) and Rawhide nightly images (with kernels close to mainline).
> Switching to other versions can be controlled via CI environment
> variables.
>
> One downside is that with this patch we lose the test build against
> refpolicy, but it shouldn't be too hard to add testing on a Debian VM
> with refpolicy later on.
>
> [1] https://github.com/SELinuxProject/selinux/commit/562d6d15272420542bf65da328bc5300219fce76
>
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---

Thanks, this is great.  One more question: when we added the VM-based 
testing to the selinux userspace travis, we nonetheless kept the old 
limited build / unit test run on the Ubuntu image as well to provide 
some degree of sanity checking there (plus it is much faster and 
possibly less prone to intermittent breakage).  Is there a reason to 
drop the "old hackery" entirely or should we retain it too?  Up to you.


