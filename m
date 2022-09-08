Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF431C38145
	for <selinux@archiver.kernel.org>; Thu,  8 Sep 2022 15:19:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230140AbiIHPTe (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 8 Sep 2022 11:19:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231574AbiIHPTc (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 8 Sep 2022 11:19:32 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DAF755AD
        for <selinux@vger.kernel.org>; Thu,  8 Sep 2022 08:19:29 -0700 (PDT)
Received: from fsav119.sakura.ne.jp (fsav119.sakura.ne.jp [27.133.134.246])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 288FIxPP039482;
        Fri, 9 Sep 2022 00:18:59 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav119.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav119.sakura.ne.jp);
 Fri, 09 Sep 2022 00:18:59 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav119.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 288FIwG7039479
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 9 Sep 2022 00:18:58 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <8ac2731c-a1db-df7b-3690-dac2b371e431@I-love.SAKURA.ne.jp>
Date:   Fri, 9 Sep 2022 00:18:52 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: LSM stacking in next for 6.1?
Content-Language: en-US
To:     Casey Schaufler <casey@schaufler-ca.com>,
        paul Moore <paul@paul-moore.com>,
        LSM List <linux-security-module@vger.kernel.org>
Cc:     James Morris <jmorris@namei.org>, linux-audit@redhat.com,
        John Johansen <john.johansen@canonical.com>,
        Mimi Zohar <zohar@linux.ibm.com>, keescook@chromium.org,
        SElinux list <selinux@vger.kernel.org>
References: <791e13b5-bebd-12fc-53de-e9a86df23836.ref@schaufler-ca.com>
 <791e13b5-bebd-12fc-53de-e9a86df23836@schaufler-ca.com>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <791e13b5-bebd-12fc-53de-e9a86df23836@schaufler-ca.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 2022/08/03 9:01, Casey Schaufler wrote:
> I would like very much to get v38 or v39 of the LSM stacking for Apparmor
> patch set in the LSM next branch for 6.1. The audit changes have polished
> up nicely and I believe that all comments on the integrity code have been
> addressed. The interface_lsm mechanism has been beaten to a frothy peak.
> There are serious binder changes, but I think they address issues beyond
> the needs of stacking. Changes outside these areas are pretty well limited
> to LSM interface improvements.
> 

After ((SELinux xor Smack) and AppArmor) is made possible in next for 6.1, what
comes next? Are you planning to make (SELinux and Smack and AppArmor) possible?

My concern is, when loadable LSM modules becomes legal, for I'm refraining from
again proposing CaitSith until LSM stacking completes.

Linus Torvalds said

  You security people are insane. I'm tired of this "only my version is correct" crap.

at https://lkml.kernel.org/r/alpine.LFD.0.999.0710010803280.3579@woody.linux-foundation.org .

Many modules

    SimpleFlow （ 2016/04/21 https://lwn.net/Articles/684825/ ）
    HardChroot （ 2016/07/29 https://lwn.net/Articles/695984/ ）
    Checmate （ 2016/08/04 https://lwn.net/Articles/696344/ ）
    LandLock （ 2016/08/25 https://lwn.net/Articles/698226/ ）
    PTAGS （ 2016/09/29 https://lwn.net/Articles/702639/ ）
    CaitSith （ 2016/10/21 https://lwn.net/Articles/704262/ ）
    SafeName （ 2016/05/03 https://lwn.net/Articles/686021/ ）
    WhiteEgret （ 2017/05/30 https://lwn.net/Articles/724192/ ）
    shebang （ 2017/06/09 https://lwn.net/Articles/725285/ ）
    S.A.R.A. （ 2017/06/13 https://lwn.net/Articles/725230/ ）

are proposed 5 or 6 years ago, but mostly became silent...

I still need byte-code analysis for finding the hook and code for making the hook
writable in AKARI/CaitSith due to lack of EXPORT_SYMBOL_GPL(security_add_hooks).
I wonder when I can stop questions like https://osdn.net/projects/tomoyo/lists/archive/users-en/2022-September/000740.html
caused by https://patchwork.kernel.org/project/linux-security-module/patch/alpine.LRH.2.20.1702131631490.8914@namei.org/ .

Last 10 years, my involvement with Linux kernel is "fixing bugs" rather than
"developing security mechanisms". Changes what I found in the past 10 years are:

  As far as I'm aware, more than 99% of systems still disable SELinux. People use RHEL,
  but the reason to choose RHEL is not because RHEL supports SELinux. The only thing
  changed is that the way to disable SELinux changed from SELINUX=disabled in
  /etc/selinux/config to selinux=0 on kernel command line options.

  Instead, Ubuntu users are increasing, but the reason people choose Ubuntu is not because
  Ubuntu supports AppArmor. Maybe because easy to use container environment. Maybe because
  available as Windows Subsystem for Linux.

  However, in many cases, it seems that whether the OS is Windows or Linux no longer
  matters. Programs are written using frameworks/languages which developers hardly care
  about Windows API or Linux syscall. LSM significantly focuses on syscalls, but the
  trend might no longer be trying to solve in the LSM layer...

Also, Linux servers started using AntiVirus software. Enterprise AntiVirus software uses
loadable kernel module that rewrites system call table rather than using LSM interface.
It seems that people prefer out-of-the-box security over fine grained access control rule
based security. In other words, it seems that allowlist based LSM modules are too
difficult for normal users. Maybe it is better for normal users to develop and use
single-function LSMs than try to utilize ((SELinux xor Smack) and AppArmor)... But
still loadable LSM modules are not legally available...

