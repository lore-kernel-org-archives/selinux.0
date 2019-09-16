Return-Path: <SRS0=qBB/=XL=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D333EC49ED7
	for <selinux@archiver.kernel.org>; Mon, 16 Sep 2019 18:47:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9547F20830
	for <selinux@archiver.kernel.org>; Mon, 16 Sep 2019 18:47:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="aMyZyDOU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730109AbfIPSrh (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 16 Sep 2019 14:47:37 -0400
Received: from USFB19PA35.eemsg.mail.mil ([214.24.26.198]:52538 "EHLO
        USFB19PA35.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730107AbfIPSrh (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 16 Sep 2019 14:47:37 -0400
X-EEMSG-check-017: 9061685|USFB19PA35_ESA_OUT05.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.64,513,1559520000"; 
   d="scan'208";a="9061685"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by USFB19PA35.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 16 Sep 2019 18:47:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1568659653; x=1600195653;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=IAYlEI7OzrhVlZ1MOKYe0QDo6HAOe1gHApDyQi+g02I=;
  b=aMyZyDOUpcyHDu7WhGXWhQQQFWh1T0GO/uut766feGBC4DnjjkeO+fvb
   1/aHnaY9ZQQGrGY7YHf/w2qwQn2uMUaPDPTdAuYnHRtHpKSHwoaVOt+3A
   zriBo0wAYvqelSUibpnEMecz6/0gSvOZUxNghsA+WYj4ZLAz7HL9wDbPZ
   OHPMOWZJvsZ//5uj1uMuVx5If0Izsx+wBh8lH3nx5Wfu0Ka7lapWvOYS3
   sglh2oHsum32mrgNLlAJGLQFjjhZfwb8vbb/s3bTLPmDYBwdeyQZeDgOx
   gC8RigztMeZ7xNZ/dVVhz2GN4wE3Jq5AgC7lasU3UCJ4pYBIbT0iz6MUc
   A==;
X-IronPort-AV: E=Sophos;i="5.64,513,1559520000"; 
   d="scan'208";a="32910781"
IronPort-PHdr: =?us-ascii?q?9a23=3AuXPYcR0GeQaTleNxsmDT+DRfVm0co7zxezQtwd?=
 =?us-ascii?q?8ZsesSI/3xwZ3uMQTl6Ol3ixeRBMOHsqkC0rGd6vqxESxYuNDd6SpEKMQNHz?=
 =?us-ascii?q?Y+yuwu1zQ6B8CEDUCpZNXLVAcdWPp4aVl+4nugOlJUEsutL3fbo3m18CJAUk?=
 =?us-ascii?q?6nbVk9Kev6AJPdgNqq3O6u5ZLTfx9IhD2gar9uMRm6twrcutQYjId4N6o8xB?=
 =?us-ascii?q?TFrmZWd+lS2GhkIU6fkwvm6sq/4ZJv7T5ct+49+8JFTK73Y7k2QbtEATo8Lm?=
 =?us-ascii?q?s7/tfrtR7NTQuO4nsTTGAbmQdWDgbG8R/3QI7/vjP1ueRh1iaaO9b2Ta0vVj?=
 =?us-ascii?q?S586hrUh7ohzwZODM/7Wral9Z/jKNfoBKmuhx/34vZa5ybOfZiYq/Qe84RSH?=
 =?us-ascii?q?FfVchNSSNOHoK8b5MOD+UfO+ZYs5L9rEYKoRenGAWgGP/jxjpOi3D4x6061/?=
 =?us-ascii?q?kqHx/A0gIuAtkCtG3YoMvxOasXV+2+0avGwijZb/5OxDnz9obIfBAir/+CU7?=
 =?us-ascii?q?1/fsjexlUgGQ7eklWdq5boMy+J2ukDsWWW6fdrW+K1i24grgF8uiWhxtsyhY?=
 =?us-ascii?q?nRhoIa1FbE/jhkzoYwP9K4TEp7bsCkEZBNsCyaLJZ5Qtg5TmF0uCc11r0GuZ?=
 =?us-ascii?q?mhcCgM05Qo3QTTa/OAc4iW+x/uUvuaLzRghH99Zb6yiBm//VKgx+HhTMW4zl?=
 =?us-ascii?q?lHojRfntXRsH0Gygbd5dKdSvRn+0eswTOP1wfO5e5aOU00jq/bK4I5wr43i5?=
 =?us-ascii?q?oTrVzPHi/ol0Xyi6+bblkk9fKy6+Tmf7XmvYWQN5N0iw7iMqQundazAeIkPQ?=
 =?us-ascii?q?gVQ2eX4+G81Lzn/UHhQbVKiOM5krXBvZzHKskWqbS1Dg9I3oo59RqyACmq3M?=
 =?us-ascii?q?4FkXUfKVJKYhOHj4znO1HUJ/D4CO+yg0+xnzdw3P3GIr3gDYnNLnjEirvhe6?=
 =?us-ascii?q?195FRGxAo8ytBf+YpYCqsdL/LrRk/xqNvYAwclPAOu2OboFtV825gFWW2TAq?=
 =?us-ascii?q?+WKr7SsVGM5u0xOemAfZMatyznJ/c54P7uiGczmUUBcqmxwZsXdHe4E+x6LE?=
 =?us-ascii?q?qDenrjnNcAHX0RvgUiTOzlkkCCUTBXZ3msRaIx/TA7CIS6DYjdQoChmqCO3C?=
 =?us-ascii?q?C+HpdOfGBJFkiMEWv0d4WDQ/oMaieSIsh7kjweVLihUJQs1Re0uw//1bVnL/?=
 =?us-ascii?q?DY+ioCtZLszNJ1/fHclQku9TxoCMSQy2WNT2BynmMVSD46xbt/rlJhxVeey6?=
 =?us-ascii?q?h4guBYFNxK6/NMVQc1KIPcz+hkBN3pRALBccmGSEy8TtWlHz4xVNQxzMEKY0?=
 =?us-ascii?q?pnHNWilB/D1TKwA7AJj7yLGIA08qXE0njqOcl9z3fG1K88j1gpWcZPK2Kmib?=
 =?us-ascii?q?Bl9wTJBI7GjV+Zl6C0eqQYxiLN832DzWWWtkFCTAFwSbnFXWwYZkbOrtT2+F?=
 =?us-ascii?q?3NT6SyBrQgNQtBytWPJbdKat3zilVGQfbjOMnbY26rnGewHxmIzKuWbIX2Y2?=
 =?us-ascii?q?UdwDndCE8cngAR+naGNQ4+Cj2jo2LZDDxhD1TvY1jy/ul4s360UlU7zweNb0?=
 =?us-ascii?q?1n1rq65gQahfiGR/wP2bIEvT8rqy9oE1alw9LWF92AqhJ5fKpCZ9M970pH1W?=
 =?us-ascii?q?PftwBkPZyvMbpihlgAfARzpE7u1gx7CoFHkcg0snwm1hFyJrib0FNcbTOXx4?=
 =?us-ascii?q?r8OrvJJWXo/hCvc7bc2kvC39aO5qcP9PM4pk37vA6zC0oi925q08FP3HuB4p?=
 =?us-ascii?q?XGFQ8SUZX2UkYt6Rd2va3VYi4459Cc6Xo5GqCvvy6K4NkpDfYrzhu6N4NUOb?=
 =?us-ascii?q?iJBSfpGM0TGsaqJfZvkFHvZRUBaqQa/6cvMtLgbPCG0bOlOOt6tDOgkWlDpo?=
 =?us-ascii?q?t61wbE9S97UPTJxL4DyvSV302ATTi4xFOgtN3n3JtJbiwIH3aujC3jCJNVa4?=
 =?us-ascii?q?VscosRT2SjOcu6wpN5nZGpE2VV8F+lGkMuxsCkY1yRYkb70AkW0l4Y8lK9ni?=
 =?us-ascii?q?7t9CB5izEkqOKk2SXKx+nzPE4cNnVjWHhpjVCqJ5O9yd8dQh77PEASiBK56B?=
 =?us-ascii?q?OilOBgr6NlIjyWGB0Zcg=3D=3D?=
X-IPAS-Result: =?us-ascii?q?A2C8BwBO2H9d/wHyM5BmHAEBAQQBAQcEAQGBZ4FuKoE/A?=
 =?us-ascii?q?TIqhCGPVQEBAQEBAQaBESV+iHWRJwkBAQEBAQEBAQE0AQIBAYQ/AoJvIzgTA?=
 =?us-ascii?q?gwBAQEEAQEBAQEFAwEBbIU6gjopAYJmAQEBAQIBIwQRQRALFQMCAiYCAlcGA?=
 =?us-ascii?q?QwGAgEBgl8/gXcFD609fzOFTIMygUmBDCiLeBh4gQeBEScMgioHLj6BF4Y4g?=
 =?us-ascii?q?lgEjGeJCpZ5giyCLpJMBhuZGY4JmxMhgVgrCAIYCCEPgyeCTheOPiQDMIEGA?=
 =?us-ascii?q?QGPbgEB?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 16 Sep 2019 18:47:30 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x8GIlSOs011738;
        Mon, 16 Sep 2019 14:47:29 -0400
Subject: Re: [PATCH v8 03/28] LSM: Infrastructure management of the key blob
To:     Casey Schaufler <casey@schaufler-ca.com>,
        casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com
References: <20190829232935.7099-1-casey@schaufler-ca.com>
 <20190829232935.7099-4-casey@schaufler-ca.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <785ba96f-b2fa-e1e8-7397-1bc89c4d3909@tycho.nsa.gov>
Date:   Mon, 16 Sep 2019 14:47:28 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190829232935.7099-4-casey@schaufler-ca.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 8/29/19 7:29 PM, Casey Schaufler wrote:
> From: Casey Schaufler <cschaufler@schaufler-ca.com>
> 
> Move management of the key->security blob out of the
> individual security modules and into the security
> infrastructure. Instead of allocating the blobs from within
> the modules the modules tell the infrastructure how much
> space is required, and the space is allocated there.

As with the superblock blob, I don't see that this is needed for 
stacking AA but I don't object to moving all the security blobs to 
infrastructure management for consistency.

Reviewed-by: Stephen Smalley <sds@tycho.nsa.gov>

> 
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Reviewed-by: John Johansen <jojn.johansen@canonical.com>
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>   include/linux/lsm_hooks.h         |  1 +
>   security/security.c               | 40 ++++++++++++++++++++++++++++++-
>   security/selinux/hooks.c          | 23 +++++-------------
>   security/selinux/include/objsec.h |  7 ++++++
>   security/smack/smack.h            |  7 ++++++
>   security/smack/smack_lsm.c        | 33 ++++++++++++-------------
>   6 files changed, 75 insertions(+), 36 deletions(-)
> 
> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> index b353482ea348..3fe39abccc8f 100644
> --- a/include/linux/lsm_hooks.h
> +++ b/include/linux/lsm_hooks.h
> @@ -2050,6 +2050,7 @@ struct lsm_blob_sizes {
>   	int	lbs_sock;
>   	int	lbs_superblock;
>   	int	lbs_ipc;
> +	int	lbs_key;
>   	int	lbs_msg_msg;
>   	int	lbs_task;
>   };
> diff --git a/security/security.c b/security/security.c
> index 2c0834db7976..7cfedb90210a 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -172,6 +172,9 @@ static void __init lsm_set_blob_sizes(struct lsm_blob_sizes *needed)
>   		blob_sizes.lbs_inode = sizeof(struct rcu_head);
>   	lsm_set_blob_size(&needed->lbs_inode, &blob_sizes.lbs_inode);
>   	lsm_set_blob_size(&needed->lbs_ipc, &blob_sizes.lbs_ipc);
> +#ifdef CONFIG_KEYS
> +	lsm_set_blob_size(&needed->lbs_key, &blob_sizes.lbs_key);
> +#endif
>   	lsm_set_blob_size(&needed->lbs_msg_msg, &blob_sizes.lbs_msg_msg);
>   	lsm_set_blob_size(&needed->lbs_sock, &blob_sizes.lbs_sock);
>   	lsm_set_blob_size(&needed->lbs_superblock, &blob_sizes.lbs_superblock);
> @@ -307,6 +310,9 @@ static void __init ordered_lsm_init(void)
>   	init_debug("file blob size       = %d\n", blob_sizes.lbs_file);
>   	init_debug("inode blob size      = %d\n", blob_sizes.lbs_inode);
>   	init_debug("ipc blob size        = %d\n", blob_sizes.lbs_ipc);
> +#ifdef CONFIG_KEYS
> +	init_debug("key blob size        = %d\n", blob_sizes.lbs_key);
> +#endif /* CONFIG_KEYS */
>   	init_debug("msg_msg blob size    = %d\n", blob_sizes.lbs_msg_msg);
>   	init_debug("sock blob size       = %d\n", blob_sizes.lbs_sock);
>   	init_debug("superblock blob size = %d\n", blob_sizes.lbs_superblock);
> @@ -573,6 +579,29 @@ static int lsm_ipc_alloc(struct kern_ipc_perm *kip)
>   	return 0;
>   }
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
> +static int lsm_key_alloc(struct key *key)
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
>   /**
>    * lsm_msg_msg_alloc - allocate a composite msg_msg blob
>    * @mp: the msg_msg that needs a blob
> @@ -2339,12 +2368,21 @@ EXPORT_SYMBOL(security_skb_classify_flow);
>   int security_key_alloc(struct key *key, const struct cred *cred,
>   		       unsigned long flags)
>   {
> -	return call_int_hook(key_alloc, 0, key, cred, flags);
> +	int rc = lsm_key_alloc(key);
> +
> +	if (unlikely(rc))
> +		return rc;
> +	rc = call_int_hook(key_alloc, 0, key, cred, flags);
> +	if (unlikely(rc))
> +		security_key_free(key);
> +	return rc;
>   }
>   
>   void security_key_free(struct key *key)
>   {
>   	call_void_hook(key_free, key);
> +	kfree(key->security);
> +	key->security = NULL;
>   }
>   
>   int security_key_permission(key_ref_t key_ref,
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 5d74ed35b728..c83ec2652eda 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -6353,11 +6353,7 @@ static int selinux_key_alloc(struct key *k, const struct cred *cred,
>   			     unsigned long flags)
>   {
>   	const struct task_security_struct *tsec;
> -	struct key_security_struct *ksec;
> -
> -	ksec = kzalloc(sizeof(struct key_security_struct), GFP_KERNEL);
> -	if (!ksec)
> -		return -ENOMEM;
> +	struct key_security_struct *ksec = selinux_key(k);
>   
>   	tsec = selinux_cred(cred);
>   	if (tsec->keycreate_sid)
> @@ -6365,18 +6361,9 @@ static int selinux_key_alloc(struct key *k, const struct cred *cred,
>   	else
>   		ksec->sid = tsec->sid;
>   
> -	k->security = ksec;
>   	return 0;
>   }
>   
> -static void selinux_key_free(struct key *k)
> -{
> -	struct key_security_struct *ksec = k->security;
> -
> -	k->security = NULL;
> -	kfree(ksec);
> -}
> -
>   static int selinux_key_permission(key_ref_t key_ref,
>   				  const struct cred *cred,
>   				  unsigned perm)
> @@ -6394,7 +6381,7 @@ static int selinux_key_permission(key_ref_t key_ref,
>   	sid = cred_sid(cred);
>   
>   	key = key_ref_to_ptr(key_ref);
> -	ksec = key->security;
> +	ksec = selinux_key(key);
>   
>   	return avc_has_perm(&selinux_state,
>   			    sid, ksec->sid, SECCLASS_KEY, perm, NULL);
> @@ -6402,7 +6389,7 @@ static int selinux_key_permission(key_ref_t key_ref,
>   
>   static int selinux_key_getsecurity(struct key *key, char **_buffer)
>   {
> -	struct key_security_struct *ksec = key->security;
> +	struct key_security_struct *ksec = selinux_key(key);
>   	char *context = NULL;
>   	unsigned len;
>   	int rc;
> @@ -6627,6 +6614,9 @@ struct lsm_blob_sizes selinux_blob_sizes __lsm_ro_after_init = {
>   	.lbs_file = sizeof(struct file_security_struct),
>   	.lbs_inode = sizeof(struct inode_security_struct),
>   	.lbs_ipc = sizeof(struct ipc_security_struct),
> +#ifdef CONFIG_KEYS
> +	.lbs_key = sizeof(struct key_security_struct),
> +#endif /* CONFIG_KEYS */
>   	.lbs_msg_msg = sizeof(struct msg_security_struct),
>   	.lbs_sock = sizeof(struct sk_security_struct),
>   	.lbs_superblock = sizeof(struct superblock_security_struct),
> @@ -6842,7 +6832,6 @@ static struct security_hook_list selinux_hooks[] __lsm_ro_after_init = {
>   
>   #ifdef CONFIG_KEYS
>   	LSM_HOOK_INIT(key_alloc, selinux_key_alloc),
> -	LSM_HOOK_INIT(key_free, selinux_key_free),
>   	LSM_HOOK_INIT(key_permission, selinux_key_permission),
>   	LSM_HOOK_INIT(key_getsecurity, selinux_key_getsecurity),
>   #endif
> diff --git a/security/selinux/include/objsec.h b/security/selinux/include/objsec.h
> index 29f02b8f8f31..3b78aa4ee98f 100644
> --- a/security/selinux/include/objsec.h
> +++ b/security/selinux/include/objsec.h
> @@ -194,6 +194,13 @@ static inline struct superblock_security_struct *selinux_superblock(
>   	return superblock->s_security + selinux_blob_sizes.lbs_superblock;
>   }
>   
> +#ifdef CONFIG_KEYS
> +static inline struct key_security_struct *selinux_key(const struct key *key)
> +{
> +	return key->security + selinux_blob_sizes.lbs_key;
> +}
> +#endif /* CONFIG_KEYS */
> +
>   static inline struct sk_security_struct *selinux_sock(const struct sock *sock)
>   {
>   	return sock->sk_security + selinux_blob_sizes.lbs_sock;
> diff --git a/security/smack/smack.h b/security/smack/smack.h
> index 4ac4bf3310d7..7cc3a3382fee 100644
> --- a/security/smack/smack.h
> +++ b/security/smack/smack.h
> @@ -386,6 +386,13 @@ static inline struct superblock_smack *smack_superblock(
>   	return superblock->s_security + smack_blob_sizes.lbs_superblock;
>   }
>   
> +#ifdef CONFIG_KEYS
> +static inline struct smack_known **smack_key(const struct key *key)
> +{
> +	return key->security + smack_blob_sizes.lbs_key;
> +}
> +#endif /* CONFIG_KEYS */
> +
>   /*
>    * Is the directory transmuting?
>    */
> diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
> index fd69e1bd841b..e9560b078efe 100644
> --- a/security/smack/smack_lsm.c
> +++ b/security/smack/smack_lsm.c
> @@ -4179,23 +4179,13 @@ static void smack_inet_csk_clone(struct sock *sk,
>   static int smack_key_alloc(struct key *key, const struct cred *cred,
>   			   unsigned long flags)
>   {
> +	struct smack_known **blob = smack_key(key);
>   	struct smack_known *skp = smk_of_task(smack_cred(cred));
>   
> -	key->security = skp;
> +	*blob = skp;
>   	return 0;
>   }
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
>   /**
>    * smack_key_permission - Smack access on a key
>    * @key_ref: gets to the object
> @@ -4208,6 +4198,8 @@ static void smack_key_free(struct key *key)
>   static int smack_key_permission(key_ref_t key_ref,
>   				const struct cred *cred, unsigned perm)
>   {
> +	struct smack_known **blob;
> +	struct smack_known *skp;
>   	struct key *keyp;
>   	struct smk_audit_info ad;
>   	struct smack_known *tkp = smk_of_task(smack_cred(cred));
> @@ -4227,7 +4219,9 @@ static int smack_key_permission(key_ref_t key_ref,
>   	 * If the key hasn't been initialized give it access so that
>   	 * it may do so.
>   	 */
> -	if (keyp->security == NULL)
> +	blob = smack_key(keyp);
> +	skp = *blob;
> +	if (skp == NULL)
>   		return 0;
>   	/*
>   	 * This should not occur
> @@ -4247,8 +4241,8 @@ static int smack_key_permission(key_ref_t key_ref,
>   		request |= MAY_READ;
>   	if (perm & (KEY_NEED_WRITE | KEY_NEED_LINK | KEY_NEED_SETATTR))
>   		request |= MAY_WRITE;
> -	rc = smk_access(tkp, keyp->security, request, &ad);
> -	rc = smk_bu_note("key access", tkp, keyp->security, request, rc);
> +	rc = smk_access(tkp, skp, request, &ad);
> +	rc = smk_bu_note("key access", tkp, skp, request, rc);
>   	return rc;
>   }
>   
> @@ -4263,11 +4257,12 @@ static int smack_key_permission(key_ref_t key_ref,
>    */
>   static int smack_key_getsecurity(struct key *key, char **_buffer)
>   {
> -	struct smack_known *skp = key->security;
> +	struct smack_known **blob = smack_key(key);
> +	struct smack_known *skp = *blob;
>   	size_t length;
>   	char *copy;
>   
> -	if (key->security == NULL) {
> +	if (skp == NULL) {
>   		*_buffer = NULL;
>   		return 0;
>   	}
> @@ -4550,6 +4545,9 @@ struct lsm_blob_sizes smack_blob_sizes __lsm_ro_after_init = {
>   	.lbs_file = sizeof(struct smack_known *),
>   	.lbs_inode = sizeof(struct inode_smack),
>   	.lbs_ipc = sizeof(struct smack_known *),
> +#ifdef CONFIG_KEYS
> +	.lbs_key = sizeof(struct smack_known *),
> +#endif /* CONFIG_KEYS */
>   	.lbs_msg_msg = sizeof(struct smack_known *),
>   	.lbs_sock = sizeof(struct socket_smack),
>   	.lbs_superblock = sizeof(struct superblock_smack),
> @@ -4671,7 +4669,6 @@ static struct security_hook_list smack_hooks[] __lsm_ro_after_init = {
>    /* key management security hooks */
>   #ifdef CONFIG_KEYS
>   	LSM_HOOK_INIT(key_alloc, smack_key_alloc),
> -	LSM_HOOK_INIT(key_free, smack_key_free),
>   	LSM_HOOK_INIT(key_permission, smack_key_permission),
>   	LSM_HOOK_INIT(key_getsecurity, smack_key_getsecurity),
>   #endif /* CONFIG_KEYS */
> 

