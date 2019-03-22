Return-Path: <SRS0=WWIK=RZ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EA7AC43381
	for <selinux@archiver.kernel.org>; Fri, 22 Mar 2019 10:16:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DF5D21900
	for <selinux@archiver.kernel.org>; Fri, 22 Mar 2019 10:16:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="eHZqkMXu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727936AbfCVKQB (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 22 Mar 2019 06:16:01 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:48150 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727860AbfCVKQA (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 22 Mar 2019 06:16:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=nBJewWCbdaJ5X4iQT6hRh0j0tFDuXREWOR4IbUJXZrw=; b=eHZqkMXuJaUupBq5agtV44k7F
        rlUiJ5cff+KL4dk+vjyMIFhLoq4JYR0WhK1ryKV7Nym63LnjGzMxBoF7HODFZyQuc1Zbb2hlBIlFH
        77oZYullmVvDUschGOvwJxz1lqJf73QZPU364tHP/Wo7XGZICNCGIETJO/443iPrcSIWCock3qWYB
        9nDvjnTkEZr6RyExdNRDyrQGRTu1GNBu4BevbyT/ZPs9HTctSQpu2/n+OiuQ19rVZT2sBOg2K/2B1
        VVl/vIvTNpogP3pjWIta6k4fqBzVTHxeU0lc9vuMrv+O1eq+CzFe1WDPpeNaHB1W3Ep9RfU4VoXd/
        KUnsSV5IA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h7HD6-0003yd-1c; Fri, 22 Mar 2019 10:15:36 +0000
Date:   Fri, 22 Mar 2019 03:15:35 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Eric Paris <eparis@parisplace.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH 0/4] Signal: Fix hard lockup problem in flush_sigqueue()
Message-ID: <20190322101535.GA10344@bombadil.infradead.org>
References: <20190321214512.11524-1-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190321214512.11524-1-longman@redhat.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Mar 21, 2019 at 05:45:08PM -0400, Waiman Long wrote:
> It was found that if a process has accumulated sufficient number of
> pending signals, the exiting of that process may cause its parent to
> have hard lockup when running on a debug kernel with a slow memory
> freeing path (like with KASAN enabled).

I appreciate these are "reliable" signals, but why do we accumulate so
many signals to a task which will never receive them?  Can we detect at
signal delivery time that the task is going to die and avoid queueing
them in the first place?
