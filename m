Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF40A25634
	for <selinux@vger.kernel.org>; Mon, 16 Dec 2024 02:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734316033; cv=none; b=THnN8S/l3PZz+HlG0QtjoecDLGHQ96am+1Y9Bd0onZPpnaHfuSrzbOjvRixnWHLahGYZibHI8+TVmeTZdskUO+vqZZd7P/+35iMcw3MP3rRn4xwzQJtzRnx4W0d5i9cN6NHg4I2UJImLktO4EvVR/lvjKoy5zoLKbc/SzU7Y8hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734316033; c=relaxed/simple;
	bh=waSsQwS2jtMN8Eq6fsGxPekvAW/JUAGGw2fXyICfboE=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=W/uW2uu+JAQ9kZFN05GHACedXNRNdT4Kwk4s4jhj8D4sRpfOlQ5nMwSlh0O1iUmZkrE+PoXObdiOAh78QJ3i8ogocJnb0oO9j4TZGNGrDu3BETeeTsq5bIZ5dr7JJA5sC85YCJL2qEtl/mfnc34Rz8ARoVzQpjqMiKoJnKKx2pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=OtdZsK+9; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="OtdZsK+9"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6d8e8445219so32604696d6.0
        for <selinux@vger.kernel.org>; Sun, 15 Dec 2024 18:27:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1734316029; x=1734920829; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aYO9HW5YvGjHfi7BvRJa+JTAWWPtDb4IF4khzdV5HPs=;
        b=OtdZsK+9KDfxRUJLOR8DJbLgAkrmKUVzYW1KqRldn8PeIQwQDSnGzW7qw63ITVtYFZ
         au5KAGDCKbh+fSat2BED2knM7OB+fVhFEfFYCt1rIXY9mGsFtNTAtEa9rwwW2PFYB60J
         E+cAANNC7+QKx5roLrC8feD1nzoOi9m9zwYZFDpa03nRW1DD1UkdSouX47hrFxrZNxim
         y/zCUGAsf6H06uzR3KYNH9deGHK9rW8bH60vb5IKySPBXUmLcK7VbetSscsIgK03Q3Ut
         xBYp6Y+5ehNdAYD+WT3CbJszql7VjKO4tc+Jq2XjjAPYAOmwpzHZTOCBs5FJeb48fEEH
         zeag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734316029; x=1734920829;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=aYO9HW5YvGjHfi7BvRJa+JTAWWPtDb4IF4khzdV5HPs=;
        b=Ew2fmnwgPE5dq8HgoW7ll+Hn7VNH8x8NSLtN1sHv09JHLmCWCUpMwtir/yvKrAiRxv
         b6h39kxexpWTsCz3otm//I9EfhQEo4+EDdwGs3QftcCHXIou2EHwGJNLrx54kbah1m2w
         8DXO53QUREAwjpt3wgitC2i4vN6ZeKTM8uWobf0Ff2EPUpvZlG+GLETypVlzBPVWnxmJ
         /bo9vpgxcPm3mthdUl5gh13XkVSaxJmGB/LBbpBy5nmWui3PsC6bOSMZS5z+yiXAn15d
         hXnz5BioAlTekDruh47qA1gwj+nkztUWQnvvPDbE7f7gvnDZPY6nO84ir7KngZQiE/xw
         3uzA==
X-Forwarded-Encrypted: i=1; AJvYcCUTmOBXhPHGTKMA2AEJ1qXqhy+z9BqEoX27vRnwDCMtNSfnA3CurgwGWuzoJn+h+aGPBgAMwwxb@vger.kernel.org
X-Gm-Message-State: AOJu0YyX25lCWNR733XNM0zaVeaS/zWOD76K7pE3b3JYlbvRIrZgGuIU
	sf52cqeWCUTXEL2vSHR/bZNUODKrxyWFYfOqsOyasC6+BSKJ/plicsK/3jp2EZUoa4ck9FFAbz8
	=
X-Gm-Gg: ASbGncu0QWwCRQG9JcQ1BxuwnHqrkLGNnd28734Ypvf1cm9EUqDIfP1qxzJ4YA7CHWs
	gzrS7r21QO+sH3k1LN0UeFkak4FWqX6CIPGpxciorVESYBp1kUFFpLSk7j9i2xNdrZD05/gbCnI
	6pw9RDf38fIUZHKJ76x4hisGDOBspQKoF51SR2zhLoM3kUBJprYgWcWst7k4jtJbORxEv+zl4m7
	6nXudEF2HTVTzeiVxqWagfR/WnJIAB/Q/Ss1Unsfy74Vi8zWyg=
