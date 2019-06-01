Return-Path: <SRS0=ThDI=UA=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7AB0C28CC1
	for <selinux@archiver.kernel.org>; Sat,  1 Jun 2019 15:18:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E59427285
	for <selinux@archiver.kernel.org>; Sat,  1 Jun 2019 15:18:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QZxxQVUy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726550AbfFAPSZ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 1 Jun 2019 11:18:25 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:39724 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726174AbfFAPSY (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sat, 1 Jun 2019 11:18:24 -0400
Received: by mail-pf1-f193.google.com with SMTP id j2so8007607pfe.6
        for <selinux@vger.kernel.org>; Sat, 01 Jun 2019 08:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=U0cWwU6xOYtT2XYHAoQyZdcQg6DPd9jtEaPPPMNsHrI=;
        b=QZxxQVUyp0Tq9VoNuDUXcvKVrXIeHJVzP1LDbHVroU5wXXF07Dh29/8Thq7cFR3wes
         6lVAPxQidZKMiye1ikgxpzBny8jObuWsTj/M8PC5+8y6hsTRXlyTqtuojC/p4ibubg89
         x3u4dEuBnxwjnHSDOnj9mN0uZYqHCWmCAYSoU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=U0cWwU6xOYtT2XYHAoQyZdcQg6DPd9jtEaPPPMNsHrI=;
        b=IFVCrnVTU55neIkGApwtpX4BEABTYw9EniELbp2CZKNenxlLmTQw+X2vNgfhCBVUTx
         af5OqIqSK34gw5ZsYqqnP6ogOBZHP3utj7otQ1jYqjv/7P4lAIM/kubbl27icbQU6ruj
         m6qlWfOd/sE+6qIkMqdcP0Wcw2qC1ll2qp+OB8noRq+jY7mraO3aPRLp44Wx+Rvrr1qF
         cZDDm9I/CPrVjMxwetu5kJc15YZh/A2dgzgi+IJPUekiH6yjeOiO90Fb0rtWdeV9awvW
         88bYVUbL1JHhynsm2iHLylf+dgOjPYjkJVuNT8wJRsUpphVPV58RDsIa8GTU/r+ZrRxE
         uVFw==
X-Gm-Message-State: APjAAAVDpSsFuAMaSxdjgh7RYIjLyzsojxnaVt793UQwZp0RJs+qKpw+
        PvQmZRo7lznvMoUn/MlgUgFJ0m0tyZQ=
X-Google-Smtp-Source: APXvYqxHrJcLKqTbOl2G8QZxOXWIkWxSuGa8HC/Lh2Z3wYpwa6XJasAlEjwGvP8w1Ck0sGM3yRoAww==
X-Received: by 2002:a17:90a:380d:: with SMTP id w13mr2172566pjb.138.1559402303962;
        Sat, 01 Jun 2019 08:18:23 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y7sm15123337pja.26.2019.06.01.08.18.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 01 Jun 2019 08:18:23 -0700 (PDT)
Date:   Sat, 1 Jun 2019 08:18:21 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: Re: [PATCH 03/58] LSM: Infrastructure management of the key security
 blob
Message-ID: <201906010818.76F800C0@keescook>
References: <20190531231020.628-1-casey@schaufler-ca.com>
 <20190531231020.628-4-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190531231020.628-4-casey@schaufler-ca.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, May 31, 2019 at 04:09:25PM -0700, Casey Schaufler wrote:
> From: Casey Schaufler <cschaufler@schaufler-ca.com>
> 
> Move management of the key->security blob out of the
> individual security modules and into the security
> infrastructure. Instead of allocating the blobs from within
> the modules the modules tell the infrastructure how much
> space is required, and the space is allocated there.
> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  include/linux/lsm_hooks.h         |  1 +
>  security/security.c               | 40 ++++++++++++++++++++++++++++++-
>  security/selinux/hooks.c          | 23 +++++-------------
>  security/selinux/include/objsec.h |  7 ++++++
>  security/smack/smack.h            |  7 ++++++
>  security/smack/smack_lsm.c        | 33 ++++++++++++-------------
>  6 files changed, 75 insertions(+), 36 deletions(-)
> 
> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> index b353482ea348..3fe39abccc8f 100644
> --- a/include/linux/lsm_hooks.h
> +++ b/include/linux/lsm_hooks.h
> @@ -2050,6 +2050,7 @@ struct lsm_blob_sizes {
>  	int	lbs_sock;
>  	int	lbs_superblock;
>  	int	lbs_ipc;
> +	int	lbs_key;
>  	int	lbs_msg_msg;
>  	int	lbs_task;
>  };
> diff --git a/security/security.c b/security/security.c
> index e32b7180282e..d05f00a40e82 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -172,6 +172,9 @@ static void __init lsm_set_blob_sizes(struct lsm_blob_sizes *needed)
>  		blob_sizes.lbs_inode = sizeof(struct rcu_head);
>  	lsm_set_blob_size(&needed->lbs_inode, &blob_sizes.lbs_inode);
>  	lsm_set_blob_size(&needed->lbs_ipc, &blob_sizes.lbs_ipc);
> +#ifdef CONFIG_KEYS
> +	lsm_set_blob_size(&needed->lbs_key, &blob_sizes.lbs_key);
> +#endif
>  	lsm_set_blob_size(&needed->lbs_msg_msg, &blob_sizes.lbs_msg_msg);
>  	lsm_set_blob_size(&needed->lbs_sock, &blob_sizes.lbs_sock);
>  	lsm_set_blob_size(&needed->lbs_superblock, &blob_sizes.lbs_superblock);
> @@ -307,6 +310,9 @@ static void __init ordered_lsm_init(void)
>  	init_debug("file blob size       = %d\n", blob_sizes.lbs_file);
>  	init_debug("inode blob size      = %d\n", blob_sizes.lbs_inode);
>  	init_debug("ipc blob size        = %d\n", blob_sizes.lbs_ipc);
> +#ifdef CONFIG_KEYS
> +	init_debug("key blob size        = %d\n", blob_sizes.lbs_key);
> +#endif /* CONFIG_KEYS */
>  	init_debug("msg_msg blob size    = %d\n", blob_sizes.lbs_msg_msg);
>  	init_debug("sock blob size       = %d\n", blob_sizes.lbs_sock);
>  	init_debug("superblock blob size = %d\n", blob_sizes.lbs_superblock);
> @@ -573,6 +579,29 @@ static int lsm_ipc_alloc(struct kern_ipc_perm *kip)
>  	return 0;
>  }
>  
> +#ifdef CONFIG_KEYS
> +/**
> + * lsm_key_alloc - allocate a composite key blob
> + * @key: the key that needs a blob
> + *
> + * Allocate the key blob for all the modules
> + *
> + * Returns 0, or -ENOMEM if memory can't be allocated.
> + */
> +int lsm_key_alloc(struct key *key)
> +{
> +	if (blob_sizes.lbs_key == 0) {
> +		key->security = NULL;
> +		return 0;
> +	}
> +
> +	key->security = kzalloc(blob_sizes.lbs_key, GFP_KERNEL);
> +	if (key->security == NULL)
> +		return -ENOMEM;
> +	return 0;
> +}
> +#endif /* CONFIG_KEYS */
> +
>  /**
>   * lsm_msg_msg_alloc - allocate a composite msg_msg blob
>   * @mp: the msg_msg that needs a blob
> @@ -2339,12 +2368,21 @@ EXPORT_SYMBOL(security_skb_classify_flow);
>  int security_key_alloc(struct key *key, const struct cred *cred,
>  		       unsigned long flags)
>  {
> -	return call_int_hook(key_alloc, 0, key, cred, flags);
> +	int rc = lsm_key_alloc(key);
> +
> +	if (unlikely(rc))
> +		return rc;
> +	rc = call_int_hook(key_alloc, 0, key, cred, flags);
> +	if (unlikely(rc))
> +		security_key_free(key);
> +	return rc;
>  }
>  
>  void security_key_free(struct key *key)
>  {
>  	call_void_hook(key_free, key);
> +	kfree(key->security);
> +	key->security = NULL;
>  }
>  
>  int security_key_permission(key_ref_t key_ref,
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index f38a6f484613..ee840fecfebb 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -6353,11 +6353,7 @@ static int selinux_key_alloc(struct key *k, const struct cred *cred,
>  			     unsigned long flags)
>  {
>  	const struct task_security_struct *tsec;
> -	struct key_security_struct *ksec;
> -
> -	ksec = kzalloc(sizeof(struct key_security_struct), GFP_KERNEL);
> -	if (!ksec)
> -		return -ENOMEM;
> +	struct key_security_struct *ksec = selinux_key(k);
>  
>  	tsec = selinux_cred(cred);
>  	if (tsec->keycreate_sid)
> @@ -6365,18 +6361,9 @@ static int selinux_key_alloc(struct key *k, const struct cred *cred,
>  	else
>  		ksec->sid = tsec->sid;
>  
> -	k->security = ksec;
>  	return 0;
>  }
>  
> -static void selinux_key_free(struct key *k)
> -{
> -	struct key_security_struct *ksec = k->security;
> -
> -	k->security = NULL;
> -	kfree(ksec);
> -}
> -
>  static int selinux_key_permission(key_ref_t key_ref,
>  				  const struct cred *cred,
>  				  unsigned perm)
> @@ -6394,7 +6381,7 @@ static int selinux_key_permission(key_ref_t key_ref,
>  	sid = cred_sid(cred);
>  
>  	key = key_ref_to_ptr(key_ref);
> -	ksec = key->security;
> +	ksec = selinux_key(key);
>  
>  	return avc_has_perm(&selinux_state,
>  			    sid, ksec->sid, SECCLASS_KEY, perm, NULL);
> @@ -6402,7 +6389,7 @@ static int selinux_key_permission(key_ref_t key_ref,
>  
>  static int selinux_key_getsecurity(struct key *key, char **_buffer)
>  {
> -	struct key_security_struct *ksec = key->security;
> +	struct key_security_struct *ksec = selinux_key(key);
>  	char *context = NULL;
>  	unsigned len;
>  	int rc;
> @@ -6627,6 +6614,9 @@ struct lsm_blob_sizes selinux_blob_sizes __lsm_ro_after_init = {
>  	.lbs_file = sizeof(struct file_security_struct),
>  	.lbs_inode = sizeof(struct inode_security_struct),
>  	.lbs_ipc = sizeof(struct ipc_security_struct),
> +#ifdef CONFIG_KEYS
> +	.lbs_key = sizeof(struct key_security_struct),
> +#endif /* CONFIG_KEYS */
>  	.lbs_msg_msg = sizeof(struct msg_security_struct),
>  	.lbs_sock = sizeof(struct sk_security_struct),
>  	.lbs_superblock = sizeof(struct superblock_security_struct),
> @@ -6842,7 +6832,6 @@ static struct security_hook_list selinux_hooks[] __lsm_ro_after_init = {
>  
>  #ifdef CONFIG_KEYS
>  	LSM_HOOK_INIT(key_alloc, selinux_key_alloc),
> -	LSM_HOOK_INIT(key_free, selinux_key_free),
>  	LSM_HOOK_INIT(key_permission, selinux_key_permission),
>  	LSM_HOOK_INIT(key_getsecurity, selinux_key_getsecurity),
>  #endif
> diff --git a/security/selinux/include/objsec.h b/security/selinux/include/objsec.h
> index 29f02b8f8f31..3b78aa4ee98f 100644
> --- a/security/selinux/include/objsec.h
> +++ b/security/selinux/include/objsec.h
> @@ -194,6 +194,13 @@ static inline struct superblock_security_struct *selinux_superblock(
>  	return superblock->s_security + selinux_blob_sizes.lbs_superblock;
>  }
>  
> +#ifdef CONFIG_KEYS
> +static inline struct key_security_struct *selinux_key(const struct key *key)
> +{
> +	return key->security + selinux_blob_sizes.lbs_key;
> +}
> +#endif /* CONFIG_KEYS */
> +
>  static inline struct sk_security_struct *selinux_sock(const struct sock *sock)
>  {
>  	return sock->sk_security + selinux_blob_sizes.lbs_sock;
> diff --git a/security/smack/smack.h b/security/smack/smack.h
> index 4ac4bf3310d7..7cc3a3382fee 100644
> --- a/security/smack/smack.h
> +++ b/security/smack/smack.h
> @@ -386,6 +386,13 @@ static inline struct superblock_smack *smack_superblock(
>  	return superblock->s_security + smack_blob_sizes.lbs_superblock;
>  }
>  
> +#ifdef CONFIG_KEYS
> +static inline struct smack_known **smack_key(const struct key *key)
> +{
> +	return key->security + smack_blob_sizes.lbs_key;
> +}
> +#endif /* CONFIG_KEYS */
> +
>  /*
>   * Is the directory transmuting?
>   */
> diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
> index fd69e1bd841b..e9560b078efe 100644
> --- a/security/smack/smack_lsm.c
> +++ b/security/smack/smack_lsm.c
> @@ -4179,23 +4179,13 @@ static void smack_inet_csk_clone(struct sock *sk,
>  static int smack_key_alloc(struct key *key, const struct cred *cred,
>  			   unsigned long flags)
>  {
> +	struct smack_known **blob = smack_key(key);
>  	struct smack_known *skp = smk_of_task(smack_cred(cred));
>  
> -	key->security = skp;
> +	*blob = skp;
>  	return 0;
>  }
>  
> -/**
> - * smack_key_free - Clear the key security blob
> - * @key: the object
> - *
> - * Clear the blob pointer
> - */
> -static void smack_key_free(struct key *key)
> -{
> -	key->security = NULL;
> -}
> -
>  /**
>   * smack_key_permission - Smack access on a key
>   * @key_ref: gets to the object
> @@ -4208,6 +4198,8 @@ static void smack_key_free(struct key *key)
>  static int smack_key_permission(key_ref_t key_ref,
>  				const struct cred *cred, unsigned perm)
>  {
> +	struct smack_known **blob;
> +	struct smack_known *skp;
>  	struct key *keyp;
>  	struct smk_audit_info ad;
>  	struct smack_known *tkp = smk_of_task(smack_cred(cred));
> @@ -4227,7 +4219,9 @@ static int smack_key_permission(key_ref_t key_ref,
>  	 * If the key hasn't been initialized give it access so that
>  	 * it may do so.
>  	 */
> -	if (keyp->security == NULL)
> +	blob = smack_key(keyp);
> +	skp = *blob;
> +	if (skp == NULL)
>  		return 0;
>  	/*
>  	 * This should not occur
> @@ -4247,8 +4241,8 @@ static int smack_key_permission(key_ref_t key_ref,
>  		request |= MAY_READ;
>  	if (perm & (KEY_NEED_WRITE | KEY_NEED_LINK | KEY_NEED_SETATTR))
>  		request |= MAY_WRITE;
> -	rc = smk_access(tkp, keyp->security, request, &ad);
> -	rc = smk_bu_note("key access", tkp, keyp->security, request, rc);
> +	rc = smk_access(tkp, skp, request, &ad);
> +	rc = smk_bu_note("key access", tkp, skp, request, rc);
>  	return rc;
>  }
>  
> @@ -4263,11 +4257,12 @@ static int smack_key_permission(key_ref_t key_ref,
>   */
>  static int smack_key_getsecurity(struct key *key, char **_buffer)
>  {
> -	struct smack_known *skp = key->security;
> +	struct smack_known **blob = smack_key(key);
> +	struct smack_known *skp = *blob;
>  	size_t length;
>  	char *copy;
>  
> -	if (key->security == NULL) {
> +	if (skp == NULL) {
>  		*_buffer = NULL;
>  		return 0;
>  	}
> @@ -4550,6 +4545,9 @@ struct lsm_blob_sizes smack_blob_sizes __lsm_ro_after_init = {
>  	.lbs_file = sizeof(struct smack_known *),
>  	.lbs_inode = sizeof(struct inode_smack),
>  	.lbs_ipc = sizeof(struct smack_known *),
> +#ifdef CONFIG_KEYS
> +	.lbs_key = sizeof(struct smack_known *),
> +#endif /* CONFIG_KEYS */
>  	.lbs_msg_msg = sizeof(struct smack_known *),
>  	.lbs_sock = sizeof(struct socket_smack),
>  	.lbs_superblock = sizeof(struct superblock_smack),
> @@ -4671,7 +4669,6 @@ static struct security_hook_list smack_hooks[] __lsm_ro_after_init = {
>   /* key management security hooks */
>  #ifdef CONFIG_KEYS
>  	LSM_HOOK_INIT(key_alloc, smack_key_alloc),
> -	LSM_HOOK_INIT(key_free, smack_key_free),
>  	LSM_HOOK_INIT(key_permission, smack_key_permission),
>  	LSM_HOOK_INIT(key_getsecurity, smack_key_getsecurity),
>  #endif /* CONFIG_KEYS */
> -- 
> 2.19.1
> 

-- 
Kees Cook
