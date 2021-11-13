Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB2DBC433F5
	for <selinux@archiver.kernel.org>; Sat, 13 Nov 2021 08:23:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A5CC61075
	for <selinux@archiver.kernel.org>; Sat, 13 Nov 2021 08:23:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232925AbhKMI01 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 13 Nov 2021 03:26:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230095AbhKMI01 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sat, 13 Nov 2021 03:26:27 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 158C6C061766
        for <selinux@vger.kernel.org>; Sat, 13 Nov 2021 00:23:35 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id p16so28351447lfa.2
        for <selinux@vger.kernel.org>; Sat, 13 Nov 2021 00:23:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=KPaSO/JS0oAv7NlM6+be0LPgLmm8Y4ceTil3/98dpgg=;
        b=A3c9vpP0BDHDlm5dQwLreMoeyaQiEt7d7XL2rh0kQhIHBRmdOuqBd/5PG9V6YIQ9Rt
         N4RKzQwBdu8xRIcbb5wmLgk/C7ENQ1eb1/6svwQt3K7tZp2NEJdMgaSZstmRo+EL2HU6
         9mR5akoakWSqQ1r8EJE6tzoEFLgZie14PyUMqcPsPodDBIi66tj2I2EUHP3oqDCijqRX
         2a3q4E6XN7a2TH5/w14+uqT+jp4NKsly5xQ90CwOkjqvPns5li0EPvx61jorqEEwHJ9D
         wOjeEAtW3wXvuXdMT5pTucrrT4A6umxzP/YhqT6ffypCp0vg0rIyuaHIUd/C0m10tuCF
         BAuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KPaSO/JS0oAv7NlM6+be0LPgLmm8Y4ceTil3/98dpgg=;
        b=XgBI1N2FAElIfSKfGeslROi5TWp73B4ByWAsGdIQne5Isu2jY3REvpeWKHeHC/fmzQ
         aEQ0H3bxXt/1Bj4QQG9GNtvo/VsrUeKvzfxPfc1fA58SXDpOrm1icPMxmR7TgWHEHJkG
         9fmUDiJJu7tU9Bcyw3rJl3IAEptp9Z+A5SGcN9V1y86qS8fp8GduzgM/8SgduRwcpHET
         +16CIMdbt+5GIYxrt8gjr9TOAgMLfilGce0uXFOo1ArWhRWG5q9MnrnmmedbP+SH4vGP
         Q8U0SkBiB7sJPk9NVF4w3uI0oI3gUpBhWvoqyITog6/A5kV9Oofr5NmAKnYheMUnl3AY
         SEGQ==
X-Gm-Message-State: AOAM531QbFDowI0YQhoEX00/oLY8DCPrHojndbadYfehFLhUePKqML/q
        6oLGPlzxU0slyM+k9gCqA1VVwzuiOU4=
X-Google-Smtp-Source: ABdhPJwOXOu99b0zJZTJwVJNTdYeVKcvyy4DvYhJaNswi5Aei2zKImAD7NbHX4VlictuUugSHwjZ4w==
X-Received: by 2002:ac2:46c8:: with SMTP id p8mr1838856lfo.174.1636791812961;
        Sat, 13 Nov 2021 00:23:32 -0800 (PST)
Received: from [192.168.1.37] (81-197-199-108.elisa-laajakaista.fi. [81.197.199.108])
        by smtp.gmail.com with ESMTPSA id y3sm764026ljg.47.2021.11.13.00.23.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Nov 2021 00:23:32 -0800 (PST)
Subject: Re: [PATCH] selinux-notebook: New chapter: Hardening SELinux
To:     Daniel Burgener <dburgener@linux.microsoft.com>,
        selinux@vger.kernel.org
References: <20211112125605.28915-1-toiwoton@gmail.com>
 <e57d27ce-1d95-01b8-8439-23280eafbc53@linux.microsoft.com>
