Return-Path: <SRS0=oqVN=6N=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC672C83003
	for <selinux@archiver.kernel.org>; Wed, 29 Apr 2020 13:15:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86BF821974
	for <selinux@archiver.kernel.org>; Wed, 29 Apr 2020 13:15:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="czXsNHIV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726797AbgD2NPI (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 29 Apr 2020 09:15:08 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:36118 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726558AbgD2NPH (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 29 Apr 2020 09:15:07 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03TD9J5a089736;
        Wed, 29 Apr 2020 13:14:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=mime-version :
 message-id : date : from : to : cc : subject : references : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=VV+TtgnM87vuUChG0Zw87MJS37UkJ0IzlgYUObe8IOw=;
 b=czXsNHIVgsZDlCYK7ch1CEkG1dO9uwV89/4ZM9Q3anSz9ZuXGYffjst+xVfcCubynQ7v
 y7em3aQl8u+IGi0g/S9iG0EbK7GPanBEmCPH8RG7M1BAvpZWK1xEK8y0MVgMXr3vCiJc
 5PsDtDVUJTUZufZDIyLOEhNe6n0GvXy2s9vH3AgaQPf0JW0xxDl01sNoBNyy9faHjb4S
 oWASTvWiIZzkq6XiD47VzeF313Glmhr9miYvrF9TkLwRGij9E8LqLKHgET/61NtSyk2i
 2vsZ9/7ctYEJrVRs2Nn42iqeNjl7eYdBRL6MeEhbfRWdF1WuvvCLFVhZMCBEPaQ9MPII fQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 30p2p0b21e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Apr 2020 13:14:55 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03TD8DKj114565;
        Wed, 29 Apr 2020 13:14:54 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 30mxrv2ttp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Apr 2020 13:14:54 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 03TDEovT032406;
        Wed, 29 Apr 2020 13:14:50 GMT
Received: from kadam (/41.57.98.10) by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Wed, 29 Apr 2020 06:07:45 -0700
USER-AGENT: Mutt/1.9.4 (2018-02-28)
MIME-Version: 1.0
Message-ID: <20200429130738.GQ2014@kadam>
Date:   Wed, 29 Apr 2020 06:07:38 -0700 (PDT)
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Wei Yongjun <weiyongjun1@huawei.com>
Cc:     Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        Jeff Vander Stoep <jeffv@google.com>,
        selinux@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH -next] selinux: fix error return code in policydb_read()
References: <20200429073053.83660-1-weiyongjun1@huawei.com>
In-Reply-To: <20200429073053.83660-1-weiyongjun1@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9605 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 suspectscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004290111
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9605 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 clxscore=1011
 bulkscore=0 adultscore=0 lowpriorityscore=0 impostorscore=0 malwarescore=0
 mlxscore=0 suspectscore=0 mlxlogscore=999 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004290111
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Apr 29, 2020 at 07:30:53AM +0000, Wei Yongjun wrote:
> Fix to return negative error code -ENOMEM from the kvcalloc() error
> handling case instead of 0, as done elsewhere in this function.
> 

Please add a Fixes tag and Cc Kent.

Fixes: acdf52d97f82 ("selinux: convert to kvmalloc")


> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> ---
>  security/selinux/ss/policydb.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
> index a0b3dc152468..a51e051df2cc 100644
> --- a/security/selinux/ss/policydb.c
> +++ b/security/selinux/ss/policydb.c
> @@ -2638,6 +2638,7 @@ int policydb_read(struct policydb *p, void *fp)
>  	if (rc)
>  		goto bad;
>  
> +	rc = -ENOMEM;
>  	p->type_attr_map_array = kvcalloc(p->p_types.nprim,
>  					  sizeof(*p->type_attr_map_array),
>  					  GFP_KERNEL);

There is another bug earlier in the function as well:

security/selinux/ss/policydb.c
  2537  
  2538          rc = next_entry(buf, fp, sizeof(u32));
  2539          if (rc)
  2540                  goto bad;
  2541          nel = le32_to_cpu(buf[0]);
  2542  
  2543          p->role_tr = hashtab_create(role_trans_hash, role_trans_cmp, nel);
  2544          if (!p->role_tr)
  2545                  goto bad;
                        ^^^^^^^^

  2546          for (i = 0; i < nel; i++) {
  2547                  rc = -ENOMEM;

This style of setting the error code seems very bug prone.

The Fixes tag for this one is:
Fixes: e67b2ec9f617 ("selinux: store role transitions in a hash table")

Just put both tags in the commit message.

regards,
dan carpenter
