Return-Path: <SRS0=WWIK=RZ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5256C43381
	for <selinux@archiver.kernel.org>; Fri, 22 Mar 2019 01:52:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99D7B218E2
	for <selinux@archiver.kernel.org>; Fri, 22 Mar 2019 01:52:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JUvjG7dL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727532AbfCVBw5 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 21 Mar 2019 21:52:57 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:55670 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727484AbfCVBw5 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 21 Mar 2019 21:52:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=40NWW8wLR1ruw4bwc6cScxdYZkXDr2Pxr9BdklVtdM4=; b=JUvjG7dL+Zhx0nDTZf6CzESCk
        +hW90ni/TULy5MPA+m+P9k1P0lD1verHqsYtRH64fANL3gDMoggs0scCQ9XL+RyWZ9s1obr+PzENn
        qA6Nwqtw3zbfAh+4X1UOQQZh+2XiQhbjDDNesOkrwx0ar8AmidhxBEOpEIIntbmxAFE9RDInqxVal
        u+U9tQOOWgAizuJmzF2JsVlLzOAmY+kB0McsfWT7AgjGTbf2Udwzoq1sbbM49hO0ywY4FVwoZ2c0f
        MKPMwdJSLSqttRzikdI4hiJqUD+Tbi7SMwrjYQ8/wc8kPZWxsNyy0ZwH3ZkDDoUB/+ME2jiEVf73Z
        eis8n0MkQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h79Lt-0002cG-4i; Fri, 22 Mar 2019 01:52:09 +0000
Date:   Thu, 21 Mar 2019 18:52:08 -0700
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
Subject: Re: [PATCH 2/4] signal: Make flush_sigqueue() use free_q to release
 memory
Message-ID: <20190322015208.GD19508@bombadil.infradead.org>
References: <20190321214512.11524-1-longman@redhat.com>
 <20190321214512.11524-3-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190321214512.11524-3-longman@redhat.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Mar 21, 2019 at 05:45:10PM -0400, Waiman Long wrote:
> It was found that if a process had many pending signals (e.g. millions),
> the act of exiting that process might cause its parent to have a hard
> lockup especially on a debug kernel with features like KASAN enabled.
> It was because the flush_sigqueue() was called in release_task() with
> tasklist_lock held and irq disabled.

This rather apocalyptic language is a bit uncalled for.  I appreciate the
warning is scary, but all that's really happening is that the debug code
is taking too long to execute.

> To avoid this dire condition and reduce lock hold time of tasklist_lock,
> flush_sigqueue() is modified to pass in a freeing queue pointer so that
> the actual freeing of memory objects can be deferred until after the
> tasklist_lock is released and irq re-enabled.

I think this is a really bad solution.  It looks kind of generic,
but isn't.  It's terribly inefficient, and all it's really doing is
deferring the debugging code until we've re-enabled interrupts.

We'd be much better off just having a list_head in the caller
and list_splice() the queue->list onto that caller.  Then call
__sigqueue_free() for each signal on the queue.
