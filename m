Return-Path: <SRS0=N/SO=R5=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3F8AC43381
	for <selinux@archiver.kernel.org>; Tue, 26 Mar 2019 13:36:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE2202070B
	for <selinux@archiver.kernel.org>; Tue, 26 Mar 2019 13:36:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731749AbfCZNgQ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 26 Mar 2019 09:36:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52700 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731768AbfCZNgO (ORCPT <rfc822;selinux@vger.kernel.org>);
        Tue, 26 Mar 2019 09:36:14 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5E10C308403E;
        Tue, 26 Mar 2019 13:36:13 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.68])
        by smtp.corp.redhat.com (Postfix) with SMTP id 4758A17A88;
        Tue, 26 Mar 2019 13:36:06 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Tue, 26 Mar 2019 14:36:12 +0100 (CET)
Date:   Tue, 26 Mar 2019 14:36:04 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     Christopher Lameter <cl@linux.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Waiman Long <longman@redhat.com>,
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
Message-ID: <20190326133603.GB16837@redhat.com>
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
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Tue, 26 Mar 2019 13:36:14 +0000 (UTC)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 03/25, Christopher Lameter wrote:
>
> On Fri, 22 Mar 2019, Matthew Wilcox wrote:
>
> > Only for SLAB and SLUB.  SLOB requires that you pass a pointer to the
> > slab cache; it has no way to look up the slab cache from the object.
>
> Well then we could either fix SLOB to conform to the others or add a
> kmem_cache_free_rcu() variant.

Speaking of struct sigqueue we can simply use call_rcu() but see my previous
email, I am not sure this is the best option.

Oleg.

