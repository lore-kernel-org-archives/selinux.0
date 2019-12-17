Return-Path: <SRS0=4tRG=2H=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5436AC43603
	for <selinux@archiver.kernel.org>; Tue, 17 Dec 2019 18:13:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E62D2067C
	for <selinux@archiver.kernel.org>; Tue, 17 Dec 2019 18:13:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="g69yyY9Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726876AbfLQSN1 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 17 Dec 2019 13:13:27 -0500
Received: from USFB19PA33.eemsg.mail.mil ([214.24.26.196]:42432 "EHLO
        USFB19PA33.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726722AbfLQSN1 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 17 Dec 2019 13:13:27 -0500
X-EEMSG-check-017: 36512435|USFB19PA33_ESA_OUT03.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.69,326,1571702400"; 
   d="scan'208";a="36512435"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by USFB19PA33.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 17 Dec 2019 18:13:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1576606406; x=1608142406;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=zkj/N4LuZqSgZiqkRQqWqUCQ9jcj2eH3uzYsECnjUEg=;
  b=g69yyY9QWWJ1yPnAYD5XAq4k5h8P14afT7pz5cAL/v/oOLceqEIQMyCx
   WGqchEyNaF4imUZDcWj5zb133M17WkcxRTi7aRNBlmMe2R0k5i6QumNmg
   5EGA3bbuc1si2G016msD315eaEpTTjzJNApwS8YblO2/boCdozvdnSSyQ
   qkaPs7pzEHDtFwycKrA5gHEzwKRlNqbc/M8ir/BCpCC7BcvSLVa8wrTZG
   7OsyKbdyrTUhxHCBat13pOw7hIKLcM3s1Y/SNwG9S8OTBo2iWktj97Z/y
   0iXqUKYoe1UwnDmXqhoa9mgXHPZJJJUaTRJBFiMnVZrukKjTYMBfjaBhe
   w==;
X-IronPort-AV: E=Sophos;i="5.69,326,1571702400"; 
   d="scan'208";a="31199077"
IronPort-PHdr: =?us-ascii?q?9a23=3AsCrezhI3SamxD06Y09mcpTZWNBhigK39O0sv0r?=
 =?us-ascii?q?FitYgXLvv/rarrMEGX3/hxlliBBdydt6sfzbCO7Ou5ATNIyK3CmUhKSIZLWR?=
 =?us-ascii?q?4BhJdetC0bK+nBN3fGKuX3ZTcxBsVIWQwt1Xi6NU9IBJS2PAWK8TW94jEIBx?=
 =?us-ascii?q?rwKxd+KPjrFY7OlcS30P2594HObwlSizexfL1/IA+ooQnNtMQajpZuJrozxx?=
 =?us-ascii?q?DUvnZGZuNayH9yK1mOhRj8/MCw/JBi8yRUpf0s8tNLXLv5caolU7FWFSwqPG?=
 =?us-ascii?q?8p6sLlsxnDVhaP6WAHUmoKiBpIAhPK4w/8U5zsryb1rOt92C2dPc3rUbA5XC?=
 =?us-ascii?q?mp4ql3RBP0jioMKiU0+3/LhMNukK1boQqhpx1hzI7SfIGVL+d1cqfEcd8HWW?=
 =?us-ascii?q?ZNQsNdWipPDYOma4sEEvQPM+BWoYLgo1cCtAWyCA2pCO7p1zRGhGL53bci3u?=
 =?us-ascii?q?o8Dw/G0gwuEdEAvnvao9r6NrsdX++uwanUzzjOde9a1Svz5YXKdB0qvPGCXa?=
 =?us-ascii?q?h3ccrU0UQhCh/FgUuIqYzlITyV0PkGvXWe7+V6UeKvj3AoqgFsqTWo3ccjl5?=
 =?us-ascii?q?LJi5kJylHE6Sp5wIE1Kce+SE5ge9GoCpRQtyaEN4ZvRM4pXmJmuD4ix7Ebtp?=
 =?us-ascii?q?O2czIGxZQ6yxLFdfCKfJaE7gj+WOuXPDx2nmhqeKiliBa36UWgz+r8WdSq31?=
 =?us-ascii?q?tStSpFl8XMtmgK1xzO9siLUvt98Vml2TaIzw3T9vtLIVo1larGMJ4t2L8wlp?=
 =?us-ascii?q?wdsUTEBS/5hln5gLWKdkQk5ueo6+Pnbq/gppCALI97lhvyMqEvmsy7Geg4Mw?=
 =?us-ascii?q?4OUHaH+emkybHu8kL0TK9Kg/EriKXVrp/XKdoBqqKkGwNV15ws6xe7Dzeoyt?=
 =?us-ascii?q?QYmnwHIUpeeB2alIjkIE3OIfDkAve/hFSgijFrx+vcMbH7DZXNKWbDnK/7fb?=
 =?us-ascii?q?lh805c1BYzzddH6p1IEL4BO+z8W0/qudzDEhA5Mxa7w/vpCNV5yIweQ3uDDb?=
 =?us-ascii?q?ODP6/IrVCI4ecvKfGWZIAJoDb9N+Ql5/n2gHAlg1AdZrem3JsNZHCjAvtmI1?=
 =?us-ascii?q?+WYWfigtcFD2gKpBEzTO3siF2eTzFTY2y+UL475jE+EIimF5vMRpixgLyd2y?=
 =?us-ascii?q?e2Bp9WZmVBClCWC3fodp6EVuwKaC2IJ89ujD0EWaKmS4872hGkrBX6xKZ/Lu?=
 =?us-ascii?q?rI5i0Ysoru1Nx05+3ViBEz+iV4D9+D3G6RUmF0hGIIRyM23axmpEx9zUqM0b?=
 =?us-ascii?q?V8g/NGDtFT+fxJXRkgNZLGzOx1FcryWgTfcdeNUlqmRc+mAT4pRNIr39AOe1?=
 =?us-ascii?q?p9G8mljh3bxCqlHbsVl72NBJwp/aPRxGbxJ8ljxHbczqUhjEcpQtFJNWK4gq?=
 =?us-ascii?q?5z7Q/TB5TGk0+Bjaalabwc3DLR9GeE1WeOv19XXxBrUarZWnAfYUjWoM/l6U?=
 =?us-ascii?q?PCVb+uDrEnMgpcyc6HMKdKbcfpjVpeTvf5JNvee36xm3u3BRuQxLOMa4rqe2?=
 =?us-ascii?q?MH0CXfD0gEkxoc/XCdNQcgACesuH7RAyZoFVLoZUPs8PVxp2m/TkMu0w6KaE?=
 =?us-ascii?q?hh3aKv+hEJnfycV+8T3rUctSc5tTp0Glm938/XC9qGvgZhf7tTYck74FhZ0W?=
 =?us-ascii?q?LUrA19MoWkL6BlmF4RbR57v1j02BV0F4VAi9IloGkszAVsM66Y0ktBfSuC3Z?=
 =?us-ascii?q?/sIr3XNnXy/Be3Zq7OwF7ezdKW97wX6PsitlXjuBilFk8l83VgydlazWGQ6Y?=
 =?us-ascii?q?nNDAoXAtrNVRMc/gN3tvnhaSk0+o3Q2GckZaK9qTLT88kiBOI4xBKtZZJUOe?=
 =?us-ascii?q?WPEwqkV4URDtOjOaoxkFigcxwAMfp69agoMsfgfPyDnOapOeF6hjO9pWJO5Y?=
 =?us-ascii?q?18lEWW+G40Tu/OwoZA2PyTwxGGSya5iVCtr8T6sZ5LaCtUHWelzyXgQolLae?=
 =?us-ascii?q?k6ZosPCGGzM+WpydhkwZ3gQXhV8BikHVxV9tWufE+pc1Hl3QBWnX8SqHijlD?=
 =?us-ascii?q?rwmyd4iBk1v6Gf22rI2O2kex0ZbD0YDFJ+hEvhdNDnx+sRW1KlOk1wzkqo?=
X-IPAS-Result: =?us-ascii?q?A2AIAABXGvld/wHyM5BlGgEBAQEBAQEBAQMBAQEBEQEBA?=
 =?us-ascii?q?QICAQEBAYFsAwEBAQELAYFzgW0gEiqEBIkDhncGgTeJaooihSiBewkBAQEBA?=
 =?us-ascii?q?QEBAQE3AQGEQAKCPDYHDgIQAQEBBAEBAQEBBQMBAWyFQ4I7KQGCegEFIwQRQ?=
 =?us-ascii?q?RALGAICJgICVwYBDAYCAQGCXz+CUyWuSX8zhU+DQoFIgQ4oAYwxeYEHgTgPg?=
 =?us-ascii?q?l0+h1mCXgSWK2FGlzOCPoJCk0gGG5pJLY4gnE4JKYFYKwgCGAghDzuCbFARF?=
 =?us-ascii?q?I0eF45BIwMwkX0BAQ?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 17 Dec 2019 18:13:23 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id xBHID482161196;
        Tue, 17 Dec 2019 13:13:04 -0500
Subject: Re: [PATCH v12 10/25] LSM: Use lsmblob in security_inode_getsecid
To:     Casey Schaufler <casey@schaufler-ca.com>,
        casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com
References: <20191216223621.5127-1-casey@schaufler-ca.com>
 <20191216223621.5127-11-casey@schaufler-ca.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <c97d5b29-a9a6-2f28-d00a-1b6e6bd3a81b@tycho.nsa.gov>
Date:   Tue, 17 Dec 2019 13:13:44 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191216223621.5127-11-casey@schaufler-ca.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 12/16/19 5:36 PM, Casey Schaufler wrote:
> Change the security_inode_getsecid() interface to fill in a
> lsmblob structure instead of a u32 secid. This allows for its
> callers to gather data from all registered LSMs. Data is provided
> for IMA and audit.
> 
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Reviewed-by: John Johansen <john.johansen@canonical.com>
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> cc: linux-integrity@vger.kernel.org

Did it get an ack from linux-integrity?  Otherwise,
Acked-by: Stephen Smalley <sds@tycho.nsa.gov>

> ---
>   include/linux/security.h            |  7 ++++---
>   kernel/auditsc.c                    |  6 +++++-
>   security/integrity/ima/ima_policy.c |  4 +---
>   security/security.c                 | 11 +++++++++--
>   4 files changed, 19 insertions(+), 9 deletions(-)
> 
> diff --git a/include/linux/security.h b/include/linux/security.h
> index b6d5475f8196..e0acc09a79fe 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -409,7 +409,7 @@ int security_inode_killpriv(struct dentry *dentry);
>   int security_inode_getsecurity(struct inode *inode, const char *name, void **buffer, bool alloc);
>   int security_inode_setsecurity(struct inode *inode, const char *name, const void *value, size_t size, int flags);
>   int security_inode_listsecurity(struct inode *inode, char *buffer, size_t buffer_size);
> -void security_inode_getsecid(struct inode *inode, u32 *secid);
> +void security_inode_getsecid(struct inode *inode, struct lsmblob *blob);
>   int security_inode_copy_up(struct dentry *src, struct cred **new);
>   int security_inode_copy_up_xattr(const char *name);
>   int security_kernfs_init_security(struct kernfs_node *kn_dir,
> @@ -924,9 +924,10 @@ static inline int security_inode_listsecurity(struct inode *inode, char *buffer,
>   	return 0;
>   }
>   
> -static inline void security_inode_getsecid(struct inode *inode, u32 *secid)
> +static inline void security_inode_getsecid(struct inode *inode,
> +					   struct lsmblob *blob)
>   {
> -	*secid = 0;
> +	lsmblob_init(blob, 0);
>   }
>   
>   static inline int security_inode_copy_up(struct dentry *src, struct cred **new)
> diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> index cccb681ad081..5752e51883d5 100644
> --- a/kernel/auditsc.c
> +++ b/kernel/auditsc.c
> @@ -1931,13 +1931,17 @@ static void audit_copy_inode(struct audit_names *name,
>   			     const struct dentry *dentry,
>   			     struct inode *inode, unsigned int flags)
>   {
> +	struct lsmblob blob;
> +
>   	name->ino   = inode->i_ino;
>   	name->dev   = inode->i_sb->s_dev;
>   	name->mode  = inode->i_mode;
>   	name->uid   = inode->i_uid;
>   	name->gid   = inode->i_gid;
>   	name->rdev  = inode->i_rdev;
> -	security_inode_getsecid(inode, &name->osid);
> +	security_inode_getsecid(inode, &blob);
> +	/* scaffolding until osid is updated */
> +	name->osid = blob.secid[0];
>   	if (flags & AUDIT_INODE_NOEVAL) {
>   		name->fcap_ver = -1;
>   		return;
> diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
> index 193ddd55420b..c7d2ea47a326 100644
> --- a/security/integrity/ima/ima_policy.c
> +++ b/security/integrity/ima/ima_policy.c
> @@ -413,7 +413,6 @@ static bool ima_match_rules(struct ima_rule_entry *rule, struct inode *inode,
>   		return false;
>   	for (i = 0; i < MAX_LSM_RULES; i++) {
>   		int rc = 0;
> -		u32 osid;
>   		struct lsmblob blob;
>   
>   		if (!rule->lsm[i].rule)
> @@ -423,8 +422,7 @@ static bool ima_match_rules(struct ima_rule_entry *rule, struct inode *inode,
>   		case LSM_OBJ_USER:
>   		case LSM_OBJ_ROLE:
>   		case LSM_OBJ_TYPE:
> -			security_inode_getsecid(inode, &osid);
> -			lsmblob_init(&blob, osid);
> +			security_inode_getsecid(inode, &blob);
>   			rc = security_filter_rule_match(&blob,
>   							rule->lsm[i].type,
>   							Audit_equal,
> diff --git a/security/security.c b/security/security.c
> index c42573958630..66322a2a2beb 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -1386,9 +1386,16 @@ int security_inode_listsecurity(struct inode *inode, char *buffer, size_t buffer
>   }
>   EXPORT_SYMBOL(security_inode_listsecurity);
>   
> -void security_inode_getsecid(struct inode *inode, u32 *secid)
> +void security_inode_getsecid(struct inode *inode, struct lsmblob *blob)
>   {
> -	call_void_hook(inode_getsecid, inode, secid);
> +	struct security_hook_list *hp;
> +
> +	lsmblob_init(blob, 0);
> +	hlist_for_each_entry(hp, &security_hook_heads.inode_getsecid, list) {
> +		if (WARN_ON(hp->lsmid->slot < 0 || hp->lsmid->slot >= lsm_slot))
> +			continue;
> +		hp->hook.inode_getsecid(inode, &blob->secid[hp->lsmid->slot]);
> +	}
>   }
>   
>   int security_inode_copy_up(struct dentry *src, struct cred **new)
> 