X-Google-Smtp-Source: AGHT+IE+b6BwYVEJpAO2jz74UPCRtvcH9afwaGWYGAYwmv1aSe80tO2uHUy9oht2/cjgaMwpcSn7jw==
X-Received: by 2002:ad4:5ec8:0:b0:6d8:aa14:f5b8 with SMTP id 6a1803df08f44-6dc9684d68fmr155749816d6.40.1734316029335;
        Sun, 15 Dec 2024 18:27:09 -0800 (PST)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6dccd2795e9sm22508246d6.66.2024.12.15.18.27.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Dec 2024 18:27:08 -0800 (PST)
Date: Sun, 15 Dec 2024 21:27:08 -0500
Message-ID: <d1c9371289fa2823e032a489925ad03f@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20241215_1918/pstg-lib:20241215_1918/pstg-pwork:20241215_1918
From: Paul Moore <paul@paul-moore.com>
To: "=?UTF-8?q?Thi=C3=A9baud=20Weksteen?=" <tweek@google.com>
Cc: "=?UTF-8?q?Christian=20G=C3=B6ttsche?=" <cgzones@googlemail.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, "=?UTF-8?q?Bram=20Bonn=C3=A9?=" <brambonne@google.com>, Jeffrey Vander Stoep <jeffv@google.com>, selinux@vger.kernel.org, "=?UTF-8?q?Thi=C3=A9baud=20Weksteen?=" <tweek@google.com>
Subject: Re: [PATCH] selinux: match extended permissions to their base  permissions
References: <20241205014951.1451858-1-tweek@google.com>
In-Reply-To: <20241205014951.1451858-1-tweek@google.com>

On Dec  4, 2024 "=?UTF-8?q?Thi=C3=A9baud=20Weksteen?=" <tweek@google.com> wrote:
> 
> In commit d1d991efaf34 ("selinux: Add netlink xperm support") a new
> extended permission was added ("nlmsg"). This was the second extended
> permission implemented in selinux ("ioctl" being the first one).
> 
> Extended permissions are associated with a base permission. It was found
> that, in the access vector cache (avc), the extended permission did not
> keep track of its base permission. This is an issue for a domain that is
> using both extended permissions (i.e., a domain calling ioctl() on a
> netlink socket). In this case, the extended permissions were
> overlapping.
> 
> Keep track of the base permission in the cache. A new field "base_perm"
> is added to struct extended_perms_decision to make sure that the
> extended permission refers to the correct policy permission. A new field
> "base_perms" is added to struct extended_perms to quickly decide if
> extended permissions apply.
> 
> While it is in theory possible to retrieve the base permission from the
> access vector, the same base permission may not be mapped to the same
> bit for each class (e.g., "nlmsg" is mapped to a different bit for
> "netlink_route_socket" and "netlink_audit_socket"). Instead, use a
> constant (AVC_EXT_IOCTL or AVC_EXT_NLMSG) provided by the caller.
> 
> Fixes: d1d991efaf34 ("selinux: Add netlink xperm support")
> Signed-off-by: Thiébaud Weksteen <tweek@google.com>
> ---
>  security/selinux/avc.c              | 61 ++++++++++++++++-------------
>  security/selinux/hooks.c            |  6 +--
>  security/selinux/include/avc.h      |  5 ++-
>  security/selinux/include/security.h |  3 ++
>  security/selinux/ss/services.c      | 23 ++++++++++-
>  5 files changed, 65 insertions(+), 33 deletions(-)

Just to make sure we are on the same page with this, my opinion is that
this should go up to Linus during the v6.13-rcX cycle as part of
selinux/stable-6.13, but not marked for the stable kernels as the netlink
xperm support was first added in v6.13-rc1; does that sound right to you?

