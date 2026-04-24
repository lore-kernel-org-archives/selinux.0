Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C6AE17A586
	for <selinux@vger.kernel.org>; Fri, 24 Apr 2026 01:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776993558; cv=none; b=Ew5JEFzAS+BX/ivMLd5RfC3cZ/BHHD8F7hb4ndK5ZOHPUDopcbh2TaCYZYfXomipdW+Qq9mXxQdyKIIDmmwvkTFHxBQnJ6f6h8VcDJ8zn+7fVnePsh+mitzsSRhM3HI3g/GI7KYmP3g6M/wF5S1/AG2LrXBAcZ/TQz93WHllNrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776993558; c=relaxed/simple;
	bh=WIEb5pD0FDnhICUwj1EqHt/4/FLlH0Zy/EYKqjdIUaE=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=UGewZXg1iZByIQSreNzd1wmH+KPOiyZ6JkfYPy8C3tDahWTdMw+cWg7/TodvMyZfPaQ3aL87jPRDm8PNapR1hh/waLtaixOBqiH+ZrKGvB5izMMxtL3XcGDWUFATj950GX/kh0zExZrTBHIoyTL0ft9Vvy76wLx7SDdlfpFCGsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=JLwp6hEb; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="JLwp6hEb"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-8c70b5594f4so800181085a.1
        for <selinux@vger.kernel.org>; Thu, 23 Apr 2026 18:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1776993555; x=1777598355; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ou1kjFGy3ABAuntrpiSfqyzSPaNZnsi6DJN5YqAbaY4=;
        b=JLwp6hEbkyiOkFRfu/Omuq4wOG+QJYIixNlSIL61JtqN144QLAZTBPGkIAmulNv9x3
         TgiohJxP4RJ0BGXsYkRJG3tBGMVgwfxvpaDIpLzfE3lnKA0ssoPeZ5Jaiy/rmJWSpyUA
         nKIoQqBfqS+B5yY18mP9Q40Fx4pyVdBVhSRUbNBhdxaBfHIH9q/AD5UB2f4ozA/oqmc/
         6YUX99PVzR53WI+bcHyBoHxOw2uPUbixf1ThJothquGv8GSPW7SKPZzgOx5pSaHRjcgh
         WVmiAqhwyyqvRBFFc0MHNB1JR9yv3UpxeVhS6X5zgb/ZYzFYwgBYLf4tjnpxNMR6RDt1
         FpLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776993555; x=1777598355;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ou1kjFGy3ABAuntrpiSfqyzSPaNZnsi6DJN5YqAbaY4=;
        b=m33nMATlrGsfUhkW8/QpJf8tSRv6sdwo7WceW/FSWjsobGUYf4uCxPGAGYOp4Up3pQ
         3Ja5jovawa+BQWmB42V24o8ZGMj85z1n7gm+ANHqsXDslI0uIjepBL1FyAwai1o753b2
         7B7dG4DFjdIwzsCbkqYSMSM3y/9G6NSOapvrQZwOD7EzR/sWyDN4rw1S9mxjzpBFhC0+
         B5257T18PKR3Y/+QURIBXvrQX4pNb8M8drJwmYEJzuv2NYvFTUaZrQWgD7z9X0VMoBsu
         0A4GHb8Xv2qrqvYaeRt6WRWjgQeAnHcD95ru4o5tWUI4gkN4JeGB777s9fajffSCrpGU
         eOHA==
X-Forwarded-Encrypted: i=1; AFNElJ/uVpXvesjNB6SssYadNo1QXzAzfdQhlxEG7xMckAlQmBk0WbYIJog2xT0IQLEYjuv8r4ijICYd@vger.kernel.org
X-Gm-Message-State: AOJu0YzNTuZfwiSfwsSMw2lk1BnxREpme3N0IgONOzTsTCH5CRIHoEWa
	/E7SGHa2fOmqPO+4Jz0H2PM9GajmIfC7HenFzu9AJ7IZhnR4X64Va39dCCtoyk4fEg==