From:   Topi Miettinen <toiwoton@gmail.com>
Message-ID: <c9bdaee9-66ec-f947-a053-31a5177e2b31@gmail.com>
Date:   Sat, 13 Nov 2021 10:23:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <e57d27ce-1d95-01b8-8439-23280eafbc53@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 12.11.2021 17.05, Daniel Burgener wrote:
> On 11/12/2021 7:56 AM, Topi Miettinen wrote:
>> Describe some easy and more difficult methods to harden SELinux
>> policies.
>>
>> Signed-off-by: Topi Miettinen <toiwoton@gmail.com>
>> ---
>>   src/hardening.md                 | 127 +++++++++++++++++++++++++++++++
>>   src/implementing_seaware_apps.md |   2 +-
>>   src/reference_policy.md          |   2 +-
>>   src/toc.md                       |   1 +
>>   4 files changed, 130 insertions(+), 2 deletions(-)
>>   create mode 100644 src/hardening.md
>>
>> diff --git a/src/hardening.md b/src/hardening.md
>> new file mode 100644
>> index 0000000..fa39776
>> --- /dev/null
>> +++ b/src/hardening.md
>> @@ -0,0 +1,127 @@
>> +# Hardening SELinux
>> +
>> +- [Reference Policy](#reference-policy)
>> +- [Custom Policy](#custom-policy)
>> +
>> +The Reference Policy sets a good basis for learning how to operate a
>> +system with SELinux. The policy allows the system administrators and
>> +users to continue using the working methods learned from time before
>> +familiarizing with SELinux, because of its "targeted" model and
>> +reasonable defaults.
> 
> There's something slightly awkwardly worded in this sentence.  Maybe 
> "The policy allows system administrators and users to continue using 
> working methods that they learned before becoming familiar with SELinux"?

I'd like to keep the reference to targeted model etc, so how about:
"The policy allows system administrators and users to continue using
working methods that they learned before becoming familiar with SELinux, 
because of its "targeted" model and reasonable defaults."?

>> +
>> +However, it's possible to tighten the policy considerably. The
>> +Reference Policy gives several options for hardening but for maximum
>> +control over the policy, it's possible to write custom modules or even
>> +replace the Reference Policy entirely.
>> +
>> +## Reference Policy
>> +
>> +The hardening suggestions are listed in the rough order of difficulty.
>> +
>> +### Booleans
>> +
>> +The Reference Policy uses booleans to control optional aspects of the
>> +policy. Changing the booleans is very easy way to tune the SELinux
>> +policy. The booleans can be also changed temporarily, without
>> +committing them yet to the on-disk policy, so changes are
>> +automatically reverted on next boot.
>> +
>> +For example, recent Firefox browsers can work with policy boolean
>> +`mozilla_execstack` set to `off`. This can reduce the surface to
>> +vulnerabilities which could use an executable stack.
> 
> It might be helpful to include a sample setsebool command here?

Yes, I'll add one.

>> +
>> +### Disabling Modules
>> +
>> +By default, the Reference Policy enables most policy modules to
>> +support any system. But when the system is known well by the
>> +administrator, it's possible to remove modules which aren't used.
>> +
>> +As an example, if Firefox isn't installed, module `mozilla` can be
>> +removed from the policy. The hardening effect comes from reducing the
>> +allow rules, some of which may apply to paths which aren't actively
>> +monitored because the corresponding application isn't installed.
> 
> *the* module mozilla
> 
>> +
>> +Care should be taken to never remove modules which actually are used,
>> +since this may weaken the policy instead, because the removed module
>> +could have contained an application more strictly than what the policy
>> +allows without the module.
> 
> It could also potentially result in system breakage.

Indeed, for example removing "unconfined" module is great source of fun. 
It's not impossible but needs a lot of supporting policy work.

>> +
>> +### Users and Roles
>> +
>> +In the "targeted" model, both unprivileged users and the system
>> +administrator (`root`) are unconfined and the TE rules are very
>> +relaxed. However, it's possible to change the SELinux user for these
>> +accounts to more confined variants.
>> +
>> +For the unprivileged users, the confined user in the Reference Policy
>> +is `user_u` with corresponding role `user_r`. There's also `staff_r`
>> +to allow transitioning to system administative roles.
> 
> administrative
> 
>> +
>> +For the system administrator there are several options: `root` SELinux
>> +user, which is mostly unconfied and `sysadm_u`, which is more
>> +confined. The role for both is `sysadm_r`.
> 
> unconfined
> 
> I would also suggest that logging root in as staff_u:staff_r and 
> escalating to staff_u:sysadm_r or another role for administrative tasks 
> would be a reasonable hardening step that could be more suitable for 
> many use cases.

Thanks, I'll ad that.

>> +
>> +It's also possible to divide the powers of the system administrator to
>> +several roles, `sysadm_r`, `auditadm_r`, `logadm_r`, `dbadm_r` and
>> +`secadm_r`. This can be useful when an organization wants to ensure
>> +that even the system administrators can be held accountable for their
>> +actions. The roles can be also useful for management of labor, for
>> +example having dedicated persons for managing databases or SELinux
>> +policies.
>> +
>> +It should be noted that since this isn't the default way of operating
>> +SELinux, the Reference Policy may need to supplemented and the
>> +administrators, even users, may need to be more aware of SELinux in
>> +order to be able to operate the system.
>> +
>> +### Network
>> +
>> +With network controls of SELinux, it's possible to enhance firewall
>> +rules with knowledge of SELinux types. Traditional firewall rules only
>> +affect the whole system by allowing certain ports and protocols but
>> +blocking others. With `nftables` and `iptables` it's also possible to
>> +make this more fine grained: certain users can access network but
>> +others may not. By using also SELinux controls it's possible to fine
>> +tune this to application level: `mozilla_t` can connect to the
>> +Internet but some other applications can't. SELinux packet controls
>> +can be also used to combine Deep Packet Inspection with SELinux TE
>> +rules.
>> +
>> +In an internal network of an organization, where all entities can
>> +agree on the same SELinux policy, using IPSec, CIPSO and CALIPSO may
>> +allow further policy controls. In addition to SELinux domain of the
>> +source application, even the SELinux domain (or at least MCS/MLS
>> +category/sensitivity) of the target server can be used in TE rules.
> 
> If the goal is escalating order of difficulty, I would say that using 
> fine grained network labeling is probably more difficult than "Custom 
> Policy", particularly because implementing it will probably require some 
> custom policy work.

Yes, though it will be less work than making a comprehensive whole 
system policy from scratch. I think I'll make three different chapters:

Custom Policy Modules
Network Labeling
Fully Custom Policy

>> +
>> +## Custom Policy
>> +
>> +Further hardening can be achieved by replacing policy modules from the
>> +Reference Policy with custom modules. Typically the modules in the
>> +Reference Policy are written to allow all possible modes of operation
>> +for an application or its users, since the writers of the policy don't
>> +know the specifics of each installation. Thus the SELinux rules may be
>> +more relaxed than what could be optimal for a specific case. When the
>> +exact environment and usage patterns are known, it's possible to write
>> +replacement policy modules to remove excess rules and hence reduce
>> +attack surface.
>> +
>> +As a minimum, it should be ensured that all continously running
>> +services and main user applications have a dedicated policy module or
>> +rules, instead of running in for example `init_t`, `initrc_t` or
>> +`unconfined_t` types which may offer low level of protection.
> 
> continuously
> 
>> +
>> +It's also possible to write custom SELinux policies for an entire
>> +system with non-trivial effort.
>> +
>> +The rules can also be analyzed with various SELinux tools, such as
>> +`apol`, `sedta`, `sepolicy` and many more. With the tools it may be
>> +possible to find hardening opportunities or errors in the policy.
>> +
>> +The downside of making the SELinux rules as tight as possible is that
>> +when the applications (or hardware components or network
>> +configuration) are updated, there's a possibility that the rules may
>> +also need updating because of the changes. Less generic rules are also
>> +less generally useful for different configurations, so the rules may
>> +need tuning for each installation.
>> +
>> +**[[ PREV ]](reference_policy.md)** **[[ TOP ]](#)** **[[ NEXT 
>> ]](implementing_seaware_apps.md)**
>> diff --git a/src/implementing_seaware_apps.md 
>> b/src/implementing_seaware_apps.md
>> index 74833f8..2351421 100644
>> --- a/src/implementing_seaware_apps.md
>> +++ b/src/implementing_seaware_apps.md
>> @@ -297,4 +297,4 @@ applied to their objects as defined by policy.
>>   <!-- %CUTHERE% -->
>>   ---
>> -**[[ PREV ]](reference_policy.md)** **[[ TOP ]](#)** **[[ NEXT 
>> ]](embedded_systems.md)**
>> +**[[ PREV ]](hardening.md)** **[[ TOP ]](#)** **[[ NEXT 
>> ]](embedded_systems.md)**
>> diff --git a/src/reference_policy.md b/src/reference_policy.md
>> index 45e4145..ebb516f 100644
>> --- a/src/reference_policy.md
>> +++ b/src/reference_policy.md
>> @@ -3060,4 +3060,4 @@ section.
>>   <!-- %CUTHERE% -->
>>   ---
>> -**[[ PREV ]](modular_policy_statements.md)** **[[ TOP ]](#)** **[[ 
>> NEXT ]](implementing_seaware_apps.md)**
>> +**[[ PREV ]](modular_policy_statements.md)** **[[ TOP ]](#)** **[[ 
>> NEXT ]](hardening.md)**
>> diff --git a/src/toc.md b/src/toc.md
>> index f5778bd..20a87f0 100644
>> --- a/src/toc.md
>> +++ b/src/toc.md
>> @@ -53,6 +53,7 @@
>>       - [XEN Statements](xen_statements.md#xen-statements)
>>       - [Modular Policy Support 
>> Statements](modular_policy_statements.md#modular-policy-support-statements) 
>>
>>   - [The Reference Policy](reference_policy.md#the-reference-policy)
>> +- [Hardening SELinux](hardening.md#hardening-selinux)
>>   - [Implementing SELinux-aware 
>> Applications](implementing_seaware_apps.md#implementing-selinux-aware-applications) 
>>
>>   - [Embedded Systems](embedded_systems.md#embedded-systems)
>>   - [SE for Android](seandroid.md#security-enhancements-for-android)
>>
> 
> -Daniel

Thank you for the review! I'll post an updated version soon.

-Topi
