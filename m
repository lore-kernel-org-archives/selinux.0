Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC68F2264A8
	for <selinux@vger.kernel.org>; Fri, 24 Apr 2026 01:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776993560; cv=none; b=EGTR9xABNGKP1PlyeaufXJT49Kz9VPeSEWgR2XR9AXkvz05bhzywr8JP0jMsichBZs/qwykEnNHfdZ+l2kydNmeBP4dQI0caNW6/9LOISismmYWeg2/U9FPqIRzog6m4XYqcj4WtzynGvtEO84rcr07zEsfO6nS7sUxK3+ZpsXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776993560; c=relaxed/simple;
	bh=w26hOfSzLr0ux5KAjGl5aYE4QBAMxS0JfkcWAXj7yUQ=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=uNdGeikKd1G7JkmfOYwvZ1pXVZuaZlr6deZ/aBF65BF+2NGxSDQmEGei1VMEEvGvLGbt3scCq6Fj0+vGB4ern0NbkyD/DWig1AEuEJZCXsqKAjHB79Qla5aPIC3jDxrb3To9J3EMhmhWYdyZ3NWHDK1FtKuR789h+HUOgztX2bE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=LDN3xTXB; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="LDN3xTXB"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-50e614fdb42so49527191cf.3
        for <selinux@vger.kernel.org>; Thu, 23 Apr 2026 18:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1776993558; x=1777598358; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yN2E5V7Fs50FVeeU3PvlsrCK+ZTQi/YisnRuc6Ir2cM=;
        b=LDN3xTXB9bp0pFNWZ6ogj6LXm+AaGftfy3P/ddYPDHXPz+S6Oveauv8Ov9TZ7/oB1E
         DeR2iG4/k4FUFKR9k8hK5+FzQ8s6p/P5nc1SGdg2jb/PeBeNbmSsofpT8Jvb9UL51lQU
         1VfFWhCXOUqYtRN6op9q+5b1FrYqqeikRUghfwNMMBM0KzR5T9xRQtZIyKU5gG05rDQU
         QcxFrYAAQTtKKZw0Wbaf+8Lr1GlWW+FtCituBvOZ5I8+keccDnPJ70mNvR57l0N7wXPz
         nhys1i8diBEU9CoMx7WL/do8qha8U1K9yXTU+APNuA4c08O1NoLesXppaHSoF3iCQshB
         OhHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776993558; x=1777598358;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yN2E5V7Fs50FVeeU3PvlsrCK+ZTQi/YisnRuc6Ir2cM=;
        b=MVNnuymnJL6xqhETGESPqOd/ujOFQxljPpEUxNjeNI6d6RLaoM+zcmV2ar/Z/Zfexp
         c2T4nQU5qU2CqffUanRqE1oE3TI+ZRBqsCfgV0PxiBBcvoXt+M/m1Esz2jRPTZ8vNY3q
         ixnp5yIffp806FfMoj7yXXvy5FPjYwQs5joSUw24hT+tCbPkvi0yi2fQllKqYcGh7Srq
         DKOFvL8YvKR3Fa0BrPD/rep3sJA2GF0BqOkzxyP64D/bAWyQt4P7LWlUxRZ8jRqw7iYJ
         MwX2qCAGvoQHUstL4s5Wlj3pEuHpfN/f8a94lBtiVIy96hHdmmffSfir/FUQldRty9wD
         Y/Pg==
X-Forwarded-Encrypted: i=1; AFNElJ/8y5mvbWtnuYqE4rcaz2dfm6Fu2VoLi4FayZ3xQACEwdx8DcisrmiqK5UnvyaZ7dGSolK7iiTK@vger.kernel.org
X-Gm-Message-State: AOJu0YyEyaYfZOfhapMF5NPFueyvo/cuSK5Pzr+YaLHkrswEblzOkDe/
	7I0+v1OdgRiygf2ojKMEKC8LLVNj7tkNnoB9fkqfBViboOnVSAXXCJZreMwh+Kgikw==
