Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2B00C433B4
	for <selinux@archiver.kernel.org>; Fri, 14 May 2021 19:00:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8013D613F6
	for <selinux@archiver.kernel.org>; Fri, 14 May 2021 19:00:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232704AbhENTBe (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 14 May 2021 15:01:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232265AbhENTBd (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 14 May 2021 15:01:33 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DA01C061574
        for <selinux@vger.kernel.org>; Fri, 14 May 2021 12:00:21 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id q15so20496378pgg.12
        for <selinux@vger.kernel.org>; Fri, 14 May 2021 12:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Mf7rkQg4v10s4Zo1+kidnAGMG8KrQBs6mbDlxs4XCDE=;
        b=iFQbPjFOutm2MBufL9DX44RvxPq26rbHzg/YKQrfl92GR2nw3W9BLsQAiY7l9RyEYl
         aP3S87bixsdzNN22R+KohMw6Yg756BC/7GNWW73Wg0xenL5aVlvAhFHFt3/haulV8vJP
         Xlt+sQCCS/Ykc6aZ+BxA4jtAjKkY9O644yNoE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Mf7rkQg4v10s4Zo1+kidnAGMG8KrQBs6mbDlxs4XCDE=;
        b=sd7xAoseG0TyjEQ8JXGgmpY0bBCru1ulqBsGut+sXbGbqartDdPnAO/YT9v/cku2fV
         DmPOYA1Ps3ks5qTolXtCsUFo8oDrAtWqSGetVaNWopeyS9sPTh3cAh66ApXxX9msujWS
         cby2rY49iNcSb0HpzjNeT7nq7Aw70yAVY35bYTEnWk88HCi+InovGedwdEDjM/ujopur
         zoqusETS3OKB/FIn8c+UKaQSIGqznkM/X+Q09jZE3ze3WFLVebcheWLLHyzGl8P7dkMC
         3jdtuLco/qAJXiqCb4kCBn32eukkkmRnHubTkFxg/6+iSVTLG7IgjoFX1Pt0HxtyOVTm
         HSXg==
X-Gm-Message-State: AOAM533tr2ibx3C5nDgTdh/0XpuK+WX+Otcm20btEdt60vTTXLDbsICX
        PZ2NhvGH28S8ZgZ63dvb5WDpZQ==
X-Google-Smtp-Source: ABdhPJyR/YWWjnzvR0qdPdYqINapCmqW53Fjxx4Amu9VJnIcwKiSw4J3/KrWOzIX4AhUQuNA4Q0Org==
X-Received: by 2002:a62:60c2:0:b029:2cb:70a7:a8ce with SMTP id u185-20020a6260c20000b02902cb70a7a8cemr18703272pfb.77.1621018820798;
        Fri, 14 May 2021 12:00:20 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id gm21sm6333686pjb.31.2021.05.14.12.00.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 May 2021 12:00:20 -0700 (PDT)
Date:   Fri, 14 May 2021 12:00:19 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-audit@redhat.com, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v26 04/25] IMA: avoid label collisions with stacked LSMs
Message-ID: <202105141157.DF737E145@keescook>
References: <20210513200807.15910-1-casey@schaufler-ca.com>
 <20210513200807.15910-5-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210513200807.15910-5-casey@schaufler-ca.com>
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, May 13, 2021 at 01:07:46PM -0700, Casey Schaufler wrote:
> Integrity measurement may filter on security module information
> and needs to be clear in the case of multiple active security
> modules which applies. Provide a boot option ima_rules_lsm= to
> allow the user to specify an active securty module to apply
> filters to. If not specified, use the first registered module
> that supports the audit_rule_match() LSM hook. Allow the user
> to specify in the IMA policy an lsm= option to specify the
> security module to use for a particular rule.
> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> To: Mimi Zohar <zohar@linux.ibm.com>
> To: linux-integrity@vger.kernel.org
> ---
>  Documentation/ABI/testing/ima_policy |  8 ++-
>  security/integrity/ima/ima_policy.c  | 77 ++++++++++++++++++++--------
>  2 files changed, 62 insertions(+), 23 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/ima_policy b/Documentation/ABI/testing/ima_policy
> index 070779e8d836..84dd19bc4344 100644
> --- a/Documentation/ABI/testing/ima_policy
> +++ b/Documentation/ABI/testing/ima_policy
> @@ -25,7 +25,7 @@ Description:
>  			base:	[[func=] [mask=] [fsmagic=] [fsuuid=] [uid=]
>  				[euid=] [fowner=] [fsname=]]
>  			lsm:	[[subj_user=] [subj_role=] [subj_type=]
> -				 [obj_user=] [obj_role=] [obj_type=]]
> +				 [obj_user=] [obj_role=] [obj_type=] [lsm=]]
>  			option:	[[appraise_type=]] [template=] [permit_directio]
>  				[appraise_flag=] [keyrings=]
>  		  base:
> @@ -117,6 +117,12 @@ Description:
>  
>  			measure subj_user=_ func=FILE_CHECK mask=MAY_READ
>  
> +		It is possible to explicitly specify which security
> +		module a rule applies to using lsm=.  If the security
> +		modules specified is not active on the system the rule
> +		will be rejected.  If lsm= is not specified the first
> +		security module registered on the system will be assumed.
> +
>  		Example of measure rules using alternate PCRs::
>  
>  			measure func=KEXEC_KERNEL_CHECK pcr=4
> diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
> index 5c40677e881c..d804b9a0dd95 100644
> --- a/security/integrity/ima/ima_policy.c
> +++ b/security/integrity/ima/ima_policy.c
> @@ -79,8 +79,9 @@ struct ima_rule_entry {
>  	bool (*uid_op)(kuid_t, kuid_t);    /* Handlers for operators       */
>  	bool (*fowner_op)(kuid_t, kuid_t); /* uid_eq(), uid_gt(), uid_lt() */
>  	int pcr;
> +	int which_lsm; /* which of the rules to use */
>  	struct {
> -		void *rules[LSMBLOB_ENTRIES]; /* LSM file metadata specific */
> +		void *rule;	/* LSM file metadata specific */
>  		char *args_p;	/* audit value */
>  		int type;	/* audit type */
>  	} lsm[MAX_LSM_RULES];
> @@ -92,17 +93,15 @@ struct ima_rule_entry {
>  
>  /**
>   * ima_lsm_isset - Is a rule set for any of the active security modules
> - * @rules: The set of IMA rules to check
> + * @entry: the rule entry to examine
> + * @lsm_rule: the specific rule type in question
>   *
> - * If a rule is set for any LSM return true, otherwise return false.
> + * If a rule is set return true, otherwise return false.
>   */
> -static inline bool ima_lsm_isset(void *rules[])
> +static inline bool ima_lsm_isset(struct ima_rule_entry *entry, int lsm_rule)
>  {
> -	int i;
> -
> -	for (i = 0; i < LSMBLOB_ENTRIES; i++)
> -		if (rules[i])
> -			return true;
> +	if (entry->lsm[lsm_rule].rule)
> +		return true;

I'd be happier if this retained the MAX_LSM_RULES bounds-check.

>  	return false;
>  }
>  
> @@ -282,6 +281,20 @@ static int __init default_appraise_policy_setup(char *str)
>  }
>  __setup("ima_appraise_tcb", default_appraise_policy_setup);
>  
> +static int ima_rules_lsm __ro_after_init;
> +
> +static int __init ima_rules_lsm_init(char *str)
> +{
> +	ima_rules_lsm = lsm_name_to_slot(str);
> +	if (ima_rules_lsm < 0) {
> +		ima_rules_lsm = 0;
> +		pr_err("rule lsm \"%s\" not registered", str);
> +	}
> +
> +	return 1;
> +}
> +__setup("ima_rules_lsm=", ima_rules_lsm_init);
> +
>  static struct ima_rule_opt_list *ima_alloc_rule_opt_list(const substring_t *src)
>  {
>  	struct ima_rule_opt_list *opt_list;
> @@ -351,11 +364,10 @@ static void ima_free_rule_opt_list(struct ima_rule_opt_list *opt_list)
>  static void ima_lsm_free_rule(struct ima_rule_entry *entry)
>  {
>  	int i;
> -	int r;
>  
>  	for (i = 0; i < MAX_LSM_RULES; i++) {
> -		for (r = 0; r < LSMBLOB_ENTRIES; r++)
> -			ima_filter_rule_free(entry->lsm[i].rules[r]);
> +		if (entry->lsm[i].rule)
> +			ima_filter_rule_free(entry->lsm[i].rule);
>  		kfree(entry->lsm[i].args_p);
>  	}
>  }
> @@ -406,8 +418,8 @@ static struct ima_rule_entry *ima_lsm_copy_rule(struct ima_rule_entry *entry)
>  
>  		ima_filter_rule_init(nentry->lsm[i].type, Audit_equal,
>  				     nentry->lsm[i].args_p,
> -				     &nentry->lsm[i].rules[0]);
> -		if (!ima_lsm_isset(nentry->lsm[i].rules))
> +				     &nentry->lsm[i].rule);
> +		if (!ima_lsm_isset(nentry, i))
>  			pr_warn("rule for LSM \'%s\' is undefined\n",
>  				nentry->lsm[i].args_p);
>  	}
> @@ -596,7 +608,7 @@ static bool ima_match_rules(struct ima_rule_entry *rule,
>  		int rc = 0;
>  		u32 osid;
>  
> -		if (!ima_lsm_isset(rule->lsm[i].rules)) {
> +		if (!ima_lsm_isset(rule, i)) {
>  			if (!rule->lsm[i].args_p)
>  				continue;
>  			else
> @@ -609,14 +621,14 @@ static bool ima_match_rules(struct ima_rule_entry *rule,
>  			security_inode_getsecid(inode, &osid);
>  			rc = ima_filter_rule_match(osid, rule->lsm[i].type,
>  						   Audit_equal,
> -						   rule->lsm[i].rules);
> +						   rule->lsm[i].rule);
>  			break;
>  		case LSM_SUBJ_USER:
>  		case LSM_SUBJ_ROLE:
>  		case LSM_SUBJ_TYPE:
>  			rc = ima_filter_rule_match(secid, rule->lsm[i].type,
>  						   Audit_equal,
> -						   rule->lsm[i].rules);
> +						   rule->lsm[i].rule);
>  			break;
>  		default:
>  			break;
> @@ -966,7 +978,7 @@ enum {
>  	Opt_uid_lt, Opt_euid_lt, Opt_fowner_lt,
>  	Opt_appraise_type, Opt_appraise_flag,
>  	Opt_permit_directio, Opt_pcr, Opt_template, Opt_keyrings,
> -	Opt_label, Opt_err
> +	Opt_lsm, Opt_label, Opt_err
>  };
>  
>  static const match_table_t policy_tokens = {
> @@ -1004,6 +1016,7 @@ static const match_table_t policy_tokens = {
>  	{Opt_template, "template=%s"},
>  	{Opt_keyrings, "keyrings=%s"},
>  	{Opt_label, "label=%s"},
> +	{Opt_lsm, "lsm=%s"},
>  	{Opt_err, NULL}
>  };
>  
> @@ -1012,7 +1025,7 @@ static int ima_lsm_rule_init(struct ima_rule_entry *entry,
>  {
>  	int result;
>  
> -	if (ima_lsm_isset(entry->lsm[lsm_rule].rules))
> +	if (ima_lsm_isset(entry, lsm_rule))
>  		return -EINVAL;
>  
>  	entry->lsm[lsm_rule].args_p = match_strdup(args);
> @@ -1022,8 +1035,8 @@ static int ima_lsm_rule_init(struct ima_rule_entry *entry,
>  	entry->lsm[lsm_rule].type = audit_type;
>  	result = ima_filter_rule_init(entry->lsm[lsm_rule].type, Audit_equal,
>  				      entry->lsm[lsm_rule].args_p,
> -				      &entry->lsm[lsm_rule].rules[0]);
> -	if (!ima_lsm_isset(entry->lsm[lsm_rule].rules)) {
> +				      &entry->lsm[lsm_rule].rule);
> +	if (!ima_lsm_isset(entry, lsm_rule)) {
>  		pr_warn("rule for LSM \'%s\' is undefined\n",
>  			entry->lsm[lsm_rule].args_p);
>  
> @@ -1561,6 +1574,19 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
>  						 &(template_desc->num_fields));
>  			entry->template = template_desc;
>  			break;
> +		case Opt_lsm:
> +			result = lsm_name_to_slot(args[0].from);
> +			if (result == LSMBLOB_INVALID) {
> +				int i;
> +
> +				for (i = 0; i < MAX_LSM_RULES; i++)
> +					entry->lsm[i].args_p = NULL;
> +				result = -EINVAL;
> +				break;
> +			}
> +			entry->which_lsm = result;
> +			result = 0;
> +			break;
>  		case Opt_err:
>  			ima_log_string(ab, "UNKNOWN", p);
>  			result = -EINVAL;
> @@ -1597,6 +1623,7 @@ ssize_t ima_parse_add_rule(char *rule)
>  	struct ima_rule_entry *entry;
>  	ssize_t result, len;
>  	int audit_info = 0;
> +	int i;
>  
>  	p = strsep(&rule, "\n");
>  	len = strlen(p) + 1;
> @@ -1614,6 +1641,9 @@ ssize_t ima_parse_add_rule(char *rule)
>  
>  	INIT_LIST_HEAD(&entry->list);
>  
> +	for (i = 0; i < MAX_LSM_RULES; i++)
> +		entry->which_lsm = ima_rules_lsm;
> +
>  	result = ima_parse_rule(p, entry);
>  	if (result) {
>  		ima_free_rule(entry);
> @@ -1830,7 +1860,7 @@ int ima_policy_show(struct seq_file *m, void *v)
>  	}
>  
>  	for (i = 0; i < MAX_LSM_RULES; i++) {
> -		if (ima_lsm_isset(entry->lsm[i].rules)) {
> +		if (ima_lsm_isset(entry, i)) {
>  			switch (i) {
>  			case LSM_OBJ_USER:
>  				seq_printf(m, pt(Opt_obj_user),
> @@ -1872,6 +1902,9 @@ int ima_policy_show(struct seq_file *m, void *v)
>  		seq_puts(m, "appraise_flag=check_blacklist ");
>  	if (entry->flags & IMA_PERMIT_DIRECTIO)
>  		seq_puts(m, "permit_directio ");
> +	if (entry->which_lsm >= 0)
> +		seq_printf(m, pt(Opt_lsm),
> +			   lsm_slot_to_name(entry->which_lsm));
>  	rcu_read_unlock();
>  	seq_puts(m, "\n");
>  	return 0;
> -- 
> 2.29.2
> 

Otherwise, this looks correct. With bounds checking:

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
