Return-Path: <SRS0=v2nJ=B5=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0C12C433E1
	for <selinux@archiver.kernel.org>; Wed, 19 Aug 2020 15:05:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83ED620888
	for <selinux@archiver.kernel.org>; Wed, 19 Aug 2020 15:05:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728610AbgHSPFq convert rfc822-to-8bit (ORCPT
        <rfc822;selinux@archiver.kernel.org>);
        Wed, 19 Aug 2020 11:05:46 -0400
Received: from seldsegrel01.sonyericsson.com ([37.139.156.29]:18544 "EHLO
        SELDSEGREL01.sonyericsson.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728700AbgHSPFk (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 19 Aug 2020 11:05:40 -0400
Subject: Re: [RFC PATCH] selinux: Use call_rcu for policydb and booleans
To:     <paulmck@kernel.org>,
        Stephen Smalley <stephen.smalley.work@gmail.com>
CC:     <paul@paul-moore.com>, <omosnace@redhat.com>,
        <selinux@vger.kernel.org>
References: <20200818221718.35655-1-stephen.smalley.work@gmail.com>
 <e9c1967d-170f-86f0-2762-7ca36ea08e40@sony.com>
 <7fe5f8e9-1fd9-2a65-4117-5b0d35c3973e@gmail.com>
 <20200819131511.GS27891@paulmck-ThinkPad-P72>
From:   peter enderborg <peter.enderborg@sony.com>
Message-ID: <15a4ba37-e5ac-6247-814b-d86c4c3c85eb@sony.com>
Date:   Wed, 19 Aug 2020 17:05:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200819131511.GS27891@paulmck-ThinkPad-P72>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Language: en-GB
X-SEG-SpamProfiler-Analysis: v=2.3 cv=frmim2wf c=1 sm=1 tr=0 a=Jtaq2Av1iV2Yg7i8w6AGMw==:117 a=IkcTkHD0fZMA:10 a=y4yBn9ojGxQA:10 a=z6gsHLkEAAAA:8 a=0OuJUApU1U2SYywe4NQA:9 a=QEXdDO2ut3YA:10 a=d-OLMTCWyvARjPbQ-enb:22
X-SEG-SpamProfiler-Score: 0
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 8/19/20 3:15 PM, Paul E. McKenney wrote:
> On Wed, Aug 19, 2020 at 08:06:25AM -0400, Stephen Smalley wrote:
>> On 8/19/20 4:32 AM, peter enderborg wrote:
>>
>>>  From 8184ea3648b18718fdb460a30dfc7f848b7bc6a2 Mon Sep 17 00:00:00 2001
>>> From: Peter Enderborg <peter.enderborg@sony.com>
>>> Date: Wed, 19 Aug 2020 10:20:28 +0200
>>> Subject: [RFC PATCH] selinux: Use call_rcu for policydb and booleans
>>>
>>> This patch adds call_rcu that moves sycronize out
>>> out call path. In the callback we can no call
>>> cond_resched so they have to be remvoed.
>> If you look at the first version of my patch, I used call_rcu() but in a
>> manner that avoided the need to remove cond_resched() or kvfree() calls from
>> the freeing code by having the rcu callback just schedule_work() to free it
>> later.  That follows the pattern used for freeing user namespaces, for
>> example.  However, in re-reading the RCU documentation, my understanding is
>> that one should use synchronize_rcu() followed by direct freeing whenever
>> possible and this is possible from both the policy load and setting
>> booleans.  Neither of them are very frequent operations nor so
>> performance-critical that the cost of synchronize_rcu() would be considered
>> unacceptable IMHO.  Thus, I don't believe we need to do this.
> Indeed, synchronize_rcu() avoids things like callback flooding.
> There are nevertheless cases where synchronize_rcu() can be a problem,
> for example due to its relatively long latency (milliseconds at best).
> But if this is an infrequent operation, that should not be an issue.
>
> If there nevertheless is a reason to avoid synchronize_rcu(), then
> queue_rcu_work() gets you directly to a sleepable workqueue context
> where cond_resched() can be used.
>
> 							Thnax, Paul

From what I have seen in usage of booleans the usage is

switch-state, do-something, switch-back. So if there is anything
security related you want switch time to be fast. But when I measured
it was faster with synchronize_rcu than call_rcu.  booleans  work are
smaller than a total policy load.

