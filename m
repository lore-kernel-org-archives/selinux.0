Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 535D1FA3743
	for <selinux@archiver.kernel.org>; Tue, 25 Oct 2022 09:48:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231361AbiJYJsO (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 25 Oct 2022 05:48:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231559AbiJYJsJ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 25 Oct 2022 05:48:09 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3473E087
        for <selinux@vger.kernel.org>; Tue, 25 Oct 2022 02:48:06 -0700 (PDT)
Received: from fsav119.sakura.ne.jp (fsav119.sakura.ne.jp [27.133.134.246])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 29P9m5WX029474;
        Tue, 25 Oct 2022 18:48:05 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav119.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav119.sakura.ne.jp);
 Tue, 25 Oct 2022 18:48:05 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav119.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 29P9m4Ij029469
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 25 Oct 2022 18:48:05 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <5995f18c-5623-9d97-0aa6-5f13a2a8e895@I-love.SAKURA.ne.jp>
Date:   Tue, 25 Oct 2022 18:48:01 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: LSM stacking in next for 6.1?
Content-Language: en-US
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To:     Casey Schaufler <casey@schaufler-ca.com>,
        Paul Moore <paul@paul-moore.com>
Cc:     John Johansen <john.johansen@canonical.com>,
        LSM List <linux-security-module@vger.kernel.org>,
        James Morris <jmorris@namei.org>, linux-audit@redhat.com,
        Mimi Zohar <zohar@linux.ibm.com>, keescook@chromium.org,
        SElinux list <selinux@vger.kernel.org>
References: <791e13b5-bebd-12fc-53de-e9a86df23836.ref@schaufler-ca.com>
 <CAHC9VhQ+UcJw4G=VHNE8wMa+EBG-UcoZ7ox0vNqLHoSKAd9XZQ@mail.gmail.com>
 <269014c6-5ce6-3322-5208-004cb1b40792@canonical.com>
 <CAHC9VhRrOgDMO9fo632tSL7vCMAy1_x3smaAok-nWdMAUFB8xQ@mail.gmail.com>
 <1958a0d3-c4fb-0661-b516-93f8955cdb95@schaufler-ca.com>
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
In-Reply-To: <2225aec6-f0f3-d38e-ee3c-6139a7c25a37@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 2022/10/25 1:37, Casey Schaufler wrote:
>>  What I'm insisting is that "warrant the freedom to load
>> loadable LSM modules without recompiling the whole kernel".
> 
> Since security modules are optional and the LSM infrastructure
> itself is optional you can't ensure that any given kernel would
> support a loadable security module.

Like I propose adding EXPORT_SYMBOL_GPL(security_hook_heads),
I'm not taking about distributors who choose CONFIG_SECURITY=n.

>> Adding EXPORT_SYMBOL_GPL(security_hook_heads) is the only way that can "allow
>> LSM modules which distributors cannot support to be legally loaded".
> 
> I believe that I've identified an alternative. It isn't easy or cheap.

No. You are just handwaving/postponing the problem using something unknown
that is not yet shown as a workable code. Anything that can be disabled via
kernel config option cannot be an alternative.

  Quoting from https://lkml.kernel.org/r/2225aec6-f0f3-d38e-ee3c-6139a7c25a37@I-love.SAKURA.ne.jp
  > Like Paul Moore said
  > 
  >   However, I will caution that it is becoming increasingly difficult for people
  >   to find time to review potential new LSMs so it may a while to attract sufficient
  >   comments and feedback.
  > 
  > , being unable to legally use loadable LSMs deprives of chances to develop/try
  > new LSMs, and makes LSM interface more and more unattractive. The consequence
  > would be "The LSM interface is dead. We will give up implementing as LSMs."

The biggest problem is that quite few developers show interest in loadable LSM modules.
How many developers responded to this topic? Once the ability to allow loadable LSM
modules is technically lost, nobody shall be able to revive it. You will be happy with
ignoring poor people.

You are already and completely trapped into "only in-tree and supported by distributors
is correct" crap.

> Of course the upstream kernel isn't going to have LSM IDs for out-of-tree
> security modules. That's one of many reasons loadable modules are going to
> have to be treated differently from built-in modules, if they're allowed
> at all.

Then, I have to hate your idea of having fixed sized array.

Nacked-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>

