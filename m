Return-Path: <SRS0=Kf9N=CD=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A9BBC433E1
	for <selinux@archiver.kernel.org>; Tue, 25 Aug 2020 15:05:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CCC342075F
	for <selinux@archiver.kernel.org>; Tue, 25 Aug 2020 15:05:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="nQjUWSmv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726851AbgHYPF2 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 25 Aug 2020 11:05:28 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:41442 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726804AbgHYPFV (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 25 Aug 2020 11:05:21 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07PF4htM156286;
        Tue, 25 Aug 2020 15:05:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=+MsGdOeNEwfGCn5iu752F9bvPs/sLrdWiugcV53CeGw=;
 b=nQjUWSmv8V/yUzzUNsZze/PlWkhcCs70vlfWp+wOE5sLfxkThGj8fZXpFqlZDNsl7v+H
 mfmCpmX9F/UFdXrZbHbhD4xEiqg204ycrP2Qu8ZeF3rpGXT64azA926vcykp4FVYVSpj
 uRpt7cj0uflafACW3afD5lnIW4GaO3TXPmWJ9OWGHWPrq9kOkcrckjW3+AbMvEln8Dyd
 ATJfaLXrbfq+y/v1UB7OM+Mjretxs5QeCA+ABuGrDWo7gK4mcYlZJbKZGojGVKxeqmG8
 pdtFheHxJ65L+DDhnn5kn4NoZ7Va1ZW0uP9/nDbrIDfR6QcpuQYBDVkYcgKJh1Mwvt8R 4g== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 333csj33dj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 25 Aug 2020 15:05:00 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07PEtJ9u115138;
        Tue, 25 Aug 2020 15:03:00 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 333r9jnrj0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Aug 2020 15:03:00 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 07PF2xZF011350;
        Tue, 25 Aug 2020 15:02:59 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 25 Aug 2020 08:02:59 -0700
Date:   Tue, 25 Aug 2020 18:02:53 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        selinux@vger.kernel.org
Subject: Re: [bug report] selinux: encapsulate policy state, refactor policy
 load
Message-ID: <20200825150252.GU5493@kadam>
References: <20200825125130.GA304650@mwanda>
 <CAHC9VhS5pAr8g9C18cniKDrh3NRgg1z8e3qYs14P1iBpioOS7w@mail.gmail.com>
 <20200825141242.GT5493@kadam>
 <CAHC9VhRn17jYSWo2oUobn=7uHv7G=HD0QRJZZgQhR10UGBU7=Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHC9VhRn17jYSWo2oUobn=7uHv7G=HD0QRJZZgQhR10UGBU7=Q@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9723 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 suspectscore=0 malwarescore=0 spamscore=0 mlxlogscore=999 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008250113
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9723 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 clxscore=1015
 spamscore=0 priorityscore=1501 impostorscore=0 adultscore=0
 lowpriorityscore=0 suspectscore=0 mlxlogscore=999 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008250114
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Aug 25, 2020 at 10:16:27AM -0400, Paul Moore wrote:
> 
> Patches are welcome :)
> 

Good.  Patches coming up tomorrow.  :)

regards,
dan carpenter

