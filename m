Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F9D51F237E
	for <selinux@vger.kernel.org>; Wed, 12 Mar 2025 23:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741823498; cv=none; b=l7FyMqSwE/GnV5Jb4yG+bAc6pn3YkUIIEabsy2fMxo2OLYeONfx0PK799/NMGTenjTJw008aE5HKoZARa9ylfo9ZcRvoRvBsHZfNAwGYbTHHM5UZaMHk/Gg/21mQ8mwfuGcYmAVlHyFO9HZoW4VaHM/KnunIa1Y1566aG8txMqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741823498; c=relaxed/simple;
	bh=y6im2FC9RnrBK0DsITVVl0clIoDEu4fT57zPgo7oKQI=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=WFv3mrZdz3gT2Sw6ItFJOdME2G+iHHzunYHif5t0Z92ggDH0q0HjOMChH9VYgMUaQh5+UuyIXQEz7/C887ggCe/TGT+tM8DIErIiDCY4uqFsWfkX7xS+Bw9LdEjEU6piiTf7UssPxzTkfXvYGenEW3dJhLcPCFHLO+t6IsTaFoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=aagWl5ht; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="aagWl5ht"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7c56321b22cso45023885a.1
        for <selinux@vger.kernel.org>; Wed, 12 Mar 2025 16:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1741823495; x=1742428295; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qEHvEcO4NOg0YRDF2fNEp3c9gsS6yXYNEicVD7ca+jg=;
        b=aagWl5htvm96U1T2VDK+wTQWnB3Os1O1B4Smq1jlsN18q5uwQA1ye/O7YN9OFTgSYL
         Q+5F76wxKqehkXX2JLKFrrPcUFOEhyaS/xp+ARN/5ANK6NAe5KtqkkNhq0cS275kr5ET
         cfFb/pGJ4yCTm/8OFF3b9Cd2GdS+CrDaiHpmQ3ktrtByR2ZIC238a6tZgpeBAY2MXROo
         gKhuRVk+lCXBzwjypUwZFPWGreAN41yWzjA10hNffGY3/YxPC2nqDvyaqR/rqn7xWX3J
         Arc/43oUVhEoAcDOOEOwE12DI2UXwFlbJ+UnfSruPN8xj1jekQUB7+5h0PJB+yskVL58
         Uv+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741823495; x=1742428295;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qEHvEcO4NOg0YRDF2fNEp3c9gsS6yXYNEicVD7ca+jg=;
        b=l1TTm7dBFbimLAMEp9Cthw66mRfWVonCmpZEKswG7s4rfyJOQmMQ5eOYBtBNNxqvwY
         iV0TiqaLvttlk3RmRgYXSk2dVMGx9kq+pQwhZc+fsOTh5fZuTxTlgIR8xNX7pHdj7+M0
         3+uj3lPDqyKZh7CI+Tt7XNsXrEvWfumrbIdHCiHZyWhSPpx2OWajc+vzUM/7A0SVnlvI
         9w62f1XZ2RKeRgfhh8a6ha17igWzo+GVGHAhpp0i1M7Lm4s2z8eX/JAk2vDgcmtpNxPh
         rK2rEotIlZicORxxRIh3OTf88fACOYgWVp+BaVCOIzqudhdWja5RcrQ/MI/VhGTjr/B7
         pl5g==
X-Forwarded-Encrypted: i=1; AJvYcCVT9a0qkImY/59GP5W5b7MrZc0y3Vt+iyIBIxDyGnPvZG23VjvbZo+jDFuXSQzv8DSaZWbCmxQn@vger.kernel.org
X-Gm-Message-State: AOJu0YzXYiijYVKixQohd6LQ132wQLqAjg70NLNirxzNT8XMRhsUbPg4
	J/8ui9CxIl47cWz1/J7lCk3rT5JgCc/ekhL0hCDil0g6bD5iEK5u7q7qsrWIKA==
