Return-Path: <SRS0=mV6Z=6S=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4742BC3A5A9
	for <selinux@archiver.kernel.org>; Mon,  4 May 2020 19:19:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 259EC20707
	for <selinux@archiver.kernel.org>; Mon,  4 May 2020 19:19:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Vposmwi0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725981AbgEDTT1 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 4 May 2020 15:19:27 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:59020 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725956AbgEDTT1 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 4 May 2020 15:19:27 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 044JHxQZ101267;
        Mon, 4 May 2020 19:19:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=qhx1l6jqlA8KLf1Dssj0T3p0m5jI4IfKYNYmy2YmRyI=;
 b=Vposmwi0h5L5OaqwcXQij5CLPQYtQrD2f1G4p3gBxMQ6YzdUGGppFrWq3dlWXbM41TAt
 k39miqKRnhngRYCS8tfKfFDqaWfaa7hamYaQe/cVKGN2Ca8znKYYfH4UEnHf+bYM1vwq
 CHxIYkaj3C2PkXyIs/fFSyRIrvf3SOiWbWKEU92s3sDKhxzksZ8unTKXwtJ6bmYkBUfM
 L6PVJOeIZy2+1sTIQz2Bbg5u1nP+e/UjWECfyBjYzQMucF5QJP/nvz9RCBJRID4LdVSb
 Tmyj9kJ/cMivWzZifkMb7IJrcU3CqxQZ2wrpAXJot3QROL6fa5mgeopPLQs45cjVUM3I wA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 30s1gn0pq3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 May 2020 19:19:13 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 044JGi4s121758;
        Mon, 4 May 2020 19:17:12 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 30sjdr6csu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 May 2020 19:17:12 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 044JH8mg030154;
        Mon, 4 May 2020 19:17:09 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 04 May 2020 12:17:08 -0700
Date:   Mon, 4 May 2020 22:17:00 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     Wei Yongjun <weiyongjun1@huawei.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        Jeff Vander Stoep <jeffv@google.com>,
        selinux@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH -next] selinux: fix error return code in policydb_read()
Message-ID: <20200504191700.GV2014@kadam>
References: <20200429073053.83660-1-weiyongjun1@huawei.com>
 <20200429130738.GQ2014@kadam>
 <CAHC9VhT1-rV3heNWxcKo58AVsvhGeX5=oTQY8d8uahpMhwbJrA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHC9VhT1-rV3heNWxcKo58AVsvhGeX5=oTQY8d8uahpMhwbJrA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9610 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 mlxscore=0
 bulkscore=0 adultscore=0 phishscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005040151
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9610 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0 mlxscore=0
 spamscore=0 clxscore=1015 priorityscore=1501 bulkscore=0 phishscore=0
 impostorscore=0 malwarescore=0 lowpriorityscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005040151
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, May 01, 2020 at 12:46:47PM -0400, Paul Moore wrote:
> On Wed, Apr 29, 2020 at 9:15 AM Dan Carpenter <dan.carpenter@oracle.com> wrote:
> > On Wed, Apr 29, 2020 at 07:30:53AM +0000, Wei Yongjun wrote:
> > > Fix to return negative error code -ENOMEM from the kvcalloc() error
> > > handling case instead of 0, as done elsewhere in this function.
> >
> > Please add a Fixes tag and Cc Kent.
> 
> Kent?  Who is Kent?

commit acdf52d97f824019888422842757013b37441dd1
Author: Kent Overstreet <kent.overstreet@gmail.com>
Date:   Mon Mar 11 23:31:10 2019 -0700

    selinux: convert to kvmalloc

regards,
dan carepnter

