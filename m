Return-Path: <SRS0=qCpE=US=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB70CC31E5D
	for <selinux@archiver.kernel.org>; Wed, 19 Jun 2019 04:52:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77BB120665
	for <selinux@archiver.kernel.org>; Wed, 19 Jun 2019 04:52:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FtU5iw20"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725866AbfFSEwr (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 19 Jun 2019 00:52:47 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:42900 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725562AbfFSEwq (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 19 Jun 2019 00:52:46 -0400
Received: by mail-pg1-f194.google.com with SMTP id l19so8907465pgh.9
        for <selinux@vger.kernel.org>; Tue, 18 Jun 2019 21:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=rKPJ7ijGdRZb06MoKRI6dDpOftMihipickVS2OCnxls=;
        b=FtU5iw20SgvykT2n7xhniSMvoSJMMyO5Zyz7ibfZaOuvdtwkn2qrZu9JZ9ivAav82Q
         JiQYdy43uXl0grHkiMQ0eJDtrC+573xjtX0Md5UJ/zjTXK6DnxkjkjG7CBZ94OvsA2ft
         aXRCtuf8JO+b4FFYOLGrGUpSx6T5aB+DJiYmM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rKPJ7ijGdRZb06MoKRI6dDpOftMihipickVS2OCnxls=;
        b=W+kQviYBBWREv5Ic3Ki9s8G+Uq23OAjdiHi9Pz1nitC2EuP0cUY8d25dloFxM4xtY2
         CHjUtp0uRsh3Tw4FNKMHVpQGOmbhPVHdb3KYU05LiEYV4jZz05n+yuHC6sz21J9gRFvO
         zt63oNOXH5DuQZEXznVFYkK+gCY8vTJxTs/fpDHApRgzHvFRF4LeLX8K3w/qWSBIDn9e
         M3epD7WpJtutCBmZebOzxYkMfGmBwGYVFGEWOIEvq2A098wvo5hCgIJTrSK6wGYo6F86
         A2lWNMPxxHFoMCgpjW4far87MbYyv9RtRcb6r4xyCmgiUHSPehpVP1TVl89FDJj/+xvF
         EJ/Q==
X-Gm-Message-State: APjAAAVW3En5JbUM6eSk0CCsh1zsFii9VxSBoDPfg0tDWOa17/PAkfHV
        X9UWB9UKqCU5SAQrJDD/z3jYzA==
X-Google-Smtp-Source: APXvYqyMYwyec5A4rUjQwUC6R/qw1I5c/rrjjgzVdL+sfcIjwVYSvgVzwMKZ4V62H2hogk9goWf3lg==
X-Received: by 2002:a63:c5:: with SMTP id 188mr6025556pga.108.1560919965952;
        Tue, 18 Jun 2019 21:52:45 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id f10sm14502545pgq.73.2019.06.18.21.52.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 18 Jun 2019 21:52:45 -0700 (PDT)
Date:   Tue, 18 Jun 2019 21:52:44 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: Re: [PATCH v2 04/25] LSM: Create and manage the lsmblob data
 structure.
Message-ID: <201906182147.0A592CBB62@keescook>
References: <20190618230551.7475-1-casey@schaufler-ca.com>
 <20190618230551.7475-5-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190618230551.7475-5-casey@schaufler-ca.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Jun 18, 2019 at 04:05:30PM -0700, Casey Schaufler wrote:
> When more than one security module is exporting data to
> audit and networking sub-systems a single 32 bit integer
> is no longer sufficient to represent the data. Add a
> structure to be used instead.
> 
> The lsmblob structure is currently an array of
> u32 "secids". There is an entry for each of the
> security modules built into the system that would
> use secids if active. The system assigns the module
> a "slot" when it registers hooks. If modules are
> compiled in but not registered there will be unused
> slots.
> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>  include/linux/lsm_hooks.h |  1 +
>  include/linux/security.h  | 62 +++++++++++++++++++++++++++++++++++++++
>  security/security.c       | 31 ++++++++++++++++++++
>  3 files changed, 94 insertions(+)
> 
> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> index 3fe39abccc8f..4d1ddf1a2aa6 100644
> --- a/include/linux/lsm_hooks.h
> +++ b/include/linux/lsm_hooks.h
> @@ -2038,6 +2038,7 @@ struct security_hook_list {
>  	struct hlist_head		*head;
>  	union security_list_options	hook;
>  	char				*lsm;
> +	int				slot;
>  } __randomize_layout;

Hm, this feels redundant (as does the existing "char *lsm") now that we
have lsm_info. The place for assigned-at-init value is blob_sizes, which
hangs off of lsm_info (as does the LSM char *)...

>  
>  /*
> diff --git a/include/linux/security.h b/include/linux/security.h
> index 49f2685324b0..28d074866895 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -76,6 +76,68 @@ enum lsm_event {
>  	LSM_POLICY_CHANGE,
>  };
>  
> +/*
> + * Data exported by the security modules
> + */
> +#define LSMDATA_ENTRIES ( \

LSMBLOB_ENTRIES?

> +	(IS_ENABLED(CONFIG_SECURITY_SELINUX) ? 1 : 0) + \
> +	(IS_ENABLED(CONFIG_SECURITY_SMACK) ? 1 : 0) + \
> +	(IS_ENABLED(CONFIG_SECURITY_APPARMOR) ? 1 : 0) )
> +
> +struct lsmblob {
> +	u32     secid[LSMDATA_ENTRIES];
> +};

