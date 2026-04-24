Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9425B239E80
	for <selinux@vger.kernel.org>; Fri, 24 Apr 2026 01:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776993561; cv=none; b=meNhZqj5vnWoB9NBEDXczS8B0Nctafm78g4i2/Uqjia51oJHOanL8f0u/QwOQJqX25sWVBMv2jGeO0Wca9ahW8LagEysjyVtZYzrlh3uYzw8QIjUMojuKJK2yPrzW3a2sAeqBtXr/CbJQPGHyfNsjQsAxGpH0LdlC9D9skwInTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776993561; c=relaxed/simple;
	bh=ij9Pg06cwGlVhbY+NNZfS2WZnAX5v7IQK0Qw0ifvhyM=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=qeV3AhQLPhB1ZBlXPwRNK/eyS2nhY7wqGM4Q5g32gohck7uPfrRLb/PQBhG49c52DVWKNuPnEL8a6hT8X2ungz3sTFgh7oBHj1EDHsmOj9dd8jr+1hvvIVFxnUrum4E9AkHojMO+neuMCh9Nhm6oM71lKMfx8+yxFafIID6NeTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Yife3xwz; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Yife3xwz"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-8a5800772f3so53464096d6.2
        for <selinux@vger.kernel.org>; Thu, 23 Apr 2026 18:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1776993559; x=1777598359; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p2U7HbtFyLcLRJfb5uoL9jhQ9iyviSSc4HFqXZsgI0M=;
        b=Yife3xwzCgW7NMgFGV7aOHeuRYEffDrjEiGtRuMsBG+2me4EjyzLoEf935jvgyj3m8
         +FbgGrmMHrUzOuASAIYfax8wrGKtZ/wJtVOm15QySvG7ZZep7uEQg5xEZW4qgQg/MBTK
         duCChXtF00XJ6KuUvXF9cKOtmNdiMIGrTFx4RZZa4ns5lhsYE5C2AtjJqU/7c+uaMyYQ
         9SStfVACnJhHfKWmBicry4NpSYmEfQ4yhMvOq9+MDxGgJTlzYv1ASW6q4my7VppmTSrn
         4nNDdc1oapjQlLkrXYy28w2o0/PuPg+RIpzCFQJfzhESJnRe57pfsTP7gZQOaR0TWq1J
         mlkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776993559; x=1777598359;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p2U7HbtFyLcLRJfb5uoL9jhQ9iyviSSc4HFqXZsgI0M=;
        b=njxHdFJH6tBKmKqfw85JfmP+3toXJY3Dlor/WVs9OFIoIZoo7FlAvKePYVtHMKGA/y
         mjI4hBG5N+NQx9epsMeSTOuAOpHETDHefYWdhV2U4bhGZQ7luDvBKZhcA/mWFyAqQcIp
         TSy7O36toA+OiZDOU+r3eUIGizEmJWBh+XSJf5iZVvFXz1vuECojuV3a6lFwz+hc8m92
         xJ2GOcJgDYzey82s6PJj06wNPp80R/TYZa3PJiAl1wsK0yHgZuEakyzJPng7aNYPfnOX
         V0IYPt3r+HQSEHSOtn0upMr2NR6Jc3ctKqekIFfufHMs+57BCL8C0Pf4gCsY04t2z74Q
         Kcrw==
X-Forwarded-Encrypted: i=1; AFNElJ+CZKoiwZ/2Z5Dk0KgTWVEgC9KnvMqYbHg1ONBxbH6P87IbrnikfLqfsVTW8YDDlYIlCZeOt+hw@vger.kernel.org
X-Gm-Message-State: AOJu0YzmdRiqmaxR1bpC7P4UgKqBPoYrNaMvJHuH62H7WgFLsg3HVhxm
	s/HuGHIJecpWhGUrbkhP81kIfjhg/isMBm34lEJ1tKALyY4hxfMGC1+mBBdu4SqWkw==
X-Gm-Gg: AeBDieurSy7bFN8A1/oMairz/8NuqZrmnmR0zmYI2TDiIhxDdElEI5T3sMZdeNAnci4
	mBZl/6fVEQ0A1z07+wJ9RNBJG88k90Xd9DrD8zyoy1pVHlfjRr21Sf6n4ROr+iyGi+L4/NxNPag
	PsptwP3HBAjREn48N2kAM3eI/vrjQhodymEM+dEpRDTGAoJVqflNw826QW1RyQDfVDq36TyNEJ3
	T0AKrYArURtl+24urwaDuxd84mgTBzqtmeGwbYuLEp204jtNeWMSSSX2hzHRoWxAZp5JSfHmFwS
	o8JxHXi1WrwjAQ7OuqJCMzqeTscNrENttcS1dPybFvUokJvMQeOd0ZlxMo6f/e2Rc33K1tPaqyV
	sArd9CP70V26M6d/Q0kX3JYRkO3Zy8t5Jo0naaTVMVqQIV7bjpc/KG8PFYAUWGvgJbwa8Vo2nPP
	Kp/yTJI6wYeYZfPrqIORFaJ3q8yh57xYPGi3g8loTT6ypla0PNMBSJo31BqV2S+AnDx+MOSw63x
	/A2wWI=
