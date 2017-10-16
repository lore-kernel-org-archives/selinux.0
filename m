Sender: Mikhail Kurinnoi <viewizard@gmail.com>
Date: Tue, 17 Oct 2017 00:03:03 +0300
From: Mikhail Kurinnoi <viewizard@viewizard.com>
To: Matthew Garrett <mjg59@google.com>
Cc: Paul Moore <paul@paul-moore.com>, Stephen Smalley <sds@tycho.nsa.gov>,
 Eric Paris <eparis@parisplace.org>, selinux@tycho.nsa.gov, Casey Schaufler
 <casey@schaufler-ca.com>, linux-security-module@vger.kernel.org, Mimi Zohar
 <zohar@linux.vnet.ibm.com>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
 linux-integrity@vger.kernel.org
Message-ID: <20171017000303.46e56b42@totoro>
In-Reply-To: <20171016203709.11199-2-mjg59@google.com>
References: <20171016203709.11199-1-mjg59@google.com>
 <20171016203709.11199-2-mjg59@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Subject: Re: [PATCH 2/2] IMA: Support using new creds in appraisal
 policy
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

В Mon, 16 Oct 2017 13:37:09 -0700
Matthew Garrett <mjg59@google.com> пишет:

> The existing BPRM_CHECK functionality in IMA validates against the
> credentials of the existing process, not any new credentials that the
> child process may transition to. Add an additional CREDS_CHECK target
> and refactor IMA to pass the appropriate creds structure. In
> ima_bprm_check(), check with both the existing process credentials and
> the credentials that will be committed when the new process is
> started.
> 
> Signed-off-by: Matthew Garrett <mjg59@google.com>
> Cc: Paul Moore <paul@paul-moore.com>
> Cc: Stephen Smalley <sds@tycho.nsa.gov>
> Cc: Eric Paris <eparis@parisplace.org>
> Cc: selinux@tycho.nsa.gov
> Cc: Casey Schaufler <casey@schaufler-ca.com>
> Cc: linux-security-module@vger.kernel.org
> Cc: Mimi Zohar <zohar@linux.vnet.ibm.com>
> Cc: Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
> Cc: linux-integrity@vger.kernel.org
> ---
>  Documentation/ABI/testing/ima_policy  |  2 +-
>  security/integrity/iint.c             |  1 +
>  security/integrity/ima/ima.h          |  7 ++++---
>  security/integrity/ima/ima_api.c      |  8 +++++---
>  security/integrity/ima/ima_appraise.c | 10 +++++++++-
>  security/integrity/ima/ima_main.c     | 26 +++++++++++++++++---------
>  security/integrity/ima/ima_policy.c   | 19 ++++++++++++-------
>  security/integrity/integrity.h        |  9 +++++++--
>  8 files changed, 56 insertions(+), 26 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/ima_policy
> b/Documentation/ABI/testing/ima_policy index
> e76432b9954d..5dc9eed035fb 100644 ---
> a/Documentation/ABI/testing/ima_policy +++
> b/Documentation/ABI/testing/ima_policy @@ -25,7 +25,7 @@ Description:
>  				 [obj_user=] [obj_role=] [obj_type=]]
>  			option:	[[appraise_type=]]
> [permit_directio] 
> -		base: 	func:=
> [BPRM_CHECK][MMAP_CHECK][FILE_CHECK][MODULE_CHECK]
> +		base: 	func:=
> [BPRM_CHECK][MMAP_CHECK][CREDS_CHECK][FILE_CHECK][MODULE_CHECK]
> [FIRMWARE_CHECK] [KEXEC_KERNEL_CHECK] [KEXEC_INITRAMFS_CHECK]
>  			mask:= [[^]MAY_READ] [[^]MAY_WRITE]
> [[^]MAY_APPEND] diff --git a/security/integrity/iint.c
> b/security/integrity/iint.c index 6fc888ca468e..ad30094a58b4 100644
> --- a/security/integrity/iint.c
> +++ b/security/integrity/iint.c
> @@ -78,6 +78,7 @@ static void iint_free(struct integrity_iint_cache
> *iint) iint->ima_mmap_status = INTEGRITY_UNKNOWN;
>  	iint->ima_bprm_status = INTEGRITY_UNKNOWN;
>  	iint->ima_read_status = INTEGRITY_UNKNOWN;
> +	iint->ima_creds_status = INTEGRITY_UNKNOWN;
>  	iint->evm_status = INTEGRITY_UNKNOWN;
>  	iint->measured_pcrs = 0;
>  	kmem_cache_free(iint_cache, iint);
> diff --git a/security/integrity/ima/ima.h
> b/security/integrity/ima/ima.h index d52b487ad259..0703a96072b5 100644
> --- a/security/integrity/ima/ima.h
> +++ b/security/integrity/ima/ima.h
> @@ -177,6 +177,7 @@ static inline unsigned long ima_hash_key(u8
> *digest) hook(FILE_CHECK)		\
>  	hook(MMAP_CHECK)		\
>  	hook(BPRM_CHECK)		\
> +	hook(CREDS_CHECK)		\
>  	hook(POST_SETATTR)		\
>  	hook(MODULE_CHECK)		\
>  	hook(FIRMWARE_CHECK)		\
> @@ -191,7 +192,7 @@ enum ima_hooks {
>  };
>  
>  /* LIM API function definitions */
> -int ima_get_action(struct inode *inode, int mask,
> +int ima_get_action(struct inode *inode, const struct cred *cred, int
> mask, enum ima_hooks func, int *pcr);
>  int ima_must_measure(struct inode *inode, int mask, enum ima_hooks
> func); int ima_collect_measurement(struct integrity_iint_cache *iint,
> @@ -212,8 +213,8 @@ void ima_free_template_entry(struct
> ima_template_entry *entry); const char *ima_d_path(const struct path
> *path, char **pathbuf, char *filename); 
>  /* IMA policy related functions */
> -int ima_match_policy(struct inode *inode, enum ima_hooks func, int
> mask,
> -		     int flags, int *pcr);
> +int ima_match_policy(struct inode *inode, const struct cred *cred,
> +		     enum ima_hooks func, int mask, int flags, int
> *pcr); void ima_init_policy(void);
>  void ima_update_policy(void);
>  void ima_update_policy_flag(void);
> diff --git a/security/integrity/ima/ima_api.c
> b/security/integrity/ima/ima_api.c index c2edba8de35e..ff33b7e65a07
> 100644 --- a/security/integrity/ima/ima_api.c
> +++ b/security/integrity/ima/ima_api.c
> @@ -157,6 +157,7 @@ void ima_add_violation(struct file *file, const
> unsigned char *filename, /**
>   * ima_get_action - appraise & measure decision based on policy.
>   * @inode: pointer to inode to measure
> + * @cred: pointer to credentials structure to validate
>   * @mask: contains the permission mask (MAY_READ, MAY_WRITE,
> MAY_EXEC,
>   *        MAY_APPEND)
>   * @func: caller identifier
> @@ -165,20 +166,21 @@ void ima_add_violation(struct file *file, const
> unsigned char *filename,
>   * The policy is defined in terms of keypairs:
>   *		subj=, obj=, type=, func=, mask=, fsmagic=
>   *	subj,obj, and type: are LSM specific.
> - *	func: FILE_CHECK | BPRM_CHECK | MMAP_CHECK | MODULE_CHECK
> + *	func: FILE_CHECK | BPRM_CHECK | CREDS_CHECK | MMAP_CHECK |
> MODULE_CHECK
>   *	mask: contains the permission mask
>   *	fsmagic: hex value
>   *
>   * Returns IMA_MEASURE, IMA_APPRAISE mask.
>   *
>   */
> -int ima_get_action(struct inode *inode, int mask, enum ima_hooks
> func, int *pcr) +int ima_get_action(struct inode *inode, const struct
> cred *cred, int mask,
> +		   enum ima_hooks func, int *pcr)
>  {
>  	int flags = IMA_MEASURE | IMA_AUDIT | IMA_APPRAISE;
>  
>  	flags &= ima_policy_flag;
>  
> -	return ima_match_policy(inode, func, mask, flags, pcr);
> +	return ima_match_policy(inode, cred, func, mask, flags, pcr);
>  }
>  
>  /*
> diff --git a/security/integrity/ima/ima_appraise.c
> b/security/integrity/ima/ima_appraise.c index
> 809ba70fbbbf..137b8d1708c6 100644 ---
> a/security/integrity/ima/ima_appraise.c +++
> b/security/integrity/ima/ima_appraise.c @@ -53,7 +53,8 @@ int
> ima_must_appraise(struct inode *inode, int mask, enum ima_hooks func)
> if (!ima_appraise) return 0;
>  
> -	return ima_match_policy(inode, func, mask, IMA_APPRAISE,
> NULL);
> +	return ima_match_policy(inode, current_cred(), func, mask,
> +				IMA_APPRAISE, NULL);
>  }
>  
>  static int ima_fix_xattr(struct dentry *dentry,
> @@ -86,6 +87,8 @@ enum integrity_status ima_get_cache_status(struct
> integrity_iint_cache *iint, return iint->ima_mmap_status;
>  	case BPRM_CHECK:
>  		return iint->ima_bprm_status;
> +	case CREDS_CHECK:
> +		return iint->ima_creds_status;
>  	case FILE_CHECK:
>  	case POST_SETATTR:
>  		return iint->ima_file_status;
> @@ -106,6 +109,8 @@ static void ima_set_cache_status(struct
> integrity_iint_cache *iint, case BPRM_CHECK:
>  		iint->ima_bprm_status = status;
>  		break;
> +	case CREDS_CHECK:
> +		iint->ima_creds_status = status;
>  	case FILE_CHECK:
>  	case POST_SETATTR:
>  		iint->ima_file_status = status;
> @@ -127,6 +132,9 @@ static void ima_cache_flags(struct
> integrity_iint_cache *iint, case BPRM_CHECK:
>  		iint->flags |= (IMA_BPRM_APPRAISED | IMA_APPRAISED);
>  		break;
> +	case CREDS_CHECK:
> +		iint->flags |= (IMA_CREDS_APPRAISED | IMA_APPRAISED);
> +		break;
>  	case FILE_CHECK:
>  	case POST_SETATTR:
>  		iint->flags |= (IMA_FILE_APPRAISED | IMA_APPRAISED);
> diff --git a/security/integrity/ima/ima_main.c
> b/security/integrity/ima/ima_main.c index 2aebb7984437..f41aa427792b
> 100644 --- a/security/integrity/ima/ima_main.c
> +++ b/security/integrity/ima/ima_main.c
> @@ -155,8 +155,9 @@ void ima_file_free(struct file *file)
>  	ima_check_last_writer(iint, inode, file);
>  }
>  
> -static int process_measurement(struct file *file, char *buf, loff_t
> size,
> -			       int mask, enum ima_hooks func, int
> opened) +static int process_measurement(struct file *file, const
> struct cred *cred,
> +			       char *buf, loff_t size, int mask,
> +			       enum ima_hooks func, int opened)
>  {
>  	struct inode *inode = file_inode(file);
>  	struct integrity_iint_cache *iint = NULL;
> @@ -178,7 +179,7 @@ static int process_measurement(struct file *file,
> char *buf, loff_t size,
>  	 * bitmask based on the appraise/audit/measurement policy.
>  	 * Included is the appraise submask.
>  	 */
> -	action = ima_get_action(inode, mask, func, &pcr);
> +	action = ima_get_action(inode, cred, mask, func, &pcr);
>  	violation_check = ((func == FILE_CHECK || func ==
> MMAP_CHECK) && (ima_policy_flag & IMA_MEASURE));
>  	if (!action && !violation_check)
> @@ -282,8 +283,8 @@ static int process_measurement(struct file *file,
> char *buf, loff_t size, int ima_file_mmap(struct file *file, unsigned
> long prot) {
>  	if (file && (prot & PROT_EXEC))
> -		return process_measurement(file, NULL, 0, MAY_EXEC,
> -					   MMAP_CHECK, 0);
> +		return process_measurement(file, current_cred(),
> NULL, 0,
> +					   MAY_EXEC, MMAP_CHECK, 0);
>  	return 0;
>  }
>  
> @@ -302,8 +303,14 @@ int ima_file_mmap(struct file *file, unsigned
> long prot) */
>  int ima_bprm_check(struct linux_binprm *bprm)
>  {
> -	return process_measurement(bprm->file, NULL, 0, MAY_EXEC,
> -				   BPRM_CHECK, 0);
> +	int ret;
> +
> +	ret = process_measurement(bprm->file, current_cred(), NULL,
> 0,
> +				  MAY_EXEC, BPRM_CHECK, 0);
> +	if (ret)
> +		return ret;
> +	return process_measurement(bprm->file, bprm->cred, NULL, 0,
> +				   MAY_EXEC, CREDS_CHECK, 0);
>  }
>  
>  /**
> @@ -318,7 +325,7 @@ int ima_bprm_check(struct linux_binprm *bprm)
>   */
>  int ima_file_check(struct file *file, int mask, int opened)
>  {
> -	return process_measurement(file, NULL, 0,
> +	return process_measurement(file, current_cred(), NULL, 0,
>  				   mask & (MAY_READ | MAY_WRITE |
> MAY_EXEC | MAY_APPEND), FILE_CHECK, opened);
>  }
> @@ -413,7 +420,8 @@ int ima_post_read_file(struct file *file, void
> *buf, loff_t size, }
>  
>  	func = read_idmap[read_id] ?: FILE_CHECK;
> -	return process_measurement(file, buf, size, MAY_READ, func,
> 0);
> +	return process_measurement(file, current_cred(), buf, size,
> MAY_READ,
> +				   func, 0);
>  }
>  
>  static int __init init_ima(void)
> diff --git a/security/integrity/ima/ima_policy.c
> b/security/integrity/ima/ima_policy.c index
> 95209a5f8595..c9d5735711eb 100644 ---
> a/security/integrity/ima/ima_policy.c +++
> b/security/integrity/ima/ima_policy.c @@ -247,10 +247,9 @@ static
> void ima_lsm_update_rules(void)
>   * Returns true on rule match, false on failure.
>   */
>  static bool ima_match_rules(struct ima_rule_entry *rule, struct
> inode *inode,
> -			    enum ima_hooks func, int mask)
> +			    const struct cred *cred, enum ima_hooks
> func,
> +			    int mask)
>  {
> -	struct task_struct *tsk = current;
> -	const struct cred *cred = current_cred();
>  	int i;
>  
>  	if ((rule->flags & IMA_FUNC) &&
> @@ -305,7 +304,7 @@ static bool ima_match_rules(struct ima_rule_entry
> *rule, struct inode *inode, case LSM_SUBJ_USER:
>  		case LSM_SUBJ_ROLE:
>  		case LSM_SUBJ_TYPE:
> -			security_task_getsecid(tsk, &sid);
> +			security_cred_getsecid(cred, &sid);
>  			rc = security_filter_rule_match(sid,
>  							rule->lsm[i].type,
>  							Audit_equal,
> @@ -339,6 +338,8 @@ static int get_subaction(struct ima_rule_entry
> *rule, enum ima_hooks func) return IMA_MMAP_APPRAISE;
>  	case BPRM_CHECK:
>  		return IMA_BPRM_APPRAISE;
> +	case CREDS_CHECK:
> +		return IMA_CREDS_APPRAISE;
>  	case FILE_CHECK:
>  	case POST_SETATTR:
>  		return IMA_FILE_APPRAISE;
> @@ -351,6 +352,8 @@ static int get_subaction(struct ima_rule_entry
> *rule, enum ima_hooks func) /**
>   * ima_match_policy - decision based on LSM and other conditions
>   * @inode: pointer to an inode for which the policy decision is
> being made
> + * @cred: pointer to a credentials structure for which the policy
> decision is
> + *        being made
>   * @func: IMA hook identifier
>   * @mask: requested action (MAY_READ | MAY_WRITE | MAY_APPEND |
> MAY_EXEC)
>   * @pcr: set the pcr to extend
> @@ -362,8 +365,8 @@ static int get_subaction(struct ima_rule_entry
> *rule, enum ima_hooks func)
>   * list when walking it.  Reads are many orders of magnitude more
> numerous
>   * than writes so ima_match_policy() is classical RCU candidate.
>   */
> -int ima_match_policy(struct inode *inode, enum ima_hooks func, int
> mask,
> -		     int flags, int *pcr)
> +int ima_match_policy(struct inode *inode, const struct cred *cred,
> +		     enum ima_hooks func, int mask, int flags, int
> *pcr) {
>  	struct ima_rule_entry *entry;
>  	int action = 0, actmask = flags | (flags << 1);
> @@ -374,7 +377,7 @@ int ima_match_policy(struct inode *inode, enum
> ima_hooks func, int mask, if (!(entry->action & actmask))
>  			continue;
>  
> -		if (!ima_match_rules(entry, inode, func, mask))
> +		if (!ima_match_rules(entry, inode, cred, func, mask))
>  			continue;
>  
>  		action |= entry->flags & IMA_ACTION_FLAGS;
> @@ -691,6 +694,8 @@ static int ima_parse_rule(char *rule, struct
> ima_rule_entry *entry) entry->func = MMAP_CHECK;
>  			else if (strcmp(args[0].from, "BPRM_CHECK")
> == 0) entry->func = BPRM_CHECK;
> +			else if (strcmp(args[0].from, "CREDS_CHECK")
> == 0)
> +				entry->func = CREDS_CHECK;
>  			else if (strcmp(args[0].from,
> "KEXEC_KERNEL_CHECK") == 0)
>  				entry->func = KEXEC_KERNEL_CHECK;
> diff --git a/security/integrity/integrity.h
> b/security/integrity/integrity.h index 0a721c110e92..8d532c3557b5
> 100644 --- a/security/integrity/integrity.h
> +++ b/security/integrity/integrity.h
> @@ -48,10 +48,14 @@
>  #define IMA_BPRM_APPRAISED	0x00002000
>  #define IMA_READ_APPRAISE	0x00004000
>  #define IMA_READ_APPRAISED	0x00008000
> +#define IMA_CREDS_APPRAISE	0x00004000
> +#define IMA_CREDS_APPRAISED	0x00008000

Is this correct, that the IMA_CREDS_APPRAISE and IMA_CREDS_APPRAISED
same as IMA_READ_APPRAISE and IMA_READ_APPRAISED?




>  #define IMA_APPRAISE_SUBMASK	(IMA_FILE_APPRAISE |
> IMA_MMAP_APPRAISE | \
> -				 IMA_BPRM_APPRAISE |
> IMA_READ_APPRAISE)
> +				 IMA_BPRM_APPRAISE |
> IMA_READ_APPRAISE | \
> +				 IMA_CREDS_APPRAISE)
>  #define IMA_APPRAISED_SUBMASK	(IMA_FILE_APPRAISED |
> IMA_MMAP_APPRAISED | \
> -				 IMA_BPRM_APPRAISED |
> IMA_READ_APPRAISED)
> +				 IMA_BPRM_APPRAISED |
> IMA_READ_APPRAISED | \
> +				 IMA_CREDS_APPRAISED)
>  
>  enum evm_ima_xattr_type {
>  	IMA_XATTR_DIGEST = 0x01,
> @@ -109,6 +113,7 @@ struct integrity_iint_cache {
>  	enum integrity_status ima_mmap_status:4;
>  	enum integrity_status ima_bprm_status:4;
>  	enum integrity_status ima_read_status:4;
> +	enum integrity_status ima_creds_status:4;
>  	enum integrity_status evm_status:4;
>  	struct ima_digest_data *ima_hash;
>  };



-- 
Best regards,
Mikhail Kurinnoi
