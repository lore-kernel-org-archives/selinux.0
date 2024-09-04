Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD64A10E3
	for <selinux@vger.kernel.org>; Wed,  4 Sep 2024 00:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725409114; cv=none; b=ZJ5Kyjdxtt/TeG48CYCpYAMbujNLU1SeVSCg/7/annS4jhUXCo2iadgnuw5EJYBCAqxknh6bRPkJ8n3aC2DQbzrapzbfZoYEsMc/PW9zIG3Ac4Zx8sO8dtIzrloXMxY58aCRaBzF4V5LZl/+tQlukhUK5Z1L/SV1IpN8+JRDp4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725409114; c=relaxed/simple;
	bh=u/GGmWG+3QR4VJBKYef9iVhq98tST0oEhk2IhIUTiv8=;
	h=Date:Message-ID:MIME-Version:Content-Type:Content-Disposition:
	 From:To:Cc:Subject:References:In-Reply-To; b=FvCEloueGSKUnzE9DdpQpvjE7lLSRpbRonXkrQFexG8TKfP2krBpjGwLax1oK6NSc7pbVUZC7cVKUNj89stkD+Cy88X5LvQdOqpf75iOOznOee2IebHhVdqC1LSa+Ao3QipzsTnapdRgu5ivQjbOWhszKcFoG9H7x92cXTYSEFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=OWWWPbhf; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="OWWWPbhf"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6bf7ad1ec3aso30823566d6.0
        for <selinux@vger.kernel.org>; Tue, 03 Sep 2024 17:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1725409111; x=1726013911; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=M5+rnIH3U8ouhhIpGkwUHv0lQNkUmZIGliNvdGoMLcE=;
        b=OWWWPbhfa3HWxbCihuAyH/TV4UbbHxwdowtJGO6LPsXgCzX85TFVV/QX2Py2AIv0+P
         i2VduhedlzLTh6gG9KOE+0l7SE4+vPEbNIWO+5hyn4idi/UsNX9VInWRwotVZGNdqIWt
         Qx8btQ+2ZZaZWEr375RT+gmvcB0eTeNiTwODgBQocpJ0oZHl5jianliKIvSCeP6obIGO
         tempUR3RNC58NMEZ+gyuRRugAG0VLOyk3TCk0Sz3vRUshte0bT89MIO/r8ssUk8xOP+j
         a1towzZbMsCWmOsLCcOgZjSFOZsp7W54aHq4H+8uPkqV9cUbqDi0w7c+yUVnGc+fmR8I
         8lYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725409111; x=1726013911;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=M5+rnIH3U8ouhhIpGkwUHv0lQNkUmZIGliNvdGoMLcE=;
        b=sri1fTZUz84lrES3yR33ZGRePh6dJ3JxfsXiKGVKnt38dlHqgmFK6snaaylOiY2FiO
         2ZWpaM258J9V6osYBwl2kLOZVOxs2g9YURznRxZZ/lEnI95aBNly+EKs9m8s0x67NEfF
         SfC7dKJd0OqmnrOxI3iBLLQULmKoiAAPBWtRKGbjKBp58j7/btaNbiQEHtMeYTQVhahV
         sLM6w9bmMyrTAWU85gKeAIyrM3difbiSxhZ+CIinAiR8Jw4Yl+sO/uxLksymorlrZTei
         UnK60XV54dN/f0i4y5X7v3yAnnjsB+4inGXhOE8f3BqDxXcIB+XpLTB/omLGOHJcQ/e4
         3S2w==
X-Forwarded-Encrypted: i=1; AJvYcCU1448UeGjTvUmp0hF0hVVIiFXfJNObn/SrfvRr07bxuiXyxvUliz+BBBXJGrj6r7HOS2Jkmmm/@vger.kernel.org
X-Gm-Message-State: AOJu0YwZOcSfPzCXGQT2AUURNRJ+a0Ab4FOTzy3XGgPTYSk/BS34usY6
	mG3WjzNiDBah5PiF3mpgv8p4pFMvED8/zUb+BzplvlibPp6oSajagjSwo0SxkQ==
X-Google-Smtp-Source: AGHT+IH31Gtn7M4+mX+j971olX4rKLKtG+qPlPEL9FOmnMTwROPFzLlNnEc4Wkx5NdGBV+uWSw5QKA==
X-Received: by 2002:a05:6214:498e:b0:6c3:8fae:9660 with SMTP id 6a1803df08f44-6c38fae97c8mr74823446d6.46.1725409111578;
        Tue, 03 Sep 2024 17:18:31 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c340bff7b6sm59074536d6.43.2024.09.03.17.18.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 17:18:31 -0700 (PDT)
Date: Tue, 03 Sep 2024 20:18:30 -0400
Message-ID: <9c8268660e3c07af7edab592e8249276@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=utf-8 
Content-Disposition: inline 
Content-Transfer-Encoding: 8bit
From: Paul Moore <paul@paul-moore.com>
To: Casey Schaufler <casey@schaufler-ca.com>, casey@schaufler-ca.com, linux-security-module@vger.kernel.org
Cc: jmorris@namei.org, serge@hallyn.com, keescook@chromium.org, john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org, selinux@vger.kernel.org, mic@digikod.net
Subject: Re: [PATCH v2 4/13] Audit: maintain an lsmblob in audit_context
References: <20240830003411.16818-5-casey@schaufler-ca.com>
In-Reply-To: <20240830003411.16818-5-casey@schaufler-ca.com>

