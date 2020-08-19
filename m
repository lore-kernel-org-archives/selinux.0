Return-Path: <SRS0=v2nJ=B5=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C403C433DF
	for <selinux@archiver.kernel.org>; Wed, 19 Aug 2020 12:18:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6FD70206FA
	for <selinux@archiver.kernel.org>; Wed, 19 Aug 2020 12:18:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gDn+2/mS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726600AbgHSMSz (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 19 Aug 2020 08:18:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728002AbgHSMSw (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 19 Aug 2020 08:18:52 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6C36C061757
        for <selinux@vger.kernel.org>; Wed, 19 Aug 2020 05:18:51 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id n129so21329981qkd.6
        for <selinux@vger.kernel.org>; Wed, 19 Aug 2020 05:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=t0c86nWgyAAM1Goz5N4oNnbqP49157Mzup/JLgqHpYc=;
        b=gDn+2/mSBIBKkUT45V+NC+kEmh6EeKMJTS41lKNraOTlrFMI9b257SP1dTyczPQ5X1
         hyYnV9YJ/lqUmOYuF3QOacKIR4HQ6uhk/VNigloS4LLLUCbFPZq5t7FpUttwelNB/1LI
         2yUp+ovNMBWzJ5mQ5bVEH8s59kqZLqjj4tEvJqVpyxf26kazsfokIH6Vc6UdBuSDxVvK
         exHa/Fpd8LsRD6AEOQ6klIWoyP/um0K5wNAgoaLCHwbbZVd44Xzn4OX6xTuhLtYrwHAu
         bIiARO40Evr1zXZbZGlC6F659wS96utXKGQWUk5mg+KQcCRe5yLi+OvaUaiHjEwqzCtp
         qn+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=t0c86nWgyAAM1Goz5N4oNnbqP49157Mzup/JLgqHpYc=;
        b=NgCrIcE7VRlJQg1J3SzfjaInNxAJbUYGVBLatGE5MDjOJoB55yIugTiMGaHKyRStHl
         CNkymmeDH+yAfxIa7o3/SleE43r1LETPHmU/5S1nRoYiH7rSV+EkxqiXoiqdrrT+r9gz
         3A7c7jarhxxoC99G/GrnxnmxLOBFvlAW5boOXutT3iGmLZQH7IvV3jI4vLrvCmi0tv/n
         PkNdhsBTqdPyGD1ENjoHYCNabnmCI+P5Mz63pkPnqBpr0zNstqyOcMXpKia8pDQE9qvD
         nS237n4UesEtcUge8k4iFBafDM3VzoIBTzSn9tuwftG2xlGsTaNhidAOW3uN3g7sBEQ/
         ZxNg==
X-Gm-Message-State: AOAM5332mXf53TMt/6+yucV2d81LQ2UPSjMNdmClg7hei/ao+qy/CkU2
        d8LmNmwTwhP3GckJBLHMmdE=
X-Google-Smtp-Source: ABdhPJxxDJOfTPML3etgbyt/WQHq9Qf6Q8z0C6SGXGSjz5xXy9oE0VYEh6d0zlfq08oeyCS08vDGTw==
X-Received: by 2002:a37:a344:: with SMTP id m65mr21313877qke.114.1597839530741;
        Wed, 19 Aug 2020 05:18:50 -0700 (PDT)
Received: from [192.168.1.190] (pool-68-134-6-11.bltmmd.fios.verizon.net. [68.134.6.11])
        by smtp.gmail.com with ESMTPSA id t25sm26246839qtp.22.2020.08.19.05.18.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Aug 2020 05:18:50 -0700 (PDT)
Subject: Re: [RFC PATCH v2] selinux: convert policy read-write lock to RCU
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     Paul Moore <paul@paul-moore.com>,
        SElinux list <selinux@vger.kernel.org>,
        peter.enderborg@sony.com
References: <20200818221718.35655-1-stephen.smalley.work@gmail.com>
 <CAFqZXNtAXmOF30FGn-uD_ORUAWMaDdr6x2NC_scbYjhAbYD5Aw@mail.gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Message-ID: <cb65e1f1-8086-3ac4-077d-11541d40e464@gmail.com>
Date:   Wed, 19 Aug 2020 08:18:48 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAFqZXNtAXmOF30FGn-uD_ORUAWMaDdr6x2NC_scbYjhAbYD5Aw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 8/19/20 4:40 AM, Ondrej Mosnacek wrote:

> A few comments inline after a quick glance...
>
> On Wed, Aug 19, 2020 at 12:17 AM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
>> Convert the policy read-write lock to RCU.  This is significantly
>> simplified by the earlier work to encapsulate the policy data
>> structures and refactor the policy load and boolean setting logic.
>> Move the latest_granting sequence number into the selinux_policy
>> structure so that it can be updated atomically with the policy.
>> Since the removal of the policy rwlock and this move of
>> latest_granting reduces the selinux_ss structure to nothing more than
>> a wrapper around the selinux_policy pointer, get rid of the extra
>> layer of indirection.
>>
>> At present this change merely passes a hardcoded 1 to
>> rcu_dereference_check() in the cases where we know we do not need to
>> take rcu_read_lock(), with the preceding comment explaining why.
>> Alternatively we could pass fsi->mutex down from selinuxfs and
>> apply a lockdep check on it instead.
>>
>> This change does not specifically do anything special with respect
>> to the sidtab live convert; I am unclear as to whether it is safe
>> as a result.  Comments welcome.
>>
>> Based in part on earlier attempts to convert the policy rwlock
>> to RCU by Kaigai Kohei [1] and by Peter Enderborg [2].
>>
>> [1] https://lore.kernel.org/selinux/6e2f9128-e191-ebb3-0e87-74bfccb0767f@tycho.nsa.gov/
>> [2] https://lore.kernel.org/selinux/20180530141104.28569-1-peter.enderborg@sony.com/
>>
>> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
>> ---
>> diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
>> index f6f78c65f53f..ba9347517e5b 100644
>> --- a/security/selinux/ss/services.c
>> +++ b/security/selinux/ss/services.c
> [...]
>
> @@ -722,8 +716,9 @@ static int security_validtrans_handle_fail(struct selinux_state *state,
>                                             struct sidtab_entry *tentry,
>                                             u16 tclass)
>   {
> -       struct policydb *p = &state->ss->policy->policydb;
> -       struct sidtab *sidtab = state->ss->policy->sidtab;
> +       struct selinux_policy *policy = rcu_dereference(state->policy);
> This looks dangerous - you might get a newer policy pointer here than
> the one you dereferenced in security_compute_validatetrans(), which
> wouldn't be good. Instead of double-dereferencing you should always
> pass the struct selinux_policy pointer as an argument to functions
> like this. Please double-check if there are other cases like this, I
> didn't go over the patch in detail yet.
Is that true even though the entire function is called with 
rcu_read_lock() held? In any event, I can fix this for clarity.
> @@ -2174,11 +2206,16 @@ void selinux_policy_commit(struct 
> selinux_state *state,
>>                          pr_info("SELinux: Enabling MLS support...\n");
>>          }
>>
>> +
>> +       /* Set latest granting seqno for new policy. */
>> +       if (oldpolicy)
>> +               newpolicy->latest_granting = oldpolicy->latest_granting + 1;
>> +       else
>> +               newpolicy->latest_granting = 1;
>> +       seqno = newpolicy->latest_granting;
>> +
>>          /* Install the new policy. */
>> -       write_lock_irq(&state->ss->policy_rwlock);
>> -       state->ss->policy = newpolicy;
>> -       seqno = ++state->ss->latest_granting;
>> -       write_unlock_irq(&state->ss->policy_rwlock);
>> +       rcu_assign_pointer(state->policy, newpolicy);
> This is probably a pre-existing thing, but I noticed that there is a
> small window of inconsistency between policy (re)load / bool change
> and AV cache. Between the rcu_assign_pointer() (or the write lock
> section before) and avc_ss_reset(), there might be AVC lookups, which
> in case of cache hit would decide based on the old policy, but in case
> of a miss, they would decide based on the new one. I think it might be
> fixed by moving avc_ss_reset() before rcu_assign_pointer() (but no
> earlier than when it is guaranteed that the policy reload will
> complete successfully).
We can't move the avc_ss_reset() before we have installed the new policy 
or else the AVC will update to the new seqno but possibly still get avd 
entries with the old seqno on security_compute_av() calls.  It is not 
unexpected that the AVC will keep seeing old decisions for a brief 
window; it is just as if they happened before the policy change.  Since 
we aren't providing a higher level synchronization in hooks.c to ensure 
that all permission checks made in a single hook (or at an even higher 
level, in a single system call) are done against the same policy, I 
don't think we gain anything by changing this. In any event, as you say, 
this is pre-existing and thus I don't want to change it as part of this 
patch.
> Anyway, since we need to flush the AVC at each policy reload, it might
> be more logical now to move the AVC under struct selinux_policy as
> well, and avoid the seqno logic altogether. After the RCU conversion,
> accessing a consistent struct selinux_policy becomes really cheap, so
> integrating the AVC should allow for code simplification for (almost)
> zero performance impact. A similar thing could be probably done also
> with the netlabel/xfrm cache (not really familiar with those). Also
> the duplicit policycap array in struct selinux_state could be replaced
> with queries to struct selinux_policy instead (but I have a hunch
> there are some pre-existing logical race conditions around the
> handling of policycaps...).

This might be possible in the kernel but the design was to permit the 
security server and AVC to potentially live in different components / 
address spaces, with the original implementation in a microkernel where 
the security server was a userspace task.  Even now, the security server 
is providing decisions to userspace policy enforcers with their own AVC 
(from libselinux) and therefore still needs a way to synchronize policy 
changes (it sends policyload notifications via netlink with the seqno, 
and /sys/fs/selinux/access provides the seqno for the decision). Some 
improvements are certainly possible here but again I'd make those separate.


