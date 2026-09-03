Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 476463C13F8
	for <selinux@vger.kernel.org>; Thu,  3 Sep 2026 06:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788415827; cv=none; b=R2Vl0Wvd5bYv7HHFv1Fn9CgxiPpTJ9W5TOeNxJE/9ACEKUJykGBiyDNC6A7wUCGJZ3/+1HmX421kDqv3eX76FNwoE+KhRxgCjTwzvrP3C/tDLvR9vsRKLZGzhWt1xesreGtQ/07+hDR/YMNBN2WxUgS+vcgsP4ZZPVZXXaWOzQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788415827; c=relaxed/simple;
	bh=2SedpaDSoAR1LvgCWs+DWL0IdG8bnTzoa636rx/f34w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sBl/8eMwbVud0qpBBH5sHjMW9ZDwtJ7w6k81LegQHgFqfZGnx595oQcAVvYjt58gR4kR9qKChqzQw+9BLHU1n3/ykESIodofDGFVCuK/tgxBhCxAYQi8KBwAA88MIm0RXHTKfZ7/x9EIMQ57crnKK6d46YUq1ZoFX5BseSvBYdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=pN952jWH; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="pN952jWH"
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id B44143FC36
	for <selinux@vger.kernel.org>; Thu,  3 Sep 2026 06:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1788415823;
	bh=0SXt+zKg72aqt2co0Md7aOOy9tUWiA94GMNENg6+61g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=pN952jWHX0o+Su5RZOYvMoEtT6AgJ7dnSRgENfbA652dUmVSAhhpL57fP3byAGHCZ
	 6GwPvwp/SEQnaAWT6qqGmr9wVtOsYWGAW06BrZ8UO5AOESylb+6KUmgt+qdhZm/7yc
	 zh0fy1H85ulw0HEJ+StBQ9EumLORvg75DSU8cjrHktqtXItUiC/u7uizvjASAxgaSB
	 XPlpBAc7Ty5eHM4ur5q7tWmqATsECgUe7NWV2lfR8pb7+SDklWNNkosRIywn7dLqPQ
	 8O42O8r+GtFBeLlkWkhIKxrS/7A0+aMYayTRnaHRNIuiRqHMHB3if4WBsBBV5iTdEF
	 ytta+jHLvcNlPqVYnNn0jvyyVAvhnR1CoWmoaZ3bREC21krufOouZ19S5e5h6h87S5
	 NnpefH0gX9kYMbnzDhZPC+Xu8hCVxuBV2aU+DTowN7+LxnR0+L8oI/ihSoYYUD0+7H
	 5BDlWY/V+ZCMHQaicN+pXVER9Gn/18eecLY5MJmCobCOgfzSU3Ed0uzk4ODY1BmeuP
	 BpVxHqwBb2IvvpLx7tFKyQ2+hkntwoJw9lLkqKwPcwcs8jMhuBF/X8trMQsQoZHT7t
	 3kqJJDvUaUzf6khK0OFUlcv7Z8PbgyorQivX37P14zXX4oVzWTAAQ92l9rwFwfaDXK
	 oLsDiaOURRYr7a5Q3wqxp43w=
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2ce8a76df2dso37834835ad.2
        for <selinux@vger.kernel.org>; Wed, 02 Sep 2026 23:10:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788415821; x=1789020621;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :autocrypt:from:content-language:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=0SXt+zKg72aqt2co0Md7aOOy9tUWiA94GMNENg6+61g=;
        b=sxshakuDQyQb0CFK1um50D+tDSdZolbZeKQpBLincwbJIajslD43qMXDMFo+QsEPtS
         SnaseLtMQgsSjOXRnjJW33XC7jK8NioWbF2ewkMsLdxSGGOj4N2F55xExK2jxmIgs2FT
         t1KHb3HiQoMBOVxbcfbFnunItVj3kupzulYvvdcIPHu4Vsr5ByiwdFrfB2utX67ENpMy
         Odf7STc0H3giO9fLo+iFDF/qCcfWwFZKSBVHooFD+tIxEyWesFEvW0lbj6uO2CkDOtGh
         el3B2hdLS+pzgjR4YrXwHUJMye/iQrWXlfHyxkCqF6BC5fDXcWSgQ7h1782/1aNA34nz
         /Q6g==
X-Forwarded-Encrypted: i=1; AKwUvBxwjlkvwdzCCl0yqW4YWXEQGXNpDL/MHKqq1uEileCkq5e3xcdgz7SRjEhBCi8Za/0fqmUH63tH@vger.kernel.org
X-Gm-Message-State: AFuF++m907aP/hcwYjS75/BmXJB6U4IvHdoqH/ytLJhh0KaZZGbrpUQh
	ycDd49VAvoe7Gr+98Mnjfv5O/YXbw10dDsQJbw7EDFNF4sSfoBtYH/ezyQoQa4PfTUGtIZ2XZ5F
	22NlAG6XKk9624hJsaA8SBRolp6uhsp5VH7OgBOwp1deefHkNoJdzm1pGSRWvVpN4ogrNz39mKF
	E=
X-Gm-Gg: AYBFou0glJ5BV4mWozWXh8KSAVll+fNlSQe1vZIaYmtE2hQMnrxhqz5N3XesTw3c7b4
	Kn3w7xQGxsZPdwFiB3tp0acz+sGraLsqPsgR5XOSOsND8QEaIRSvZZF2npAWPpk55caA6wS4gIr
	fCJeMgnGAAKVWv6M797r5+gSQCnABPtKh95BiPHtfjtqLrye6nzrwFTyQFpEn6sH09Qy3swmOpq
	U9qAdTvcn922EiTSWl0udBHb/wlFikYuACRCyg7467Qve6juH3w3PIsxLkyOS2fLF5hpDcYmXO0
	ULtmdVZjFsmKmECC9pfOFsqTKWdfo7qf5Tkoo5UIORQtxALtmN3zBX93jrYJQram1GPCjQdQj9A
	bOG/QkbB+oi42gTQ=
