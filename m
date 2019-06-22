Return-Path: <SRS0=BI9l=UV=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBB98C43613
	for <selinux@archiver.kernel.org>; Sat, 22 Jun 2019 22:51:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9355020673
	for <selinux@archiver.kernel.org>; Sat, 22 Jun 2019 22:51:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JXiqGENR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726388AbfFVWvL (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 22 Jun 2019 18:51:11 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:39079 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726379AbfFVWvL (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sat, 22 Jun 2019 18:51:11 -0400
Received: by mail-pl1-f196.google.com with SMTP id b7so4766080pls.6
        for <selinux@vger.kernel.org>; Sat, 22 Jun 2019 15:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8uJUBIdVeiwIgJWQ+yjJ9wbRMcOW7pm9R396v1auN14=;
        b=JXiqGENRW0k5SoGGtTs8I9Slu3rutfpsb/UTs4BL3guzsxTA9KtBmXdAbIu2JLLQpB
         sGdIDBpNGorha38Q86tDzKsP3MiTkkEFx9kr1GAL8ov1Dap0sYyy20EeI4RxbKzssDRZ
         dMcwMFZqnh8LingmNvuSdsv0Itnw1Y775jV2c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8uJUBIdVeiwIgJWQ+yjJ9wbRMcOW7pm9R396v1auN14=;
        b=URlOnLJfFdt9J50syMou03hOOI7p7DUF3L+UGNZFjm/Zy7llDJuXiuiaR/1G8YmOke
         fljlvaxdFUoidHaJbz8PTkaIeFLXb0FIHYzXzthophZ1++6TyRUx+/dpgBFFclfvMtN3
         WF+4q5+02r/ulo7SY7XqnNbuiqfxqI/zU7hlgLd32ocfPYj7h4OOv8dOq5dWIM1+dBgH
         R+vTSZiuaSYE2vsnFtgf/CtRDCotfdRudc8JUR7wwTZvP8aZEd1p9j2MKn6RzuAEKJLF
         O46psrMgWziprSJswizrhktjN3Gy/GyJIXFb8iqc9I/e5YT47mP45u0m7yIA3DnZkpcK
         jUzw==
X-Gm-Message-State: APjAAAXGEnr6YO/qoxKWESKQ5J7rgpsHrxSOXIN3ioZjWlzOHy1ZF5bX
        8ux1XHxaFmAMF+QaPsWVIDIc9A==
X-Google-Smtp-Source: APXvYqwg4VBWom9erpXQP3x3oR5qK9R19x3y/4ykbuw8oa8RWllskP1ROvdaNHSxmHZ58NU6G7xNyA==
X-Received: by 2002:a17:902:8b88:: with SMTP id ay8mr72115294plb.139.1561243869703;
        Sat, 22 Jun 2019 15:51:09 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 196sm9745334pfy.167.2019.06.22.15.51.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 22 Jun 2019 15:51:09 -0700 (PDT)
Date:   Sat, 22 Jun 2019 15:51:08 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: Re: [PATCH v3 14/24] IMA: Change internal interfaces to use lsmblobs
Message-ID: <201906221550.BB72176990@keescook>
References: <20190621185233.6766-1-casey@schaufler-ca.com>
 <20190621185233.6766-15-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190621185233.6766-15-casey@schaufler-ca.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Jun 21, 2019 at 11:52:23AM -0700, Casey Schaufler wrote:
> The IMA interfaces ima_get_action() and ima_match_policy()
> call LSM functions that use lsmblobs. Change the IMA functions
> to pass the lsmblob to be compatible with the LSM functions.
> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>  security/integrity/ima/ima.h          | 10 ++++++----
>  security/integrity/ima/ima_api.c      |  9 +++++----
>  security/integrity/ima/ima_appraise.c |  4 +---
>  security/integrity/ima/ima_main.c     | 27 +++++++++++----------------
>  security/integrity/ima/ima_policy.c   | 12 ++++++------
>  5 files changed, 29 insertions(+), 33 deletions(-)
> 
> diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
> index 5a337239d9e4..73b3b15dec5c 100644
> --- a/security/integrity/ima/ima.h
> +++ b/security/integrity/ima/ima.h
> @@ -192,8 +192,9 @@ enum ima_hooks {
>  };
>  
>  /* LIM API function definitions */
> -int ima_get_action(struct inode *inode, const struct cred *cred, u32 secid,
> -		   int mask, enum ima_hooks func, int *pcr);
> +int ima_get_action(struct inode *inode, const struct cred *cred,
> +		   struct lsmblob *blob, int mask, enum ima_hooks func,
> +		   int *pcr);
>  int ima_must_measure(struct inode *inode, int mask, enum ima_hooks func);
>  int ima_collect_measurement(struct integrity_iint_cache *iint,
>  			    struct file *file, void *buf, loff_t size,
> @@ -213,8 +214,9 @@ void ima_free_template_entry(struct ima_template_entry *entry);
>  const char *ima_d_path(const struct path *path, char **pathbuf, char *filename);
>  
>  /* IMA policy related functions */
> -int ima_match_policy(struct inode *inode, const struct cred *cred, u32 secid,
> -		     enum ima_hooks func, int mask, int flags, int *pcr);
> +int ima_match_policy(struct inode *inode, const struct cred *cred,
> +		     struct lsmblob *blob, enum ima_hooks func, int mask,
> +		     int flags, int *pcr);
>  void ima_init_policy(void);
>  void ima_update_policy(void);
>  void ima_update_policy_flag(void);
> diff --git a/security/integrity/ima/ima_api.c b/security/integrity/ima/ima_api.c
> index c7505fb122d4..03a2392852de 100644
> --- a/security/integrity/ima/ima_api.c
> +++ b/security/integrity/ima/ima_api.c
> @@ -159,7 +159,7 @@ void ima_add_violation(struct file *file, const unsigned char *filename,
>   * ima_get_action - appraise & measure decision based on policy.
>   * @inode: pointer to inode to measure
>   * @cred: pointer to credentials structure to validate
> - * @secid: secid of the task being validated
> + * @blob: LAM data of the task being validated

typo: LAM -> LSM

with that fixed:

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

>   * @mask: contains the permission mask (MAY_READ, MAY_WRITE, MAY_EXEC,
>   *        MAY_APPEND)
>   * @func: caller identifier
> @@ -175,14 +175,15 @@ void ima_add_violation(struct file *file, const unsigned char *filename,
>   * Returns IMA_MEASURE, IMA_APPRAISE mask.
>   *
>   */
> -int ima_get_action(struct inode *inode, const struct cred *cred, u32 secid,
> -		   int mask, enum ima_hooks func, int *pcr)
> +int ima_get_action(struct inode *inode, const struct cred *cred,
> +		   struct lsmblob *blob, int mask, enum ima_hooks func,
> +		   int *pcr)
>  {
>  	int flags = IMA_MEASURE | IMA_AUDIT | IMA_APPRAISE | IMA_HASH;
>  
>  	flags &= ima_policy_flag;
>  
> -	return ima_match_policy(inode, cred, secid, func, mask, flags, pcr);
> +	return ima_match_policy(inode, cred, blob, func, mask, flags, pcr);
>  }
>  
>  /*
> diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
> index 85c7692fc4a3..3ff7aae81829 100644
> --- a/security/integrity/ima/ima_appraise.c
> +++ b/security/integrity/ima/ima_appraise.c
> @@ -50,15 +50,13 @@ bool is_ima_appraise_enabled(void)
>   */
>  int ima_must_appraise(struct inode *inode, int mask, enum ima_hooks func)
>  {
> -	u32 secid;
>  	struct lsmblob blob;
>  
>  	if (!ima_appraise)
>  		return 0;
>  
>  	security_task_getsecid(current, &blob);
> -	lsmblob_secid(&blob, &secid);
> -	return ima_match_policy(inode, current_cred(), secid, func, mask,
> +	return ima_match_policy(inode, current_cred(), &blob, func, mask,
>  				IMA_APPRAISE | IMA_HASH, NULL);
>  }
>  
> diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
> index 1afb75a893af..0588dd9a88db 100644
> --- a/security/integrity/ima/ima_main.c
> +++ b/security/integrity/ima/ima_main.c
> @@ -169,8 +169,8 @@ void ima_file_free(struct file *file)
>  }
>  
>  static int process_measurement(struct file *file, const struct cred *cred,
> -			       u32 secid, char *buf, loff_t size, int mask,
> -			       enum ima_hooks func)
> +			       struct lsmblob *blob, char *buf, loff_t size,
> +			       int mask, enum ima_hooks func)
>  {
>  	struct inode *inode = file_inode(file);
>  	struct integrity_iint_cache *iint = NULL;
> @@ -192,7 +192,7 @@ static int process_measurement(struct file *file, const struct cred *cred,
>  	 * bitmask based on the appraise/audit/measurement policy.
>  	 * Included is the appraise submask.
>  	 */
> -	action = ima_get_action(inode, cred, secid, mask, func, &pcr);
> +	action = ima_get_action(inode, cred, blob, mask, func, &pcr);
>  	violation_check = ((func == FILE_CHECK || func == MMAP_CHECK) &&
>  			   (ima_policy_flag & IMA_MEASURE));
>  	if (!action && !violation_check)
> @@ -339,8 +339,7 @@ int ima_file_mmap(struct file *file, unsigned long prot)
>  
>  	if (file && (prot & PROT_EXEC)) {
>  		security_task_getsecid(current, &blob);
> -		/* scaffolding - until process_measurement changes */
> -		return process_measurement(file, current_cred(), blob.secid[0],
> +		return process_measurement(file, current_cred(), &blob,
>  					   NULL, 0, MAY_EXEC, MMAP_CHECK);
>  	}
>  
> @@ -366,16 +365,14 @@ int ima_bprm_check(struct linux_binprm *bprm)
>  	struct lsmblob blob;
>  
>  	security_task_getsecid(current, &blob);
> -	/* scaffolding until process_measurement changes */
> -	ret = process_measurement(bprm->file, current_cred(), blob.secid[0],
> -				  NULL, 0, MAY_EXEC, BPRM_CHECK);
> +	ret = process_measurement(bprm->file, current_cred(), &blob, NULL, 0,
> +				  MAY_EXEC, BPRM_CHECK);
>  	if (ret)
>  		return ret;
>  
>  	security_cred_getsecid(bprm->cred, &blob);
> -	/* scaffolding until process_measurement changes */
> -	return process_measurement(bprm->file, bprm->cred, blob.secid[0],
> -				   NULL, 0, MAY_EXEC, CREDS_CHECK);
> +	return process_measurement(bprm->file, bprm->cred, &blob, NULL, 0,
> +				   MAY_EXEC, CREDS_CHECK);
>  }
>  
>  /**
> @@ -393,8 +390,7 @@ int ima_file_check(struct file *file, int mask)
>  	struct lsmblob blob;
>  
>  	security_task_getsecid(current, &blob);
> -	/* scaffolding until process_measurement changes */
> -	return process_measurement(file, current_cred(), blob.secid[0], NULL, 0,
> +	return process_measurement(file, current_cred(), &blob, NULL, 0,
>  				   mask & (MAY_READ | MAY_WRITE | MAY_EXEC |
>  					   MAY_APPEND), FILE_CHECK);
>  }
> @@ -526,9 +522,8 @@ int ima_post_read_file(struct file *file, void *buf, loff_t size,
>  
>  	func = read_idmap[read_id] ?: FILE_CHECK;
>  	security_task_getsecid(current, &blob);
> -	/* scaffolding until process_measurement changes */
> -	return process_measurement(file, current_cred(), blob.secid[0], buf,
> -				   size, MAY_READ, func);
> +	return process_measurement(file, current_cred(), &blob, buf, size,
> +				   MAY_READ, func);
>  }
>  
>  /**
> diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
> index 92ee3d984c73..dbad256aa7b4 100644
> --- a/security/integrity/ima/ima_policy.c
> +++ b/security/integrity/ima/ima_policy.c
> @@ -286,7 +286,7 @@ static void ima_lsm_update_rules(void)
>   * Returns true on rule match, false on failure.
>   */
>  static bool ima_match_rules(struct ima_rule_entry *rule, struct inode *inode,
> -			    const struct cred *cred, u32 secid,
> +			    const struct cred *cred, struct lsmblob *blob,
>  			    enum ima_hooks func, int mask)
>  {
>  	int i;
> @@ -345,7 +345,6 @@ static bool ima_match_rules(struct ima_rule_entry *rule, struct inode *inode,
>  		case LSM_SUBJ_USER:
>  		case LSM_SUBJ_ROLE:
>  		case LSM_SUBJ_TYPE:
> -			lsmblob_init(&blob, secid);
>  			rc = security_filter_rule_match(&blob,
>  							rule->lsm[i].type,
>  							Audit_equal,
> @@ -394,7 +393,7 @@ static int get_subaction(struct ima_rule_entry *rule, enum ima_hooks func)
>   * @inode: pointer to an inode for which the policy decision is being made
>   * @cred: pointer to a credentials structure for which the policy decision is
>   *        being made
> - * @secid: LSM secid of the task to be validated
> + * @blob: LSM data of the task to be validated
>   * @func: IMA hook identifier
>   * @mask: requested action (MAY_READ | MAY_WRITE | MAY_APPEND | MAY_EXEC)
>   * @pcr: set the pcr to extend
> @@ -406,8 +405,9 @@ static int get_subaction(struct ima_rule_entry *rule, enum ima_hooks func)
>   * list when walking it.  Reads are many orders of magnitude more numerous
>   * than writes so ima_match_policy() is classical RCU candidate.
>   */
> -int ima_match_policy(struct inode *inode, const struct cred *cred, u32 secid,
> -		     enum ima_hooks func, int mask, int flags, int *pcr)
> +int ima_match_policy(struct inode *inode, const struct cred *cred,
> +		     struct lsmblob *blob, enum ima_hooks func, int mask,
> +		     int flags, int *pcr)
>  {
>  	struct ima_rule_entry *entry;
>  	int action = 0, actmask = flags | (flags << 1);
> @@ -418,7 +418,7 @@ int ima_match_policy(struct inode *inode, const struct cred *cred, u32 secid,
>  		if (!(entry->action & actmask))
>  			continue;
>  
> -		if (!ima_match_rules(entry, inode, cred, secid, func, mask))
> +		if (!ima_match_rules(entry, inode, cred, blob, func, mask))
>  			continue;
>  
>  		action |= entry->flags & IMA_ACTION_FLAGS;
> -- 
> 2.20.1
> 

-- 
Kees Cook
