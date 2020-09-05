Return-Path: <SRS0=e/d8=CO=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A25A5C43461
	for <selinux@archiver.kernel.org>; Sat,  5 Sep 2020 21:33:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71B192073B
	for <selinux@archiver.kernel.org>; Sat,  5 Sep 2020 21:33:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Z6yDMcI2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728505AbgIEVdh (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 5 Sep 2020 17:33:37 -0400
Received: from linux.microsoft.com ([13.77.154.182]:56302 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728449AbgIEVdh (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sat, 5 Sep 2020 17:33:37 -0400
Received: from [192.168.0.104] (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id 034AE2074C44;
        Sat,  5 Sep 2020 14:33:35 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 034AE2074C44
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1599341616;
        bh=H9Vsi/pVwVxCNbRlPgq/caoc0oPkYDr/d6WGCbCoAQE=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Z6yDMcI2kvp/Qg2VKF++Fhh78LM6ErZdtSJX4Z4iSRJ38qXXiP9AetOmjsZATURCn
         iH4gR7ZCzL5499XMJfjHNEgYrpAYS9SJq7Lus5sB8Jcz9HCsNOFA5/vNdaP+SZfsaG
         MjvhFq7r293+AI/qHoeo3QvTxF11cnFMDFCRMIq0=
Subject: Re: [RFC PATCH 3/3] selinux: track policy lifetime with refcount
To:     Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org,
        Paul Moore <paul@paul-moore.com>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        rcu@vger.kernel.org, "Paul E . McKenney" <paulmck@kernel.org>
References: <20200825152045.1719298-1-omosnace@redhat.com>
 <20200825152045.1719298-4-omosnace@redhat.com>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <d82b0a33-6e52-0dda-2f74-cc5b7bdb898a@linux.microsoft.com>
Date:   Sat, 5 Sep 2020 14:33:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200825152045.1719298-4-omosnace@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 8/25/20 8:20 AM, Ondrej Mosnacek wrote:

Hi Ondrej,

I am just trying understand the expected behavior w.r.t the usage of 
rcu_dereference_protected() for accessing SELinux policy. Could you 
please clarify?

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
> ---
>   security/selinux/ss/services.c | 286 ++++++++++++++++-----------------
>   security/selinux/ss/services.h |   6 +
>   2 files changed, 147 insertions(+), 145 deletions(-)

int security_read_policy(struct selinux_state *state,
			 void **data, size_t *len)
{
	struct selinux_policy *policy;

	policy = rcu_dereference_protected(
			state->policy,
                         lockdep_is_held(&state->policy_mutex));
	if (!policy)
		return -EINVAL;
...
}

If "policy_mutex" is not held by the caller of security_read_policy() I 
was expecting the above rcu_dereference_protected() call to return NULL, 
but policy is non-NULL and I see the following messages in "dmesg" log.

Is this expected?

[   78.627152] =============================
[   78.627155] WARNING: suspicious RCU usage
[   78.627159] 5.9.0-rc1+ #10 Not tainted
[   78.627162] -----------------------------
[   78.627166] security/selinux/ss/services.c:3950 suspicious 
rcu_dereference_protected() usage!
[   78.627169]
                other info that might help us debug this:

[   78.627173]
                rcu_scheduler_active = 2, debug_locks = 1
[   78.627177] 1 lock held by bash/2446:
[   78.627179]  #0: ffff939ef5f69448 (sb_writers#7){.+.+}-{0:0}, at: 
vfs_write+0x1b8/0x230
[   78.627199]
                stack backtrace:
[   78.627205] CPU: 10 PID: 2446 Comm: bash Not tainted 5.9.0-rc1+ #10
[   78.627208] Hardware name: LENOVO 30BFS07500/1036, BIOS S03KT33A 
08/06/2019
[   78.627211] Call Trace:
[   78.627222]  dump_stack+0x9f/0xe5
[   78.627231]  lockdep_rcu_suspicious+0xce/0xf0
[   78.627256]  security_read_policy_kernel+0x10a/0x140
[   78.627268]  selinux_measure_state+0x1dc/0x270
[   78.627282]  sel_write_checkreqprot+0x129/0x1a0
[   78.627296]  vfs_write+0xdd/0x230
[   78.627300]  ? sel_read_handle_unknown+0xb0/0xb0
[   78.627304]  ? vfs_write+0xdd/0x230
[   78.627313]  ksys_write+0xad/0xf0
[   78.627324]  __x64_sys_write+0x1a/0x20
[   78.627333]  do_syscall_64+0x37/0x80
[   78.627341]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   78.627346] RIP: 0033:0x7faabb210264
[   78.627351] Code: 89 02 48 c7 c0 ff ff ff ff c3 66 2e 0f 1f 84 00 00 
00 00 00 66 90 48 8d 05 a1 06 2e 00 8b 00 85 c0 75 13 b8 01 00 00 00 0f 
05 <48> 3d 00 f0 ff ff 77 54 f3 c3 66 90 41 54 55 49 89 d4 53 48 89 f5

thanks,
  -lakshmi
