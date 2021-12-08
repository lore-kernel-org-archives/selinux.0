Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 127CCC433EF
	for <selinux@archiver.kernel.org>; Wed,  8 Dec 2021 20:55:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234770AbhLHU7D (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 8 Dec 2021 15:59:03 -0500
Received: from linux.microsoft.com ([13.77.154.182]:41330 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232827AbhLHU7D (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 8 Dec 2021 15:59:03 -0500
Received: from [192.168.1.10] (pool-173-66-191-184.washdc.fios.verizon.net [173.66.191.184])
        by linux.microsoft.com (Postfix) with ESMTPSA id C63EB20B7179;
        Wed,  8 Dec 2021 12:55:30 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C63EB20B7179
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1638996931;
        bh=aFnZQ5fPNpVjGg9laMJYYRnZVIBuU2xiY3Anl/jl5w4=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=hh9q2mwcb9v/rfwRK4oak218l2bisxFrsZ6V2W7bVZ+pO5Irge070PaQ0WffBzj1c
         VcJmebPgLFUWNaXqEquXx07plbZmkyd7zPghWmHde6q1K3WZFc62vN3bpjmnFrKMkM
         0xNUQEB4YRuQsZCCU//WxwIHg9ZZ56dBMRFaWrhQ=
Message-ID: <a3f6d680-92c6-b49b-3e86-600c30e99949@linux.microsoft.com>
Date:   Wed, 8 Dec 2021 15:55:24 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH v3] selinux-notebook: New chapter: Hardening SELinux
Content-Language: en-US
To:     Topi Miettinen <toiwoton@gmail.com>, selinux@vger.kernel.org
References: <20211116105335.21864-1-toiwoton@gmail.com>
From:   Daniel Burgener <dburgener@linux.microsoft.com>
In-Reply-To: <20211116105335.21864-1-toiwoton@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 11/16/2021 5:53 AM, Topi Miettinen wrote:
> Describe some easy and more difficult methods to harden SELinux
> policies.
> 
> Signed-off-by: Topi Miettinen <toiwoton@gmail.com>
> 
> ---

[snip]

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
> +SELinux, the Reference Policy may need to be supplemented and the
> +administrators, even users, may need to be more aware of SELinux in
> +order to be able to operate the system.
> +
> +Example:
> +```
> +# User `test` has beed added earlier with `adduser` or `useradd`.
> +semanage login --add --seuser user_u --range 's0' test
> +```

s/beed/been/


Looks good to me other than that.

FWIW:

Reviewed-by: Daniel Burgener <dburgener@linux.microsoft.com>
