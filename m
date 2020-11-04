Return-Path: <SRS0=XO28=EK=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53B7CC2D0A3
	for <selinux@archiver.kernel.org>; Wed,  4 Nov 2020 07:02:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE52C2225B
	for <selinux@archiver.kernel.org>; Wed,  4 Nov 2020 07:02:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ANJPjk0O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727001AbgKDHCK (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 4 Nov 2020 02:02:10 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:33876 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725926AbgKDHCK (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 4 Nov 2020 02:02:10 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0A46WCtX130877;
        Wed, 4 Nov 2020 02:01:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : references : date : in-reply-to : message-id : mime-version :
 content-type; s=pp1; bh=YzP75st8LTQCFMRonrMqa7EYecxPL4AjHvqtXuuDhZQ=;
 b=ANJPjk0Oin0smoDwtN2LOk83JWLaXIQp7NU40Ky4fTPgqcPZMTh12A7P1JVPleYFC19u
 b7X398QFQ9NWe+ZFbVI75bTqo4J9kV+2dpP1HuZUwDm/7lJS8SUya9V31fEu53ZkmLLz
 5NH8UfiyBbsjJ238RMdsIie6w67bxOuCkqnCf850AjeHEjXrvyAMourOgWkXy7jyIn5b
 NhBCXTr0OcKvOuEDdytmqBfN6K1J3k7B7LNamaETCr6ncYSIGE30mNawJeERnNvxVKTX
 4umdT3GEkw0jpyN6j1k1x70wQF3iGlVWR2oVxSyGZ+HeIPR1hMGK9FAq6iJ0rkJQiMUb mw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 34kdmr7knr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 04 Nov 2020 02:01:55 -0500
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0A46hF11171819;
        Wed, 4 Nov 2020 02:01:53 -0500
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 34kdmr7kmd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 04 Nov 2020 02:01:53 -0500
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0A46q0Tb000737;
        Wed, 4 Nov 2020 07:01:50 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma03ams.nl.ibm.com with ESMTP id 34hm6hb90f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 04 Nov 2020 07:01:50 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0A471lAC65733054
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 4 Nov 2020 07:01:47 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 665B24C040;
        Wed,  4 Nov 2020 07:01:47 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0C1B74C058;
        Wed,  4 Nov 2020 07:01:47 +0000 (GMT)
Received: from tuxmaker.linux.ibm.com (unknown [9.152.85.9])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed,  4 Nov 2020 07:01:46 +0000 (GMT)
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
        <yt9dpn4u9scs.fsf@linux.ibm.com>
        <CAHC9VhRxm=YR1yBy8fnWPXRZ48pq4MA4b26YAtqAJORJZD61wg@mail.gmail.com>
Date:   Wed, 04 Nov 2020 08:01:46 +0100
In-Reply-To: <CAHC9VhRxm=YR1yBy8fnWPXRZ48pq4MA4b26YAtqAJORJZD61wg@mail.gmail.com>
        (Paul Moore's message of "Tue, 3 Nov 2020 21:42:35 -0500")
Message-ID: <yt9dpn4twqp1.fsf@linux.ibm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-04_03:2020-11-04,2020-11-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 priorityscore=1501 adultscore=0 mlxlogscore=829 mlxscore=0
 bulkscore=0 suspectscore=8 phishscore=0 clxscore=1015 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011040044
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Hi Paul,

Paul Moore <paul@paul-moore.com> writes:

> On Tue, Nov 3, 2020 at 2:02 PM Sven Schnelle <svens@linux.ibm.com> wrote:
>> Thanks for the patch. Unfortunately it doesn't seem to change anything
>> for me. I can take a look into this tomorrow, but i don't know much
>> about the internals of selinux, so i'm not sure whether i'm of much help.
>
> I'm sorry that patch didn't work out.  I just spent some more time
> looking at the code+patch and the only other thing that I can see is
> that if we mark the isec invalid, we don't bother setting the
> isec->sid value to whatever default we may have already found.  In a
> perfect world this shouldn't matter, but if for whatever reason the
> kernel can't revalidate the inode's label when it tries later it will
> fallback to that default isec->sid.
>
> I'm sorry to ask this again, but would you be able to test the attached patch?

This patch fixes the issue. So it looks like your assumption is right.

Thanks
Sven
