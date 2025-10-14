Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E56CA2FAC03
	for <selinux@vger.kernel.org>; Tue, 14 Oct 2025 23:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760483575; cv=none; b=JKKsRloWhhnJlSTOPGupWaxtN45azuvswDjCkFsdQFGtbCLczgmGun4jc4T0EV2HqUja887Lqh9M8Kv6eBXcvFSB6QLkDp++Xo6WJ7g/NFaQOnl1I5LqSn5ybH5soslbthoKpcEWQzfjb860w87+YFDWcq2e6fLXxpS8tobhIoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760483575; c=relaxed/simple;
	bh=pqapgx3SjFaiVLjTtl9ZYj2hBgm63UGXxUD3Vh5H9m0=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=jUtqB3ApOgFBAVcWK9QYpdUJ9E+SySoA7cD5pJcdDlVVMqO/b1gC+6kKFBHw75kELNx2+7VmOKr0+Kk0hHsgULNdtcMVDaClgfm1+HDiuOJF8e1Oib1LPLa2XuXgsKJgK6yYBNeyBKBRM7vYCzQSSH1a87eoiLGVPf2Fp6PdOVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=MQaqD3U9; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="MQaqD3U9"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-88e32ad012cso10511985a.2
        for <selinux@vger.kernel.org>; Tue, 14 Oct 2025 16:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1760483573; x=1761088373; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ps8OB349up+2JiXOOAUFOzgYyyG71oedxuIe/5L+TTI=;
        b=MQaqD3U9+xOyUqIFdbpUou2sBimqG5nyiMeV/xmWu1Wl7qA+KnYmQesHKndJCEV0Jo
         5/mgTsFavaip7r0VuFrXc00yS6oSo52I6WLPLd5j+3jompo7qqRcRWgco+qMdWYYnef4
         S1kAcXAt2YK2o8nkSgfAVOvqnxvUXZSnADKYMM5A5etSeCgqA+WXx36KlmyeQhttfY1v
         xppq5+CZmPQEsbYXVjzZW2OtFwewYo+z4qosKFf5TKDOu4mmMLPPCV8JeG4kdIdBIOz6
         UvS6jY7MmxY1WceJAgfVt1Ung41gYynYSp33hREqSVO5USmj084Hbc8PDnoA4x7ShylE
         4bag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760483573; x=1761088373;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ps8OB349up+2JiXOOAUFOzgYyyG71oedxuIe/5L+TTI=;
        b=skz/PAxuFJvVcI4jkJ5HkRUeF8lwyhCSOSTKWoG44T8nHhAjGef9/B6ClbgAqqRKGS
         mlA9nkMwSVflpp3s5BEi+XlDmWgcrEYlbo6CX+zGzwmXWarUPzf+bL9Xg00FV/Fe5dyq
         sHO9c1dtCA1voQt9db/YQSQEk72yuVUzNEtFLpptvkqnRxzcA1aphHGPhUgvUH7w61BT
         4lHW0SRCM43wb9cqgnlLQHQivfe4ccFWhjtyDwHYcLpfWVfu+kP55u+gaoi22qJ0I+CY
         XOiLjXe4OummlMW5UHug1RcrLSD2jTpmUS43XeaQ3e9xxaWjk1nYeAMY3S3QckQ7y6jf
         /ogg==
X-Forwarded-Encrypted: i=1; AJvYcCXqIC6RD6tkWG6DiIJwyKtPXH8NFqajnXJnGVZJNersCNpTrX9+5Jo1/ZpoFpGeAGI3UedP2ssz@vger.kernel.org
X-Gm-Message-State: AOJu0YytkWjdPBhfslgclLtVoae4oYpbC3xu9hJ2S9xglJd+ov+NYBk6
	ZspzMJqPorEhtIja8XgQBocI8tO8ic+EmcqX1JEGV2N5o9fxO4fP9a05Q+cw7M9UpA==
X-Gm-Gg: ASbGncsRqD4sBY4wO+5NoJTWcjM9/mi1RZqND5PziudCNfAM5j6UwF/dF0W8X5TtxMK
	mYqJXfj7FmKDoP117mrFzBP9an4HWKY1FRiF63AMhHzHngVuInNGJdMTgvjKNjL8cnb/4eWnW2s
	YCU18jyOFlLbZFwnfehrn9gMPTCvFE94EkkhAvZbztGEq4b72NRzoYsh3E/Y98vzN9K627mDKp4
	wZTc+PzzMUZlEnwgfap7EwHC/LELH4pYM1wZ6VkUoU+nZmxk0nhFioXeH0SeeqeBB/rQ7NmBgE1
	2JBniSnPR7p484X70h/pdCgRqxIWK6YYOO7t159aH9QZ/75OMLiyZpeLouSMYpeKSQpv2wH+Epq
	o0A3Auh0Gewy5xU7DnDYRSllttl7viuc+ssR76DKAEtMHiBWABmtUHDKCI8Wd1R+rl5hY6XXF4f
	O0YZPVR7hXl+o=
