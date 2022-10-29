Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8094AC433FE
	for <selinux@archiver.kernel.org>; Sat, 29 Oct 2022 09:34:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229476AbiJ2JeI (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 29 Oct 2022 05:34:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiJ2JeH (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sat, 29 Oct 2022 05:34:07 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C342497D6C
        for <selinux@vger.kernel.org>; Sat, 29 Oct 2022 02:34:06 -0700 (PDT)
Received: from fsav315.sakura.ne.jp (fsav315.sakura.ne.jp [153.120.85.146])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 29T9XeSS061021;
        Sat, 29 Oct 2022 18:33:40 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav315.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav315.sakura.ne.jp);
 Sat, 29 Oct 2022 18:33:40 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav315.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 29T9XeZG061016
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 29 Oct 2022 18:33:40 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <87c2eb1b-0f50-5d8c-1dad-c7059e2fb0c1@I-love.SAKURA.ne.jp>
Date:   Sat, 29 Oct 2022 18:33:42 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: LSM stacking in next for 6.1?
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>
Cc:     Paul Moore <paul@paul-moore.com>,
        John Johansen <john.johansen@canonical.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        LSM List <linux-security-module@vger.kernel.org>,
        James Morris <jmorris@namei.org>, linux-audit@redhat.com,
        Mimi Zohar <zohar@linux.ibm.com>,
        SElinux list <selinux@vger.kernel.org>
References: <ff43e254-0f41-3f4f-f04d-63b76bed2ccf@I-love.SAKURA.ne.jp>
 <1a9f9182-9188-2f64-4a17-ead2fed70348@schaufler-ca.com>
 <2225aec6-f0f3-d38e-ee3c-6139a7c25a37@I-love.SAKURA.ne.jp>
 <5995f18c-5623-9d97-0aa6-5f13a2a8e895@I-love.SAKURA.ne.jp>
 <77ec837a-ff64-e6f0-fe14-a54c1646ea0b@canonical.com>
 <0fcc5444-a957-f107-25a1-3540588eab5a@I-love.SAKURA.ne.jp>
 <CAHC9VhQy91eezWMQ=MoLe3fQSu_Rc+ZUWW2Mm3+78Mr7vS_Z0A@mail.gmail.com>
 <a0567b10-fa83-50f4-7bf6-937e0c677e60@I-love.SAKURA.ne.jp>
 <CAHC9VhT2Azg1F-G3RQ4xL7JgA3OAtHafzS1_nvUyEUFsCJ9+SA@mail.gmail.com>
 <56add81d-0ea7-9d3e-0e30-e0b02e62a8d0@I-love.SAKURA.ne.jp>
 <202210280944.AF75E37DC@keescook>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <202210280944.AF75E37DC@keescook>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 2022/10/29 2:40, Kees Cook wrote:
> On Fri, Oct 28, 2022 at 10:58:30PM +0900, Tetsuo Handa wrote:
>> I consider /sbin/insmod-able LSM modules as a compromise/remedy for LSM modules
>> which could not get merged upstream or supported by distributors, for patching and
>> rebuilding the whole kernel in order to use not-yet-upstreamed and/or not-builtin
>> LSMs is already a lot of barrier for users. But requiring a permanent integer in
>> order to use a LSM module is a denial of even patching and rebuilding the whole
>> kernel. That's why I hate this change.
> 
> But the upstream kernel _does not support APIs for out-of-tree code_. To
> that point, security_add_hooks() is _not exported_, so it is already not
> possible to create a modular LSM without patching the kernel source.

AKARI/CaitSith and several other LSM modules are running without patching
the kernel source. But this patchset makes it impossible to use 9 out of 13
LSM modules as (not upstreamed but) built-in LSM modules by patching the kernel,
due to lack of identifier. That's a needless requirement that harms development
of LSM modules.

Linux kernel has started using a new and more inclusive terminology for the
Linux kernel code and documentation. But this patchset is making the code
more and more exclusive. That's a way to exclude LSM modules that satisfies
user's need, even if perfect LSM stacking implementation is provided.

What do you think if an authority commands you that companies like Intel, Google,
RedHat, Canonical etc. must wind up because these companies are not member of
that authority? That's behavior of autocracy.

This patchset _does not allow out-of-tree code to exist_ rather than simply
_does not support APIs for out-of-tree code_. The behavior of this patchset is
to exclude 9 out of 13 LSM modules, unless upstream kernel allows these modules
to exist (by assigning an LSM id value). What a closed community LSM is!

