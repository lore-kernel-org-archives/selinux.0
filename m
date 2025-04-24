Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BAA7221F00
	for <selinux@vger.kernel.org>; Thu, 24 Apr 2025 22:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745533117; cv=none; b=BHsgnE1h005BMykWehC3y5vFMBe4VaYQFUMUTt6KLvqNXBRHhfgsgUxDfGXWMga83logQkcpAhATaXAczO1TvzkxD9N2gxWegzLqz7kiKq2VVht4MVdkI/sEvplF0gyTezeR2zyBeJlX6MiyFXbPtvduIFnb5yEKohOgN7SpWK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745533117; c=relaxed/simple;
	bh=OVX18VdLNgmU4K/lJQHocIp3fvdOXLQtT7CpJrwusDk=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=dBP0C4TB7yHa/RJe770RBck45S329fMxmnOyDXjlgoOahUIPYCQCLS+sNTp5QQaKkfahhhMBgJ+TuZP50BAkGDqEDfDC8kfs4VYQp6cZVi5CdtWkRq3wLJwQmjkR6CZACbSJIdST+ml7pOVx0QaAyrTlC+Jya/ZARRzyw/MS3oM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=MVLckdlg; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="MVLckdlg"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-47692b9d059so25046531cf.3
        for <selinux@vger.kernel.org>; Thu, 24 Apr 2025 15:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1745533113; x=1746137913; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qoHfSMxzs7rssuXAPH06Bk0hTUV/lLQabDLhD+4R0Lk=;
        b=MVLckdlg7wZg7mWQj9+p+nw987fC60D411OuPDKDpp7g/QTi35AoD0Au7I+iMm5gpC
         M/26pKcehJWLCkwIiiSh+HYDuL7gk1YebMYBQRpOmFgrM8GeH7Ln1Lc+56XlJOUx1YW7
         E9QU5i7NwYKN2oTPIaJ/YkkpmKcoOwJ1buJBkfAqmHBdZEfDMA2veGSO17egf6V1K0kV
         hjfL6U5NjKIxPw6nKzyhkXPiCz2YfVKzsJXRFDdyNa705xXLKbbov3atmzbFL6rn+T1l
         xHmo48pSP4RcCMFL/0ZK8S3PkGKqMGWpyovCbztwgKv7zRBmxgGxjIT4ffQViAMY31JQ
         OdfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745533113; x=1746137913;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qoHfSMxzs7rssuXAPH06Bk0hTUV/lLQabDLhD+4R0Lk=;
        b=RYNNYjy+Veju2IaSbqB9UldEnemeGb+WscEK816WMDcDWwrCqu0fibSO0LiICD3/Zb
         vYnVaDQR65nYhAqZbZnYy5E03XjTq1rveXw96VWWHDe5h7m0IQ73fQUWfg9PA/NRGTTE
         KfdDHujMRcEr7Iv2h0Nq5fL2lp9IDfH3CuU1ZWepvSJQYyalwaVkoZdDu782SX6BxNm0
         rbqZ5kuHp5i0StdVxOq8qXJfVqTjnscuq18mNTaZVBjJ+p0eRwT977qiH47SPgbyf35k
         aQcE0x9aoY4jANvu7XBTyFnCG2RzwHxEI5Hsaa5o3WCq1HAXcdkf+dWQHobu3Wsss4YI
         NSCA==
X-Forwarded-Encrypted: i=1; AJvYcCU5fdoNwBPUqQ1RDtRsBl+Y/FPXAPoXvCIQYYYfFR+dBujgEUt+5qx/LA+UqaHWztRTTjR03C+Q@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6yGI1fsc5eD1PtteN/IfyUbMmB5/2Z73ynv7W7o+UeLhGQnaD
	P2FgsBm0DdHXmmwxEo0mcOIdwnU1XzrfyhDtiSK8iTNbwPQ3WR/2aRonoxlrkg==
X-Gm-Gg: ASbGncurhTlPgqAOK+tnKbqxdmCjvFfnkNfU70CotXSe6vhreal+lJM/t0cbY5KVziZ
	Coy7pON1SuWahQC/oFWt4wAauvohGUJAo/HlWUy0Jqf0k8L1oHtxVVsgsz1/rpkv22FBeH0HldH
	/rda3tz3/6vdngeNf4aqAlp0zLFPN6TGnRZIdS1J/LIUEKi79DM8HnKgxjx/N/SgYTR7ZFj2dFR
	I0HofzdnzTbV3I6Et+DctCh5334v8gknqTOpcvcL5y7OrfXBGaxcvuESB4Ldqpb7MKbUaf7PlCm
	oWX5uFo+fVJPWtmtjVoiEo0eOPG8aEWMus5uF0a0WX+cROnnMcbkPZYSte/SdkV07r7J2TRgZyh
	RxapRVgwXSQ==
