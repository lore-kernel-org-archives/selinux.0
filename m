Return-Path: <SRS0=o61S=RE=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB3C5C4360F
	for <selinux@archiver.kernel.org>; Fri,  1 Mar 2019 14:59:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82BE620851
	for <selinux@archiver.kernel.org>; Fri,  1 Mar 2019 14:59:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388712AbfCAO7h (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 1 Mar 2019 09:59:37 -0500
Received: from mail.emypeople.net ([216.220.167.73]:38267 "EHLO
        mail.emypeople.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728313AbfCAO7h (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 1 Mar 2019 09:59:37 -0500
Received: from Shop7 ([166.182.241.52])
        by mail.emypeople.net (12.1.1 build 4 DEB9 x64) with ASMTP id 201903010959357549;
        Fri, 01 Mar 2019 09:59:35 -0500
From:   "Edwin Zimmerman" <edwin@211mainstreet.net>
To:     "'Casey Schaufler'" <casey@schaufler-ca.com>, <jmorris@namei.org>,
        <linux-security-module@vger.kernel.org>, <selinux@vger.kernel.org>
Cc:     <keescook@chromium.org>, <john.johansen@canonical.com>,
        <penguin-kernel@i-love.sakura.ne.jp>, <paul@paul-moore.com>
References: <20190228221933.2551-1-casey@schaufler-ca.com> <20190228221933.2551-12-casey@schaufler-ca.com>
In-Reply-To: <20190228221933.2551-12-casey@schaufler-ca.com>
Subject: RE: [PATCH 11/97] LSM: Use lsm_export in the kernel_ask_as hooks
Date:   Fri, 1 Mar 2019 09:59:14 -0500
Message-ID: <000b01d4d03f$567e1e90$037a5bb0$@211mainstreet.net>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 15.0
Content-Language: en-us
Thread-Index: AQHLxLo4sMohEqs1TC+P/+0SYu7cuwF/FdJVpfz75jA=
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thursday, 2/28/2019 at 5:18 PM, Casey Schaufler <casey@schaufler-ca.com> wrote:
> Convert the kernel_ask_as hooks to use the lsm_export
Should be act_as, not? ^^
> structure instead of a u32 secid. There is some scaffolding
> involved that will be removed when security_kernel_ask_as()
> is updated.
> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>  include/linux/lsm_hooks.h  |  4 ++--
>  security/security.c        | 15 ++++++++++++++-
>  security/selinux/hooks.c   | 17 ++++++++++++++---
>  security/smack/smack_lsm.c | 12 +++++++++++-
>  4 files changed, 41 insertions(+), 7 deletions(-)
> 
> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> index 44597189fea4..796eb441be95 100644
> --- a/include/linux/lsm_hooks.h
> +++ b/include/linux/lsm_hooks.h
> @@ -562,7 +562,7 @@
>   * @kernel_act_as:
>   *	Set the credentials for a kernel service to act as (subjective context).
>   *	@new points to the credentials to be modified.
> - *	@secid specifies the security ID to be set
> + *	@l specifies the security data to be set
>   *	The current task must be the one that nominated @secid.
>   *	Return 0 if successful.
>   * @kernel_create_files_as:
> @@ -1588,7 +1588,7 @@ union security_list_options {
>  				gfp_t gfp);
>  	void (*cred_transfer)(struct cred *new, const struct cred *old);
>  	void (*cred_getsecid)(const struct cred *c, struct lsm_export *l);
> -	int (*kernel_act_as)(struct cred *new, u32 secid);
> +	int (*kernel_act_as)(struct cred *new, struct lsm_export *l);
>  	int (*kernel_create_files_as)(struct cred *new, struct inode *inode);
>  	int (*kernel_module_request)(char *kmod_name);
>  	int (*kernel_load_data)(enum kernel_load_data_id id);
> diff --git a/security/security.c b/security/security.c
> index 909b6b8d1a50..1a29fe08a5d9 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -738,6 +738,15 @@ static inline void lsm_export_secid(struct lsm_export *data, u32 *secid)
>  	}
>  }
> 
> +static inline void lsm_export_to_all(struct lsm_export *data, u32 secid)
> +{
> +	data->selinux = secid;
> +	data->smack = secid;
> +	data->apparmor = secid;
> +	data->flags = LSM_EXPORT_SELINUX | LSM_EXPORT_SMACK |
> +		      LSM_EXPORT_APPARMOR;
> +}
> +
>  /* Security operations */
> 
>  int security_binder_set_context_mgr(struct task_struct *mgr)
> @@ -1633,7 +1642,11 @@ EXPORT_SYMBOL(security_cred_getsecid);
> 
>  int security_kernel_act_as(struct cred *new, u32 secid)
>  {
> -	return call_int_hook(kernel_act_as, 0, new, secid);
> +	struct lsm_export data = { .flags = LSM_EXPORT_NONE };
> +
> +	lsm_export_to_all(&data, secid);
> +
> +	return call_int_hook(kernel_act_as, 0, new, &data);
>  }
> 
>  int security_kernel_create_files_as(struct cred *new, struct inode *inode)
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 6f61a894f7c5..efcd905bdabf 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -220,6 +220,14 @@ static inline void selinux_export_secid(struct lsm_export *l, u32 secid)
>  	l->flags |= LSM_EXPORT_SELINUX;
>  }
> 
> +static inline void selinux_import_secid(struct lsm_export *l, u32 *secid)
> +{
> +	if (l->flags | LSM_EXPORT_SELINUX)
> +		*secid = l->selinux;
> +	else
> +		*secid = SECSID_NULL;
> +}
> +
>  /*
>   * get the security ID of a set of credentials
>   */
> @@ -3669,19 +3677,22 @@ static void selinux_cred_getsecid(const struct cred *c, struct lsm_export *l)
>   * set the security data for a kernel service
>   * - all the creation contexts are set to unlabelled
>   */
> -static int selinux_kernel_act_as(struct cred *new, u32 secid)
> +static int selinux_kernel_act_as(struct cred *new, struct lsm_export *l)
>  {
>  	struct task_security_struct *tsec = selinux_cred(new);
> +	u32 nsid;
>  	u32 sid = current_sid();
>  	int ret;
> 
> +	selinux_import_secid(l, &nsid);
> +
>  	ret = avc_has_perm(&selinux_state,
> -			   sid, secid,
> +			   sid, nsid,
>  			   SECCLASS_KERNEL_SERVICE,
>  			   KERNEL_SERVICE__USE_AS_OVERRIDE,
>  			   NULL);
>  	if (ret == 0) {
> -		tsec->sid = secid;
> +		tsec->sid = nsid;
>  		tsec->create_sid = 0;
>  		tsec->keycreate_sid = 0;
>  		tsec->sockcreate_sid = 0;
> diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
> index d5ff34a5803b..0e1f6ef25eb2 100644
> --- a/security/smack/smack_lsm.c
> +++ b/security/smack/smack_lsm.c
> @@ -473,6 +473,14 @@ static inline void smack_export_secid(struct lsm_export *l, u32 secid)
>  	l->flags |= LSM_EXPORT_SMACK;
>  }
> 
> +static inline void smack_import_secid(struct lsm_export *l, u32 *secid)
> +{
> +	if (l->flags | LSM_EXPORT_SMACK)
> +		*secid = l->smack;
> +	else
> +		*secid = 0;
> +}
> +
>  /*
>   * LSM hooks.
>   * We he, that is fun!
> @@ -1910,10 +1918,12 @@ static void smack_cred_getsecid(const struct cred *cred, struct lsm_export *l)
>   *
>   * Set the security data for a kernel service.
>   */
> -static int smack_kernel_act_as(struct cred *new, u32 secid)
> +static int smack_kernel_act_as(struct cred *new, struct lsm_export *l)
>  {
> +	u32 secid;
>  	struct task_smack *new_tsp = smack_cred(new);
> 
> +	smack_import_secid(l, &secid);
>  	new_tsp->smk_task = smack_from_secid(secid);
>  	return 0;
>  }
> --
> 2.17.0

