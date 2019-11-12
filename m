Return-Path: <SRS0=MTWr=ZE=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F394AC43331
	for <selinux@archiver.kernel.org>; Tue, 12 Nov 2019 15:24:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB53921D7F
	for <selinux@archiver.kernel.org>; Tue, 12 Nov 2019 15:24:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="KKb1wuM2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727020AbfKLPYH (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 12 Nov 2019 10:24:07 -0500
Received: from UCOL19PA35.eemsg.mail.mil ([214.24.24.195]:62060 "EHLO
        UCOL19PA35.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726952AbfKLPYH (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 12 Nov 2019 10:24:07 -0500
X-EEMSG-check-017: 48518288|UCOL19PA35_ESA_OUT02.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.68,296,1569283200"; 
   d="scan'208";a="48518288"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by UCOL19PA35.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 12 Nov 2019 15:24:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1573572241; x=1605108241;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=Mk4Ysmf/xXapwRjKDr4rcp5tV0PEjM3Ro+pTndWNzcY=;
  b=KKb1wuM2a1XQvyG4c8vBv30L3VR+z7BLsMPev0iIJ85Dm5dhvQ5db+Ww
   PdwyLFFdc/Lf/GW5jdUJhl03B1P6Y85fwgYcSSm5ENDgItJCmqE54AcIk
   2DCVSDQOrYvFgjyiat1F8eot6idwDdBdRblgMUgLDItI8xi3zMe+4TQIh
   nEb5vtrTvm5Neb2rACw6Si6Hjy1/gsVXcZUao40RSqTuOyODr0gNpCWH0
   nuSGG0/rZzEewcOlOfKyPyRMGvYeDDGTqjeZvaaGpHVD8CjcvTmJbq47r
   O8aN+FyFWVHojWmnigXa928if8CWFsirKma8jUZekkztCwtWTVEUUfB89
   w==;
X-IronPort-AV: E=Sophos;i="5.68,296,1569283200"; 
   d="scan'208";a="35393232"
IronPort-PHdr: =?us-ascii?q?9a23=3AZF69eRNhvyfORR5YvgMl6mtUPXoX/o7sNwtQ0K?=
 =?us-ascii?q?IMzox0K/38osbcNUDSrc9gkEXOFd2Cra4d0KyP6fGrBjdIyK3CmUhKSIZLWR?=
 =?us-ascii?q?4BhJdetC0bK+nBN3fGKuX3ZTcxBsVIWQwt1Xi6NU9IBJS2PAWK8TW94jEIBx?=
 =?us-ascii?q?rwKxd+KPjrFY7OlcS30P2594HObwlSizexfL1/IA+roQnPssQajolvJ6gswR?=
 =?us-ascii?q?bVv3VEfPhby3l1LlyJhRb84cmw/J9n8ytOvv8q6tBNX6bncakmVLJUFDspPX?=
 =?us-ascii?q?w7683trhnDUBCA5mAAXWUMkxpHGBbK4RfnVZrsqCT6t+592C6HPc3qSL0/RD?=
 =?us-ascii?q?qv47t3RBLulSwKLCAy/n3JhcNsjaJbuBOhqAJ5w47Ie4GeKf5ycrrAcd8GWW?=
 =?us-ascii?q?ZNW8BcWCJbAoO4coABEewPM+hFpIX5vlcCsx+zCQyqCejyyDFHm2X20LUn3e?=
 =?us-ascii?q?o/HwHI3A8uEdwAv3vbrtr6KKgcXPupzKTK1zjPc+9a1Dn/5YXObxsvoeuMXb?=
 =?us-ascii?q?V1ccfJ1EcvCx3Kjk2QqYP7OTOey/kDs22B4OpkUeKglW4moBx2rzi028gskZ?=
 =?us-ascii?q?LEhp4Vy1/Y9SV5x5w5JdujSEFhe9KkH5xQtz+DOoZwX8gsTWZouCMgxb0Hv5?=
 =?us-ascii?q?62ZDIKx4o6yB7fcfOHb5KE7Q7kVOaUJzpzmXFreKqnihqv/kWtxffwW8mp3F?=
 =?us-ascii?q?pQsCZIncfAumoQ2xHV98OJUOFy/l271jaKzw3T7+ZELl0qmqfDMJ4hx6Iwlo?=
 =?us-ascii?q?IUsUTeAi/6gEX2g7GSdkUj4uWo9/7oYq/npp+BLI94kB3+M6Qylcy/BuQ0KA?=
 =?us-ascii?q?4OUHSA+eugzrHj+Ez5QLFSgv03lKnWrozaKNwGqqO2DAJZyIYu5wulAzu439?=
 =?us-ascii?q?kUg2MLIE9ddBKClYfpOlXOIP7iDfe4hlShiCxryO3dPrD6HpXMLmTMkLfmfb?=
 =?us-ascii?q?pn7U5c0xA8wcpQ55JTFLENOOjzVVPptNzEEh85NBS5w+HiCNV6zYMeX3iADb?=
 =?us-ascii?q?OHP67Jq1+H+P8gI+mWa48JojryN/8l5/v2h38jhVAdZbWp3YcQaH2gBfRpPU?=
 =?us-ascii?q?GZYXvqgtccHmYHpRQ+TOP0h12YSzJTZGi9X7g65j4lDIKqF4DDRpqigLaZxi?=
 =?us-ascii?q?e0AoVWZnxaClCLCXrob5+LW+oIaC+JOs9uiCEEVby4R48k0hGusxX6xKR9Iu?=
 =?us-ascii?q?XI/S0YsIrp1MJp6O3LiREy6Tt0AtyH026RUmF5hX0IRzAo06Blu0B9yUmM0b?=
 =?us-ascii?q?J+g/NGEdxf/fRJUh01NZTE1ex1F8jyWh7dfteOUFumWs+pASw1TtI039AOYF?=
 =?us-ascii?q?1wG9a8gRDZ2SqlHbsVm6aMBJwu/aLWx2LxKNply3bayKkhiEErQs5UNWK4ha?=
 =?us-ascii?q?5/8xbcB5LTnEiCjaala7kT3C7X+2ef12aBoEZYUAsjGZnCCFcZalHbr5zc4V?=
 =?us-ascii?q?jERrSjCvxzNQ5G0siLIaZicNDljVxaAvzkPYKaK3m8n2a2GAag2LyBdszpdn?=
 =?us-ascii?q?8b0SGbD1IL10gr9GuCfS05AT2s6zbGBSFqPUrmfkep9O55sn79RUgxmVKkdU?=
 =?us-ascii?q?pkgoGp9wYViPrUcPYa2rYJqW91sDlvNEqs1NLRTdybrkxue7sKMoB120tOyW?=
 =?us-ascii?q?+M7181BZenNa03wwdEIgk=3D?=
X-IPAS-Result: =?us-ascii?q?A2BPAABYzcpd/wHyM5BlGgEBAQEBAQEBAQMBAQEBEQEBA?=
 =?us-ascii?q?QICAQEBAYF+gXQsbFUyKoQpj1gGgTZ/iGePXIFnCQEBAQEBAQEBASsJAQIBA?=
 =?us-ascii?q?YRAAoIdJDgTAg4BAQEEAQEBAQEFAwEBbIU3DII7KQGCbQEFGgkEEUEQCw4KA?=
 =?us-ascii?q?gImAgJXBgEMBgIBAYJfHhcKAYJSJQ+vMH8zhU6DNIFCBoEOKIghg3MYeIEHg?=
 =?us-ascii?q?REngjY1PoJiBBiBL4Mogl4EjH0PFYkvRXOWCIIvgjaEYY4nBhuCPYwWiyaOR?=
 =?us-ascii?q?4g2k1EigVgrCAIYCCEPO4JsUBEUV49rF4NQinEjAzABgQQBAY4ZK4ITAQE?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 12 Nov 2019 15:24:00 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id xACFNxjT001974;
        Tue, 12 Nov 2019 10:23:59 -0500
Subject: Re: [PATCH v4] selinux: cache the SID -> context string translation
To:     Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org,
        Paul Moore <paul@paul-moore.com>
Cc:     rcu@vger.kernel.org, "Paul E. McKenney" <paulmck@kernel.org>,
        Michal Sekletar <msekleta@redhat.com>
References: <20191111154004.1790-1-omosnace@redhat.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <02baef66-b37e-1bd3-54e1-d6656f206185@tycho.nsa.gov>
Date:   Tue, 12 Nov 2019 10:23:59 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <20191111154004.1790-1-omosnace@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 11/11/19 10:40 AM, Ondrej Mosnacek wrote:
> Translating a context struct to string can be quite slow, especially if
> the context has a lot of category bits set. This can cause quite
> noticeable performance impact in situations where the translation needs
> to be done repeatedly. A common example is a UNIX datagram socket with
> the SO_PASSSEC option enabled, which is used e.g. by systemd-journald
> when receiving log messages via datagram socket. This scenario can be
> reproduced with:
> 
>      cat /dev/urandom | base64 | logger &
>      timeout 30s perf record -p $(pidof systemd-journald) -a -g
>      kill %1
>      perf report -g none --pretty raw | grep security_secid_to_secctx
> 
> Before the caching introduced by this patch, computing the context
> string (security_secid_to_secctx() function) takes up ~65% of
> systemd-journald's CPU time (assuming a context with 1024 categories
> set and Fedora x86_64 release kernel configs). After this patch
> (assuming near-perfect cache hit ratio) this overhead is reduced to just
> ~2%.
> 
> This patch addresses the issue by caching a certain number (compile-time
> configurable) of recently used context strings to speed up repeated
> translations of the same context, while using only a small amount of
> memory.
> 
> The cache is integrated into the existing sidtab table by adding a field
> to each entry, which when not NULL contains an RCU-protected pointer to
> a cache entry containing the cached string. The cache entries are kept
> in a linked list sorted according to how recently they were used. On a
> cache miss when the cache is full, the least recently used entry is
> removed to make space for the new entry.
> 
> The patch migrates security_sid_to_context_core() to use the cache (also
> a few other functions where it was possible without too much fuss, but
> these mostly use the translation for logging in case of error, which is
> rare).
> 
> Link: https://bugzilla.redhat.com/show_bug.cgi?id=1733259
> Cc: Michal Sekletar <msekleta@redhat.com>
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>

Reviewed-by: Stephen Smalley <sds@tycho.nsa.gov>
Tested-by: Stephen Smalley <sds@tycho.nsa.gov>

> ---
> 
> Changes in v4:
>   - use rcu_dereference_protected() instead of rcu_dereference_raw() in
>     sidtab_sid2str_put()
>   - fix typo in comment
>   - remove unnecessary rcu_head_init() call
> 
> Changes in v3:
>   - add rcu@vger.kernel.org and Paul McKenney to Cc for review of the RCU
>     logic
>   - add __rcu annotation to the cache entry pointer (sidtab.c now passes
>     sparse checks with C=1)
> 
> Changes in v2:
>   - skip sidtab_sid2str_put() when in non-task context to prevent
>     deadlock while avoiding the need to lock the spinlock with
>     irqsave/-restore (which is slower)
> 
>   security/selinux/Kconfig       |  11 ++
>   security/selinux/ss/services.c | 138 +++++++++++++++----------
>   security/selinux/ss/sidtab.c   | 179 +++++++++++++++++++++++++++------
>   security/selinux/ss/sidtab.h   |  58 +++++++++--
>   4 files changed, 294 insertions(+), 92 deletions(-)
> 
> diff --git a/security/selinux/Kconfig b/security/selinux/Kconfig
> index 5711689deb6a..35fe8878cf1c 100644
> --- a/security/selinux/Kconfig
> +++ b/security/selinux/Kconfig
> @@ -85,3 +85,14 @@ config SECURITY_SELINUX_CHECKREQPROT_VALUE
>   	  via /selinux/checkreqprot if authorized by policy.
>   
>   	  If you are unsure how to answer this question, answer 0.
> +
> +config SECURITY_SELINUX_SID2STR_CACHE_SIZE
> +	int "NSA SELinux SID to context string translation cache size"
> +	depends on SECURITY_SELINUX
> +	default 256
> +	help
> +	  This option defines the size of the internal SID -> context string
> +	  cache, which improves the performance of context to string
> +	  conversion.  Setting this option to 0 disables the cache completely.
> +
> +	  If unsure, keep the default value.
> diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
> index 3a29e7c24ba9..b6dda5261166 100644
> --- a/security/selinux/ss/services.c
> +++ b/security/selinux/ss/services.c
> @@ -91,6 +91,12 @@ static int context_struct_to_string(struct policydb *policydb,
>   				    char **scontext,
>   				    u32 *scontext_len);
>   
> +static int sidtab_entry_to_string(struct policydb *policydb,
> +				  struct sidtab *sidtab,
> +				  struct sidtab_entry *entry,
> +				  char **scontext,
> +				  u32 *scontext_len);
> +
>   static void context_struct_compute_av(struct policydb *policydb,
>   				      struct context *scontext,
>   				      struct context *tcontext,
> @@ -716,20 +722,21 @@ static void context_struct_compute_av(struct policydb *policydb,
>   }
>   
>   static int security_validtrans_handle_fail(struct selinux_state *state,
> -					   struct context *ocontext,
> -					   struct context *ncontext,
> -					   struct context *tcontext,
> +					   struct sidtab_entry *oentry,
> +					   struct sidtab_entry *nentry,
> +					   struct sidtab_entry *tentry,
>   					   u16 tclass)
>   {
>   	struct policydb *p = &state->ss->policydb;
> +	struct sidtab *sidtab = state->ss->sidtab;
>   	char *o = NULL, *n = NULL, *t = NULL;
>   	u32 olen, nlen, tlen;
>   
> -	if (context_struct_to_string(p, ocontext, &o, &olen))
> +	if (sidtab_entry_to_string(p, sidtab, oentry, &o, &olen))
>   		goto out;
> -	if (context_struct_to_string(p, ncontext, &n, &nlen))
> +	if (sidtab_entry_to_string(p, sidtab, nentry, &n, &nlen))
>   		goto out;
> -	if (context_struct_to_string(p, tcontext, &t, &tlen))
> +	if (sidtab_entry_to_string(p, sidtab, tentry, &t, &tlen))
>   		goto out;
>   	audit_log(audit_context(), GFP_ATOMIC, AUDIT_SELINUX_ERR,
>   		  "op=security_validate_transition seresult=denied"
> @@ -751,9 +758,9 @@ static int security_compute_validatetrans(struct selinux_state *state,
>   {
>   	struct policydb *policydb;
>   	struct sidtab *sidtab;
> -	struct context *ocontext;
> -	struct context *ncontext;
> -	struct context *tcontext;
> +	struct sidtab_entry *oentry;
> +	struct sidtab_entry *nentry;
> +	struct sidtab_entry *tentry;
>   	struct class_datum *tclass_datum;
>   	struct constraint_node *constraint;
>   	u16 tclass;
> @@ -779,24 +786,24 @@ static int security_compute_validatetrans(struct selinux_state *state,
>   	}
>   	tclass_datum = policydb->class_val_to_struct[tclass - 1];
>   
> -	ocontext = sidtab_search(sidtab, oldsid);
> -	if (!ocontext) {
> +	oentry = sidtab_search_entry(sidtab, oldsid);
> +	if (!oentry) {
>   		pr_err("SELinux: %s:  unrecognized SID %d\n",
>   			__func__, oldsid);
>   		rc = -EINVAL;
>   		goto out;
>   	}
>   
> -	ncontext = sidtab_search(sidtab, newsid);
> -	if (!ncontext) {
> +	nentry = sidtab_search_entry(sidtab, newsid);
> +	if (!nentry) {
>   		pr_err("SELinux: %s:  unrecognized SID %d\n",
>   			__func__, newsid);
>   		rc = -EINVAL;
>   		goto out;
>   	}
>   
> -	tcontext = sidtab_search(sidtab, tasksid);
> -	if (!tcontext) {
> +	tentry = sidtab_search_entry(sidtab, tasksid);
> +	if (!tentry) {
>   		pr_err("SELinux: %s:  unrecognized SID %d\n",
>   			__func__, tasksid);
>   		rc = -EINVAL;
> @@ -805,15 +812,16 @@ static int security_compute_validatetrans(struct selinux_state *state,
>   
>   	constraint = tclass_datum->validatetrans;
>   	while (constraint) {
> -		if (!constraint_expr_eval(policydb, ocontext, ncontext,
> -					  tcontext, constraint->expr)) {
> +		if (!constraint_expr_eval(policydb, &oentry->context,
> +					  &nentry->context, &tentry->context,
> +					  constraint->expr)) {
>   			if (user)
>   				rc = -EPERM;
>   			else
>   				rc = security_validtrans_handle_fail(state,
> -								     ocontext,
> -								     ncontext,
> -								     tcontext,
> +								     oentry,
> +								     nentry,
> +								     tentry,
>   								     tclass);
>   			goto out;
>   		}
> @@ -855,7 +863,7 @@ int security_bounded_transition(struct selinux_state *state,
>   {
>   	struct policydb *policydb;
>   	struct sidtab *sidtab;
> -	struct context *old_context, *new_context;
> +	struct sidtab_entry *old_entry, *new_entry;
>   	struct type_datum *type;
>   	int index;
>   	int rc;
> @@ -869,16 +877,16 @@ int security_bounded_transition(struct selinux_state *state,
>   	sidtab = state->ss->sidtab;
>   
>   	rc = -EINVAL;
> -	old_context = sidtab_search(sidtab, old_sid);
> -	if (!old_context) {
> +	old_entry = sidtab_search_entry(sidtab, old_sid);
> +	if (!old_entry) {
>   		pr_err("SELinux: %s: unrecognized SID %u\n",
>   		       __func__, old_sid);
>   		goto out;
>   	}
>   
>   	rc = -EINVAL;
> -	new_context = sidtab_search(sidtab, new_sid);
> -	if (!new_context) {
> +	new_entry = sidtab_search_entry(sidtab, new_sid);
> +	if (!new_entry) {
>   		pr_err("SELinux: %s: unrecognized SID %u\n",
>   		       __func__, new_sid);
>   		goto out;
> @@ -886,10 +894,10 @@ int security_bounded_transition(struct selinux_state *state,
>   
>   	rc = 0;
>   	/* type/domain unchanged */
> -	if (old_context->type == new_context->type)
> +	if (old_entry->context.type == new_entry->context.type)
>   		goto out;
>   
> -	index = new_context->type;
> +	index = new_entry->context.type;
>   	while (true) {
>   		type = policydb->type_val_to_struct[index - 1];
>   		BUG_ON(!type);
> @@ -901,7 +909,7 @@ int security_bounded_transition(struct selinux_state *state,
>   
>   		/* @newsid is bounded by @oldsid */
>   		rc = 0;
> -		if (type->bounds == old_context->type)
> +		if (type->bounds == old_entry->context.type)
>   			break;
>   
>   		index = type->bounds;
> @@ -912,10 +920,10 @@ int security_bounded_transition(struct selinux_state *state,
>   		char *new_name = NULL;
>   		u32 length;
>   
> -		if (!context_struct_to_string(policydb, old_context,
> -					      &old_name, &length) &&
> -		    !context_struct_to_string(policydb, new_context,
> -					      &new_name, &length)) {
> +		if (!sidtab_entry_to_string(policydb, sidtab, old_entry,
> +					    &old_name, &length) &&
> +		    !sidtab_entry_to_string(policydb, sidtab, new_entry,
> +					    &new_name, &length)) {
>   			audit_log(audit_context(),
>   				  GFP_ATOMIC, AUDIT_SELINUX_ERR,
>   				  "op=security_bounded_transition "
> @@ -1255,6 +1263,23 @@ static int context_struct_to_string(struct policydb *p,
>   	return 0;
>   }
>   
> +static int sidtab_entry_to_string(struct policydb *p,
> +				  struct sidtab *sidtab,
> +				  struct sidtab_entry *entry,
> +				  char **scontext, u32 *scontext_len)
> +{
> +	int rc = sidtab_sid2str_get(sidtab, entry, scontext, scontext_len);
> +
> +	if (rc != -ENOENT)
> +		return rc;
> +
> +	rc = context_struct_to_string(p, &entry->context, scontext,
> +				      scontext_len);
> +	if (!rc && scontext)
> +		sidtab_sid2str_put(sidtab, entry, *scontext, *scontext_len);
> +	return rc;
> +}
> +
>   #include "initial_sid_to_string.h"
>   
>   const char *security_get_initial_sid_context(u32 sid)
> @@ -1271,7 +1296,7 @@ static int security_sid_to_context_core(struct selinux_state *state,
>   {
>   	struct policydb *policydb;
>   	struct sidtab *sidtab;
> -	struct context *context;
> +	struct sidtab_entry *entry;
>   	int rc = 0;
>   
>   	if (scontext)
> @@ -1302,21 +1327,23 @@ static int security_sid_to_context_core(struct selinux_state *state,
>   	read_lock(&state->ss->policy_rwlock);
>   	policydb = &state->ss->policydb;
>   	sidtab = state->ss->sidtab;
> +
>   	if (force)
> -		context = sidtab_search_force(sidtab, sid);
> +		entry = sidtab_search_entry_force(sidtab, sid);
>   	else
> -		context = sidtab_search(sidtab, sid);
> -	if (!context) {
> +		entry = sidtab_search_entry(sidtab, sid);
> +	if (!entry) {
>   		pr_err("SELinux: %s:  unrecognized SID %d\n",
>   			__func__, sid);
>   		rc = -EINVAL;
>   		goto out_unlock;
>   	}
> -	if (only_invalid && !context->len)
> -		rc = 0;
> -	else
> -		rc = context_struct_to_string(policydb, context, scontext,
> -					      scontext_len);
> +	if (only_invalid && !entry->context.len)
> +		goto out_unlock;
> +
> +	rc = sidtab_entry_to_string(policydb, sidtab, entry, scontext,
> +				    scontext_len);
> +
>   out_unlock:
>   	read_unlock(&state->ss->policy_rwlock);
>   out:
> @@ -1574,19 +1601,20 @@ int security_context_to_sid_force(struct selinux_state *state,
>   
>   static int compute_sid_handle_invalid_context(
>   	struct selinux_state *state,
> -	struct context *scontext,
> -	struct context *tcontext,
> +	struct sidtab_entry *sentry,
> +	struct sidtab_entry *tentry,
>   	u16 tclass,
>   	struct context *newcontext)
>   {
>   	struct policydb *policydb = &state->ss->policydb;
> +	struct sidtab *sidtab = state->ss->sidtab;
>   	char *s = NULL, *t = NULL, *n = NULL;
>   	u32 slen, tlen, nlen;
>   	struct audit_buffer *ab;
>   
> -	if (context_struct_to_string(policydb, scontext, &s, &slen))
> +	if (sidtab_entry_to_string(policydb, sidtab, sentry, &s, &slen))
>   		goto out;
> -	if (context_struct_to_string(policydb, tcontext, &t, &tlen))
> +	if (sidtab_entry_to_string(policydb, sidtab, tentry, &t, &tlen))
>   		goto out;
>   	if (context_struct_to_string(policydb, newcontext, &n, &nlen))
>   		goto out;
> @@ -1645,7 +1673,8 @@ static int security_compute_sid(struct selinux_state *state,
>   	struct policydb *policydb;
>   	struct sidtab *sidtab;
>   	struct class_datum *cladatum = NULL;
> -	struct context *scontext = NULL, *tcontext = NULL, newcontext;
> +	struct context *scontext, *tcontext, newcontext;
> +	struct sidtab_entry *sentry, *tentry;
>   	struct role_trans *roletr = NULL;
>   	struct avtab_key avkey;
>   	struct avtab_datum *avdatum;
> @@ -1682,21 +1711,24 @@ static int security_compute_sid(struct selinux_state *state,
>   	policydb = &state->ss->policydb;
>   	sidtab = state->ss->sidtab;
>   
> -	scontext = sidtab_search(sidtab, ssid);
> -	if (!scontext) {
> +	sentry = sidtab_search_entry(sidtab, ssid);
> +	if (!sentry) {
>   		pr_err("SELinux: %s:  unrecognized SID %d\n",
>   		       __func__, ssid);
>   		rc = -EINVAL;
>   		goto out_unlock;
>   	}
> -	tcontext = sidtab_search(sidtab, tsid);
> -	if (!tcontext) {
> +	tentry = sidtab_search_entry(sidtab, tsid);
> +	if (!tentry) {
>   		pr_err("SELinux: %s:  unrecognized SID %d\n",
>   		       __func__, tsid);
>   		rc = -EINVAL;
>   		goto out_unlock;
>   	}
>   
> +	scontext = &sentry->context;
> +	tcontext = &tentry->context;
> +
>   	if (tclass && tclass <= policydb->p_classes.nprim)
>   		cladatum = policydb->class_val_to_struct[tclass - 1];
>   
> @@ -1797,10 +1829,8 @@ static int security_compute_sid(struct selinux_state *state,
>   
>   	/* Check the validity of the context. */
>   	if (!policydb_context_isvalid(policydb, &newcontext)) {
> -		rc = compute_sid_handle_invalid_context(state, scontext,
> -							tcontext,
> -							tclass,
> -							&newcontext);
> +		rc = compute_sid_handle_invalid_context(state, sentry, tentry,
> +							tclass, &newcontext);
>   		if (rc)
>   			goto out_unlock;
>   	}
> diff --git a/security/selinux/ss/sidtab.c b/security/selinux/ss/sidtab.c
> index 7d49994e8d5f..6d6ce1c43b49 100644
> --- a/security/selinux/ss/sidtab.c
> +++ b/security/selinux/ss/sidtab.c
> @@ -9,6 +9,8 @@
>    */
>   #include <linux/errno.h>
>   #include <linux/kernel.h>
> +#include <linux/list.h>
> +#include <linux/rcupdate.h>
>   #include <linux/slab.h>
>   #include <linux/sched.h>
>   #include <linux/spinlock.h>
> @@ -17,6 +19,14 @@
>   #include "security.h"
>   #include "sidtab.h"
>   
> +struct sidtab_str_cache {
> +	struct rcu_head rcu_member;
> +	struct list_head lru_member;
> +	struct sidtab_entry *parent;
> +	u32 len;
> +	char str[];
> +};
> +
>   int sidtab_init(struct sidtab *s)
>   {
>   	u32 i;
> @@ -34,24 +44,33 @@ int sidtab_init(struct sidtab *s)
>   	s->convert = NULL;
>   
>   	spin_lock_init(&s->lock);
> +
> +#if CONFIG_SECURITY_SELINUX_SID2STR_CACHE_SIZE > 0
> +	s->cache_free_slots = CONFIG_SECURITY_SELINUX_SID2STR_CACHE_SIZE;
> +	INIT_LIST_HEAD(&s->cache_lru_list);
> +	spin_lock_init(&s->cache_lock);
> +#endif
>   	return 0;
>   }
>   
>   int sidtab_set_initial(struct sidtab *s, u32 sid, struct context *context)
>   {
> -	struct sidtab_isid_entry *entry;
> +	struct sidtab_isid_entry *isid;
>   	int rc;
>   
>   	if (sid == 0 || sid > SECINITSID_NUM)
>   		return -EINVAL;
>   
> -	entry = &s->isids[sid - 1];
> +	isid = &s->isids[sid - 1];
>   
> -	rc = context_cpy(&entry->context, context);
> +	rc = context_cpy(&isid->entry.context, context);
>   	if (rc)
>   		return rc;
>   
> -	entry->set = 1;
> +#if CONFIG_SECURITY_SELINUX_SID2STR_CACHE_SIZE > 0
> +	isid->entry.cache = NULL;
> +#endif
> +	isid->set = 1;
>   	return 0;
>   }
>   
> @@ -88,7 +107,8 @@ static int sidtab_alloc_roots(struct sidtab *s, u32 level)
>   	return 0;
>   }
>   
> -static struct context *sidtab_do_lookup(struct sidtab *s, u32 index, int alloc)
> +static struct sidtab_entry *sidtab_do_lookup(struct sidtab *s, u32 index,
> +					     int alloc)
>   {
>   	union sidtab_entry_inner *entry;
>   	u32 level, capacity_shift, leaf_index = index / SIDTAB_LEAF_ENTRIES;
> @@ -125,10 +145,16 @@ static struct context *sidtab_do_lookup(struct sidtab *s, u32 index, int alloc)
>   		if (!entry->ptr_leaf)
>   			return NULL;
>   	}
> -	return &entry->ptr_leaf->entries[index % SIDTAB_LEAF_ENTRIES].context;
> +	return &entry->ptr_leaf->entries[index % SIDTAB_LEAF_ENTRIES];
> +}
> +
> +/* use when you know that there is enough entries */
> +static struct context *sidtab_lookup_unsafe(struct sidtab *s, u32 index)
> +{
> +	return &sidtab_do_lookup(s, index, 0)->context;
>   }
>   
> -static struct context *sidtab_lookup(struct sidtab *s, u32 index)
> +static struct sidtab_entry *sidtab_lookup(struct sidtab *s, u32 index)
>   {
>   	/* read entries only after reading count */
>   	u32 count = smp_load_acquire(&s->count);
> @@ -139,33 +165,34 @@ static struct context *sidtab_lookup(struct sidtab *s, u32 index)
>   	return sidtab_do_lookup(s, index, 0);
>   }
>   
> -static struct context *sidtab_lookup_initial(struct sidtab *s, u32 sid)
> +static struct sidtab_entry *sidtab_lookup_initial(struct sidtab *s, u32 sid)
>   {
> -	return s->isids[sid - 1].set ? &s->isids[sid - 1].context : NULL;
> +	return s->isids[sid - 1].set ? &s->isids[sid - 1].entry : NULL;
>   }
>   
> -static struct context *sidtab_search_core(struct sidtab *s, u32 sid, int force)
> +static struct sidtab_entry *sidtab_search_core(struct sidtab *s, u32 sid,
> +					       int force)
>   {
> -	struct context *context;
> -
>   	if (sid != 0) {
> +		struct sidtab_entry *entry;
> +
>   		if (sid > SECINITSID_NUM)
> -			context = sidtab_lookup(s, sid - (SECINITSID_NUM + 1));
> +			entry = sidtab_lookup(s, sid - (SECINITSID_NUM + 1));
>   		else
> -			context = sidtab_lookup_initial(s, sid);
> -		if (context && (!context->len || force))
> -			return context;
> +			entry = sidtab_lookup_initial(s, sid);
> +		if (entry && (!entry->context.len || force))
> +			return entry;
>   	}
>   
>   	return sidtab_lookup_initial(s, SECINITSID_UNLABELED);
>   }
>   
> -struct context *sidtab_search(struct sidtab *s, u32 sid)
> +struct sidtab_entry *sidtab_search_entry(struct sidtab *s, u32 sid)
>   {
>   	return sidtab_search_core(s, sid, 0);
>   }
>   
> -struct context *sidtab_search_force(struct sidtab *s, u32 sid)
> +struct sidtab_entry *sidtab_search_entry_force(struct sidtab *s, u32 sid)
>   {
>   	return sidtab_search_core(s, sid, 1);
>   }
> @@ -230,7 +257,7 @@ static int sidtab_rcache_search(struct sidtab *s, struct context *context,
>   		if (v >= SIDTAB_MAX)
>   			continue;
>   
> -		if (context_cmp(sidtab_do_lookup(s, v, 0), context)) {
> +		if (context_cmp(sidtab_lookup_unsafe(s, v), context)) {
>   			sidtab_rcache_update(s, v, i);
>   			*index = v;
>   			return 0;
> @@ -245,7 +272,7 @@ static int sidtab_reverse_lookup(struct sidtab *s, struct context *context,
>   	unsigned long flags;
>   	u32 count, count_locked, level, pos;
>   	struct sidtab_convert_params *convert;
> -	struct context *dst, *dst_convert;
> +	struct sidtab_entry *dst, *dst_convert;
>   	int rc;
>   
>   	rc = sidtab_rcache_search(s, context, index);
> @@ -273,7 +300,7 @@ static int sidtab_reverse_lookup(struct sidtab *s, struct context *context,
>   
>   	/* if count has changed before we acquired the lock, then catch up */
>   	while (count < count_locked) {
> -		if (context_cmp(sidtab_do_lookup(s, count, 0), context)) {
> +		if (context_cmp(sidtab_lookup_unsafe(s, count), context)) {
>   			sidtab_rcache_push(s, count);
>   			*index = count;
>   			rc = 0;
> @@ -293,7 +320,7 @@ static int sidtab_reverse_lookup(struct sidtab *s, struct context *context,
>   	if (!dst)
>   		goto out_unlock;
>   
> -	rc = context_cpy(dst, context);
> +	rc = context_cpy(&dst->context, context);
>   	if (rc)
>   		goto out_unlock;
>   
> @@ -305,13 +332,14 @@ static int sidtab_reverse_lookup(struct sidtab *s, struct context *context,
>   		rc = -ENOMEM;
>   		dst_convert = sidtab_do_lookup(convert->target, count, 1);
>   		if (!dst_convert) {
> -			context_destroy(dst);
> +			context_destroy(&dst->context);
>   			goto out_unlock;
>   		}
>   
> -		rc = convert->func(context, dst_convert, convert->args);
> +		rc = convert->func(context, &dst_convert->context,
> +				   convert->args);
>   		if (rc) {
> -			context_destroy(dst);
> +			context_destroy(&dst->context);
>   			goto out_unlock;
>   		}
>   
> @@ -341,9 +369,9 @@ int sidtab_context_to_sid(struct sidtab *s, struct context *context, u32 *sid)
>   	u32 i;
>   
>   	for (i = 0; i < SECINITSID_NUM; i++) {
> -		struct sidtab_isid_entry *entry = &s->isids[i];
> +		struct sidtab_isid_entry *isid = &s->isids[i];
>   
> -		if (entry->set && context_cmp(context, &entry->context)) {
> +		if (isid->set && context_cmp(context, &isid->entry.context)) {
>   			*sid = i + 1;
>   			return 0;
>   		}
> @@ -453,6 +481,14 @@ int sidtab_convert(struct sidtab *s, struct sidtab_convert_params *params)
>   	return rc;
>   }
>   
> +static void sidtab_destroy_entry(struct sidtab_entry *entry)
> +{
> +	context_destroy(&entry->context);
> +#if CONFIG_SECURITY_SELINUX_SID2STR_CACHE_SIZE > 0
> +	kfree(rcu_dereference_raw(entry->cache));
> +#endif
> +}
> +
>   static void sidtab_destroy_tree(union sidtab_entry_inner entry, u32 level)
>   {
>   	u32 i;
> @@ -473,7 +509,7 @@ static void sidtab_destroy_tree(union sidtab_entry_inner entry, u32 level)
>   			return;
>   
>   		for (i = 0; i < SIDTAB_LEAF_ENTRIES; i++)
> -			context_destroy(&node->entries[i].context);
> +			sidtab_destroy_entry(&node->entries[i]);
>   		kfree(node);
>   	}
>   }
> @@ -484,7 +520,7 @@ void sidtab_destroy(struct sidtab *s)
>   
>   	for (i = 0; i < SECINITSID_NUM; i++)
>   		if (s->isids[i].set)
> -			context_destroy(&s->isids[i].context);
> +			sidtab_destroy_entry(&s->isids[i].entry);
>   
>   	level = SIDTAB_MAX_LEVEL;
>   	while (level && !s->roots[level].ptr_inner)
> @@ -492,3 +528,88 @@ void sidtab_destroy(struct sidtab *s)
>   
>   	sidtab_destroy_tree(s->roots[level], level);
>   }
> +
> +#if CONFIG_SECURITY_SELINUX_SID2STR_CACHE_SIZE > 0
> +
> +void sidtab_sid2str_put(struct sidtab *s, struct sidtab_entry *entry,
> +			const char *str, u32 str_len)
> +{
> +	struct sidtab_str_cache *cache, *victim;
> +
> +	/* do not cache invalid contexts */
> +	if (entry->context.len)
> +		return;
> +
> +	/*
> +	 * Skip the put operation when in non-task context to avoid the need
> +	 * to disable interrupts while holding s->cache_lock.
> +	 */
> +	if (!in_task())
> +		return;
> +
> +	spin_lock(&s->cache_lock);
> +
> +	cache = rcu_dereference_protected(entry->cache,
> +					  lockdep_is_held(&s->cache_lock));
> +	if (cache) {
> +		/* entry in cache - just bump to the head of LRU list */
> +		list_move(&cache->lru_member, &s->cache_lru_list);
> +		goto out_unlock;
> +	}
> +
> +	cache = kmalloc(sizeof(struct sidtab_str_cache) + str_len, GFP_ATOMIC);
> +	if (!cache)
> +		goto out_unlock;
> +
> +	if (s->cache_free_slots == 0) {
> +		/* pop a cache entry from the tail and free it */
> +		victim = container_of(s->cache_lru_list.prev,
> +				      struct sidtab_str_cache, lru_member);
> +		list_del(&victim->lru_member);
> +		kfree_rcu(victim, rcu_member);
> +		rcu_assign_pointer(victim->parent->cache, NULL);
> +	} else {
> +		s->cache_free_slots--;
> +	}
> +	cache->parent = entry;
> +	cache->len = str_len;
> +	memcpy(cache->str, str, str_len);
> +	list_add(&cache->lru_member, &s->cache_lru_list);
> +
> +	rcu_assign_pointer(entry->cache, cache);
> +
> +out_unlock:
> +	spin_unlock(&s->cache_lock);
> +}
> +
> +int sidtab_sid2str_get(struct sidtab *s, struct sidtab_entry *entry,
> +		       char **out, u32 *out_len)
> +{
> +	struct sidtab_str_cache *cache;
> +	int rc = 0;
> +
> +	if (entry->context.len)
> +		return -ENOENT; /* do not cache invalid contexts */
> +
> +	rcu_read_lock();
> +
> +	cache = rcu_dereference(entry->cache);
> +	if (!cache) {
> +		rc = -ENOENT;
> +	} else {
> +		*out_len = cache->len;
> +		if (out) {
> +			*out = kmemdup(cache->str, cache->len, GFP_ATOMIC);
> +			if (!*out)
> +				rc = -ENOMEM;
> +		}
> +	}
> +
> +	rcu_read_unlock();
> +
> +	if (!rc && out)
> +		sidtab_sid2str_put(s, entry, *out, *out_len);
> +	return rc;
> +}
> +
> +#endif /* CONFIG_SECURITY_SELINUX_SID2STR_CACHE_SIZE > 0 */
> diff --git a/security/selinux/ss/sidtab.h b/security/selinux/ss/sidtab.h
> index 1f4763141aa1..5fe67a0c307b 100644
> --- a/security/selinux/ss/sidtab.h
> +++ b/security/selinux/ss/sidtab.h
> @@ -16,13 +16,13 @@
>   
>   #include "context.h"
>   
> -struct sidtab_entry_leaf {
> +struct sidtab_entry {
>   	struct context context;
> +#if CONFIG_SECURITY_SELINUX_SID2STR_CACHE_SIZE > 0
> +	struct sidtab_str_cache __rcu *cache;
> +#endif
>   };
>   
> -struct sidtab_node_inner;
> -struct sidtab_node_leaf;
> -
>   union sidtab_entry_inner {
>   	struct sidtab_node_inner *ptr_inner;
>   	struct sidtab_node_leaf  *ptr_leaf;
> @@ -38,7 +38,7 @@ union sidtab_entry_inner {
>   	(SIDTAB_NODE_ALLOC_SHIFT - size_to_shift(sizeof(union sidtab_entry_inner)))
>   #define SIDTAB_INNER_ENTRIES ((size_t)1 << SIDTAB_INNER_SHIFT)
>   #define SIDTAB_LEAF_ENTRIES \
> -	(SIDTAB_NODE_ALLOC_SIZE / sizeof(struct sidtab_entry_leaf))
> +	(SIDTAB_NODE_ALLOC_SIZE / sizeof(struct sidtab_entry))
>   
>   #define SIDTAB_MAX_BITS 32
>   #define SIDTAB_MAX U32_MAX
> @@ -48,7 +48,7 @@ union sidtab_entry_inner {
>   		     SIDTAB_INNER_SHIFT)
>   
>   struct sidtab_node_leaf {
> -	struct sidtab_entry_leaf entries[SIDTAB_LEAF_ENTRIES];
> +	struct sidtab_entry entries[SIDTAB_LEAF_ENTRIES];
>   };
>   
>   struct sidtab_node_inner {
> @@ -57,7 +57,7 @@ struct sidtab_node_inner {
>   
>   struct sidtab_isid_entry {
>   	int set;
> -	struct context context;
> +	struct sidtab_entry entry;
>   };
>   
>   struct sidtab_convert_params {
> @@ -83,6 +83,13 @@ struct sidtab {
>   	struct sidtab_convert_params *convert;
>   	spinlock_t lock;
>   
> +#if CONFIG_SECURITY_SELINUX_SID2STR_CACHE_SIZE > 0
> +	/* SID -> context string cache */
> +	u32 cache_free_slots;
> +	struct list_head cache_lru_list;
> +	spinlock_t cache_lock;
> +#endif
> +
>   	/* reverse lookup cache - access atomically via {READ|WRITE}_ONCE() */
>   	u32 rcache[SIDTAB_RCACHE_SIZE];
>   
> @@ -92,8 +99,22 @@ struct sidtab {
>   
>   int sidtab_init(struct sidtab *s);
>   int sidtab_set_initial(struct sidtab *s, u32 sid, struct context *context);
> -struct context *sidtab_search(struct sidtab *s, u32 sid);
> -struct context *sidtab_search_force(struct sidtab *s, u32 sid);
> +struct sidtab_entry *sidtab_search_entry(struct sidtab *s, u32 sid);
> +struct sidtab_entry *sidtab_search_entry_force(struct sidtab *s, u32 sid);
> +
> +static inline struct context *sidtab_search(struct sidtab *s, u32 sid)
> +{
> +	struct sidtab_entry *entry = sidtab_search_entry(s, sid);
> +
> +	return entry ? &entry->context : NULL;
> +}
> +
> +static inline struct context *sidtab_search_force(struct sidtab *s, u32 sid)
> +{
> +	struct sidtab_entry *entry = sidtab_search_entry_force(s, sid);
> +
> +	return entry ? &entry->context : NULL;
> +}
>   
>   int sidtab_convert(struct sidtab *s, struct sidtab_convert_params *params);
>   
> @@ -101,6 +122,25 @@ int sidtab_context_to_sid(struct sidtab *s, struct context *context, u32 *sid);
>   
>   void sidtab_destroy(struct sidtab *s);
>   
> +#if CONFIG_SECURITY_SELINUX_SID2STR_CACHE_SIZE > 0
> +void sidtab_sid2str_put(struct sidtab *s, struct sidtab_entry *entry,
> +			const char *str, u32 str_len);
> +int sidtab_sid2str_get(struct sidtab *s, struct sidtab_entry *entry,
> +		       char **out, u32 *out_len);
> +#else
> +static inline void sidtab_sid2str_put(struct sidtab *s,
> +				      struct sidtab_entry *entry,
> +				      const char *str, u32 str_len)
> +{
> +}
> +static inline int sidtab_sid2str_get(struct sidtab *s,
> +				     struct sidtab_entry *entry,
> +				     char **out, u32 *out_len)
> +{
> +	return -ENOENT;
> +}
> +#endif /* CONFIG_SECURITY_SELINUX_SID2STR_CACHE_SIZE > 0 */
> +
>   #endif	/* _SS_SIDTAB_H_ */
>   
>   
> 

