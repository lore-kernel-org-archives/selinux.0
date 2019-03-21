Return-Path: <SRS0=MVxc=RY=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEE1BC43381
	for <selinux@archiver.kernel.org>; Thu, 21 Mar 2019 21:45:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B8CB21917
	for <selinux@archiver.kernel.org>; Thu, 21 Mar 2019 21:45:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726727AbfCUVph (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 21 Mar 2019 17:45:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50664 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725962AbfCUVph (ORCPT <rfc822;selinux@vger.kernel.org>);
        Thu, 21 Mar 2019 17:45:37 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DA86A59443;
        Thu, 21 Mar 2019 21:45:35 +0000 (UTC)
Received: from llong.com (dhcp-17-47.bos.redhat.com [10.18.17.47])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 845765C8BD;
        Thu, 21 Mar 2019 21:45:27 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Eric Paris <eparis@parisplace.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH 0/4] Signal: Fix hard lockup problem in flush_sigqueue()
Date:   Thu, 21 Mar 2019 17:45:08 -0400
Message-Id: <20190321214512.11524-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Thu, 21 Mar 2019 21:45:36 +0000 (UTC)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

It was found that if a process has accumulated sufficient number of
pending signals, the exiting of that process may cause its parent to
have hard lockup when running on a debug kernel with a slow memory
freeing path (like with KASAN enabled).

  release_task() => flush_sigqueue()

The lockup condition can be reproduced on a large system with a lot of
memory and relatively slow CPUs running LTP's sigqueue_9-1 test on a
debug kernel.

This patchset tries to mitigate this problem by introducing a new kernel
memory freeing queue mechanism modelled after the wake_q mechanism for
waking up tasks. Then flush_sigqueue() and release_task() are modified
to use the freeing queue mechanism to defer the actual memory object
freeing until after releasing the tasklist_lock and with irq re-enabled.

With the patchset applied, the hard lockup problem was no longer
reproducible on the debug kernel.

Waiman Long (4):
  mm: Implement kmem objects freeing queue
  signal: Make flush_sigqueue() use free_q to release memory
  signal: Add free_uid_to_q()
  mm: Do periodic rescheduling when freeing objects in kmem_free_up_q()

 include/linux/sched/user.h |  3 +++
 include/linux/signal.h     |  4 ++-
 include/linux/slab.h       | 28 +++++++++++++++++++++
 kernel/exit.c              | 12 ++++++---
 kernel/signal.c            | 29 +++++++++++++---------
 kernel/user.c              | 17 ++++++++++---
 mm/slab_common.c           | 50 ++++++++++++++++++++++++++++++++++++++
 security/selinux/hooks.c   |  8 ++++--
 8 files changed, 128 insertions(+), 23 deletions(-)

-- 
2.18.1