X-Gm-Gg: AeBDiespQ2RqY7M3qC78020nvgB5u+mRVH3ylAuLV5ucRpEyCHtCe7DEOAcaq3FNk3d
	SpWn/capmuz0jxiPpMVVVsw4aDllj1zhp+qEZyPI0+oe+4AhPd9BxTOphbH05TNA4+sU6ePewEa
	/GC7aqKntE5YSln0nZMD08JcgRhuJ6HaMDo6COP0xZiBTSzGPX8slFjg9j3h/fkxfC0o9aUXXCh
	LspTUHYt5DNpMQXz62e6Ffkw+aDoe89wwd0YrU39QHB1ufed5IcETkF1Bo9JQdsn+YUd7zL3MwZ
	DbOq1yu9EglOujjD+kMNmPQQ4ewLRffwlUTEsyxvliNVLEPqYKPxJ9JW0VaO8mfsi24QO7mmWas
	PgHZQv1Lc8q4YnGrDLTCNxU0crXrNr+TwHr8gmCFLE+zidA4s0Wa9p9i/GDzoCxkMqAv3stmRjx
	1OtqmG/eagzsOwRnpGoZeW9COcjxiKAnkSHnBUYqylPB3SZQnwiygaf//Q92q6XbI07jFZ13Aa4
	pysl+o=
X-Received: by 2002:a05:622a:83:b0:50f:b17d:7e5e with SMTP id d75a77b69052e-50fb17d804cmr214587511cf.24.1776993557711;
        Thu, 23 Apr 2026 18:19:17 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50e392c859asm224983731cf.1.2026.04.23.18.19.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 18:19:16 -0700 (PDT)
Date: Thu, 23 Apr 2026 21:19:15 -0400
Message-ID: <c101a47f7d262bded2bce52bf5463586@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20260423_1403/pstg-lib:20260423_1403/pstg-pwork:20260423_1403
From: Paul Moore <paul@paul-moore.com>
To: Casey Schaufler <casey@schaufler-ca.com>, casey@schaufler-ca.com, linux-security-module@vger.kernel.org
Cc: jmorris@namei.org, serge@hallyn.com, keescook@chromium.org, john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com, selinux@vger.kernel.org
Subject: Re: [PATCH RFC 2/3] LSM: Enforce exclusive hooks
References: <20260225192143.14448-3-casey@schaufler-ca.com>
In-Reply-To: <20260225192143.14448-3-casey@schaufler-ca.com>

On Feb 25, 2026 Casey Schaufler <casey@schaufler-ca.com> wrote:
> 
> If an LSM hook is marked as exclusive via LSM_FLAG_EXCLUSIVE
> in lsm_hook_defs.h it will not be added to the set of hooks to
> be executed if an different LSM has already registered an
> exclusive hook.
> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>  include/linux/security.h |  2 ++
>  security/lsm_init.c      | 66 ++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 68 insertions(+)
> 
> diff --git a/include/linux/security.h b/include/linux/security.h
> index 83a646d72f6f..e3c137a1b30a 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -2404,4 +2404,6 @@ static inline void security_initramfs_populated(void)
>  }
>  #endif /* CONFIG_SECURITY */
>  
> +extern u64 lsm_exclusive_hooks;

We already have the 'lsm_exclusive' variable in lsm_init.c, don't create
another variable that does the same thing.  If the scope of the existing
variable isn't what you need, change that.

Although to be honest, I'm not in love with what you're doing with the
variable anyway, more on that later in the review.

