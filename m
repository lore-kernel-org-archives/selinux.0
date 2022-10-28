Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74314C38A02
	for <selinux@archiver.kernel.org>; Fri, 28 Oct 2022 13:58:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbiJ1N6e (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 28 Oct 2022 09:58:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230253AbiJ1N6c (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 28 Oct 2022 09:58:32 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D4A41DC4DD
        for <selinux@vger.kernel.org>; Fri, 28 Oct 2022 06:58:31 -0700 (PDT)
Received: from fsav115.sakura.ne.jp (fsav115.sakura.ne.jp [27.133.134.242])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 29SDwT36000996;
        Fri, 28 Oct 2022 22:58:29 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav115.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav115.sakura.ne.jp);
 Fri, 28 Oct 2022 22:58:29 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav115.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 29SDwSsB000988
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 28 Oct 2022 22:58:29 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <56add81d-0ea7-9d3e-0e30-e0b02e62a8d0@I-love.SAKURA.ne.jp>
Date:   Fri, 28 Oct 2022 22:58:30 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: LSM stacking in next for 6.1?
Content-Language: en-US
To:     Paul Moore <paul@paul-moore.com>
Cc:     John Johansen <john.johansen@canonical.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        LSM List <linux-security-module@vger.kernel.org>,
        James Morris <jmorris@namei.org>, linux-audit@redhat.com,
        Mimi Zohar <zohar@linux.ibm.com>, keescook@chromium.org,
        SElinux list <selinux@vger.kernel.org>
References: <791e13b5-bebd-12fc-53de-e9a86df23836.ref@schaufler-ca.com>
 <CAHC9VhQMeyxQJSAUuigu=CCr44WtpJg=LEh1xng_bPfCCjqq6Q@mail.gmail.com>
 <5ef4a1ae-e92c-ca77-7089-2efe1d4c4e6d@schaufler-ca.com>
 <CAHC9VhQRpeOMkeEfy=VRPnpuYMUDYgLp56OjQZPYwoXmfHYREQ@mail.gmail.com>
 <c679cea7-bb90-7a62-2e17-888826857d55@schaufler-ca.com>
 <e9ce6253-c8a3-19c3-1b71-f3a2e04539bc@I-love.SAKURA.ne.jp>
 <cc14bbde-529e-376c-7d27-8512ec677db3@schaufler-ca.com>
 <ff43e254-0f41-3f4f-f04d-63b76bed2ccf@I-love.SAKURA.ne.jp>
 <1a9f9182-9188-2f64-4a17-ead2fed70348@schaufler-ca.com>
 <2225aec6-f0f3-d38e-ee3c-6139a7c25a37@I-love.SAKURA.ne.jp>
 <5995f18c-5623-9d97-0aa6-5f13a2a8e895@I-love.SAKURA.ne.jp>
 <77ec837a-ff64-e6f0-fe14-a54c1646ea0b@canonical.com>
 <0fcc5444-a957-f107-25a1-3540588eab5a@I-love.SAKURA.ne.jp>
 <CAHC9VhQy91eezWMQ=MoLe3fQSu_Rc+ZUWW2Mm3+78Mr7vS_Z0A@mail.gmail.com>
 <a0567b10-fa83-50f4-7bf6-937e0c677e60@I-love.SAKURA.ne.jp>
 <CAHC9VhT2Azg1F-G3RQ4xL7JgA3OAtHafzS1_nvUyEUFsCJ9+SA@mail.gmail.com>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <CAHC9VhT2Azg1F-G3RQ4xL7JgA3OAtHafzS1_nvUyEUFsCJ9+SA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 2022/10/28 18:50, Paul Moore wrote:
>> This problem is not limited to out-of-tree and/or
>> loadable LSM modules. This change prevents new LSM modules from getting upstream
>> due to a chicken-and-egg problem.
> 
> It does *not* prevent new LSM modules from being merged upstream.
> 
> It may make it more difficult for out-of-tree modules to remain
> out-of-tree, but that is both not a concern of the upstream community
> nor is it the concern you are currently describing.

New LSM modules are out-of-tree modules until being merged upstream.

LSM modules is an area which is difficult to get merged upstream for
unknown reasons. You remember the label versus pathname war, don't you?
Do you remember that 10 modules were proposed 

    SimpleFlow ( 2016/04/21 https://lwn.net/Articles/684825/ )
    HardChroot ( 2016/07/29 https://lwn.net/Articles/695984/ )
    Checmate ( 2016/08/04 https://lwn.net/Articles/696344/ )
    LandLock ( 2016/08/25 https://lwn.net/Articles/698226/ )
    PTAGS ( 2016/09/29 https://lwn.net/Articles/702639/ )
    CaitSith ( 2016/10/21 https://lwn.net/Articles/704262/ )
    SafeName ( 2016/05/03 https://lwn.net/Articles/686021/ )
    WhiteEgret ( 2017/05/30 https://lwn.net/Articles/724192/ )
    shebang ( 2017/06/09 https://lwn.net/Articles/725285/ )
    S.A.R.A. ( 2017/06/13 https://lwn.net/Articles/725230/ )

and how many of them got merged upstream? It is inevitable that some
(or rather, many or most) of LSM modules cannot be merged upstream or
be enabled by distributors.

Even if perfect LSM stacking is implemented, I can imagine a future that
none of LSM modules available in upstream kernel can satisfy user's needs.
LSM stacking makes sense only if LSM modules which can satisfy user's needs
are available. And we know that upstream kernel won't accept whatever LSMs.

I consider /sbin/insmod-able LSM modules as a compromise/remedy for LSM modules
which could not get merged upstream or supported by distributors, for patching and
rebuilding the whole kernel in order to use not-yet-upstreamed and/or not-builtin
LSMs is already a lot of barrier for users. But requiring a permanent integer in
order to use a LSM module is a denial of even patching and rebuilding the whole
kernel. That's why I hate this change.

> 
>> Currently anyone can start writing new LSM modules using name as identifier. But
>> you are trying to forbid using name as identifier, and trying to force using integer
>> as identifier, but that integer will not be provided unless new LSM modules get
>> upstream.
> 
> That is correct.  In order to have a LSM identifier token the LSM must
> be upstream.

Then, new LSM modules which are intended to be merged upstream can't write
userspace interface.

> 
>> Then, how those who want to write new LSM modules can start writing LSM modules and
>> propose userspace changes for new LSM modules? They can't use the identifier unless
>> their LSM module get upstream, which in turn forces them not to propose interface for
>> userspace programs, which in turn makes it difficult to get new LSM modules tested
>> by users, which in turn makes it difficult to get upstream due to "who is using your
>> LSM module" question, which in turn makes it difficult to get the identifier...
> 
> First, new LSMs generally do not need extensive userspace
> modifications; of course there may be some, but when one considers the
> entirety of a modern Linux distribution the actual percentage should
> be quite small.

I agree that new LSMs generally do not need extensive userspace modifications.
But

>                  In addition, it is not uncommon for in-development
> LSMs to have a set of privately, i.e. not upstreamed, patched
> userspace tools while the new LSM works to get upstream.  These
> private userspace patches are generally merged after the LSM has been
> merged into the kernel.

I still think an identifier is needed when developing management programs for each
new LSM.

Do you mean that management programs which are specific to each LSM module are not
forced to use the identifier Casey is trying to introduce? If yes, why does "you are
trying to forbid using name as identifier, and trying to force using integer as
identifier" need to be correct? Only programs that do not belong to specific LSM
module but needs to be able to recognize various LSM modules' per task attributes
need to use the identifier Casey is trying to introduce.

I can't understand why assigning a permanent integer identifier is mandatory.
TOMOYO (and trivial LSMs) will not need such identifier. This change merely makes
it more difficult to stack minor/trivial LSMs implemented as /sbin/insmod-able LSMs,
by introducing fixed sized array.

> 
>> You are trying to force CONFIG_MODULES=n by just "we don't care about out-of-tree code".
> 
> That is not the goal at all and I would appreciate it if you could
> stop slandering the motivations of the LSM syscall effort.
> 
>> Trying to change identifier from name to integer is a serious bug.
> 
> I disagree.  One would have a similar problem - userspace
> awareness/enablement - regardless of if a name or a token is used.

TOMOYO (and trivial LSMs) will not need userspace awareness/enablement.

> Ultimately the challenge is getting userspace developers to accept a
> change that is not part of the upstream Linux Kernel and thus not
> guaranteed under the usual "don't break userspace" kernel API promise.

I'm not against the challenge. But none of "introducing fixed sized array",
"assigning permanent integer for the fixed sized array", "not assigning permanent
integer unless merged upstream" is required for achieving the challenge. We can
achieve the challenge via "using linked list" and "using name or assigning dynamic
integer upon loading of a LSM module". (Of course, if upstream kernel allows assigning
permanent integer before getting merged, we can use integer for the userspace...)

