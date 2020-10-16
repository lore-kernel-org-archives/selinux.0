Return-Path: <SRS0=kXWH=DX=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32ED3C433E7
	for <selinux@archiver.kernel.org>; Fri, 16 Oct 2020 14:22:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC51A20866
	for <selinux@archiver.kernel.org>; Fri, 16 Oct 2020 14:22:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1602858136;
	bh=ZsxYnxmSLZmi0mWIGgwokYR34n/peDNXDgnu0t5EgpI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Dxn4HOmsHIeIwO+uCVT9vrtGGbNCj2OSentbfAuYHutMgO1nqn5d9hsBaBfzEfi2h
	 mRshYRcQwPyaoLa7QpkGISx2DFY7+O4u34lNoLpA4s056dLBrhgC3BH4X2ufhv8IgF
	 O9yNKboB9PO/4sikcAzpjbDkuq2YYPlvsd8D7KbY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408792AbgJPOWQ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 16 Oct 2020 10:22:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:37804 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2394682AbgJPOWP (ORCPT <rfc822;selinux@vger.kernel.org>);
        Fri, 16 Oct 2020 10:22:15 -0400
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E1DBE20848;
        Fri, 16 Oct 2020 14:22:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602858135;
        bh=ZsxYnxmSLZmi0mWIGgwokYR34n/peDNXDgnu0t5EgpI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KS/BBjI5F41mQ9RUb1/QE0SRj8Iab1AnG6wUxHolWQ+eGge9epU088b1z8N0WDpge
         QbvCgCzDKjSYWPWzGiRpPoJVMsKPoejmoNLaI5HDb7naDclQz20Om30TdCzIQJwaiQ
         6a67cKTcw1DM5/WNzlG+xpSSv0BTHcKoZ5mjnPwo=
Date:   Fri, 16 Oct 2020 10:22:13 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Paul Moore <paul@paul-moore.com>
Cc:     Daniel Burgener <dburgener@linux.microsoft.com>,
        Greg KH <greg@kroah.com>, stable@vger.kernel.org,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        selinux@vger.kernel.org, James Morris <jmorris@namei.org>
Subject: Re: [PATCH v5.4 0/3] Update SELinuxfs out of tree and then swapover
Message-ID: <20201016142213.GV2415204@sasha-vm>
References: <20201015192956.1797021-1-dburgener@linux.microsoft.com>
 <20201016050036.GB461792@kroah.com>
 <9aeaa66d-d369-a1eb-7a07-08d9244585f3@linux.microsoft.com>
 <CAHC9VhR_WG13wLT-rJs0AdDgh6kwN_ei46btyXp5KusUdzuOag@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAHC9VhR_WG13wLT-rJs0AdDgh6kwN_ei46btyXp5KusUdzuOag@mail.gmail.com>
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Oct 16, 2020 at 09:55:25AM -0400, Paul Moore wrote:
>On Fri, Oct 16, 2020 at 9:05 AM Daniel Burgener
><dburgener@linux.microsoft.com> wrote:
>> Yes, thank you.  I will fix up the series with the third commit
>> included, and add commit ids.  Thanks.
>
>Greg and I have different opinions on what is classified as a good
>candidate for the -stable trees, but in my opinion this patch series
>doesn't qualify.  There are a lot of dependencies, it is intertwined
>with a lot of code, and the issue that this patchset fixes has been
>around for a *long* time.  I personally feel the risk of backporting
>this to -stable does not outweigh the potential wins.

My understanding is that while the issue Daniel is fixing here has been
around for a while, it's also very real - the reports suggest a failure
rate of 1-2% on boot.

I do understand your concerns around this series, but given it was just
fixed upstream we don't have a better story than "sit tight for the
next LTS" to tell to users affected by this issue.

Is there a scenario where you'd feel safer with the series? I suspect
that if it doesn't go into upstream stable Daniel will end up carrying
it out of tree anyway, so maybe we can ask Daniel to do targetted
testing for the next week or two and report back?

-- 
Thanks,
Sasha
