Return-Path: <SRS0=5g5+=ZY=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DC2DC43215
	for <selinux@archiver.kernel.org>; Mon,  2 Dec 2019 15:58:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E18722146E
	for <selinux@archiver.kernel.org>; Mon,  2 Dec 2019 15:58:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727556AbfLBP6j (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 2 Dec 2019 10:58:39 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:4218 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727555AbfLBP6j (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 2 Dec 2019 10:58:39 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xB2FvQjd183169
        for <selinux@vger.kernel.org>; Mon, 2 Dec 2019 10:58:38 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2wm6g8j9se-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <selinux@vger.kernel.org>; Mon, 02 Dec 2019 10:58:37 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <selinux@vger.kernel.org> from <zohar@linux.ibm.com>;
        Mon, 2 Dec 2019 15:58:35 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 2 Dec 2019 15:58:32 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xB2FwV5p57671888
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 2 Dec 2019 15:58:31 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4E839A4051;
        Mon,  2 Dec 2019 15:58:31 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7C22AA4057;
        Mon,  2 Dec 2019 15:58:30 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.147.107])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  2 Dec 2019 15:58:30 +0000 (GMT)
Subject: Re: [GIT PULL] SELinux patches for v5.5
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        Roberto Sassu <roberto.sassu@huawei.com>,
        initramfs <initramfs@vger.kernel.org>
Date:   Mon, 02 Dec 2019 10:58:30 -0500
In-Reply-To: <CAHC9VhRj-vx8AnP5tKcq9joNqWSHRv1bk+3e7DGU9mxjN+fVFg@mail.gmail.com>
References: <CAHC9VhRj-vx8AnP5tKcq9joNqWSHRv1bk+3e7DGU9mxjN+fVFg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19120215-0020-0000-0000-000003927D0F
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19120215-0021-0000-0000-000021E99932
Message-Id: <1575302310.4793.379.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-02_03:2019-11-29,2019-12-02 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 priorityscore=1501
 suspectscore=0 clxscore=1011 mlxlogscore=999 impostorscore=0
 lowpriorityscore=0 adultscore=0 malwarescore=0 spamscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912020141
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

[Truncated Cc list, adding Roberto and the initramfs mailing list]

Hi Paul,

On Tue, 2019-11-26 at 16:24 -0500, Paul Moore wrote:

> - Allow file labeling before the policy is loaded.  This should ease
> some of the burden when the policy is initially loaded (no need to
> relabel files), but it should also help enable some new system
> concepts which dynamically create the root filesystem in the initrd.

Any chance you're planning on using Roberto's patches for including
security xattrs in the initramfs?[1]  Any help reviewing his patches
would be much appreciated!

thanks,

Mimi

[1] https://www.spinics.net/lists/linux-initramfs/msg04771.html