X-Google-Smtp-Source: AGHT+IFEWJdceLias5GrSe1DAaiC0Ems36cBhBGoLLAUzyCcUBGba2Uy3uq/KTnIAAA2klH+GMKqlw==
X-Received: by 2002:a05:622a:15c3:b0:47a:e6e1:c04f with SMTP id d75a77b69052e-4801eadd081mr2029341cf.46.1745533113073;
        Thu, 24 Apr 2025 15:18:33 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-47ea1b9e860sm17171111cf.66.2025.04.24.15.18.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 15:18:32 -0700 (PDT)
Date: Thu, 24 Apr 2025 18:18:32 -0400
Message-ID: <4895afcecf518a0744b964cfa4c16e3a@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20250424_1707/pstg-lib:20250424_1742/pstg-pwork:20250424_1707
From: Paul Moore <paul@paul-moore.com>
To: Casey Schaufler <casey@schaufler-ca.com>, casey@schaufler-ca.com, eparis@redhat.com, linux-security-module@vger.kernel.org, audit@vger.kernel.org
Cc: jmorris@namei.org, serge@hallyn.com, keescook@chromium.org, john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org, selinux@vger.kernel.org
Subject: Re: [PATCH v3 3/5] Audit: Add record for multiple task security  contexts
References: <20250319222744.17576-4-casey@schaufler-ca.com>
In-Reply-To: <20250319222744.17576-4-casey@schaufler-ca.com>