X-Gm-Gg: AeBDievWPkFOQKte6irXKPwn/0Lcv6YdNQzNqzi2knlNMcJ5OadW4/s5K+fMOIok/tf
	kYVK8H4uDxvHIFYM1/SUCI9M/hQsDTCSQ6b/UM26+jk6L+hEpgyzt8OnTYxce8f7Sz8NjwXK1lJ
	kANq+rxdzWr7Hjrra1hkSbZ7n4/RTViS3MVyC0t3FfpOj9Z+EAh/E20A+YCljvkk1TQtWQrkuBq
	wkQRC+tNdb3eZ6jsjcRcUl147BjBP5W9+VAbk8Y4uHzCQ0GIOgXnQ7g87ndrJSDVFhGcgnC3I9P
	6nBM9OL1pOg59Y+fAC5kotDIZbTlt5IPXLrnfc8gfOFSo3/E/el/0O0b1s3gzoXMqxo5F3rZyp+
	qXHS1WkpMl8sdwNccuW05yu7gnOVg7vthtWjUEVLJzwWxkX4iVabRhlFNgks1c89myiB6yGKLRX
	dj4RPltNPURONgYYGr4cXDMN4pJ3sSYkEoA8WrHI5QWyGz01pgN+u15r6J3vfAjW0p5tPOuHCqx
	mPziKo=
X-Received: by 2002:a05:620a:2982:b0:8ef:f1c0:ab8c with SMTP id af79cd13be357-8eff1c0b4dbmr1184884585a.6.1776993555478;
        Thu, 23 Apr 2026 18:19:15 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8e7d5fe8f3csm1786763585a.2.2026.04.23.18.19.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 18:19:14 -0700 (PDT)
Date: Thu, 23 Apr 2026 21:19:13 -0400
Message-ID: <c25833f447e6c00868b352cfea50d2b2@paul-moore.com>
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
Subject: Re: [PATCH RFC 1/3] LSM: add a flags field to the LSM hook definitions
References: <20260225192143.14448-2-casey@schaufler-ca.com>
In-Reply-To: <20260225192143.14448-2-casey@schaufler-ca.com>

On Feb 25, 2026 Casey Schaufler <casey@schaufler-ca.com> wrote:
> 
> Add a field for flags to the definition of LSM hooks.  This allows
> for hooks to be identified at system initialization for special
> processing.
> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>  include/linux/bpf_lsm.h       |   2 +-
>  include/linux/lsm_hook_defs.h | 614 ++++++++++++++++++----------------
>  include/linux/lsm_hooks.h     |   4 +-
>  kernel/bpf/bpf_lsm.c          |  10 +-
>  security/bpf/hooks.c          |   2 +-
>  security/security.c           |   6 +-
>  6 files changed, 331 insertions(+), 307 deletions(-)
> 
> diff --git a/include/linux/bpf_lsm.h b/include/linux/bpf_lsm.h
> index 643809cc78c3..d71ba8c87e79 100644
> --- a/include/linux/bpf_lsm.h
> +++ b/include/linux/bpf_lsm.h
> @@ -14,7 +14,7 @@
>  
>  #ifdef CONFIG_BPF_LSM
>  
> -#define LSM_HOOK(RET, DEFAULT, NAME, ...) \
> +#define LSM_HOOK(RET, DEFAULT, FLAGS, NAME, ...) \
>  	RET bpf_lsm_##NAME(__VA_ARGS__);
>  #include <linux/lsm_hook_defs.h>
>  #undef LSM_HOOK
> diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
> index 8c42b4bde09c..acda3a02da97 100644
> --- a/include/linux/lsm_hook_defs.h
> +++ b/include/linux/lsm_hook_defs.h
> @@ -18,451 +18,475 @@
>   * The macro LSM_HOOK is used to define the data structures required by
>   * the LSM framework using the pattern:
>   *
> - *	LSM_HOOK(<return_type>, <default_value>, <hook_name>, args...)
> + *	LSM_HOOK(<return_type>, <default_value>, <flags>, <single>,
> + *		 <hook_name>, args...)
>   *
>   * struct security_hook_heads {
> - *   #define LSM_HOOK(RET, DEFAULT, NAME, ...) struct hlist_head NAME;
> + *   #define LSM_HOOK(RET, DEFAULT, FLAGS, NAME, ...) struct hlist_head NAME;
>   *   #include <linux/lsm_hook_defs.h>
>   *   #undef LSM_HOOK
>   * };
>   */
> -LSM_HOOK(int, 0, binder_set_context_mgr, const struct cred *mgr)
> -LSM_HOOK(int, 0, binder_transaction, const struct cred *from,
> +LSM_HOOK(int, 0, 0, binder_set_context_mgr, const struct cred *mgr)
> +LSM_HOOK(int, 0, 0, binder_transaction, const struct cred *from,
>  	 const struct cred *to)

I think adding a flag field to the LSM_HOOK() macro/definitions is a good
and useful addition, but I'd prefer if we created a LSM_FLAG_NONE #define
and used it here just so we could avoid the back-to-back 0's and do a bit
of self-documentation.

--
paul-moore.com
