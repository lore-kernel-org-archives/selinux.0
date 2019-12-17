Return-Path: <SRS0=4tRG=2H=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BECC2C43603
	for <selinux@archiver.kernel.org>; Tue, 17 Dec 2019 18:25:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C8292072D
	for <selinux@archiver.kernel.org>; Tue, 17 Dec 2019 18:25:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="UtrJTlHk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728117AbfLQSZt (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 17 Dec 2019 13:25:49 -0500
Received: from UCOL19PA39.eemsg.mail.mil ([214.24.24.199]:41273 "EHLO
        UCOL19PA39.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726646AbfLQSZt (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 17 Dec 2019 13:25:49 -0500
X-EEMSG-check-017: 62850077|UCOL19PA39_ESA_OUT06.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.69,326,1571702400"; 
   d="scan'208";a="62850077"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by UCOL19PA39.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 17 Dec 2019 18:25:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1576607146; x=1608143146;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=PIJ7U0zjmkoSqd19V+fnaDkdEoIgr87xGGgKEdAFcqU=;
  b=UtrJTlHk6YACptsp2ZUruh2edIx0/rIvTQJ4SWJBZxyTh/Q/XcCdARdH
   99rvFOYs7l2Ienjz/NaEaIkxIK54wVoKcNs3id4etORDRuWj9V7o9z/ji
   CuFCGnBcRW5kZShwbVB+mq8CQMUy1lVh7Ehz39+E38gof9Ozrzf+9ZSOt
   4c+S4dVzy47qfUyldFPJIh2urNTKgnq7HJtmOLsGI/VSrid+4vBR8IIDd
   +H6WeQc5AWLzm6PSkPMiM9keA1Q2l02Fc428xixAA9aFNkIQW7vjSrIN4
   1tdLJ1YYUY5oDjOYJoscHMiHMOeKaB7r7mnaF1J/A1jAoBO2D1JOSnbtH
   w==;
X-IronPort-AV: E=Sophos;i="5.69,326,1571702400"; 
   d="scan'208";a="31199965"
IronPort-PHdr: =?us-ascii?q?9a23=3AyNjD0x/6ysl49v9uRHKM819IXTAuvvDOBiVQ1K?=
 =?us-ascii?q?B+1+0SIJqq85mqBkHD//Il1AaPAdyAragc1KGP6viocFdDyK7JiGoFfp1IWk?=
 =?us-ascii?q?1NouQttCtkPvS4D1bmJuXhdS0wEZcKflZk+3amLRodQ56mNBXdrXKo8DEdBA?=
 =?us-ascii?q?j0OxZrKeTpAI7SiNm82/yv95HJbAhEmTSwbalsIBmqrwjdudQajZZ+Jq0s1h?=
 =?us-ascii?q?bHv3xEdvhMy2h1P1yThRH85smx/J5n7Stdvu8q+tBDX6vnYak2VKRUAzs6PW?=
 =?us-ascii?q?874s3rrgTDQhCU5nQASGUWkwFHDBbD4RrnQ5r+qCr6tu562CmHIc37SK0/VD?=
 =?us-ascii?q?q+46t3ThLjlTwKPCAl/m7JlsNwjbpboBO/qBx5347Ue5yeOP5ncq/AYd8WWW?=
 =?us-ascii?q?9NU8BfWCxbBoO3cpUBAewPM+1Fq4XxvkUCoB+7CQSqGejhyCJHhmXu0KMnze?=
 =?us-ascii?q?ohHwHI0g8uEd0Av3vbrsn6OqgJXOCpzqTF1ynPY+9Y1Dr/7oXDbxAvoeuLXb?=
 =?us-ascii?q?J1acff1FUvGB3djlWQt4PlOS6e2PkIs2eB6+pgUfygim46oAx2uTig29wsh5?=
 =?us-ascii?q?LVhoMV1l/E9SJ5zJwzJd2jUkF3e9GkEJxOtyyDMYZ9X8AsQ3lwtSonxbALto?=
 =?us-ascii?q?S3cSgXxJg92RLSZOKLf5KV7h/lSe2fOy13hGh/d7K6nxuy9E+gxfDiWcSsy1?=
 =?us-ascii?q?ZKqzZFksHLtnAQyxzf8siHReV5/kemwTuPyxrc6vtFIUApjqrXMZ8hwrg+lp?=
 =?us-ascii?q?oUqkTMADP5lF/qjK6Wakok+u+o5/7hYrr6vZ+TK5V4igT/MqQqgsC/AOI4PR?=
 =?us-ascii?q?YSX2WD5Oix27Lu8Vf5TblXlPE6jKbUvI7AKcgGvqK5BhVa0ocn6xaxFTem19?=
 =?us-ascii?q?EYkGEcLF1YYxKKlJTpOlHSL/D4CvezmVKskCxxyPzcMb3hBYvNImDZkLj9Zb?=
 =?us-ascii?q?Z991JcyA0rwN9D/Z1UEa8OIfLoV0/qqNPYDgU2MxG6w+bjFtp9zJoSVn6VDa?=
 =?us-ascii?q?ODLKzStlqI7Po1I+aQfI8VpCr9K/896vHyl3A5gkESfKmz0ZsMdH+4Hu5pI1?=
 =?us-ascii?q?iXYXronNgBC3wHvgs4TOz2llKCVSRfaGq1X6I5/js7Ep6pDZ/fRoCxh7yMxC?=
 =?us-ascii?q?W7HphRZmBcEFCMEGzoep6CW/gWbSKdPM5hniYDVbi7RI8rzQuuuxPiy7p7Mu?=
 =?us-ascii?q?rU/TUVtZbi1Nhz+u3Smgg+9SdqAMuBzmGNVWB0nn8IRjMv2aB/plFyykqH0a?=
 =?us-ascii?q?dmmPFYC9NT6O1TUgsgNp7T0fZ6C9bsVQLFZNuJT0ymQtq+CzErUt0x28MOY1?=
 =?us-ascii?q?p6G9i6lRDMwS6qA74Tl7yWC5056bzc33fvKMZn0XrG17cuj0MgQsRRMW2qnK?=
 =?us-ascii?q?l/9xLcB4TRiUWWi76qdbgA3C7K7GqDznSBs19DUAFsVqXFWnMfa1DKotT5/E?=
 =?us-ascii?q?PCSLquCbU6MgtE08KCLbFKatLxh1VcWPjjIMjeY362m2qoBxaIwbOMbIzwd2?=
 =?us-ascii?q?Uf2yXdCFILkwYI/XmYMwgzHTuurHjYDDxpE1LvYl/j/vN6qH+hUkA0yASKZV?=
 =?us-ascii?q?V717Wp4h4VmeCcS/QL07IcpighrTp0HEu839LQEtaApBRufL9aYdwj5FdKzm?=
 =?us-ascii?q?PZuxV5PpynMaBtmEQScx9tsEPtyhV3EJ9PndIsrHw01gZyK7qY2ktbdzyExZ?=
 =?us-ascii?q?DwJqHXKm7q8RC3caHWx1Xe3c2O+qgV9fQ4r0zvvASuFkol6XVozcNZ3Geb5p?=
 =?us-ascii?q?XPX0IuVsfaW1065lBBrLHTfyc56pmcgXZlKqSlmiTJ29s0Cu8o0FOrdpFUN6?=
 =?us-ascii?q?bSUEf5GtYXFo61I+wjhlatYwgsPeZO+apyNMSjM7OE3amxJud7tDSviGlGpo?=
 =?us-ascii?q?dn3QbE8yt6V/6NxJsO3uuZwhrCUjDwkVOsmt74lJoCZjwIGGe7jy/+C8oZfa?=
 =?us-ascii?q?B2fIAWGU+wLMCtgNZznZjgXzhf7lHwKUkB3ZqSZReKb1H7lTZV3EATrG3vzT?=
 =?us-ascii?q?C01BRogjopqeyZxyWIzOP8IklUclVXTXVv2A+/abO/iMoXCQ3xNVkk?=
X-IPAS-Result: =?us-ascii?q?A2BtAgDSHPld/wHyM5BlHAEBAQEBBwEBEQEEBAEBgX6Bd?=
 =?us-ascii?q?IFtIBIqhASJA4Z3BoE3gQGIaZFFCQEBAQEBAQEBATcBAYRAAoI8OBMCEAEBA?=
 =?us-ascii?q?QQBAQEBAQUDAQFshUOCOykBgnoBBSMEEUEQCxgCAiYCAlcGAQwGAgEBglMMP?=
 =?us-ascii?q?4JTJa5HfzOFT4NCgUiBDiiMMnmBB4ERJw+CKAcuPodZgl4EjUGJS0aXM4I+g?=
 =?us-ascii?q?kKTSAYbmkmOTZxeIoFYKwgCGAghDzuCbFARFI0eF45BIwMwjz4rghQBAQ?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 17 Dec 2019 18:25:45 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id xBHIPQb9170559;
        Tue, 17 Dec 2019 13:25:26 -0500
Subject: Re: [PATCH v12 12/25] IMA: Change internal interfaces to use lsmblobs
To:     Casey Schaufler <casey@schaufler-ca.com>,
        casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com
References: <20191216223621.5127-1-casey@schaufler-ca.com>
 <20191216223621.5127-13-casey@schaufler-ca.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <20ea4766-6a2b-cfda-2a48-74eaebafb04d@tycho.nsa.gov>
Date:   Tue, 17 Dec 2019 13:26:06 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191216223621.5127-13-casey@schaufler-ca.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 12/16/19 5:36 PM, Casey Schaufler wrote:
> The IMA interfaces ima_get_action() and ima_match_policy()
> call LSM functions that use lsmblobs. Change the IMA functions
> to pass the lsmblob to be compatible with the LSM functions.
> 
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Reviewed-by: John Johansen <john.johansen@canonical.com>
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> cc: linux-integrity@vger.kernel.org

Needs an ack from linux-integrity, but for me:
Acked-by: Stephen Smalley <sds@tycho.nsa.gov>

> ---
>   security/integrity/ima/ima.h          | 11 ++++-----
>   security/integrity/ima/ima_api.c      | 10 ++++-----
>   security/integrity/ima/ima_appraise.c |  4 +---
>   security/integrity/ima/ima_main.c     | 32 +++++++++++----------------
>   security/integrity/ima/ima_policy.c   | 12 +++++-----
>   5 files changed, 31 insertions(+), 38 deletions(-)
> 
> diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
> index d95b0ece7434..96b6662ea39f 100644
> --- a/security/integrity/ima/ima.h
> +++ b/security/integrity/ima/ima.h
> @@ -205,9 +205,9 @@ extern const char *const func_tokens[];
>   struct modsig;
>   
>   /* LIM API function definitions */
> -int ima_get_action(struct inode *inode, const struct cred *cred, u32 secid,
> -		   int mask, enum ima_hooks func, int *pcr,
> -		   struct ima_template_desc **template_desc);
> +int ima_get_action(struct inode *inode, const struct cred *cred,
> +		   struct lsmblob *blob, int mask, enum ima_hooks func,
> +		   int *pcr, struct ima_template_desc **template_desc);
>   int ima_must_measure(struct inode *inode, int mask, enum ima_hooks func);
>   int ima_collect_measurement(struct integrity_iint_cache *iint,
>   			    struct file *file, void *buf, loff_t size,
> @@ -232,8 +232,9 @@ void ima_free_template_entry(struct ima_template_entry *entry);
>   const char *ima_d_path(const struct path *path, char **pathbuf, char *filename);
>   
>   /* IMA policy related functions */
> -int ima_match_policy(struct inode *inode, const struct cred *cred, u32 secid,
> -		     enum ima_hooks func, int mask, int flags, int *pcr,
> +int ima_match_policy(struct inode *inode, const struct cred *cred,
> +		     struct lsmblob *blob, enum ima_hooks func, int mask,
> +		     int flags, int *pcr,
>   		     struct ima_template_desc **template_desc);
>   void ima_init_policy(void);
>   void ima_update_policy(void);
> diff --git a/security/integrity/ima/ima_api.c b/security/integrity/ima/ima_api.c
> index 610759fe63b8..1ab769fa7df6 100644
> --- a/security/integrity/ima/ima_api.c
> +++ b/security/integrity/ima/ima_api.c
> @@ -163,7 +163,7 @@ void ima_add_violation(struct file *file, const unsigned char *filename,
>    * ima_get_action - appraise & measure decision based on policy.
>    * @inode: pointer to inode to measure
>    * @cred: pointer to credentials structure to validate
> - * @secid: secid of the task being validated
> + * @blob: LSM data of the task being validated
>    * @mask: contains the permission mask (MAY_READ, MAY_WRITE, MAY_EXEC,
>    *        MAY_APPEND)
>    * @func: caller identifier
> @@ -181,15 +181,15 @@ void ima_add_violation(struct file *file, const unsigned char *filename,
>    * Returns IMA_MEASURE, IMA_APPRAISE mask.
>    *
>    */
> -int ima_get_action(struct inode *inode, const struct cred *cred, u32 secid,
> -		   int mask, enum ima_hooks func, int *pcr,
> -		   struct ima_template_desc **template_desc)
> +int ima_get_action(struct inode *inode, const struct cred *cred,
> +		   struct lsmblob *blob, int mask, enum ima_hooks func,
> +		   int *pcr, struct ima_template_desc **template_desc)
>   {
>   	int flags = IMA_MEASURE | IMA_AUDIT | IMA_APPRAISE | IMA_HASH;
>   
>   	flags &= ima_policy_flag;
>   
> -	return ima_match_policy(inode, cred, secid, func, mask, flags, pcr,
> +	return ima_match_policy(inode, cred, blob, func, mask, flags, pcr,
>   				template_desc);
>   }
>   
> diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
> index 69e549164949..01c755a242ac 100644
> --- a/security/integrity/ima/ima_appraise.c
> +++ b/security/integrity/ima/ima_appraise.c
> @@ -48,15 +48,13 @@ bool is_ima_appraise_enabled(void)
>    */
>   int ima_must_appraise(struct inode *inode, int mask, enum ima_hooks func)
>   {
> -	u32 secid;
>   	struct lsmblob blob;
>   
>   	if (!ima_appraise)
>   		return 0;
>   
>   	security_task_getsecid(current, &blob);
> -	lsmblob_secid(&blob, &secid);
> -	return ima_match_policy(inode, current_cred(), secid, func, mask,
> +	return ima_match_policy(inode, current_cred(), &blob, func, mask,
>   				IMA_APPRAISE | IMA_HASH, NULL, NULL);
>   }
>   
> diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
> index c8e3e234d446..86cc1419587e 100644
> --- a/security/integrity/ima/ima_main.c
> +++ b/security/integrity/ima/ima_main.c
> @@ -190,8 +190,8 @@ void ima_file_free(struct file *file)
>   }
>   
>   static int process_measurement(struct file *file, const struct cred *cred,
> -			       u32 secid, char *buf, loff_t size, int mask,
> -			       enum ima_hooks func)
> +			       struct lsmblob *blob, char *buf, loff_t size,
> +			       int mask, enum ima_hooks func)
>   {
>   	struct inode *inode = file_inode(file);
>   	struct integrity_iint_cache *iint = NULL;
> @@ -214,7 +214,7 @@ static int process_measurement(struct file *file, const struct cred *cred,
>   	 * bitmask based on the appraise/audit/measurement policy.
>   	 * Included is the appraise submask.
>   	 */
> -	action = ima_get_action(inode, cred, secid, mask, func, &pcr,
> +	action = ima_get_action(inode, cred, blob, mask, func, &pcr,
>   				&template_desc);
>   	violation_check = ((func == FILE_CHECK || func == MMAP_CHECK) &&
>   			   (ima_policy_flag & IMA_MEASURE));
> @@ -388,8 +388,7 @@ int ima_file_mmap(struct file *file, unsigned long prot)
>   
>   	if (file && (prot & PROT_EXEC)) {
>   		security_task_getsecid(current, &blob);
> -		/* scaffolding - until process_measurement changes */
> -		return process_measurement(file, current_cred(), blob.secid[0],
> +		return process_measurement(file, current_cred(), &blob,
>   					   NULL, 0, MAY_EXEC, MMAP_CHECK);
>   	}
>   
> @@ -415,16 +414,14 @@ int ima_bprm_check(struct linux_binprm *bprm)
>   	struct lsmblob blob;
>   
>   	security_task_getsecid(current, &blob);
> -	/* scaffolding until process_measurement changes */
> -	ret = process_measurement(bprm->file, current_cred(), blob.secid[0],
> -				  NULL, 0, MAY_EXEC, BPRM_CHECK);
> +	ret = process_measurement(bprm->file, current_cred(), &blob, NULL, 0,
> +				  MAY_EXEC, BPRM_CHECK);
>   	if (ret)
>   		return ret;
>   
>   	security_cred_getsecid(bprm->cred, &blob);
> -	/* scaffolding until process_measurement changes */
> -	return process_measurement(bprm->file, bprm->cred, blob.secid[0],
> -				   NULL, 0, MAY_EXEC, CREDS_CHECK);
> +	return process_measurement(bprm->file, bprm->cred, &blob, NULL, 0,
> +				   MAY_EXEC, CREDS_CHECK);
>   }
>   
>   /**
> @@ -442,8 +439,7 @@ int ima_file_check(struct file *file, int mask)
>   	struct lsmblob blob;
>   
>   	security_task_getsecid(current, &blob);
> -	/* scaffolding until process_measurement changes */
> -	return process_measurement(file, current_cred(), blob.secid[0], NULL, 0,
> +	return process_measurement(file, current_cred(), &blob, NULL, 0,
>   				   mask & (MAY_READ | MAY_WRITE | MAY_EXEC |
>   					   MAY_APPEND), FILE_CHECK);
>   }
> @@ -575,9 +571,8 @@ int ima_post_read_file(struct file *file, void *buf, loff_t size,
>   
>   	func = read_idmap[read_id] ?: FILE_CHECK;
>   	security_task_getsecid(current, &blob);
> -	/* scaffolding until process_measurement changes */
> -	return process_measurement(file, current_cred(), blob.secid[0], buf,
> -				   size, MAY_READ, func);
> +	return process_measurement(file, current_cred(), &blob, buf, size,
> +				   MAY_READ, func);
>   }
>   
>   /**
> @@ -669,9 +664,8 @@ void process_buffer_measurement(const void *buf, int size,
>   	 */
>   	if (func) {
>   		security_task_getsecid(current, &blob);
> -		/* scaffolding */
> -		action = ima_get_action(NULL, current_cred(), blob.secid[0],
> -					0, func, &pcr, &template);
> +		action = ima_get_action(NULL, current_cred(), &blob, 0, func,
> +					&pcr, &template);
>   		if (!(action & IMA_MEASURE))
>   			return;
>   	}
> diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
> index c7d2ea47a326..b089d4a8b27b 100644
> --- a/security/integrity/ima/ima_policy.c
> +++ b/security/integrity/ima/ima_policy.c
> @@ -368,7 +368,7 @@ int ima_lsm_policy_change(struct notifier_block *nb, unsigned long event,
>    * Returns true on rule match, false on failure.
>    */
>   static bool ima_match_rules(struct ima_rule_entry *rule, struct inode *inode,
> -			    const struct cred *cred, u32 secid,
> +			    const struct cred *cred, struct lsmblob *blob,
>   			    enum ima_hooks func, int mask)
>   {
>   	int i;
> @@ -431,7 +431,6 @@ static bool ima_match_rules(struct ima_rule_entry *rule, struct inode *inode,
>   		case LSM_SUBJ_USER:
>   		case LSM_SUBJ_ROLE:
>   		case LSM_SUBJ_TYPE:
> -			lsmblob_init(&blob, secid);
>   			rc = security_filter_rule_match(&blob,
>   							rule->lsm[i].type,
>   							Audit_equal,
> @@ -475,7 +474,7 @@ static int get_subaction(struct ima_rule_entry *rule, enum ima_hooks func)
>    * @inode: pointer to an inode for which the policy decision is being made
>    * @cred: pointer to a credentials structure for which the policy decision is
>    *        being made
> - * @secid: LSM secid of the task to be validated
> + * @blob: LSM data of the task to be validated
>    * @func: IMA hook identifier
>    * @mask: requested action (MAY_READ | MAY_WRITE | MAY_APPEND | MAY_EXEC)
>    * @pcr: set the pcr to extend
> @@ -488,8 +487,9 @@ static int get_subaction(struct ima_rule_entry *rule, enum ima_hooks func)
>    * list when walking it.  Reads are many orders of magnitude more numerous
>    * than writes so ima_match_policy() is classical RCU candidate.
>    */
> -int ima_match_policy(struct inode *inode, const struct cred *cred, u32 secid,
> -		     enum ima_hooks func, int mask, int flags, int *pcr,
> +int ima_match_policy(struct inode *inode, const struct cred *cred,
> +		     struct lsmblob *blob, enum ima_hooks func, int mask,
> +		     int flags, int *pcr,
>   		     struct ima_template_desc **template_desc)
>   {
>   	struct ima_rule_entry *entry;
> @@ -504,7 +504,7 @@ int ima_match_policy(struct inode *inode, const struct cred *cred, u32 secid,
>   		if (!(entry->action & actmask))
>   			continue;
>   
> -		if (!ima_match_rules(entry, inode, cred, secid, func, mask))
> +		if (!ima_match_rules(entry, inode, cred, blob, func, mask))
>   			continue;
>   
>   		action |= entry->flags & IMA_ACTION_FLAGS;
> 