X-Google-Smtp-Source: AGHT+IH2kJu3p5TXj14jePlOqpBlixzbhxeJPUr5Dl1KA11KjKhjkHDMYoCi0UavIwCqCbLXkHZG5A==
X-Received: by 2002:a05:622a:1b1d:b0:4e3:16bd:3e16 with SMTP id d75a77b69052e-4e6ead5b614mr441408041cf.56.1760483572924;
        Tue, 14 Oct 2025 16:12:52 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-4e881c86dd0sm7554211cf.15.2025.10.14.16.12.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 16:12:52 -0700 (PDT)
Date: Tue, 14 Oct 2025 19:12:51 -0400
Message-ID: <36f0c22554337b4d5551eabee2d86479@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20251014_1821/pstg-lib:20251014_1132/pstg-pwork:20251014_1821
From: Paul Moore <paul@paul-moore.com>
To: Casey Schaufler <casey@schaufler-ca.com>, casey@schaufler-ca.com, eparis@redhat.com, linux-security-module@vger.kernel.org, audit@vger.kernel.org
Cc: jmorris@namei.org, serge@hallyn.com, keescook@chromium.org, john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org, selinux@vger.kernel.org
Subject: Re: [PATCH RFC 7/15] Audit: Call only the first of the audit rule  hooks
References: <20250621171851.5869-8-casey@schaufler-ca.com>
In-Reply-To: <20250621171851.5869-8-casey@schaufler-ca.com>

On Jun 21, 2025 Casey Schaufler <casey@schaufler-ca.com> wrote:
> 
> The audit system is not (yet) capable for distinguishing
> between audit rules specified for multiple security modules.
> Call only the first registered of the audit rule hooks.
> The order of registration, which can be specified with the
> lsm= boot parameter, is hence an important consideration.
> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>  security/security.c | 30 ++++++++++++++++++++++++++----
>  1 file changed, 26 insertions(+), 4 deletions(-)
> 
> diff --git a/security/security.c b/security/security.c
> index 2286285f8aea..93d4ac39fe9f 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -5056,7 +5056,13 @@ void security_key_post_create_or_update(struct key *keyring, struct key *key,
>  int security_audit_rule_init(u32 field, u32 op, char *rulestr, void **lsmrule,
>  			     gfp_t gfp)
>  {
> -	return call_int_hook(audit_rule_init, field, op, rulestr, lsmrule, gfp);
> +	struct lsm_static_call *scall;
> +
> +	lsm_for_each_hook(scall, audit_rule_init) {
> +		return scall->hl->hook.audit_rule_init(field, op, rulestr,
> +						       lsmrule, gfp);
> +	}
> +	return LSM_RET_DEFAULT(audit_rule_init);
>  }

Similar to the comments in patch 5/15, what would it look like to do the
enforcement of this callback restriction at LSM registration time?

>  /**
> @@ -5070,7 +5076,12 @@ int security_audit_rule_init(u32 field, u32 op, char *rulestr, void **lsmrule,
>   */
>  int security_audit_rule_known(struct audit_krule *krule)
>  {
> -	return call_int_hook(audit_rule_known, krule);
> +	struct lsm_static_call *scall;
> +
> +	lsm_for_each_hook(scall, audit_rule_known) {
> +		return scall->hl->hook.audit_rule_known(krule);
> +	}
> +	return LSM_RET_DEFAULT(audit_rule_known);
>  }
>  
>  /**
> @@ -5082,7 +5093,12 @@ int security_audit_rule_known(struct audit_krule *krule)
>   */
>  void security_audit_rule_free(void *lsmrule)
>  {
> -	call_void_hook(audit_rule_free, lsmrule);
> +	struct lsm_static_call *scall;
> +
> +	lsm_for_each_hook(scall, audit_rule_free) {
> +		scall->hl->hook.audit_rule_free(lsmrule);
> +		return;
> +	}
>  }
>  
>  /**
> @@ -5101,7 +5117,13 @@ void security_audit_rule_free(void *lsmrule)
>  int security_audit_rule_match(struct lsm_prop *prop, u32 field, u32 op,
>  			      void *lsmrule)
>  {
> -	return call_int_hook(audit_rule_match, prop, field, op, lsmrule);
> +	struct lsm_static_call *scall;
> +
> +	lsm_for_each_hook(scall, audit_rule_match) {
> +		return scall->hl->hook.audit_rule_match(prop, field, op,
> +							lsmrule);
> +	}
> +	return LSM_RET_DEFAULT(audit_rule_match);
>  }
>  #endif /* CONFIG_AUDIT */
>  
> -- 
> 2.47.0

--
paul-moore.com
