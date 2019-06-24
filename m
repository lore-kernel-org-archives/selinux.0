Return-Path: <SRS0=g6d+=UX=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAA32C48BE9
	for <selinux@archiver.kernel.org>; Mon, 24 Jun 2019 18:33:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C195A20645
	for <selinux@archiver.kernel.org>; Mon, 24 Jun 2019 18:33:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728045AbfFXSdr (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 24 Jun 2019 14:33:47 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:50108 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726378AbfFXSdq (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 24 Jun 2019 14:33:46 -0400
Received: from static-50-53-46-226.bvtn.or.frontiernet.net ([50.53.46.226] helo=[192.168.192.153])
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <john.johansen@canonical.com>)
        id 1hfTmc-0008BD-5l; Mon, 24 Jun 2019 18:33:38 +0000
From:   John Johansen <john.johansen@canonical.com>
Subject: [PATCH v3 03/24] LSM: Infrastructure management of the key blob
To:     Casey Schaufler <casey@schaufler-ca.com>,
        casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     keescook@chromium.org, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
References: <20190621185233.6766-1-casey@schaufler-ca.com>
 <20190621185233.6766-4-casey@schaufler-ca.com>
Openpgp: preference=signencrypt
Autocrypt: addr=john.johansen@canonical.com; prefer-encrypt=mutual; keydata=
 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
Organization: Canonical
Message-ID: <f522f2e8-ad64-a5de-0004-9cf8cf4f5e45@canonical.com>
Date:   Mon, 24 Jun 2019 11:33:35 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190621185233.6766-4-casey@schaufler-ca.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 6/21/19 11:52 AM, Casey Schaufler wrote:
> From: Casey Schaufler <cschaufler@schaufler-ca.com>
> 
> Move management of the key->security blob out of the
> individual security modules and into the security
> infrastructure. Instead of allocating the blobs from within
> the modules the modules tell the infrastructure how much
> space is required, and the space is allocated there.
> 
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>

One small thing below

Reviewed-by: John Johansen <john.johansen@canonical.com>



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

should be static


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
> 



