Return-Path: <SRS0=D1eb=CQ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5FAEC433E2
	for <selinux@archiver.kernel.org>; Mon,  7 Sep 2020 17:18:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5DA5D206B8
	for <selinux@archiver.kernel.org>; Mon,  7 Sep 2020 17:18:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="ru6Dk39v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729892AbgIGRRm (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 7 Sep 2020 13:17:42 -0400
Received: from linux.microsoft.com ([13.77.154.182]:45572 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729760AbgIGODl (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 7 Sep 2020 10:03:41 -0400
Received: from [192.168.0.104] (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id 42027232AD7D;
        Mon,  7 Sep 2020 07:03:28 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 42027232AD7D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1599487408;
        bh=qIyXkjZk1e31gBlXPkKZ9WaWrjjGj8cSt6/WJNx2NIY=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=ru6Dk39vEWFaKHpHHez2mKZ3RgKYRxvfZsWPcmjvrWkmEwlYdmouTAma78ZghkP27
         ixKRrHZ6Gy6dyMugv+b2McgDbpxuDtPTfIbtKUOdob3+qCPXfrUk+NXmTZkHI4JnGq
         xk26M5pLnpjuSbO/ERNaK8tYRiTWME0+OtXarxaQ=
Subject: Re: [RFC PATCH 3/3] selinux: track policy lifetime with refcount
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        rcu@vger.kernel.org, "Paul E . McKenney" <paulmck@kernel.org>
References: <20200825152045.1719298-1-omosnace@redhat.com>
 <20200825152045.1719298-4-omosnace@redhat.com>
 <d82b0a33-6e52-0dda-2f74-cc5b7bdb898a@linux.microsoft.com>
 <CAFqZXNs+eQL7H54BbbeO-Ra4RtQKwQN6gBPAniMmUHmr4RGyBw@mail.gmail.com>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <41bc40c8-e2b5-8535-5d72-ebe66e2ffb5d@linux.microsoft.com>
Date:   Mon, 7 Sep 2020 07:03:23 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAFqZXNs+eQL7H54BbbeO-Ra4RtQKwQN6gBPAniMmUHmr4RGyBw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 9/7/20 12:47 AM, Ondrej Mosnacek wrote:
> On Sat, Sep 5, 2020 at 11:33 PM Lakshmi Ramasubramanian
> <nramas@linux.microsoft.com> wrote:
>> On 8/25/20 8:20 AM, Ondrej Mosnacek wrote:
>>
>> Hi Ondrej,
>>
>> I am just trying understand the expected behavior w.r.t the usage of
>> rcu_dereference_protected() for accessing SELinux policy. Could you
>> please clarify?
>>
>>> Instead of holding the RCU read lock the whole time while accessing the
>>> policy, add a simple refcount mechanism to track its lifetime. After
>>> this, the RCU read lock is held only for a brief time when fetching the
>>> policy pointer and incrementing the refcount. The policy struct is then
>>> guaranteed to stay alive until the refcount is decremented.
>>>
>>> Freeing of the policy remains the responsibility of the task that does
>>> the policy reload. In case the refcount drops to zero in a different
>>> task, the policy load task is notified via a completion.
>>>
>>> The advantage of this change is that the operations that access the
>>> policy can now do sleeping allocations, since they don't need to hold
>>> the RCU read lock anymore. This patch so far only leverages this in
>>> security_read_policy() for the vmalloc_user() allocation (although this
>>> function is always called under fsi->mutex and could just access the
>>> policy pointer directly). The conversion of affected GFP_ATOMIC
>>> allocations to GFP_KERNEL is left for a later patch, since auditing
>>> which code paths may still need GFP_ATOMIC is not very easy.
>>>
>>> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
>>> ---
>>>    security/selinux/ss/services.c | 286 ++++++++++++++++-----------------
>>>    security/selinux/ss/services.h |   6 +
>>>    2 files changed, 147 insertions(+), 145 deletions(-)
>>
>> int security_read_policy(struct selinux_state *state,
>>                           void **data, size_t *len)
>> {
>>          struct selinux_policy *policy;
>>
>>          policy = rcu_dereference_protected(
>>                          state->policy,
>>                           lockdep_is_held(&state->policy_mutex));
>>          if (!policy)
>>                  return -EINVAL;
>> ...
>> }
>>
>> If "policy_mutex" is not held by the caller of security_read_policy() I
>> was expecting the above rcu_dereference_protected() call to return NULL,
> 
> No, that's not how rcu_dereference_protected() works. You should only
> call it when you know for sure that you are in a section that is
> mutually exclusive with anything that might change the pointer. The
> check argument is only used for sanity checking that this is indeed
> true, but other than triggering a warning when RCU debugging is
> enabled the result of the check is ignored.
> 
> If the returned pointer is NULL, it just means that the pointer hasn't
> been assigned yet, i.e. that no policy has been loaded yet (this was
> checked using selinux_initialized() before, but when we're under
> policy_mutex, checking the pointer for NULL is possible and simpler).
> 
> BTW, you should've replied to [1], which is the merged patch that
> introduced the code you are referencing :)

Thanks for clarifying Ondrej.

  -lakshmi

