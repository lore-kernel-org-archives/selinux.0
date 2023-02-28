Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC7B1C64ED6
	for <selinux@archiver.kernel.org>; Tue, 28 Feb 2023 20:13:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229592AbjB1UNG (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 28 Feb 2023 15:13:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbjB1UNG (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 28 Feb 2023 15:13:06 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E70DA15881;
        Tue, 28 Feb 2023 12:13:03 -0800 (PST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31SJKtB7013059;
        Tue, 28 Feb 2023 20:12:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=qYUAQSuTtTP2ywwAOGafLdz9DPSpAk4kTZ7aDGeFU4c=;
 b=KIhlTxjAT82D0GLB7ci1OAjqV/4/oQRGDysOOXkenH34TG8kIrmIMNMuXbxu6sHDJIGD
 lzGtDIu7VmZ9AoYWHIf7H8D+c6CnyFoA6pBdLAN+5cSoR1Vk3+6cEymOa09B2I3coxTX
 vJyyvDoaweh3qHsa87EFz0NxOKQTNO+CSzxXTReO8coNEi75VwREd/mIWkrbmw6WVOiu
 vGcSnqyRw5wIZF0ijgEpIvCGbZoY0pDKFwWvO0zjIMnnEMMLDiWNLL51j9aWTbWWCqWP
 NETGk16XUVFW5I3HWQQofaXBOtMd0drAf7S3tEv4bMnuN8lSiR2EQdUkAGO71v40qQT0 9Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3p1qpj978h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Feb 2023 20:12:59 +0000
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 31SK1Vri023619;
        Tue, 28 Feb 2023 20:12:59 GMT
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3p1qpj9782-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Feb 2023 20:12:58 +0000
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 31SIZDEq024508;
        Tue, 28 Feb 2023 20:12:57 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([9.208.130.100])
        by ppma05wdc.us.ibm.com (PPS) with ESMTPS id 3nybe9jvxh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Feb 2023 20:12:57 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
        by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 31SKCuIA4588046
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Feb 2023 20:12:56 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BA9AF58055;
        Tue, 28 Feb 2023 20:12:56 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1B1CD5805D;
        Tue, 28 Feb 2023 20:12:56 +0000 (GMT)
Received: from sig-9-65-248-59.ibm.com (unknown [9.65.248.59])
        by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 28 Feb 2023 20:12:56 +0000 (GMT)
Message-ID: <6ae09db579b6fa4702c8c31bb84c2d06102f67ab.camel@linux.ibm.com>
Subject: Re: [PATCH testsuite 1/3] policy: make sure test_ibpkey_access_t
 can lock enough memory
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Paul Moore <paul@paul-moore.com>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        Chris PeBenito <pebenito@ieee.org>
Cc:     selinux@vger.kernel.org, selinux-refpolicy@vger.kernel.org
Date:   Tue, 28 Feb 2023 15:12:55 -0500
In-Reply-To: <CAHC9VhQnCchbn+kgZQ4cxUQKWCKd=H02R++qeKtqR75BpZETxQ@mail.gmail.com>
References: <20230228141247.626736-1-omosnace@redhat.com>
         <20230228141247.626736-2-omosnace@redhat.com>
         <CAHC9VhQnCchbn+kgZQ4cxUQKWCKd=H02R++qeKtqR75BpZETxQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 5PWymrCdmJWIHSbO01BXpFWKWf4iixVP
X-Proofpoint-GUID: yMMJsMh70fwGuoDOYDMw36mfvwSfRqYu
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-02-28_17,2023-02-28_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 mlxlogscore=965 adultscore=0 impostorscore=0 mlxscore=0 malwarescore=0
 spamscore=0 priorityscore=1501 lowpriorityscore=0 clxscore=1011
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302280166
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, 2023-02-28 at 11:51 -0500, Paul Moore wrote:
> On Tue, Feb 28, 2023 at 9:13 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> >
> > The ibv_create_cq() operation requires the caller to be able to lock
> > enough memory (RLIMIT_MEMLOCK). In some environments (such as RHEL-8)
> > the default resource limits may not be enough, requiring CAP_IPC_LOCK to
> > go above the limit. To make sure the test works also under stricter
> > resource limits, grant CAP_IPC_LOCK to test_ibpkey_access_t.
> >
> > Reported-by: Mimi Zohar <zohar@linux.ibm.com>
> > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> > ---
> >  policy/test_ibpkey.te | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/policy/test_ibpkey.te b/policy/test_ibpkey.te
> > index 863ff16..97f0c3c 100644
> > --- a/policy/test_ibpkey.te
> > +++ b/policy/test_ibpkey.te
> > @@ -10,6 +10,8 @@ type test_ibpkey_access_t;
> >  testsuite_domain_type(test_ibpkey_access_t)
> >  typeattribute test_ibpkey_access_t ibpkeydomain;
> >
> > +allow test_ibpkey_access_t self:capability ipc_lock;
> 
> FWIW, I brought this up back in 2019 and have been carrying a local
> selinux-testsuite patch for this ever since (it's the only way to get
> a clean run of the IB tests).

Confirmed, with this change the SELinux infiniband tests are now
working on stable linux-4.19.y.

> While it can be fixed in the
> selinux-testsuite policy, I believe this is a more general problem and
> should probably be fixed in refpol.
> 
> https://lore.kernel.org/selinux/CAHC9VhTuYi+W0RukEV4WNrP5X_AFeouaWMsdbgxSL1v04mouWw@mail.gmail.com/
> 
> >  dev_rw_infiniband_dev(test_ibpkey_access_t)
> >  dev_rw_sysfs(test_ibpkey_access_t)

-- 
thanks,

Mimi


