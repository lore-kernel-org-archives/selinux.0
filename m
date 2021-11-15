Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 317BFC433FE
	for <selinux@archiver.kernel.org>; Mon, 15 Nov 2021 17:41:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D4FF63386
	for <selinux@archiver.kernel.org>; Mon, 15 Nov 2021 17:41:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237839AbhKORol (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 15 Nov 2021 12:44:41 -0500
Received: from linux.microsoft.com ([13.77.154.182]:59848 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238581AbhKORmM (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 15 Nov 2021 12:42:12 -0500
Received: from [192.168.1.10] (pool-173-66-191-184.washdc.fios.verizon.net [173.66.191.184])
        by linux.microsoft.com (Postfix) with ESMTPSA id 8CFD520C5A71;
        Mon, 15 Nov 2021 09:39:16 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8CFD520C5A71
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1636997956;
        bh=/5NRXHskFDrqGVtCx615Bf/FAFO0ixMaXI20Vh0jk4I=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=pcGRtDH58a8qD6Df9iDfT9GqpvVBMBD3x21BaLHDSok64FIqGo0K+4jyntc9sbtwx
         fIVpNqAJYIvk6eojmZYV/MJDg1DTVv9HdO1wSgRcBZFExqysOVc5Pc+w3wTmubnxHp
         r+TdRmjGi3hmaBjO7Mgy0XytKUrh08+BJOxeHzQM=
Message-ID: <7ee0207f-5be9-5050-0baa-f59d27b617a9@linux.microsoft.com>
Date:   Mon, 15 Nov 2021 12:39:16 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH v2] selinux-notebook: New chapter: Hardening SELinux
Content-Language: en-US
To:     Topi Miettinen <toiwoton@gmail.com>, selinux@vger.kernel.org
References: <20211113095547.19406-1-toiwoton@gmail.com>
From:   Daniel Burgener <dburgener@linux.microsoft.com>
In-Reply-To: <20211113095547.19406-1-toiwoton@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

This looks great!  I found a few more typos on this readthrough, 
enumerated below.

On 11/13/2021 4:55 AM, Topi Miettinen wrote:
> Describe some easy and more difficult methods to harden SELinux
> policies.
> 
> Signed-off-by: Topi Miettinen <toiwoton@gmail.com>
> 
> ---
> v2:
>   - Updated with comments from Daniel Burgener
>   - Fixed issues with PDF generation
> ---
>   src/hardening.md                 | 154 +++++++++++++++++++++++++++++++
>   src/implementing_seaware_apps.md |   2 +-
>   src/reference_policy.md          |   2 +-
>   src/section_list.txt             |   1 +
>   src/toc.md                       |   1 +
>   5 files changed, 158 insertions(+), 2 deletions(-)
>   create mode 100644 src/hardening.md
> 
> diff --git a/src/hardening.md b/src/hardening.md
> new file mode 100644
> index 0000000..031e7c1
> --- /dev/null
> +++ b/src/hardening.md
> @@ -0,0 +1,154 @@
> +# Hardening SELinux
> +
> +- [Tuning Booleans](#tuning-booleans)
> +- [Disabling Modules](#disabling-modules)
> +- [Users and Roles](#users-and-roles)
> +- [Network Controls](#network-controls)
> +- [Custom Policy Modules](#custom-policy-modules)
> +- [Fine Grained Network Controls](#fine-grained-network-controls)
> +- [Fully Custom Policy](#fully-custom-policy)
> +
> +The Reference Policy sets a good basis for learning how to operate a
> +system with SELinux. The policy allows system administrators and users
> +to continue using working methods that they learned before becoming
> +familiar with SELinux, because of its "targeted" model and reasonable
> +defaults.
> +
> +However, it's possible to tighten the policy considerably. The
> +Reference Policy gives several options for hardening but for maximum
> +control over the policy, it's possible to write custom modules or even
> +replace the Reference Policy entirely.
> +
> +The hardening suggestions are listed in the rough order of difficulty.
> +
> +## Tuning Booleans
> +
> +The Reference Policy uses booleans to control optional aspects of the
> +policy. Changing the booleans is very easy way to tune the SELinux
> +policy. The booleans can be also changed temporarily, without
> +committing them yet to the on-disk policy, so changes are
> +automatically reverted on next boot.

"...changing the booleans is *a* very easy..."

> +
> +For example, recent Firefox browsers can work with policy boolean
> +`mozilla_execstack` set to `off`. This can reduce the surface to
> +vulnerabilities which could use an executable stack. The boolean can
> +be changed using ***setsebool**(8)*:
> +
> +```
> +# Check current status:
> +getsebool mozilla_execstack
> +mozilla_execstack --> on
> +
> +# Change temporarily:
> +setsebool mozilla_execstack=off
> +
> +# Write to persistent policy on disk:
> +setsebool -P mozilla_execstack=off
> +
> +```
> +
> +## Disabling Modules
> +
> +By default, the Reference Policy enables most policy modules to
> +support any system. But when the system is known well by the
> +administrator, it's possible to remove modules which aren't used.
> +
> +As an example, if Firefox isn't installed, the module `mozilla` can be
> +removed from the policy. The hardening effect comes from reducing the
> +allow rules, some of which may apply to paths which aren't actively
> +monitored because the corresponding application isn't installed.
> +
> +Care should be taken to never remove modules which actually are used,
> +since this may weaken the policy instead, because the removed module
> +could have contained an application more strictly than what the policy
> +allows without the module. Removing critical modules can also result
> +in system breakage.
> +
> +## Users and Roles
> +
> +In the "targeted" model, both unprivileged users and the system
> +administrator (`root`) are unconfined and the TE rules are very
> +relaxed. However, it's possible to change the SELinux user for these
> +accounts to more confined variants.
> +
> +For the unprivileged users, the confined user in the Reference Policy
> +is `user_u` with corresponding role `user_r`. There's also `staff_u`
> +and `staff_r` to allow transitioning to system administrative roles by
> +logging in as `staff_u:staff_r` and escalating to `staff_u:sysadm_r`
> +or another role for administrative tasks with ***newrole**(1)*.
> +
> +For the system administrator there are several options: `root` SELinux
> +user, which is mostly unconfined and `sysadm_u`, which is more
> +confined. The role for both is `sysadm_r`.
> +
> +It's also possible to divide the powers of the system administrator to
> +several roles, `sysadm_r`, `auditadm_r`, `logadm_r`, `dbadm_r` and
> +`secadm_r`. This can be useful when an organization wants to ensure
> +that even the system administrators can be held accountable for their
> +actions. The roles can be also useful for management of labor, for
> +example having dedicated persons for managing databases or SELinux
> +policies.
> +
> +It should be noted that since this isn't the default way of operating
> +SELinux, the Reference Policy may need to supplemented and the
> +administrators, even users, may need to be more aware of SELinux in
> +order to be able to operate the system.
> +
> +## Network Controls
> +
> +With network controls of SELinux, it's possible to enhance firewall
> +rules with knowledge of SELinux types. Traditional firewall rules only
> +affect the whole system by allowing certain ports and protocols but
> +blocking others. With `nftables` and `iptables` it's also possible to
> +make this more fine grained: certain users can access network but
> +others may not. By using also SELinux controls it's possible to fine
> +tune this to application level: `mozilla_t` can connect to the
> +Internet but some other applications can't. SELinux packet controls
> +can be also used to combine Deep Packet Inspection with SELinux TE
> +rules.

"...can access *the* network..."

"By also using SELinux..."

"...fine tune this to *the* application level..."

> +
> +## Custom Policy Modules
> +
> +Further hardening can be achieved by replacing policy modules from the
> +Reference Policy with custom modules. Typically the modules in the
> +Reference Policy are written to allow all possible modes of operation
> +for an application or its users, since the writers of the policy don't
> +know the specifics of each installation. Thus the SELinux rules may be
> +more relaxed than what could be optimal for a specific case. When the
> +exact environment and usage patterns are known, it's possible to write
> +replacement policy modules to remove excess rules and hence reduce
> +attack surface.
> +
> +As a minimum, it should be ensured that all continuously running
> +services and main user applications have a dedicated policy module or
> +rules, instead of running in for example `init_t`, `initrc_t` or
> +`unconfined_t` types which may offer low level of protection.
> +
> +## Fine Grained Network Controls
> +
> +In an internal network of an organization, where all entities can
> +agree on the same SELinux policy, using IPSec, CIPSO and CALIPSO may
> +allow further policy controls. In addition to SELinux domain of the
> +source application, even the SELinux domain (or at least MCS/MLS
> +category/sensitivity) of the target server can be used in TE rules.
> +
> +## Fully Custom Policy
> +
> +It's also possible to write custom SELinux policies for an entire
> +system with non-trivial effort.
> +
> +The rules can also be analyzed with various SELinux tools, such as
> +`apol`, `sedta`, `sepolicy` and many more. With the tools it may be
> +possible to find hardening opportunities or errors in the policy.
> +
> +The downside of making the SELinux rules as tight as possible is that
> +when the applications (or hardware components or network
> +configuration) are updated, there's a possibility that the rules may
> +also need updating because of the changes. Less generic rules are also
> +less generally useful for different configurations, so the rules may
> +need tuning for each installation.
> +
> +<!-- %CUTHERE% -->
> +
> +---
> +**[[ PREV ]](reference_policy.md)** **[[ TOP ]](#)** **[[ NEXT ]](implementing_seaware_apps.md)**
> diff --git a/src/implementing_seaware_apps.md b/src/implementing_seaware_apps.md
> index 74833f8..2351421 100644
> --- a/src/implementing_seaware_apps.md
> +++ b/src/implementing_seaware_apps.md
> @@ -297,4 +297,4 @@ applied to their objects as defined by policy.
>   <!-- %CUTHERE% -->
>   
>   ---
> -**[[ PREV ]](reference_policy.md)** **[[ TOP ]](#)** **[[ NEXT ]](embedded_systems.md)**
> +**[[ PREV ]](hardening.md)** **[[ TOP ]](#)** **[[ NEXT ]](embedded_systems.md)**
> diff --git a/src/reference_policy.md b/src/reference_policy.md
> index 45e4145..ebb516f 100644
> --- a/src/reference_policy.md
> +++ b/src/reference_policy.md
> @@ -3060,4 +3060,4 @@ section.
>   <!-- %CUTHERE% -->
>   
>   ---
> -**[[ PREV ]](modular_policy_statements.md)** **[[ TOP ]](#)** **[[ NEXT ]](implementing_seaware_apps.md)**
> +**[[ PREV ]](modular_policy_statements.md)** **[[ TOP ]](#)** **[[ NEXT ]](hardening.md)**
> diff --git a/src/section_list.txt b/src/section_list.txt
> index dcca883..b67f65e 100644
> --- a/src/section_list.txt
> +++ b/src/section_list.txt
> @@ -52,6 +52,7 @@ infiniband_statements.md
>   xen_statements.md
>   modular_policy_statements.md
>   reference_policy.md
> +hardening.md
>   implementing_seaware_apps.md
>   embedded_systems.md
>   seandroid.md
> diff --git a/src/toc.md b/src/toc.md
> index f5778bd..20a87f0 100644
> --- a/src/toc.md
> +++ b/src/toc.md
> @@ -53,6 +53,7 @@
>       - [XEN Statements](xen_statements.md#xen-statements)
>       - [Modular Policy Support Statements](modular_policy_statements.md#modular-policy-support-statements)
>   - [The Reference Policy](reference_policy.md#the-reference-policy)
> +- [Hardening SELinux](hardening.md#hardening-selinux)
>   - [Implementing SELinux-aware Applications](implementing_seaware_apps.md#implementing-selinux-aware-applications)
>   - [Embedded Systems](embedded_systems.md#embedded-systems)
>   - [SE for Android](seandroid.md#security-enhancements-for-android)
> 

-Daniel
