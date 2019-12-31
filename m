Return-Path: <SRS0=uw/3=2V=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46FF1C2D0C2
	for <selinux@archiver.kernel.org>; Tue, 31 Dec 2019 13:13:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21FC4205ED
	for <selinux@archiver.kernel.org>; Tue, 31 Dec 2019 13:13:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726229AbfLaNN3 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 31 Dec 2019 08:13:29 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:23802 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726659AbfLaNN3 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 31 Dec 2019 08:13:29 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBVD7LAL091755
        for <selinux@vger.kernel.org>; Tue, 31 Dec 2019 08:13:28 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2x6nejrd9b-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <selinux@vger.kernel.org>; Tue, 31 Dec 2019 08:13:27 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <selinux@vger.kernel.org> from <zohar@linux.ibm.com>;
        Tue, 31 Dec 2019 13:13:25 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 31 Dec 2019 13:13:21 -0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xBVDDKNT56098828
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 31 Dec 2019 13:13:20 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A3B9A42047;
        Tue, 31 Dec 2019 13:13:20 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 502FF42041;
        Tue, 31 Dec 2019 13:13:19 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.184.68])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 31 Dec 2019 13:13:19 +0000 (GMT)
Subject: Re: [PATCH v13 03/25] LSM: Use lsmblob in security_audit_rule_match
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Casey Schaufler <casey@schaufler-ca.com>,
        casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov, Janne Karhunen <janne.karhunen@gmail.com>
Date:   Tue, 31 Dec 2019 08:13:18 -0500
In-Reply-To: <20191224235939.7483-4-casey@schaufler-ca.com>
References: <20191224235939.7483-1-casey@schaufler-ca.com>
         <20191224235939.7483-4-casey@schaufler-ca.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19123113-0020-0000-0000-0000039CCA25
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19123113-0021-0000-0000-000021F412DB
Message-Id: <1577797998.5874.75.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-31_03:2019-12-30,2019-12-31 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 phishscore=0 mlxscore=0 spamscore=0 suspectscore=2 impostorscore=0
 mlxlogscore=999 adultscore=0 lowpriorityscore=0 priorityscore=1501
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912310115
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

[Cc'ing Janne Karhunen based on his recent work updating IMA policy
rules LSM id's - commit b16942455193 ("ima: use the lsm policy update
notifier")]

On Tue, 2019-12-24 at 15:59 -0800, Casey Schaufler wrote:
> diff --git a/security/security.c b/security/security.c
> index 87fc70f77660..12e1e6223233 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -439,7 +439,7 @@ static int lsm_append(const char *new, char **result)
>  /*
>   * Current index to use while initializing the lsmblob secid list.
>   */
> -static int lsm_slot __initdata;
> +static int lsm_slot __lsm_ro_after_init;
> 
>  /**
>   * security_add_hooks - Add a modules hooks to the hook lists.
> @@ -2412,9 +2412,21 @@ void security_audit_rule_free(void *lsmrule)
>  	call_void_hook(audit_rule_free, lsmrule);
>  }
> 
> -int security_audit_rule_match(u32 secid, u32 field, u32 op, void *lsmrule)
> +int security_audit_rule_match(struct lsmblob *blob, u32 field, u32 op,
> +			      void *lsmrule)
>  {
> -	return call_int_hook(audit_rule_match, 0, secid, field, op, lsmrule);
> +	struct security_hook_list *hp;
> +	int rc;
> +
> +	hlist_for_each_entry(hp, &security_hook_heads.audit_rule_match, list) {
> +		if (WARN_ON(hp->lsmid->slot < 0 || hp->lsmid->slot >= lsm_slot))
> +			continue;
> +		rc = hp->hook.audit_rule_match(blob->secid[hp->lsmid->slot],
> +					       field, op, lsmrule);

IMA's policy rules may be written in terms of LSM labels.  On IMA
policy initialization and, subsequently, when the LSM policy is
updated, IMA correlates LSM labels with LSM ids.  Doesn't
security_audit_rule_init() also need to be updated to walk the LSMs?

The basic assumption with security_audit_rule_match() is that there
isn't any naming overlap.  Is that guaranteed?  With this change, do
the IMA policy rules now need to be LSM qualified?

Mimi

> +		if (rc != 0)
> +			return rc;
> +	}
> +	return 0;
>  }
>  #endif /* CONFIG_AUDIT */

