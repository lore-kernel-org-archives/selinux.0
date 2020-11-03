Return-Path: <SRS0=PQdl=EJ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD02AC2D0A3
	for <selinux@archiver.kernel.org>; Tue,  3 Nov 2020 19:02:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 63B412074B
	for <selinux@archiver.kernel.org>; Tue,  3 Nov 2020 19:02:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="r26fcWu6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729536AbgKCTCa (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 3 Nov 2020 14:02:30 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42644 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727688AbgKCTC3 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 3 Nov 2020 14:02:29 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0A3J1rJm099398;
        Tue, 3 Nov 2020 14:02:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : references : date : in-reply-to : message-id : mime-version :
 content-type; s=pp1; bh=ibVjWhKmFik2faUYu2uakXS4z98x5a28SI0oDBfyW+A=;
 b=r26fcWu6EsmzY0kuwstooDcizNrrSP7I5Bify37lMIa/UTOi+dUwAacT2XRPMUuPATPE
 w4lsNL2BH5CVMrR44BPMFGai/PXviQstV1N4qsq2bJWhE1QuPHJzwflrNxIzUFVExY2J
 Z1254sDb3mJbAJNr7O8Bs/KN8O06WqjIyWPiLGuh0DYIYFE2R5y5JBXm7SXlmEVb78gw
 Y1rDlnZJgMpyT0AJYr/fHWlcZ9picJ8H8JlCKVNq0efXx9IH17RjFoqpubort12cpK5y
 3rD0tgkhh21PQRmtDQyug8wUTpWf3rnuM5bL0GC6OFHbLGLV+WVs1D1J8wWfpoHKb3WQ Nw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 34k9bws2f2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 03 Nov 2020 14:02:18 -0500
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0A3J2Hp9101713;
        Tue, 3 Nov 2020 14:02:17 -0500
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com with ESMTP id 34k9bws2e9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 03 Nov 2020 14:02:17 -0500
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0A3Im1WX002858;
        Tue, 3 Nov 2020 19:02:15 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma06fra.de.ibm.com with ESMTP id 34h01khtv4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 03 Nov 2020 19:02:15 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0A3J2Cxu8717010
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 3 Nov 2020 19:02:12 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5D21AA405E;
        Tue,  3 Nov 2020 19:02:12 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0AC7EA404D;
        Tue,  3 Nov 2020 19:02:12 +0000 (GMT)
Received: from tuxmaker.linux.ibm.com (unknown [9.152.85.9])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue,  3 Nov 2020 19:02:11 +0000 (GMT)
From:   Sven Schnelle <svens@linux.ibm.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     rentianyue@tj.kylinos.cn,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Andreas Gruenbacher <agruenba@redhat.com>, yangzhao@kylinos.cn,
        selinux@vger.kernel.org, Tianyue Ren <rentianyue@kylinos.cn>,
        linux-s390@vger.kernel.org, hca@linux.ibm.com,
        borntraeger@de.ibm.com
Subject: Re: [PATCH v3 1/1] selinux: fix error initialization in
 inode_doinit_with_dentry()
References: <CAHC9VhQTp3Rc_7zM661Rzur0XSuWRWKJJg=CwLPAQo5ABRpS-w@mail.gmail.com>
        <20201009013630.6777-1-rentianyue@tj.kylinos.cn>
        <20201009013630.6777-2-rentianyue@tj.kylinos.cn>
        <CAHC9VhR2KPKN8ot9WrkjZQ08X-VPDGkXro18C5jhDEwcFH6wog@mail.gmail.com>
        <yt9dh7q64m8a.fsf@linux.ibm.com>
        <CAHC9VhT-dgT8pP7ZfPu+Ssw4RAYUpcwhTWfXXeciVPz0mRcP3A@mail.gmail.com>
Date:   Tue, 03 Nov 2020 20:02:11 +0100
In-Reply-To: <CAHC9VhT-dgT8pP7ZfPu+Ssw4RAYUpcwhTWfXXeciVPz0mRcP3A@mail.gmail.com>
        (Paul Moore's message of "Tue, 3 Nov 2020 12:11:08 -0500")
Message-ID: <yt9dpn4u9scs.fsf@linux.ibm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-03_08:2020-11-03,2020-11-03 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1015
 bulkscore=0 spamscore=0 impostorscore=0 lowpriorityscore=0 phishscore=0
 mlxlogscore=999 mlxscore=0 priorityscore=1501 adultscore=0 suspectscore=9
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011030125
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Hi Paul,

Paul Moore <paul@paul-moore.com> writes:

> On Tue, Nov 3, 2020 at 8:14 AM Sven Schnelle <svens@linux.ibm.com> wrote:
>> Paul Moore <paul@paul-moore.com> writes:
>>
>> > On Thu, Oct 8, 2020 at 9:37 PM <rentianyue@tj.kylinos.cn> wrote:
>> >> From: Tianyue Ren <rentianyue@kylinos.cn>
>> >>
>> >> Mark the inode security label as invalid if we cannot find
>> >> a dentry so that we will retry later rather than marking it
>> >> initialized with the unlabeled SID.
>> >>
>> >> Fixes: 9287aed2ad1f ("selinux: Convert isec->lock into a spinlock")
>> >> Signed-off-by: Tianyue Ren <rentianyue@kylinos.cn>
>> >> ---
>> >>  security/selinux/hooks.c | 19 ++++++++++++++++---
>> >>  1 file changed, 16 insertions(+), 3 deletions(-)
>> >
>> > Merged into selinux/next with some minor tweaks to the comments.
>> > Thanks for your help!
>>
>> This seems to break booting on s390:
>>
>> Welcome to Fedora 32 (Thirty Two)!
>>
>> [    1.434571] systemd[1]: Set hostname to <xxx.xxx>
>> [    1.436839] audit: type=1400 audit(1604408868.681:4): avc:  denied  { write } for  pid=1 comm="systemd" dev="cgroup2" ino=2 scontext=system_u:sys
>> tem_r:init_t:s0 tcontext=system_u:object_r:unlabeled_t:s0 tclass=file permissive=0
>> [    1.436840] systemd[1]: Failed to create /init.scope control group: Permission denied
>> [    1.438039] systemd[1]: Failed to allocate manager object: Permission denied
>> [ [0;1;31m!!!!!! [0m] Failed to allocate manager object.
>> [    1.438281] systemd[1]: Freezing execution.
>>
>> Any ideas? If i revert 83370b31a915493231e5b9addc72e4bef69f8d31 from
>> linux-next-20201103 it works fine...
>
> Thanks for the report.
>
> Looking at this again, I'm thinking that setting the isec->initialized
> field outside of the spinlock is probably a bad idea.  My guess is
> that your system is racing on inode_doinit_with_dentry() and the
> initialized field is getting messed up.
>
> Any chance you could try the attached (completely untested) patch?

Thanks for the patch. Unfortunately it doesn't seem to change anything
for me. I can take a look into this tomorrow, but i don't know much
about the internals of selinux, so i'm not sure whether i'm of much help.

Regards
Sven
