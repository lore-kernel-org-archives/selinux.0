Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-23.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E1E3C432C3
	for <selinux@archiver.kernel.org>; Wed,  3 Mar 2021 04:35:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0293E64EC0
	for <selinux@archiver.kernel.org>; Wed,  3 Mar 2021 04:35:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352919AbhCCE0p (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 2 Mar 2021 23:26:45 -0500
Received: from linux.microsoft.com ([13.77.154.182]:51628 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232861AbhCCC6X (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 2 Mar 2021 21:58:23 -0500
Received: from sequoia (162-237-133-238.lightspeed.rcsntx.sbcglobal.net [162.237.133.238])
        by linux.microsoft.com (Postfix) with ESMTPSA id 85C4B20B83EC;
        Tue,  2 Mar 2021 18:57:32 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 85C4B20B83EC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1614740252;
        bh=to2KJxJCH5auLUuRmKS/Q/BCsMvntcfgqPrFg7RdUlw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=o6Wbkt0h4Sezi44BCwI/rhQRGehWA8pBHo8cyC+DS+0MQnbv/GUv66V0/KsxVLAXb
         fytzlUlpl/SLNz5lFyPmYIaa1Cy6B5JeNA513XGMT9vd2pQoFJsJB5PHuz+nP11evc
         l41KAWKmCXsjKd7YGTf1qSjDbLPcYWTW+V5AHAjc=
Date:   Tue, 2 Mar 2021 20:57:30 -0600
From:   Tyler Hicks <tyhicks@linux.microsoft.com>
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: Re: [PATCH v2 2/2] selinux: fix variable scope issue in live sidtab
 conversion
Message-ID: <20210303025730.GI6000@sequoia>
References: <20210212185930.130477-1-omosnace@redhat.com>
 <20210212185930.130477-3-omosnace@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210212185930.130477-3-omosnace@redhat.com>
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 2021-02-12 19:59:30, Ondrej Mosnacek wrote:
> Commit 02a52c5c8c3b ("selinux: move policy commit after updating
> selinuxfs") moved the selinux_policy_commit() call out of
> security_load_policy() into sel_write_load(), which caused a subtle yet
> rather serious bug.
> 
> The problem is that security_load_policy() passes a reference to the
> convert_params local variable to sidtab_convert(), which stores it in
> the sidtab, where it may be accessed until the policy is swapped over
> and RCU synchronized. Before 02a52c5c8c3b, selinux_policy_commit() was
> called directly from security_load_policy(), so the convert_params
> pointer remained valid all the way until the old sidtab was destroyed,
> but now that's no longer the case and calls to sidtab_context_to_sid()
> on the old sidtab after security_load_policy() returns may cause invalid
> memory accesses.
> 
> This can be easily triggered using the stress test from commit
> ee1a84fdfeed ("selinux: overhaul sidtab to fix bug and improve
> performance"):
> ```
> function rand_cat() {
> 	echo $(( $RANDOM % 1024 ))
> }
> 
> function do_work() {
> 	while true; do
> 		echo -n "system_u:system_r:kernel_t:s0:c$(rand_cat),c$(rand_cat)" \
> 			>/sys/fs/selinux/context 2>/dev/null || true
> 	done
> }
> 
> do_work >/dev/null &
> do_work >/dev/null &
> do_work >/dev/null &
> 
> while load_policy; do echo -n .; sleep 0.1; done
> 
> kill %1
> kill %2
> kill %3
> ```
> 
> Fix this by allocating the temporary sidtab convert structures
> dynamically and passing them among the
> selinux_policy_{load,cancel,commit} functions.
> 
> Note that this commit also fixes the minor issue of logging a
> MAC_POLICY_LOAD audit record in case sel_make_policy_nodes() fails (in
> which case the new policy isn't actually loaded).
> 
> Fixes: 02a52c5c8c3b ("selinux: move policy commit after updating selinuxfs")
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>

Tested-by: Tyler Hicks <tyhicks@linux.microsoft.com>
Reviewed-by: Tyler Hicks <tyhicks@linux.microsoft.com>

Feel free to leave those tags on your v3 submission after making the two
small changes requested by Paul.

Tyler

> ---
>  security/selinux/include/security.h | 15 ++++++---
>  security/selinux/selinuxfs.c        | 10 +++---
>  security/selinux/ss/services.c      | 51 +++++++++++++++++++----------
>  3 files changed, 49 insertions(+), 27 deletions(-)
> 
> diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
> index 765a258a899e..25db66e0ac51 100644
> --- a/security/selinux/include/security.h
> +++ b/security/selinux/include/security.h
> @@ -219,14 +219,21 @@ static inline bool selinux_policycap_genfs_seclabel_symlinks(void)
>  	return READ_ONCE(state->policycap[POLICYDB_CAPABILITY_GENFS_SECLABEL_SYMLINKS]);
>  }
>  
> +struct selinux_policy_convert_data;
> +
> +struct selinux_load_state {
> +	struct selinux_policy *policy;
> +	struct selinux_policy_convert_data *convert_data;
> +};
> +
>  int security_mls_enabled(struct selinux_state *state);
>  int security_load_policy(struct selinux_state *state,
> -			void *data, size_t len,
> -			struct selinux_policy **newpolicyp);
> +			 void *data, size_t len,
> +			 struct selinux_load_state *load_state);
>  void selinux_policy_commit(struct selinux_state *state,
> -			struct selinux_policy *newpolicy);
> +			   struct selinux_load_state *load_state);
>  void selinux_policy_cancel(struct selinux_state *state,
> -			struct selinux_policy *policy);
> +			   struct selinux_load_state *load_state);
>  int security_read_policy(struct selinux_state *state,
>  			 void **data, size_t *len);
>  
> diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
> index 340711e3dc9a..158d44ea93f4 100644
> --- a/security/selinux/selinuxfs.c
> +++ b/security/selinux/selinuxfs.c
> @@ -616,7 +616,7 @@ static ssize_t sel_write_load(struct file *file, const char __user *buf,
>  
>  {
>  	struct selinux_fs_info *fsi = file_inode(file)->i_sb->s_fs_info;
> -	struct selinux_policy *newpolicy;
> +	struct selinux_load_state load_state;
>  	ssize_t length;
>  	void *data = NULL;
>  
> @@ -642,19 +642,19 @@ static ssize_t sel_write_load(struct file *file, const char __user *buf,
>  	if (copy_from_user(data, buf, count) != 0)
>  		goto out;
>  
> -	length = security_load_policy(fsi->state, data, count, &newpolicy);
> +	length = security_load_policy(fsi->state, data, count, &load_state);
>  	if (length) {
>  		pr_warn_ratelimited("SELinux: failed to load policy\n");
>  		goto out;
>  	}
>  
> -	length = sel_make_policy_nodes(fsi, newpolicy);
> +	length = sel_make_policy_nodes(fsi, load_state.policy);
>  	if (length) {
> -		selinux_policy_cancel(fsi->state, newpolicy);
> +		selinux_policy_cancel(fsi->state, &load_state);
>  		goto out;
>  	}
>  
> -	selinux_policy_commit(fsi->state, newpolicy);
> +	selinux_policy_commit(fsi->state, &load_state);
>  
>  	length = count;
>  
> diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
> index 5e08ce2c5994..fada4ebc7ef8 100644
> --- a/security/selinux/ss/services.c
> +++ b/security/selinux/ss/services.c
> @@ -2157,8 +2157,13 @@ static void selinux_policy_cond_free(struct selinux_policy *policy)
>  	kfree(policy);
>  }
>  
> +struct selinux_policy_convert_data {
> +	struct convert_context_args args;
> +	struct sidtab_convert_params sidtab_params;
> +};
> +
>  void selinux_policy_cancel(struct selinux_state *state,
> -			struct selinux_policy *policy)
> +			   struct selinux_load_state *load_state)
>  {
>  	struct selinux_policy *oldpolicy;
>  
> @@ -2166,7 +2171,8 @@ void selinux_policy_cancel(struct selinux_state *state,
>  					lockdep_is_held(&state->policy_mutex));
>  
>  	sidtab_cancel_convert(oldpolicy->sidtab);
> -	selinux_policy_free(policy);
> +	selinux_policy_free(load_state->policy);
> +	kfree(load_state->convert_data);
>  }
>  
>  static void selinux_notify_policy_change(struct selinux_state *state,
> @@ -2181,9 +2187,9 @@ static void selinux_notify_policy_change(struct selinux_state *state,
>  }
>  
>  void selinux_policy_commit(struct selinux_state *state,
> -			struct selinux_policy *newpolicy)
> +			   struct selinux_load_state *load_state)
>  {
> -	struct selinux_policy *oldpolicy;
> +	struct selinux_policy *oldpolicy, *newpolicy = load_state->policy;
>  	u32 seqno;
>  
>  	oldpolicy = rcu_dereference_protected(state->policy,
> @@ -2223,6 +2229,7 @@ void selinux_policy_commit(struct selinux_state *state,
>  	/* Free the old policy */
>  	synchronize_rcu();
>  	selinux_policy_free(oldpolicy);
> +	kfree(load_state->convert_data);
>  
>  	/* Notify others of the policy change */
>  	selinux_notify_policy_change(state, seqno);
> @@ -2239,11 +2246,10 @@ void selinux_policy_commit(struct selinux_state *state,
>   * loading the new policy.
>   */
>  int security_load_policy(struct selinux_state *state, void *data, size_t len,
> -			struct selinux_policy **newpolicyp)
> +			 struct selinux_load_state *load_state)
>  {
>  	struct selinux_policy *newpolicy, *oldpolicy;
> -	struct sidtab_convert_params convert_params;
> -	struct convert_context_args args;
> +	struct selinux_policy_convert_data *convert_data;
>  	int rc = 0;
>  	struct policy_file file = { data, len }, *fp = &file;
>  
> @@ -2273,10 +2279,10 @@ int security_load_policy(struct selinux_state *state, void *data, size_t len,
>  		goto err_mapping;
>  	}
>  
> -
>  	if (!selinux_initialized(state)) {
>  		/* First policy load, so no need to preserve state from old policy */
> -		*newpolicyp = newpolicy;
> +		load_state->policy = newpolicy;
> +		load_state->convert_data = NULL;
>  		return 0;
>  	}
>  
> @@ -2290,29 +2296,38 @@ int security_load_policy(struct selinux_state *state, void *data, size_t len,
>  		goto err_free_isids;
>  	}
>  
> +	convert_data = kmalloc(sizeof(*convert_data), GFP_KERNEL);
> +	if (!convert_data) {
> +		rc = -ENOMEM;
> +		goto err_free_isids;
> +	}
> +
>  	/*
>  	 * Convert the internal representations of contexts
>  	 * in the new SID table.
>  	 */
> -	args.state = state;
> -	args.oldp = &oldpolicy->policydb;
> -	args.newp = &newpolicy->policydb;
> +	convert_data->args.state = state;
> +	convert_data->args.oldp = &oldpolicy->policydb;
> +	convert_data->args.newp = &newpolicy->policydb;
>  
> -	convert_params.func = convert_context;
> -	convert_params.args = &args;
> -	convert_params.target = newpolicy->sidtab;
> +	convert_data->sidtab_params.func = convert_context;
> +	convert_data->sidtab_params.args = &convert_data->args;
> +	convert_data->sidtab_params.target = newpolicy->sidtab;
>  
> -	rc = sidtab_convert(oldpolicy->sidtab, &convert_params);
> +	rc = sidtab_convert(oldpolicy->sidtab, &convert_data->sidtab_params);
>  	if (rc) {
>  		pr_err("SELinux:  unable to convert the internal"
>  			" representation of contexts in the new SID"
>  			" table\n");
> -		goto err_free_isids;
> +		goto err_free_convert_data;
>  	}
>  
> -	*newpolicyp = newpolicy;
> +	load_state->policy = newpolicy;
> +	load_state->convert_data = convert_data;
>  	return 0;
>  
> +err_free_convert_data:
> +	kfree(convert_data);
>  err_free_isids:
>  	sidtab_destroy(newpolicy->sidtab);
>  err_mapping:
> -- 
> 2.29.2
> 
