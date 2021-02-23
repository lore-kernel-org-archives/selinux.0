Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 565D6C433E0
	for <selinux@archiver.kernel.org>; Tue, 23 Feb 2021 00:28:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF13B64DDC
	for <selinux@archiver.kernel.org>; Tue, 23 Feb 2021 00:28:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230079AbhBWA2M (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 22 Feb 2021 19:28:12 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:17346 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229902AbhBWA2M (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 22 Feb 2021 19:28:12 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11N03u8t080253;
        Mon, 22 Feb 2021 19:27:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=5J1oNfAJAZAWoxjtw2qcZ2zBoDJIV8/0RoNc1tVrOmU=;
 b=TuaJ0zDVYIg4AY90MBndgHRlYvzfK4jqgc1ESE1iyR8uvrJ/GoI6ngmI1q9M0WS2DAjE
 Lr9oTlDH4U+L9r7yseWCriPaycgoYIbqaAU8Q4NlKG5yPkg6wMjQba8ZSIr/GB1DRIc9
 7ktZjt5jITTiDDui4Gy8dcX7FZM4m1j6vcun7GAAUP5qXknNWXujDz1OX9p4WLs+ha1p
 +OWpEXU859OTC3D9DjzPfoBbMEZNmEdvX3YfGVyKz3J4W1H0rhDoFiau+HV7QtaJUA6V
 ty3WJbQlDMWQnOoP+oN4Umq/hZCa5NWMOeC53Zr6/m8eHuIHpJI4H9gySmyCYljGs92N BQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 36vkehyd7g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 Feb 2021 19:27:16 -0500
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 11N04Hin082615;
        Mon, 22 Feb 2021 19:27:16 -0500
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0b-001b2d01.pphosted.com with ESMTP id 36vkehyd75-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 Feb 2021 19:27:16 -0500
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 11N0CAcv005954;
        Tue, 23 Feb 2021 00:27:14 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma02fra.de.ibm.com with ESMTP id 36tt2893mj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 23 Feb 2021 00:27:14 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 11N0RC7l43319652
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 Feb 2021 00:27:12 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F07384C044;
        Tue, 23 Feb 2021 00:27:11 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 030404C040;
        Tue, 23 Feb 2021 00:27:09 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.211.63.56])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 23 Feb 2021 00:27:08 +0000 (GMT)
Message-ID: <3862fed24a1265611f71327ddb444e52557bdc7c.camel@linux.ibm.com>
Subject: Re: [PATCH v24 04/25] IMA: avoid label collisions with stacked LSMs
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Casey Schaufler <casey@schaufler-ca.com>,
        casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     linux-audit@redhat.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov,
        linux-kernel@vger.kernel.org
Date:   Mon, 22 Feb 2021 19:27:07 -0500
In-Reply-To: <77ebed19-2912-d8f2-cb4d-3f782c8e7f18@schaufler-ca.com>
References: <20210126164108.1958-1-casey@schaufler-ca.com>
         <20210126164108.1958-5-casey@schaufler-ca.com>
         <693f81d9d2f50a920cafbbc8d1d634598b99081a.camel@linux.ibm.com>
         <77ebed19-2912-d8f2-cb4d-3f782c8e7f18@schaufler-ca.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-14.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-22_08:2021-02-22,2021-02-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 clxscore=1015 bulkscore=0 impostorscore=0 phishscore=0 mlxlogscore=999
 lowpriorityscore=0 suspectscore=0 spamscore=0 priorityscore=1501
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102220208
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, 2021-02-22 at 15:45 -0800, Casey Schaufler wrote:
> On 2/14/2021 10:21 AM, Mimi Zohar wrote:
> 
> Would these changes match your suggestion?
> 
>  security/integrity/ima/ima_policy.c | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
> index 9ac673472781..e80956548243 100644
> --- a/security/integrity/ima/ima_policy.c
> +++ b/security/integrity/ima/ima_policy.c
> @@ -78,11 +78,11 @@ struct ima_rule_entry {
>  	bool (*uid_op)(kuid_t, kuid_t);    /* Handlers for operators       */
>  	bool (*fowner_op)(kuid_t, kuid_t); /* uid_eq(), uid_gt(), uid_lt() */
>  	int pcr;
> +	int which_lsm; /* which of the rules to use */
>  	struct {
>  		void *rules[LSMBLOB_ENTRIES]; /* LSM file metadata specific */

If each IMA policy rule may only contain a single LSM specific
LSM_OBJ_{USER | ROLE | TYPE} and LSM_SUBJ_{USER | ROLE | TYPE}, then
there is no need for rules[LSMBLOB_ENTRIES].  Leave it as "*rule".

Otherwise it looks good.

Mimi

>  		char *args_p;	/* audit value */
>  		int type;	/* audit type */
> -		int which_lsm; /* which of the rules to use */
>  	} lsm[MAX_LSM_RULES];
>  	char *fsname;
>  	struct ima_rule_opt_list *keyrings; /* Measure keys added to these keyrings */

