Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88998C433E0
	for <selinux@archiver.kernel.org>; Sun, 14 Feb 2021 18:22:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5AB0664DBA
	for <selinux@archiver.kernel.org>; Sun, 14 Feb 2021 18:22:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbhBNSWl (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 14 Feb 2021 13:22:41 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:26318 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229793AbhBNSWl (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 14 Feb 2021 13:22:41 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 11EI1vZ9026468;
        Sun, 14 Feb 2021 13:21:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=eQlUZqwI30ecnU8cuNANWm8C/Zc1V971Hnwfp7kViGQ=;
 b=Bd9kDnLFAuQ+ncwti52rjP0GaPfiRrx/l0VEYv53suLHSXUvX8b6+YVTQUL2IKf/Rrr9
 FRSGrg3Of6KQWuWUpoHkNDfhfxWLLJEKcvpItcwqXVlIoWYmuvfLDNfQEt4cEP5ECJdj
 cL+f7NsrZ1w4TdKkKkN13bfaN5hnWsmc/fUzDBtAuRx/yen5XLYAZEi8tRWPWeXjzdyu
 OSxBL6OiCxgZB6/yK8jZA/JEYQqPcIyghYy5eeOFhXidBcAyVQS4XBtG/pui8Cmst9og
 q6d7JOjcxbgCR5EJEr0dDB2XW6mowb2b3n3/aSrTuInP/Kd5SEHJ8ccPqwQis9SaseuI 8Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36q82bry0x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 14 Feb 2021 13:21:50 -0500
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 11EILnh6129569;
        Sun, 14 Feb 2021 13:21:49 -0500
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36q82bry05-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 14 Feb 2021 13:21:49 -0500
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 11EIHZeS012548;
        Sun, 14 Feb 2021 18:21:47 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma04ams.nl.ibm.com with ESMTP id 36p6d895sf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 14 Feb 2021 18:21:47 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 11EILj4I12648826
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 14 Feb 2021 18:21:45 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0AB955204F;
        Sun, 14 Feb 2021 18:21:45 +0000 (GMT)
Received: from sig-9-65-223-148.ibm.com (unknown [9.65.223.148])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 30F985204E;
        Sun, 14 Feb 2021 18:21:42 +0000 (GMT)
Message-ID: <693f81d9d2f50a920cafbbc8d1d634598b99081a.camel@linux.ibm.com>
Subject: Re: [PATCH v24 04/25] IMA: avoid label collisions with stacked LSMs
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Casey Schaufler <casey@schaufler-ca.com>,
        casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     linux-audit@redhat.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov,
        linux-kernel@vger.kernel.org
Date:   Sun, 14 Feb 2021 13:21:41 -0500
In-Reply-To: <20210126164108.1958-5-casey@schaufler-ca.com>
References: <20210126164108.1958-1-casey@schaufler-ca.com>
         <20210126164108.1958-5-casey@schaufler-ca.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-14.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-14_04:2021-02-12,2021-02-14 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 malwarescore=0
 phishscore=0 impostorscore=0 spamscore=0 mlxscore=0 bulkscore=0
 adultscore=0 mlxlogscore=999 suspectscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102140151
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Hi Casey,

On Tue, 2021-01-26 at 08:40 -0800, Casey Schaufler wrote:
> Integrity measurement may filter on security module information
> and needs to be clear in the case of multiple active security
> modules which applies. Provide a boot option ima_rules_lsm= to
> allow the user to specify an active securty module to apply
> filters to. If not specified, use the first registered module
> that supports the audit_rule_match() LSM hook. Allow the user
> to specify in the IMA policy an lsm= option to specify the
> security module to use for a particular rule.

Thanks, Casey.

(This patch description line length seems short.)

> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> To: Mimi Zohar <zohar@linux.ibm.com>
> To: linux-integrity@vger.kernel.org
> ---
>  Documentation/ABI/testing/ima_policy |  8 +++-
>  security/integrity/ima/ima_policy.c  | 64 ++++++++++++++++++++++------
>  2 files changed, 57 insertions(+), 15 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/ima_policy b/Documentation/ABI/testing/ima_policy
> index e35263f97fc1..a7943d40466f 100644
> --- a/Documentation/ABI/testing/ima_policy
> +++ b/Documentation/ABI/testing/ima_policy
> @@ -25,7 +25,7 @@ Description:
>  			base:	[[func=] [mask=] [fsmagic=] [fsuuid=] [uid=]
>  				[euid=] [fowner=] [fsname=]]
>  			lsm:	[[subj_user=] [subj_role=] [subj_type=]
> -				 [obj_user=] [obj_role=] [obj_type=]]
> +				 [obj_user=] [obj_role=] [obj_type=] [lsm=]]

"[lsm=]" either requires all LSM rules types (e.g. {subj/obj}_user,
role, type) to be exactly the same for multiple LSMs or all of the LSM
rule types are applicable to only a single LSM.  Supporting multiple
LSMs with exactly the same LSM labels doesn't seem worth the effort.  
Keep it simple - a single rule, containing any LSM rule types, is
applicable to a single LSM.

>  			option:	[[appraise_type=]] [template=] [permit_directio]
>  				[appraise_flag=] [keyrings=]
>  		  base:
> @@ -114,6 +114,12 @@ Description:
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
> index 8002683003e6..de72b719c90c 100644
> --- a/security/integrity/ima/ima_policy.c
> +++ b/security/integrity/ima/ima_policy.c
> @@ -82,6 +82,7 @@ struct ima_rule_entry {
>  		void *rules[LSMBLOB_ENTRIES]; /* LSM file metadata specific */
>  		char *args_p;	/* audit value */
>  		int type;	/* audit type */
> +		int which_lsm; /* which of the rules to use */
>  	} lsm[MAX_LSM_RULES];

Even if we wanted to support multiple LSMs within the same rule having
both "rules[LSMBLOB_ENTRIES]" and "which_lsm" shouldn't be necessary.  
The LSMBLOB_ENTRIES should already identify the LSM.

To support a single LSM per policy rule, "which_lsm" should be defined
outside of lsm[MAX_LSM_RULES].  This will simplify the rest of the code
(e.g. matching/freeing rules).

	int which_lsm;          /* which of the rules to use */
	struct {
                void *rule;        /* LSM file metadata specific */
                char *args_p;   /* audit value */
                int type;       /* audit type */
        } lsm[MAX_LSM_RULES];


>  	char *fsname;
>  	struct ima_rule_opt_list *keyrings; /* Measure keys added to these keyrings */
> @@ -90,17 +91,15 @@ struct ima_rule_entry {
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
> +	if (entry->lsm[lsm_rule].rules[entry->lsm[lsm_rule].which_lsm])
> +		return true;

If each IMA policy rule is limited to a specific LSM, then the test
would be "entry->which_lsm".

>  	return false;
>  }
> 
> @@ -273,6 +272,20 @@ static int __init default_appraise_policy_setup(char *str)
>  }
>  __setup("ima_appraise_tcb", default_appraise_policy_setup);
> 
> +static int ima_rule_lsm __ro_after_init;
> +
> +static int __init ima_rule_lsm_init(char *str)
> +{
> +	ima_rule_lsm = lsm_name_to_slot(str);
> +	if (ima_rule_lsm < 0) {
> +		ima_rule_lsm = 0;
> +		pr_err("rule lsm \"%s\" not registered", str);
> +	}
> +
> +	return 1;
> +}
> +__setup("ima_rule_lsm=", ima_rule_lsm_init);

The patch description refers to "ima_rules_lsm=".  Please update one or
the other.

thanks,

Mimi

