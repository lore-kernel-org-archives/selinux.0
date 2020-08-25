Return-Path: <SRS0=Kf9N=CD=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2C74C433DF
	for <selinux@archiver.kernel.org>; Tue, 25 Aug 2020 18:51:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8CB0920738
	for <selinux@archiver.kernel.org>; Tue, 25 Aug 2020 18:51:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726090AbgHYSvT convert rfc822-to-8bit (ORCPT
        <rfc822;selinux@archiver.kernel.org>);
        Tue, 25 Aug 2020 14:51:19 -0400
Received: from seldsegrel01.sonyericsson.com ([37.139.156.29]:14056 "EHLO
        SELDSEGREL01.sonyericsson.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726066AbgHYSvT (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 25 Aug 2020 14:51:19 -0400
Subject: Re: [RFC PATCH 3/3] selinux: track policy lifetime with refcount
To:     Ondrej Mosnacek <omosnace@redhat.com>, <selinux@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>
CC:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        <rcu@vger.kernel.org>, "Paul E . McKenney" <paulmck@kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20200825152045.1719298-1-omosnace@redhat.com>
 <20200825152045.1719298-4-omosnace@redhat.com>
From:   peter enderborg <peter.enderborg@sony.com>
Message-ID: <748e4541-7608-ae51-bdd1-1356deedb105@sony.com>
Date:   Tue, 25 Aug 2020 20:51:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200825152045.1719298-4-omosnace@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Language: en-GB
X-SEG-SpamProfiler-Analysis: v=2.3 cv=dtal9Go4 c=1 sm=1 tr=0 a=kIrCkORFHx6JeP9rmF/Kww==:117 a=IkcTkHD0fZMA:10 a=y4yBn9ojGxQA:10 a=20KFwNOVAAAA:8 a=L_wMz1sGHkmsje8T-zAA:9 a=QEXdDO2ut3YA:10
X-SEG-SpamProfiler-Score: 0
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 8/25/20 5:20 PM, Ondrej Mosnacek wrote:
> Instead of holding the RCU read lock the whole time while accessing the
> policy, add a simple refcount mechanism to track its lifetime. After
> this, the RCU read lock is held only for a brief time when fetching the
> policy pointer and incrementing the refcount. The policy struct is then
> guaranteed to stay alive until the refcount is decremented.
>
> Freeing of the policy remains the responsibility of the task that does
> the policy reload. In case the refcount drops to zero in a different
> task, the policy load task is notified via a completion.
>
> The advantage of this change is that the operations that access the
> policy can now do sleeping allocations, since they don't need to hold
> the RCU read lock anymore. This patch so far only leverages this in
> security_read_policy() for the vmalloc_user() allocation (although this
> function is always called under fsi->mutex and could just access the
> policy pointer directly). The conversion of affected GFP_ATOMIC
> allocations to GFP_KERNEL is left for a later patch, since auditing
> which code paths may still need GFP_ATOMIC is not very easy.
>
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
>
Very clever. But is it the right prioritization? We get a lot more
cpu synchronization need with two RCU in-out and refcounts inc/dec
instead of only one RCU in-out.  What is the problem with the atomic
allocations? And this if for each syscall, all caches are on the inside?

