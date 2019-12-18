Return-Path: <SRS0=xVDs=2I=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCEFCC43603
	for <selinux@archiver.kernel.org>; Wed, 18 Dec 2019 18:02:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EA05206D7
	for <selinux@archiver.kernel.org>; Wed, 18 Dec 2019 18:02:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="dY6/JAcZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726985AbfLRSC1 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 18 Dec 2019 13:02:27 -0500
Received: from USFB19PA35.eemsg.mail.mil ([214.24.26.198]:41754 "EHLO
        USFB19PA35.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726960AbfLRSC1 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 18 Dec 2019 13:02:27 -0500
X-EEMSG-check-017: 37115427|USFB19PA35_ESA_OUT05.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.69,330,1571702400"; 
   d="scan'208";a="37115427"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by USFB19PA35.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 18 Dec 2019 18:02:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1576692143; x=1608228143;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=12yVV6Bk5jdTs6cHZXeXkyhp4Gmu57eo9PkBkcnugxY=;
  b=dY6/JAcZzIAiycaWkcWbf/eswdfbrXdj63e7vven4IX0BYYUX3mM3yDS
   KGiXmg6oFKXu0ARFen7X3HqovoH8p4mU6UVhPLup61fwpwOntYMTpefI/
   nvQvTsIcIethkyKOCM7faOMNp3ja+C6HVRwg5MkUISezuW4a61qQl4F4j
   TDjze7zuRvZxFAJ++KfajUPOJ774GdT0u7phlv0jHuRVMs4SVw14gvZKJ
   Gbi8IPRtMWiZuGQyBTyiGD5F3iIPqckWBGUrPBfuT/e3MQdiQQvSnjhog
   hob1qX5kqLdyEKhHQO0U9ReTqhepNMjTLj5gcMy9ic6a72oIyKjlz+L2x
   g==;
X-IronPort-AV: E=Sophos;i="5.69,330,1571702400"; 
   d="scan'208";a="31245939"
IronPort-PHdr: =?us-ascii?q?9a23=3AzPKLZx+6OJorrf9uRHKM819IXTAuvvDOBiVQ1K?=
 =?us-ascii?q?B+1+0SIJqq85mqBkHD//Il1AaPAdyAragc2qGP6/qocFdDyK7JiGoFfp1IWk?=
 =?us-ascii?q?1NouQttCtkPvS4D1bmJuXhdS0wEZcKflZk+3amLRodQ56mNBXdrXKo8DEdBA?=
 =?us-ascii?q?j0OxZrKeTpAI7SiNm82/yv95HJbAhEmTSwbalsIBmqqQjdudQajZd8Jq0s1h?=
 =?us-ascii?q?bHv3xEdvhMy2h1P1yThRH85smx/J5n7Stdvu8q+tBDX6vnYak2VKRUAzs6PW?=
 =?us-ascii?q?874s3rrgTDQhCU5nQASGUWkwFHDBbD4RrnQ5r+qCr6tu562CmHIc37SK0/VD?=
 =?us-ascii?q?q+46t3ThLjlTwKPCAl/m7JlsNwjbpboBO/qBx5347Ue5yeOP5ncq/AYd8WWW?=
 =?us-ascii?q?9NU8BfWCxbBoO3cpUBAewPM+1Fq4XxvlUDoB+7CQSqGejhyCJHhmXu0KMnze?=
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
 =?us-ascii?q?C01BRogjopqeyZxyWIzOP8IklUclVXTXVv2A+/abO/iMoXCQ3xNFkk?=
X-IPAS-Result: =?us-ascii?q?A2DIAACPaPpd/wHyM5BlGwEBAQEBAQEFAQEBEQEBAwMBA?=
 =?us-ascii?q?QGBfIF2gW0gEiqEBIkDhloGgRIliWqRRQkBAQEBAQEBAQE3AQGEQAKCPTgTA?=
 =?us-ascii?q?hABAQEEAQEBAQEFAwEBbIVDgjspAYJ6AQUjBBFBEAsYAgImAgJXBgEMBgIBA?=
 =?us-ascii?q?YJfP4JTJa4LfzOFT4NEgUGBDiiKeoE4eYEHgREnDAOCLy4+h1mCXgSNQohrY?=
 =?us-ascii?q?UaXNYI/gkOTSgYbmk6EDAGKQZxfIoFYKwgCGAghDzuCbFAYDY0eF45BIwMwj?=
 =?us-ascii?q?y0BAQ?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 18 Dec 2019 18:02:21 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id xBII1u4q066260;
        Wed, 18 Dec 2019 13:01:56 -0500
Subject: Re: [PATCH v12 22/25] Audit: Include object data for all security
 modules
To:     Casey Schaufler <casey@schaufler-ca.com>,
        casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com
References: <20191216223621.5127-1-casey@schaufler-ca.com>
 <20191216223621.5127-23-casey@schaufler-ca.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <2a22d682-3293-d684-dc79-cb2d5aba4610@tycho.nsa.gov>
Date:   Wed, 18 Dec 2019 13:02:35 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191216223621.5127-23-casey@schaufler-ca.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 12/16/19 5:36 PM, Casey Schaufler wrote:
> When there is more than one context displaying security
> module extend what goes into the audit record by supplimenting
> the "obj=" with an "obj_<lsm>=" for each such security
> module.
> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>

Disclaimer: requires ack by audit maintainers.  For me,
Acked-by: Stephen Smalley <sds@tycho.nsa.gov>

> ---
>   kernel/audit.h   |   4 +-
>   kernel/auditsc.c | 110 ++++++++++++++++++++++++-----------------------
>   2 files changed, 58 insertions(+), 56 deletions(-)
> 
> diff --git a/kernel/audit.h b/kernel/audit.h
> index af9bc09e656c..c9f1e1641542 100644
> --- a/kernel/audit.h
> +++ b/kernel/audit.h
> @@ -78,7 +78,7 @@ struct audit_names {
>   	kuid_t			uid;
>   	kgid_t			gid;
>   	dev_t			rdev;
> -	u32			osid;
> +	struct lsmblob		oblob;
>   	struct audit_cap_data	fcap;
>   	unsigned int		fcap_ver;
>   	unsigned char		type;		/* record type */
> @@ -152,7 +152,7 @@ struct audit_context {
>   			kuid_t			uid;
>   			kgid_t			gid;
>   			umode_t			mode;
> -			u32			osid;
> +			struct lsmblob		oblob;
>   			int			has_perm;
>   			uid_t			perm_uid;
>   			gid_t			perm_gid;
> diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> index e0dd643e9b13..0c071947c2b3 100644
> --- a/kernel/auditsc.c
> +++ b/kernel/auditsc.c
> @@ -659,17 +659,15 @@ static int audit_filter_rules(struct task_struct *tsk,
>   			if (f->lsm_rule) {
>   				/* Find files that match */
>   				if (name) {
> -					lsmblob_init(&blob, name->osid);
>   					result = security_audit_rule_match(
> -								&blob,
> +								&name->oblob,
>   								f->type,
>   								f->op,
>   								f->lsm_rule);
>   				} else if (ctx) {
>   					list_for_each_entry(n, &ctx->names_list, list) {
> -						lsmblob_init(&blob, n->osid);
>   						if (security_audit_rule_match(
> -								&blob,
> +								&n->oblob,
>   								f->type,
>   								f->op,
>   								f->lsm_rule)) {
> @@ -681,8 +679,7 @@ static int audit_filter_rules(struct task_struct *tsk,
>   				/* Find ipc objects that match */
>   				if (!ctx || ctx->type != AUDIT_IPC)
>   					break;
> -				lsmblob_init(&blob, ctx->ipc.osid);
> -				if (security_audit_rule_match(&blob,
> +				if (security_audit_rule_match(&ctx->ipc.oblob,
>   							      f->type, f->op,
>   							      f->lsm_rule))
>   					++result;
> @@ -956,13 +953,57 @@ static inline void audit_free_context(struct audit_context *context)
>   	kfree(context);
>   }
>   
> +static int audit_log_object_context(struct audit_buffer *ab,
> +				    struct lsmblob *blob)
> +{
> +	struct lsmcontext context;
> +	const char *lsm;
> +	int i;
> +
> +	/*
> +	 * None of the installed modules have object labels.
> +	 */
> +	if (security_lsm_slot_name(0) == NULL)
> +		return 0;
> +
> +	if (blob->secid[0] != 0) {
> +		if (security_secid_to_secctx(blob, &context, 0)) {
> +			audit_log_format(ab, " obj=?");
> +			return 1;
> +		}
> +		audit_log_format(ab, " obj=%s", context.context);
> +		security_release_secctx(&context);
> +	}
> +
> +	/*
> +	 * Don't do anything more unless there is more than one LSM
> +	 * with a security context to report.
> +	 */
> +	if (security_lsm_slot_name(1) == NULL)
> +		return 0;
> +
> +	for (i = 0; i < LSMBLOB_ENTRIES; i++) {
> +		lsm = security_lsm_slot_name(i);
> +		if (lsm == NULL)
> +			break;
> +		if (blob->secid[i] == 0)
> +			continue;
> +		if (security_secid_to_secctx(blob, &context, i)) {
> +			audit_log_format(ab, " obj_%s=?", lsm);
> +			continue;
> +		}
> +		audit_log_format(ab, " obj_%s=%s", lsm, context.context);
> +		security_release_secctx(&context);
> +	}
> +	return 0;
> +}
> +
>   static int audit_log_pid_context(struct audit_context *context, pid_t pid,
>   				 kuid_t auid, kuid_t uid,
>   				 unsigned int sessionid,
>   				 struct lsmblob *blob, char *comm)
>   {
>   	struct audit_buffer *ab;
> -	struct lsmcontext lsmctx;
>   	int rc = 0;
>   
>   	ab = audit_log_start(context, GFP_KERNEL, AUDIT_OBJ_PID);
> @@ -972,15 +1013,7 @@ static int audit_log_pid_context(struct audit_context *context, pid_t pid,
>   	audit_log_format(ab, "opid=%d oauid=%d ouid=%d oses=%d", pid,
>   			 from_kuid(&init_user_ns, auid),
>   			 from_kuid(&init_user_ns, uid), sessionid);
> -	if (lsmblob_is_set(blob)) {
> -		if (security_secid_to_secctx(blob, &lsmctx, LSMBLOB_FIRST)) {
> -			audit_log_format(ab, " obj=(none)");
> -			rc = 1;
> -		} else {
> -			audit_log_format(ab, " obj=%s", lsmctx.context);
> -			security_release_secctx(&lsmctx);
> -		}
> -	}
> +	rc = audit_log_object_context(ab, blob);
>   	audit_log_format(ab, " ocomm=");
>   	audit_log_untrustedstring(ab, comm);
>   	audit_log_end(ab);
> @@ -1207,26 +1240,14 @@ static void show_special(struct audit_context *context, int *call_panic)
>   				context->socketcall.args[i]);
>   		break; }
>   	case AUDIT_IPC: {
> -		u32 osid = context->ipc.osid;
> +		struct lsmblob *oblob = & context->ipc.oblob;
>   
>   		audit_log_format(ab, "ouid=%u ogid=%u mode=%#ho",
>   				 from_kuid(&init_user_ns, context->ipc.uid),
>   				 from_kgid(&init_user_ns, context->ipc.gid),
>   				 context->ipc.mode);
> -		if (osid) {
> -			struct lsmcontext lsmcxt;
> -			struct lsmblob blob;
> -
> -			lsmblob_init(&blob, osid);
> -			if (security_secid_to_secctx(&blob, &lsmcxt,
> -						     LSMBLOB_FIRST)) {
> -				audit_log_format(ab, " osid=%u", osid);
> -				*call_panic = 1;
> -			} else {
> -				audit_log_format(ab, " obj=%s", lsmcxt.context);
> -				security_release_secctx(&lsmcxt);
> -			}
> -		}
> +		if (audit_log_object_context(ab, oblob))
> +			*call_panic = 1;
>   		if (context->ipc.has_perm) {
>   			audit_log_end(ab);
>   			ab = audit_log_start(context, GFP_KERNEL,
> @@ -1366,20 +1387,8 @@ static void audit_log_name(struct audit_context *context, struct audit_names *n,
>   				 from_kgid(&init_user_ns, n->gid),
>   				 MAJOR(n->rdev),
>   				 MINOR(n->rdev));
> -	if (n->osid != 0) {
> -		struct lsmblob blob;
> -		struct lsmcontext lsmctx;
> -
> -		lsmblob_init(&blob, n->osid);
> -		if (security_secid_to_secctx(&blob, &lsmctx, LSMBLOB_FIRST)) {
> -			audit_log_format(ab, " osid=%u", n->osid);
> -			if (call_panic)
> -				*call_panic = 2;
> -		} else {
> -			audit_log_format(ab, " obj=%s", lsmctx.context);
> -			security_release_secctx(&lsmctx);
> -		}
> -	}
> +	if (audit_log_object_context(ab, &n->oblob) && call_panic)
> +		*call_panic = 2;
>   
>   	/* log the audit_names record type */
>   	switch (n->type) {
> @@ -1929,17 +1938,13 @@ static void audit_copy_inode(struct audit_names *name,
>   			     const struct dentry *dentry,
>   			     struct inode *inode, unsigned int flags)
>   {
> -	struct lsmblob blob;
> -
>   	name->ino   = inode->i_ino;
>   	name->dev   = inode->i_sb->s_dev;
>   	name->mode  = inode->i_mode;
>   	name->uid   = inode->i_uid;
>   	name->gid   = inode->i_gid;
>   	name->rdev  = inode->i_rdev;
> -	security_inode_getsecid(inode, &blob);
> -	/* scaffolding until osid is updated */
> -	name->osid = blob.secid[0];
> +	security_inode_getsecid(inode, &name->oblob);
>   	if (flags & AUDIT_INODE_NOEVAL) {
>   		name->fcap_ver = -1;
>   		return;
> @@ -2285,14 +2290,11 @@ void __audit_mq_getsetattr(mqd_t mqdes, struct mq_attr *mqstat)
>   void __audit_ipc_obj(struct kern_ipc_perm *ipcp)
>   {
>   	struct audit_context *context = audit_context();
> -	struct lsmblob blob;
>   	context->ipc.uid = ipcp->uid;
>   	context->ipc.gid = ipcp->gid;
>   	context->ipc.mode = ipcp->mode;
>   	context->ipc.has_perm = 0;
> -	security_ipc_getsecid(ipcp, &blob);
> -	/* scaffolding on the [0] - change "osid" to a lsmblob */
> -	context->ipc.osid = blob.secid[0];
> +	security_ipc_getsecid(ipcp, &context->ipc.oblob);
>   	context->type = AUDIT_IPC;
>   }
>   
> 

