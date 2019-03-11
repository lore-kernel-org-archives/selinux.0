Return-Path: <SRS0=naTH=RO=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23FC4C43381
	for <selinux@archiver.kernel.org>; Mon, 11 Mar 2019 19:29:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E766D214AE
	for <selinux@archiver.kernel.org>; Mon, 11 Mar 2019 19:29:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="fRlWtWXR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727424AbfCKT34 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 11 Mar 2019 15:29:56 -0400
Received: from ucol19pa13.eemsg.mail.mil ([214.24.24.86]:6579 "EHLO
        ucol19pa13.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727153AbfCKT34 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 11 Mar 2019 15:29:56 -0400
X-EEMSG-check-017: 685983421|UCOL19PA13_EEMSG_MP11.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.39,1,1493683200"; 
   d="scan'208";a="685983421"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by ucol19pa13.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 11 Mar 2019 19:27:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1552332470; x=1583868470;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=Y77ebXXT7MRSyEcNNV7Zwa8+hqjVLQA5O20/SlhIN6k=;
  b=fRlWtWXR7QkheuLGMMaCAA3urTZjQKBybXleKdg1sGrgpmFB9VOsOUBQ
   34wZLw0t0qKwJz4qy8BvgXI3BEZosb5IiBaCpfLhAsKMz5rpuwN/bRERc
   eW0xiY2/jg22TnWfmdvGFf+2pvN3Tydl+2mqe1m9yqP+hyMlWepFgGKCI
   I9O6YcJ/wk+uElJlIB/zI/h4LIYe1Q0whmTH/xJjBooGt2QE8YgLUb/zQ
   Pmes9CBhVSq1e2xVCRtNWqnNiqfzx/nbIXhrULH+wctI+QVrC9D0QXHGf
   ZACHG/pr4tgBTDDoKB+ksojz/KsBzsiKWsXcj8oSc9UyDyVc8H3NTMUGB
   A==;
X-IronPort-AV: E=Sophos;i="5.58,468,1544486400"; 
   d="scan'208";a="24900461"
IronPort-PHdr: =?us-ascii?q?9a23=3APMmCdR0TvCmOUWcFsmDT+DRfVm0co7zxezQtwd?=
 =?us-ascii?q?8ZseIVK/ad9pjvdHbS+e9qxAeQG9mCs7Qc0qL/iOPJYSQ4+5GPsXQPItRndi?=
 =?us-ascii?q?QuroEopTEmG9OPEkbhLfTnPGQQFcVGU0J5rTngaRAGUMnxaEfPrXKs8DUcBg?=
 =?us-ascii?q?vwNRZvJuTyB4Xek9m72/q99pHOfwlEniaxba5vJxiqsAvdsdUbj5F/Iagr0B?=
 =?us-ascii?q?vJpXVIe+VSxWx2IF+Yggjx6MSt8pN96ipco/0u+dJOXqX8ZKQ4UKdXDC86PG?=
 =?us-ascii?q?Av5c3krgfMQA2S7XYBSGoWkx5IAw/Y7BHmW5r6ryX3uvZh1CScIMb5Q6o0WT?=
 =?us-ascii?q?C/5Kl1ThHmhjoMOzog/GzXjsF8iaRWqw+jqRNi2Y7ZeJybOuRwfq3dft0US2?=
 =?us-ascii?q?ROUclTWCNdDY2xdJcPAugbMOpEs4XwqVkDoB2jDgesHuPvzTpIi2fr060mze?=
 =?us-ascii?q?shCQHG0xImH9kTrXrUqc/6NKMWUe+rzKjD0DLOb+hL1jfm84XIbhAgru2MXb?=
 =?us-ascii?q?J3a8bRz1IvGBnfglWfrozlISqY2+IQuGaY9+ptTf+jhmEopg1rojWj290ghp?=
 =?us-ascii?q?fGi44L0FzI6CN0y5svK9KiUk50e9ukHYNVtyGdKoR5XNsvQ3ptuCYm0r0Gvo?=
 =?us-ascii?q?O7fDQSxJQn2RHfb/uHfpCU4h35TuaRICp4hGl/dLKjhxe97UigyurmWsmyzF?=
 =?us-ascii?q?lKtTZKnsPJtnAM0xzf8smHSv1j8Ue9wTuDyg/e5+5eLU00iKbXMYAtz7Eump?=
 =?us-ascii?q?YJrEjPBir2l1/3jK+SeEUk4O+o6+H/b7X9u5CcLJR5ih3+M6symsy/Bv40Mg?=
 =?us-ascii?q?4VX2eB4+i827rj/VPhTLVQkvI2irXZsIzdJckDqa+5HglV3Zoj6xmlCTem38?=
 =?us-ascii?q?8VnXYALFJCdxKHi5bmN0vSL/D/CPe1m06snytzx/DaIr3hBY3ALmPdn7flfL?=
 =?us-ascii?q?Z97VNcyQUowNBB6JJbFKsBLOjwWkDvrtzYCAE2Mwiuz+bgEtV92dBWZWXaPq?=
 =?us-ascii?q?6QNqHTvBe4+6p7M/SKb48cvjnVJP8i6Prjy3Q+nAlZNbKk2ZoRdWCQAPtrOQ?=
 =?us-ascii?q?OabGDqj9NHFn0F7SQkS+m/s0GPST5eYT6JWqs44jwqQNa9AZzrWpGmgLvH2j?=
 =?us-ascii?q?yyWJJReDYVWRi3DX70etDcCL83YyWIL5okz20J?=
X-IPAS-Result: =?us-ascii?q?A2C1BwBCtoZc/wHyM5BkHAEBAQQBAQcEAQGBZQKBZCqBa?=
 =?us-ascii?q?4Qxk05MAQEBAQEBBoEICCWJP457gWc4AYRAAoQ6IjkFDAEBAwEBAQYBAwIBb?=
 =?us-ascii?q?CiCOimCaAEFIxVRCxgCAiYCAlcGAQwIAQGCXz+BaQ2wVoEvhUWEc4ELJAGLL?=
 =?us-ascii?q?Bd4gQeBOAyCMS6ETgERAgGDKIJXA5E8kmUJkwYGGYF5hWaLW4p4lE4gZXErC?=
 =?us-ascii?q?AIYCCEPgyiCFReOOiMDgTUBAY85AQE?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 11 Mar 2019 19:27:49 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x2BJRmYf019870;
        Mon, 11 Mar 2019 15:27:49 -0400
Subject: Re: Patch to the context lookup change
To:     Tianjie Xu <xunchang@google.com>, selinux@vger.kernel.org
References: <CADBPxw7XyZdQsipF80cpcYu0h1XvJBhe5_MwndqqSBf5GCuFbQ@mail.gmail.com>
 <CADBPxw62sgm3bYBhBg+pft45eT+k0K9MrrjTSF-DhV8iOPaing@mail.gmail.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <ebb47bdc-7285-c13c-cecf-9646845fa86f@tycho.nsa.gov>
Date:   Mon, 11 Mar 2019 15:24:28 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <CADBPxw62sgm3bYBhBg+pft45eT+k0K9MrrjTSF-DhV8iOPaing@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 3/11/19 3:20 PM, Tianjie Xu wrote:
> Hi there,
> I recently made a change in android's selinux repo. The change 
> implements a new lookup helper function for context matches, and it aims 
> to skip unnecessary restorecon if the corresponding context doesn't 
> change. (Wasn't able to attach the URL to the CL, otherwise it's blocked 
> by spam detector).
> 
> Though I haven't done the work to implement this change selinux 
> upstream. I did a local merge and the code compiles. So I wonder if it's 
> possible to merge in this change to the lookup functions first? It will 
> make the upstream & android repo more consistent and also save some work 
> for future merges.

Please, send your patch via git send-email or similar, or otherwise 
follow Linux kernel instructions for submitting patches.  If using a 
mail client, use one that you can configure to send plaintext-only mail.

As part of the patch description, please include the full rationale for 
the change, e.g. the motivation for why these changes are being 
introduced and what they do.




