Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EE02C433FE
	for <selinux@archiver.kernel.org>; Thu, 27 Oct 2022 00:02:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232946AbiJ0ACr (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 26 Oct 2022 20:02:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229880AbiJ0ACq (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 26 Oct 2022 20:02:46 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E55C32051
        for <selinux@vger.kernel.org>; Wed, 26 Oct 2022 17:02:45 -0700 (PDT)
Received: from fsav119.sakura.ne.jp (fsav119.sakura.ne.jp [27.133.134.246])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 29R02hOb003349;
        Thu, 27 Oct 2022 09:02:43 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav119.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav119.sakura.ne.jp);
 Thu, 27 Oct 2022 09:02:43 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav119.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 29R02hkK003345
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 27 Oct 2022 09:02:43 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <a0567b10-fa83-50f4-7bf6-937e0c677e60@I-love.SAKURA.ne.jp>
Date:   Thu, 27 Oct 2022 09:02:43 +0900
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
 <CAHC9VhQPvcunvBDvSnrUChwmGLen0Rcy8KEk_uOjNF1kr4_m9w@mail.gmail.com>
 <6552af17-e511-a7d8-f462-cafcf41a33bb@schaufler-ca.com>
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
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <CAHC9VhQy91eezWMQ=MoLe3fQSu_Rc+ZUWW2Mm3+78Mr7vS_Z0A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 2022/10/27 5:11, Paul Moore wrote:
> On Tue, Oct 25, 2022 at 7:20 AM Tetsuo Handa
> <penguin-kernel@i-love.sakura.ne.jp> wrote:
>> On 2022/10/25 19:26, John Johansen wrote:
>>> no, Casey is not. He is trying to find a path forward to get LSM
>>> stacking upstream sooner than later. He has made proposals that
>>> admittedly you have not liked, but he has at least tried to propose
>>> ideas that could work within the insane set of constraints.
>>
>> I'm OK with getting LSM stacking upstream. But changes made based on
>> only built-in modules are bad. If LSM id cannot be assigned to loadable
>> LSM modules at runtime because not all loadable LSM modules will be
>> in-tree in order to get an LSM id assigned, loadable LSM modules won't
>> be able to utilize e.g. lsm_module_list system call (or whatever
>> changes made while trying to unshare resources/interfaces currently
>> shared among SELinux/Smack/AppArmor).
> 
> As a reminder, the LSM layer, just like the rest of the kernel, has no
> plans to provide any level of consideration or support for out-of-tree
> kernel code.  LSMs which are not part of the upstream Linux kernel are
> not our concern here; if they fail to work with the syscall and/or LSM
> stacking changes merged, that should not be considered a blocker to
> upstream development.
> 

No. You are misunderstanding. This problem is not limited to out-of-tree and/or
loadable LSM modules. This change prevents new LSM modules from getting upstream
due to a chicken-and-egg problem.

Currently anyone can start writing new LSM modules using name as identifier. But
you are trying to forbid using name as identifier, and trying to force using integer
as identifier, but that integer will not be provided unless new LSM modules get
upstream.

Then, how those who want to write new LSM modules can start writing LSM modules and
propose userspace changes for new LSM modules? They can't use the identifier unless
their LSM module get upstream, which in turn forces them not to propose interface for
userspace programs, which in turn makes it difficult to get new LSM modules tested
by users, which in turn makes it difficult to get upstream due to "who is using your
LSM module" question, which in turn makes it difficult to get the identifier...

You are trying to force CONFIG_MODULES=n by just "we don't care about out-of-tree code".
Trying to change identifier from name to integer is a serious bug.

