Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F164C433F5
	for <selinux@archiver.kernel.org>; Tue, 11 Oct 2022 13:19:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230152AbiJKNTg (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 11 Oct 2022 09:19:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230145AbiJKNTN (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 11 Oct 2022 09:19:13 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7AE7497ED3
        for <selinux@vger.kernel.org>; Tue, 11 Oct 2022 06:17:19 -0700 (PDT)
Received: from [192.168.1.10] (pool-173-66-202-112.washdc.fios.verizon.net [173.66.202.112])
        by linux.microsoft.com (Postfix) with ESMTPSA id D7A1B20F06A6;
        Tue, 11 Oct 2022 06:16:50 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D7A1B20F06A6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1665494211;
        bh=zIeyvRDFvtX5rRaL7ugCoe0opmEm/N+OJnFNlZP5BeY=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=jbOr3sGsEvMMZmREekuTFS/i5Cqo3E7+POtHNo3DQGBfARzwMME/xZTBP26JbDiSe
         Kkq+dLjTgVhpCSPFnqMQLLBIXJnSiQWsv2trQSXLeuMDiTmDKZODmS7RLcxvzYARV+
         6taPkVUNmYP7jtftRiDDJiIn2yuXvMiTxBocyqV8=
Message-ID: <aad3cf91-53ed-e4aa-8009-2e7e6ea5ca89@linux.microsoft.com>
Date:   Tue, 11 Oct 2022 09:16:46 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH] libselinux: Add missing '\n' to avc_log() messages
To:     Petr Lautrbach <plautrba@redhat.com>, selinux@vger.kernel.org
References: <20221011112733.194079-1-plautrba@redhat.com>
Content-Language: en-US
From:   Daniel Burgener <dburgener@linux.microsoft.com>
In-Reply-To: <20221011112733.194079-1-plautrba@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 10/11/2022 7:27 AM, Petr Lautrbach wrote:
> Signed-off-by: Petr Lautrbach <plautrba@redhat.com>

Reviewed-by: Daniel Burgener <dburgener@linux.microsoft.com>

> ---
>   libselinux/src/avc.c          | 2 +-
>   libselinux/src/avc_internal.c | 4 ++--
>   libselinux/src/checkAccess.c  | 4 ++--
>   3 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/libselinux/src/avc.c b/libselinux/src/avc.c
> index 8d5983a2fe0c..98a3fcae41c8 100644
> --- a/libselinux/src/avc.c
> +++ b/libselinux/src/avc.c
> @@ -725,7 +725,7 @@ void avc_audit(security_id_t ssid, security_id_t tsid,
>   	if (denied)
>   		log_append(avc_audit_buf, " permissive=%u", result ? 0 : 1);
>   
> -	avc_log(SELINUX_AVC, "%s", avc_audit_buf);
> +	avc_log(SELINUX_AVC, "%s\n", avc_audit_buf);
>   
>   	avc_release_lock(avc_log_lock);
>   }
> diff --git a/libselinux/src/avc_internal.c b/libselinux/src/avc_internal.c
> index 71a1357bc564..c550e5788527 100644
> --- a/libselinux/src/avc_internal.c
> +++ b/libselinux/src/avc_internal.c
> @@ -59,7 +59,7 @@ int avc_process_setenforce(int enforcing)
>   	int rc = 0;
>   
>   	avc_log(SELINUX_SETENFORCE,
> -		"%s:  op=setenforce lsm=selinux enforcing=%d res=1",
> +		"%s:  op=setenforce lsm=selinux enforcing=%d res=1\n",
>   		avc_prefix, enforcing);
>   	if (avc_setenforce)
>   		goto out;
> @@ -81,7 +81,7 @@ int avc_process_policyload(uint32_t seqno)
>   	int rc = 0;
>   
>   	avc_log(SELINUX_POLICYLOAD,
> -		"%s:  op=load_policy lsm=selinux seqno=%u res=1",
> +		"%s:  op=load_policy lsm=selinux seqno=%u res=1\n",
>   		avc_prefix, seqno);
>   	rc = avc_ss_reset(seqno);
>   	if (rc < 0) {
> diff --git a/libselinux/src/checkAccess.c b/libselinux/src/checkAccess.c
> index 022cd6b5ecab..319af267c6a7 100644
> --- a/libselinux/src/checkAccess.c
> +++ b/libselinux/src/checkAccess.c
> @@ -44,7 +44,7 @@ int selinux_check_access(const char *scon, const char *tcon, const char *class,
>          sclass = string_to_security_class(class);
>          if (sclass == 0) {
>   	       rc = errno;
> -	       avc_log(SELINUX_ERROR, "Unknown class %s", class);
> +	       avc_log(SELINUX_ERROR, "Unknown class %s\n", class);
>   	       if (security_deny_unknown() == 0)
>   		       return 0;
>   	       errno = rc;
> @@ -54,7 +54,7 @@ int selinux_check_access(const char *scon, const char *tcon, const char *class,
>          av = string_to_av_perm(sclass, perm);
>          if (av == 0) {
>   	       rc = errno;
> -	       avc_log(SELINUX_ERROR, "Unknown permission %s for class %s", perm, class);
> +	       avc_log(SELINUX_ERROR, "Unknown permission %s for class %s\n", perm, class);
>   	       if (security_deny_unknown() == 0)
>   		       return 0;
>   	       errno = rc;

