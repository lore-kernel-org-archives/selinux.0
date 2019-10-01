Return-Path: <SRS0=wSC+=X2=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56903C352AA
	for <selinux@archiver.kernel.org>; Tue,  1 Oct 2019 18:28:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FF532168B
	for <selinux@archiver.kernel.org>; Tue,  1 Oct 2019 18:28:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="aeTJUNWi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725851AbfJAS25 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 1 Oct 2019 14:28:57 -0400
Received: from UPDC19PA21.eemsg.mail.mil ([214.24.27.196]:5188 "EHLO
        UPDC19PA21.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbfJAS25 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 1 Oct 2019 14:28:57 -0400
X-EEMSG-check-017: 18853555|UPDC19PA21_ESA_OUT03.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.64,571,1559520000"; 
   d="scan'208";a="18853555"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by UPDC19PA21.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 01 Oct 2019 18:28:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1569954533; x=1601490533;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=HI4kIWub/mR4UuK8/Nb0hf/79b02MaM91PtMi8FG0bQ=;
  b=aeTJUNWifOB9mYD9+JmchnYat42f3hBSVfTlVSW1kt8SJ8JMJtoHDMKv
   kQ10Mr+GqljzJGe3iGfuOdfx9Eka0xSnulrqM2y2ZMHNX0VpaLWqzUHbn
   HrRT+wlL2EAbTMbABYEP9impJfi8XduCnICoXp4pjJyTvy1v3bwzlkf9U
   p8n7ybgDac+pEEGk9V37J/pk4EHRDWY7BTbHCApXQETAd2nFMrVFKDYXq
   LAXCTHzh2nzp9DQ0e6bb2l0vRijg/tJ5O9SSIUsheE7kZkRfpcV74JNHI
   dSKxkNYxbKGpC2Jgh/bHiRuuAFOSqHB3OMwDV4ODEI2sgtx4eHsu05Z6s
   A==;
X-IronPort-AV: E=Sophos;i="5.64,571,1559520000"; 
   d="scan'208";a="33601633"
IronPort-PHdr: =?us-ascii?q?9a23=3AqzkCRxHo9jgvPzhqHmYzn51GYnF86YWxBRYc79?=
 =?us-ascii?q?8ds5kLTJ7zr82wAkXT6L1XgUPTWs2DsrQY0rGQ7/yrADZZqb+681k6OKRWUB?=
 =?us-ascii?q?EEjchE1ycBO+WiTXPBEfjxciYhF95DXlI2t1uyMExSBdqsLwaK+i764jEdAA?=
 =?us-ascii?q?jwOhRoLerpBIHSk9631+ev8JHPfglEnjWwba58IRmsogjcucYajZZ8Jqos1x?=
 =?us-ascii?q?DEvmZGd+NKyG1yOFmdhQz85sC+/J5i9yRfpfcs/NNeXKv5Yqo1U6VWACwpPG?=
 =?us-ascii?q?4p6sLrswLDTRaU6XsHTmoWiBtIDBPb4xz8Q5z8rzH1tut52CmdIM32UbU5Ui?=
 =?us-ascii?q?ms4qt3VBPljjoMOiUn+2/LlMN/kKNboAqgpxNhxY7UfJqVP+d6cq/EYN8WWX?=
 =?us-ascii?q?ZNUsNXWiNPGIO8a5YEAfQHM+hWsoLxo0ICoBW6CAWpAu7k1z1GiWLs3aAizu?=
 =?us-ascii?q?ovDw/G0gwjEdwAvnvbo9f6O7sdX+2u0KnFzy/OY+9K1Trz6oXFdA0qr/GWXb?=
 =?us-ascii?q?J3dMrc0VQhFx/bgVWIqYzqITWV3fkQvWie9eVgUeavhHAnqgpspTWv3dojip?=
 =?us-ascii?q?LSi4IJylHL6SV5wIEvKd2+U050e8SoEJRXtyGELoZ7RN4pTWJwuCsi17ELtp?=
 =?us-ascii?q?G2cDIKxZg63RLTdfOKf5aS7h7+UuuaPC12i2h/eL2lgha/6U2gyurhWcaqyF?=
 =?us-ascii?q?tKtS9FksXUtnAKyhzT9tCLSvtj8Uel3jaCzxzT5fteIUA1iKrbMIQtwqIwl5?=
 =?us-ascii?q?UPsUTDGTX6mEPqg6+Nakoo4O2o6+XjYrn+p5+cMZF7ih3mP6gzlcGyDv40Pw?=
 =?us-ascii?q?gTU2SB5+ix26Pv8VfkTLlSi/05iKjZsJTUJcQBoa65BhdY0p0+5BakFDqmzN?=
 =?us-ascii?q?QZkmUHLFJCYh6HiZPpNEvULPD3Cve/nUygkC13yPDeIr3hHpLNI2DdkLfker?=
 =?us-ascii?q?Z96U9dyAsozd1E/ZJbFKwOIPLpVU/trtDXEhg5Mwmsyeb9FNp9zp8eWX6IAq?=
 =?us-ascii?q?KBK6Pdr1uI5uMpI+mRa44Yoyj9K/c76P70l3M5mkESfbOv3ZQJbHC0BPNmI1?=
 =?us-ascii?q?+WYSmkvtBUL2YW9i85Tv7rkxXWTztUZWSzRIom6z07AZ7gBoDGEMTlm7GF3S?=
 =?us-ascii?q?GmDrVIaW1cTFOBC3Hlc8ODQfhfRjiVJ5pajjEcVbWnA7Qk3BWquR6yn6FrNc?=
 =?us-ascii?q?LI6yYYstTlz9Ez6OrNw0JhvQdoBtiQhjneB1p/mXkFEnpvh/Fy?=
X-IPAS-Result: =?us-ascii?q?A2B9AACfmZNd/wHyM5BmHAEBAQQBAQwEAQGBVQUBAQsBg?=
 =?us-ascii?q?XMqbVMyKoQijndNAQEBAQEBBoE2iXWPMIF7CQEBAQEBAQEBASMRAQIBAYRAA?=
 =?us-ascii?q?oIvIzYHDgIMAQEBBAEBAQEBBQMBAWyFLQyCOikBgmgBBSMVUQsOCgICJgICV?=
 =?us-ascii?q?wYBDAYCAQGCXz8BgXYUsDuBMoVNgyiBSIEMKAGMDRh4gQeBOIJrPoEXgnaDR?=
 =?us-ascii?q?IJYBJYWlw+CLIIvhFeOBQYbgyqWD4RCiWGbKgYsgVgrCAIYCCEPO4JsCUcQF?=
 =?us-ascii?q?IsnhQolAzCBBgEBjh+CVAEB?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 01 Oct 2019 18:28:50 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x91ISnPT009373;
        Tue, 1 Oct 2019 14:28:49 -0400
Subject: Re: [PATCH] python/semanage: fix moduleRecords.customized()
To:     Vit Mojzis <vmojzis@redhat.com>, selinux@vger.kernel.org
References: <CAJfZ7=nBDUZYO95PN4p5FaXh_KAa3SeHu6yq4CteFGgyPkjEUw@mail.gmail.com>
 <20190930074904.25219-1-vmojzis@redhat.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <83f5cfdc-a0a8-47f8-0a6d-2889a4d2c13f@tycho.nsa.gov>
Date:   Tue, 1 Oct 2019 14:28:49 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20190930074904.25219-1-vmojzis@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 9/30/19 3:49 AM, Vit Mojzis wrote:
> Return value of "customized" has to be iterable.
> 
> Fixes:
>     "semanage export" with no modules in the system (eg. monolithic policy)
>     crashes:
> 
>     Traceback (most recent call last):
>       File "/usr/sbin/semanage", line 970, in <module>
>         do_parser()
>       File "/usr/sbin/semanage", line 949, in do_parser
>         args.func(args)
>       File "/usr/sbin/semanage", line 771, in handleExport
>         for c in OBJECT.customized():
>     TypeError: 'NoneType' object is not iterable
> 
> Signed-off-by: Vit Mojzis <vmojzis@redhat.com>

Thanks, both patches applied.

> ---
>   python/semanage/seobject.py | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/python/semanage/seobject.py b/python/semanage/seobject.py
> index 5e9e3eb5..f4c29854 100644
> --- a/python/semanage/seobject.py
> +++ b/python/semanage/seobject.py
> @@ -380,7 +380,7 @@ class moduleRecords(semanageRecords):
>       def customized(self):
>           all = self.get_all()
>           if len(all) == 0:
> -            return
> +            return []
>           return ["-d %s" % x[0] for x in [t for t in all if t[1] == 0]]
>   
>       def list(self, heading=1, locallist=0):
> 

