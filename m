Return-Path: <SRS0=MVxc=RY=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DFADC43381
	for <selinux@archiver.kernel.org>; Thu, 21 Mar 2019 22:01:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9F02218D4
	for <selinux@archiver.kernel.org>; Thu, 21 Mar 2019 22:01:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pSWHajQs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727422AbfCUWAu (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 21 Mar 2019 18:00:50 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:37608 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727246AbfCUWAu (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 21 Mar 2019 18:00:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=JVdztBDJcSey0QI9UZ8uSOMuJf9GvmkjJ47WwH+ajqs=; b=pSWHajQsPC7Dnpe2r+iQ7C2or
        UFxfv/su+iL/pKAP1gL41nDsBFsAb+DZM7b3AC8jaWN1Nbr6zTLE4rlY7vXWA6ShCSc+lKp24ZqUG
        qhRw/NfaVJZq1G/CZ36bCkP/M+xVdDArAkWcgTFPjD32YIh0KrgZKLFiUJQHkaz2C83VSRMMOm2GV
        D2jvftVr170zAbhGkv4lfpzXvHNnGDd0q40AKVeo7vgk2svIcocNRSlzTKx1GjXiti2EhTXA7ASG4
        6fLbS8rQB6J+iUyMkw9PqSK7xGSs6ue2cucX/lcfS8l9qu+ffGrvUpFoYiWLToHMAzHZhgA5KgGNU
        6C1Eh4s7w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h75jr-0001Fe-Im; Thu, 21 Mar 2019 22:00:40 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 737E7984EEA; Thu, 21 Mar 2019 23:00:35 +0100 (CET)
Date:   Thu, 21 Mar 2019 23:00:35 +0100
From:   Peter Zijlstra <peterz@infradead.org>
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
        Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH 4/4] mm: Do periodic rescheduling when freeing objects in
 kmem_free_up_q()
Message-ID: <20190321220035.GF7905@worktop.programming.kicks-ass.net>
References: <20190321214512.11524-1-longman@redhat.com>
 <20190321214512.11524-5-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190321214512.11524-5-longman@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Mar 21, 2019 at 05:45:12PM -0400, Waiman Long wrote:
> If the freeing queue has many objects, freeing all of them consecutively
> may cause soft lockup especially on a debug kernel. So kmem_free_up_q()
> is modified to call cond_resched() if running in the process context.
> 
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>  mm/slab_common.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index dba20b4208f1..633a1d0f6d20 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -1622,11 +1622,14 @@ EXPORT_SYMBOL_GPL(kmem_free_q_add);
>   * kmem_free_up_q - free all the objects in the freeing queue
>   * @head: freeing queue head
>   *
> - * Free all the objects in the freeing queue.
> + * Free all the objects in the freeing queue. The caller cannot hold any
> + * non-sleeping locks.
>   */
>  void kmem_free_up_q(struct kmem_free_q_head *head)
>  {
>  	struct kmem_free_q_node *node, *next;
> +	bool do_resched = !in_irq();
> +	int cnt = 0;
>  
>  	for (node = head->first; node; node = next) {
>  		next = node->next;
> @@ -1634,6 +1637,12 @@ void kmem_free_up_q(struct kmem_free_q_head *head)
>  			kmem_cache_free(node->cachep, node);
>  		else
>  			kfree(node);
> +		/*
> +		 * Call cond_resched() every 256 objects freed when in
> +		 * process context.
> +		 */
> +		if (do_resched && !(++cnt & 0xff))
> +			cond_resched();

Why not just: cond_resched() ?

>  	}
>  }
>  EXPORT_SYMBOL_GPL(kmem_free_up_q);
> -- 
> 2.18.1
> 
