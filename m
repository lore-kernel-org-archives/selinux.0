Return-Path: <SRS0=WWIK=RZ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C147AC43381
	for <selinux@archiver.kernel.org>; Fri, 22 Mar 2019 20:00:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 860E521874
	for <selinux@archiver.kernel.org>; Fri, 22 Mar 2019 20:00:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="C8EnG3Nn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727086AbfCVUAF (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 22 Mar 2019 16:00:05 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:36316 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726589AbfCVUAE (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 22 Mar 2019 16:00:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=g9JaNDMvFMAM62vwNPQ5/TuvcMvCk3Ftabzyp8bNxns=; b=C8EnG3NnF9HDBrR9KjLd3Cgs3
        qelf1PoSRZODZcqvXFU818UL1qu/MYwjZRO2SG4YJpU4Lt3au0J6lIFX7Vhnumuf7tjgGwc+2uPmj
        5USHOk+FWSovAuXjVECU1KCiieD4ku3KdPJDWUrOYoKg+3qxyTgopM0zVfhHCG2lQ7jyOiutHW37+
        39n82yFF7h6rwyL+wVlFuxdoCZaP3gyMWSE3iCAhgFgnQ49l3yBEQTh3ph2lpPlQq16tMd6CCLAt7
        63lQ+jeXbpsQJUtXJkfoNGmIAHWd9FfkWNWR35DARY48p9lrbjyD8zjCRJV1c9t0LTa+QEjZYUr+3
        Kik8ykoSQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h7QK6-0003HC-Uc; Fri, 22 Mar 2019 19:59:26 +0000
Date:   Fri, 22 Mar 2019 12:59:26 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Christopher Lameter <cl@linux.com>
Cc:     Waiman Long <longman@redhat.com>, Oleg Nesterov <oleg@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Eric Paris <eparis@parisplace.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: Re: [PATCH 2/4] signal: Make flush_sigqueue() use free_q to release
 memory
Message-ID: <20190322195926.GB10344@bombadil.infradead.org>
References: <20190321214512.11524-1-longman@redhat.com>
 <20190321214512.11524-3-longman@redhat.com>
 <20190322015208.GD19508@bombadil.infradead.org>
 <20190322111642.GA28876@redhat.com>
 <d9e02cc4-3162-57b0-7924-9642aecb8f49@redhat.com>
 <01000169a686689d-bc18fecd-95e1-4b3e-8cd5-dad1b1c570cc-000000@email.amazonses.com>
 <93523469-48b0-07c8-54fd-300678af3163@redhat.com>
 <01000169a6ea5e46-f845b8db-730b-436e-980c-3e4273ad2e34-000000@email.amazonses.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01000169a6ea5e46-f845b8db-730b-436e-980c-3e4273ad2e34-000000@email.amazonses.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Mar 22, 2019 at 07:39:31PM +0000, Christopher Lameter wrote:
> On Fri, 22 Mar 2019, Waiman Long wrote:
> 
> > >
> > >> I am looking forward to it.
> > > There is also alrady rcu being used in these paths. kfree_rcu() would not
> > > be enough? It is an estalished mechanism that is mature and well
> > > understood.
> > >
> > In this case, the memory objects are from kmem caches, so they can't
> > freed using kfree_rcu().
> 
> Oh they can. kfree() can free memory from any slab cache.

Only for SLAB and SLUB.  SLOB requires that you pass a pointer to the
slab cache; it has no way to look up the slab cache from the object.

