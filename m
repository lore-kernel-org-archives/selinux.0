Return-Path: <SRS0=4tRG=2H=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F486C43603
	for <selinux@archiver.kernel.org>; Tue, 17 Dec 2019 17:35:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5794E24655
	for <selinux@archiver.kernel.org>; Tue, 17 Dec 2019 17:35:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="VjxplNzf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727145AbfLQRfK (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 17 Dec 2019 12:35:10 -0500
Received: from UCOL19PA34.eemsg.mail.mil ([214.24.24.194]:34711 "EHLO
        UCOL19PA34.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727007AbfLQRfJ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 17 Dec 2019 12:35:09 -0500
X-EEMSG-check-017: 62885468|UCOL19PA34_ESA_OUT01.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.69,326,1571702400"; 
   d="scan'208";a="62885468"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by UCOL19PA34.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 17 Dec 2019 17:34:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1576604088; x=1608140088;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=MOluYw42focxbX2BCsXkt1z1jsGtk7yWU9hCQFem1O8=;
  b=VjxplNzfzixefYv3EwRI/8aecLP7AUHKxrRz5GioH7zaDUhz0bwRPhyc
   6Hhcmvr3izM8SQnoPKZUDqnAljiQe1Oj6hTmX8mFCNeE7Qsoe/hEguDoQ
   gCHRA6o05jnezGmqdzyDuqK+FHdUGhPk0ELUVNBjUt+wqVJ4Yj5N69o2E
   Jvo93MxRrFjnJu/KS9IWDxzOzs/Zdw5m3iutA3wjZA5V0BCZ3UvyiOgWC
   I5Lo8mQinpSJ9gep4RKFAR6caLfPUfRxu3zbrSj2RKaksgJt2LHUQ4OLw
   l9QTAb5d9L78MxF3YZj7AVt8xvO/Sm6L2wttXWHd8gLFjiKdvd7eT08Ag
   A==;
X-IronPort-AV: E=Sophos;i="5.69,326,1571702400"; 
   d="scan'208";a="31196498"
IronPort-PHdr: =?us-ascii?q?9a23=3AxYdDuBPFaDikbUK2w7El6mtUPXoX/o7sNwtQ0K?=
 =?us-ascii?q?IMzox0K/j8psbcNUDSrc9gkEXOFd2Cra4d0KyM6/+rCDxIyK3CmUhKSIZLWR?=
 =?us-ascii?q?4BhJdetC0bK+nBN3fGKuX3ZTcxBsVIWQwt1Xi6NU9IBJS2PAWK8TW94jEIBx?=
 =?us-ascii?q?rwKxd+KPjrFY7OlcS30P2594HObwlSizexfL1/IA+ooQnNtMQajo9vJ6UswR?=
 =?us-ascii?q?bVv3VEfPhby3l1LlyJhRb84cmw/J9n8ytOvv8q6tBNX6bncakmVLJUFDspPX?=
 =?us-ascii?q?w7683trhnDUBCA5mAAXWUMkxpHGBbK4RfnVZrsqCT6t+592C6HPc3qSL0/RD?=
 =?us-ascii?q?qv47t3RBLulSwKLCAy/n3JhcNsjaJbuBOhqAJ5w47Ie4GeKf5ycrrAcd8GWW?=
 =?us-ascii?q?ZNW8BcWCJbAoO4coABEewPM+hFpIX5vlcCsx+zCQyqCejyyDFHm2X20LUn3e?=
 =?us-ascii?q?o/HwHI3A8uEdwAv3vbrtr6KKgcXPupzKTK1zjPc+9a1Dn/5YXObxsvoeuMXb?=
 =?us-ascii?q?V1ccfJ1EcvCx3Kjk2QqYP7OTOey/kDs22B4OpkUeKglW4moBx2rzi028gskZ?=
 =?us-ascii?q?LEhp4Vy1/Y9SV5x5w5JdujSEFhe9KkH5xQtz+DOoZwX8gsQHlotT4nxrAJtp?=
 =?us-ascii?q?O3ZigHxIk9yxLBZPGLbZKE7g/lWe2MOzl3nmhld6i6hxuq9EigzfDzWdes3V?=
 =?us-ascii?q?ZRqypFjsHMtncQ1xzP8sSHSuVy/kOm2TuXywDc8PtEIUEplarAMZIhw7gwlp?=
 =?us-ascii?q?QUsUTYACD5hF/6jLOWd0o4+uio7P7rYrP6qZ+HK4B4kAT+MqUqmsCnAOQ4NB?=
 =?us-ascii?q?YBX3SD9Oih27Du8lf1TbVXgvEsjKXUv47WKd4GqqKhBg9ayIcj6xKxDze819?=
 =?us-ascii?q?QYmGEKLElYdxKclIXpJ1HPL+z4Dfe4mVislixryOrcMr3uBZXNMGDPkK39cr?=
 =?us-ascii?q?Zl905c1A0zwMhD6J1OEbEOPvLyV1TqtNPEDh82KRG0w+jjCNpjzIMSQH6ADb?=
 =?us-ascii?q?WDPKzOtl+I4/olI/OQa48NpDb9N/8l6ubygnAjgl8SY6mo0YEMaH+kHvRpOV?=
 =?us-ascii?q?iZYXTogtgfC2cHpQs+TOr2iFKcVT5ffWq9X6U55jsjEoKpEZ/DRpyxgLyGxC?=
 =?us-ascii?q?q7HJhWZmdcClCWEHfobJ6JW/EWZyKXPMBhkyYIVb+7S48uzRuurhP1y6J7Lu?=
 =?us-ascii?q?rI/S0VrZbj1Nlz5+3OmhA+7Cd0ANqB3GGQVWF0n38IRj8v0KB6pkxy10qD0a?=
 =?us-ascii?q?xmjPFDC9xT6O1GUh0gOZ7f0eN6EdbyVRzFftuTT1amWNqmCykrTt0t298Of1?=
 =?us-ascii?q?p9G9K6gxDYwSWqB74Vl7qWBJ076a/cwXfxKNhny3rc16kukUMmQs1ROm2inK?=
 =?us-ascii?q?J/8BLTB4HRmUWDi6mqbbgc3DLK9GqbzmqBol9XUBVsXqXCWnAfZVDbosj55k?=
 =?us-ascii?q?PYSL+uDLUnMhZEycKYLatKcNLph01cRPj/INTef36xm2CoCBaKwbOMbIzqd3?=
 =?us-ascii?q?8f3CXaCEgLiQYT/W2YOgg4HSquv3jRDDppFVLpYkPj7fNxqHehQkAoyAGKal?=
 =?us-ascii?q?Vr16Cp9R4NmfycV/QT06ocuCg/rTV0E0u939PQC9aZpApuYr9cYdUj71dDzm?=
 =?us-ascii?q?/ZthVxPpinL6B8mFESaR93sFnt1xVqEIVPi9ImrHU0wwZoK6KYyEtLdymE0p?=
 =?us-ascii?q?DoJr3XNm7y8Qi3a6HMx1He1M2b+r8V5/Qlr1XvpQSpFk0l83V9zdZZyWeT5p?=
 =?us-ascii?q?LPDFlabZWkeU8s+gkynLraazQz447OnSlnOLK5oxfZ0NIgGeUhxwzldN4ZO6?=
 =?us-ascii?q?SBQku6GMQBCtnoM+cqkkWnah8eFOFU6KMwecihcr/O2qusJvxhhxqghGFK4c?=
 =?us-ascii?q?Z6yE3Ivy59TPPYmo0IyOyC3xeWEjL7gEqlv+jplo1eIzIfBGyyzW7jHoEVLr?=
 =?us-ascii?q?Z/eYcNFHeGPcK63JN9ioTrVnoe80SsVH0c38r8Qgafd1zw20Vr0E0TpXG20X?=
 =?us-ascii?q?+jwydcjyAirq3Z2jfHhevlakxUaSZwWGB+gAK0csCPhNcAUR3tNlJ4mQ=3D?=
 =?us-ascii?q?=3D?=
X-IPAS-Result: =?us-ascii?q?A2AxAAAoEfld/wHyM5BlGwEBAQEBAQEFAQEBEQEBAwMBA?=
 =?us-ascii?q?QGBbQMBAQELAYFzgW0gEiqEBIkDhnQEBoESJYlqiiKHIwkBAQEBAQEBAQE3A?=
 =?us-ascii?q?QGEQAKCPDcGDgIQAQEBBAEBAQEBBQMBAWyFQ4I7KQGCegEFIwQRQRALGAICJ?=
 =?us-ascii?q?gICVwYBDAYCAQGCXz+CUyWuN38zhU+DPoFIgQ4oAYwxeYEHgTgMA4JdPodZg?=
 =?us-ascii?q?l4ElithRpczgj6CQpNIBhuaSS2OIJxdI4FYKwgCGAghDzuCbFARFI0eF45BI?=
 =?us-ascii?q?wMwjz8qghcBAQ?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 17 Dec 2019 17:34:47 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id xBHHYK2B142338;
        Tue, 17 Dec 2019 12:34:27 -0500
Subject: Re: [PATCH v12 03/25] LSM: Use lsmblob in security_audit_rule_match
To:     Casey Schaufler <casey@schaufler-ca.com>,
        casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com
References: <20191216223621.5127-1-casey@schaufler-ca.com>
 <20191216223621.5127-4-casey@schaufler-ca.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <5d2d0621-5156-28af-7c08-0f9daac6ea6e@tycho.nsa.gov>
Date:   Tue, 17 Dec 2019 12:34:59 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191216223621.5127-4-casey@schaufler-ca.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 12/16/19 5:35 PM, Casey Schaufler wrote:
> Change the secid parameter of security_audit_rule_match
> to a lsmblob structure pointer. Pass the entry from the
> lsmblob structure for the approprite slot to the LSM hook.
> 
> Change the users of security_audit_rule_match to use the
> lsmblob instead of a u32. In some cases this requires a
> temporary conversion using lsmblob_init() that will go
> away when other interfaces get converted.
> 
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Reviewed-by: John Johansen <john.johansen@canonical.com>
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>   include/linux/security.h            |  7 ++++---
>   kernel/auditfilter.c                |  7 +++++--
>   kernel/auditsc.c                    | 14 ++++++++++----
>   security/integrity/ima/ima.h        |  4 ++--
>   security/integrity/ima/ima_policy.c |  7 +++++--
>   security/security.c                 | 18 +++++++++++++++---
>   6 files changed, 41 insertions(+), 16 deletions(-)
> 
> diff --git a/include/linux/security.h b/include/linux/security.h
> index b74dc70088ca..9c6dbe248eaf 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -1837,7 +1837,8 @@ static inline int security_key_getsecurity(struct key *key, char **_buffer)
>   #ifdef CONFIG_SECURITY
>   int security_audit_rule_init(u32 field, u32 op, char *rulestr, void **lsmrule);
>   int security_audit_rule_known(struct audit_krule *krule);
> -int security_audit_rule_match(u32 secid, u32 field, u32 op, void *lsmrule);
> +int security_audit_rule_match(struct lsmblob *blob, u32 field, u32 op,
> +			      void *lsmrule);
>   void security_audit_rule_free(void *lsmrule);
>   
>   #else
> @@ -1853,8 +1854,8 @@ static inline int security_audit_rule_known(struct audit_krule *krule)
>   	return 0;
>   }
>   
> -static inline int security_audit_rule_match(u32 secid, u32 field, u32 op,
> -					    void *lsmrule)
> +static inline int security_audit_rule_match(struct lsmblob *blob, u32 field,
> +					    u32 op, void *lsmrule)
>   {
>   	return 0;
>   }
> diff --git a/kernel/auditfilter.c b/kernel/auditfilter.c
> index b0126e9c0743..356db1dd276c 100644
> --- a/kernel/auditfilter.c
> +++ b/kernel/auditfilter.c
> @@ -1325,6 +1325,7 @@ int audit_filter(int msgtype, unsigned int listtype)
>   			struct audit_field *f = &e->rule.fields[i];
>   			pid_t pid;
>   			u32 sid;
> +			struct lsmblob blob;
>   
>   			switch (f->type) {
>   			case AUDIT_PID:
> @@ -1355,8 +1356,10 @@ int audit_filter(int msgtype, unsigned int listtype)
>   			case AUDIT_SUBJ_CLR:
>   				if (f->lsm_rule) {
>   					security_task_getsecid(current, &sid);
> -					result = security_audit_rule_match(sid,
> -						   f->type, f->op, f->lsm_rule);
> +					lsmblob_init(&blob, sid);
> +					result = security_audit_rule_match(
> +							&blob, f->type,
> +							f->op, f->lsm_rule);
>   				}
>   				break;
>   			case AUDIT_EXE:
> diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> index 4effe01ebbe2..7566e5b1c419 100644
> --- a/kernel/auditsc.c
> +++ b/kernel/auditsc.c
> @@ -445,6 +445,7 @@ static int audit_filter_rules(struct task_struct *tsk,
>   	const struct cred *cred;
>   	int i, need_sid = 1;
>   	u32 sid;
> +	struct lsmblob blob;
>   	unsigned int sessionid;
>   
>   	cred = rcu_dereference_check(tsk->cred, tsk == current || task_creation);
> @@ -643,7 +644,9 @@ static int audit_filter_rules(struct task_struct *tsk,
>   					security_task_getsecid(tsk, &sid);
>   					need_sid = 0;
>   				}
> -				result = security_audit_rule_match(sid, f->type,
> +				lsmblob_init(&blob, sid);
> +				result = security_audit_rule_match(&blob,
> +								   f->type,
>   								   f->op,
>   								   f->lsm_rule);
>   			}
> @@ -658,15 +661,17 @@ static int audit_filter_rules(struct task_struct *tsk,
>   			if (f->lsm_rule) {
>   				/* Find files that match */
>   				if (name) {
> +					lsmblob_init(&blob, name->osid);
>   					result = security_audit_rule_match(
> -								name->osid,
> +								&blob,
>   								f->type,
>   								f->op,
>   								f->lsm_rule);
>   				} else if (ctx) {
>   					list_for_each_entry(n, &ctx->names_list, list) {
> +						lsmblob_init(&blob, n->osid);
>   						if (security_audit_rule_match(
> -								n->osid,
> +								&blob,
>   								f->type,
>   								f->op,
>   								f->lsm_rule)) {
> @@ -678,7 +683,8 @@ static int audit_filter_rules(struct task_struct *tsk,
>   				/* Find ipc objects that match */
>   				if (!ctx || ctx->type != AUDIT_IPC)
>   					break;
> -				if (security_audit_rule_match(ctx->ipc.osid,
> +				lsmblob_init(&blob, ctx->ipc.osid);
> +				if (security_audit_rule_match(&blob,
>   							      f->type, f->op,
>   							      f->lsm_rule))
>   					++result;
> diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
> index df4ca482fb53..d95b0ece7434 100644
> --- a/security/integrity/ima/ima.h
> +++ b/security/integrity/ima/ima.h
> @@ -381,8 +381,8 @@ static inline int security_filter_rule_init(u32 field, u32 op, char *rulestr,
>   	return -EINVAL;
>   }
>   
> -static inline int security_filter_rule_match(u32 secid, u32 field, u32 op,
> -					     void *lsmrule)
> +static inline int security_filter_rule_match(struct lsmblob *blob, u32 field,
> +					     u32 op, void *lsmrule)
>   {
>   	return -EINVAL;
>   }
> diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
> index f19a895ad7cd..193ddd55420b 100644
> --- a/security/integrity/ima/ima_policy.c
> +++ b/security/integrity/ima/ima_policy.c
> @@ -414,6 +414,7 @@ static bool ima_match_rules(struct ima_rule_entry *rule, struct inode *inode,
>   	for (i = 0; i < MAX_LSM_RULES; i++) {
>   		int rc = 0;
>   		u32 osid;
> +		struct lsmblob blob;
>   
>   		if (!rule->lsm[i].rule)
>   			continue;
> @@ -423,7 +424,8 @@ static bool ima_match_rules(struct ima_rule_entry *rule, struct inode *inode,
>   		case LSM_OBJ_ROLE:
>   		case LSM_OBJ_TYPE:
>   			security_inode_getsecid(inode, &osid);
> -			rc = security_filter_rule_match(osid,
> +			lsmblob_init(&blob, osid);
> +			rc = security_filter_rule_match(&blob,
>   							rule->lsm[i].type,
>   							Audit_equal,
>   							rule->lsm[i].rule);
> @@ -431,7 +433,8 @@ static bool ima_match_rules(struct ima_rule_entry *rule, struct inode *inode,
>   		case LSM_SUBJ_USER:
>   		case LSM_SUBJ_ROLE:
>   		case LSM_SUBJ_TYPE:
> -			rc = security_filter_rule_match(secid,
> +			lsmblob_init(&blob, secid);
> +			rc = security_filter_rule_match(&blob,
>   							rule->lsm[i].type,
>   							Audit_equal,
>   							rule->lsm[i].rule);
> diff --git a/security/security.c b/security/security.c
> index a89634af639a..bfea9739c084 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -439,7 +439,7 @@ static int lsm_append(const char *new, char **result)
>   /*
>    * Current index to use while initializing the lsmblob secid list.
>    */
> -static int lsm_slot __initdata;
> +static int lsm_slot __lsm_ro_after_init;
>   
>   /**
>    * security_add_hooks - Add a modules hooks to the hook lists.
> @@ -2412,9 +2412,21 @@ void security_audit_rule_free(void *lsmrule)
>   	call_void_hook(audit_rule_free, lsmrule);
>   }
>   
> -int security_audit_rule_match(u32 secid, u32 field, u32 op, void *lsmrule)
> +int security_audit_rule_match(struct lsmblob *blob, u32 field, u32 op,
> +			      void *lsmrule)
>   {
> -	return call_int_hook(audit_rule_match, 0, secid, field, op, lsmrule);
> +	struct security_hook_list *hp;
> +	int rc;
> +
> +	hlist_for_each_entry(hp, &security_hook_heads.audit_rule_match, list) {
> +		if (WARN_ON(hp->lsmid->slot < 0 || hp->lsmid->slot >= lsm_slot))
> +			continue;

Do you think we really need to retain these WARN_ON()s?  If not, then 
you could dispense with it now and leave lsm_slot as __initdata?  Otherwise,
Acked-by: Stephen Smalley <sds@tycho.nsa.gov>

> +		rc = hp->hook.audit_rule_match(blob->secid[hp->lsmid->slot],
> +					       field, op, lsmrule);
> +		if (rc != 0)
> +			return rc;
> +	}
> +	return 0;
>   }
>   #endif /* CONFIG_AUDIT */
>   
> 

