Return-Path: <SRS0=oqVN=6N=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 335CEC83006
	for <selinux@archiver.kernel.org>; Wed, 29 Apr 2020 13:49:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 127FA2083B
	for <selinux@archiver.kernel.org>; Wed, 29 Apr 2020 13:49:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="nnOkb+PW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727057AbgD2Ntr (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 29 Apr 2020 09:49:47 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:36656 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726765AbgD2Ntr (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 29 Apr 2020 09:49:47 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03TDmrus060234;
        Wed, 29 Apr 2020 13:49:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=XPl7khAJVlMJvnMhzcBb4TztA3fFxHexfhbx8rcJQQk=;
 b=nnOkb+PWxbkHVpDAv3Pa+P77VkBqx2AyLQn7dp2mdaWsfQtCaHVSHcqyBnP1T6jovR6c
 ZvHUxk/f66dzkMtJeXSY0qOQiS0pkL1IyrNnxoVTUvk0+MNRsA8bd8Othu9wmp97tBBQ
 sknta8xDVDnw2TsghVB0cSp3J//1cv7KsN8+wD6BpkxH9KHwXiPfJcG+7DZkKF4lJqLm
 nc8+k1LniLpmnjWCMBMwjjJGJTzp5z74hU04oa0XPFiEEsaWzKMB8QP/qkLKTQDvK9Id
 /8XKvM28hDW9bCrDqtYY/bZz2L9dpDwg40BZc8OBD7s8BrUy/jTHrQs/QtMPYhsl8LhD eA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 30nucg5u3r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Apr 2020 13:49:34 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03TDcpMu171959;
        Wed, 29 Apr 2020 13:47:33 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 30mxpk2f8f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Apr 2020 13:47:33 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 03TDlVke022101;
        Wed, 29 Apr 2020 13:47:31 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 29 Apr 2020 06:47:31 -0700
Date:   Wed, 29 Apr 2020 16:47:24 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     Wei Yongjun <weiyongjun1@huawei.com>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Jeff Vander Stoep <jeffv@google.com>,
        SElinux list <selinux@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH -next] selinux: fix error return code in policydb_read()
Message-ID: <20200429134724.GR2014@kadam>
References: <20200429073053.83660-1-weiyongjun1@huawei.com>
 <20200429130738.GQ2014@kadam>
 <CAFqZXNs=YTn-mnzSEssR1szRhSw7Ajdaqg=wy88O_F3gBL2rOQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFqZXNs=YTn-mnzSEssR1szRhSw7Ajdaqg=wy88O_F3gBL2rOQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9605 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 mlxscore=0 bulkscore=0 adultscore=0 phishscore=0 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004290115
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9605 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 priorityscore=1501
 mlxlogscore=999 impostorscore=0 suspectscore=0 malwarescore=0
 lowpriorityscore=0 mlxscore=0 spamscore=0 adultscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004290115
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Apr 29, 2020 at 03:32:13PM +0200, Ondrej Mosnacek wrote:
> On Wed, Apr 29, 2020 at 3:15 PM Dan Carpenter <dan.carpenter@oracle.com> wrote:
> > On Wed, Apr 29, 2020 at 07:30:53AM +0000, Wei Yongjun wrote:
> > > Fix to return negative error code -ENOMEM from the kvcalloc() error
> > > handling case instead of 0, as done elsewhere in this function.
> > >
> >
> > Please add a Fixes tag and Cc Kent.
> >
> > Fixes: acdf52d97f82 ("selinux: convert to kvmalloc")
> >
> >
> > > Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> > > ---
> > >  security/selinux/ss/policydb.c | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
> > > index a0b3dc152468..a51e051df2cc 100644
> > > --- a/security/selinux/ss/policydb.c
> > > +++ b/security/selinux/ss/policydb.c
> > > @@ -2638,6 +2638,7 @@ int policydb_read(struct policydb *p, void *fp)
> > >       if (rc)
> > >               goto bad;
> > >
> > > +     rc = -ENOMEM;
> > >       p->type_attr_map_array = kvcalloc(p->p_types.nprim,
> > >                                         sizeof(*p->type_attr_map_array),
> > >                                         GFP_KERNEL);
> >
> > There is another bug earlier in the function as well:
> >
> > security/selinux/ss/policydb.c
> >   2537
> >   2538          rc = next_entry(buf, fp, sizeof(u32));
> >   2539          if (rc)
> >   2540                  goto bad;
> >   2541          nel = le32_to_cpu(buf[0]);
> >   2542
> >   2543          p->role_tr = hashtab_create(role_trans_hash, role_trans_cmp, nel);
> >   2544          if (!p->role_tr)
> >   2545                  goto bad;
> >                         ^^^^^^^^
> >
> >   2546          for (i = 0; i < nel; i++) {
> >   2547                  rc = -ENOMEM;
> >
> > This style of setting the error code seems very bug prone.
> >
> > The Fixes tag for this one is:
> > Fixes: e67b2ec9f617 ("selinux: store role transitions in a hash table")
> 
> FYI, this one is also indirectly fixed by this patch, which is
> currently pending review:
> https://patchwork.kernel.org/patch/11514495/
> 

Ah.  Fantastic.  Wei, could you just resend your original commit with
the first Fixes tag and Kent CC'd?

regards,
dan carpenter

