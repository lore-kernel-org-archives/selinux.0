Return-Path: <SRS0=qD/R=XE=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BD82C4740A
	for <selinux@archiver.kernel.org>; Mon,  9 Sep 2019 20:05:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED2EC21924
	for <selinux@archiver.kernel.org>; Mon,  9 Sep 2019 20:05:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="An+qfJzn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732139AbfIIUFp (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 9 Sep 2019 16:05:45 -0400
Received: from UPDC19PA19.eemsg.mail.mil ([214.24.27.194]:36683 "EHLO
        UPDC19PA19.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731778AbfIIUFp (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 9 Sep 2019 16:05:45 -0400
X-EEMSG-check-017: 12187112|UPDC19PA19_ESA_OUT01.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.64,486,1559520000"; 
   d="scan'208";a="12187112"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by UPDC19PA19.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 09 Sep 2019 20:05:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1568059540; x=1599595540;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=t01rSmxjOMi/RxY4wFmkPw31fWXoURfjIrNzccFiOYk=;
  b=An+qfJzn+m7MY+eIAQdPHp1s/aKWojOZMWFuWx+Ryy0X4lL1NLtAY9SX
   vb9MwJzPF2jhMWmBQ4ZsBbUKIUAQbju3pVu6VbqICJGDyAvG/mQmdLxPz
   i4BAY7Z3DUW1Pu8hb4aNA3tHvyOCkFdxs4/Xt1tFrT+Rd7wQ+X6lPO5j6
   N01NhQI0jEmOU3oE1uPIup7UfevyaMIxJQjsm3oxjcbbondZz5EGg3BNd
   AdZ3VPYbaReHV7W1fUnmb4qC4sBHGK7O+g6lq9CQyTV1tUi03Dr4iWv5u
   aL+zR9ACd+MdOnZe3itPNFvUBNCTr5ectlScMHV4mPpMpcRwk8G5LetfV
   w==;
X-IronPort-AV: E=Sophos;i="5.64,487,1559520000"; 
   d="scan'208";a="27701583"
IronPort-PHdr: =?us-ascii?q?9a23=3AdF6t6BZtUQBkymCGsuyP6zX/LSx+4OfEezUN45?=
 =?us-ascii?q?9isYplN5qZr8m7bnLW6fgltlLVR4KTs6sC17OM9fmwBydZvczJmUtBWaQEbw?=
 =?us-ascii?q?UCh8QSkl5oK+++Imq/EsTXaTcnFt9JTl5v8iLzG0FUHMHjew+a+SXqvnYdFR?=
 =?us-ascii?q?rlKAV6OPn+FJLMgMSrzeCy/IDYbxlViDanbr5+MQu6oR/MusQVgIZuJbs9xx?=
 =?us-ascii?q?TXrnBVZ+lY2GRkKE6JkR3h/Mmw5plj8ypRu/Il6cFNVLjxcro7Q7JFEjkoKn?=
 =?us-ascii?q?g568L3uxbNSwuP/WYcXX4NkhVUGQjF7Qr1UYn3vyDnq+dywiiaPcnxTbApRT?=
 =?us-ascii?q?Sv6rpgRRH0hCsbMTMy7W/YitZ0jKlGvhyvoRJxyJPQbI2MNPdzeqbRcNUHTm?=
 =?us-ascii?q?RDQ8lRTTRMDJ6iYYsBD+QPPuhWoIfyqFQMsRSwChKhBP/txzJSmnP6waM33u?=
 =?us-ascii?q?YnHArb3AIgBdUOsHHModvoKKcdT/i1zKnWwjXFcvhYxDL955LMchAlv/6NXa?=
 =?us-ascii?q?97fM3KyUYyDAPIlUmQqIz5MDOV0eQBqW6b7/F6Wu61hG4nrB9xryGpy8wxiY?=
 =?us-ascii?q?fJnpoYxk3L+Ch22oo4JcC0RFRlbdOrDpdcrTyWOo1rSc04WW5oojw1yrgetJ?=
 =?us-ascii?q?6+eygF1YooygbEa/yCb4iI+hXjVPuNITtghHJqZra/hxGq/Ei80OL8TMi00E?=
 =?us-ascii?q?tRriZfjtnNtmwC1xzU6sSdTPty4lyh1iqV2wDW6+FEJVg4lavdK5E/3r49jo?=
 =?us-ascii?q?cfvEvMEyPsmEj6kbWaelsr9+S28ejrf63qppqGOI91jgH+PL4umsu6AekgKQ?=
 =?us-ascii?q?gBQnOb9P+g1Lzj4UL5QLJKgucwkqnCqp/WP8sbpqmnAwNNyIYs9w6/Dyu60N?=
 =?us-ascii?q?QfhXQHMkhKeA6cj4fzIV3OJfT4AOywg1SpijhrxvTGMqf9DZXKK3jJiK3hcq?=
 =?us-ascii?q?pl605A1AozyshS54lKBbEFIfLzXFLxtdPDAx8nPAy73fznBM9+1owAQ2KPBL?=
 =?us-ascii?q?GWMKfIvV+P/OIvLLrEWIhAgyz8NfE5/Pems3Y1lVYSfLOolc8JYWyjF7JjJ2?=
 =?us-ascii?q?2WZHPthpEKFmJc+kIlQejrjkCSeSBcamz0XK8m4Dw/ToW8AtTtXIeo1Yed0T?=
 =?us-ascii?q?+7E5seXWVPDlSBAD+8bImfc+sdYyKVZMl6m3oLUqb3GNxp7g2nqAKvk+kvFe?=
 =?us-ascii?q?HT4CBN8M+y2Q=3D=3D?=
X-IPAS-Result: =?us-ascii?q?A2A9AQCIr3Zd/wHyM5BlHQEBBQEHBQGBVAcBCwGBbSqBP?=
 =?us-ascii?q?wEyhEuPEFEBAQaBESWJc48rgXsJAQEBAQEBAQEBNAECAQGEPwKCOCM1CA4CD?=
 =?us-ascii?q?AEBAQQBAQEBAQYDAQFshTqCOimCaAEFIxVRCw4KAgImAgJXBgEMCAEBgl8/g?=
 =?us-ascii?q?XcUpVaBMoVLgzqBSYEMKAGEf4Z4GHiBB4E4DIIxLj6HT4JYBIw1D4kYgTGVM?=
 =?us-ascii?q?4IrgiySQgYCGZkCjX6aZgE2gVgrCAIYCCEPgyiRIiQDgTYBAZAWAQE?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 09 Sep 2019 20:05:39 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x89K5bAI032433;
        Mon, 9 Sep 2019 16:05:37 -0400
Subject: Re: Changing selinux enforcing mode at runtime
To:     Srivatsa Vaddagiri <vatsa.ml@gmail.com>, selinux@vger.kernel.org
References: <CAMHO8so3mL4hOLd12gg=DZQz7=1auXQET6dVip+r=9GGPjec+Q@mail.gmail.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <45562434-a8bc-ba91-2eee-7407dab4a97f@tycho.nsa.gov>
Date:   Mon, 9 Sep 2019 16:05:37 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAMHO8so3mL4hOLd12gg=DZQz7=1auXQET6dVip+r=9GGPjec+Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 9/9/19 1:16 PM, Srivatsa Vaddagiri wrote:
> Hello,
>      I wanted to know the behavior when selinux enforcing mode is
> changed at runtime via security_setenforce() API. Lets say we boot
> with selinux in permissive mode and after bootup we change it to
> enforcing mode. My question is related to the tasks that were created
> before we enabled enforcing mode. Would their subsequent file
> operations fail once selinux is set to enforcing mode (even though the
> policy may have been set to allow their access to say a file)?

No, they would not fail if the operation is allowed by the policy.  In 
fact, this scenario is typical; commonly, the init process e.g. systemd 
performs the initial policy load and switches to enforcing mode. 
Further, you can fully boot a Linux distro e.g. Fedora in permissive 
mode and then switch to enforcing mode, and nothing should fail unless 
denied by policy.

The more complicated scenario is tasks created before initial policy 
load, because those may not be assigned the correct security context. To 
avoid this, the init process is typically responsible for loading policy 
initially and then either re-exec'ing itself or dynamically switching 
its own security context to the right value before proceeding.
