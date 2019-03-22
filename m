Return-Path: <SRS0=WWIK=RZ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EF1CC43381
	for <selinux@archiver.kernel.org>; Fri, 22 Mar 2019 12:56:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6820121873
	for <selinux@archiver.kernel.org>; Fri, 22 Mar 2019 12:56:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732334AbfCVM4H (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:56:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48956 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732465AbfCVLtZ (ORCPT <rfc822;selinux@vger.kernel.org>);
        Fri, 22 Mar 2019 07:49:25 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 758D8A12A7;
        Fri, 22 Mar 2019 11:49:25 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.32])
        by smtp.corp.redhat.com (Postfix) with SMTP id 2DD3417160;
        Fri, 22 Mar 2019 11:49:20 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Fri, 22 Mar 2019 12:49:23 +0100 (CET)
Date:   Fri, 22 Mar 2019 12:49:17 +0100
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
Subject: Re: [PATCH 0/4] Signal: Fix hard lockup problem in flush_sigqueue()
Message-ID: <20190322114917.GC28876@redhat.com>
References: <20190321214512.11524-1-longman@redhat.com>
 <20190322101535.GA10344@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190322101535.GA10344@bombadil.infradead.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Fri, 22 Mar 2019 11:49:25 +0000 (UTC)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 03/22, Matthew Wilcox wrote:
>
> On Thu, Mar 21, 2019 at 05:45:08PM -0400, Waiman Long wrote:
> > It was found that if a process has accumulated sufficient number of
> > pending signals, the exiting of that process may cause its parent to
> > have hard lockup when running on a debug kernel with a slow memory
> > freeing path (like with KASAN enabled).
>
> I appreciate these are "reliable" signals, but why do we accumulate so
> many signals to a task which will never receive them?  Can we detect at
> signal delivery time that the task is going to die and avoid queueing
> them in the first place?

A task can block the signal and accumulate up to RLIMIT_SIGPENDING signals,
then it can exit.

Oleg.

