Return-Path: <SRS0=B3ih=24=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F319AC33C8C
	for <selinux@archiver.kernel.org>; Tue,  7 Jan 2020 17:53:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B68F62073D
	for <selinux@archiver.kernel.org>; Tue,  7 Jan 2020 17:53:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="qrvp6Djm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728400AbgAGRx2 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 7 Jan 2020 12:53:28 -0500
Received: from USFB19PA36.eemsg.mail.mil ([214.24.26.199]:49683 "EHLO
        USFB19PA36.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728390AbgAGRx2 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 7 Jan 2020 12:53:28 -0500
X-EEMSG-check-017: 41924359|USFB19PA36_ESA_OUT06.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.69,406,1571702400"; 
   d="scan'208";a="41924359"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by USFB19PA36.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 07 Jan 2020 17:53:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1578419605; x=1609955605;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=9YuDZzWezRbbZlBnMKVf09hG7BLcxFTvXc4jiw7+JQw=;
  b=qrvp6DjmCaIV48iT4hS2MbaIiIOB+nfw55w7W9tqSuLXJ1Z9ZXlxjSsy
   inGv5eSsuA5DnqKjU4B5YB9SSzPpviqofaHCAjkkeJxueHtEoi+5uWIiE
   RNOqwmjrvSZJFwjEBjj7r/Q6mQWCz9eTFWCZ5ptqI+z2gOJjZbatc6RTt
   3W/3xKLDDjQZ8IqIndgXOYpnuf15p7JJcDS/q6b+QnE7IQ0cSw+KLEPJI
   CBgGYZSMOnvtN9M+5d8nJ6BXpZQnmc3cCbAcHhs2Rwm3JOVjpj7JewsCb
   6nK8VGjKCiPbJlCqSEUms5P8AdBosV5wAdT8Qw4KlCR8CuQTQx9ol0ewR
   w==;
X-IronPort-AV: E=Sophos;i="5.69,406,1571702400"; 
   d="scan'208";a="31683838"
IronPort-PHdr: =?us-ascii?q?9a23=3AqGpTHh2umpwawZIwsmDT+DRfVm0co7zxezQtwd?=
 =?us-ascii?q?8ZsesSLf3xwZ3uMQTl6Ol3ixeRBMOHsqkC0beL+Pi/EUU7or+5+EgYd5JNUx?=
 =?us-ascii?q?JXwe43pCcHRPC/NEvgMfTxZDY7FskRHHVs/nW8LFQHUJ2mPw6arXK99yMdFQ?=
 =?us-ascii?q?viPgRpOOv1BpTSj8Oq3Oyu5pHfeQpFiCezbL9oMhm7rQXcusYKjYZgN6081g?=
 =?us-ascii?q?bHrnxUdupM2GhmP0iTnxHy5sex+J5s7SFdsO8/+sBDTKv3Yb02QaRXAzo6PW?=
 =?us-ascii?q?814tbrtQTYQguU+nQcSGQWnQFWDAXD8Rr3Q43+sir+tup6xSmaIcj7Rq06VD?=
 =?us-ascii?q?i+86tmTgLjhTwZPDAl7m7Yls1wjLpaoB2/oRx/35XUa5yROPZnY6/RYc8WSW?=
 =?us-ascii?q?9HU8lfTSxBBp63YZUJAeQPIO1Uq5Dxq0UKoBe7AwSnGeHhxSJShnLuwKM0ze?=
 =?us-ascii?q?ohHwHF0gIuEd0Bv3bbo8n6OqoJTeC4zrPFwSnfY/5Y2zrw7pXDfBA7ofGLWL?=
 =?us-ascii?q?J9adffyVUxGAPdjlWft4rlNC6I2OQIqWeb6+5gWvyvimU6rAxxuSWgxtw3h4?=
 =?us-ascii?q?nVhoMa1lDE9SJjzIYzPt23UlR3YdGjEJtOriyXMZZ9TMA6Q2xwpSo3xbILtY?=
 =?us-ascii?q?S7cSQX0pgr2RHSZ+Kdf4SV5B/oSfyfLi1ihH1/fbKynxOy8U+9xeLiTsS0y1?=
 =?us-ascii?q?NKrjZdktnLq3ANywTf6siZRft5+UeswSqP2BrJ6uFFPEA0jrDXK58nwr4+kZ?=
 =?us-ascii?q?oTqlrMETPslEXqjK6ZakUk+u+y5+ThfrrmvYOTO5VxigH/NqQigs2/AeImPQ?=
 =?us-ascii?q?gSR2WX5Oux2bL58UD5XblGlOM6n6bHvJzAOMgXvqu5DBVU0oYn5Ra/FTCm0N?=
 =?us-ascii?q?EAkHkcMV1FYwmKj5TpOl7SIPD4Cu2zg1K3kDhx3fzGMbrhAovVInjZjLjhZa?=
 =?us-ascii?q?p961JbyAcr0d9Q/YlUBa8BIf/oQU/+qNzYAQUkMwy6x+boFs992poCVm2VGK?=
 =?us-ascii?q?OWLKTSsVqQ7OI1P+aMfJMVuCr6K/U9+/Hhl2Q5lkEdfKWzxpsYdHC4Ee57I0?=
 =?us-ascii?q?WXZXrjnM0BHHwLvgo4UOzlllmCXSRPaHa1WqI2/is7B56+DYffWoCth6SM3C?=
 =?us-ascii?q?W+Hp1RfGBGEFGMEWzzeoWCQfgMbTydIs57njwDT7ihRJcr1Quyuw/i17pnMu?=
 =?us-ascii?q?3U9zUctZLi0th1+uLSmQgp9TNqE8udznuNT2BonmIIXjM22ad/rlFgyleHz6?=
 =?us-ascii?q?d1mOJYFdNN6PNTSAs6NoDTz/Z8C9/sXgLNZNCJSEypQt++GzE+Usoxw8MSY0?=
 =?us-ascii?q?Z6A9iilQ7M3y6rA78TiryKC4c58rzT33fvPcZx0XXG27c7j1kgXMRPMXeqhq?=
 =?us-ascii?q?ll9wjcH4TJiVmWl762daQA2y7A7GSDwnSQs0FDTAFwVqLFXXMEa0TKrdT5/E?=
 =?us-ascii?q?TCT7qvCbQ6NwtN08mCKrFFatfxl1VJWO/jOMjCY2K2g2qwBxGIxrOKbIbweW?=
 =?us-ascii?q?Ud2yXdB1ICkwAI43mGMxMzCTu7rGLYCzxuE1PvbF/2/ul6sn+0Ukg0zwSSZU?=
 =?us-ascii?q?17y7W14gIVheCbS/4LxrILpiEhqzppHFa82dLaEtmAqBR7fKVaf9w95ExK1W?=
 =?us-ascii?q?PAuwx5OZygMb5tikQFcwttvEPuyg93BZ9ancgssnwm1ghyKbqA2lNbazyYxY?=
 =?us-ascii?q?zwOqHQKmTq5BCgcbPW2lXF3daO4KgP9fA4p0zmvAGuEUoi6Wto38NJ3Hub45?=
 =?us-ascii?q?WZRDYVBLn4SUsmvyNxp7jHbC0w/cuA3nR3PLicqTTC0s8nAOY/jx2pOdxYNf?=
 =?us-ascii?q?XAXAT7CMALQdOlKOU3lVykdDoFOvxf8Og/OMbiP/mD37SxPf1ImjujgGUB55?=
 =?us-ascii?q?pylgqI9ixhWqvT0p0Y2fCEz06CUDvhiFqJrM/6g8ZHaCsUE275zjLrQMZKa6?=
 =?us-ascii?q?lze5sbIXmhLtfxxdhkgZPpHXlC+w2NHVQDjfS1dAKSYlq15ghZ0UAasDTzgi?=
 =?us-ascii?q?ej5yBlmDEu6KyE1WrBxPq0J0lPAXJCWGQ31QSkGoOzld1PGRHyPgU=3D?=
X-IPAS-Result: =?us-ascii?q?A2BwAACUxBRe/wHyM5BmGgEBAQEBAQEBAQMBAQEBEQEBA?=
 =?us-ascii?q?QICAQEBAYF8gX2BbSASKoQJiQOGbQaBN4luiiSHJAkBAQEBAQEBAQE3AQGEQ?=
 =?us-ascii?q?AKCDTgTAhABAQEEAQEBAQEFAwEBbIVDgjspAYJ5AQEBAQIBIwQRQQULCxgCA?=
 =?us-ascii?q?iYCAlcGAQwGAgEBgl8/glMFIKwTdX8zhU+DMYE9gQ4ojDN5gQeBEScPgl0+h?=
 =?us-ascii?q?1mCXgSNTIlNRpdAgkCCRZNRBhuaXy2OJpxyIoFYKwgCGAghDzuCbFAYDY0dA?=
 =?us-ascii?q?ReOQSMDMI5dAQE?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 07 Jan 2020 17:53:23 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id 007HqjUH180745;
        Tue, 7 Jan 2020 12:52:46 -0500
Subject: Re: [PATCH v13 09/25] LSM: Use lsmblob in security_task_getsecid
To:     Casey Schaufler <casey@schaufler-ca.com>,
        casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com
References: <20191224235939.7483-1-casey@schaufler-ca.com>
 <20191224235939.7483-10-casey@schaufler-ca.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <6c955493-41c0-a787-9c75-9750579a341d@tycho.nsa.gov>
Date:   Tue, 7 Jan 2020 12:53:54 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20191224235939.7483-10-casey@schaufler-ca.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 12/24/19 6:59 PM, Casey Schaufler wrote:
> Change the security_task_getsecid() interface to fill in
> a lsmblob structure instead of a u32 secid in support of
> LSM stacking. Audit interfaces will need to collect all
> possible secids for possible reporting.
> 
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Reviewed-by: John Johansen <john.johansen@canonical.com>
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>

You can drop one of your SOBs and add my Ack,

Acked-by: Stephen Smalley <sds@tycho.nsa.gov>

> cc: linux-integrity@vger.kernel.org
> ---
>   drivers/android/binder.c              |  4 +--
>   include/linux/security.h              |  7 +++--
>   kernel/audit.c                        | 11 +++----
>   kernel/auditfilter.c                  |  4 +--
>   kernel/auditsc.c                      | 18 ++++++++----
>   net/netlabel/netlabel_unlabeled.c     |  5 +++-
>   net/netlabel/netlabel_user.h          |  6 +++-
>   security/integrity/ima/ima_appraise.c |  9 +++---
>   security/integrity/ima/ima_main.c     | 42 +++++++++++++++------------
>   security/security.c                   | 12 ++++++--
>   10 files changed, 71 insertions(+), 47 deletions(-)
> 
> diff --git a/drivers/android/binder.c b/drivers/android/binder.c
> index f9b67f585e06..22fef6e130df 100644
> --- a/drivers/android/binder.c
> +++ b/drivers/android/binder.c
> @@ -3104,12 +3104,10 @@ static void binder_transaction(struct binder_proc *proc,
>   	t->priority = task_nice(current);
>   
>   	if (target_node && target_node->txn_security_ctx) {
> -		u32 secid;
>   		struct lsmblob blob;
>   		size_t added_size;
>   
> -		security_task_getsecid(proc->tsk, &secid);
> -		lsmblob_init(&blob, secid);
> +		security_task_getsecid(proc->tsk, &blob);
>   		ret = security_secid_to_secctx(&blob, &secctx, &secctx_sz);
>   		if (ret) {
>   			return_error = BR_FAILED_REPLY;
> diff --git a/include/linux/security.h b/include/linux/security.h
> index 61a80afbbdba..b6d5475f8196 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -449,7 +449,7 @@ int security_task_fix_setuid(struct cred *new, const struct cred *old,
>   int security_task_setpgid(struct task_struct *p, pid_t pgid);
>   int security_task_getpgid(struct task_struct *p);
>   int security_task_getsid(struct task_struct *p);
> -void security_task_getsecid(struct task_struct *p, u32 *secid);
> +void security_task_getsecid(struct task_struct *p, struct lsmblob *blob);
>   int security_task_setnice(struct task_struct *p, int nice);
>   int security_task_setioprio(struct task_struct *p, int ioprio);
>   int security_task_getioprio(struct task_struct *p);
> @@ -1101,9 +1101,10 @@ static inline int security_task_getsid(struct task_struct *p)
>   	return 0;
>   }
>   
> -static inline void security_task_getsecid(struct task_struct *p, u32 *secid)
> +static inline void security_task_getsecid(struct task_struct *p,
> +					  struct lsmblob *blob)
>   {
> -	*secid = 0;
> +	lsmblob_init(blob, 0);
>   }
>   
>   static inline int security_task_setnice(struct task_struct *p, int nice)
> diff --git a/kernel/audit.c b/kernel/audit.c
> index e3e515158295..6ee53e43c986 100644
> --- a/kernel/audit.c
> +++ b/kernel/audit.c
> @@ -2062,14 +2062,12 @@ int audit_log_task_context(struct audit_buffer *ab)
>   	char *ctx = NULL;
>   	unsigned len;
>   	int error;
> -	u32 sid;
>   	struct lsmblob blob;
>   
> -	security_task_getsecid(current, &sid);
> -	if (!sid)
> +	security_task_getsecid(current, &blob);
> +	if (!lsmblob_is_set(&blob))
>   		return 0;
>   
> -	lsmblob_init(&blob, sid);
>   	error = security_secid_to_secctx(&blob, &ctx, &len);
>   	if (error) {
>   		if (error != -EINVAL)
> @@ -2277,6 +2275,7 @@ int audit_set_loginuid(kuid_t loginuid)
>   int audit_signal_info(int sig, struct task_struct *t)
>   {
>   	kuid_t uid = current_uid(), auid;
> +	struct lsmblob blob;
>   
>   	if (auditd_test_task(t) &&
>   	    (sig == SIGTERM || sig == SIGHUP ||
> @@ -2287,7 +2286,9 @@ int audit_signal_info(int sig, struct task_struct *t)
>   			audit_sig_uid = auid;
>   		else
>   			audit_sig_uid = uid;
> -		security_task_getsecid(current, &audit_sig_sid);
> +		security_task_getsecid(current, &blob);
> +		/* scaffolding until audit_sig_sid is converted */
> +		audit_sig_sid = blob.secid[0];
>   	}
>   
>   	return audit_signal_info_syscall(t);
> diff --git a/kernel/auditfilter.c b/kernel/auditfilter.c
> index 356db1dd276c..19cfbe716f9d 100644
> --- a/kernel/auditfilter.c
> +++ b/kernel/auditfilter.c
> @@ -1324,7 +1324,6 @@ int audit_filter(int msgtype, unsigned int listtype)
>   		for (i = 0; i < e->rule.field_count; i++) {
>   			struct audit_field *f = &e->rule.fields[i];
>   			pid_t pid;
> -			u32 sid;
>   			struct lsmblob blob;
>   
>   			switch (f->type) {
> @@ -1355,8 +1354,7 @@ int audit_filter(int msgtype, unsigned int listtype)
>   			case AUDIT_SUBJ_SEN:
>   			case AUDIT_SUBJ_CLR:
>   				if (f->lsm_rule) {
> -					security_task_getsecid(current, &sid);
> -					lsmblob_init(&blob, sid);
> +					security_task_getsecid(current, &blob);
>   					result = security_audit_rule_match(
>   							&blob, f->type,
>   							f->op, f->lsm_rule);
> diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> index ce8bf2d8f8d2..cccb681ad081 100644
> --- a/kernel/auditsc.c
> +++ b/kernel/auditsc.c
> @@ -444,7 +444,6 @@ static int audit_filter_rules(struct task_struct *tsk,
>   {
>   	const struct cred *cred;
>   	int i, need_sid = 1;
> -	u32 sid;
>   	struct lsmblob blob;
>   	unsigned int sessionid;
>   
> @@ -641,10 +640,9 @@ static int audit_filter_rules(struct task_struct *tsk,
>   			   logged upon error */
>   			if (f->lsm_rule) {
>   				if (need_sid) {
> -					security_task_getsecid(tsk, &sid);
> +					security_task_getsecid(tsk, &blob);
>   					need_sid = 0;
>   				}
> -				lsmblob_init(&blob, sid);
>   				result = security_audit_rule_match(&blob,
>   								   f->type,
>   								   f->op,
> @@ -2382,12 +2380,15 @@ int __audit_sockaddr(int len, void *a)
>   void __audit_ptrace(struct task_struct *t)
>   {
>   	struct audit_context *context = audit_context();
> +	struct lsmblob blob;
>   
>   	context->target_pid = task_tgid_nr(t);
>   	context->target_auid = audit_get_loginuid(t);
>   	context->target_uid = task_uid(t);
>   	context->target_sessionid = audit_get_sessionid(t);
> -	security_task_getsecid(t, &context->target_sid);
> +	security_task_getsecid(t, &blob);
> +	/* scaffolding - until target_sid is converted */
> +	context->target_sid = blob.secid[0];
>   	memcpy(context->target_comm, t->comm, TASK_COMM_LEN);
>   }
>   
> @@ -2403,6 +2404,7 @@ int audit_signal_info_syscall(struct task_struct *t)
>   	struct audit_aux_data_pids *axp;
>   	struct audit_context *ctx = audit_context();
>   	kuid_t t_uid = task_uid(t);
> +	struct lsmblob blob;
>   
>   	if (!audit_signals || audit_dummy_context())
>   		return 0;
> @@ -2414,7 +2416,9 @@ int audit_signal_info_syscall(struct task_struct *t)
>   		ctx->target_auid = audit_get_loginuid(t);
>   		ctx->target_uid = t_uid;
>   		ctx->target_sessionid = audit_get_sessionid(t);
> -		security_task_getsecid(t, &ctx->target_sid);
> +		security_task_getsecid(t, &blob);
> +		/* scaffolding until target_sid is converted */
> +		ctx->target_sid = blob.secid[0];
>   		memcpy(ctx->target_comm, t->comm, TASK_COMM_LEN);
>   		return 0;
>   	}
> @@ -2435,7 +2439,9 @@ int audit_signal_info_syscall(struct task_struct *t)
>   	axp->target_auid[axp->pid_count] = audit_get_loginuid(t);
>   	axp->target_uid[axp->pid_count] = t_uid;
>   	axp->target_sessionid[axp->pid_count] = audit_get_sessionid(t);
> -	security_task_getsecid(t, &axp->target_sid[axp->pid_count]);
> +	security_task_getsecid(t, &blob);
> +	/* scaffolding until target_sid is converted */
> +	axp->target_sid[axp->pid_count] = blob.secid[0];
>   	memcpy(axp->target_comm[axp->pid_count], t->comm, TASK_COMM_LEN);
>   	axp->pid_count++;
>   
> diff --git a/net/netlabel/netlabel_unlabeled.c b/net/netlabel/netlabel_unlabeled.c
> index 0cda17cb44a0..e279b81d9545 100644
> --- a/net/netlabel/netlabel_unlabeled.c
> +++ b/net/netlabel/netlabel_unlabeled.c
> @@ -1539,11 +1539,14 @@ int __init netlbl_unlabel_defconf(void)
>   	int ret_val;
>   	struct netlbl_dom_map *entry;
>   	struct netlbl_audit audit_info;
> +	struct lsmblob blob;
>   
>   	/* Only the kernel is allowed to call this function and the only time
>   	 * it is called is at bootup before the audit subsystem is reporting
>   	 * messages so don't worry to much about these values. */
> -	security_task_getsecid(current, &audit_info.secid);
> +	security_task_getsecid(current, &blob);
> +	/* scaffolding until audit_info.secid is converted */
> +	audit_info.secid = blob.secid[0];
>   	audit_info.loginuid = GLOBAL_ROOT_UID;
>   	audit_info.sessionid = 0;
>   
> diff --git a/net/netlabel/netlabel_user.h b/net/netlabel/netlabel_user.h
> index 3c67afce64f1..438b5db6c714 100644
> --- a/net/netlabel/netlabel_user.h
> +++ b/net/netlabel/netlabel_user.h
> @@ -34,7 +34,11 @@
>   static inline void netlbl_netlink_auditinfo(struct sk_buff *skb,
>   					    struct netlbl_audit *audit_info)
>   {
> -	security_task_getsecid(current, &audit_info->secid);
> +	struct lsmblob blob;
> +
> +	security_task_getsecid(current, &blob);
> +	/* scaffolding until secid is converted */
> +	audit_info->secid = blob.secid[0];
>   	audit_info->loginuid = audit_get_loginuid(current);
>   	audit_info->sessionid = audit_get_sessionid(current);
>   }
> diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
> index 300c8d2943c5..37f540af45bb 100644
> --- a/security/integrity/ima/ima_appraise.c
> +++ b/security/integrity/ima/ima_appraise.c
> @@ -48,14 +48,15 @@ bool is_ima_appraise_enabled(void)
>    */
>   int ima_must_appraise(struct inode *inode, int mask, enum ima_hooks func)
>   {
> -	u32 secid;
> +	struct lsmblob blob;
>   
>   	if (!ima_appraise)
>   		return 0;
>   
> -	security_task_getsecid(current, &secid);
> -	return ima_match_policy(inode, current_cred(), secid, func, mask,
> -				IMA_APPRAISE | IMA_HASH, NULL, NULL);
> +	security_task_getsecid(current, &blob);
> +	/* scaffolding the .secid[0] */
> +	return ima_match_policy(inode, current_cred(), blob.secid[0], func,
> +				mask, IMA_APPRAISE | IMA_HASH, NULL, NULL);
>   }
>   
>   static int ima_fix_xattr(struct dentry *dentry,
> diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
> index d7e987baf127..7c4bfc051ebc 100644
> --- a/security/integrity/ima/ima_main.c
> +++ b/security/integrity/ima/ima_main.c
> @@ -384,12 +384,13 @@ static int process_measurement(struct file *file, const struct cred *cred,
>    */
>   int ima_file_mmap(struct file *file, unsigned long prot)
>   {
> -	u32 secid;
> +	struct lsmblob blob;
>   
>   	if (file && (prot & PROT_EXEC)) {
> -		security_task_getsecid(current, &secid);
> -		return process_measurement(file, current_cred(), secid, NULL,
> -					   0, MAY_EXEC, MMAP_CHECK);
> +		security_task_getsecid(current, &blob);
> +		/* scaffolding - until process_measurement changes */
> +		return process_measurement(file, current_cred(), blob.secid[0],
> +					   NULL, 0, MAY_EXEC, MMAP_CHECK);
>   	}
>   
>   	return 0;
> @@ -412,10 +413,12 @@ int ima_bprm_check(struct linux_binprm *bprm)
>   {
>   	int ret;
>   	u32 secid;
> +	struct lsmblob blob;
>   
> -	security_task_getsecid(current, &secid);
> -	ret = process_measurement(bprm->file, current_cred(), secid, NULL, 0,
> -				  MAY_EXEC, BPRM_CHECK);
> +	security_task_getsecid(current, &blob);
> +	/* scaffolding until process_measurement changes */
> +	ret = process_measurement(bprm->file, current_cred(), blob.secid[0],
> +				  NULL, 0, MAY_EXEC, BPRM_CHECK);
>   	if (ret)
>   		return ret;
>   
> @@ -436,10 +439,11 @@ int ima_bprm_check(struct linux_binprm *bprm)
>    */
>   int ima_file_check(struct file *file, int mask)
>   {
> -	u32 secid;
> +	struct lsmblob blob;
>   
> -	security_task_getsecid(current, &secid);
> -	return process_measurement(file, current_cred(), secid, NULL, 0,
> +	security_task_getsecid(current, &blob);
> +	/* scaffolding until process_measurement changes */
> +	return process_measurement(file, current_cred(), blob.secid[0], NULL, 0,
>   				   mask & (MAY_READ | MAY_WRITE | MAY_EXEC |
>   					   MAY_APPEND), FILE_CHECK);
>   }
> @@ -548,7 +552,7 @@ int ima_post_read_file(struct file *file, void *buf, loff_t size,
>   		       enum kernel_read_file_id read_id)
>   {
>   	enum ima_hooks func;
> -	u32 secid;
> +	struct lsmblob blob;
>   
>   	if (!file && read_id == READING_FIRMWARE) {
>   		if ((ima_appraise & IMA_APPRAISE_FIRMWARE) &&
> @@ -570,9 +574,10 @@ int ima_post_read_file(struct file *file, void *buf, loff_t size,
>   	}
>   
>   	func = read_idmap[read_id] ?: FILE_CHECK;
> -	security_task_getsecid(current, &secid);
> -	return process_measurement(file, current_cred(), secid, buf, size,
> -				   MAY_READ, func);
> +	security_task_getsecid(current, &blob);
> +	/* scaffolding until process_measurement changes */
> +	return process_measurement(file, current_cred(), blob.secid[0], buf,
> +				   size, MAY_READ, func);
>   }
>   
>   /**
> @@ -653,7 +658,7 @@ void process_buffer_measurement(const void *buf, int size,
>   	} hash = {};
>   	int violation = 0;
>   	int action = 0;
> -	u32 secid;
> +	struct lsmblob blob;
>   
>   	/*
>   	 * Both LSM hooks and auxilary based buffer measurements are
> @@ -663,9 +668,10 @@ void process_buffer_measurement(const void *buf, int size,
>   	 * buffer measurements.
>   	 */
>   	if (func) {
> -		security_task_getsecid(current, &secid);
> -		action = ima_get_action(NULL, current_cred(), secid, 0, func,
> -					&pcr, &template);
> +		security_task_getsecid(current, &blob);
> +		/* scaffolding */
> +		action = ima_get_action(NULL, current_cred(), blob.secid[0],
> +					0, func, &pcr, &template);
>   		if (!(action & IMA_MEASURE))
>   			return;
>   	}
> diff --git a/security/security.c b/security/security.c
> index 793c4ee0cf4e..7a170c02f8df 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -1700,10 +1700,16 @@ int security_task_getsid(struct task_struct *p)
>   	return call_int_hook(task_getsid, 0, p);
>   }
>   
> -void security_task_getsecid(struct task_struct *p, u32 *secid)
> +void security_task_getsecid(struct task_struct *p, struct lsmblob *blob)
>   {
> -	*secid = 0;
> -	call_void_hook(task_getsecid, p, secid);
> +	struct security_hook_list *hp;
> +
> +	lsmblob_init(blob, 0);
> +	hlist_for_each_entry(hp, &security_hook_heads.task_getsecid, list) {
> +		if (WARN_ON(hp->lsmid->slot < 0 || hp->lsmid->slot >= lsm_slot))
> +			continue;
> +		hp->hook.task_getsecid(p, &blob->secid[hp->lsmid->slot]);
> +	}
>   }
>   EXPORT_SYMBOL(security_task_getsecid);
>   
> 

