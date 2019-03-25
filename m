Return-Path: <SRS0=9nT4=R4=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBCD4C43381
	for <selinux@archiver.kernel.org>; Mon, 25 Mar 2019 14:15:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B995720863
	for <selinux@archiver.kernel.org>; Mon, 25 Mar 2019 14:15:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="HrFR8unf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726234AbfCYOP1 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 25 Mar 2019 10:15:27 -0400
Received: from a9-99.smtp-out.amazonses.com ([54.240.9.99]:36424 "EHLO
        a9-99.smtp-out.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726182AbfCYOP0 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 25 Mar 2019 10:15:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=6gbrjpgwjskckoa6a5zn6fwqkn67xbtw; d=amazonses.com; t=1553523325;
        h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:MIME-Version:Content-Type:Feedback-ID;
        bh=QxVsvwno82TD/DL3wXtmz3tio2QUfM6l7WxY911mLLw=;
        b=HrFR8unfmFN4rnnt+Hqsx6IMNV5j6Ea/Am8KbVWjJx5WXZ9vC8pAxsdFJsEwsMr8
        IX6ny3v5i4pWq6vZO83gg1U5J8ocP78jveoB25urbgWFuwz8X1ZrdUpqRv3x8XkjIK/
        3zFEhG+E6hEoqvnb3aAcjzbuqhphsuE+dCz+h7hU=
Date:   Mon, 25 Mar 2019 14:15:25 +0000
From:   Christopher Lameter <cl@linux.com>
X-X-Sender: cl@nuc-kabylake
To:     Matthew Wilcox <willy@infradead.org>
cc:     Waiman Long <longman@redhat.com>, Oleg Nesterov <oleg@redhat.com>,
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
In-Reply-To: <20190322195926.GB10344@bombadil.infradead.org>
Message-ID: <01000169b534b9e8-31a2af2c-c396-47f9-8534-4cbd934ef09d-000000@email.amazonses.com>
References: <20190321214512.11524-1-longman@redhat.com> <20190321214512.11524-3-longman@redhat.com> <20190322015208.GD19508@bombadil.infradead.org> <20190322111642.GA28876@redhat.com> <d9e02cc4-3162-57b0-7924-9642aecb8f49@redhat.com>
 <01000169a686689d-bc18fecd-95e1-4b3e-8cd5-dad1b1c570cc-000000@email.amazonses.com> <93523469-48b0-07c8-54fd-300678af3163@redhat.com> <01000169a6ea5e46-f845b8db-730b-436e-980c-3e4273ad2e34-000000@email.amazonses.com>
 <20190322195926.GB10344@bombadil.infradead.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-SES-Outgoing: 2019.03.25-54.240.9.99
Feedback-ID: 1.us-east-1.fQZZZ0Xtj2+TD7V5apTT/NrT6QKuPgzCT/IC7XYgDKI=:AmazonSES
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, 22 Mar 2019, Matthew Wilcox wrote:

> On Fri, Mar 22, 2019 at 07:39:31PM +0000, Christopher Lameter wrote:
> > On Fri, 22 Mar 2019, Waiman Long wrote:
> >
> > > >
> > > >> I am looking forward to it.
> > > > There is also alrady rcu being used in these paths. kfree_rcu() would not
> > > > be enough? It is an estalished mechanism that is mature and well
> > > > understood.
> > > >
> > > In this case, the memory objects are from kmem caches, so they can't
> > > freed using kfree_rcu().
> >
> > Oh they can. kfree() can free memory from any slab cache.
>
> Only for SLAB and SLUB.  SLOB requires that you pass a pointer to the
> slab cache; it has no way to look up the slab cache from the object.

Well then we could either fix SLOB to conform to the others or add a
kmem_cache_free_rcu() variant.

