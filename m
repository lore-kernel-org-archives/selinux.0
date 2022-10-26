Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11D8EC433FE
	for <selinux@archiver.kernel.org>; Wed, 26 Oct 2022 10:19:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231681AbiJZKTi (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 26 Oct 2022 06:19:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231937AbiJZKTh (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 26 Oct 2022 06:19:37 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79EAC10071
        for <selinux@vger.kernel.org>; Wed, 26 Oct 2022 03:19:36 -0700 (PDT)
Received: from fsav313.sakura.ne.jp (fsav313.sakura.ne.jp [153.120.85.144])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 29QAJYGa040633;
        Wed, 26 Oct 2022 19:19:34 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav313.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav313.sakura.ne.jp);
 Wed, 26 Oct 2022 19:19:34 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav313.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 29QAJYCE040630
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 26 Oct 2022 19:19:34 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <3266c2c2-cd7e-bc0f-0fc4-478a63d6ee77@I-love.SAKURA.ne.jp>
Date:   Wed, 26 Oct 2022 19:19:28 +0900
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
 <98ab33d6-6c91-9c0a-8647-22f6bdede885@I-love.SAKURA.ne.jp>
 <aa201ed7-9ca1-9507-08cc-156f280ee5f4@schaufler-ca.com>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <aa201ed7-9ca1-9507-08cc-156f280ee5f4@schaufler-ca.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 2022/10/26 7:41, Casey Schaufler wrote:
>             You need a built-in LSM that loads and manages loadable
> security modules.

That is no longer loadable LSM modules. A loadable LSM module must be capable of
loading any code and using any interface that is allowed to loadable kernel modules
using /sbin/insmod command. That is my understanding of what you have promised (and
the reason I am allowing you to continue working on LSM stacking before I make
CONFIG_SECURITY_TOMOYO=m).

>                   That LSM would have an LSM ID just like the BPF LSM
> has a LSM ID.

There can't be a LSM that manages loadable security modules. TOMOYO can't be loaded
via such LSM, for TOMOYO needs to e.g. create /sys/kernel/security/tomoyo/ interface.
A contained program like BPF can't get such flexibility, and a LSM that manages
loadable security modules can't manage flexible/unconfined programs.

>                   That LSM would have an LSM ID just like the BPF LSM
> has a LSM ID.

Whatever LSM modules that are in-tree will have an LSM id. But you must remember
that not all LSM modules are in-tree (and won't be able to get in-tree).
The LSM id I'm talking about is for LSM modules that cannot get in-tree.

>               I have no doubt that there are multiple workable implementations,
> as I have looked into many different ways to implement the stacking for
> built-in modules.

Please enumerate some that can satisfy our promise.

Even if there is a LSM that manages loadable LSMs, loadable LSMs can't get LSM id
because what loadable LSMs will do is beyond what the BPF LSM can do.
Loadable LSMs by nature needs to be able to have unique identifier (currently
module name, and you are trying to change from name to integer which some of
loadable LSMs cannot get).

>                   I am also sorry that I don't expect to have enough working
> years left to even consider spending any more time on the problem. This is
> a development effort for The Next Generation.

If you segregate built-in LSM modules and loadable LSM modules (remember,
not all LSM modules will be able to get in-tree and built-in), userspace won't be
able to use LSM id you are trying to introduce. Your LSM id makes LSM framework
worse than now.

You are killing The Next Generation due to "only in-tree and supported by
distributors is correct" crap.