Cool; I like this auto-sizing.

> +
> +#define LSMDATA_INVALID	-1
> +
> +/**
> + * lsmblob_init - initialize an lsmblob structure.
> + * @l: Pointer to the data to initialize
> + * @secid: The initial secid value
> + *
> + * Set all secid for all modules to the specified value.
> + */
> +static inline void lsmblob_init(struct lsmblob *l, u32 secid)
> +{
> +	int i;
> +
> +	for (i = 0; i < LSMDATA_ENTRIES; i++)
> +		l->secid[i] = secid;

For all these LSMDATA_ENTRIES, I prefer ARRAY_SIZE(l->secid), but
*shrug*

> +}
> +
> +/**
> + * lsmblob_is_set - report if there is an value in the lsmblob
> + * @l: Pointer to the exported LSM data
> + *
> + * Returns true if there is a secid set, false otherwise
> + */
> +static inline bool lsmblob_is_set(struct lsmblob *l)
> +{
> +	int i;
> +
> +	for (i = 0; i < LSMDATA_ENTRIES; i++)
> +		if (l->secid[i] != 0)
> +			return true;
> +	return false;
> +}
> +
> +/**
> + * lsmblob_equal - report if the two lsmblob's are equal
> + * @l: Pointer to one LSM data
> + * @m: Pointer to the other LSM data
> + *
> + * Returns true if all entries in the two are equal, false otherwise
> + */
> +static inline bool lsmblob_equal(struct lsmblob *l, struct lsmblob *m)
> +{
> +	int i;
> +
> +	for (i = 0; i < LSMDATA_ENTRIES; i++)
> +		if (l->secid[i] != m->secid[i])
> +			return false;
> +	return true;
> +}
> +
>  /* These functions are in security/commoncap.c */
>  extern int cap_capable(const struct cred *cred, struct user_namespace *ns,
>  		       int cap, unsigned int opts);
> diff --git a/security/security.c b/security/security.c
> index d05f00a40e82..5aa3c052d702 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -317,6 +317,7 @@ static void __init ordered_lsm_init(void)
>  	init_debug("sock blob size       = %d\n", blob_sizes.lbs_sock);
>  	init_debug("superblock blob size = %d\n", blob_sizes.lbs_superblock);
>  	init_debug("task blob size       = %d\n", blob_sizes.lbs_task);
> +	init_debug("lsmblob size         = %lu\n", sizeof(struct lsmblob));
>  
>  	/*
>  	 * Create any kmem_caches needed for blobs
> @@ -420,6 +421,11 @@ static int lsm_append(char *new, char **result)
>  	return 0;
>  }
>  
> +/*
> + * Current index to use while initializing the lsmblob secid list.
> + */
> +static int lsm_slot __initdata;
> +
>  /**
>   * security_add_hooks - Add a modules hooks to the hook lists.
>   * @hooks: the hooks to add
> @@ -427,15 +433,40 @@ static int lsm_append(char *new, char **result)
>   * @lsm: the name of the security module
>   *
>   * Each LSM has to register its hooks with the infrastructure.
> + * If the LSM is using hooks that export secids allocate a slot
> + * for it in the lsmblob.
>   */
>  void __init security_add_hooks(struct security_hook_list *hooks, int count,
>  				char *lsm)
>  {
> +	int slot = LSMDATA_INVALID;
>  	int i;
>  
>  	for (i = 0; i < count; i++) {
>  		hooks[i].lsm = lsm;
>  		hlist_add_tail_rcu(&hooks[i].list, hooks[i].head);
> +		/*
> +		 * If this is one of the hooks that uses a secid
> +		 * note it so that a slot can in allocated for the
> +		 * secid in the lsmblob structure.
> +		 */
> +		if (hooks[i].head == &security_hook_heads.audit_rule_match ||
> +		    hooks[i].head == &security_hook_heads.kernel_act_as ||
> +		    hooks[i].head ==
> +			&security_hook_heads.socket_getpeersec_dgram ||
> +		    hooks[i].head == &security_hook_heads.secctx_to_secid ||
> +		    hooks[i].head == &security_hook_heads.secid_to_secctx ||
> +		    hooks[i].head == &security_hook_heads.ipc_getsecid ||
> +		    hooks[i].head == &security_hook_heads.task_getsecid ||
> +		    hooks[i].head == &security_hook_heads.inode_getsecid ||
> +		    hooks[i].head == &security_hook_heads.cred_getsecid) {
> +			if (slot == LSMDATA_INVALID) {
> +				slot = lsm_slot++;

This needs to sanity check lsm_slot against lsmblob secids array size,
just we we catch cases cleanly if an LSM adds a hook but doesn't add
itself to the LSMDATA_ENTRIES macro.

> +				init_debug("%s assigned lsmblob slot %d\n",
> +					hooks[i].lsm, slot);
> +			}
> +		}
> +		hooks[i].slot = slot;
>  	}
>  	if (lsm_append(lsm, &lsm_names) < 0)
>  		panic("%s - Cannot get early memory.\n", __func__);
> -- 
> 2.20.1
> 

-- 
Kees Cook