> diff --git a/security/selinux/avc.c b/security/selinux/avc.c
> index cc0b0af20296..1f2680bcc43a 100644
> --- a/security/selinux/avc.c
> +++ b/security/selinux/avc.c
> @@ -174,13 +174,15 @@ int avc_get_hash_stats(char *page)
>   * using a linked list for extended_perms_decision lookup because the list is
>   * always small. i.e. less than 5, typically 1
>   */
> -static struct extended_perms_decision *avc_xperms_decision_lookup(u8 driver,
> -					struct avc_xperms_node *xp_node)
> +static struct extended_perms_decision *
> +avc_xperms_decision_lookup(u8 driver, u8 base_perm,
> +			   struct avc_xperms_node *xp_node)
>  {
>  	struct avc_xperms_decision_node *xpd_node;
>  
>  	list_for_each_entry(xpd_node, &xp_node->xpd_head, xpd_list) {
> -		if (xpd_node->xpd.driver == driver)
> +		if (xpd_node->xpd.driver == driver &&
> +		    xpd_node->xpd.base_perm == base_perm)
>  			return &xpd_node->xpd;
>  	}
>  	return NULL;
> @@ -205,11 +207,12 @@ avc_xperms_has_perm(struct extended_perms_decision *xpd,
>  }
>  
>  static void avc_xperms_allow_perm(struct avc_xperms_node *xp_node,
> -				u8 driver, u8 perm)
> +				  u8 driver, u8 base_perm, u8 perm)
>  {
>  	struct extended_perms_decision *xpd;
>  	security_xperm_set(xp_node->xp.drivers.p, driver);
> -	xpd = avc_xperms_decision_lookup(driver, xp_node);
> +	xp_node->xp.base_perms |= base_perm;

Should this be a "= base_perm" instead of a "|= base_perm"?  Would this
work with multiple base_perm values?  Would we want it to work for
multiple base_perm values?

These questions also applies to similar logic later in the patch.

> +	xpd = avc_xperms_decision_lookup(driver, base_perm, xp_node);
>  	if (xpd && xpd->allowed)
>  		security_xperm_set(xpd->allowed->p, perm);
>  }
> @@ -245,6 +248,7 @@ static void avc_xperms_free(struct avc_xperms_node *xp_node)
>  static void avc_copy_xperms_decision(struct extended_perms_decision *dest,
>  					struct extended_perms_decision *src)
>  {
> +	dest->base_perm = src->base_perm;
>  	dest->driver = src->driver;
>  	dest->used = src->used;
>  	if (dest->used & XPERMS_ALLOWED)
> @@ -272,6 +276,7 @@ static inline void avc_quick_copy_xperms_decision(u8 perm,
>  	 */
>  	u8 i = perm >> 5;
>  
> +	dest->base_perm = src->base_perm;
>  	dest->used = src->used;
>  	if (dest->used & XPERMS_ALLOWED)
>  		dest->allowed->p[i] = src->allowed->p[i];
> @@ -357,6 +362,7 @@ static int avc_xperms_populate(struct avc_node *node,
>  
>  	memcpy(dest->xp.drivers.p, src->xp.drivers.p, sizeof(dest->xp.drivers.p));
>  	dest->xp.len = src->xp.len;
> +	dest->xp.base_perms = src->xp.base_perms;
>  
>  	/* for each source xpd allocate a destination xpd and copy */
>  	list_for_each_entry(src_xpd, &src->xpd_head, xpd_list) {
> @@ -807,6 +813,7 @@ int __init avc_add_callback(int (*callback)(u32 event), u32 events)
>   * @event : Updating event
>   * @perms : Permission mask bits
>   * @driver: xperm driver information
> + * @base_perm: the base permission associated with the extended permission
>   * @xperm: xperm permissions
>   * @ssid: AVC entry source sid
>   * @tsid: AVC entry target sid
> @@ -820,10 +827,9 @@ int __init avc_add_callback(int (*callback)(u32 event), u32 events)
>   * otherwise, this function updates the AVC entry. The original AVC-entry object
>   * will release later by RCU.
>   */
> -static int avc_update_node(u32 event, u32 perms, u8 driver, u8 xperm, u32 ssid,
> -			   u32 tsid, u16 tclass, u32 seqno,
> -			   struct extended_perms_decision *xpd,
> -			   u32 flags)
> +static int avc_update_node(u32 event, u32 perms, u8 driver, u8 base_perm,
> +			   u8 xperm, u32 ssid, u32 tsid, u16 tclass, u32 seqno,
> +			   struct extended_perms_decision *xpd, u32 flags)
>  {
>  	u32 hvalue;
>  	int rc = 0;
> @@ -880,7 +886,7 @@ static int avc_update_node(u32 event, u32 perms, u8 driver, u8 xperm, u32 ssid,
>  	case AVC_CALLBACK_GRANT:
>  		node->ae.avd.allowed |= perms;
>  		if (node->ae.xp_node && (flags & AVC_EXTENDED_PERMS))
> -			avc_xperms_allow_perm(node->ae.xp_node, driver, xperm);
> +			avc_xperms_allow_perm(node->ae.xp_node, driver, base_perm, xperm);
>  		break;
>  	case AVC_CALLBACK_TRY_REVOKE:
>  	case AVC_CALLBACK_REVOKE:
> @@ -987,10 +993,9 @@ static noinline void avc_compute_av(u32 ssid, u32 tsid, u16 tclass,
>  	avc_insert(ssid, tsid, tclass, avd, xp_node);
>  }
>  
> -static noinline int avc_denied(u32 ssid, u32 tsid,
> -			       u16 tclass, u32 requested,
> -			       u8 driver, u8 xperm, unsigned int flags,
> -			       struct av_decision *avd)
> +static noinline int avc_denied(u32 ssid, u32 tsid, u16 tclass, u32 requested,
> +			       u8 driver, u8 base_perm, u8 xperm,
> +			       unsigned int flags, struct av_decision *avd)
>  {
>  	if (flags & AVC_STRICT)
>  		return -EACCES;
> @@ -999,7 +1004,7 @@ static noinline int avc_denied(u32 ssid, u32 tsid,
>  	    !(avd->flags & AVD_FLAGS_PERMISSIVE))
>  		return -EACCES;
>  
> -	avc_update_node(AVC_CALLBACK_GRANT, requested, driver,
> +	avc_update_node(AVC_CALLBACK_GRANT, requested, driver, base_perm,
>  			xperm, ssid, tsid, tclass, avd->seqno, NULL, flags);
>  	return 0;
>  }
> @@ -1012,7 +1017,8 @@ static noinline int avc_denied(u32 ssid, u32 tsid,
>   * driver field is used to specify which set contains the permission.
>   */
>  int avc_has_extended_perms(u32 ssid, u32 tsid, u16 tclass, u32 requested,
> -			   u8 driver, u8 xperm, struct common_audit_data *ad)
> +			   u8 driver, u8 base_perm, u8 xperm,
> +			   struct common_audit_data *ad)
>  {
>  	struct avc_node *node;
>  	struct av_decision avd;
> @@ -1047,22 +1053,23 @@ int avc_has_extended_perms(u32 ssid, u32 tsid, u16 tclass, u32 requested,
>  	local_xpd.auditallow = &auditallow;
>  	local_xpd.dontaudit = &dontaudit;
>  
> -	xpd = avc_xperms_decision_lookup(driver, xp_node);
> +	xpd = avc_xperms_decision_lookup(driver, base_perm, xp_node);
>  	if (unlikely(!xpd)) {
>  		/*
>  		 * Compute the extended_perms_decision only if the driver
> -		 * is flagged
> +		 * is flagged and the base permission is known.
>  		 */
> -		if (!security_xperm_test(xp_node->xp.drivers.p, driver)) {
> +		if (!security_xperm_test(xp_node->xp.drivers.p, driver) ||
> +		    !(xp_node->xp.base_perms & base_perm)) {
>  			avd.allowed &= ~requested;
>  			goto decision;
>  		}
>  		rcu_read_unlock();
> -		security_compute_xperms_decision(ssid, tsid, tclass,
> -						 driver, &local_xpd);
> +		security_compute_xperms_decision(ssid, tsid, tclass, driver,
> +						 base_perm, &local_xpd);
>  		rcu_read_lock();
> -		avc_update_node(AVC_CALLBACK_ADD_XPERMS, requested,
> -				driver, xperm, ssid, tsid, tclass, avd.seqno,
> +		avc_update_node(AVC_CALLBACK_ADD_XPERMS, requested, driver,
> +				base_perm, xperm, ssid, tsid, tclass, avd.seqno,
>  				&local_xpd, 0);
>  	} else {
>  		avc_quick_copy_xperms_decision(xperm, &local_xpd, xpd);
> @@ -1075,8 +1082,8 @@ int avc_has_extended_perms(u32 ssid, u32 tsid, u16 tclass, u32 requested,
>  decision:
>  	denied = requested & ~(avd.allowed);
>  	if (unlikely(denied))
> -		rc = avc_denied(ssid, tsid, tclass, requested,
> -				driver, xperm, AVC_EXTENDED_PERMS, &avd);
> +		rc = avc_denied(ssid, tsid, tclass, requested, driver,
> +				base_perm, xperm, AVC_EXTENDED_PERMS, &avd);
>  
>  	rcu_read_unlock();
>  
> @@ -1110,7 +1117,7 @@ static noinline int avc_perm_nonode(u32 ssid, u32 tsid, u16 tclass,
>  	avc_compute_av(ssid, tsid, tclass, avd, &xp_node);
>  	denied = requested & ~(avd->allowed);
>  	if (unlikely(denied))
> -		return avc_denied(ssid, tsid, tclass, requested, 0, 0,
> +		return avc_denied(ssid, tsid, tclass, requested, 0, 0, 0,
>  				  flags, avd);
>  	return 0;
>  }
> @@ -1158,7 +1165,7 @@ inline int avc_has_perm_noaudit(u32 ssid, u32 tsid,
>  	rcu_read_unlock();
>  
>  	if (unlikely(denied))
> -		return avc_denied(ssid, tsid, tclass, requested, 0, 0,
> +		return avc_denied(ssid, tsid, tclass, requested, 0, 0, 0,
>  				  flags, avd);
>  	return 0;
>  }
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index f5a08f94e094..011d9121b3ab 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -3688,8 +3688,8 @@ static int ioctl_has_perm(const struct cred *cred, struct file *file,
>  		return 0;
>  
>  	isec = inode_security(inode);
> -	rc = avc_has_extended_perms(ssid, isec->sid, isec->sclass,
> -				    requested, driver, xperm, &ad);
> +	rc = avc_has_extended_perms(ssid, isec->sid, isec->sclass, requested,
> +				    driver, AVC_EXT_IOCTL, xperm, &ad);
>  out:
>  	return rc;
>  }
> @@ -5952,7 +5952,7 @@ static int nlmsg_sock_has_extended_perms(struct sock *sk, u32 perms, u16 nlmsg_t
>  	xperm = nlmsg_type & 0xff;
>  
>  	return avc_has_extended_perms(current_sid(), sksec->sid, sksec->sclass,
> -			perms, driver, xperm, &ad);
> +				      perms, driver, AVC_EXT_NLMSG, xperm, &ad);
>  }
>  
>  static int selinux_netlink_send(struct sock *sk, struct sk_buff *skb)
> diff --git a/security/selinux/include/avc.h b/security/selinux/include/avc.h
> index 96a614d47df8..281f40103663 100644
> --- a/security/selinux/include/avc.h
> +++ b/security/selinux/include/avc.h
> @@ -136,8 +136,11 @@ int avc_has_perm_noaudit(u32 ssid, u32 tsid, u16 tclass, u32 requested,
>  int avc_has_perm(u32 ssid, u32 tsid, u16 tclass, u32 requested,
>  		 struct common_audit_data *auditdata);
>  
> +#define AVC_EXT_IOCTL	(1 << 0) /* Cache entry for an ioctl extended permission */
> +#define AVC_EXT_NLMSG	(1 << 1) /* Cache entry for an nlmsg extended permission */
>  int avc_has_extended_perms(u32 ssid, u32 tsid, u16 tclass, u32 requested,
> -			   u8 driver, u8 perm, struct common_audit_data *ad);
> +			   u8 driver, u8 base_perm, u8 perm,
> +			   struct common_audit_data *ad);
>  
>  u32 avc_policy_seqno(void);
>  
> diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
> index c7f2731abd03..0f6ff19d420c 100644
> --- a/security/selinux/include/security.h
> +++ b/security/selinux/include/security.h
> @@ -239,6 +239,7 @@ struct extended_perms_data {
>  struct extended_perms_decision {
>  	u8 used;
>  	u8 driver;
> +	u8 base_perm;
>  	struct extended_perms_data *allowed;
>  	struct extended_perms_data *auditallow;
>  	struct extended_perms_data *dontaudit;
> @@ -247,6 +248,7 @@ struct extended_perms_decision {
>  struct extended_perms {
>  	u16 len; /* length associated decision chain */
>  	struct extended_perms_data drivers; /* flag drivers that are used */
> +	u8 base_perms; /* which base permissions are covered */

Would it be better to locate "base_perms" after "len", before "drivers"?

>  };
>  
>  /* definitions of av_decision.flags */
> @@ -257,6 +259,7 @@ void security_compute_av(u32 ssid, u32 tsid, u16 tclass,
>  			 struct extended_perms *xperms);
>  
>  void security_compute_xperms_decision(u32 ssid, u32 tsid, u16 tclass, u8 driver,
> +				      u8 base_perm,
>  				      struct extended_perms_decision *xpermd);
>  
>  void security_compute_av_user(u32 ssid, u32 tsid, u16 tclass,
> diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
> index 971c45d576ba..04ac4138a8b7 100644
> --- a/security/selinux/ss/services.c
> +++ b/security/selinux/ss/services.c
> @@ -582,7 +582,7 @@ static void type_attribute_bounds_av(struct policydb *policydb,
>  }
>  
>  /*
> - * Flag which drivers have permissions.
> + * Flag which drivers have permissions and which base permissions are covered.
>   */
>  void services_compute_xperms_drivers(
>  		struct extended_perms *xperms,
> @@ -592,12 +592,19 @@ void services_compute_xperms_drivers(
>  
>  	switch (node->datum.u.xperms->specified) {
>  	case AVTAB_XPERMS_IOCTLDRIVER:
> +		xperms->base_perms |= AVC_EXT_IOCTL;
>  		/* if one or more driver has all permissions allowed */
>  		for (i = 0; i < ARRAY_SIZE(xperms->drivers.p); i++)
>  			xperms->drivers.p[i] |= node->datum.u.xperms->perms.p[i];
>  		break;
>  	case AVTAB_XPERMS_IOCTLFUNCTION:
> +		xperms->base_perms |= AVC_EXT_IOCTL;
> +		/* if allowing permissions within a driver */
> +		security_xperm_set(xperms->drivers.p,
> +					node->datum.u.xperms->driver);
> +		break;
>  	case AVTAB_XPERMS_NLMSG:
> +		xperms->base_perms |= AVC_EXT_NLMSG;
>  		/* if allowing permissions within a driver */
>  		security_xperm_set(xperms->drivers.p,
>  					node->datum.u.xperms->driver);
> @@ -632,6 +639,7 @@ static void context_struct_compute_av(struct policydb *policydb,
>  	avd->auditdeny = 0xffffffff;
>  	if (xperms) {
>  		memset(&xperms->drivers, 0, sizeof(xperms->drivers));
> +		xperms->base_perms = 0;
>  		xperms->len = 0;

Are we better off replacing the above with one memset(), e.g.
'memset(xperms, 0, sizeof(*xperms))'?

>  	}
>  
> @@ -969,14 +977,23 @@ void services_compute_xperms_decision(struct extended_perms_decision *xpermd,
>  {
>  	switch (node->datum.u.xperms->specified) {
>  	case AVTAB_XPERMS_IOCTLFUNCTION:
> -	case AVTAB_XPERMS_NLMSG:
>  		if (xpermd->driver != node->datum.u.xperms->driver)
>  			return;
> +		if (xpermd->base_perm != AVC_EXT_IOCTL)
> +			return;

Shouldn't we check the base_perm field before we check the driver field?

The same question applies to the other cases below.

>  		break;
>  	case AVTAB_XPERMS_IOCTLDRIVER:
>  		if (!security_xperm_test(node->datum.u.xperms->perms.p,
>  					xpermd->driver))
>  			return;
> +		if (xpermd->base_perm != AVC_EXT_IOCTL)
> +			return;
> +		break;
> +	case AVTAB_XPERMS_NLMSG:
> +		if (xpermd->driver != node->datum.u.xperms->driver)
> +			return;
> +		if (xpermd->base_perm != AVC_EXT_NLMSG)
> +			return;
>  		break;
>  	default:
>  		BUG();
> @@ -1006,6 +1023,7 @@ void security_compute_xperms_decision(u32 ssid,
>  				      u32 tsid,
>  				      u16 orig_tclass,
>  				      u8 driver,
> +				      u8 base_perm,
>  				      struct extended_perms_decision *xpermd)
>  {
>  	struct selinux_policy *policy;
> @@ -1019,6 +1037,7 @@ void security_compute_xperms_decision(u32 ssid,
>  	struct ebitmap_node *snode, *tnode;
>  	unsigned int i, j;
>  
> +	xpermd->base_perm = base_perm;
>  	xpermd->driver = driver;
>  	xpermd->used = 0;
>  	memset(xpermd->allowed->p, 0, sizeof(xpermd->allowed->p));
> -- 
> 2.47.0.338.g60cca15819-goog

--
paul-moore.com
