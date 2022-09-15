Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 966D1C6FA89
	for <selinux@archiver.kernel.org>; Thu, 15 Sep 2022 14:27:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbiIOO11 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 15 Sep 2022 10:27:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiIOO10 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 15 Sep 2022 10:27:26 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CE51AE68
        for <selinux@vger.kernel.org>; Thu, 15 Sep 2022 07:27:25 -0700 (PDT)
Received: from fsav415.sakura.ne.jp (fsav415.sakura.ne.jp [133.242.250.114])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 28FERN7K044334;
        Thu, 15 Sep 2022 23:27:23 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav415.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav415.sakura.ne.jp);
 Thu, 15 Sep 2022 23:27:23 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav415.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 28FERNj0044330
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 15 Sep 2022 23:27:23 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <38ebbbd0-bd07-b3a4-1254-3b3f3c847fab@I-love.SAKURA.ne.jp>
Date:   Thu, 15 Sep 2022 23:27:22 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: LSM stacking in next for 6.1?
Content-Language: en-US
To:     John Johansen <john.johansen@canonical.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Paul Moore <paul@paul-moore.com>
Cc:     LSM List <linux-security-module@vger.kernel.org>,
        James Morris <jmorris@namei.org>, linux-audit@redhat.com,
        Mimi Zohar <zohar@linux.ibm.com>, keescook@chromium.org,
        SElinux list <selinux@vger.kernel.org>
References: <791e13b5-bebd-12fc-53de-e9a86df23836.ref@schaufler-ca.com>
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
 <e7e7d647-e903-4533-f146-befc77ff25c0@canonical.com>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <e7e7d647-e903-4533-f146-befc77ff25c0@canonical.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 2022/09/15 16:45, John Johansen wrote:
> On 9/14/22 06:57, Tetsuo Handa wrote:
> for some users, but having a very well defined support surface also has its
> place. From a distro POV support is expensive and its amazing what users
> will do and try to hide while trying to get support.
> 

I know support is expensive. But distributors are not the only organizations
who provide support. Non-distributors can provide efforts for fixing bugs.
(In fact, I'm debugging problems where distributors would not care/support.)

> Personally I prefer splitting enable and support but there are situations
> where that isn't even allowed (some certifications). So I can understand
> where they are coming from.

What certifications require that an LSM must not be loaded as a loadable kernel
module?

I can imagine that certification becomes void if uncertified/extra kernel modules
are loaded. But I can't imagine that ability to load some kernel module (either
LSM or not) is relevant to certification.

>> I don't like closed-source kernel modules that rewrite syscall tables (e.g.
>> used by AntiVirus), for I can't analyze problems when something went wrong.
> 
> Does anyone?

Yes. It took me whole 2 years to prove that a timeout problem happening in a RHEL
system using TrendMicro's DeepSecurity is caused by a loadable kernel module used
by DeepSecurity. It is really difficult to analyze problems with closed-source
kernel modules, for I can't guess what is happening from source code.

You can browse how a loadable kernel module (for TrendMicro's ServerProtect) would look like
at https://files.trendmicro.com/products/splx/splx_kernel_module-3.0.1.0024-src.tar.gz .
I'm expecting that such loadable kernel module becomes cleaner by legally allowing
loadable LSM modules.

> 
>> If LSMs were available to open-source out-of-tree kernel modules, this situation
>> could be improved.
>>
> you are more optimistic than I am. What makes you think a distro like RH will
> enable loading out-of-tree kernel modules if they aren't enabling TOMOYO
> that is already in the kernel.
> 
> If loadable LSM modules are allowed, there will likely be a kernel config
> to disable them and there will definitely be an interface that allows
> blocking them. So whether via config option or run time control I don't
> see RH allowing them.

An interface that allows blocking unwanted loadable kernel module (either LSM or not)
will be e.g. module signature verification. No special switch for LSM is needed.

The "Vendor-A enables module-A" == "Vendor-A provides support for module-A" and
"Vendor-B enables module-B" == "Vendor-B provides support for module-B" rule can
apply to non-SELinux LSMs.

