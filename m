Return-Path: <SRS0=HUo+=EL=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 266E6C00A89
	for <selinux@archiver.kernel.org>; Thu,  5 Nov 2020 09:03:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB708206FB
	for <selinux@archiver.kernel.org>; Thu,  5 Nov 2020 09:03:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="IyyNgWxG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725320AbgKEJDY (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 5 Nov 2020 04:03:24 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:64400 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730154AbgKEJDT (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 5 Nov 2020 04:03:19 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0A58XqRI009848;
        Thu, 5 Nov 2020 04:03:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : references : date : in-reply-to : message-id : mime-version :
 content-type; s=pp1; bh=BF3En31LtomYKakXazsluOMlB9XZV1SJ/0J5bosipB0=;
 b=IyyNgWxGpK2B7EH3kmGazY08gQCdseRXqQrCZ3E/iA5Y2DdeGuZrzKZoxfSkHRCo63Vw
 GzxSYFI90IjmBEfo0nTLmWXiDGvKCQI3sv1MLpKSnWFlbcronH2e7TTfKJxnEsYGvrGN
 YnxfM/fDroD67Cefhw+NQydLIPnW1RvPiG/cRokgDvDFPKo2zw11UpwIqavNXEZ1Pu7w
 MdUNL4jYC5bASwkfdMzmWWYuFlizaSYSEoqpfAfEodtGY8lcMpY6i1NCxEZ8ElmpMzgT
 7lA8dZCFP88P8a9hrIO8opmWaWt0FQphKz9iSNQ6YPqOdvwrkszyYuxKzezr6JDZGCGc fw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 34m6n34fyu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 05 Nov 2020 04:03:18 -0500
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0A58Ydrh013547;
        Thu, 5 Nov 2020 04:03:17 -0500
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 34m6n34fxn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 05 Nov 2020 04:03:17 -0500
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0A591sVC010914;
        Thu, 5 Nov 2020 09:03:14 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma03ams.nl.ibm.com with ESMTP id 34hm6hcf2k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 05 Nov 2020 09:03:14 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0A593CWY2621980
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 5 Nov 2020 09:03:12 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 983C34C059;
        Thu,  5 Nov 2020 09:03:12 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 715AA4C046;
        Thu,  5 Nov 2020 09:03:12 +0000 (GMT)
Received: from tuxmaker.linux.ibm.com (unknown [9.152.85.9])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu,  5 Nov 2020 09:03:12 +0000 (GMT)
From:   Sven Schnelle <svens@linux.ibm.com>
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     Paul Moore <paul@paul-moore.com>,
        SElinux list <selinux@vger.kernel.org>
Subject: Re: [PATCH] selinux: fix inode_doinit_with_dentry() LABEL_INVALID
 error handling
References: <160453882404.5064.13236738388118581389.stgit@sifl>
        <CAFqZXNuM_Cv6jrxibEMZpzJA2jUiU8jif9_LrnN8oS2LU8Q_oA@mail.gmail.com>
Date:   Thu, 05 Nov 2020 10:03:12 +0100
In-Reply-To: <CAFqZXNuM_Cv6jrxibEMZpzJA2jUiU8jif9_LrnN8oS2LU8Q_oA@mail.gmail.com>
        (Ondrej Mosnacek's message of "Thu, 5 Nov 2020 09:55:38 +0100")
Message-ID: <yt9dh7q4kwfj.fsf@linux.ibm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-05_02:2020-11-05,2020-11-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 mlxlogscore=999 mlxscore=0 phishscore=0 clxscore=1015
 adultscore=0 bulkscore=0 suspectscore=0 impostorscore=0 lowpriorityscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011050063
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Ondrej Mosnacek <omosnace@redhat.com> writes:

> On Thu, Nov 5, 2020 at 2:13 AM Paul Moore <paul@paul-moore.com> wrote:
>> A previous fix, commit 83370b31a915 ("selinux: fix error initialization
>> in inode_doinit_with_dentry()"), changed how failures were handled
>> before a SELinux policy was loaded.  Unfortunately that patch was
>> potentially problematic for two reasons: it set the isec->initialized
>> state without holding a lock, and it didn't set the inode's SELinux
>> label to the "default" for the particular filesystem.  The later can
>> be a problem if/when a later attempt to revalidate the inode fails
>> and SELinux reverts to the existing inode label.
>>
>> This patch should restore the default inode labeling that existed
>> before the original fix, without affecting the LABEL_INVALID marking
>> such that revalidation will still be attempted in the future.
>>
>> Fixes: 83370b31a915 ("selinux: fix error initialization in inode_doinit_with_dentry()")
>> Reported-by: Sven Schnelle <svens@linux.ibm.com>
>> Signed-off-by: Paul Moore <paul@paul-moore.com>
>> ---
>>  security/selinux/hooks.c |   31 +++++++++++++------------------
>>  1 file changed, 13 insertions(+), 18 deletions(-)
>
> FWIW, the patch looks good to me.
>
> Reviewed-by: Ondrej Mosnacek <omosnace@redhat.com>

I just tested it on s390, works fine.

Tested-by: Sven Schnelle <svens@linux.ibm.com>

Thanks
Sven
