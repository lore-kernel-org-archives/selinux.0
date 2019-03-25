Return-Path: <SRS0=9nT4=R4=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E97CDC43381
	for <selinux@archiver.kernel.org>; Mon, 25 Mar 2019 15:26:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF82A20896
	for <selinux@archiver.kernel.org>; Mon, 25 Mar 2019 15:26:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="IpLumw3U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728983AbfCYP0e (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 25 Mar 2019 11:26:34 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:48084 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726743AbfCYP0e (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 25 Mar 2019 11:26:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=D8ZVArfnFLBcVmlAcDBorEaZjH66v1dusWAAyZwbrQw=; b=IpLumw3UrLhH6QfeKSA8vQdAz
        yTGI0GJFGhrgB77kTlyDPnn1vmjAdz4nLUBoVyTnVbPpH6JVZV0cTxUnBWzuah4Y2enj03N6JEM9E
        LBc2CvIGi1DrS4KTI31rFTtOKpixQafa2pmUTouq9V9uL8SOnXcphOyKFuV9paW7x4O+wLMLlHFU8
        3aoBTt/5WpXWs0qXlIZyjtiEC8Yp9rJDVcXKAHh/qyr4uTgKS+MTn1LOP4U2G5KrxBIGCcxFrK37S
        767Tlo0LOq4V7Lb7S9Yj7B0IDy4t87ymWvxPQ53U8ClZteR6RCav/Ml3K4D6shqcmCKPpNJiSBX4i
        2Yv7HGmqw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h8RUM-0003TH-7G; Mon, 25 Mar 2019 15:26:14 +0000
Date:   Mon, 25 Mar 2019 08:26:14 -0700
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
Message-ID: <20190325152613.GG10344@bombadil.infradead.org>
References: <20190321214512.11524-1-longman@redhat.com>
 <20190321214512.11524-3-longman@redhat.com>
 <20190322015208.GD19508@bombadil.infradead.org>
 <20190322111642.GA28876@redhat.com>
 <d9e02cc4-3162-57b0-7924-9642aecb8f49@redhat.com>
 <01000169a686689d-bc18fecd-95e1-4b3e-8cd5-dad1b1c570cc-000000@email.amazonses.com>
 <93523469-48b0-07c8-54fd-300678af3163@redhat.com>
 <01000169a6ea5e46-f845b8db-730b-436e-980c-3e4273ad2e34-000000@email.amazonses.com>
 <20190322195926.GB10344@bombadil.infradead.org>
 <01000169b534b9e8-31a2af2c-c396-47f9-8534-4cbd934ef09d-000000@email.amazonses.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01000169b534b9e8-31a2af2c-c396-47f9-8534-4cbd934ef09d-000000@email.amazonses.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Mar 25, 2019 at 02:15:25PM +0000, Christopher Lameter wrote:
> On Fri, 22 Mar 2019, Matthew Wilcox wrote:
> 
> > On Fri, Mar 22, 2019 at 07:39:31PM +0000, Christopher Lameter wrote:
> > > On Fri, 22 Mar 2019, Waiman Long wrote:
> > >
> > > > >
> > > > >> I am looking forward to it.
> > > > > There is also alrady rcu being used in these paths. kfree_rcu() would not
> > > > > be enough? It is an estalished mechanism that is mature and well
> > > > > understood.
> > > > >
> > > > In this case, the memory objects are from kmem caches, so they can't
> > > > freed using kfree_rcu().
> > >
> > > Oh they can. kfree() can free memory from any slab cache.
> >
> > Only for SLAB and SLUB.  SLOB requires that you pass a pointer to the
> > slab cache; it has no way to look up the slab cache from the object.
> 
> Well then we could either fix SLOB to conform to the others or add a
> kmem_cache_free_rcu() variant.

The problem with a kmem_cache_free_rcu() variant is that we now have
three pointers to store -- the object pointer, the slab pointer and the
rcu next pointer.

I spent some time looking at how SLOB might be fixed, and I didn't come
up with a good idea.  Currently SLOB stores the size of the object in the
four bytes before the object, unless the object is "allocated from a slab
cache", in which case the size is taken from the cache pointer instead.
So calling kfree() on a pointer allocated using kmem_cache_alloc() will
cause corruption as it attempts to determine the length of the object.

Options:

1. Dispense with this optimisation and always store the size of the
object before the object.

2. Add a kmem_cache flag that says whether objects in this cache may be
freed with kfree().  Only dispense with this optimisation for slabs
with this flag set.

3. Change SLOB to segregate objects by size.  If someone has gone to
the trouble of creating a kmem_cache, this is a pretty good hint that
there will be a lot of objects of this size allocated, so this could
help SLOB fight fragmentation.

Any other bright ideas?