X-Gm-Gg: ASbGncuItYtlUvOBdovhHEhv5VG1K32Bv8jSjPUz1WOpbUUgyMPmnuRRflqExmN4wnv
	sir/OFcd8wKM/d/ARtl++24xoJv3VGZUUZ0vxBWwHc4znVQ2pUwIpTc8ZkoeLoCNjjXqWf2Jm/D
	mG/ZgiUC1qahyPazxJdaSqMSSFTFtPKlOtlXoHwIiAeQB+bFAO9O5awLTGVieqe+lRS1pom+oEw
	PKyqNF/gIh2JIu8AhIU/8LovcpWLzLL3nPKO/DTQuTckIf+JPWtXRBSBJuMlmr+L62KANQo3AQZ
	sC7limkl325S1peED+lxhXyhfDay7Xc3sqF2ZOmS3kQ05uDPu8NaWQuR5laldGJajl9jZzpEwvS
	kYUChNaEEMtcrjQ==
X-Google-Smtp-Source: AGHT+IEW0E6G8sFUJZrXjgx8IgIO7dCL/me5AKtsty8GXdCJQbxSmByGBM0HaBvG1kOgomgjfgPzCw==
X-Received: by 2002:a05:620a:13d0:b0:7c0:add8:1759 with SMTP id af79cd13be357-7c5737b8c7dmr71231985a.18.1741823495217;
        Wed, 12 Mar 2025 16:51:35 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7c573c9d8b8sm18772585a.53.2025.03.12.16.51.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 16:51:34 -0700 (PDT)
Date: Wed, 12 Mar 2025 19:51:34 -0400
Message-ID: <69ee16ce82a564e09b2060d46fa2be0d@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20250312_1930/pstg-lib:20250312_1930/pstg-pwork:20250312_1930
From: Paul Moore <paul@paul-moore.com>
To: Casey Schaufler <casey@schaufler-ca.com>, casey@schaufler-ca.com, eparis@redhat.com, linux-security-module@vger.kernel.org, audit@vger.kernel.org
Cc: jmorris@namei.org, serge@hallyn.com, keescook@chromium.org, john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org, selinux@vger.kernel.org
Subject: Re: [PATCH v2 2/6] Audit: Allow multiple records in an audit_buffer
References: <20250307183701.16970-3-casey@schaufler-ca.com>
In-Reply-To: <20250307183701.16970-3-casey@schaufler-ca.com>

On Mar  7, 2025 Casey Schaufler <casey@schaufler-ca.com> wrote:
> 
> Replace the single skb pointer in an audit_buffer with
> a list of skb pointers. Add the audit_stamp information
> to the audit_buffer as there's no guarantee that there
> will be an audit_context containing the stamp associated
> with the event. At audit_log_end() time create auxiliary
> records (none are currently defined) as have been added
> to the list. Functions are created to manage the skb list
> in the audit_buffer.
> 
> Suggested-by: Paul Moore <paul@paul-moore.com>
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>  kernel/audit.c | 111 +++++++++++++++++++++++++++++++++++++++----------
>  1 file changed, 89 insertions(+), 22 deletions(-)

This may need to be squashed with a later patch as I get
"defined but not used" warnings/errors for audit_buffer_aux_{new,end}().

> diff --git a/kernel/audit.c b/kernel/audit.c
> index 2a567f667528..a4945f1c3ec0 100644
> --- a/kernel/audit.c
> +++ b/kernel/audit.c
> @@ -2412,26 +2471,14 @@ int audit_signal_info(int sig, struct task_struct *t)
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
> @@ -2442,6 +2489,26 @@ void audit_log_end(struct audit_buffer *ab)
>  		wake_up_interruptible(&kauditd_wait);

We should probably move the kauditd thread wake into audit_log_end()
so we don't end up poking the scheduler multiple times.

>  	} else
>  		audit_log_lost("rate limit exceeded");
> +}
> +
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

Put the kauditd thread wake here.

>  	audit_buffer_free(ab);
>  }
> -- 
> 2.47.0

--
paul-moore.com
