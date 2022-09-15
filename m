Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 004E8ECAAA1
	for <selinux@archiver.kernel.org>; Thu, 15 Sep 2022 07:45:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229909AbiIOHp6 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 15 Sep 2022 03:45:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbiIOHp5 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 15 Sep 2022 03:45:57 -0400
Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEB1A2BDB;
        Thu, 15 Sep 2022 00:45:55 -0700 (PDT)
Received: from [172.17.1.114] (unknown [193.120.40.250])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id A07733FDD6;
        Thu, 15 Sep 2022 07:45:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1663227950;
        bh=kVmgiXJrCMwrbdfTfI4CrPavY2f7IW59c5lsCnisSZQ=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=o3MH+jQK3/29hogrFHsOoteR8ueY/MRg4Ddnn8BsOMuw43HeN29yiNq3lcb2+N9J8
         oHw42L5xAWy7rfVX+xPzkxT6GTaDxkpmgg33dYNOTkmSUa7OfwOoPthDe616cKSzPw
         xzdaCqyF4Ut7sxoynNDg6ZdwY7Wgm/rHfLdMnCk8xEXvE+YtxHM5LVJCR2BtqhxT47
         8PXPPR+ebVhZuSBq8g3rx+x1WOy8TOHvRorE3GWOAzfeqTQDZ2JPD+P3PVLvLKNKUl
         qno5mB0jHjJYjomBwp2hPSzhGf4pqvIFDL4a1U/lc6Yp5eo9/eTb2TE6c6pZPmHU/l
         9DjRPndu9jmFQ==
Message-ID: <e7e7d647-e903-4533-f146-befc77ff25c0@canonical.com>
Date:   Thu, 15 Sep 2022 00:45:50 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: LSM stacking in next for 6.1?
Content-Language: en-US
To:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Paul Moore <paul@paul-moore.com>
Cc:     LSM List <linux-security-module@vger.kernel.org>,
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
From:   John Johansen <john.johansen@canonical.com>
Organization: Canonical
In-Reply-To: <2225aec6-f0f3-d38e-ee3c-6139a7c25a37@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 9/14/22 06:57, Tetsuo Handa wrote:
> On 2022/09/13 23:45, Casey Schaufler wrote:
>>> . A security module that manages loadable LSM modules cannot give us a good answer
>>> if there is a kernel config option to disable the manager security module.
>>
>> The community that is absolutely opposed to loadable modules will disagree.
> 
> Who are members of that community?
> 
> Hiding security_hook_heads from /proc/kallsyms has no value from security
> perspective, for malicious loadable kernel modules can calculate the address
> of security_hook_heads based on addresses of relevant functions and byte-code
> in the relevant functions.
> 
> Keeping __lsm_ro_after_init might have a little value, but at the same time
> it might make kernel less secure (or more prone to memory corruption) due to
> the need to pass rodata=0 kernel command line option when a loadable module
> LSM is loaded.
> 
> 
> 
>>> The kernel config option and distribution's policy are preventing users from using
>>> non-builtin LSMs in distributor's kernels. It is a trivial task to make TOMOYO work
>>> in distributor's kernels if above-mentioned changes are accepted.
>>
>> You should be able to use TOMOYO as a built-in along side other security modules
>> today. Aside from getting the distribution to include it in their kernel
>> configuration, which is admittedly no mean feat, and getting any user-space you
>> need included, you should already have what you need.
> 
> That's a chicken-and-egg problem.
> 
> Yes, we can use TOMOYO as a built-in along side other security modules for
> _user-built_ kernels. But no, we can't use TOMOYO for _distributor-built_ kernels
> (namely, Fedora/CentOS Stream/RHEL kernels).
> 
>>> https://bugzilla.redhat.com/show_bug.cgi?id=542986
>>
>> Ten years ago they said "Don't want to, aren't going to". Sadly, I doubt
>> there would be a different attitude today. The decision to support a security
>> module in a distribution is serious. I can definitely see how Redhat would
>> have their hands full supporting SELinux.
> 
> Please distinguish the difference between "enable" and "support" at
> https://bugzilla.redhat.com/show_bug.cgi?id=542986#c7 . (By the way,
> I hate the word "support", for nobody can share agreed definition.)
> 
> "enable" is something like "available", "allow to exist".
> 
> "support" is something like "guaranteed", "provide efforts for fixing bugs".
> 
> However, in the Red Hat's world, "enable" == "support". The kernel config options
> enabled by Red Hat is supported by Red Hat, and the kernel config options Red Hat
> cannot support cannot be enabled by Red Hat.
> 
> On the contrary, in the vanilla kernel's world, the in-tree version of TOMOYO
> cannot be built as a loadable module LSM. And it is impossible to built TOMOYO
> as a loadable module LSM (so that TOMOYO can be used without the "support" by
> Red Hat). As a result, users cannot try LSMs (either in-tree or out-of-tree)
> other than SELinux.
> 
> The negative effect is not limited to TOMOYO.
> Like Paul Moore said
> 
>    However, I will caution that it is becoming increasingly difficult for people
>    to find time to review potential new LSMs so it may a while to attract sufficient
>    comments and feedback.
> 
> , being unable to legally use loadable LSMs deprives of chances to develop/try
> new LSMs, and makes LSM interface more and more unattractive. The consequence
> would be "The LSM interface is dead. We will give up implementing as LSMs."
> 
> It is exactly "only in-tree and supported by distributors is correct" crap.
> 

for some users, but having a very well defined support surface also has its
place. From a distro POV support is expensive and its amazing what users
will do and try to hide while trying to get support.

Personally I prefer splitting enable and support but there are situations
where that isn't even allowed (some certifications). So I can understand
where they are coming from.

It just sucks for the users and projects that aren't "supported".

> I don't like closed-source kernel modules that rewrite syscall tables (e.g.
> used by AntiVirus), for I can't analyze problems when something went wrong.

Does anyone?

> If LSMs were available to open-source out-of-tree kernel modules, this situation
> could be improved.
> 
you are more optimistic than I am. What makes you think a distro like RH will
enable loading out-of-tree kernel modules if they aren't enabling TOMOYO
that is already in the kernel.

If loadable LSM modules are allowed, there will likely be a kernel config
to disable them and there will definitely be an interface that allows
blocking them. So whether via config option or run time control I don't
see RH allowing them.

> 
> 
> I think that syzbot is the most aggressive tester of TOMOYO security module.
> But how many bugs did syzbot found in TOMOYO? How many distributors that
> enabled TOMOYO in their kernels got bug reports regarding TOMOYO?
> 
> There might be reports like "When do you start providing ready-made policy
> configurations?", but what Josh Boyer worried at
> https://bugzilla.redhat.com/show_bug.cgi?id=542986#c8
> 
>    Simply put, we do not have the time to deal with any potential kernel bug
>    reports that would come from enabling TOMOYO.  It would be a disservice to
>    our users to enable something we have no intention of attempting to fix
>    when it is broken.
> 
> did not happen, and
> 
>    Even if it was 100% perfect code and caused no bug reports for the kernel,
>    it is still bloat and while it might not seem like it we are actually
>    trying to cut down on the size of our installed kernels.
> 
> can be solved by allowing loadable module LSMs.
> 
> Loadable module LSM also breaks distributor's "enable" == "support" spell.
> 

sadly I really don't think it will

> 
> 
>> A loadable module would have to be managed differently from a built-in one.
>> Hence the notion of a loadable module manager.
> 
> We can make management up to module authors, like the comment of security_delete_hooks().
> (Well, I'm not proposing ability to unload. I'm proposing only ability to load LSMs
> as loadable kernel modules.)
> 

