Return-Path: <SRS0=v2nJ=B5=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C4E5C433DF
	for <selinux@archiver.kernel.org>; Wed, 19 Aug 2020 14:32:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20FEC2078D
	for <selinux@archiver.kernel.org>; Wed, 19 Aug 2020 14:32:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727003AbgHSOcq convert rfc822-to-8bit (ORCPT
        <rfc822;selinux@archiver.kernel.org>);
        Wed, 19 Aug 2020 10:32:46 -0400
Received: from seldsegrel01.sonyericsson.com ([37.139.156.29]:17953 "EHLO
        SELDSEGREL01.sonyericsson.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727000AbgHSOcn (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 19 Aug 2020 10:32:43 -0400
Subject: Re: [RFC PATCH] selinux: Use call_rcu for policydb and booleans
To:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        <paul@paul-moore.com>, "Paul E. McKenney" <paulmck@kernel.org>
CC:     <omosnace@redhat.com>, <selinux@vger.kernel.org>
References: <20200818221718.35655-1-stephen.smalley.work@gmail.com>
 <e9c1967d-170f-86f0-2762-7ca36ea08e40@sony.com>
 <7fe5f8e9-1fd9-2a65-4117-5b0d35c3973e@gmail.com>
From:   peter enderborg <peter.enderborg@sony.com>
Message-ID: <8acc00da-e337-9d2d-ea7c-f4f62f7acae8@sony.com>
Date:   Wed, 19 Aug 2020 16:32:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <7fe5f8e9-1fd9-2a65-4117-5b0d35c3973e@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Language: en-GB
X-SEG-SpamProfiler-Analysis: v=2.3 cv=frmim2wf c=1 sm=1 tr=0 a=Jtaq2Av1iV2Yg7i8w6AGMw==:117 a=IkcTkHD0fZMA:10 a=y4yBn9ojGxQA:10 a=z6gsHLkEAAAA:8 a=xd5sBpXtjmSQRx5lkpsA:9 a=QEXdDO2ut3YA:10 a=d-OLMTCWyvARjPbQ-enb:22
X-SEG-SpamProfiler-Score: 0
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 8/19/20 2:06 PM, Stephen Smalley wrote:
> On 8/19/20 4:32 AM, peter enderborg wrote:
>
>>  From 8184ea3648b18718fdb460a30dfc7f848b7bc6a2 Mon Sep 17 00:00:00 2001
>> From: Peter Enderborg <peter.enderborg@sony.com>
>> Date: Wed, 19 Aug 2020 10:20:28 +0200
>> Subject: [RFC PATCH] selinux: Use call_rcu for policydb and booleans
>>
>> This patch adds call_rcu that moves sycronize out
>> out call path. In the callback we can no call
>> cond_resched so they have to be remvoed.
>
> If you look at the first version of my patch, I used call_rcu() but in a manner that avoided the need to remove cond_resched() or kvfree() calls from the freeing code by having the rcu callback just schedule_work() to free it later.  That follows the pattern used for freeing user namespaces, for example.  However, in re-reading the RCU documentation, my understanding is that one should use synchronize_rcu() followed by direct freeing whenever possible and this is possible from both the policy load and setting booleans.  Neither of them are very frequent operations nor so performance-critical that the cost of synchronize_rcu() would be considered unacceptable IMHO.  Thus, I don't believe we need to do this.
>
>
Loading policydb should be very rare, and it takes for ever anyway. Booleans I have no idea. It seems to something that turns on-off quickly and there are many of them
so it will be hard to say. However I did a test. Before rcu a boolean cycle is (on my test rig) 15ms, with call_rcu 14ms and with synchronize_rcu 10ms.  Not what I expected.

And there are rcu versions for the kvfree if needed.



