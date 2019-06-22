Return-Path: <SRS0=BI9l=UV=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14030C43613
	for <selinux@archiver.kernel.org>; Sat, 22 Jun 2019 22:42:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C65CB2070B
	for <selinux@archiver.kernel.org>; Sat, 22 Jun 2019 22:42:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Hi6Dulo7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726290AbfFVWmr (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 22 Jun 2019 18:42:47 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:38756 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725844AbfFVWmq (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sat, 22 Jun 2019 18:42:46 -0400
Received: by mail-pl1-f194.google.com with SMTP id g4so4740092plb.5
        for <selinux@vger.kernel.org>; Sat, 22 Jun 2019 15:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=oifZtYtaymGeepdlKcC/lwfrN00OPy3AvMSUCQesT1M=;
        b=Hi6Dulo7vEb1nXC4gr2G3cIgGW/ulRL6bE5VWshv55MYsYjvDDto9ezVuUa1pSGnPN
         nxpmlZbRmk0tNGjO8y1F+zTEgFJqen1R4WOMmojzfmyf9275GNC6sw8jRpCj2dc2SU1e
         yXT+4hJiCW1JXRFnMJwx/svpJmLsBnaRRp/bE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oifZtYtaymGeepdlKcC/lwfrN00OPy3AvMSUCQesT1M=;
        b=rY3ZGR/Pr5WFNk/enAL5aYhfn13qRX03D0ezd/8SH5SdkAlQlWhSNmyckwED55NZ3H
         gGcHbZAaAoq3yA6vzRYr8g6X5+lvg7ijTiOqOibuXjrb/XgSzZ9Lx1XZT1pA3KCOtzDp
         A1+NE8mobBsvwPlhE5crJWDBiGfH3w/OTjznz8GsGlREsnUub/xq8fi8AQSJXTH5t+hq
         NVLMInzq0sgAZCHWrCYJJBHaj47Wq+CnwQ7MZ9iHzPZ+SBnw5kcWqLbULNqiT5YWCUck
         B6J2hSSJT18l7rAzi2J9QsIl4eNEOdOsRqCPMpMMJw9CoSFqDpo8GI4VkNbpROkHtX5R
         wEWg==
X-Gm-Message-State: APjAAAVwi4LgCpig/MDrAgjQv0MUnavmUHjzmn2L3q6oDmUHfq1sMUQo
        QZiVMOlBKgZqVE/nLMU2XTt6BA==
X-Google-Smtp-Source: APXvYqydu3U0p+kic6rtp7M67YfDPGMYWttOm7sdq7eOEXOE9ULREbpEllayKN96A2tlWRmLr8P8ug==
X-Received: by 2002:a17:902:e01:: with SMTP id 1mr8924783plw.268.1561243366009;
        Sat, 22 Jun 2019 15:42:46 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id w132sm6905181pfd.78.2019.06.22.15.42.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 22 Jun 2019 15:42:45 -0700 (PDT)
Date:   Sat, 22 Jun 2019 15:42:44 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: Re: [PATCH v3 04/24] LSM: Create and manage the lsmblob data
 structure.
Message-ID: <201906221542.510418C3@keescook>
References: <20190621185233.6766-1-casey@schaufler-ca.com>
 <20190621185233.6766-5-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190621185233.6766-5-casey@schaufler-ca.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Jun 21, 2019 at 11:52:13AM -0700, Casey Schaufler wrote:
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

Acked-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  include/linux/lsm_hooks.h |  1 +
>  include/linux/security.h  | 62 +++++++++++++++++++++++++++++++++++++++
>  security/security.c       | 36 +++++++++++++++++++++++
>  3 files changed, 99 insertions(+)
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
>  
>  /*
> diff --git a/include/linux/security.h b/include/linux/security.h
> index 49f2685324b0..0aa9417a5762 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -76,6 +76,68 @@ enum lsm_event {
>  	LSM_POLICY_CHANGE,
>  };
>  
> +/*
> + * Data exported by the security modules
> + */
> +#define LSMBLOB_ENTRIES ( \
> +	(IS_ENABLED(CONFIG_SECURITY_SELINUX) ? 1 : 0) + \
> +	(IS_ENABLED(CONFIG_SECURITY_SMACK) ? 1 : 0) + \
> +	(IS_ENABLED(CONFIG_SECURITY_APPARMOR) ? 1 : 0))
> +
> +struct lsmblob {
> +	u32     secid[LSMBLOB_ENTRIES];
> +};
> +
> +#define LSMBLOB_INVALID	-1
> +
> +/**
> + * lsmblob_init - initialize an lsmblob structure.
> + * @blob: Pointer to the data to initialize
> + * @secid: The initial secid value
> + *
> + * Set all secid for all modules to the specified value.
> + */
> +static inline void lsmblob_init(struct lsmblob *blob, u32 secid)
> +{
> +	int i;
> +
> +	for (i = 0; i < LSMBLOB_ENTRIES; i++)
> +		blob->secid[i] = secid;
> +}
> +
> +/**
> + * lsmblob_is_set - report if there is an value in the lsmblob
> + * @blob: Pointer to the exported LSM data
> + *
> + * Returns true if there is a secid set, false otherwise
> + */
> +static inline bool lsmblob_is_set(struct lsmblob *blob)
> +{
> +	int i;
> +
> +	for (i = 0; i < LSMBLOB_ENTRIES; i++)
> +		if (blob->secid[i] != 0)
> +			return true;
> +	return false;
> +}
> +
> +/**
> + * lsmblob_equal - report if the two lsmblob's are equal
> + * @bloba: Pointer to one LSM data
> + * @blobb: Pointer to the other LSM data
> + *
> + * Returns true if all entries in the two are equal, false otherwise
> + */
> +static inline bool lsmblob_equal(struct lsmblob *bloba, struct lsmblob *blobb)
> +{
> +	int i;
> +
> +	for (i = 0; i < LSMBLOB_ENTRIES; i++)
> +		if (bloba->secid[i] != blobb->secid[i])
> +			return false;
> +	return true;
> +}
> +
>  /* These functions are in security/commoncap.c */
>  extern int cap_capable(const struct cred *cred, struct user_namespace *ns,
>  		       int cap, unsigned int opts);
> diff --git a/security/security.c b/security/security.c
> index d05f00a40e82..7618c761060d 100644
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
> @@ -427,15 +433,45 @@ static int lsm_append(char *new, char **result)
>   * @lsm: the name of the security module
>   *
>   * Each LSM has to register its hooks with the infrastructure.
> + * If the LSM is using hooks that export secids allocate a slot
> + * for it in the lsmblob.
>   */
>  void __init security_add_hooks(struct security_hook_list *hooks, int count,
>  				char *lsm)
>  {
> +	int slot = LSMBLOB_INVALID;
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
> +		    hooks[i].head == &security_hook_heads.getprocattr ||
> +		    hooks[i].head == &security_hook_heads.setprocattr ||
> +		    hooks[i].head == &security_hook_heads.secctx_to_secid ||
> +		    hooks[i].head == &security_hook_heads.secid_to_secctx ||
> +		    hooks[i].head == &security_hook_heads.ipc_getsecid ||
> +		    hooks[i].head == &security_hook_heads.task_getsecid ||
> +		    hooks[i].head == &security_hook_heads.inode_getsecid ||
> +		    hooks[i].head == &security_hook_heads.cred_getsecid) {
> +			if (slot == LSMBLOB_INVALID) {
> +				slot = lsm_slot++;
> +				if (slot >= LSMBLOB_ENTRIES)
> +					panic("%s Too many LSMs registered.\n",
> +					      __func__);
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
