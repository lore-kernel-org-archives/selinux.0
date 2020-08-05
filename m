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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D17E0C433DF
	for <selinux@archiver.kernel.org>; Wed,  5 Aug 2020 19:55:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD7AA2076E
	for <selinux@archiver.kernel.org>; Wed,  5 Aug 2020 19:55:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pxeq+0ZK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726248AbgHETzi (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 5 Aug 2020 15:55:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728040AbgHEQqQ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 5 Aug 2020 12:46:16 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9D1BC0A8883
        for <selinux@vger.kernel.org>; Wed,  5 Aug 2020 06:38:37 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id j10so14020488qvo.13
        for <selinux@vger.kernel.org>; Wed, 05 Aug 2020 06:38:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=xUz8oVL+ldPQ3qlmnh/inFEZEfZCbXPm4EO9EFeWgUU=;
        b=pxeq+0ZKoUczUfNhXt/SafH9bYLDttzn6Vao/ve047cGz9VdJKPlaYuunZZNtinoaX
         kjufK7p1fijmQEzhtIrhJETzhT7Np+t/cnV550k33Tk5GviunZZ/RPRGAIJwmvcxlOAK
         ONm1jmDVqKm3qBsn+mWbt18Mlfe6BHHvit4jsHcNJ+PKhch+9U91E4RfQkiiBF96/TKq
         Wc9Zce/khsQQmKPjRiyZ7kyadhfKdwxTExcUufKWyPInoT5Z3depAUCmgG3sCPJyHQ0v
         Mod0Wd6Mdn+xHLckhXeDDkBhZAUn74G0ZeszihbT6uTBacPNffRPmo/zAwIakgNTaGo/
         6wZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=xUz8oVL+ldPQ3qlmnh/inFEZEfZCbXPm4EO9EFeWgUU=;
        b=k5JdFRnXyEb2DwTm3MB9z8Yq4TkXh+ZI4SFLohS54YPZOzEAxd+MT1tOSq1SPw+w3j
         Di5x28MDgzKzyE9MeSPSnzn9A/iAyxOVfMjhhEjwfwGlIn8EkaKRucWdw8CsZyMEKNll
         +dsuHQvRjnU5pjXbNIYlvIqYXioePwlMjBjboYMXT2Ff6gsNNrlNYF7i+9IPMBGYK02W
         NTmGUfRZutYVwYGoKE8iJjscvB1aFxNXKb3Yz1PiBcoZt+SredAGXx+63XQ4Jw+bE3fc
         wgOZhN2j+BdlF+CFAYDQaL4Y1vNL1N+veT3fXe5F6hfg6ouQdtHOZUfzEmaL4dQBIUPH
         FwgQ==
X-Gm-Message-State: AOAM530rcSfxGDZOpHmiK+YG3oiK/ifuERASWh+JnQ2/1KgpWMgCodRz
        TPPc3tlcRQ7JDC06qhmonAVFx8GcbtE=
X-Google-Smtp-Source: ABdhPJwRkE/NVgfZRThdY50HYK+64ilBAdVZuCqlUmywhpP0+ctfCQuVho05nNQKQX9bWQgeprAa9w==
X-Received: by 2002:a0c:ff02:: with SMTP id w2mr3627802qvt.206.1596634711165;
        Wed, 05 Aug 2020 06:38:31 -0700 (PDT)
Received: from [192.168.1.190] (pool-96-244-118-111.bltmmd.fios.verizon.net. [96.244.118.111])
        by smtp.gmail.com with ESMTPSA id n33sm1724950qtd.43.2020.08.05.06.38.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Aug 2020 06:38:30 -0700 (PDT)
Subject: Re: [RFC PATCH v3] selinux: encapsulate policy state, refactor policy
 load
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     Paul Moore <paul@paul-moore.com>,
        SElinux list <selinux@vger.kernel.org>
References: <20200803173948.17118-1-stephen.smalley.work@gmail.com>
 <CAFqZXNs5RjGkifBBVZm8zONx5fube4NZe6xFVAtZpuJjEePw+g@mail.gmail.com>
 <b4333d41-de9e-96a7-7ef8-39e14513c370@gmail.com>
 <CAFqZXNuM2ZXQj+b33aFCQxAN447MOqzkSEGyYT5rWgkMqtOv=A@mail.gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Message-ID: <e8ae8a41-22ed-9566-9d11-fe5dce0e1301@gmail.com>
Date:   Wed, 5 Aug 2020 09:38:29 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAFqZXNuM2ZXQj+b33aFCQxAN447MOqzkSEGyYT5rWgkMqtOv=A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 8/5/20 9:27 AM, Ondrej Mosnacek wrote:

> On Wed, Aug 5, 2020 at 2:19 PM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
>> On 8/5/20 4:29 AM, Ondrej Mosnacek wrote:
>>
>>> On Mon, Aug 3, 2020 at 7:40 PM Stephen Smalley
>>> <stephen.smalley.work@gmail.com> wrote:
>>>> Encapsulate the policy state in its own structure (struct
>>>> selinux_policy) that is separately allocated but referenced from the
>>>> selinux_ss structure.  The policy state includes the SID table
>>>> (particularly the context structures), the policy database, and the
>>>> mapping between the kernel classes/permissions and the policy values.
>>>> Refactor the security server portion of the policy load logic to
>>>> cleanly separate loading of the new structures from committing the new
>>>> policy.  Unify the initial policy load and reload code paths as much
>>>> as possible, avoiding duplicated code.  Make sure we are taking the
>>>> policy read-lock prior to any dereferencing of the policy.  Move the
>>>> copying of the policy capability booleans into the state structure
>>>> outside of the policy write-lock because they are separate from the
>>>> policy and are read outside of any policy lock; possibly they should
>>>> be using at least READ_ONCE/WRITE_ONCE or smp_load_acquire/store_release.
>>>>
>>>> These changes simplify the policy loading logic, reduce the size of
>>>> the critical section while holding the policy write-lock, and should
>>>> facilitate future changes to e.g. refactor the entire policy reload
>>>> logic including the selinuxfs code to make the updating of the policy
>>>> and the selinuxfs directory tree atomic and/or to convert the policy
>>>> read-write lock to RCU.
>>>>
>>>> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
>>>> ---
>>>> v3 fixes a couple of instances where we should take the read-lock for
>>>> consistency prior to dereferencing state->ss->policy, and updates
>>>> sidtab_convert() and its helpers/callbacks to use GFP_ATOMIC
>>>> allocations instead of GFP_KERNEL and to remove a call to
>>>> cond_resched() since it is now called with the read-lock held and
>>>> therefore cannot call sleeping functions.  Technically we know that
>>>> state->ss->policy cannot be modified since selinuxfs is taking
>>>> fsi->mutex for all policy-modifying operations (both
>>>> security_load_policy and security_set_bools) but this provides
>>>> consistency in the handling of the policy rwlock.
>>> I must say I'm a little concerned about switching to GFP_ATOMIC here.
>>> The sidtab table can become quite large on long-running systems (since
>>> it's grow-only currently) and in such case the kernel could have a
>>> hard time allocating everything atomically. Maybe we could instead
>>> pass the fsi->mutex's lockdep_map to security_load_policy() and call
>>> lockdep_is_held() inside as a sanity check? This would document that
>>> the function is expected to be called in mutual exclusion and also
>>> detect at runtime if someone accidentally moves the call outside of
>>> the mutex's critical section. It's not perfect, since a careless
>>> programmer can still abuse it, but at least the lockdep_map argument
>>> would warn anyone calling that function (or reviewing a related patch)
>>> that there is some locking constraint that needs to be respected.
>> Is that done anywhere else in the kernel currently?  If so, then I have
>> no problem with doing so. Otherwise, I'd rather just drop the
>> read_lock() here and add a comment explaining why it is currently safe
>> without it.
> I guess the closest thing is the "c" argument of
> rcu_dereference_protected(), which should be passed a
> lock[dep]_is_held() check on the lock/mutex that provides the mutual
> exclusion that is needed for the operation to be safe. If we ever do
> conver the rwlock to RCU, we will need something to pass to
> rcu_dereference_protected() anyway. (I mean we could cheat and just
> pass 1 + a comment, but it would be nicer to put an actual
> lock[dep]_held() check there.)
>
> But it just occurred to me that we could make it even more explicit by
> simply adding another "policy_load" mutex to security_ss and do most
> of security_load_policy() with that mutex locked. Since there will
> never be any contention on it, the extra overhead should be
> negligible.

I like that better.  In fact, we used to have that prior to:

commit 89abd0acf0335f3f760a3c0698d43bb1eaa83e44
Author: Eric Paris <eparis@redhat.com>
Date:   Mon Jun 9 15:58:04 2008 -0400

     SELinux: drop load_mutex in security_load_policy

     We used to protect against races of policy load in security_load_policy
     by using the load_mutex.  Since then we have added a new mutex,
     sel_mutex, in sel_write_load() which is always held across all calls to
     security_load_policy we are covered and can safely just drop this one.

