Return-Path: <SRS0=Xw2L=2J=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69FC5C43603
	for <selinux@archiver.kernel.org>; Thu, 19 Dec 2019 21:11:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4455E24679
	for <selinux@archiver.kernel.org>; Thu, 19 Dec 2019 21:11:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726963AbfLSVLk (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 19 Dec 2019 16:11:40 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:14870 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726908AbfLSVLj (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 19 Dec 2019 16:11:39 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBJL7fOX038557
        for <selinux@vger.kernel.org>; Thu, 19 Dec 2019 16:11:38 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2x07fqs1qd-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <selinux@vger.kernel.org>; Thu, 19 Dec 2019 16:11:38 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <selinux@vger.kernel.org> from <zohar@linux.ibm.com>;
        Thu, 19 Dec 2019 21:11:36 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 19 Dec 2019 21:11:33 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xBJLBXe930998550
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Dec 2019 21:11:33 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EAE7CA4062;
        Thu, 19 Dec 2019 21:11:32 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B4D40A405F;
        Thu, 19 Dec 2019 21:11:31 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.194.51])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 19 Dec 2019 21:11:31 +0000 (GMT)
Subject: Re: [PATCH v12 02/25] LSM: Create and manage the lsmblob data
 structure.
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Casey Schaufler <casey@schaufler-ca.com>,
        casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov
Date:   Thu, 19 Dec 2019 16:11:31 -0500
In-Reply-To: <20191216223621.5127-3-casey@schaufler-ca.com>
References: <20191216223621.5127-1-casey@schaufler-ca.com>
         <20191216223621.5127-3-casey@schaufler-ca.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19121921-0008-0000-0000-00000342B54D
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19121921-0009-0000-0000-00004A62D065
Message-Id: <1576789891.5660.3.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-19_06:2019-12-17,2019-12-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 lowpriorityscore=0 bulkscore=0 mlxscore=0 adultscore=0 mlxlogscore=815
 phishscore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912190156
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, 2019-12-16 at 14:35 -0800, Casey Schaufler wrote:
> When more than one security module is exporting data to
> audit and networking sub-systems a single 32 bit integer
> is no longer sufficient to represent the data. Add a
> structure to be used instead.
> 
> The lsmblob structure is currently an array of
> u32 "secids". There is an entry for each of the
> security modules built into the system that would
> use secids if active. The system assigns the module
> a "slot" when it registers hooks. If modules are
> compiled in but not registered there will be unused
> slots.
> 
> A new lsm_id structure, which contains the name
> of the LSM and its slot number, is created. There
> is an instance for each LSM, which assigns the name
> and passes it to the infrastructure to set the slot.
> 
> Reviewed-by: John Johansen <john.johansen@canonical.com>
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>  include/linux/lsm_hooks.h  | 12 ++++++--
>  include/linux/security.h   | 58 ++++++++++++++++++++++++++++++++++++++
>  security/apparmor/lsm.c    |  7 ++++-
>  security/commoncap.c       |  7 ++++-
>  security/loadpin/loadpin.c |  8 +++++-
>  security/safesetid/lsm.c   |  8 +++++-
>  security/security.c        | 28 ++++++++++++++----
>  security/selinux/hooks.c   |  8 +++++-
>  security/smack/smack_lsm.c |  7 ++++-
>  security/tomoyo/tomoyo.c   |  8 +++++-
>  security/yama/yama_lsm.c   |  7 ++++-
>  11 files changed, 142 insertions(+), 16 deletions(-)

security/lockdown/lockdown.c is missing.  I'm getting a compiler
error.

Mimi

