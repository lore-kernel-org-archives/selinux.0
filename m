Return-Path: <SRS0=FvZo=BW=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F3C1C433E1
	for <selinux@archiver.kernel.org>; Wed, 12 Aug 2020 07:15:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 760DB20768
	for <selinux@archiver.kernel.org>; Wed, 12 Aug 2020 07:15:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726673AbgHLHPW (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 12 Aug 2020 03:15:22 -0400
Received: from seldsegrel01.sonyericsson.com ([37.139.156.29]:16741 "EHLO
        SELDSEGREL01.sonyericsson.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726255AbgHLHPV (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 12 Aug 2020 03:15:21 -0400
Subject: Re: [RFC PATCH v4 1/2] selinux: encapsulate policy state, refactor
 policy load
To:     Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>
CC:     Ondrej Mosnacek <omosnace@redhat.com>, <selinux@vger.kernel.org>,
        <dburgener@linux.microsoft.com>
References: <20200805155240.26473-1-stephen.smalley.work@gmail.com>
 <CAHC9VhTmXnHMGd8sD7343ANYkZD3RR_Tz=D2a2V8H9coOpvDNg@mail.gmail.com>
From:   peter enderborg <peter.enderborg@sony.com>
Message-ID: <df752d3b-f538-965e-0bf2-b036bd4a7393@sony.com>
Date:   Wed, 12 Aug 2020 09:15:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAHC9VhTmXnHMGd8sD7343ANYkZD3RR_Tz=D2a2V8H9coOpvDNg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
X-SEG-SpamProfiler-Analysis: v=2.3 cv=frmim2wf c=1 sm=1 tr=0 a=kIrCkORFHx6JeP9rmF/Kww==:117 a=IkcTkHD0fZMA:10 a=y4yBn9ojGxQA:10 a=pGLkceISAAAA:8 a=tineZ3jrEsuOGFh_hIAA:9 a=rhBUSfRS5AhQlVL0:21 a=InZRV-5gbhoBjiud:21 a=QEXdDO2ut3YA:10
X-SEG-SpamProfiler-Score: 0
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 8/7/20 5:41 AM, Paul Moore wrote:
> On Wed, Aug 5, 2020 at 11:52 AM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
>> Encapsulate the policy state in its own structure (struct
>> selinux_policy) that is separately allocated but referenced from the
>> selinux_ss structure.  The policy state includes the SID table
>> (particularly the context structures), the policy database, and the
>> mapping between the kernel classes/permissions and the policy values.
>> Refactor the security server portion of the policy load logic to
>> cleanly separate loading of the new structures from committing the new
>> policy.  Unify the initial policy load and reload code paths as much
>> as possible, avoiding duplicated code.  Make sure we are taking the
>> policy read-lock prior to any dereferencing of the policy.  Move the
>> copying of the policy capability booleans into the state structure
>> outside of the policy write-lock because they are separate from the
>> policy and are read outside of any policy lock; possibly they should
>> be using at least READ_ONCE/WRITE_ONCE or smp_load_acquire/store_release.
>> Restore the load mutex that was previously removed by
>> commit 89abd0acf033 ("SELinux: drop load_mutex in security_load_policy")
>> to make explicit the exclusion even though it is currently redundant
>> with the fsi->mutex held by selinuxfs; this makes clear that we do
>> not need to take the policy read-lock across sidtab_convert() and will
>> be useful in the future for lockdep checking.
>>
>> These changes simplify the policy loading logic, reduce the size of
>> the critical section while holding the policy write-lock, and should
>> facilitate future changes to e.g. refactor the entire policy reload
>> logic including the selinuxfs code to make the updating of the policy
>> and the selinuxfs directory tree atomic and/or to convert the policy
>> read-write lock to RCU.
>>
>> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
>> ---
>> v4 does not take the policy read-lock across sidtab_convert() and
>> therefore does not require changing allocations by it to be atomic
>> or dropping the cond_resched() call.  To make obvious that taking
>> the policy read-lock is not necessary in security_load_policy(), restore
>> the load mutex to security_load_policy() that was removed back in
>> commit 89abd0acf033 ("SELinux: drop load_mutex in security_load_policy").
>> However, since we have refactored security_load_policy() in this change
>> to split out selinux_policy_commit(), we need to take the mutex in
>> security_load_policy() and release it in selinux_policy_commit().
> I'm not in love with the idea of splitting the lock/unlock across
> different functions, more below in the relevant code section.
>
>>  security/selinux/ss/services.c | 403 +++++++++++++++++----------------
>>  security/selinux/ss/services.h |  11 +-
>>  2 files changed, 220 insertions(+), 194 deletions(-)
> ...
>
>
>> diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
>> index 9e76a80db6e1..6dea93fac9e2 100644
>> --- a/security/selinux/ss/services.c
>> +++ b/security/selinux/ss/services.c
>> @@ -2115,11 +2126,73 @@ static void security_load_policycaps(struct selinux_state *state)
>>                         pr_info("SELinux:  unknown policy capability %u\n",
>>                                 i);
>>         }
>> +
>> +       read_unlock(&state->ss->policy_rwlock);
>>  }
>>
>>  static int security_preserve_bools(struct selinux_state *state,
>>                                    struct policydb *newpolicydb);
>>
>> +static void selinux_policy_free(struct selinux_policy *policy)
>> +{
>> +       if (!policy)
>> +               return;
>> +
>> +       policydb_destroy(&policy->policydb);
>> +       sidtab_destroy(&policy->sidtab);
>> +       kfree(policy->map.mapping);
>> +       kfree(policy);
>> +}
>> +
>> +static void selinux_policy_commit(struct selinux_state *state,
>> +                               struct selinux_policy *newpolicy)
>> +{
>> +       struct selinux_policy *oldpolicy;
>> +       u32 seqno;
>> +
>> +       lockdep_assert_held(&state->ss->load_mutex);
>> +
>> +       /* If switching between different policy types, log MLS status */
>> +       oldpolicy = state->ss->policy;
>> +       if (oldpolicy) {
>> +               if (oldpolicy->policydb.mls_enabled && !newpolicy->policydb.mls_enabled)
>> +                       pr_info("SELinux: Disabling MLS support...\n");
>> +               else if (!oldpolicy->policydb.mls_enabled && newpolicy->policydb.mls_enabled)
>> +                       pr_info("SELinux: Enabling MLS support...\n");
>> +       }
>> +
>> +       /* Install the new policy. */
>> +       write_lock_irq(&state->ss->policy_rwlock);
>> +       state->ss->policy = newpolicy;
>> +       seqno = ++state->ss->latest_granting;
>> +       write_unlock_irq(&state->ss->policy_rwlock);
>> +
>> +       /* Load the policycaps from the new policy */
>> +       security_load_policycaps(state);
>> +
>> +       if (!selinux_initialized(state)) {
>> +               /*
>> +                * After first policy load, the security server is
>> +                * marked as initialized and ready to handle requests and
>> +                * any objects created prior to policy load are then labeled.
>> +                */
>> +               selinux_mark_initialized(state);
>> +               mutex_unlock(&state->ss->load_mutex);
>> +               selinux_complete_init();
>> +       } else
>> +               mutex_unlock(&state->ss->load_mutex);
>> +
>> +       /* Free the old policy */
>> +       selinux_policy_free(oldpolicy);
>> +
>> +       /* Flush external caches and notify userspace of policy load */
>> +       avc_ss_reset(state->avc, seqno);
>> +       selnl_notify_policyload(seqno);
>> +       selinux_status_update_policyload(state, seqno);
>> +       selinux_netlbl_cache_invalidate();
>> +       selinux_xfrm_notify_policyload();
>> +}
> I can somewhat understand if you don't want to have all the old policy
> cleanup, reset, and notify code in security_load_policy(), but I
> really dislike that the mutex lock/unlock is split across the two
> functions.
>
> What if selinux_policy_commit() returned oldpolicy on success and we
> created a new function, selinux_policy_retire() (name?), that would be
> called from security_load_policy and could handle the cleanup, reset,
> and notify code.  The mutex unlock could happen between the calls to
> selinux_policy_commit() and selinux_policy_retire()?
>
> I'm open to other ideas as well.
>
Something similar to that will most likely be needed for a move to rcu lock anyway.