X-Received: by 2002:a17:903:32c2:b0:2c9:bf82:dd11 with SMTP id d9443c01a7336-2daec646e99mr105324285ad.7.1788415821165;
        Wed, 02 Sep 2026 23:10:21 -0700 (PDT)
X-Received: by 2002:a17:903:32c2:b0:2c9:bf82:dd11 with SMTP id d9443c01a7336-2daec646e99mr105323705ad.7.1788415820747;
        Wed, 02 Sep 2026 23:10:20 -0700 (PDT)
Received: from [192.168.192.72] ([50.47.147.90])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-2dafe0cf4d3sm4768265ad.3.2026.09.02.23.10.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Sep 2026 23:10:20 -0700 (PDT)
Message-ID: <c7850811-c258-4684-b232-e25ddfb152dd@canonical.com>
Date: Wed, 2 Sep 2026 23:10:19 -0700
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/7] SELinux: hooks for secctx_to_lsmprop and
 update_lsmprop
To: Casey Schaufler <casey@schaufler-ca.com>, paul@paul-moore.com,
 linux-security-module@vger.kernel.org, pablo@netfilter.org, fw@strlen.de,
 phil@nwl.cc
Cc: linux-kernel@vger.kernel.org, netfilter-devel@vger.kernel.org,
 coreteam@netfilter.org, jmorris@namei.org, serge@hallyn.com,
 keescook@chromium.org, penguin-kernel@i-love.sakura.ne.jp,
 stephen.smalley.work@gmail.com, selinux@vger.kernel.org
References: <20260902220150.18586-1-casey@schaufler-ca.com>
 <20260902220150.18586-5-casey@schaufler-ca.com>
Content-Language: en-US
From: John Johansen <john.johansen@canonical.com>
Autocrypt: addr=john.johansen@canonical.com; keydata=
 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 lT9Q
Organization: Canonical
In-Reply-To: <20260902220150.18586-5-casey@schaufler-ca.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/2/26 15:01, Casey Schaufler wrote:
> Implement these hooks.
> 
other than the question below, this is looking good
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>   security/selinux/hooks.c | 16 ++++++++++++++++
>   1 file changed, 16 insertions(+)
> 
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 18dd28b2bb13..12614478b638 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -6946,6 +6946,13 @@ static int selinux_ismaclabel(const char *name)
>   	return (strcmp(name, XATTR_SELINUX_SUFFIX) == 0);
>   }
>   
> +static void selinux_update_lsmprop(struct lsm_prop *dest, struct lsm_prop *src,
> +				   int lsmid)
> +{
> +	if (lsmid == LSM_ID_SELINUX || lsmid == LSM_ID_UNDEF)
you have added similar boiler plate to each of the LSMs using this hook. If
all LSMs are going to do this, then shouldn't we just move this into the
LSM similar to what is done with secctx_to_lsm_prop

		if (lsmid != LSM_ID_UNDEF && lsmid != scall->hl->lsmid->id)
			continue;

> +		dest->selinux.secid = src->selinux.secid;
> +}
> +
>   static int selinux_secid_to_secctx(u32 secid, struct lsm_context *cp)
>   {
>   	u32 seclen;
> @@ -6964,6 +6971,13 @@ static int selinux_secid_to_secctx(u32 secid, struct lsm_context *cp)
>   	return seclen;
>   }
>   
> +static int selinux_secctx_to_lsmprop(const char *secdata, u32 seclen,
> +				     struct lsm_prop *prop)
> +{
> +	return security_context_to_sid(secdata, seclen, &prop->selinux.secid,
> +				       GFP_KERNEL);
> +}
> +
>   static int selinux_lsmprop_to_secctx(struct lsm_prop *prop,
>   				     struct lsm_context *cp)
>   {
> @@ -7694,6 +7708,7 @@ static struct security_hook_list selinux_hooks[] __ro_after_init = {
>   
>   	LSM_HOOK_INIT(ismaclabel, selinux_ismaclabel),
>   	LSM_HOOK_INIT(secctx_to_secid, selinux_secctx_to_secid),
> +	LSM_HOOK_INIT(secctx_to_lsmprop, selinux_secctx_to_lsmprop),
>   	LSM_HOOK_INIT(release_secctx, selinux_release_secctx),
>   	LSM_HOOK_INIT(inode_invalidate_secctx, selinux_inode_invalidate_secctx),
>   	LSM_HOOK_INIT(inode_notifysecctx, selinux_inode_notifysecctx),
> @@ -7812,6 +7827,7 @@ static struct security_hook_list selinux_hooks[] __ro_after_init = {
>   	LSM_HOOK_INIT(sem_alloc_security, selinux_sem_alloc_security),
>   	LSM_HOOK_INIT(secid_to_secctx, selinux_secid_to_secctx),
>   	LSM_HOOK_INIT(lsmprop_to_secctx, selinux_lsmprop_to_secctx),
> +	LSM_HOOK_INIT(update_lsmprop, selinux_update_lsmprop),
>   	LSM_HOOK_INIT(inode_getsecctx, selinux_inode_getsecctx),
>   	LSM_HOOK_INIT(sk_alloc_security, selinux_sk_alloc_security),
>   	LSM_HOOK_INIT(tun_dev_alloc_security, selinux_tun_dev_alloc_security),

