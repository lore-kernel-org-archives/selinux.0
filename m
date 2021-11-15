Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21C1EC433EF
	for <selinux@archiver.kernel.org>; Tue, 16 Nov 2021 00:56:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0CBF8617E4
	for <selinux@archiver.kernel.org>; Tue, 16 Nov 2021 00:56:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348438AbhKPA7f (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 15 Nov 2021 19:59:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358823AbhKPA4u (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 15 Nov 2021 19:56:50 -0500
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E798C07AF64
        for <selinux@vger.kernel.org>; Mon, 15 Nov 2021 15:03:04 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id e9so38888617ljl.5
        for <selinux@vger.kernel.org>; Mon, 15 Nov 2021 15:03:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=CKUkqu7d/I2GvCdAk34QS/Oz0Lnk6bp48EbKS9iFz6E=;
        b=Ca/P5sdC3OOeFOEsJolqyR1z93AEaHXQg0qOC3iXr0Bxf9DRyEq49T6M4Qar/WFuxl
         kZhEYaYz7DEQjG9xoasIVSTllTjUd8csoPszFn9FvssS/wE4AVWIJWWw9hrDBSR3T2px
         Lis5axwqlb2QDNkJGhcdWszc2snTbklE+xoCpg/64NOAvIieIjy20JD2nwiEiMvYnS5t
         0xbGJaxNc1ToapPB/xzC1NsbFLzyjw6xP8dvLAQYYM/zsLtFFIRd3DlKfMx0plNPQFty
         ayVDJC/Aj1/2aByEjJPG6mTte21IRhboVkaDb2PP659HYVTkPqeyjhloIvXBy0XBErac
         4zDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CKUkqu7d/I2GvCdAk34QS/Oz0Lnk6bp48EbKS9iFz6E=;
        b=yOwP2vwMxcZRoYI4TBY3DkGt/Lx7OsGFTACch9gBTewm/oJnEHpRLN/vatITlyPkIE
         /fD+DHEtX3sHihQy7sLK9mJnJMTzKI2ucdsKZ7LtQIJsxChoB2MT3TRWecCi9wutL6z5
         BBAq772+tjueK8rW+g8AfuUcftlWr04YLIC92ms3QjtHuxZ6gBGYoln33PnByzZ+ojWT
         DV3YH/32lDKWp2A7L5LYOOpUBecFKh8sU9V04HBB0wI1O6g50MMHkVTPa4asoSsu2Lq4
         vLVpkQA6XElw+BZthbLeB6ZxM9vv8WjjOxZU0WBxQru6H7NCxjd6KicAAZ8Su8ZEGuYG
         DTkQ==
X-Gm-Message-State: AOAM533oRpVPwJ21Afu9v+h12QoEUjN2Io2OLJDfnvzkDL2Skw8rfDX8
        EyFYTxUGJRXjjbz0zCVIQUrrrZLQNno=
X-Google-Smtp-Source: ABdhPJy7n52rIZURTMLqf0bmdJF1TKPcsHVXCsD01vmQT+gb7J4Wxy7JqHjK9178vKykYvmUTuqVIw==
X-Received: by 2002:a2e:a26b:: with SMTP id k11mr2211467ljm.313.1637017382102;
        Mon, 15 Nov 2021 15:03:02 -0800 (PST)
Received: from [192.168.1.37] (81-197-199-108.elisa-laajakaista.fi. [81.197.199.108])
        by smtp.gmail.com with ESMTPSA id q13sm1352198lfm.199.2021.11.15.15.03.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Nov 2021 15:03:01 -0800 (PST)
From:   Topi Miettinen <toiwoton@gmail.com>
Subject: Re: [PATCH v2] selinux-notebook: New chapter: Hardening SELinux
To:     Dominick Grift <dominick.grift@defensec.nl>
Cc:     Daniel Burgener <dburgener@linux.microsoft.com>,
        selinux@vger.kernel.org
References: <20211113095547.19406-1-toiwoton@gmail.com>
 <7ee0207f-5be9-5050-0baa-f59d27b617a9@linux.microsoft.com>
 <87wnl9p9y3.fsf@defensec.nl> <6872b656-03cf-bcde-72ab-0b27493cac34@gmail.com>
 <87o86lp0co.fsf@defensec.nl>
Message-ID: <57d7e3d2-e1b1-6ef5-5a96-a6da62cb4fef@gmail.com>
Date:   Tue, 16 Nov 2021 01:02:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <87o86lp0co.fsf@defensec.nl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 15.11.2021 23.36, Dominick Grift wrote:
> Topi Miettinen <toiwoton@gmail.com> writes:
> 
>> On 15.11.2021 20.09, Dominick Grift wrote:
>>> Daniel Burgener <dburgener@linux.microsoft.com> writes:
>>>
>>>> This looks great!  I found a few more typos on this readthrough,
>>>> enumerated below.
>>> A couple more suggestions below
>>
>> Thanks to both for your input!
>>
>>>
>>>>
>>>> On 11/13/2021 4:55 AM, Topi Miettinen wrote:
>>>>> Describe some easy and more difficult methods to harden SELinux
>>>>> policies.
>>>>> Signed-off-by: Topi Miettinen <toiwoton@gmail.com>
>>>>> ---
>>>>> v2:
>>>>>     - Updated with comments from Daniel Burgener
>>>>>     - Fixed issues with PDF generation
>>>>> ---
>>>>>     src/hardening.md                 | 154 +++++++++++++++++++++++++++++++
>>>>>     src/implementing_seaware_apps.md |   2 +-
>>>>>     src/reference_policy.md          |   2 +-
>>>>>     src/section_list.txt             |   1 +
>>>>>     src/toc.md                       |   1 +
>>>>>     5 files changed, 158 insertions(+), 2 deletions(-)
>>>>>     create mode 100644 src/hardening.md
>>>>> diff --git a/src/hardening.md b/src/hardening.md
>>>>> new file mode 100644
>>>>> index 0000000..031e7c1
>>>>> --- /dev/null
>>>>> +++ b/src/hardening.md
>>>>> @@ -0,0 +1,154 @@
>>>>> +# Hardening SELinux
>>>>> +
>>>>> +- [Tuning Booleans](#tuning-booleans)
>>>>> +- [Disabling Modules](#disabling-modules)
>>>>> +- [Users and Roles](#users-and-roles)
>>>>> +- [Network Controls](#network-controls)
>>>>> +- [Custom Policy Modules](#custom-policy-modules)
>>>>> +- [Fine Grained Network Controls](#fine-grained-network-controls)
>>>>> +- [Fully Custom Policy](#fully-custom-policy)
>>>>> +
>>>>> +The Reference Policy sets a good basis for learning how to operate a
>>>>> +system with SELinux. The policy allows system administrators and users
>>>>> +to continue using working methods that they learned before becoming
>>>>> +familiar with SELinux, because of its "targeted" model and reasonable
>>>>> +defaults.
>>>>> +
>>>>> +However, it's possible to tighten the policy considerably. The
>>>>> +Reference Policy gives several options for hardening but for maximum
>>>>> +control over the policy, it's possible to write custom modules or even
>>>>> +replace the Reference Policy entirely.
>>>>> +
>>>>> +The hardening suggestions are listed in the rough order of difficulty.
>>>>> +
>>>>> +## Tuning Booleans
>>>>> +
>>>>> +The Reference Policy uses booleans to control optional aspects of the
>>>>> +policy. Changing the booleans is very easy way to tune the SELinux
>>>>> +policy. The booleans can be also changed temporarily, without
>>>>> +committing them yet to the on-disk policy, so changes are
>>>>> +automatically reverted on next boot.
>>>>
>>>> "...changing the booleans is *a* very easy..."
>>>>
>>>>> +
>>>>> +For example, recent Firefox browsers can work with policy boolean
>>>>> +`mozilla_execstack` set to `off`. This can reduce the surface to
>>>>> +vulnerabilities which could use an executable stack. The boolean can
>>>>> +be changed using ***setsebool**(8)*:
>>>>> +
>>>>> +```
>>>>> +# Check current status:
>>>>> +getsebool mozilla_execstack
>>>>> +mozilla_execstack --> on
>>>>> +
>>>>> +# Change temporarily:
>>>>> +setsebool mozilla_execstack=off
>>>>> +
>>>>> +# Write to persistent policy on disk:
>>>>> +setsebool -P mozilla_execstack=off
>>>>> +
>>>>> +```
>>>>> +
>>>>> +## Disabling Modules
>>>>> +
>>>>> +By default, the Reference Policy enables most policy modules to
>>>>> +support any system. But when the system is known well by the
>>>>> +administrator, it's possible to remove modules which aren't used.
>>> It is better to just disable module that you do not use as removing
>>> the
>>> modules probably causes them to be reinstalled on policy upgrades and
>>> thus be re-enabled. This is likely not what one would expect.
>>
>> Post-install script in Debian package checks for both removed and
>> disabled modules and tries to keep the state same after package
>> upgrade. Is this not the case for other distros? I haven't had
>> problems with upgrading the package with lots of removed modules.
>>
> 
> https://salsa.debian.org/selinux-team/refpolicy/-/blob/debian/debian/postinst.policy
> 
> I might be overlooking it but i think its the other way around (if youre
> refering to this clause:
> 
> "	# Now build a list of the modules that we were shipping before but that we are not
> 	# anymore and that we need to remove
> "
> 
> How would the script know that you manually removed a module that it
> previously installed?

You're right, the removed modules are restored after reinstalling, 
disabled modules stay disabled. I had probably forgotten the extent of 
my hacked package.

Maybe the install script could choose to never install any modules which 
aren't present in the system, but then the users would miss any newly 
written modules. The pre-install script would probably need to record 
before installation which modules are removed (vs. then available 
modules) and then post-install could use this list to avoid installing them.

-Topi

> 
>>>
>>>>> +
>>>>> +As an example, if Firefox isn't installed, the module `mozilla` can be
>>>>> +removed from the policy. The hardening effect comes from reducing the
>>>>> +allow rules, some of which may apply to paths which aren't actively
>>>>> +monitored because the corresponding application isn't installed.
>>>>> +
>>>>> +Care should be taken to never remove modules which actually are used,
>>>>> +since this may weaken the policy instead, because the removed module
>>>>> +could have contained an application more strictly than what the policy
>>>>> +allows without the module. Removing critical modules can also result
>>>>> +in system breakage.
>>>>> +
>>>>> +## Users and Roles
>>>>> +
>>>>> +In the "targeted" model, both unprivileged users and the system
>>>>> +administrator (`root`) are unconfined and the TE rules are very
>>>>> +relaxed. However, it's possible to change the SELinux user for these
>>>>> +accounts to more confined variants.
>>>>> +
>>>>> +For the unprivileged users, the confined user in the Reference Policy
>>>>> +is `user_u` with corresponding role `user_r`. There's also `staff_u`
>>>>> +and `staff_r` to allow transitioning to system administrative roles by
>>>>> +logging in as `staff_u:staff_r` and escalating to `staff_u:sysadm_r`
>>>>> +or another role for administrative tasks with ***newrole**(1)*.
>>>>> +
>>>>> +For the system administrator there are several options: `root` SELinux
>>>>> +user, which is mostly unconfined and `sysadm_u`, which is more
>>>>> +confined. The role for both is `sysadm_r`.
>>>>> +
>>>>> +It's also possible to divide the powers of the system administrator to
>>>>> +several roles, `sysadm_r`, `auditadm_r`, `logadm_r`, `dbadm_r` and
>>>>> +`secadm_r`. This can be useful when an organization wants to ensure
>>>>> +that even the system administrators can be held accountable for their
>>>>> +actions. The roles can be also useful for management of labor, for
>>>>> +example having dedicated persons for managing databases or SELinux
>>>>> +policies.
>>>>> +
>>>>> +It should be noted that since this isn't the default way of operating
>>>>> +SELinux, the Reference Policy may need to supplemented and the
>>> there is some thing not right here: "the Reference Policy may need
>>> to supplemented"
>>
>> Right, "need to be supplemented".
>>
>>>
>>>>> +administrators, even users, may need to be more aware of SELinux in
>>>>> +order to be able to operate the system.
>>>>> +
>>>>> +## Network Controls
>>>>> +
>>>>> +With network controls of SELinux, it's possible to enhance firewall
>>>>> +rules with knowledge of SELinux types. Traditional firewall rules only
>>>>> +affect the whole system by allowing certain ports and protocols but
>>>>> +blocking others. With `nftables` and `iptables` it's also possible to
>>>>> +make this more fine grained: certain users can access network but
>>>>> +others may not. By using also SELinux controls it's possible to fine
>>>>> +tune this to application level: `mozilla_t` can connect to the
>>>>> +Internet but some other applications can't. SELinux packet controls
>>>>> +can be also used to combine Deep Packet Inspection with SELinux TE
>>>>> +rules.
>>>>
>>>> "...can access *the* network..."
>>>>
>>>> "By also using SELinux..."
>>>>
>>>> "...fine tune this to *the* application level..."
>>>>
>>>>> +
>>>>> +## Custom Policy Modules
>>>>> +
>>>>> +Further hardening can be achieved by replacing policy modules from the
>>>>> +Reference Policy with custom modules. Typically the modules in the
>>>>> +Reference Policy are written to allow all possible modes of operation
>>>>> +for an application or its users, since the writers of the policy don't
>>>>> +know the specifics of each installation. Thus the SELinux rules may be
>>>>> +more relaxed than what could be optimal for a specific case. When the
>>>>> +exact environment and usage patterns are known, it's possible to write
>>>>> +replacement policy modules to remove excess rules and hence reduce
>>>>> +attack surface.
>>>>> +
>>>>> +As a minimum, it should be ensured that all continuously running
>>>>> +services and main user applications have a dedicated policy module or
>>>>> +rules, instead of running in for example `init_t`, `initrc_t` or
>>>>> +`unconfined_t` types which may offer low level of protection.
>>>>> +
>>>>> +## Fine Grained Network Controls
>>>>> +
>>>>> +In an internal network of an organization, where all entities can
>>>>> +agree on the same SELinux policy, using IPSec, CIPSO and CALIPSO may
>>>>> +allow further policy controls. In addition to SELinux domain of the
>>>>> +source application, even the SELinux domain (or at least MCS/MLS
>>>>> +category/sensitivity) of the target server can be used in TE rules.
>>>>> +
>>>>> +## Fully Custom Policy
>>>>> +
>>>>> +It's also possible to write custom SELinux policies for an entire
>>>>> +system with non-trivial effort.
>>>>> +
>>>>> +The rules can also be analyzed with various SELinux tools, such as
>>>>> +`apol`, `sedta`, `sepolicy` and many more. With the tools it may be
>>> those arent exactly the tools that come to mind first here,
>>> especially
>>> not `sepolicy`. I would first and foremost mention `seinfo` and
>>> `sesearch`.
>>
>> Those are great too. Though there's also Appendix C and many manual
>> pages would also benefit from examples.
>>
>>> It would be nice if this doc would have some examples. It should not
>>> be
>>> hard since the doc targets refpolicy.
>>
>> Yes, more examples would be great. I'll try to add some more here.
>>
>> -Topi
>>
>>>
>>>>> +possible to find hardening opportunities or errors in the policy.
>>>>> +
>>>>> +The downside of making the SELinux rules as tight as possible is that
>>>>> +when the applications (or hardware components or network
>>>>> +configuration) are updated, there's a possibility that the rules may
>>>>> +also need updating because of the changes. Less generic rules are also
>>>>> +less generally useful for different configurations, so the rules may
>>>>> +need tuning for each installation.
>>>>> +
>>>>> +<!-- %CUTHERE% -->
>>>>> +
>>>>> +---
>>>>> +**[[ PREV ]](reference_policy.md)** **[[ TOP ]](#)** **[[ NEXT ]](implementing_seaware_apps.md)**
>>>>> diff --git a/src/implementing_seaware_apps.md b/src/implementing_seaware_apps.md
>>>>> index 74833f8..2351421 100644
>>>>> --- a/src/implementing_seaware_apps.md
>>>>> +++ b/src/implementing_seaware_apps.md
>>>>> @@ -297,4 +297,4 @@ applied to their objects as defined by policy.
>>>>>     <!-- %CUTHERE% -->
>>>>>       ---
>>>>> -**[[ PREV ]](reference_policy.md)** **[[ TOP ]](#)** **[[ NEXT ]](embedded_systems.md)**
>>>>> +**[[ PREV ]](hardening.md)** **[[ TOP ]](#)** **[[ NEXT ]](embedded_systems.md)**
>>>>> diff --git a/src/reference_policy.md b/src/reference_policy.md
>>>>> index 45e4145..ebb516f 100644
>>>>> --- a/src/reference_policy.md
>>>>> +++ b/src/reference_policy.md
>>>>> @@ -3060,4 +3060,4 @@ section.
>>>>>     <!-- %CUTHERE% -->
>>>>>       ---
>>>>> -**[[ PREV ]](modular_policy_statements.md)** **[[ TOP ]](#)** **[[ NEXT ]](implementing_seaware_apps.md)**
>>>>> +**[[ PREV ]](modular_policy_statements.md)** **[[ TOP ]](#)** **[[ NEXT ]](hardening.md)**
>>>>> diff --git a/src/section_list.txt b/src/section_list.txt
>>>>> index dcca883..b67f65e 100644
>>>>> --- a/src/section_list.txt
>>>>> +++ b/src/section_list.txt
>>>>> @@ -52,6 +52,7 @@ infiniband_statements.md
>>>>>     xen_statements.md
>>>>>     modular_policy_statements.md
>>>>>     reference_policy.md
>>>>> +hardening.md
>>>>>     implementing_seaware_apps.md
>>>>>     embedded_systems.md
>>>>>     seandroid.md
>>>>> diff --git a/src/toc.md b/src/toc.md
>>>>> index f5778bd..20a87f0 100644
>>>>> --- a/src/toc.md
>>>>> +++ b/src/toc.md
>>>>> @@ -53,6 +53,7 @@
>>>>>         - [XEN Statements](xen_statements.md#xen-statements)
>>>>>         - [Modular Policy Support Statements](modular_policy_statements.md#modular-policy-support-statements)
>>>>>     - [The Reference Policy](reference_policy.md#the-reference-policy)
>>>>> +- [Hardening SELinux](hardening.md#hardening-selinux)
>>>>>     - [Implementing SELinux-aware Applications](implementing_seaware_apps.md#implementing-selinux-aware-applications)
>>>>>     - [Embedded Systems](embedded_systems.md#embedded-systems)
>>>>>     - [SE for Android](seandroid.md#security-enhancements-for-android)
>>>>>
>>>>
>>>> -Daniel
>>>>
>>>
>>
> 

