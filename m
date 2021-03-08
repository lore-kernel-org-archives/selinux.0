Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E62A3C433E9
	for <selinux@archiver.kernel.org>; Mon,  8 Mar 2021 19:28:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B32EA6521F
	for <selinux@archiver.kernel.org>; Mon,  8 Mar 2021 19:28:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229972AbhCHT1Z (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 8 Mar 2021 14:27:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36367 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231321AbhCHT1I (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 8 Mar 2021 14:27:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615231628;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kKDJ/lrvypxZKD7GZrpP2I6Uwa8dO8VBjG6vd5FMaJ4=;
        b=gzsRxvy1SPjX4Asz+pw1vGvDHPZd/ol4mZv5yy02rsnurSvCbBH9aAGLYji9cO+p0vjhw0
        5DP6YJFF+T5JmPa+awaUkLDkoD4i8RWzNr7LGqJiLHkW7nK/AKXrz5/8Hjn6BAB1xGIDJE
        V2chZlce3bvpU2spL5TNRZHzH3bhuU0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-309-Ez0JHeTqM2aRxCxUi5NkIg-1; Mon, 08 Mar 2021 14:27:04 -0500
X-MC-Unique: Ez0JHeTqM2aRxCxUi5NkIg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2A1B310866A3;
        Mon,  8 Mar 2021 19:27:03 +0000 (UTC)
Received: from madcap2.tricolour.ca (unknown [10.10.110.12])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B2E0E6062F;
        Mon,  8 Mar 2021 19:26:53 +0000 (UTC)
Date:   Mon, 8 Mar 2021 14:26:51 -0500
From:   Richard Guy Briggs <rgb@redhat.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        John Johansen <john.johansen@canonical.com>,
        selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-audit@redhat.com
Subject: Re: [RFC PATCH 3/4] smack: differentiate between subjective and
 objective task credentials
Message-ID: <20210308192651.GA2015948@madcap2.tricolour.ca>
References: <161377712068.87807.12246856567527156637.stgit@sifl>
 <161377735771.87807.8998552586584751981.stgit@sifl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <161377735771.87807.8998552586584751981.stgit@sifl>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 2021-02-19 18:29, Paul Moore wrote:
> With the split of the security_task_getsecid() into subjective and
> objective variants it's time to update Smack to ensure it is using
> the correct task creds.
> 
> Signed-off-by: Paul Moore <paul@paul-moore.com>

FWIW Reviewed-by: Richard Guy Briggs <rgb@redhat.com>

> ---
>  security/smack/smack.h     |   18 +++++++++++++++++-
>  security/smack/smack_lsm.c |   40 +++++++++++++++++++++++++++-------------
>  2 files changed, 44 insertions(+), 14 deletions(-)
> 
> diff --git a/security/smack/smack.h b/security/smack/smack.h
> index a9768b12716bf..08f9cb80655ce 100644
> --- a/security/smack/smack.h
> +++ b/security/smack/smack.h
> @@ -383,7 +383,23 @@ static inline struct smack_known *smk_of_task(const struct task_smack *tsp)
>  	return tsp->smk_task;
>  }
>  
> -static inline struct smack_known *smk_of_task_struct(
> +static inline struct smack_known *smk_of_task_struct_subj(
> +						const struct task_struct *t)
> +{
> +	struct smack_known *skp;
> +	const struct cred *cred;
> +
> +	rcu_read_lock();
> +
> +	cred = rcu_dereference(t->cred);
> +	skp = smk_of_task(smack_cred(cred));
> +
> +	rcu_read_unlock();
> +
> +	return skp;
> +}
> +
> +static inline struct smack_known *smk_of_task_struct_obj(
>  						const struct task_struct *t)
>  {
>  	struct smack_known *skp;
> diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
> index 2bb354ef2c4a9..ea1a82742e8ba 100644
> --- a/security/smack/smack_lsm.c
> +++ b/security/smack/smack_lsm.c
> @@ -159,7 +159,7 @@ static int smk_bu_current(char *note, struct smack_known *oskp,
>  static int smk_bu_task(struct task_struct *otp, int mode, int rc)
>  {
>  	struct task_smack *tsp = smack_cred(current_cred());
> -	struct smack_known *smk_task = smk_of_task_struct(otp);
> +	struct smack_known *smk_task = smk_of_task_struct_obj(otp);
>  	char acc[SMK_NUM_ACCESS_TYPE + 1];
>  
>  	if (rc <= 0)
> @@ -479,7 +479,7 @@ static int smack_ptrace_access_check(struct task_struct *ctp, unsigned int mode)
>  {
>  	struct smack_known *skp;
>  
> -	skp = smk_of_task_struct(ctp);
> +	skp = smk_of_task_struct_obj(ctp);
>  
>  	return smk_ptrace_rule_check(current, skp, mode, __func__);
>  }
> @@ -2031,7 +2031,7 @@ static int smk_curacc_on_task(struct task_struct *p, int access,
>  				const char *caller)
>  {
>  	struct smk_audit_info ad;
> -	struct smack_known *skp = smk_of_task_struct(p);
> +	struct smack_known *skp = smk_of_task_struct_subj(p);
>  	int rc;
>  
>  	smk_ad_init(&ad, caller, LSM_AUDIT_DATA_TASK);
> @@ -2076,15 +2076,29 @@ static int smack_task_getsid(struct task_struct *p)
>  }
>  
>  /**
> - * smack_task_getsecid - get the secid of the task
> - * @p: the object task
> + * smack_task_getsecid_subj - get the subjective secid of the task
> + * @p: the task
>   * @secid: where to put the result
>   *
> - * Sets the secid to contain a u32 version of the smack label.
> + * Sets the secid to contain a u32 version of the task's subjective smack label.
> + */
> +static void smack_task_getsecid_subj(struct task_struct *p, u32 *secid)
> +{
> +	struct smack_known *skp = smk_of_task_struct_subj(p);
> +
> +	*secid = skp->smk_secid;
> +}
> +
> +/**
> + * smack_task_getsecid_obj - get the objective secid of the task
> + * @p: the task
> + * @secid: where to put the result
> + *
> + * Sets the secid to contain a u32 version of the task's objective smack label.
>   */
> -static void smack_task_getsecid(struct task_struct *p, u32 *secid)
> +static void smack_task_getsecid_obj(struct task_struct *p, u32 *secid)
>  {
> -	struct smack_known *skp = smk_of_task_struct(p);
> +	struct smack_known *skp = smk_of_task_struct_obj(p);
>  
>  	*secid = skp->smk_secid;
>  }
> @@ -2172,7 +2186,7 @@ static int smack_task_kill(struct task_struct *p, struct kernel_siginfo *info,
>  {
>  	struct smk_audit_info ad;
>  	struct smack_known *skp;
> -	struct smack_known *tkp = smk_of_task_struct(p);
> +	struct smack_known *tkp = smk_of_task_struct_obj(p);
>  	int rc;
>  
>  	if (!sig)
> @@ -2210,7 +2224,7 @@ static int smack_task_kill(struct task_struct *p, struct kernel_siginfo *info,
>  static void smack_task_to_inode(struct task_struct *p, struct inode *inode)
>  {
>  	struct inode_smack *isp = smack_inode(inode);
> -	struct smack_known *skp = smk_of_task_struct(p);
> +	struct smack_known *skp = smk_of_task_struct_obj(p);
>  
>  	isp->smk_inode = skp;
>  	isp->smk_flags |= SMK_INODE_INSTANT;
> @@ -3481,7 +3495,7 @@ static void smack_d_instantiate(struct dentry *opt_dentry, struct inode *inode)
>   */
>  static int smack_getprocattr(struct task_struct *p, char *name, char **value)
>  {
> -	struct smack_known *skp = smk_of_task_struct(p);
> +	struct smack_known *skp = smk_of_task_struct_subj(p);
>  	char *cp;
>  	int slen;
>  
> @@ -4755,8 +4769,8 @@ static struct security_hook_list smack_hooks[] __lsm_ro_after_init = {
>  	LSM_HOOK_INIT(task_setpgid, smack_task_setpgid),
>  	LSM_HOOK_INIT(task_getpgid, smack_task_getpgid),
>  	LSM_HOOK_INIT(task_getsid, smack_task_getsid),
> -	LSM_HOOK_INIT(task_getsecid_subj, smack_task_getsecid),
> -	LSM_HOOK_INIT(task_getsecid_obj, smack_task_getsecid),
> +	LSM_HOOK_INIT(task_getsecid_subj, smack_task_getsecid_subj),
> +	LSM_HOOK_INIT(task_getsecid_obj, smack_task_getsecid_obj),
>  	LSM_HOOK_INIT(task_setnice, smack_task_setnice),
>  	LSM_HOOK_INIT(task_setioprio, smack_task_setioprio),
>  	LSM_HOOK_INIT(task_getioprio, smack_task_getioprio),
> 
> --
> Linux-audit mailing list
> Linux-audit@redhat.com
> https://listman.redhat.com/mailman/listinfo/linux-audit

- RGB

--
Richard Guy Briggs <rgb@redhat.com>
Sr. S/W Engineer, Kernel Security, Base Operating Systems
Remote, Ottawa, Red Hat Canada
IRC: rgb, SunRaycer
Voice: +1.647.777.2635, Internal: (81) 32635