On Aug 29, 2024 Casey Schaufler <casey@schaufler-ca.com> wrote:
> 
> Replace the secid value stored in struct audit_context with a struct
> lsmblob. Change the code that uses this value to accommodate the
> change. security_audit_rule_match() expects a lsmblob, so existing
> scaffolding can be removed. A call to security_secid_to_secctx()
> is changed to security_lsmblob_to_secctx().  The call to
> security_ipc_getsecid() is scaffolded.
> 
> A new function lsmblob_is_set() is introduced to identify whether
> an lsmblob contains a non-zero value.
> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>  include/linux/security.h | 13 +++++++++++++
>  kernel/audit.h           |  3 ++-
>  kernel/auditsc.c         | 19 ++++++++-----------
>  3 files changed, 23 insertions(+), 12 deletions(-)
> 
> diff --git a/include/linux/security.h b/include/linux/security.h
> index 457fafc32fb0..a0b23b6e8734 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -277,6 +277,19 @@ static inline const char *kernel_load_data_id_str(enum kernel_load_data_id id)
>  	return kernel_load_data_str[id];
>  }
>  
> +/**
> + * lsmblob_is_set - report if there is a value in the lsmblob
> + * @blob: Pointer to the exported LSM data
> + *
> + * Returns true if there is a value set, false otherwise
> + */
> +static inline bool lsmblob_is_set(struct lsmblob *blob)
> +{
> +	const struct lsmblob empty = {};
> +
> +	return !!memcmp(blob, &empty, sizeof(*blob));
> +}
> +
>  #ifdef CONFIG_SECURITY

We probably want a !CONFIG_SECURITY variant of this too.

>  int call_blocking_lsm_notifier(enum lsm_event event, void *data);
> diff --git a/kernel/audit.h b/kernel/audit.h
> index a60d2840559e..b1f2de4d4f1e 100644
> --- a/kernel/audit.h
> +++ b/kernel/audit.h
> @@ -11,6 +11,7 @@
>  
>  #include <linux/fs.h>
>  #include <linux/audit.h>
> +#include <linux/security.h>
>  #include <linux/skbuff.h>
>  #include <uapi/linux/mqueue.h>
>  #include <linux/tty.h>
> @@ -160,7 +161,7 @@ struct audit_context {
>  			kuid_t			uid;
>  			kgid_t			gid;
>  			umode_t			mode;
> -			u32			osid;
> +			struct lsmblob		oblob;
>  			int			has_perm;
>  			uid_t			perm_uid;
>  			gid_t			perm_gid;
> diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> index 23adb15cae43..84f6e9356b8f 100644
> --- a/kernel/auditsc.c
> +++ b/kernel/auditsc.c
> @@ -724,9 +724,7 @@ static int audit_filter_rules(struct task_struct *tsk,
>  				/* Find ipc objects that match */
>  				if (!ctx || ctx->type != AUDIT_IPC)
>  					break;
> -				/* scaffolding */
> -				blob.scaffold.secid = ctx->ipc.osid;
> -				if (security_audit_rule_match(&blob,
> +				if (security_audit_rule_match(&ctx->ipc.oblob,
>  							      f->type, f->op,
>  							      f->lsm_rule))
>  					++result;
> @@ -1394,19 +1392,17 @@ static void show_special(struct audit_context *context, int *call_panic)
>  			audit_log_format(ab, " a%d=%lx", i,
>  				context->socketcall.args[i]);
>  		break; }
> -	case AUDIT_IPC: {
> -		u32 osid = context->ipc.osid;
> -
> +	case AUDIT_IPC:
>  		audit_log_format(ab, "ouid=%u ogid=%u mode=%#ho",
>  				 from_kuid(&init_user_ns, context->ipc.uid),
>  				 from_kgid(&init_user_ns, context->ipc.gid),
>  				 context->ipc.mode);
> -		if (osid) {
> +		if (lsmblob_is_set(&context->ipc.oblob)) {
>  			char *ctx = NULL;
>  			u32 len;
>  
> -			if (security_secid_to_secctx(osid, &ctx, &len)) {
> -				audit_log_format(ab, " osid=%u", osid);
> +			if (security_lsmblob_to_secctx(&context->ipc.oblob,
> +						       &ctx, &len)) {
>  				*call_panic = 1;
>  			} else {
>  				audit_log_format(ab, " obj=%s", ctx);
> @@ -1426,7 +1422,7 @@ static void show_special(struct audit_context *context, int *call_panic)
>  				context->ipc.perm_gid,
>  				context->ipc.perm_mode);
>  		}
> -		break; }
> +		break;
>  	case AUDIT_MQ_OPEN:
>  		audit_log_format(ab,
>  			"oflag=0x%x mode=%#ho mq_flags=0x%lx mq_maxmsg=%ld "
> @@ -2642,7 +2638,8 @@ void __audit_ipc_obj(struct kern_ipc_perm *ipcp)
>  	context->ipc.gid = ipcp->gid;
>  	context->ipc.mode = ipcp->mode;
>  	context->ipc.has_perm = 0;
> -	security_ipc_getsecid(ipcp, &context->ipc.osid);
> +	/* scaffolding */
> +	security_ipc_getsecid(ipcp, &context->ipc.oblob.scaffold.secid);
>  	context->type = AUDIT_IPC;
>  }
>  
> -- 
> 2.46.0

--
paul-moore.com
