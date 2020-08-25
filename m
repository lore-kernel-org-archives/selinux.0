Return-Path: <SRS0=Kf9N=CD=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F494C433DF
	for <selinux@archiver.kernel.org>; Tue, 25 Aug 2020 14:12:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ECCF42075F
	for <selinux@archiver.kernel.org>; Tue, 25 Aug 2020 14:12:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="vtU5AJtf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726095AbgHYOM6 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 25 Aug 2020 10:12:58 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:55308 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725998AbgHYOM5 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 25 Aug 2020 10:12:57 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07PE9Pri085215;
        Tue, 25 Aug 2020 14:12:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=F7hEqocWVM3mnakCSLOGFz26upWRY1jhdAuPWf1mAvU=;
 b=vtU5AJtfyik2J4I6qtbrGXLmlSh/8tPALFax4A3Sjbd9EdKBqOV5KT/nX1FylF6MFida
 0dvwqUD3oHqGFAQ9wg8ERTQrTOLu3uZgTDCdlHE7jEhUHw3AAIvW/sjcNpIyjVmX4fBR
 cZFsHSO2rTssTiUcIaGK9XN2KCZMbPqyoDIRQZfrhqLvp0xMvTn8P884Y/BWK4DqVhVv
 qjai/xFFu1GW4R/XdvtjWPxQTeMlgyQtOv8ZnAfYgJXLoRsBRvj5oCTtL+/X52VPampB
 SXSizjTMUXzxprp50qPfKgFcYABH0b61n79RPpnEZ/ueOjdIl5NltMGvUFzkZTnbWIto WQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 333w6ts8f0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 25 Aug 2020 14:12:50 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07PEABV7023899;
        Tue, 25 Aug 2020 14:12:50 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 333ru7mra9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Aug 2020 14:12:50 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 07PECmWO017865;
        Tue, 25 Aug 2020 14:12:49 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 25 Aug 2020 07:12:48 -0700
Date:   Tue, 25 Aug 2020 17:12:43 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        selinux@vger.kernel.org
Subject: Re: [bug report] selinux: encapsulate policy state, refactor policy
 load
Message-ID: <20200825141242.GT5493@kadam>
References: <20200825125130.GA304650@mwanda>
 <CAHC9VhS5pAr8g9C18cniKDrh3NRgg1z8e3qYs14P1iBpioOS7w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHC9VhS5pAr8g9C18cniKDrh3NRgg1z8e3qYs14P1iBpioOS7w@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9723 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 bulkscore=0 suspectscore=2 spamscore=0 mlxscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008250108
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9723 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 impostorscore=0
 mlxlogscore=999 suspectscore=2 phishscore=0 malwarescore=0 spamscore=0
 priorityscore=1501 clxscore=1011 mlxscore=0 lowpriorityscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008250108
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Aug 25, 2020 at 09:38:22AM -0400, Paul Moore wrote:
> On Tue, Aug 25, 2020 at 8:51 AM Dan Carpenter <dan.carpenter@oracle.com> wrote:
> >
> > Hello Stephen Smalley,
> >
> > The patch 461698026ffa: "selinux: encapsulate policy state, refactor
> > policy load" from Aug 7, 2020, leads to the following static checker
> > warning:
> >
> >         security/selinux/ss/services.c:2288 security_load_policy()
> >         error: we previously assumed 'newpolicy->sidtab' could be null (see line 2227)
> >
> > security/selinux/ss/services.c
> >   2221
> >   2222          newpolicy = kzalloc(sizeof(*newpolicy), GFP_KERNEL);
> >   2223          if (!newpolicy)
> >   2224                  return -ENOMEM;
> >   2225
> >   2226          newpolicy->sidtab = kzalloc(sizeof(*newpolicy->sidtab), GFP_KERNEL);
> >   2227          if (!newpolicy->sidtab)
> >   2228                  goto err;
> 
> ...
> 
> >   2287  err:
> >   2288          selinux_policy_free(newpolicy);
> >
> > This style of "one function frees everything" error handling is the
> > most bug prone style of error handling ...
> 
> In this particular case I think the use of selinux_poicy_free() is
> okay, we should just make selinux_policy_free() a bit more robust,
> e.g. checking that ->sidtab is non-NULL before calling
> sidtab_destroy().  While we are at it, it probably wouldn't hurt to
> also check ->policydb.

There are other bugs on this path as well.  For example in context_cpy():

   150  static inline int context_cpy(struct context *dst, struct context *src)
   151  {
   152          int rc;
   153  
   154          dst->user = src->user;
   155          dst->role = src->role;
   156          dst->type = src->type;
   157          if (src->str) {
   158                  dst->str = kstrdup(src->str, GFP_ATOMIC);
   159                  if (!dst->str)
   160                          return -ENOMEM;
   161                  dst->len = src->len;
   162          } else {
   163                  dst->str = NULL;
   164                  dst->len = 0;
   165          }
   166          rc = mls_context_cpy(dst, src);
   167          if (rc) {
   168                  kfree(dst->str);
                              ^^^^^^^^
This is the right place to free it.  That's what other coders generally
expect and what static analysis tools expect.  Otherwise it's not clear
if it's the caller which should free it or the caller's caller.  In this
code we free it in all three places.

   169                  return rc;
   170          }
   171          return 0;
   172  }

regards,
dan carpenter
