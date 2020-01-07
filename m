Return-Path: <SRS0=B3ih=24=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA8E4C33C8C
	for <selinux@archiver.kernel.org>; Tue,  7 Jan 2020 14:44:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95AD020715
	for <selinux@archiver.kernel.org>; Tue,  7 Jan 2020 14:44:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="oMATW3sW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727959AbgAGOom (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 7 Jan 2020 09:44:42 -0500
Received: from USFB19PA34.eemsg.mail.mil ([214.24.26.197]:21540 "EHLO
        USFB19PA34.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726937AbgAGOom (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 7 Jan 2020 09:44:42 -0500
X-EEMSG-check-017: 41874277|USFB19PA34_ESA_OUT04.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.69,406,1571702400"; 
   d="scan'208";a="41874277"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by USFB19PA34.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 07 Jan 2020 14:44:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1578408279; x=1609944279;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=mKvXUZFjULvHcoP3H1r9CMCEDhwoaWNBT9xuUWbq0rs=;
  b=oMATW3sWp6UaQeAhnGrAe2ObTwa4A+j5lW3V9sqZrmLg9P/a0e+YG9IJ
   VwnBqDr1GtS4QW9fhrKtYT4piAZg2YqSvEIvGhljyeu0gutKqewaetzg7
   TPRIkTOVGHptRMrloBx09cu9MeP1bmQtP2mCZehco02Hl1Q7ZVEAP79FT
   eGyArAMULBv5gOhtcxKW4eXvyluyJOceagfc4EE90xsAofQwpz0ZH7ujK
   HxR6Bcx6UrfroKEwldX4jQVTTnSelFAC0R/YeLLIoVolG3WBdPbBmxc73
   jlEzNDSEcOv/zE1RL+JRkf0H7GStsZwI9xpi830Qw3yOLvSK+cTefEV0U
   A==;
X-IronPort-AV: E=Sophos;i="5.69,406,1571702400"; 
   d="scan'208";a="37430879"
IronPort-PHdr: =?us-ascii?q?9a23=3A6vp+ABRVvjMQKTwxU5vUyW/Sntpsv+yvbD5Q0Y?=
 =?us-ascii?q?Iujvd0So/mwa67YRKGt8tkgFKBZ4jH8fUM07OQ7/m7HzZdvd3Y4TgrS99lb1?=
 =?us-ascii?q?c9k8IYnggtUoauKHbQC7rUVRE8B9lIT1R//nu2YgB/Ecf6YEDO8DXptWZBUh?=
 =?us-ascii?q?rwOhBoKevrB4Xck9q41/yo+53Ufg5EmCexbal9IRmrowjdrNcajIttJ6o+1x?=
 =?us-ascii?q?fEpmZDdvhLy29vOV+dhQv36N2q/J5k/SRQuvYh+NBFXK7nYak2TqFWASo/PW?=
 =?us-ascii?q?wt68LlqRfMTQ2U5nsBSWoWiQZHAxLE7B7hQJj8tDbxu/dn1ymbOc32Sq00WS?=
 =?us-ascii?q?in4qx2RhLklDsLOjgk+2zMlMd+kLxUrw6gpxxnwo7bfoeVNOZlfqjAed8WXH?=
 =?us-ascii?q?dNUtpNWyBEBI6zYZEPD+4cNuhGqYfzqUYFoR+nCQSiAO7jzzlFjWL006Inye?=
 =?us-ascii?q?QsCRzI0hIuH9wOs3raotv6O6gQXu+pw6fF1inDYvFM1Dvh9ITFfBIsrPeRVr?=
 =?us-ascii?q?xwa8rRzkwvGhvYgFWMt4PlJzOV2foLs2OG8uRgUPigi2ojqw5vojmk28Ahip?=
 =?us-ascii?q?LUiYIO0V3E6SV4z5o1Jd2/UkJ7Z8WkH4FKuyGVMIt2XNovTmd1syg50r0LoY?=
 =?us-ascii?q?O3cScFxZg9xxPTduaLf5aH7x79TuqdPDF1j29/dr2lnRa9602gx/X5VsmzzV?=
 =?us-ascii?q?lFsDJIksLJtnARzxzT7dWHSudl8kehxzmP0wfT5/lYIU8uj6rbKoMhwqUqmp?=
 =?us-ascii?q?oSt0TDECj2mF7og6CKbEkk5uip5PjnYrXhvJOcMZN7ihriPag0n8y/AOA4Ph?=
 =?us-ascii?q?APX2id5+u8yKXu8VD2TbhFlPE7krTVvIrEKckUuKK1GRJZ3p4m6xmlDjem1N?=
 =?us-ascii?q?oYnWMALFJAYB+HlJXmO0rVLfDkDfawn1SskDBxy/DAJb3uGI/BLnfEkLf/Zb?=
 =?us-ascii?q?p98VJTyBIvzdBD4JJZErYBIPf0Wk/qstzXFAM2PBKvzub9Ftpyy4MeVniTAq?=
 =?us-ascii?q?ODLKzStlqI7Po1I+aQfI8VpCr9K/896v7qjH85n0IdfKaw0ZsMdn+3AulmI1?=
 =?us-ascii?q?+YYXrwgtYNCGIKvg0jQ+z3jF2NTyVeZ2i9X60i/DE3EoGmApnZRoCrnrOB2D?=
 =?us-ascii?q?23HppMZmBJElqMC2vnd52YW/cQbyKfOs1hkjkDVbi7UY8h1AquuRT8y7V9K+?=
 =?us-ascii?q?rb5CwYuYjk1Nhv6O3ZjQsy+iBsD8SBz2GNSHl5nngWSD8s06Bwv1dwyleZ3q?=
 =?us-ascii?q?h8h/xZFdpT6+lVXQc9MJ7W1/Z6BMzqWgLdYteJT06rTcm8DjEqUN0ww8QDY1?=
 =?us-ascii?q?1hFNWilB/DwiSqA7sLmLyRHZA77rjT02LtKMZ6znbMzLMhgEU+QstTKW2mgb?=
 =?us-ascii?q?Zy9xPNCI7NkkWZkbuqdKsH0S7T+2eM03COsFtbUAFuS6XFW24QZk/ModT+/E?=
 =?us-ascii?q?PCQKekCa47PQtZ1c6CNqxKZ8XxjVpcWffjPM/TY3qrlGetARaE37aMbI3te2?=
 =?us-ascii?q?UHwirRElQLkwcW/XyeLwgxGj+ho37CDDxpDV/vYUTs8el4qH+hTE80yAGKYF?=
 =?us-ascii?q?dn17qu5BEVg+eRRO8J0bICvychrTR0E0qn0NLSEdaPuw1hfKBEa9Mn/FhHzX?=
 =?us-ascii?q?7ZtxB6PpG4LKBtmEARcx9rsEPp0BV3CZ5NntQqrHMwywpyLKOY0E5Edz+C2p?=
 =?us-ascii?q?DwILLXIHHo/B+zc67Wxk3e0NGO96cK7/Q4sUnjvAavFkon6Hhoz9lV02Gb5p?=
 =?us-ascii?q?XPDQoSTJfxXlww9xhgqLHQejM96J/M1X1wLam0tSfP28o3C+sjxRagYtZfMK?=
 =?us-ascii?q?WdGA/xDcIaHc6uJ/Ium1WybxIIJeRS9KkqP8y4bfeGw7SkPOV9nDK8l2tL+o?=
 =?us-ascii?q?Z93VyW+yp+Uu6bl6oCltae0hGKVX/Zi0ynu8v6msgQYjQVBWy2wiXMHoNdZq?=
 =?us-ascii?q?RuO40MDDHqa8m2wMhuwoXgUGNC9UKyQlYB1NKtdDKMYFHnmw5dz0IapTqggy?=
 =?us-ascii?q?T8hx59ljwy5o+YxjbP2Ky2dh8AIHRKX0FkhFLhIM6zld9MGADiVAUzmxbtyA?=
 =?us-ascii?q?Cy56FfoLV5ZSGHWkpScCXeL2hmVrq28LGFZpgcxokvtHBsTOmkYV2cAoX4qh?=
 =?us-ascii?q?8e3jKrS3BS3xgnZjqqvdP/hBU8h2WDeiUg5EHFcN19kE+MrOfXQuRci39fH3?=
 =?us-ascii?q?h1?=
X-IPAS-Result: =?us-ascii?q?A2AwAQBRlBRe/wHyM5BmGwEBAQEBAQEFAQEBEQEBAwMBA?=
 =?us-ascii?q?QGBfIF9gW0gEiqECYkDhmoGgRIliW6PYYFnCQEBAQEBAQEBATcBAYRAAoINO?=
 =?us-ascii?q?BMCEAEBAQQBAQEBAQUDAQFshUOCOykBgnoBBSMEEUEQCw4KAgImAgJXBgEMB?=
 =?us-ascii?q?gIBAYJfP4JTJaxLfzOFT4MwgT2BDiiMM3mBB4ERJwwDgl0+hDGDKIJeBI0oJ?=
 =?us-ascii?q?II4hjRhRpdAgkCCRZNRBhuaX45TnHIigVgrCAIYCCEPgydQGA2NHheOQSMDM?=
 =?us-ascii?q?IwcJwaCFAEB?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 07 Jan 2020 14:44:36 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id 007EhwtZ086523;
        Tue, 7 Jan 2020 09:43:59 -0500
Subject: Re: [PATCH 1/2] selinux: treat atomic flags more carefully
To:     Ondrej Mosnacek <omosnace@redhat.com>,
        linux-security-module@vger.kernel.org,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>
Cc:     Casey Schaufler <casey@schaufler-ca.com>, selinux@vger.kernel.org,
        Paul Moore <paul@paul-moore.com>,
        John Johansen <john.johansen@canonical.com>,
        Kees Cook <keescook@chromium.org>,
        Micah Morton <mortonm@chromium.org>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
References: <20200107133154.588958-1-omosnace@redhat.com>
 <20200107133154.588958-2-omosnace@redhat.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <3cd598e0-4e47-3839-ab8d-c35ed141f2cf@tycho.nsa.gov>
Date:   Tue, 7 Jan 2020 09:45:13 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200107133154.588958-2-omosnace@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 1/7/20 8:31 AM, Ondrej Mosnacek wrote:
> The disabled/enforcing/initialized flags are all accessed concurrently
> by threads so use the appropriate accessors that ensure atomicity and
> document that it is expected.
> 
> Use smp_load/acquire...() helpers (with memory barriers) for the
> initialized flag, since it gates access to the rest of the state
> structures.
> 
> Note that the disabled flag is currently not used for anything other
> than avoiding double disable, but it will be used for bailing out of
> hooks once security_delete_hooks() is removed.
> 
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>

This looks good to me as a cleanup regardless of whether the 2nd patch 
is merged.  Similar treatment is likely needed for state->checkreqprot 
(although I'd like to obsolete and get rid of that entirely at some 
point), maybe state->policycap[], isec->initialized, and others, but 
that can all be done separately.

Acked-by: Stephen Smalley <sds@tycho.nsa.gov>

> ---
>   security/selinux/hooks.c            | 21 ++++++++--------
>   security/selinux/include/security.h | 33 +++++++++++++++++++++++--
>   security/selinux/ss/services.c      | 38 ++++++++++++++---------------
>   3 files changed, 61 insertions(+), 31 deletions(-)
> 
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 659c4a81e897..47ad4db925cf 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -272,7 +272,7 @@ static int __inode_security_revalidate(struct inode *inode,
>   
>   	might_sleep_if(may_sleep);
>   
> -	if (selinux_state.initialized &&
> +	if (selinux_initialized(&selinux_state) &&
>   	    isec->initialized != LABEL_INITIALIZED) {
>   		if (!may_sleep)
>   			return -ECHILD;
> @@ -659,7 +659,7 @@ static int selinux_set_mnt_opts(struct super_block *sb,
>   
>   	mutex_lock(&sbsec->lock);
>   
> -	if (!selinux_state.initialized) {
> +	if (!selinux_initialized(&selinux_state)) {
>   		if (!opts) {
>   			/* Defer initialization until selinux_complete_init,
>   			   after the initial policy is loaded and the security
> @@ -928,7 +928,7 @@ static int selinux_sb_clone_mnt_opts(const struct super_block *oldsb,
>   	 * if the parent was able to be mounted it clearly had no special lsm
>   	 * mount options.  thus we can safely deal with this superblock later
>   	 */
> -	if (!selinux_state.initialized)
> +	if (!selinux_initialized(&selinux_state))
>   		return 0;
>   
>   	/*
> @@ -1103,7 +1103,7 @@ static int selinux_sb_show_options(struct seq_file *m, struct super_block *sb)
>   	if (!(sbsec->flags & SE_SBINITIALIZED))
>   		return 0;
>   
> -	if (!selinux_state.initialized)
> +	if (!selinux_initialized(&selinux_state))
>   		return 0;
>   
>   	if (sbsec->flags & FSCONTEXT_MNT) {
> @@ -2920,7 +2920,8 @@ static int selinux_inode_init_security(struct inode *inode, struct inode *dir,
>   		isec->initialized = LABEL_INITIALIZED;
>   	}
>   
> -	if (!selinux_state.initialized || !(sbsec->flags & SBLABEL_MNT))
> +	if (!selinux_initialized(&selinux_state) ||
> +	    !(sbsec->flags & SBLABEL_MNT))
>   		return -EOPNOTSUPP;
>   
>   	if (name)
> @@ -3143,7 +3144,7 @@ static int selinux_inode_setxattr(struct dentry *dentry, const char *name,
>   		return dentry_has_perm(current_cred(), dentry, FILE__SETATTR);
>   	}
>   
> -	if (!selinux_state.initialized)
> +	if (!selinux_initialized(&selinux_state))
>   		return (inode_owner_or_capable(inode) ? 0 : -EPERM);
>   
>   	sbsec = inode->i_sb->s_security;
> @@ -3229,7 +3230,7 @@ static void selinux_inode_post_setxattr(struct dentry *dentry, const char *name,
>   		return;
>   	}
>   
> -	if (!selinux_state.initialized) {
> +	if (!selinux_initialized(&selinux_state)) {
>   		/* If we haven't even been initialized, then we can't validate
>   		 * against a policy, so leave the label as invalid. It may
>   		 * resolve to a valid label on the next revalidation try if
> @@ -7304,17 +7305,17 @@ static void selinux_nf_ip_exit(void)
>   #ifdef CONFIG_SECURITY_SELINUX_DISABLE
>   int selinux_disable(struct selinux_state *state)
>   {
> -	if (state->initialized) {
> +	if (selinux_initialized(state)) {
>   		/* Not permitted after initial policy load. */
>   		return -EINVAL;
>   	}
>   
> -	if (state->disabled) {
> +	if (selinux_disabled(state)) {
>   		/* Only do this once. */
>   		return -EINVAL;
>   	}
>   
> -	state->disabled = 1;
> +	selinux_mark_disabled(state);
>   
>   	pr_info("SELinux:  Disabled at runtime.\n");
>   
> diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
> index ecdd610e6449..a39f9565d80b 100644
> --- a/security/selinux/include/security.h
> +++ b/security/selinux/include/security.h
> @@ -117,15 +117,27 @@ void selinux_avc_init(struct selinux_avc **avc);
>   
>   extern struct selinux_state selinux_state;
>   
> +static inline bool selinux_initialized(const struct selinux_state *state)
> +{
> +	/* do a synchronized load to avoid race conditions */
> +	return smp_load_acquire(&state->initialized);
> +}
> +
> +static inline void selinux_mark_initialized(struct selinux_state *state)
> +{
> +	/* do a synchronized write to avoid race conditions */
> +	smp_store_release(&state->initialized, true);
> +}
> +
>   #ifdef CONFIG_SECURITY_SELINUX_DEVELOP
>   static inline bool enforcing_enabled(struct selinux_state *state)
>   {
> -	return state->enforcing;
> +	return READ_ONCE(state->enforcing);
>   }
>   
>   static inline void enforcing_set(struct selinux_state *state, bool value)
>   {
> -	state->enforcing = value;
> +	WRITE_ONCE(state->enforcing, value);
>   }
>   #else
>   static inline bool enforcing_enabled(struct selinux_state *state)
> @@ -138,6 +150,23 @@ static inline void enforcing_set(struct selinux_state *state, bool value)
>   }
>   #endif
>   
> +#ifdef CONFIG_SECURITY_SELINUX_DISABLE
> +static inline bool selinux_disabled(struct selinux_state *state)
> +{
> +	return READ_ONCE(state->disabled);
> +}
> +
> +static inline void selinux_mark_disabled(struct selinux_state *state)
> +{
> +	WRITE_ONCE(state->disabled, true);
> +}
> +#else
> +static inline bool selinux_disabled(struct selinux_state *state)
> +{
> +	return false;
> +}
> +#endif
> +
>   static inline bool selinux_policycap_netpeer(void)
>   {
>   	struct selinux_state *state = &selinux_state;
> diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
> index 55cf42945cba..0e8b94e8e156 100644
> --- a/security/selinux/ss/services.c
> +++ b/security/selinux/ss/services.c
> @@ -767,7 +767,7 @@ static int security_compute_validatetrans(struct selinux_state *state,
>   	int rc = 0;
>   
>   
> -	if (!state->initialized)
> +	if (!selinux_initialized(state))
>   		return 0;
>   
>   	read_lock(&state->ss->policy_rwlock);
> @@ -868,7 +868,7 @@ int security_bounded_transition(struct selinux_state *state,
>   	int index;
>   	int rc;
>   
> -	if (!state->initialized)
> +	if (!selinux_initialized(state))
>   		return 0;
>   
>   	read_lock(&state->ss->policy_rwlock);
> @@ -1027,7 +1027,7 @@ void security_compute_xperms_decision(struct selinux_state *state,
>   	memset(xpermd->dontaudit->p, 0, sizeof(xpermd->dontaudit->p));
>   
>   	read_lock(&state->ss->policy_rwlock);
> -	if (!state->initialized)
> +	if (!selinux_initialized(state))
>   		goto allow;
>   
>   	policydb = &state->ss->policydb;
> @@ -1112,7 +1112,7 @@ void security_compute_av(struct selinux_state *state,
>   	read_lock(&state->ss->policy_rwlock);
>   	avd_init(state, avd);
>   	xperms->len = 0;
> -	if (!state->initialized)
> +	if (!selinux_initialized(state))
>   		goto allow;
>   
>   	policydb = &state->ss->policydb;
> @@ -1166,7 +1166,7 @@ void security_compute_av_user(struct selinux_state *state,
>   
>   	read_lock(&state->ss->policy_rwlock);
>   	avd_init(state, avd);
> -	if (!state->initialized)
> +	if (!selinux_initialized(state))
>   		goto allow;
>   
>   	policydb = &state->ss->policydb;
> @@ -1286,7 +1286,7 @@ int security_sidtab_hash_stats(struct selinux_state *state, char *page)
>   {
>   	int rc;
>   
> -	if (!state->initialized) {
> +	if (!selinux_initialized(state)) {
>   		pr_err("SELinux: %s:  called before initial load_policy\n",
>   		       __func__);
>   		return -EINVAL;
> @@ -1320,7 +1320,7 @@ static int security_sid_to_context_core(struct selinux_state *state,
>   		*scontext = NULL;
>   	*scontext_len  = 0;
>   
> -	if (!state->initialized) {
> +	if (!selinux_initialized(state)) {
>   		if (sid <= SECINITSID_NUM) {
>   			char *scontextp;
>   
> @@ -1549,7 +1549,7 @@ static int security_context_to_sid_core(struct selinux_state *state,
>   	if (!scontext2)
>   		return -ENOMEM;
>   
> -	if (!state->initialized) {
> +	if (!selinux_initialized(state)) {
>   		int i;
>   
>   		for (i = 1; i < SECINITSID_NUM; i++) {
> @@ -1736,7 +1736,7 @@ static int security_compute_sid(struct selinux_state *state,
>   	int rc = 0;
>   	bool sock;
>   
> -	if (!state->initialized) {
> +	if (!selinux_initialized(state)) {
>   		switch (orig_tclass) {
>   		case SECCLASS_PROCESS: /* kernel value */
>   			*out_sid = ssid;
> @@ -2198,7 +2198,7 @@ int security_load_policy(struct selinux_state *state, void *data, size_t len)
>   		goto out;
>   	}
>   
> -	if (!state->initialized) {
> +	if (!selinux_initialized(state)) {
>   		rc = policydb_read(policydb, fp);
>   		if (rc) {
>   			kfree(newsidtab);
> @@ -2223,7 +2223,7 @@ int security_load_policy(struct selinux_state *state, void *data, size_t len)
>   
>   		state->ss->sidtab = newsidtab;
>   		security_load_policycaps(state);
> -		state->initialized = 1;
> +		selinux_mark_initialized(state);
>   		seqno = ++state->ss->latest_granting;
>   		selinux_complete_init();
>   		avc_ss_reset(state->avc, seqno);
> @@ -2639,7 +2639,7 @@ int security_get_user_sids(struct selinux_state *state,
>   	*sids = NULL;
>   	*nel = 0;
>   
> -	if (!state->initialized)
> +	if (!selinux_initialized(state))
>   		goto out;
>   
>   	read_lock(&state->ss->policy_rwlock);
> @@ -2875,7 +2875,7 @@ int security_get_bools(struct selinux_state *state,
>   	struct policydb *policydb;
>   	int i, rc;
>   
> -	if (!state->initialized) {
> +	if (!selinux_initialized(state)) {
>   		*len = 0;
>   		*names = NULL;
>   		*values = NULL;
> @@ -3050,7 +3050,7 @@ int security_sid_mls_copy(struct selinux_state *state,
>   	int rc;
>   
>   	rc = 0;
> -	if (!state->initialized || !policydb->mls_enabled) {
> +	if (!selinux_initialized(state) || !policydb->mls_enabled) {
>   		*new_sid = sid;
>   		goto out;
>   	}
> @@ -3217,7 +3217,7 @@ int security_get_classes(struct selinux_state *state,
>   	struct policydb *policydb = &state->ss->policydb;
>   	int rc;
>   
> -	if (!state->initialized) {
> +	if (!selinux_initialized(state)) {
>   		*nclasses = 0;
>   		*classes = NULL;
>   		return 0;
> @@ -3366,7 +3366,7 @@ int selinux_audit_rule_init(u32 field, u32 op, char *rulestr, void **vrule)
>   
>   	*rule = NULL;
>   
> -	if (!state->initialized)
> +	if (!selinux_initialized(state))
>   		return -EOPNOTSUPP;
>   
>   	switch (field) {
> @@ -3665,7 +3665,7 @@ int security_netlbl_secattr_to_sid(struct selinux_state *state,
>   	struct context *ctx;
>   	struct context ctx_new;
>   
> -	if (!state->initialized) {
> +	if (!selinux_initialized(state)) {
>   		*sid = SECSID_NULL;
>   		return 0;
>   	}
> @@ -3732,7 +3732,7 @@ int security_netlbl_sid_to_secattr(struct selinux_state *state,
>   	int rc;
>   	struct context *ctx;
>   
> -	if (!state->initialized)
> +	if (!selinux_initialized(state))
>   		return 0;
>   
>   	read_lock(&state->ss->policy_rwlock);
> @@ -3771,7 +3771,7 @@ int security_read_policy(struct selinux_state *state,
>   	int rc;
>   	struct policy_file fp;
>   
> -	if (!state->initialized)
> +	if (!selinux_initialized(state))
>   		return -EINVAL;
>   
>   	*len = security_policydb_len(state);
> 

