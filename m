Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D318C433E9
	for <selinux@archiver.kernel.org>; Wed, 24 Feb 2021 16:51:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C61764F06
	for <selinux@archiver.kernel.org>; Wed, 24 Feb 2021 16:51:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235628AbhBXQup (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 24 Feb 2021 11:50:45 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:7064 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235600AbhBXQu2 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 24 Feb 2021 11:50:28 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11OGdFF9195336;
        Wed, 24 Feb 2021 11:49:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=hxMuZAGfdNXyb+XcesIBUzjrYop11lXKyA26AOH0kLk=;
 b=pFpkCTWSPx+2s4XbxiQMx5txXqEZ+DRJQwpot63QWE3NKqkoaXA1tjWG1lcaFVyHCtHQ
 OYdqFi0GUNVy6ebJvw5TAQA3mY+bCvhjK+9oqpULIPaHE9Nk0bPNfa7GnYrAZgZt+qq9
 +hE3McUirA4E9bbZsXnNiHu1MQqnB0sqXM4miWin/sX1+m4mCCIYBrvNtlDE/LkiuOth
 mz9RvJt0sthnrVus228m5B9zthq6TMo8UzYrQ3vTMlTIqrWLHF5aFOi49GWzUAZgxuFI
 v8PkfFvmNmQyBmvg3YNFqBB2eJXIknhLNOkwfUFBL464Qyep6iypf+1yXJW1DNYkDUD0 rw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36wk3trsd1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 Feb 2021 11:49:42 -0500
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 11OGfH3s007548;
        Wed, 24 Feb 2021 11:49:42 -0500
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36wk3trsce-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 Feb 2021 11:49:42 -0500
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 11OGlFcp028582;
        Wed, 24 Feb 2021 16:49:40 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma04fra.de.ibm.com with ESMTP id 36tt289y69-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 Feb 2021 16:49:39 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 11OGnbqJ38601000
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Feb 2021 16:49:37 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 74C2842047;
        Wed, 24 Feb 2021 16:49:37 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DF0C042041;
        Wed, 24 Feb 2021 16:49:35 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.211.37.44])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 24 Feb 2021 16:49:35 +0000 (GMT)
Message-ID: <dcc3df948dc18cc91888f4d5b6bd18e6aafc8007.camel@linux.ibm.com>
Subject: Re: [RFC PATCH 1/4] lsm: separate security_task_getsecid() into
 subjective and objective variants
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Paul Moore <paul@paul-moore.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        John Johansen <john.johansen@canonical.com>
Cc:     linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-audit@redhat.com
Date:   Wed, 24 Feb 2021 11:49:34 -0500
In-Reply-To: <161377734508.87807.8537642254664217815.stgit@sifl>
References: <161377712068.87807.12246856567527156637.stgit@sifl>
         <161377734508.87807.8537642254664217815.stgit@sifl>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-14.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-24_06:2021-02-24,2021-02-24 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=999 spamscore=0 phishscore=0 mlxscore=0 malwarescore=0
 suspectscore=0 adultscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102240127
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, 2021-02-19 at 18:29 -0500, Paul Moore wrote:
> Of the three LSMs that implement the security_task_getsecid() LSM
> hook, all three LSMs provide the task's objective security
> credentials.  This turns out to be unfortunate as most of the hook's
> callers seem to expect the task's subjective credentials, although
> a small handful of callers do correctly expect the objective
> credentials.
> 
> This patch is the first step towards fixing the problem: it splits
> the existing security_task_getsecid() hook into two variants, one
> for the subjective creds, one for the objective creds.
> 
>   void security_task_getsecid_subj(struct task_struct *p,
> 				   u32 *secid);
>   void security_task_getsecid_obj(struct task_struct *p,
> 				  u32 *secid);
> 
> While this patch does fix all of the callers to use the correct
> variant, in order to keep this patch focused on the callers and to
> ease review, the LSMs continue to use the same implementation for
> both hooks.  The net effect is that this patch should not change
> the behavior of the kernel in any way, it will be up to the latter
> LSM specific patches in this series to change the hook
> implementations and return the correct credentials.
> 
> Signed-off-by: Paul Moore <paul@paul-moore.com>

Thanks, Paul.

Acked-by: Mimi Zohar <zohar@linux.ibm.com>  (IMA)

