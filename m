Return-Path: <SRS0=B3ih=24=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ADF3C3F68F
	for <selinux@archiver.kernel.org>; Tue,  7 Jan 2020 18:09:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FDB42187F
	for <selinux@archiver.kernel.org>; Tue,  7 Jan 2020 18:09:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kLWfLWFN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728365AbgAGSJl (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 7 Jan 2020 13:09:41 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:44928 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728358AbgAGSJl (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 7 Jan 2020 13:09:41 -0500
Received: by mail-pl1-f196.google.com with SMTP id az3so22920plb.11
        for <selinux@vger.kernel.org>; Tue, 07 Jan 2020 10:09:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ai4A82M4iWF2TKuu16caIBXUDr+jDGHpOJYnUTB7B6g=;
        b=kLWfLWFND6ce+S22Yo0gJ6n5y1d33kqnRwqBCuzuAVNb7sHiKdhJCWkOhm86K3DxKp
         GCIHz2YX0hPJfIUzRDQadhxIMsDN5cE4+97dWK8LBj41icqSSO41gCnM9w9c655r55oN
         6wG1RqvybhSq9lOV39RmRlHppZN/FdB3L6RLA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ai4A82M4iWF2TKuu16caIBXUDr+jDGHpOJYnUTB7B6g=;
        b=RNx2e0x+iTNzT3zfNb+DIZ95gin5VS3sn0xB/44b799cmN1geVGtmJeJHrQtVT1+JI
         KsVMDaYAhLMSYQ7RmhIor6BU93JYiSeYcPxUQmIYcHjVi3TK1bssYI9KlWKR+MMGn9sZ
         J6jodDeBQhC81S3puM7T8EBWXdbVFHj9URQy9cskYECmr++No/0Zy9g+1DV1s3qFYe/8
         FbrQXU2uRM1ncgHarE5g/wGlEbaooqgbA1LrjBCpm6xsVjluyRoc1+YswzfS7D4u5/70
         yj08TqsjcY9CDzrWpFq1Z+TDRUwAtsFIw2UUH64I8da+PJ/eAbwjKyj/P+jzkZiHayvQ
         /o/A==
X-Gm-Message-State: APjAAAVKDfRHyab2nxzTQeifWuJjuZaNXPQYYVcYfnf7yToENpPJYBWL
        FEgKXge1w7hX3L3QtAElN901dw==
X-Google-Smtp-Source: APXvYqxFn2cblgdOeNxLGEKY5/LMEQcgpXusAQ7ig9h2qdx7z0ibd1Q93GDbjaYGIiVXFwI8vRyFoQ==
X-Received: by 2002:a17:902:bf47:: with SMTP id u7mr942635pls.259.1578420580356;
        Tue, 07 Jan 2020 10:09:40 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id q25sm224101pfg.41.2020.01.07.10.09.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2020 10:09:39 -0800 (PST)
Date:   Tue, 7 Jan 2020 10:09:38 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     linux-security-module@vger.kernel.org,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        John Johansen <john.johansen@canonical.com>,
        Micah Morton <mortonm@chromium.org>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: Re: [PATCH 1/2] selinux: treat atomic flags more carefully
Message-ID: <202001071009.3E0B826@keescook>
References: <20200107133154.588958-1-omosnace@redhat.com>
 <20200107133154.588958-2-omosnace@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200107133154.588958-2-omosnace@redhat.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Jan 07, 2020 at 02:31:53PM +0100, Ondrej Mosnacek wrote:
> The disabled/enforcing/initialized flags are all accessed concurrently
> by threads so use the appropriate accessors that ensure atomicity and
> document that it is expected.
> 
> Use smp_load/acquire...() helpers (with memory barriers) for the
> initialized flag, since it gates access to the rest of the state
> structures.
> 
> Note that the disabled flag is currently not used for anything other
> than avoiding double disable, but it will be used for bailing out of
> hooks once security_delete_hooks() is removed.
> 
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  security/selinux/hooks.c            | 21 ++++++++--------
>  security/selinux/include/security.h | 33 +++++++++++++++++++++++--
>  security/selinux/ss/services.c      | 38 ++++++++++++++---------------
>  3 files changed, 61 insertions(+), 31 deletions(-)
> 
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 659c4a81e897..47ad4db925cf 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -272,7 +272,7 @@ static int __inode_security_revalidate(struct inode *inode,
>  
>  	might_sleep_if(may_sleep);
>  
> -	if (selinux_state.initialized &&
> +	if (selinux_initialized(&selinux_state) &&
>  	    isec->initialized != LABEL_INITIALIZED) {
>  		if (!may_sleep)
>  			return -ECHILD;
> @@ -659,7 +659,7 @@ static int selinux_set_mnt_opts(struct super_block *sb,
>  
>  	mutex_lock(&sbsec->lock);
>  
> -	if (!selinux_state.initialized) {
> +	if (!selinux_initialized(&selinux_state)) {
>  		if (!opts) {
>  			/* Defer initialization until selinux_complete_init,
>  			   after the initial policy is loaded and the security
> @@ -928,7 +928,7 @@ static int selinux_sb_clone_mnt_opts(const struct super_block *oldsb,
>  	 * if the parent was able to be mounted it clearly had no special lsm
>  	 * mount options.  thus we can safely deal with this superblock later
>  	 */
> -	if (!selinux_state.initialized)
> +	if (!selinux_initialized(&selinux_state))
>  		return 0;
>  
>  	/*
> @@ -1103,7 +1103,7 @@ static int selinux_sb_show_options(struct seq_file *m, struct super_block *sb)
>  	if (!(sbsec->flags & SE_SBINITIALIZED))
>  		return 0;
>  
> -	if (!selinux_state.initialized)
> +	if (!selinux_initialized(&selinux_state))
>  		return 0;
>  
>  	if (sbsec->flags & FSCONTEXT_MNT) {
> @@ -2920,7 +2920,8 @@ static int selinux_inode_init_security(struct inode *inode, struct inode *dir,
>  		isec->initialized = LABEL_INITIALIZED;
>  	}
>  
> -	if (!selinux_state.initialized || !(sbsec->flags & SBLABEL_MNT))
> +	if (!selinux_initialized(&selinux_state) ||
> +	    !(sbsec->flags & SBLABEL_MNT))
>  		return -EOPNOTSUPP;
>  
>  	if (name)
> @@ -3143,7 +3144,7 @@ static int selinux_inode_setxattr(struct dentry *dentry, const char *name,
>  		return dentry_has_perm(current_cred(), dentry, FILE__SETATTR);
>  	}
>  
> -	if (!selinux_state.initialized)
> +	if (!selinux_initialized(&selinux_state))
>  		return (inode_owner_or_capable(inode) ? 0 : -EPERM);
>  
>  	sbsec = inode->i_sb->s_security;
> @@ -3229,7 +3230,7 @@ static void selinux_inode_post_setxattr(struct dentry *dentry, const char *name,
>  		return;
>  	}
>  
> -	if (!selinux_state.initialized) {
> +	if (!selinux_initialized(&selinux_state)) {
>  		/* If we haven't even been initialized, then we can't validate
>  		 * against a policy, so leave the label as invalid. It may
>  		 * resolve to a valid label on the next revalidation try if
> @@ -7304,17 +7305,17 @@ static void selinux_nf_ip_exit(void)
>  #ifdef CONFIG_SECURITY_SELINUX_DISABLE
>  int selinux_disable(struct selinux_state *state)
>  {
> -	if (state->initialized) {
> +	if (selinux_initialized(state)) {
>  		/* Not permitted after initial policy load. */
>  		return -EINVAL;
>  	}
>  
> -	if (state->disabled) {
> +	if (selinux_disabled(state)) {
>  		/* Only do this once. */
>  		return -EINVAL;
>  	}
>  
> -	state->disabled = 1;
> +	selinux_mark_disabled(state);
>  
>  	pr_info("SELinux:  Disabled at runtime.\n");
>  
> diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
> index ecdd610e6449..a39f9565d80b 100644
> --- a/security/selinux/include/security.h
> +++ b/security/selinux/include/security.h
> @@ -117,15 +117,27 @@ void selinux_avc_init(struct selinux_avc **avc);
>  
>  extern struct selinux_state selinux_state;
>  
> +static inline bool selinux_initialized(const struct selinux_state *state)
> +{
> +	/* do a synchronized load to avoid race conditions */
> +	return smp_load_acquire(&state->initialized);
> +}
> +
> +static inline void selinux_mark_initialized(struct selinux_state *state)
> +{
> +	/* do a synchronized write to avoid race conditions */
> +	smp_store_release(&state->initialized, true);
> +}
> +
>  #ifdef CONFIG_SECURITY_SELINUX_DEVELOP
>  static inline bool enforcing_enabled(struct selinux_state *state)
>  {
> -	return state->enforcing;
> +	return READ_ONCE(state->enforcing);
>  }
>  
>  static inline void enforcing_set(struct selinux_state *state, bool value)
>  {
> -	state->enforcing = value;
> +	WRITE_ONCE(state->enforcing, value);
>  }
>  #else
>  static inline bool enforcing_enabled(struct selinux_state *state)
> @@ -138,6 +150,23 @@ static inline void enforcing_set(struct selinux_state *state, bool value)
>  }
>  #endif
>  
> +#ifdef CONFIG_SECURITY_SELINUX_DISABLE
> +static inline bool selinux_disabled(struct selinux_state *state)
> +{
> +	return READ_ONCE(state->disabled);
> +}
> +
> +static inline void selinux_mark_disabled(struct selinux_state *state)
> +{
> +	WRITE_ONCE(state->disabled, true);
> +}
> +#else
> +static inline bool selinux_disabled(struct selinux_state *state)
> +{
> +	return false;
> +}
> +#endif
> +
>  static inline bool selinux_policycap_netpeer(void)
>  {
>  	struct selinux_state *state = &selinux_state;
> diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
> index 55cf42945cba..0e8b94e8e156 100644
> --- a/security/selinux/ss/services.c
> +++ b/security/selinux/ss/services.c
> @@ -767,7 +767,7 @@ static int security_compute_validatetrans(struct selinux_state *state,
>  	int rc = 0;
>  
>  
> -	if (!state->initialized)
> +	if (!selinux_initialized(state))
>  		return 0;
>  
>  	read_lock(&state->ss->policy_rwlock);
> @@ -868,7 +868,7 @@ int security_bounded_transition(struct selinux_state *state,
>  	int index;
>  	int rc;
>  
> -	if (!state->initialized)
> +	if (!selinux_initialized(state))
>  		return 0;
>  
>  	read_lock(&state->ss->policy_rwlock);
> @@ -1027,7 +1027,7 @@ void security_compute_xperms_decision(struct selinux_state *state,
>  	memset(xpermd->dontaudit->p, 0, sizeof(xpermd->dontaudit->p));
>  
>  	read_lock(&state->ss->policy_rwlock);
> -	if (!state->initialized)
> +	if (!selinux_initialized(state))
>  		goto allow;
>  
>  	policydb = &state->ss->policydb;
> @@ -1112,7 +1112,7 @@ void security_compute_av(struct selinux_state *state,
>  	read_lock(&state->ss->policy_rwlock);
>  	avd_init(state, avd);
>  	xperms->len = 0;
> -	if (!state->initialized)
> +	if (!selinux_initialized(state))
>  		goto allow;
>  
>  	policydb = &state->ss->policydb;
> @@ -1166,7 +1166,7 @@ void security_compute_av_user(struct selinux_state *state,
>  
>  	read_lock(&state->ss->policy_rwlock);
>  	avd_init(state, avd);
> -	if (!state->initialized)
> +	if (!selinux_initialized(state))
>  		goto allow;
>  
>  	policydb = &state->ss->policydb;
> @@ -1286,7 +1286,7 @@ int security_sidtab_hash_stats(struct selinux_state *state, char *page)
>  {
>  	int rc;
>  
> -	if (!state->initialized) {
> +	if (!selinux_initialized(state)) {
>  		pr_err("SELinux: %s:  called before initial load_policy\n",
>  		       __func__);
>  		return -EINVAL;
> @@ -1320,7 +1320,7 @@ static int security_sid_to_context_core(struct selinux_state *state,
>  		*scontext = NULL;
>  	*scontext_len  = 0;
>  
> -	if (!state->initialized) {
> +	if (!selinux_initialized(state)) {
>  		if (sid <= SECINITSID_NUM) {
>  			char *scontextp;
>  
> @@ -1549,7 +1549,7 @@ static int security_context_to_sid_core(struct selinux_state *state,
>  	if (!scontext2)
>  		return -ENOMEM;
>  
> -	if (!state->initialized) {
> +	if (!selinux_initialized(state)) {
>  		int i;
>  
>  		for (i = 1; i < SECINITSID_NUM; i++) {
> @@ -1736,7 +1736,7 @@ static int security_compute_sid(struct selinux_state *state,
>  	int rc = 0;
>  	bool sock;
>  
> -	if (!state->initialized) {
> +	if (!selinux_initialized(state)) {
>  		switch (orig_tclass) {
>  		case SECCLASS_PROCESS: /* kernel value */
>  			*out_sid = ssid;
> @@ -2198,7 +2198,7 @@ int security_load_policy(struct selinux_state *state, void *data, size_t len)
>  		goto out;
>  	}
>  
> -	if (!state->initialized) {
> +	if (!selinux_initialized(state)) {
>  		rc = policydb_read(policydb, fp);
>  		if (rc) {
>  			kfree(newsidtab);
> @@ -2223,7 +2223,7 @@ int security_load_policy(struct selinux_state *state, void *data, size_t len)
>  
>  		state->ss->sidtab = newsidtab;
>  		security_load_policycaps(state);
> -		state->initialized = 1;
> +		selinux_mark_initialized(state);
>  		seqno = ++state->ss->latest_granting;
>  		selinux_complete_init();
>  		avc_ss_reset(state->avc, seqno);
> @@ -2639,7 +2639,7 @@ int security_get_user_sids(struct selinux_state *state,
>  	*sids = NULL;
>  	*nel = 0;
>  
> -	if (!state->initialized)
> +	if (!selinux_initialized(state))
>  		goto out;
>  
>  	read_lock(&state->ss->policy_rwlock);
> @@ -2875,7 +2875,7 @@ int security_get_bools(struct selinux_state *state,
>  	struct policydb *policydb;
>  	int i, rc;
>  
> -	if (!state->initialized) {
> +	if (!selinux_initialized(state)) {
>  		*len = 0;
>  		*names = NULL;
>  		*values = NULL;
> @@ -3050,7 +3050,7 @@ int security_sid_mls_copy(struct selinux_state *state,
>  	int rc;
>  
>  	rc = 0;
> -	if (!state->initialized || !policydb->mls_enabled) {
> +	if (!selinux_initialized(state) || !policydb->mls_enabled) {
>  		*new_sid = sid;
>  		goto out;
>  	}
> @@ -3217,7 +3217,7 @@ int security_get_classes(struct selinux_state *state,
>  	struct policydb *policydb = &state->ss->policydb;
>  	int rc;
>  
> -	if (!state->initialized) {
> +	if (!selinux_initialized(state)) {
>  		*nclasses = 0;
>  		*classes = NULL;
>  		return 0;
> @@ -3366,7 +3366,7 @@ int selinux_audit_rule_init(u32 field, u32 op, char *rulestr, void **vrule)
>  
>  	*rule = NULL;
>  
> -	if (!state->initialized)
> +	if (!selinux_initialized(state))
>  		return -EOPNOTSUPP;
>  
>  	switch (field) {
> @@ -3665,7 +3665,7 @@ int security_netlbl_secattr_to_sid(struct selinux_state *state,
>  	struct context *ctx;
>  	struct context ctx_new;
>  
> -	if (!state->initialized) {
> +	if (!selinux_initialized(state)) {
>  		*sid = SECSID_NULL;
>  		return 0;
>  	}
> @@ -3732,7 +3732,7 @@ int security_netlbl_sid_to_secattr(struct selinux_state *state,
>  	int rc;
>  	struct context *ctx;
>  
> -	if (!state->initialized)
> +	if (!selinux_initialized(state))
>  		return 0;
>  
>  	read_lock(&state->ss->policy_rwlock);
> @@ -3771,7 +3771,7 @@ int security_read_policy(struct selinux_state *state,
>  	int rc;
>  	struct policy_file fp;
>  
> -	if (!state->initialized)
> +	if (!selinux_initialized(state))
>  		return -EINVAL;
>  
>  	*len = security_policydb_len(state);
> -- 
> 2.24.1
> 

-- 
Kees Cook
