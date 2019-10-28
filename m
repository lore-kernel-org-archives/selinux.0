Return-Path: <SRS0=r+0f=YV=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58963CA9EC0
	for <selinux@archiver.kernel.org>; Mon, 28 Oct 2019 14:51:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24DBD208C0
	for <selinux@archiver.kernel.org>; Mon, 28 Oct 2019 14:51:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="ZtimycXz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730798AbfJ1Ovs (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 28 Oct 2019 10:51:48 -0400
Received: from UCOL19PA39.eemsg.mail.mil ([214.24.24.199]:32055 "EHLO
        UCOL19PA39.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730792AbfJ1Ovs (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 28 Oct 2019 10:51:48 -0400
X-EEMSG-check-017: 41763365|UCOL19PA39_ESA_OUT06.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.68,240,1569283200"; 
   d="scan'208";a="41763365"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by UCOL19PA39.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 28 Oct 2019 14:51:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1572274292; x=1603810292;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=LbFu3NqUgKVsfyU9axAZs0V/AQKm9XrdPXFSVOeKLsE=;
  b=ZtimycXzAx8uwqe2UK1qjRhb9ndeZZYPCg8aawyfx2IkaSVqlEYYozMM
   RVXziMs8w3xaawgq9PsPFvTpgbTl2TKMX1xqyQAnVWTKHSyh/pZEi+SEZ
   6o49yHWK5lwFZ/ETvJ81WbcZBd4jGYzehdOjYG684bi/Y9+IuwBpFngoT
   zVSLPmGdKAhV9ad/Dr+ayO6WI1LeqQ0CmyvnnBhfEEbw0mvv/zWFbsdNF
   Omg24oOn+OUxQJ+81MULdiTfd9UhrHh1C8h2vGI35TUN2IsjHxFmyfJTp
   qx7NXL5YSsreVoguCavbXJwT+bdENwAJEqJRZbonFuFE3iPRYqWrqD/7t
   A==;
X-IronPort-AV: E=Sophos;i="5.68,240,1569283200"; 
   d="scan'208";a="29457048"
IronPort-PHdr: =?us-ascii?q?9a23=3AsFt37RT544CeMC9VoIHHKJW9C9psv+yvbD5Q0Y?=
 =?us-ascii?q?Iujvd0So/mwa6yYBCN2/xhgRfzUJnB7Loc0qyK6vumCD1Lv8nJmUtBWaQEbw?=
 =?us-ascii?q?UCh8QSkl5oK+++Imq/EsTXaTcnFt9JTl5v8iLzG0FUHMHjew+a+SXqvnYdFR?=
 =?us-ascii?q?rlKAV6OPn+FJLMgMSrzeCy/IDYbxlViDanbr5+MRu7oR/Vu8QSjodvK6Q8wQ?=
 =?us-ascii?q?bVr3VVfOhb2XlmLk+JkRbm4cew8p9j8yBOtP8k6sVNT6b0cbkmQLJBFDgpPH?=
 =?us-ascii?q?w768PttRnYUAuA/WAcXXkMkhpJGAfK8hf3VYrsvyTgt+p93C6aPdDqTb0xRD?=
 =?us-ascii?q?+v4btnRAPuhSwaOTE56mXXgdFugqxdrhyquhhzz5fUbYyRMfZzeL7Wc9EHSm?=
 =?us-ascii?q?pbRstfSjJPAo28YYUMAeQOM+lXoIvhqFUBtha+GQqhCfnzxjNUiHL736s32P?=
 =?us-ascii?q?khHwHc2wwgGsoDvmnIrNrrLKcSUf66zK/VxjveavNZwzP96IzWfREhvPqBWq?=
 =?us-ascii?q?lwftfKyUQ0CwPEjkmfqYziPz+P0OQNqHKU4/BvVeKolW4qsgd8qSWsyMc0ko?=
 =?us-ascii?q?TFm40Yx1/e+Sh53Yo5P8O0RUFlbdK+DZddsTyROZFsTcM4WW5ovT43yrgBuZ?=
 =?us-ascii?q?GmYicH0I8nxxvDa/yfdIiI/w7jWP6RIThmgHJlf6qyhwqo/ki6y+38S9K03E?=
 =?us-ascii?q?xWritFjtbMtncN2wbV6sebUfty4l2t2TOO1wDX8u1EIEY0mrTHK5M537I9mZ?=
 =?us-ascii?q?UevV7DEyPrgkn6kqCbels+9uS18+jnZ6/ppp6YN496kAH+NaEul9SkAeslKQ?=
 =?us-ascii?q?gDRHSb+OSg273j+k31WrNKjuYsnaXDv5DaItobqrajAwBJyoYj9wq/DzC+3d?=
 =?us-ascii?q?sCh3kIMktFeA+Gj4jxJV7OJvf4AOywg1SpijhrxvTGMqf9DZXKK3jJiK3hcq?=
 =?us-ascii?q?pl605A1AozyshS54lKBbEFIfLzXFLxtdPDAx8nPAy73fznBM9+1owAQ2KPBL?=
 =?us-ascii?q?GWMKfIvV+P/OIvLLrEWIhAmT/7Y8Ak4/XugGVxzVYHcLC03IMabneQEfFvIk?=
 =?us-ascii?q?Hfan3p1JNJCmoOvwwjXMT0h1CYFz1efXC/W+Q7/D5oJpihCNL4Wo21gLGHlB?=
 =?us-ascii?q?y+F5lSa3EOXkuACl/0Zo6EXLEKcyvULch/xG9XHYO9QpMsgEn9/DTxzKBqe6?=
 =?us-ascii?q?+JqyA=3D?=
X-IPAS-Result: =?us-ascii?q?A2DABgDo/7Zd/wHyM5BlHAEBAQEBBwEBEQEEBAEBgXuBb?=
 =?us-ascii?q?wUsgUEyhFKPBVQGgTaJY5ExCQEBAQEBAQEBATQBAgEBhEACg0okOBMCDAEBA?=
 =?us-ascii?q?QQBAQEBAQUDAQFshUOCOymCbgEFIw8BBVELDgoCAiYCAlcGAQwIAQGCXz+CU?=
 =?us-ascii?q?yWwSIEyhU6DOIFIgQ4ojA8YeIEHgTiCPS4+h1WCXgSNPqAqgi6CM5J1BhuZW?=
 =?us-ascii?q?o4/m1kigVgrCAIYCCEPgyhPEBSRaCUDgTUBAY9NAQE?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 28 Oct 2019 14:51:31 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x9SEpVjo002019;
        Mon, 28 Oct 2019 10:51:31 -0400
Subject: Re: Add portcon rule to existing policy module
To:     Ian Pilcher <arequipeno@gmail.com>, selinux@vger.kernel.org
References: <bded2b55-30eb-e039-19cd-4e834ad5ca28@gmail.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <fafed3b1-85fc-c6ee-744b-df0eee0b1d85@tycho.nsa.gov>
Date:   Mon, 28 Oct 2019 10:51:31 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <bded2b55-30eb-e039-19cd-4e834ad5ca28@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 10/27/19 9:07 PM, Ian Pilcher wrote:
> I have a policy module that consists of a .te and an .fc file.  I would
> like to add a "portcon" rule to this module, which (AFAIK) can only be
> done in CIL "format."
> 
> What I've got today is:
> 
> 1. Build a "traditional" .pp file
>     (make -f /usr/share/selinux/devel/Makefile).
> 
> 2. Use /usr/libexec/selinux/hll/pp to convert the .pp file to a .cil
>     file.
> 
> 3. Add the port context rule to the .cil file.
> 
> Is this the best/only way to do this?

Alternatives:

1) Use semanage port to add the port context instead of including it in 
the policy module, or

2) Rewrite the module in CIL or start using the automatically converted 
one going forward as the preferred source form of your module.

Eventually, a high level policy language is anticipated to be created on 
top of CIL that will offer the full flexibility of CIL along with some 
of the syntactic niceties of .te as well as newer high level features.


