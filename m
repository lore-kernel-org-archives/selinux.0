Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7996AC433F5
	for <selinux@archiver.kernel.org>; Mon, 15 Nov 2021 21:28:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A59861BE3
	for <selinux@archiver.kernel.org>; Mon, 15 Nov 2021 21:28:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350329AbhKOVbE (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 15 Nov 2021 16:31:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353251AbhKOUzb (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 15 Nov 2021 15:55:31 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0D53C061226
        for <selinux@vger.kernel.org>; Mon, 15 Nov 2021 12:43:06 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id t26so5903363lfk.9
        for <selinux@vger.kernel.org>; Mon, 15 Nov 2021 12:43:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=h81nqRcrrKi2yhNmoebHbFUUwbgkd4i/xjOIE+HDakY=;
        b=l8KhRoM0VvDE/8qz/X0TXFI/XLyMbxys5f+6xxuVHF0U81x6Z83J/fJYr8GTUbKIth
         f/j3AlqRnB7P3vE2Pw2gLI9UCV/pRg2HvHmTOh4/MIzB9b3+m6v5aahO+SA08xgCBUel
         JqYTvc5aT6S3BndkB0nTfeCE/S1kPvBs0fesIz999Yuj1Oui3uJX9xqlYN4AAH2yot00
         knRraYB/e3uin9ffonYi0dpzVbuHpRNuaw/QlWY7QKoUKDkmasPr/7fcQW9tNavcliy+
         me8v3js5oamLDkIj/wuO4viip9V6fA6Nd46UBqGpFg7D/up68cqfVlnEdKKzoFOke79y
         abqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=h81nqRcrrKi2yhNmoebHbFUUwbgkd4i/xjOIE+HDakY=;
        b=d8v9gigIxvx76xQETir3wNIVqxpk4QHvHP9QZACXR65fSxFWHAe+oJBIykA1+sfPgu
         +sIB15n4VdWl2931+aCZbQR4YjFv+TfoC3aAf/t3ANcsvKYe8H62A0huoPDw0LXZGEiT
         /us/16dQXZJYPIH/xNhv/zN6k8/HM1Zhq4VJDcj+ECagCP08u6gUFNI8K0pCz/Hht0S8
         dQA/ieDY+ZmBqzwqbPE2IJgdVkKe81kEBcmcbjAp1Sv29Hm8aPGHQFsliQnrwPX4Z763
         xmbbsN/uio0ix9Q0wHi+EodiBZzOi62bcFvGj5FR5bL4kFpf1VynvcEnj3gRjfYCQ34+
         kiPA==
X-Gm-Message-State: AOAM531oyjVAW5pzUuoeqNjP819ut4YIn0EEk1uRfbkU76FYwvHv1S+6
        0fWua21Lc8wvVRIEzIE0sBRiejwRJp0=
X-Google-Smtp-Source: ABdhPJxjCJtKOyJ5lWdPutZXwbg5o1ckAGaRCz9fBvBZEa00FfEgAszLQccTFcapNzKV261Sw9nsfA==
X-Received: by 2002:a05:6512:3996:: with SMTP id j22mr1458602lfu.637.1637008984839;
        Mon, 15 Nov 2021 12:43:04 -0800 (PST)
Received: from [192.168.1.37] (81-197-199-108.elisa-laajakaista.fi. [81.197.199.108])
        by smtp.gmail.com with ESMTPSA id 13sm1534160lfq.69.2021.11.15.12.43.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Nov 2021 12:43:04 -0800 (PST)
Subject: Re: [PATCH v2] selinux-notebook: New chapter: Hardening SELinux
To:     Dominick Grift <dominick.grift@defensec.nl>,
        Daniel Burgener <dburgener@linux.microsoft.com>
Cc:     selinux@vger.kernel.org
References: <20211113095547.19406-1-toiwoton@gmail.com>
 <7ee0207f-5be9-5050-0baa-f59d27b617a9@linux.microsoft.com>
 <87wnl9p9y3.fsf@defensec.nl>
From:   Topi Miettinen <toiwoton@gmail.com>
Message-ID: <6872b656-03cf-bcde-72ab-0b27493cac34@gmail.com>
Date:   Mon, 15 Nov 2021 22:42:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <87wnl9p9y3.fsf@defensec.nl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 15.11.2021 20.09, Dominick Grift wrote:
> Daniel Burgener <dburgener@linux.microsoft.com> writes:
> 
>> This looks great!  I found a few more typos on this readthrough,
>> enumerated below.
> 
> A couple more suggestions below

Thanks to both for your input!

> 
>>
>> On 11/13/2021 4:55 AM, Topi Miettinen wrote:
>>> Describe some easy and more difficult methods to harden SELinux
>>> policies.
>>> Signed-off-by: Topi Miettinen <toiwoton@gmail.com>
>>> ---
>>> v2:
>>>    - Updated with comments from Daniel Burgener
>>>    - Fixed issues with PDF generation
>>> ---
>>>    src/hardening.md                 | 154 +++++++++++++++++++++++++++++++
>>>    src/implementing_seaware_apps.md |   2 +-
>>>    src/reference_policy.md          |   2 +-
>>>    src/section_list.txt             |   1 +
>>>    src/toc.md                       |   1 +
>>>    5 files changed, 158 insertions(+), 2 deletions(-)
>>>    create mode 100644 src/hardening.md
>>> diff --git a/src/hardening.md b/src/hardening.md
>>> new file mode 100644
>>> index 0000000..031e7c1
>>> --- /dev/null
>>> +++ b/src/hardening.md
>>> @@ -0,0 +1,154 @@
>>> +# Hardening SELinux
>>> +
>>> +- [Tuning Booleans](#tuning-booleans)
>>> +- [Disabling Modules](#disabling-modules)
>>> +- [Users and Roles](#users-and-roles)
>>> +- [Network Controls](#network-controls)
>>> +- [Custom Policy Modules](#custom-policy-modules)
>>> +- [Fine Grained Network Controls](#fine-grained-network-controls)
>>> +- [Fully Custom Policy](#fully-custom-policy)
>>> +
>>> +The Reference Policy sets a good basis for learning how to operate a
>>> +system with SELinux. The policy allows system administrators and users
>>> +to continue using working methods that they learned before becoming
>>> +familiar with SELinux, because of its "targeted" model and reasonable
>>> +defaults.
>>> +
>>> +However, it's possible to tighten the policy considerably. The
>>> +Reference Policy gives several options for hardening but for maximum
>>> +control over the policy, it's possible to write custom modules or even
>>> +replace the Reference Policy entirely.
>>> +
>>> +The hardening suggestions are listed in the rough order of difficulty.
>>> +
>>> +## Tuning Booleans
>>> +
>>> +The Reference Policy uses booleans to control optional aspects of the
>>> +policy. Changing the booleans is very easy way to tune the SELinux
>>> +policy. The booleans can be also changed temporarily, without
>>> +committing them yet to the on-disk policy, so changes are
>>> +automatically reverted on next boot.
>>
>> "...changing the booleans is *a* very easy..."
>>
>>> +
>>> +For example, recent Firefox browsers can work with policy boolean
>>> +`mozilla_execstack` set to `off`. This can reduce the surface to
>>> +vulnerabilities which could use an executable stack. The boolean can
>>> +be changed using ***setsebool**(8)*:
>>> +
>>> +```
>>> +# Check current status:
>>> +getsebool mozilla_execstack
>>> +mozilla_execstack --> on
>>> +
>>> +# Change temporarily:
>>> +setsebool mozilla_execstack=off
>>> +
>>> +# Write to persistent policy on disk:
>>> +setsebool -P mozilla_execstack=off
>>> +
>>> +```
>>> +
>>> +## Disabling Modules
>>> +
>>> +By default, the Reference Policy enables most policy modules to
>>> +support any system. But when the system is known well by the
>>> +administrator, it's possible to remove modules which aren't used.
> 
> It is better to just disable module that you do not use as removing the
> modules probably causes them to be reinstalled on policy upgrades and
> thus be re-enabled. This is likely not what one would expect.

Post-install script in Debian package checks for both removed and 
disabled modules and tries to keep the state same after package upgrade. 
Is this not the case for other distros? I haven't had problems with 
upgrading the package with lots of removed modules.

> 
>>> +
>>> +As an example, if Firefox isn't installed, the module `mozilla` can be
>>> +removed from the policy. The hardening effect comes from reducing the
>>> +allow rules, some of which may apply to paths which aren't actively
>>> +monitored because the corresponding application isn't installed.
>>> +
>>> +Care should be taken to never remove modules which actually are used,
>>> +since this may weaken the policy instead, because the removed module
>>> +could have contained an application more strictly than what the policy
>>> +allows without the module. Removing critical modules can also result
>>> +in system breakage.
>>> +
>>> +## Users and Roles
>>> +
>>> +In the "targeted" model, both unprivileged users and the system
>>> +administrator (`root`) are unconfined and the TE rules are very
>>> +relaxed. However, it's possible to change the SELinux user for these
>>> +accounts to more confined variants.
>>> +
>>> +For the unprivileged users, the confined user in the Reference Policy
>>> +is `user_u` with corresponding role `user_r`. There's also `staff_u`
>>> +and `staff_r` to allow transitioning to system administrative roles by
>>> +logging in as `staff_u:staff_r` and escalating to `staff_u:sysadm_r`
>>> +or another role for administrative tasks with ***newrole**(1)*.
>>> +
>>> +For the system administrator there are several options: `root` SELinux
>>> +user, which is mostly unconfined and `sysadm_u`, which is more
>>> +confined. The role for both is `sysadm_r`.
>>> +
>>> +It's also possible to divide the powers of the system administrator to
>>> +several roles, `sysadm_r`, `auditadm_r`, `logadm_r`, `dbadm_r` and
>>> +`secadm_r`. This can be useful when an organization wants to ensure
>>> +that even the system administrators can be held accountable for their
>>> +actions. The roles can be also useful for management of labor, for
>>> +example having dedicated persons for managing databases or SELinux
>>> +policies.
>>> +
>>> +It should be noted that since this isn't the default way of operating
>>> +SELinux, the Reference Policy may need to supplemented and the
> 
> there is some thing not right here: "the Reference Policy may need to supplemented"

Right, "need to be supplemented".

> 
>>> +administrators, even users, may need to be more aware of SELinux in
>>> +order to be able to operate the system.
>>> +
>>> +## Network Controls
>>> +
>>> +With network controls of SELinux, it's possible to enhance firewall
>>> +rules with knowledge of SELinux types. Traditional firewall rules only
>>> +affect the whole system by allowing certain ports and protocols but
>>> +blocking others. With `nftables` and `iptables` it's also possible to
>>> +make this more fine grained: certain users can access network but
>>> +others may not. By using also SELinux controls it's possible to fine
>>> +tune this to application level: `mozilla_t` can connect to the
>>> +Internet but some other applications can't. SELinux packet controls
>>> +can be also used to combine Deep Packet Inspection with SELinux TE
>>> +rules.
>>
>> "...can access *the* network..."
>>
>> "By also using SELinux..."
>>
>> "...fine tune this to *the* application level..."
>>
>>> +
>>> +## Custom Policy Modules
>>> +
>>> +Further hardening can be achieved by replacing policy modules from the
>>> +Reference Policy with custom modules. Typically the modules in the
>>> +Reference Policy are written to allow all possible modes of operation
>>> +for an application or its users, since the writers of the policy don't
>>> +know the specifics of each installation. Thus the SELinux rules may be
>>> +more relaxed than what could be optimal for a specific case. When the
>>> +exact environment and usage patterns are known, it's possible to write
>>> +replacement policy modules to remove excess rules and hence reduce
>>> +attack surface.
>>> +
>>> +As a minimum, it should be ensured that all continuously running
>>> +services and main user applications have a dedicated policy module or
>>> +rules, instead of running in for example `init_t`, `initrc_t` or
>>> +`unconfined_t` types which may offer low level of protection.
>>> +
>>> +## Fine Grained Network Controls
>>> +
>>> +In an internal network of an organization, where all entities can
>>> +agree on the same SELinux policy, using IPSec, CIPSO and CALIPSO may
>>> +allow further policy controls. In addition to SELinux domain of the
>>> +source application, even the SELinux domain (or at least MCS/MLS
>>> +category/sensitivity) of the target server can be used in TE rules.
>>> +
>>> +## Fully Custom Policy
>>> +
>>> +It's also possible to write custom SELinux policies for an entire
>>> +system with non-trivial effort.
>>> +
>>> +The rules can also be analyzed with various SELinux tools, such as
>>> +`apol`, `sedta`, `sepolicy` and many more. With the tools it may be
> 
> those arent exactly the tools that come to mind first here, especially
> not `sepolicy`. I would first and foremost mention `seinfo` and
> `sesearch`.

Those are great too. Though there's also Appendix C and many manual 
pages would also benefit from examples.

> 
> It would be nice if this doc would have some examples. It should not be
> hard since the doc targets refpolicy.

Yes, more examples would be great. I'll try to add some more here.

-Topi

> 
>>> +possible to find hardening opportunities or errors in the policy.
>>> +
>>> +The downside of making the SELinux rules as tight as possible is that
>>> +when the applications (or hardware components or network
>>> +configuration) are updated, there's a possibility that the rules may
>>> +also need updating because of the changes. Less generic rules are also
>>> +less generally useful for different configurations, so the rules may
>>> +need tuning for each installation.
>>> +
>>> +<!-- %CUTHERE% -->
>>> +
>>> +---
>>> +**[[ PREV ]](reference_policy.md)** **[[ TOP ]](#)** **[[ NEXT ]](implementing_seaware_apps.md)**
>>> diff --git a/src/implementing_seaware_apps.md b/src/implementing_seaware_apps.md
>>> index 74833f8..2351421 100644
>>> --- a/src/implementing_seaware_apps.md
>>> +++ b/src/implementing_seaware_apps.md
>>> @@ -297,4 +297,4 @@ applied to their objects as defined by policy.
>>>    <!-- %CUTHERE% -->
>>>      ---
>>> -**[[ PREV ]](reference_policy.md)** **[[ TOP ]](#)** **[[ NEXT ]](embedded_systems.md)**
>>> +**[[ PREV ]](hardening.md)** **[[ TOP ]](#)** **[[ NEXT ]](embedded_systems.md)**
>>> diff --git a/src/reference_policy.md b/src/reference_policy.md
>>> index 45e4145..ebb516f 100644
>>> --- a/src/reference_policy.md
>>> +++ b/src/reference_policy.md
>>> @@ -3060,4 +3060,4 @@ section.
>>>    <!-- %CUTHERE% -->
>>>      ---
>>> -**[[ PREV ]](modular_policy_statements.md)** **[[ TOP ]](#)** **[[ NEXT ]](implementing_seaware_apps.md)**
>>> +**[[ PREV ]](modular_policy_statements.md)** **[[ TOP ]](#)** **[[ NEXT ]](hardening.md)**
>>> diff --git a/src/section_list.txt b/src/section_list.txt
>>> index dcca883..b67f65e 100644
>>> --- a/src/section_list.txt
>>> +++ b/src/section_list.txt
>>> @@ -52,6 +52,7 @@ infiniband_statements.md
>>>    xen_statements.md
>>>    modular_policy_statements.md
>>>    reference_policy.md
>>> +hardening.md
>>>    implementing_seaware_apps.md
>>>    embedded_systems.md
>>>    seandroid.md
>>> diff --git a/src/toc.md b/src/toc.md
>>> index f5778bd..20a87f0 100644
>>> --- a/src/toc.md
>>> +++ b/src/toc.md
>>> @@ -53,6 +53,7 @@
>>>        - [XEN Statements](xen_statements.md#xen-statements)
>>>        - [Modular Policy Support Statements](modular_policy_statements.md#modular-policy-support-statements)
>>>    - [The Reference Policy](reference_policy.md#the-reference-policy)
>>> +- [Hardening SELinux](hardening.md#hardening-selinux)
>>>    - [Implementing SELinux-aware Applications](implementing_seaware_apps.md#implementing-selinux-aware-applications)
>>>    - [Embedded Systems](embedded_systems.md#embedded-systems)
>>>    - [SE for Android](seandroid.md#security-enhancements-for-android)
>>>
>>
>> -Daniel
>>
> 