X-Received: by 2002:a05:6214:2c03:b0:8ac:b7f1:adf2 with SMTP id 6a1803df08f44-8b02804585fmr470879476d6.12.1776993559553;
        Thu, 23 Apr 2026 18:19:19 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b02ae5eaf1sm174674356d6.30.2026.04.23.18.19.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 18:19:18 -0700 (PDT)
Date: Thu, 23 Apr 2026 21:19:17 -0400
Message-ID: <8fa09781ac340398fb2b914bf29d9dcb@paul-moore.com>
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
Subject: Re: [PATCH RFC 3/3] LSM: Reserve use of secmarks
References: <20260225192143.14448-4-casey@schaufler-ca.com>
In-Reply-To: <20260225192143.14448-4-casey@schaufler-ca.com>

On Feb 25, 2026 Casey Schaufler <casey@schaufler-ca.com> wrote:
> 
> Use of "exclusive" LSM hooks are limited to the first LSM registering
> them. These hooks include those use to process network secmarks.
> The hooks required to process secmarks are flagged with LSM_FLAG_EXCLUSIVE
> in their definitions. This includes secid_to_secctx and secctx_to_secid,
> which are used by netfilter.
> 
> The various LSMs that use secmarks are updated to detect whether
> they are providing exclusive hooks, and to eschew the use of secmarks
> if they are not.
> 
> SELinux has a peculiar behavior in that it may decide that it
> must have network controls, but only after policy is loaded.
> This patch includes a warning should policy capability alwaysnetwork
> be set when another LSM holds the exclusive hooks. It has been
> suggested that SELinux would consider this a fatal condition, in
> which case a panic might be a favored, if draconian, option.
> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>  include/linux/lsm_hook_defs.h    | 12 +++++------
>  include/linux/security.h         |  1 +
>  security/apparmor/lsm.c          | 24 ++++++++++++++++------
>  security/security.c              | 15 ++++++++++++++
>  security/selinux/hooks.c         | 35 ++++++++++++++++++++++++--------
>  security/selinux/ss/services.c   |  3 +++
>  security/smack/smack_lsm.c       |  6 ++++--
>  security/smack/smack_netfilter.c |  6 ++++++
>  8 files changed, 80 insertions(+), 22 deletions(-)

...

> diff --git a/include/linux/security.h b/include/linux/security.h
> index e3c137a1b30a..638436b9b748 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -326,6 +326,7 @@ int unregister_blocking_lsm_notifier(struct notifier_block *nb);
>  extern int security_init(void);
>  extern int early_security_init(void);
>  extern u64 lsm_name_to_attr(const char *name);
> +extern u32 lsm_secmark_from_skb(struct sk_buff *skb, const u64 lsmid);
>  
>  /* Security operations */
>  int security_binder_set_context_mgr(const struct cred *mgr);
> diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
> index a87cd60ed206..2ce0d9a73973 100644
> --- a/security/apparmor/lsm.c
> +++ b/security/apparmor/lsm.c
> @@ -1511,9 +1511,11 @@ static int apparmor_socket_shutdown(struct socket *sock, int how)
>  static int apparmor_socket_sock_rcv_skb(struct sock *sk, struct sk_buff *skb)
>  {
>  	struct aa_sk_ctx *ctx = aa_sock(sk);
> +	u32 secmark;
>  	int error;
>  
> -	if (!skb->secmark)
> +	secmark = lsm_secmark_from_skb(skb, LSM_ID_APPARMOR);
> +	if (!secmark)
>  		return 0;
>  
>  	/*

...

> diff --git a/security/security.c b/security/security.c
> index 25e7cfc96f20..754b16004677 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -4509,6 +4509,21 @@ void security_inet_conn_established(struct sock *sk,
>  }
>  EXPORT_SYMBOL(security_inet_conn_established);
>  
> +/**
> + * lsm_secmark_from_skb - secid for the specified LSM from the packet
> + * @skb: the packet
> + * @lsm: which LSM is asking
> + *
> + * If the specified LSM has use of the secmark, return its value.
> + * Otherwise, return the invalid secid 0.
> + */
> +u32 lsm_secmark_from_skb(struct sk_buff *skb, const u64 lsmid)
> +{
> +	if (lsmid == lsm_exclusive_hooks)
> +		return skb->secmark;
> +	return 0;
> +}

Ooof.  Not a fan.  A better way to handle this would be to like I
mentioned in my comments on patch 2/3: have the LSM detect that it lost
the LSM_FLAG_EXCLUSIVE battle at callback registration time and do
whatever adjustments are necessary at init time.  In a number of cases I
believe that simply not registering the callback will be sufficient.

If the only way to solve this is via runtime checks like this,
unfortunately my answer is going to be "no".

... and of course the proper way to solve this for secmark is to just
do the idr/xarray conversion for secmarks so every LSM can have their
own secmark.  Yes, it does require some work, but to be honest I think
you've spent more time avoiding that work then it would be to just do
it.  I'm growing increasing inclined to simply state that this is the
only solution I'm going to accept.

--
paul-moore.com
