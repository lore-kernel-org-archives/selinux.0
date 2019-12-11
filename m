Return-Path: <SRS0=W72o=2B=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BACE3C00454
	for <selinux@archiver.kernel.org>; Wed, 11 Dec 2019 15:49:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90A102077B
	for <selinux@archiver.kernel.org>; Wed, 11 Dec 2019 15:49:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JQ+T1bbR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732879AbfLKPYo (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 11 Dec 2019 10:24:44 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:46658 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732714AbfLKPYn (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 11 Dec 2019 10:24:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=lCtKLzzdaOAiKN6oGE3yx6uTT5U+M8wV3nEecLRcZL4=; b=JQ+T1bbRmiOoN11jYVC7+m0HU
        JoyGLNA3Nzw1yp7vwy93I53nt5PqCLktzdgmHlodPSYRBP/HJ6z3hZMf9gWmZokOE8ltuaquR05Cz
        mh7n3UdMKbcvok3uc+IYpnOsTzdHT+oK0Cd1IOXLrtnznq3i72h+XDgKNNEtH3YCHpyOVOGEeDSVU
        ZdY9dzNbIkF61y5/Kk4IXcyJ3HLTVcH7P5y9SsVsWaaXMuCAN+eOPKnrHFlq5Io0xxz/FCzLFaC6z
        Gmo6Eog8Rbc/geQNHiYrLw84TJkBbw71cV1QH/c9t6gRmbvzTmGk3mSeDv4a2Nq9zefrComnPIvZJ
        LGByA1Pdw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1if3qw-0001sp-5J; Wed, 11 Dec 2019 15:24:38 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 56095306060;
        Wed, 11 Dec 2019 16:23:15 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3BF3220137C8F; Wed, 11 Dec 2019 16:24:35 +0100 (CET)
Date:   Wed, 11 Dec 2019 16:24:35 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@redhat.com>,
        Andi Kleen <ak@linux.intel.com>, elena.reshetova@intel.com,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Stephane Eranian <eranian@google.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 0/3] Introduce CAP_SYS_PERFMON capability for secure
 Perf users groups
Message-ID: <20191211152435.GN2827@hirez.programming.kicks-ass.net>
References: <283f09a5-33bd-eac3-bdfd-83d775045bf9@linux.intel.com>
 <1e836f34-eda3-542d-f7ce-9a3e87ac5e2e@schaufler-ca.com>
 <d0c6f000-4757-02d8-b114-a35cbb9566ed@linux.intel.com>
 <a81248c5-971a-9d3f-6df4-e6335384fe7f@schaufler-ca.com>
 <ab206ef5-466e-7bce-3e5f-53da110bddb2@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ab206ef5-466e-7bce-3e5f-53da110bddb2@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Dec 11, 2019 at 01:52:15PM +0300, Alexey Budankov wrote:
> Undoubtedly, SELinux is the powerful, mature, whole level of functionality that
> could provide benefits not only for perf_events subsystem. However perf_events
> is built around capabilities to provide access control to its functionality,
> thus perf_events would require considerable rework prior it could be controlled
> thru SELinux. 

You mean this:

  da97e18458fb ("perf_event: Add support for LSM and SELinux checks")

?

> Then the adoption could also require changes to the installed
> infrastructure just for the sake of adopting alternative access control mechanism.

This is still very much true.
