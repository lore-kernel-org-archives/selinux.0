Return-Path: <SRS0=Kca8=BP=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F15CAC433E0
	for <selinux@archiver.kernel.org>; Wed,  5 Aug 2020 20:02:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD4362076E
	for <selinux@archiver.kernel.org>; Wed,  5 Aug 2020 20:02:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ElW1kVDb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727990AbgHEUB4 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 5 Aug 2020 16:01:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726958AbgHEQkG (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 5 Aug 2020 12:40:06 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8674C034610
        for <selinux@vger.kernel.org>; Wed,  5 Aug 2020 05:19:20 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id h7so41364992qkk.7
        for <selinux@vger.kernel.org>; Wed, 05 Aug 2020 05:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=ZO7+nyp4YY7ibrCK0MQdSOA+W/eh67jKd5ubJU4pRCg=;
        b=ElW1kVDbQhSPKk2tNR6TCSu34NU5jIAv9RaztXUayFttHPCE+tBCMZK1YFpQrwfztf
         7azfTEy7Wn26YwpwgCziVAk7pjUHKO6J/pNQpjndk0KO9Kth+PWUXt/Z4lGkqIQje/86
         UCApd3kR94jVZM81GtCK1NM/jxAV0X+UjjxfrIuq/VtbEtMx8yLqMV+uRAtgDacIyZym
         zGhLi6MIwJ/1/QZIrfXDaHBJxb7MO4G4r4c80uQ3KIOlpz5ivDWKXtNTm43qD1rKnMoJ
         fhRu3Mx08RlvVGpWmXJgcfa1lNpZ819ILe04XLEoWRQMJ2qouNVHZH74LzH/s3XXzZyU
         kcyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=ZO7+nyp4YY7ibrCK0MQdSOA+W/eh67jKd5ubJU4pRCg=;
        b=qZAM7qcx1rFbdIpcho5TZxssxNo+Zz2EWKUuWlvbejNR1xc5Zm11UXVaVPK5JpXQfD
         luJiHVy5/E1RroUoiyfM+oicARH3UjnC/IZMqog8N4YkRwAcY7lEoqDuZTrnwRabeGeL
         iiOenjYawLIYpZ70XJNEwDSvXapVZDnoTgnD0smEPfDGdLKQrfl3KLECjfur1iuVAcc4
         PzWlIYAd2NGNL5v+HJneq3h8EmE4+cakARDVePkOD9d2aTHX7ficmEm1s+g6AzS3PIQh
         q7uQl5IPl3BTuW4ETaf7PSVCrWvhA9cMUDwmNpR6/fJDkdXyJjKcmrBFy8ku8jJFN2BJ
         skxw==
X-Gm-Message-State: AOAM53212/KIFl3dYtLQvpZWkNH0xO2gIQAE+CVfwvr10OkxxiNoxCI9
        +a3lYiOcAAFACo7iyFWiHVIfoAxlj7g=
X-Google-Smtp-Source: ABdhPJy9ZK70IaeCITbKOBHgSDsLzmOOkqFF90VCajO1SvqN91byIk9VhGMp4AKcuuz8ptuCQFcOiA==
X-Received: by 2002:a37:ad04:: with SMTP id f4mr2856314qkm.302.1596629951491;
        Wed, 05 Aug 2020 05:19:11 -0700 (PDT)
Received: from [192.168.1.190] (pool-96-244-118-111.bltmmd.fios.verizon.net. [96.244.118.111])
        by smtp.gmail.com with ESMTPSA id r188sm1419879qkb.122.2020.08.05.05.19.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Aug 2020 05:19:11 -0700 (PDT)
Subject: Re: [RFC PATCH v3] selinux: encapsulate policy state, refactor policy
 load
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     Paul Moore <paul@paul-moore.com>,
        SElinux list <selinux@vger.kernel.org>
References: <20200803173948.17118-1-stephen.smalley.work@gmail.com>
 <CAFqZXNs5RjGkifBBVZm8zONx5fube4NZe6xFVAtZpuJjEePw+g@mail.gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Message-ID: <b4333d41-de9e-96a7-7ef8-39e14513c370@gmail.com>
Date:   Wed, 5 Aug 2020 08:19:10 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAFqZXNs5RjGkifBBVZm8zONx5fube4NZe6xFVAtZpuJjEePw+g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 8/5/20 4:29 AM, Ondrej Mosnacek wrote:

> On Mon, Aug 3, 2020 at 7:40 PM Stephen Smalley
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
>> v3 fixes a couple of instances where we should take the read-lock for
>> consistency prior to dereferencing state->ss->policy, and updates
>> sidtab_convert() and its helpers/callbacks to use GFP_ATOMIC
>> allocations instead of GFP_KERNEL and to remove a call to
>> cond_resched() since it is now called with the read-lock held and
>> therefore cannot call sleeping functions.  Technically we know that
>> state->ss->policy cannot be modified since selinuxfs is taking
>> fsi->mutex for all policy-modifying operations (both
>> security_load_policy and security_set_bools) but this provides
>> consistency in the handling of the policy rwlock.
> I must say I'm a little concerned about switching to GFP_ATOMIC here.
> The sidtab table can become quite large on long-running systems (since
> it's grow-only currently) and in such case the kernel could have a
> hard time allocating everything atomically. Maybe we could instead
> pass the fsi->mutex's lockdep_map to security_load_policy() and call
> lockdep_is_held() inside as a sanity check? This would document that
> the function is expected to be called in mutual exclusion and also
> detect at runtime if someone accidentally moves the call outside of
> the mutex's critical section. It's not perfect, since a careless
> programmer can still abuse it, but at least the lockdep_map argument
> would warn anyone calling that function (or reviewing a related patch)
> that there is some locking constraint that needs to be respected.
Is that done anywhere else in the kernel currently?  If so, then I have 
no problem with doing so. Otherwise, I'd rather just drop the 
read_lock() here and add a comment explaining why it is currently safe 
without it.
>
> Otherwise the patch looks good to me after a brief look.
>
