Return-Path: <SRS0=WWIK=RZ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B31BEC43381
	for <selinux@archiver.kernel.org>; Fri, 22 Mar 2019 11:16:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 817D0218A2
	for <selinux@archiver.kernel.org>; Fri, 22 Mar 2019 11:16:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727683AbfCVLQv (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:16:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52934 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726667AbfCVLQv (ORCPT <rfc822;selinux@vger.kernel.org>);
        Fri, 22 Mar 2019 07:16:51 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BEC5B3083363;
        Fri, 22 Mar 2019 11:16:50 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.32])
        by smtp.corp.redhat.com (Postfix) with SMTP id 41AA71A914;
        Fri, 22 Mar 2019 11:16:45 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Fri, 22 Mar 2019 12:16:48 +0100 (CET)
Date:   Fri, 22 Mar 2019 12:16:42 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Waiman Long <longman@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
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
Message-ID: <20190322111642.GA28876@redhat.com>
References: <20190321214512.11524-1-longman@redhat.com>
 <20190321214512.11524-3-longman@redhat.com>
 <20190322015208.GD19508@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190322015208.GD19508@bombadil.infradead.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Fri, 22 Mar 2019 11:16:51 +0000 (UTC)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 03/21, Matthew Wilcox wrote:
>
> On Thu, Mar 21, 2019 at 05:45:10PM -0400, Waiman Long wrote:
>
> > To avoid this dire condition and reduce lock hold time of tasklist_lock,
> > flush_sigqueue() is modified to pass in a freeing queue pointer so that
> > the actual freeing of memory objects can be deferred until after the
> > tasklist_lock is released and irq re-enabled.
>
> I think this is a really bad solution.  It looks kind of generic,
> but isn't.  It's terribly inefficient, and all it's really doing is
> deferring the debugging code until we've re-enabled interrupts.

Agreed.

> We'd be much better off just having a list_head in the caller
> and list_splice() the queue->list onto that caller.  Then call
> __sigqueue_free() for each signal on the queue.

This won't work, note the comment which explains the race with sigqueue_free().

Let me think about it... at least we can do something like

	close_the_race_with_sigqueue_free(struct sigpending *queue)
	{
		struct sigqueue *q, *t;

		list_for_each_entry_safe(q, t, ...) {
			if (q->flags & SIGQUEUE_PREALLOC)
				list_del_init(&q->list);
	}

called with ->siglock held, tasklist_lock is not needed.

After that flush_sigqueue() can be called lockless in release_task() release_task.

I'll try to make the patch tomorrow.

Oleg.

