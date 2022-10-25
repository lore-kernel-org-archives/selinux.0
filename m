Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D64D3C38A2D
	for <selinux@archiver.kernel.org>; Tue, 25 Oct 2022 22:12:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230453AbiJYWMy (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 25 Oct 2022 18:12:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230415AbiJYWMx (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 25 Oct 2022 18:12:53 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22C4E1EECC
        for <selinux@vger.kernel.org>; Tue, 25 Oct 2022 15:12:51 -0700 (PDT)
Received: from fsav118.sakura.ne.jp (fsav118.sakura.ne.jp [27.133.134.245])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 29PMCoQV066785;
        Wed, 26 Oct 2022 07:12:50 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav118.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav118.sakura.ne.jp);
 Wed, 26 Oct 2022 07:12:50 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav118.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 29PMCoqK066782
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 26 Oct 2022 07:12:50 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <98ab33d6-6c91-9c0a-8647-22f6bdede885@I-love.SAKURA.ne.jp>
Date:   Wed, 26 Oct 2022 07:12:47 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: LSM stacking in next for 6.1?
Content-Language: en-US
To:     Casey Schaufler <casey@schaufler-ca.com>,
        John Johansen <john.johansen@canonical.com>,
        Paul Moore <paul@paul-moore.com>
Cc:     LSM List <linux-security-module@vger.kernel.org>,
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
 <11564f69-3bba-abf7-eb46-06813ff4a404@schaufler-ca.com>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <11564f69-3bba-abf7-eb46-06813ff4a404@schaufler-ca.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 2022/10/25 23:12, Casey Schaufler wrote:
> On 10/25/2022 4:20 AM, Tetsuo Handa wrote:
>> On 2022/10/25 19:26, John Johansen wrote:
>>> no, Casey is not. He is trying to find a path forward to get LSM
>>> stacking upstream sooner than later. He has made proposals that
>>> admittedly you have not liked, but he has at least tried to propose
>>> ideas that could work within the insane set of constraints.
>> I'm OK with getting LSM stacking upstream. But changes made based on
>> only built-in modules are bad. If LSM id cannot be assigned to loadable
>> LSM modules at runtime because not all loadable LSM modules will be
>> in-tree in order to get an LSM id assigned, loadable LSM modules won't
>> be able to utilize e.g. lsm_module_list system call (or whatever
>> changes made while trying to unshare resources/interfaces currently
>> shared among SELinux/Smack/AppArmor).
>>
>> It will be a complete reinvention of Linux security framework which is
>> merely borrowing hooks provided by LSM. That is no different from
>> duplicating existing LSM hooks and managing via completely different
>> set of interfaces (e.g. /proc/$pid/attr2/$lsmname/$filename ,
>> /sys/kernel/security2/$lsmname/$filename ). Such implementation is
>> no longer loadable LSM. It is LSM version 2. And I don't think that
>> such implementation will be accepted unless you agree to kill current
>> LSM (say, LSM version 1).
> 
> The counter argument to this statement is that BPF has been accepted
> upstream. eBPF programs are different from built-in security modules.
> There is no reason that a well implemented LSM that accepts loadable
> modules *that are different* from built-in modules couldn't be created.
> I seriously doubt that it would get upstream for all the reasons
> usually cited. But there is nothing about the implementation I've proposed
> that would prevent it.
> 

As an easy example, please show me an eBPF program that allows restricting where
to chroot to and allows configuring where to chroot to using /sys/kernel/security/
interface.

An loadable LSM consists of hooks (for filtering access requests) and interface
(for configuring rules whether to filter access requests).

Your LSM id approach makes it impossible to use interface (due to lack of LSM id
for loadable LSM modules) by loadable LSM modules. LSM id must not be limited to
built-in LSM modules.

