Return-Path: <SRS0=m/sx=4M=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23127C11D32
	for <selinux@archiver.kernel.org>; Mon, 24 Feb 2020 17:57:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 078CE20836
	for <selinux@archiver.kernel.org>; Mon, 24 Feb 2020 17:57:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727474AbgBXR5J (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 24 Feb 2020 12:57:09 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:41150 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727259AbgBXR5J (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 24 Feb 2020 12:57:09 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01OHoBHx134160
        for <selinux@vger.kernel.org>; Mon, 24 Feb 2020 12:57:08 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2yayb01gm2-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <selinux@vger.kernel.org>; Mon, 24 Feb 2020 12:57:08 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <selinux@vger.kernel.org> from <zohar@linux.ibm.com>;
        Mon, 24 Feb 2020 17:57:06 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 24 Feb 2020 17:57:03 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 01OHv2Rl54788320
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Feb 2020 17:57:02 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 09FFD11C058;
        Mon, 24 Feb 2020 17:57:02 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7996D11C04C;
        Mon, 24 Feb 2020 17:57:00 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.188.252])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 24 Feb 2020 17:57:00 +0000 (GMT)
Subject: Re: [PATCH v15 02/23] LSM: Create and manage the lsmblob data
 structure.
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Casey Schaufler <casey@schaufler-ca.com>,
        casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        Janne Karhunen <janne.karhunen@gmail.com>
Cc:     keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov
Date:   Mon, 24 Feb 2020 12:56:59 -0500
In-Reply-To: <20200214234203.7086-3-casey@schaufler-ca.com>
References: <20200214234203.7086-1-casey@schaufler-ca.com>
         <20200214234203.7086-3-casey@schaufler-ca.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 20022417-0020-0000-0000-000003AD2EBA
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20022417-0021-0000-0000-0000220541B2
Message-Id: <1582567019.10443.140.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-24_07:2020-02-21,2020-02-24 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0 mlxscore=0
 bulkscore=0 mlxlogscore=999 clxscore=1011 suspectscore=2 spamscore=0
 malwarescore=0 priorityscore=1501 impostorscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002240132
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

[Cc'ing Janne Karhunen]

On Fri, 2020-02-14 at 15:41 -0800, Casey Schaufler wrote:
<snip>
> diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
> index 453427048999..624ed1a34842 100644
> --- a/security/integrity/ima/ima_policy.c
> +++ b/security/integrity/ima/ima_policy.c
> @@ -75,7 +75,7 @@ struct ima_rule_entry {
>  	bool (*fowner_op)(kuid_t, kuid_t); /* uid_eq(), uid_gt(), uid_lt() */
>  	int pcr;
>  	struct {
> -		void *rule;	/* LSM file metadata specific */
> +		void *rules[LSMBLOB_ENTRIES];
>  		void *args_p;	/* audit value */
>  		int type;	/* audit type */
>  	} lsm[MAX_LSM_RULES];
> @@ -84,6 +84,16 @@ struct ima_rule_entry {
>  	struct ima_template_desc *template;
>  };
> 
> +static inline bool ima_lsm_isset(void *rules[])
> +{
> +	int i;
> +
> +	for (i = 0; i < LSMBLOB_ENTRIES; i++)
> +		if (rules[i])
> +			return true;
> +	return false;
> +}
> +

Even though ima_lsm_isset() is static, it should really be commented.

>  /*
>   * Without LSM specific knowledge, the default policy can only be
>   * written in terms of .action, .func, .mask, .fsmagic, .uid, and .fowner
> @@ -258,9 +268,11 @@ __setup("ima_appraise_tcb", default_appraise_policy_setup);
>  static void ima_lsm_free_rule(struct ima_rule_entry *entry)
>  {
>  	int i;
> +	int r;
> 
>  	for (i = 0; i < MAX_LSM_RULES; i++) {
> -		kfree(entry->lsm[i].rule);
> +		for (r = 0; r < LSMBLOB_ENTRIES; r++)
> +			kfree(entry->lsm[i].rules[r]);
>  		kfree(entry->lsm[i].args_p);
>  	}
>  	kfree(entry);
> @@ -295,8 +307,8 @@ static struct ima_rule_entry *ima_lsm_copy_rule(struct ima_rule_entry *entry)
>  		security_filter_rule_init(nentry->lsm[i].type,
>  					  Audit_equal,
>  					  nentry->lsm[i].args_p,
> -					  &nentry->lsm[i].rule);
> -		if (!nentry->lsm[i].rule)
> +					  nentry->lsm[i].rules);
> +		if (!ima_lsm_isset(nentry->lsm[i].rules))
>  			pr_warn("rule for LSM \'%s\' is undefined\n",
>  				(char *)entry->lsm[i].args_p);

Janne, the generic LSM message looks fine, but should there also be an
LSM specific warning the first time it changes?

Mimi

