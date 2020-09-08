Return-Path: <SRS0=EaKV=CR=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53BBBC433E2
	for <selinux@archiver.kernel.org>; Tue,  8 Sep 2020 10:25:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E6CDC208C7
	for <selinux@archiver.kernel.org>; Tue,  8 Sep 2020 10:25:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UPjh9SJA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729406AbgIHKZw (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 8 Sep 2020 06:25:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729031AbgIHKZv (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 8 Sep 2020 06:25:51 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56BD7C061573;
        Tue,  8 Sep 2020 03:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=3PMzoeG0jLYH6a5jncrRPYuy7xbDoeom4wasamz/iBA=; b=UPjh9SJAsH6DRbPldgyO0bFYbz
        7KeipEdsRPnr4iZ4TAKWE9HDIB1fr0vp9/zYDYNgB1ZG4onTRSLW0Dnc/JUIUqt/IH2MMwSGbssHX
        Fniw4/RGfZoJfdM4u4M0xwdH6FdB3DiT/MV8nUSOqmDlYLPvbHLjSkgx7Cb9qwaDryDE70wrPjgap
        gP+/74T0jJabj4DCVrcFzN0cIbIs4jYL2EBQMMsmHDDzNhsxKM3PEe3X1+vjbG8JWtXUm0THPl/aR
        sEo2QrKLub+CwnvETCVRJSuvURLxggHJ7WDnCa3sgHlT9hb9AlD1bTx01MyIPy1TGdjnEnh95wzD7
        315lZ6cg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kFaol-0005ND-2Y; Tue, 08 Sep 2020 10:25:39 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 205C8304B92;
        Tue,  8 Sep 2020 12:25:38 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 018B823D54AB1; Tue,  8 Sep 2020 12:25:37 +0200 (CEST)
Date:   Tue, 8 Sep 2020 12:25:37 +0200
From:   peterz@infradead.org
To:     Christian =?iso-8859-1?Q?G=F6ttsche?= <cgzones@googlemail.com>
Cc:     linux-kernel@vger.kernel.org, selinux@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>
Subject: Re: [RFC PATCH] sched: only issue an audit on privileged operation
Message-ID: <20200908102537.GU2674@hirez.programming.kicks-ass.net>
References: <20200904160031.6444-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200904160031.6444-1-cgzones@googlemail.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Sep 04, 2020 at 06:00:31PM +0200, Christian Göttsche wrote:
> sched_setattr(2) does via kernel/sched/core.c:__sched_setscheduler()
> issue a CAP_SYS_NICE audit event unconditionally, even when the requested
> operation does not require that capability / is un-privileged.
> 
> Perform privilged/unprivileged catigorization first and perform a
> capable test only if needed.
> 
> Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
> ---
>  kernel/sched/core.c | 65 ++++++++++++++++++++++++++++++++-------------
>  1 file changed, 47 insertions(+), 18 deletions(-)

So who sodding cares about audit, and why is that a reason to make a
trainwreck of code?
