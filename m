Return-Path: <SRS0=M/73=ZN=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 344D0C432C0
	for <selinux@archiver.kernel.org>; Thu, 21 Nov 2019 18:45:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F23DC206CB
	for <selinux@archiver.kernel.org>; Thu, 21 Nov 2019 18:45:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbfKUSpK (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 21 Nov 2019 13:45:10 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:59308 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726279AbfKUSpK (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 21 Nov 2019 13:45:10 -0500
Received: from static-50-53-33-191.bvtn.or.frontiernet.net ([50.53.33.191] helo=[192.168.192.153])
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <john.johansen@canonical.com>)
        id 1iXrRw-0003Ci-1H; Thu, 21 Nov 2019 18:45:04 +0000
Subject: Re: [PATCH v11 12/25] IMA: Change internal interfaces to use lsmblobs
To:     Casey Schaufler <casey@schaufler-ca.com>,
        casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     keescook@chromium.org, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
References: <20191113181925.2437-1-casey@schaufler-ca.com>
 <20191113181925.2437-13-casey@schaufler-ca.com>
From:   John Johansen <john.johansen@canonical.com>
Openpgp: preference=signencrypt
Autocrypt: addr=john.johansen@canonical.com; prefer-encrypt=mutual; keydata=
 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
Organization: Canonical
Message-ID: <eac3a3f6-48f7-b63c-fd31-acd06c25d94d@canonical.com>
Date:   Thu, 21 Nov 2019 10:45:01 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191113181925.2437-13-casey@schaufler-ca.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 11/13/19 10:19 AM, Casey Schaufler wrote:
> The IMA interfaces ima_get_action() and ima_match_policy()
> call LSM functions that use lsmblobs. Change the IMA functions
> to pass the lsmblob to be compatible with the LSM functions.
> 
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Reviewed-by: John Johansen <john.johansen@canonical.com>
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> cc: linux-integrity@vger.kernel.org

Acked-by: John Johansen <john.johansen@canonical.com>


> ---
>  security/integrity/ima/ima.h          | 11 ++++----
>  security/integrity/ima/ima_api.c      | 10 +++----
>  security/integrity/ima/ima_appraise.c |  4 +--
>  security/integrity/ima/ima_main.c     | 38 +++++++++++----------------
>  security/integrity/ima/ima_policy.c   | 12 ++++-----
>  5 files changed, 34 insertions(+), 41 deletions(-)
> 
> diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
> index 5bcd6011ef8c..4226622f50b1 100644
> --- a/security/integrity/ima/ima.h
> +++ b/security/integrity/ima/ima.h
> @@ -205,9 +205,9 @@ extern const char *const func_tokens[];
>  struct modsig;
>  
>  /* LIM API function definitions */
> -int ima_get_action(struct inode *inode, const struct cred *cred, u32 secid,
> -		   int mask, enum ima_hooks func, int *pcr,
> -		   struct ima_template_desc **template_desc);
> +int ima_get_action(struct inode *inode, const struct cred *cred,
> +		   struct lsmblob *blob, int mask, enum ima_hooks func,
> +		   int *pcr, struct ima_template_desc **template_desc);
>  int ima_must_measure(struct inode *inode, int mask, enum ima_hooks func);
>  int ima_collect_measurement(struct integrity_iint_cache *iint,
>  			    struct file *file, void *buf, loff_t size,
> @@ -229,8 +229,9 @@ void ima_free_template_entry(struct ima_template_entry *entry);
>  const char *ima_d_path(const struct path *path, char **pathbuf, char *filename);
>  
>  /* IMA policy related functions */
> -int ima_match_policy(struct inode *inode, const struct cred *cred, u32 secid,
> -		     enum ima_hooks func, int mask, int flags, int *pcr,
> +int ima_match_policy(struct inode *inode, const struct cred *cred,
> +		     struct lsmblob *blob, enum ima_hooks func, int mask,
> +		     int flags, int *pcr,
>  		     struct ima_template_desc **template_desc);
>  void ima_init_policy(void);
>  void ima_update_policy(void);
> diff --git a/security/integrity/ima/ima_api.c b/security/integrity/ima/ima_api.c
> index 610759fe63b8..1ab769fa7df6 100644
> --- a/security/integrity/ima/ima_api.c
> +++ b/security/integrity/ima/ima_api.c
> @@ -163,7 +163,7 @@ void ima_add_violation(struct file *file, const unsigned char *filename,
>   * ima_get_action - appraise & measure decision based on policy.
>   * @inode: pointer to inode to measure
>   * @cred: pointer to credentials structure to validate
> - * @secid: secid of the task being validated
> + * @blob: LSM data of the task being validated
>   * @mask: contains the permission mask (MAY_READ, MAY_WRITE, MAY_EXEC,
>   *        MAY_APPEND)
>   * @func: caller identifier
> @@ -181,15 +181,15 @@ void ima_add_violation(struct file *file, const unsigned char *filename,
>   * Returns IMA_MEASURE, IMA_APPRAISE mask.
>   *
>   */
> -int ima_get_action(struct inode *inode, const struct cred *cred, u32 secid,
> -		   int mask, enum ima_hooks func, int *pcr,
> -		   struct ima_template_desc **template_desc)
> +int ima_get_action(struct inode *inode, const struct cred *cred,
> +		   struct lsmblob *blob, int mask, enum ima_hooks func,
> +		   int *pcr, struct ima_template_desc **template_desc)
>  {
>  	int flags = IMA_MEASURE | IMA_AUDIT | IMA_APPRAISE | IMA_HASH;
>  
>  	flags &= ima_policy_flag;
>  
> -	return ima_match_policy(inode, cred, secid, func, mask, flags, pcr,
> +	return ima_match_policy(inode, cred, blob, func, mask, flags, pcr,
>  				template_desc);
>  }
>  
> diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
> index 7288a574459b..bc04c6f4bb20 100644
> --- a/security/integrity/ima/ima_appraise.c
> +++ b/security/integrity/ima/ima_appraise.c
> @@ -47,15 +47,13 @@ bool is_ima_appraise_enabled(void)
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
>  				IMA_APPRAISE | IMA_HASH, NULL, NULL);
>  }
>  
> diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
> index 305a00a6b087..a8e7e11b1c84 100644
> --- a/security/integrity/ima/ima_main.c
> +++ b/security/integrity/ima/ima_main.c
> @@ -190,8 +190,8 @@ void ima_file_free(struct file *file)
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
> @@ -214,7 +214,7 @@ static int process_measurement(struct file *file, const struct cred *cred,
>  	 * bitmask based on the appraise/audit/measurement policy.
>  	 * Included is the appraise submask.
>  	 */
> -	action = ima_get_action(inode, cred, secid, mask, func, &pcr,
> +	action = ima_get_action(inode, cred, blob, mask, func, &pcr,
>  				&template_desc);
>  	violation_check = ((func == FILE_CHECK || func == MMAP_CHECK) &&
>  			   (ima_policy_flag & IMA_MEASURE));
> @@ -384,8 +384,7 @@ int ima_file_mmap(struct file *file, unsigned long prot)
>  
>  	if (file && (prot & PROT_EXEC)) {
>  		security_task_getsecid(current, &blob);
> -		/* scaffolding - until process_measurement changes */
> -		return process_measurement(file, current_cred(), blob.secid[0],
> +		return process_measurement(file, current_cred(), &blob,
>  					   NULL, 0, MAY_EXEC, MMAP_CHECK);
>  	}
>  
> @@ -411,16 +410,14 @@ int ima_bprm_check(struct linux_binprm *bprm)
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
> @@ -438,8 +435,7 @@ int ima_file_check(struct file *file, int mask)
>  	struct lsmblob blob;
>  
>  	security_task_getsecid(current, &blob);
> -	/* scaffolding until process_measurement changes */
> -	return process_measurement(file, current_cred(), blob.secid[0], NULL, 0,
> +	return process_measurement(file, current_cred(), &blob, NULL, 0,
>  				   mask & (MAY_READ | MAY_WRITE | MAY_EXEC |
>  					   MAY_APPEND), FILE_CHECK);
>  }
> @@ -571,9 +567,8 @@ int ima_post_read_file(struct file *file, void *buf, loff_t size,
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
> @@ -632,13 +627,14 @@ int ima_load_data(enum kernel_load_data_id id)
>   * @size: size of buffer(in bytes).
>   * @eventname: event name to be used for the buffer entry.
>   * @cred: a pointer to a credentials structure for user validation.
> - * @secid: the secid of the task to be validated.
> + * @blob: the LSM data of the task to be validated.
>   *
>   * Based on policy, the buffer is measured into the ima log.
>   */
>  static void process_buffer_measurement(const void *buf, int size,
>  				       const char *eventname,
> -				       const struct cred *cred, u32 secid)
> +				       const struct cred *cred,
> +				       struct lsmblob *blob)
>  {
>  	int ret = 0;
>  	struct ima_template_entry *entry = NULL;
> @@ -656,7 +652,7 @@ static void process_buffer_measurement(const void *buf, int size,
>  	int pcr = CONFIG_IMA_MEASURE_PCR_IDX;
>  	int action = 0;
>  
> -	action = ima_get_action(NULL, cred, secid, 0, KEXEC_CMDLINE, &pcr,
> +	action = ima_get_action(NULL, cred, blob, 0, KEXEC_CMDLINE, &pcr,
>  				&template_desc);
>  	if (!(action & IMA_MEASURE))
>  		return;
> @@ -691,14 +687,12 @@ static void process_buffer_measurement(const void *buf, int size,
>   */
>  void ima_kexec_cmdline(const void *buf, int size)
>  {
> -	u32 secid;
>  	struct lsmblob blob;
>  
>  	if (buf && size != 0) {
>  		security_task_getsecid(current, &blob);
> -		/* scaffolding */
>  		process_buffer_measurement(buf, size, "kexec-cmdline",
> -					   current_cred(), blob.secid[0]);
> +					   current_cred(), &blob);
>  	}
>  }
>  
> diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
> index c5417045e165..e863c0d0f9b7 100644
> --- a/security/integrity/ima/ima_policy.c
> +++ b/security/integrity/ima/ima_policy.c
> @@ -368,7 +368,7 @@ int ima_lsm_policy_change(struct notifier_block *nb, unsigned long event,
>   * Returns true on rule match, false on failure.
>   */
>  static bool ima_match_rules(struct ima_rule_entry *rule, struct inode *inode,
> -			    const struct cred *cred, u32 secid,
> +			    const struct cred *cred, struct lsmblob *blob,
>  			    enum ima_hooks func, int mask)
>  {
>  	int i;
> @@ -431,7 +431,6 @@ static bool ima_match_rules(struct ima_rule_entry *rule, struct inode *inode,
>  		case LSM_SUBJ_USER:
>  		case LSM_SUBJ_ROLE:
>  		case LSM_SUBJ_TYPE:
> -			lsmblob_init(&blob, secid);
>  			rc = security_filter_rule_match(&blob,
>  							rule->lsm[i].type,
>  							Audit_equal,
> @@ -475,7 +474,7 @@ static int get_subaction(struct ima_rule_entry *rule, enum ima_hooks func)
>   * @inode: pointer to an inode for which the policy decision is being made
>   * @cred: pointer to a credentials structure for which the policy decision is
>   *        being made
> - * @secid: LSM secid of the task to be validated
> + * @blob: LSM data of the task to be validated
>   * @func: IMA hook identifier
>   * @mask: requested action (MAY_READ | MAY_WRITE | MAY_APPEND | MAY_EXEC)
>   * @pcr: set the pcr to extend
> @@ -488,8 +487,9 @@ static int get_subaction(struct ima_rule_entry *rule, enum ima_hooks func)
>   * list when walking it.  Reads are many orders of magnitude more numerous
>   * than writes so ima_match_policy() is classical RCU candidate.
>   */
> -int ima_match_policy(struct inode *inode, const struct cred *cred, u32 secid,
> -		     enum ima_hooks func, int mask, int flags, int *pcr,
> +int ima_match_policy(struct inode *inode, const struct cred *cred,
> +		     struct lsmblob *blob, enum ima_hooks func, int mask,
> +		     int flags, int *pcr,
>  		     struct ima_template_desc **template_desc)
>  {
>  	struct ima_rule_entry *entry;
> @@ -504,7 +504,7 @@ int ima_match_policy(struct inode *inode, const struct cred *cred, u32 secid,
>  		if (!(entry->action & actmask))
>  			continue;
>  
> -		if (!ima_match_rules(entry, inode, cred, secid, func, mask))
> +		if (!ima_match_rules(entry, inode, cred, blob, func, mask))
>  			continue;
>  
>  		action |= entry->flags & IMA_ACTION_FLAGS;
> 

