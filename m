Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C3E9C74A5B
	for <selinux@archiver.kernel.org>; Fri, 17 Mar 2023 20:25:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229903AbjCQUZ0 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 17 Mar 2023 16:25:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbjCQUZZ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 17 Mar 2023 16:25:25 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F09AB521C5;
        Fri, 17 Mar 2023 13:25:24 -0700 (PDT)
Received: from [192.168.1.10] (pool-96-241-71-43.washdc.fios.verizon.net [96.241.71.43])
        by linux.microsoft.com (Postfix) with ESMTPSA id 272BF2057675;
        Fri, 17 Mar 2023 13:25:24 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 272BF2057675
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1679084724;
        bh=/Ke63LxewfrLPtmCkRrWSwC3rWH2JiWgvhPd+4b5WHw=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=ZTSMguaac9oPl/i+Oy92Y2PFQyPYnZMfOtjV3X99+BllqLH4qQ2V6gNaJjvRi4Bkw
         /LKxKLf42jVKfPpy2GkvKV6pMJrvXip321YIWOYgnIEou8Vx/dRmZAE1XYZW39fu34
         1pt5TB1bhiLs8mD8wPyQN4gFw76CRqTwjMNAYzZE=
Message-ID: <7b02ffaa-d9ce-d75d-1078-cd1691f1230f@linux.microsoft.com>
Date:   Fri, 17 Mar 2023 16:25:18 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] selinux: remove the runtime disable functionality
To:     Paul Moore <paul@paul-moore.com>, selinux@vger.kernel.org,
        linux-security-module@vger.kernel.org
References: <20230317195615.281810-1-paul@paul-moore.com>
Content-Language: en-US
From:   Daniel Burgener <dburgener@linux.microsoft.com>
In-Reply-To: <20230317195615.281810-1-paul@paul-moore.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 3/17/2023 3:56 PM, Paul Moore wrote:
> --- a/Documentation/ABI/obsolete/sysfs-selinux-disable
> +++ b/Documentation/ABI/removed/sysfs-selinux-disable
> @@ -4,6 +4,9 @@ KernelVersion:	2.6.12-rc2 (predates git)
>   Contact:	selinux@vger.kernel.org
>   Description:
>   
> +	REMOVAL UPDATE: The SELinux checkreqprot functionality was removed in
> +	March 2023, the original deprecation notice is shown below.
> +
>   	The selinuxfs "disable" node allows SELinux to be disabled at runtime
>   	prior to a policy being loaded into the kernel.  If disabled via this
>   	mechanism, SELinux will remain disabled until the system is rebooted.

Looks like a copy/paste typo from the other deprecation removal.  I 
assume this should mention runtime disable, rather than checkreqprot.

-Daniel