>  #endif /* ! __LINUX_SECURITY_H */
> diff --git a/security/lsm_init.c b/security/lsm_init.c
> index 05bd52e6b1f2..dc3c84387a7e 100644
> --- a/security/lsm_init.c
> +++ b/security/lsm_init.c
> @@ -356,6 +356,70 @@ static int __init lsm_static_call_init(struct security_hook_list *hl)
>  	return -ENOSPC;
>  }
>  
> +/*
> + * Hooks that are restricted to use by a single security module.
> + *
> + * Secmark hooks have not been converted from secids to lsm_props
> + * due to space limitations in packet headers.

If this is a general purpose mechanism for all types of LSM hooks, please
don't put commentary in here about a single class of hook.

If this only reason for doing all of this is for secmark, just fix
secmark instead of going through all of this trouble.

> + * Conversions from a secid to a secctx are restricted to the
> + * single security module. All cases where there may be multiple
> + * modules providing the input data have been converted to use
> + * a lsm_prop instead of a secid.

Okay, yes, the paragraph above is true, I'm just not sure why it is
important here?

> + */
> +struct lsm_exclusive {
> +	struct lsm_static_call *name;
> +	char *namestr;
> +	u32 flags;
> +};
> +
> +static __initdata struct lsm_exclusive lsm_exclusive_set[] = {
> +#define LSM_HOOK(RET, DEFAULT, FLAGS, NAME, ...)	\
> +	{ .name = static_calls_table.NAME, .flags = FLAGS, .namestr = "" #NAME "" , },
> +#include <linux/lsm_hook_defs.h>
> +#undef LSM_HOOK
> +};
> +u64 lsm_exclusive_hooks;
> +EXPORT_SYMBOL(lsm_exclusive_hooks);

Unless I missed something, we really shouldn't need to export this, why
did you need EXPORT_SYMBOL() here?

> +/**
> + * lsm_exclusive_hook_denial - Check if exclusive hook is in use
> + * @hook: the hook to check
> + *
> + * Check if the hook in question is restricted to a single using LSM,
> + * and if the LSM providing single LSM hooks is defined.
> + *
> + * Returns true if the hook is exclusive and they are already provided,
> + * false otherwise.
> + */
> +static bool __init lsm_exclusive_hook_denial(struct security_hook_list *hook)
> +{
> +	int i;
> +
> +	if (lsm_exclusive_hooks == hook->lsmid->id)
> +		return false;
> +
> +	for (i = 0; i < ARRAY_SIZE(lsm_exclusive_set); i++) {
> +		if (!(lsm_exclusive_set[i].flags & LSM_FLAG_EXCLUSIVE))
> +			continue;

The logic on this looks a bit odd.  What is wrong with something like the
pseduo code below?

    for (i = 0; ARRAY_SIZE(lsm_hooks); i++) {
      if (lsm_hooks[i] == hook) {
        if (lsm_hooks[i].flags & LSM_FLAG_EXCLUSIVE)
          return true;
        else
          return false;
      }
    }

> +		if (hook->scalls == lsm_exclusive_set[i].name) {
> +			if (lsm_exclusive_hooks) {
> +				if (lsm_debug)
> +					lsm_pr("%s denied for %s.\n",
> +						lsm_exclusive_set[i].namestr,
> +						hook->lsmid->name);

The lsm_pr_dbg() macro exists for this very reason.

> +				return true;
> +			}
> +			if (lsm_debug)
> +				lsm_pr("Exclusive hooks limited to %s.\n",
> +					hook->lsmid->name);

Same as above.

> +			lsm_exclusive_hooks = hook->lsmid->id;
> +			break;
> +		}
> +	}
> +	return false;
> +}
>
>  /**
>   * security_add_hooks - Add a LSM's hooks to the LSM framework's hook lists
>   * @hooks: LSM hooks to add
> @@ -371,6 +435,8 @@ void __init security_add_hooks(struct security_hook_list *hooks, int count,
>  
>  	for (i = 0; i < count; i++) {
>  		hooks[i].lsmid = lsmid;
> +		if (lsm_exclusive_hook_denial(&hooks[i]))
> +			continue;
>  		if (lsm_static_call_init(&hooks[i]))
>  			panic("exhausted LSM callback slots with LSM %s\n",
>  			      lsmid->name);

I don't think we'd want to simply skip over a hook registration if the
LSM doesn't have access to an exclusive hook.  At the very least it risks
unexpected behavior in the LSM and at the worst it prevents the LSM from
properly enforcing it's security policy.  There is a reason we have the
panic() call in the existing code if we are not able to register a hook.

The simpliest solution here would be to panic, like we do today.

However, if you want to get fancy and enable LSMs to optionally adjust
their behavior to cope with the loss of a hook callback (I'm looking at
your patch 3/3 now), come up with a mechanism to report back to the LSM
that one or more of the callbacks were not registered.  One quick thought
would be to return a non-zero error code and add an indicator/bool/flag
to the security_hook_list that would be set by security_add_hooks().

--
paul-moore.com
