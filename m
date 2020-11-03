Return-Path: <SRS0=PQdl=EJ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFAEDC2D0A3
	for <selinux@archiver.kernel.org>; Tue,  3 Nov 2020 13:14:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C2D122243
	for <selinux@archiver.kernel.org>; Tue,  3 Nov 2020 13:14:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="SiYxK4T8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729160AbgKCNOQ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 3 Nov 2020 08:14:16 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:11480 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729085AbgKCNOO (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 3 Nov 2020 08:14:14 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0A3D421E034026;
        Tue, 3 Nov 2020 08:13:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : in-reply-to : references : date : message-id : mime-version :
 content-type; s=pp1; bh=uBVsmjERMUz8ak9zNeRjiWv5n6TGmuaChWnQU9v5Wn0=;
 b=SiYxK4T8f8gbqmGQMJJhZsLwCeui9XJyMCM+Rz33ER0gip34tJ55EktDzNNFRRrvQW22
 INO96EpJ838Jc0tC6Dh82AuBG9KBKUGgZ6t5We6L7WH2QMUC6dqjsSYE3NPqNI2qxETV
 522HXtPN0MOJzzudwqMDOU5O+2ZCB2wjlJCc+v6Lu5NA1T9otMzfm5AxcM6WavN7G2QN
 pIsqNM2DzNFio0L2NsGAlx2x/mxjWkrIZLwe1DWMq7Z1Gx/JNbiWoHt7FUMuDVO6Db5R
 IrMoIHk9j4C6W7QlrecAJ3Sj6ilbxeqdE3Q0ixmNxtUNx6oY7FMWQEy74yq+EekY7G7y yw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 34k5rwvap8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 03 Nov 2020 08:13:30 -0500
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0A3D4FJP034719;
        Tue, 3 Nov 2020 08:13:30 -0500
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0b-001b2d01.pphosted.com with ESMTP id 34k5rwvane-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 03 Nov 2020 08:13:30 -0500
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0A3DD89v010665;
        Tue, 3 Nov 2020 13:13:28 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma06ams.nl.ibm.com with ESMTP id 34h0fcu93e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 03 Nov 2020 13:13:28 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0A3DDPdm57868546
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 3 Nov 2020 13:13:25 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C616142047;
        Tue,  3 Nov 2020 13:13:25 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6542042041;
        Tue,  3 Nov 2020 13:13:25 +0000 (GMT)
Received: from tuxmaker.linux.ibm.com (unknown [9.152.85.9])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue,  3 Nov 2020 13:13:25 +0000 (GMT)
From:   Sven Schnelle <svens@linux.ibm.com>
To:     rentianyue@tj.kylinos.cn
Cc:     Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Andreas Gruenbacher <agruenba@redhat.com>, yangzhao@kylinos.cn,
        selinux@vger.kernel.org, Tianyue Ren <rentianyue@kylinos.cn>,
        linux-s390@vger.kernel.org, hca@linux.ibm.com,
        borntraeger@de.ibm.com
Subject: Re: [PATCH v3 1/1] selinux: fix error initialization in
 inode_doinit_with_dentry()
In-Reply-To: <CAHC9VhR2KPKN8ot9WrkjZQ08X-VPDGkXro18C5jhDEwcFH6wog@mail.gmail.com>
References: <CAHC9VhQTp3Rc_7zM661Rzur0XSuWRWKJJg=CwLPAQo5ABRpS-w@mail.gmail.com>
        <20201009013630.6777-1-rentianyue@tj.kylinos.cn>
        <20201009013630.6777-2-rentianyue@tj.kylinos.cn>
        <CAHC9VhR2KPKN8ot9WrkjZQ08X-VPDGkXro18C5jhDEwcFH6wog@mail.gmail.com>
Date:   Tue, 03 Nov 2020 14:13:25 +0100
Message-ID: <yt9dh7q64m8a.fsf@linux.ibm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-03_08:2020-11-03,2020-11-03 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 phishscore=0 impostorscore=0 malwarescore=0 suspectscore=15
 mlxlogscore=999 bulkscore=0 spamscore=0 priorityscore=1501 adultscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011030086
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Paul Moore <paul@paul-moore.com> writes:

> On Thu, Oct 8, 2020 at 9:37 PM <rentianyue@tj.kylinos.cn> wrote:
>> From: Tianyue Ren <rentianyue@kylinos.cn>
>>
>> Mark the inode security label as invalid if we cannot find
>> a dentry so that we will retry later rather than marking it
>> initialized with the unlabeled SID.
>>
>> Fixes: 9287aed2ad1f ("selinux: Convert isec->lock into a spinlock")
>> Signed-off-by: Tianyue Ren <rentianyue@kylinos.cn>
>> ---
>>  security/selinux/hooks.c | 19 ++++++++++++++++---
>>  1 file changed, 16 insertions(+), 3 deletions(-)
>
> Merged into selinux/next with some minor tweaks to the comments.
> Thanks for your help!

This seems to break booting on s390:

Welcome to Fedora 32 (Thirty Two)!
 
[    1.434571] systemd[1]: Set hostname to <xxx.xxx>
[    1.436839] audit: type=1400 audit(1604408868.681:4): avc:  denied  { write } for  pid=1 comm="systemd" dev="cgroup2" ino=2 scontext=system_u:sys
tem_r:init_t:s0 tcontext=system_u:object_r:unlabeled_t:s0 tclass=file permissive=0 
[    1.436840] systemd[1]: Failed to create /init.scope control group: Permission denied 
[    1.438039] systemd[1]: Failed to allocate manager object: Permission denied 
[ [0;1;31m!!!!!! [0m] Failed to allocate manager object. 
[    1.438281] systemd[1]: Freezing execution.

Any ideas? If i revert 83370b31a915493231e5b9addc72e4bef69f8d31 from
linux-next-20201103 it works fine...

Thanks
Sven
