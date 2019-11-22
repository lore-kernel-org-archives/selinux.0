Return-Path: <SRS0=8Pnr=ZO=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44D71C432C0
	for <selinux@archiver.kernel.org>; Fri, 22 Nov 2019 13:04:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E97F820707
	for <selinux@archiver.kernel.org>; Fri, 22 Nov 2019 13:04:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="Mx7sdmbE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727569AbfKVNE0 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 22 Nov 2019 08:04:26 -0500
Received: from UHIL19PA40.eemsg.mail.mil ([214.24.21.199]:41077 "EHLO
        UHIL19PA40.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726526AbfKVNE0 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 22 Nov 2019 08:04:26 -0500
X-EEMSG-check-017: 51115382|UHIL19PA40_ESA_OUT06.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.69,229,1571702400"; 
   d="scan'208";a="51115382"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by UHIL19PA40.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 22 Nov 2019 13:04:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1574427863; x=1605963863;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=Ea/rOQ55oF76n8GXqpCA7lr2pBodill3bOJ1ohtcWcE=;
  b=Mx7sdmbEmrR9ewRYoJSTSDJFnat2SXk6NfYDt9H+Qx2YzgM7/Y0gluX7
   ZYGCR5OfSAvzdd7zuMctix305gBnK7kpx8d++D49K4lO002zHbvmeY/CA
   zhPMfZPiu16es341AQvxkWBgYo/iUk40dKbofYvNT34IK7qsRFvgrlw6u
   zBs3ri5fMNLciqKdLzTDAed5uOR4dpWjwB7i5HwHIEuFccbGQYfgW/Yqm
   URzUR0MYxPgWN9ellvZoA7DXtlsfhZnLSB5lryjNMNkZHuCMYPnmYJtUs
   tfCZcdOURWy0/AHeFlrQOkryl5KFRKRRDxWCEMUShSmA0Yy+QbAapvbHz
   A==;
X-IronPort-AV: E=Sophos;i="5.69,229,1571702400"; 
   d="scan'208";a="30402773"
IronPort-PHdr: =?us-ascii?q?9a23=3A4PPhDBSf19CD63VQLJfOpWLVv9psv+yvbD5Q0Y?=
 =?us-ascii?q?Iujvd0So/mwa67ZRSHt8tkgFKBZ4jH8fUM07OQ7/m7HzVdvd3d7TgrS99lb1?=
 =?us-ascii?q?c9k8IYnggtUoauKHbQC7rUVRE8B9lIT1R//nu2YgB/Ecf6YEDO8DXptWZBUh?=
 =?us-ascii?q?rwOhBoKevrB4Xck9q41/yo+53Ufg5EmCexbal9IRmrowjdrNQajIttJ6o+xR?=
 =?us-ascii?q?bEomZDdvhLy29vOV+dhQv36N2q/J5k/SRQuvYh+NBFXK7nYak2TqFWASo/PW?=
 =?us-ascii?q?wt68LlqRfMTQ2U5nsBSWoWiQZHAxLE7B7hQJj8tDbxu/dn1ymbOc32Sq00WS?=
 =?us-ascii?q?in4qx2RhLklDsLOjgk+2zMlMd+kLxUrw6gpxxnwo7bfoeVNOZlfqjAed8WXH?=
 =?us-ascii?q?dNUtpNWyBEBI6zYZEPD+4cNuhGqYfzqUYFoR+nCQSiAO7jzzlFjWL006Inye?=
 =?us-ascii?q?QsCRzI0hIuH9wOs3raotv6O6gQXu+pw6fF1inDYvFM1Dvh9ITFfBIsrPeRVr?=
 =?us-ascii?q?xwa8rRzkwvGhvYgFWMt4PlJzOV2foLs2OG8uRgUPigi2ojqw5vojmk28Ahip?=
 =?us-ascii?q?LUiYIO0V3E6SV4z5o1Jd2/UkJ7Z8WkH4FKuyGVMIt2XNovTmd1syg0zb0GvI?=
 =?us-ascii?q?S0fCkMyJk/yB7fauCHc4iV4h34TuqePTB4hHdjdbmihBiy6VCtxvDzW8S7yl?=
 =?us-ascii?q?pHrjdJnsPSun0CyRDf8NWLR/1g9Um7wzmPzRrc6uRcLEAxkqrUNoAuz6Yrlp?=
 =?us-ascii?q?oWrUTDBij2mFjqjKOOdkUr5Oyo6+P/b7X6vJCcLY50ihzlMqg0m8y/B+o4Mg?=
 =?us-ascii?q?8VX2eF5euwzqHj/E3lT7VKif06iK/Zv4zBJcsHvKK5Bg5V0oI75xa+CTepzs?=
 =?us-ascii?q?gYkGEaIF9Kdx+LlYjkN0zULPzmAvqznU6gnCpzy/DDJLLhA5HNLnbZkLfmeL?=
 =?us-ascii?q?Zw81Vcxxcozd1E+5JVCq0OIPL0WkPrstzYFQU2Pxa7w+bgFtVxzpkeVn6XAq?=
 =?us-ascii?q?+FLKPStkeF5uUqI+mLf48VvizyJOQ76PP1l382h0ISfamz0psLcny3AvNmI0?=
 =?us-ascii?q?CBa3r2ntgBCXsKvhY5TOHykl2CUCJcZ3aoUKIm+z40EJ6pAp/DRo+3gbyB2j?=
 =?us-ascii?q?m0HoZNa29dFlCMEHHod5maVPcWbiKdPNNhniYYWrimTo8rzQuuuxPiy7p7Mu?=
 =?us-ascii?q?rU/TUVtYn929hx5u3Tkwwy9DNvAsSD3GGCUXt0knkLRzAoxqB/p1JyylOZ3a?=
 =?us-ascii?q?h/mfxYGsRZ5+lVXQciKZ7c0+t6BsjqWg3bY9eJTE2rQs28DjEsStI92toOY0?=
 =?us-ascii?q?F6G9W4kB/PxTalA7gQl+/DOJth1aTQxXXzb+N60HDP36Qixw0hR8xUM2Sti4?=
 =?us-ascii?q?Zl+gTTDpKPmEKcweLiT6UX3CfX+C+jxGuIsVoQBBRxWqXMR3wobXzWpNX/61?=
 =?us-ascii?q?jqRaOvD6gqKA1M1YiJLa4cOfPzilATf+vuINTTZSqKnm60ARuZjueXYJHCZ3?=
 =?us-ascii?q?QW3CKbDlMN1Q8U4yDVZkAFGi69rjeGX3RVHlX1bhapqLIvpQ=3D=3D?=
X-IPAS-Result: =?us-ascii?q?A2AGAADd29dd/wHyM5BlGQEBAQEBAQEBAQEBAQEBAQEBE?=
 =?us-ascii?q?QEBAQEBAQEBAQEBgWwCAQEBAQELAYFzgRhVIBKEVIkDhlUGgTeJZ49IgXsJA?=
 =?us-ascii?q?QEBAQEBAQEBLQoBAYRAAoJONgcOAhABAQEEAQEBAQEFAwEBbIU3DII7KQGCb?=
 =?us-ascii?q?QEFIxVBEAsOCgICJgICVwYBDAgBAYJfPwGCUiUPrlaBMoQ5AYEUgzyBQgaBD?=
 =?us-ascii?q?igBjC94gQeBESeCaz6CYgKEcYJeBJAxhi5GlwuCNYI3hGOOMAYbmhiOSIg4k?=
 =?us-ascii?q?1UIKoFYKwgCGAghD4MoTxEUijuKcSMDOpE7AQE?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 22 Nov 2019 13:04:22 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id xAMD4HHQ042803;
        Fri, 22 Nov 2019 08:04:18 -0500
Subject: Re: [PATCH V4] selinux-testsuite: Add kernel module tests
To:     Ondrej Mosnacek <omosnace@redhat.com>,
        Richard Haines <richard_c_haines@btinternet.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>
References: <20191119113845.89951-1-richard_c_haines@btinternet.com>
 <CAFqZXNtdWNSma6Y55bPcRvJinCe=F4YNwuciDAhhdgr95ef0Dg@mail.gmail.com>
 <CAFqZXNtZ8TVWP=6Rsp81u5NOHsvgc0Xr2yMtATTv2R-u5YmOhw@mail.gmail.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <57736f19-2b1b-aa1f-39ea-19f5c837ad9a@tycho.nsa.gov>
Date:   Fri, 22 Nov 2019 08:04:18 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CAFqZXNtZ8TVWP=6Rsp81u5NOHsvgc0Xr2yMtATTv2R-u5YmOhw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 11/22/19 5:40 AM, Ondrej Mosnacek wrote:
> When trying this on RHEL-7, I realized there is a missing kernel
> version check here (module_load kernel support was introduced in v4.7
> [1]):
> 
> ifneq ($(shell ./kvercmp $$(uname -r) 4.7),-1)
> ...
> endif
> 
> It is quite a corner case to have a policy that supports module_load
> and a kernel that does not, but there is at least one distro that hits
> it, so I think it's worth it to add the explicit check.
> 
> Stephen/Paul, is it trivial enough to add when merging the patch or
> should Richard repost it?
> 
> [1] https://github.com/torvalds/linux/commit/61d612ea731e57dc510472fb746b55cdc017f371

Alternatively, you could exclude it on RHEL7 by adding it to the 
filter-out line under ifeq ($(DISTRO),RHEL7).  Regardless, it is 
entirely up to you as to whether you want to fix it up on merge yourself 
or request a re-spin.

