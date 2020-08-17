Return-Path: <SRS0=6AtE=B3=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9D47C433E1
	for <selinux@archiver.kernel.org>; Mon, 17 Aug 2020 23:43:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A7B692072E
	for <selinux@archiver.kernel.org>; Mon, 17 Aug 2020 23:43:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="DwYLzi8K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726341AbgHQXnd (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 17 Aug 2020 19:43:33 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:40176 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726328AbgHQXnc (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 17 Aug 2020 19:43:32 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07HNVTht142111;
        Mon, 17 Aug 2020 19:43:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=yVH+6yOPo/7laPxqV+p2URfIJgvLhJORLAKkAeKkfIs=;
 b=DwYLzi8KkqJWklSGBe/80W9PR2Ql1PkXRv7DTyX48GZ6ZI6Tk32en8vUbVhj6UYpmMry
 4bq6qu9nyIyRqJpGAX7N40DxZvWMPpnmgCIItjeIOFd7mxoiMjahch3MZFL3jG8a2IsN
 32AJT9svDYUaNzgKTq0sOlzEllij2vvXRDqF7Y3HwE1mzGeuYLuec8/o8BMK3aIxam+Z
 2JElbGBYoiTbjp7Yrh48yNYR3doqXUGG8VkLPqW8J2wh+jyzkU+0vx7AyNtZuxr4wunw
 1/TXy4Z1kA8h15eZmJrVUZJn2U8CY/j0kEln04St/QE/aF1WWsQmaJ7h6RIWcmtFZjq1 jg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 32y69wuut8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Aug 2020 19:43:26 -0400
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 07HNXfQV146317;
        Mon, 17 Aug 2020 19:43:26 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 32y69wuusp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Aug 2020 19:43:26 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 07HNeeCV020326;
        Mon, 17 Aug 2020 23:43:24 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma04ams.nl.ibm.com with ESMTP id 32x7b82san-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Aug 2020 23:43:24 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 07HNhMcx27853158
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 Aug 2020 23:43:22 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0CE6911C054;
        Mon, 17 Aug 2020 23:43:22 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 48A8E11C050;
        Mon, 17 Aug 2020 23:43:19 +0000 (GMT)
Received: from sig-9-65-192-88.ibm.com (unknown [9.65.192.88])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 17 Aug 2020 23:43:19 +0000 (GMT)
Message-ID: <97d25609b6a87f104cc88a2ff8ae52d3f2e4e387.camel@linux.ibm.com>
Subject: Re: [PATCH 2/3] IMA: add policy to support measuring critical data
 from kernel components
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Tushar Sugandhi <tusharsu@linux.microsoft.com>,
        stephen.smalley.work@gmail.com, casey@schaufler-ca.com,
        gmazyland@gmail.com
Cc:     tyhicks@linux.microsoft.com, sashal@kernel.org, jmorris@namei.org,
        linux-integrity@vger.kernel.org, selinux@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dm-devel@redhat.com,
        nramas@linux.microsoft.com
Date:   Mon, 17 Aug 2020 19:43:18 -0400
In-Reply-To: <5275268e-2ce8-0129-b11d-8419ac384262@linux.microsoft.com>
References: <20200812193102.18636-1-tusharsu@linux.microsoft.com>
         <20200812193102.18636-3-tusharsu@linux.microsoft.com>
         <591b5f09c7df8ef0378866eaf3afde7a7cb4e82f.camel@linux.ibm.com>
         <5275268e-2ce8-0129-b11d-8419ac384262@linux.microsoft.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-12.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-17_15:2020-08-17,2020-08-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 spamscore=0 mlxscore=0 suspectscore=3 mlxlogscore=999 impostorscore=0
 phishscore=0 priorityscore=1501 adultscore=0 lowpriorityscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008170154
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, 2020-08-17 at 15:27 -0700, Tushar Sugandhi wrote:

> > scripts/Lindent isn't as prevalent as it used to be, but it's still
> > included in Documentation/process/coding-style.rst.  Use it as a guide.
> Thanks for the pointer. We'll use scripts/Lindent going forward

Please don't change existing code to conform to it.  Use it as a
guide/suggestion for new code.

Mimi



