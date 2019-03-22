Return-Path: <SRS0=WWIK=RZ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12FA6C43381
	for <selinux@archiver.kernel.org>; Fri, 22 Mar 2019 17:47:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8C97206BA
	for <selinux@archiver.kernel.org>; Fri, 22 Mar 2019 17:47:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="C9e2KlVV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728217AbfCVRrT (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 22 Mar 2019 13:47:19 -0400
Received: from a9-34.smtp-out.amazonses.com ([54.240.9.34]:41658 "EHLO
        a9-34.smtp-out.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727871AbfCVRrT (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 22 Mar 2019 13:47:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=6gbrjpgwjskckoa6a5zn6fwqkn67xbtw; d=amazonses.com; t=1553276838;
        h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:MIME-Version:Content-Type:Feedback-ID;
        bh=rFwzn/BBO25AP0s77MXmb0hXGtOvd/fOwhwfuRoZrBw=;
        b=C9e2KlVV2mDdwR48uPojXdogeRsWVjBuGjnXSR99D/1/hWBT97akhkkrahqu9rfV
        nN5akCDSy2A3KAjstu1nDudPH1zBtFR02pVvL1AikDrtcJvXvztaWo8qYvkiIriJfTL
        NBMJ+uk3vWOjFYWC7WnzRVoNt+tbkkEx+reCBk/c=
Date:   Fri, 22 Mar 2019 17:47:18 +0000
From:   Christopher Lameter <cl@linux.com>
X-X-Sender: cl@nuc-kabylake
To:     Waiman Long <longman@redhat.com>
cc:     Andrew Morton <akpm@linux-foundation.org>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Eric Paris <eparis@parisplace.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH 1/4] mm: Implement kmem objects freeing queue
In-Reply-To: <20190321214512.11524-2-longman@redhat.com>
Message-ID: <01000169a683a0ed-3fa1b014-8efa-4c8f-a7e1-958e9eccd693-000000@email.amazonses.com>
References: <20190321214512.11524-1-longman@redhat.com> <20190321214512.11524-2-longman@redhat.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-SES-Outgoing: 2019.03.22-54.240.9.34
Feedback-ID: 1.us-east-1.fQZZZ0Xtj2+TD7V5apTT/NrT6QKuPgzCT/IC7XYgDKI=:AmazonSES
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, 21 Mar 2019, Waiman Long wrote:

> When releasing kernel data structures, freeing up the memory
> occupied by those objects is usually the last step. To avoid races,
> the release operation is commonly done with a lock held. However, the
> freeing operations do not need to be under lock, but are in many cases.
>
> In some complex cases where the locks protect many different memory
> objects, that can be a problem especially if some memory debugging
> features like KASAN are enabled. In those cases, freeing memory objects
> under lock can greatly lengthen the lock hold time. This can even lead
> to soft/hard lockups in some extreme cases.
>
> To make it easer to defer freeing memory objects until after unlock,
> a kernel memory freeing queue mechanism is now added. It is modelled
> after the wake_q mechanism for waking up tasks without holding a lock.

It is already pretty easy. You just store the pointer to the slab object
in a local variable, finish all the unlocks and then free the objects.
This is done in numerous places of the kernel.

I fear that the automated mechanism will make the code more difficult to
read and result in a loss of clarity of the sequencing of events in
releasing locks and objects.

Also there is already kfree_rcu which does a similar thing to what you are
proposing here and is used in numerous places.