On Mar 19, 2025 Casey Schaufler <casey@schaufler-ca.com> wrote:
> 
> Replace the single skb pointer in an audit_buffer with a list of
> skb pointers. Add the audit_stamp information to the audit_buffer as
> there's no guarantee that there will be an audit_context containing
> the stamp associated with the event. At audit_log_end() time create
> auxiliary records (none are currently defined) as have been added to the
> list. Functions are created to manage the skb list in the audit_buffer.
> 
> Create a new audit record AUDIT_MAC_TASK_CONTEXTS.
> An example of the MAC_TASK_CONTEXTS (1423) record is:
> 
>     type=MAC_TASK_CONTEXTS[1423]
>     msg=audit(1600880931.832:113)
>     subj_apparmor=unconfined
>     subj_smack=_
> 
> When an audit event includes a AUDIT_MAC_TASK_CONTEXTS record the
> "subj=" field in other records in the event will be "subj=?".
> An AUDIT_MAC_TASK_CONTEXTS record is supplied when the system has
> multiple security modules that may make access decisions based on a
> subject security context.
> 
> Suggested-by: Paul Moore <paul@paul-moore.com>
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>  include/linux/audit.h      |   6 ++
>  include/uapi/linux/audit.h |   1 +
>  kernel/audit.c             | 171 ++++++++++++++++++++++++++++++-------
>  security/apparmor/lsm.c    |   3 +
>  security/selinux/hooks.c   |   3 +
>  security/smack/smack_lsm.c |   3 +
>  6 files changed, 158 insertions(+), 29 deletions(-)
> 
> diff --git a/include/linux/audit.h b/include/linux/audit.h
> index 0050ef288ab3..b493ca5976cf 100644
> --- a/include/linux/audit.h
> +++ b/include/linux/audit.h
> @@ -37,6 +37,7 @@ struct audit_watch;
>  struct audit_tree;
>  struct sk_buff;
>  struct kern_ipc_perm;
> +struct lsm_id;
>  
>  struct audit_krule {
>  	u32			pflags;
> @@ -210,6 +211,8 @@ extern u32 audit_enabled;
>  
>  extern int audit_signal_info(int sig, struct task_struct *t);
>  
> +extern void audit_lsm_secctx(const struct lsm_id *lsmid);
> +
>  #else /* CONFIG_AUDIT */
>  static inline __printf(4, 5)
>  void audit_log(struct audit_context *ctx, gfp_t gfp_mask, int type,
> @@ -269,6 +272,9 @@ static inline int audit_signal_info(int sig, struct task_struct *t)
>  	return 0;
>  }
>  
> +static inline void audit_lsm_secctx(const struct lsm_id *lsmid)
> +{ }
> +
>  #endif /* CONFIG_AUDIT */
>  
>  #ifdef CONFIG_AUDIT_COMPAT_GENERIC
> diff --git a/include/uapi/linux/audit.h b/include/uapi/linux/audit.h
> index d9a069b4a775..5ebb5d80363d 100644
> --- a/include/uapi/linux/audit.h
> +++ b/include/uapi/linux/audit.h
> @@ -146,6 +146,7 @@
>  #define AUDIT_IPE_ACCESS	1420	/* IPE denial or grant */
>  #define AUDIT_IPE_CONFIG_CHANGE	1421	/* IPE config change */
>  #define AUDIT_IPE_POLICY_LOAD	1422	/* IPE policy load */
> +#define AUDIT_MAC_TASK_CONTEXTS	1423	/* Multiple LSM task contexts */
>  
>  #define AUDIT_FIRST_KERN_ANOM_MSG   1700
>  #define AUDIT_LAST_KERN_ANOM_MSG    1799
> diff --git a/kernel/audit.c b/kernel/audit.c
> index 6bbadb605ca3..7ec3919ae925 100644
> --- a/kernel/audit.c
> +++ b/kernel/audit.c
> @@ -54,6 +54,7 @@
>  #include <net/netlink.h>
>  #include <linux/skbuff.h>
>  #include <linux/security.h>
> +#include <linux/lsm_hooks.h>
>  #include <linux/freezer.h>
>  #include <linux/pid_namespace.h>
>  #include <net/netns/generic.h>
> @@ -81,6 +82,11 @@ static u32	audit_failure = AUDIT_FAIL_PRINTK;
>  /* private audit network namespace index */
>  static unsigned int audit_net_id;
>  
> +/* Number of modules that provide a security context.
> +   List of lsms that provide a security context */
> +static u32 audit_secctx_cnt = 0;
> +static const struct lsm_id *audit_lsms[MAX_LSM_COUNT];

We've already talked about this in other threads, offline, etc., but
for the sake of others, this should be adjusted to use the counts
provided in the LSM initialization code rework.

https://lore.kernel.org/linux-security-module/20250409185019.238841-31-paul@paul-moore.com/

> @@ -2412,26 +2517,14 @@ int audit_signal_info(int sig, struct task_struct *t)
>  }
>  
>  /**
> - * audit_log_end - end one audit record
> - * @ab: the audit_buffer
> - *
> - * We can not do a netlink send inside an irq context because it blocks (last
> - * arg, flags, is not set to MSG_DONTWAIT), so the audit buffer is placed on a
> - * queue and a kthread is scheduled to remove them from the queue outside the
> - * irq context.  May be called in any context.
> + * __audit_log_end - enqueue one audit record
> + * @skb: the buffer to send
>   */
> -void audit_log_end(struct audit_buffer *ab)
> +static void __audit_log_end(struct sk_buff *skb)
>  {
> -	struct sk_buff *skb;
>  	struct nlmsghdr *nlh;
>  
> -	if (!ab)
> -		return;
> -
>  	if (audit_rate_check()) {
> -		skb = ab->skb;
> -		ab->skb = NULL;
> -
>  		/* setup the netlink header, see the comments in
>  		 * kauditd_send_multicast_skb() for length quirks */
>  		nlh = nlmsg_hdr(skb);
> @@ -2442,6 +2535,26 @@ void audit_log_end(struct audit_buffer *ab)
>  		wake_up_interruptible(&kauditd_wait);
>  	} else
>  		audit_log_lost("rate limit exceeded");
> +}

Okay, this is twice now in one patchset ... as I mentioned in the v2
review:

 "We should probably move the kauditd thread wake into
  audit_log_end() so we don't end up poking the scheduler
  multiple times."

https://lore.kernel.org/audit/69ee16ce82a564e09b2060d46fa2be0d@paul-moore.com/

> +/**
> + * audit_log_end - end one audit record
> + * @ab: the audit_buffer
> + *
> + * We can not do a netlink send inside an irq context because it blocks (last
> + * arg, flags, is not set to MSG_DONTWAIT), so the audit buffer is placed on a
> + * queue and a kthread is scheduled to remove them from the queue outside the
> + * irq context.  May be called in any context.
> + */
> +void audit_log_end(struct audit_buffer *ab)
> +{
> +	struct sk_buff *skb;
> +
> +	if (!ab)
> +		return;
> +
> +	while ((skb = skb_dequeue(&ab->skb_list)))
> +		__audit_log_end(skb);

The wakeup should go here.

>  	audit_buffer_free(ab);
>  }

--
paul-moore.com
