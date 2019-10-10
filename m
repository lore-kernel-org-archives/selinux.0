Return-Path: <SRS0=2qaZ=YD=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AE8EC4360C
	for <selinux@archiver.kernel.org>; Thu, 10 Oct 2019 19:59:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42B2520B7C
	for <selinux@archiver.kernel.org>; Thu, 10 Oct 2019 19:59:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="Wx9fPZuw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726034AbfJJT7B (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 10 Oct 2019 15:59:01 -0400
Received: from USFB19PA31.eemsg.mail.mil ([214.24.26.194]:40303 "EHLO
        USFB19PA31.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725867AbfJJT7A (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 10 Oct 2019 15:59:00 -0400
X-EEMSG-check-017: 16673363|USFB19PA31_ESA_OUT01.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.67,281,1566864000"; 
   d="scan'208";a="16673363"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by USFB19PA31.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 10 Oct 2019 19:57:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1570737472; x=1602273472;
  h=subject:from:to:references:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=KUguIviyMVCN+jmuIJEkIs1EUc8t1Pph7CXVyU3TTOQ=;
  b=Wx9fPZuwMpzDiPKLcRXk91TSQsjuKdPGMDTKjXLJLXIBtbfpAUUyGzp8
   rE2A/X0tKYsnCOHfpd6hMPEcgbsr4UsUUCG3pS2gL2Iydwy8lwV/zV/GO
   ZfmFYepf6F0aPEtI1EmXPVSxEAcv5xtJuOYza3Da/mikYsFANDRWS8HgZ
   LILmKeCDqI53NWcspSO+HET4oV3COhY+9NOa2GGScl/6ZyS7MGsioWSr2
   clIXaYpwd995sZ4E5tstYtc+LT3MLUBYyj3sLBX8/AbLmInrMw6Brcu7G
   ra4hC85fbAZgIsjlIgCtsoG3/N/DweY56bYe87HqeCJr6hY1GgzXBG9A4
   Q==;
X-IronPort-AV: E=Sophos;i="5.67,281,1566864000"; 
   d="scan'208";a="34044991"
IronPort-PHdr: =?us-ascii?q?9a23=3ANoilkRF1MQqEQ3ujexVyAp1GYnF86YWxBRYc79?=
 =?us-ascii?q?8ds5kLTJ7zr82wAkXT6L1XgUPTWs2DsrQY0rGQ7furADBdqb+681k6OKRWUB?=
 =?us-ascii?q?EEjchE1ycBO+WiTXPBEfjxciYhF95DXlI2t1uyMExSBdqsLwaK+i764jEdAA?=
 =?us-ascii?q?jwOhRoLerpBIHSk9631+ev8JHPfglEnjWwba58IRmsrAjcuMYajZZtJ6sx1x?=
 =?us-ascii?q?DEvmZGd+NKyG1yOFmdhQz85sC+/J5i9yRfpfcs/NNeXKv5Yqo1U6VWACwpPG?=
 =?us-ascii?q?4p6sLrswLDTRaU6XsHTmoWiBtIDBPb4xz8Q5z8rzH1tut52CmdIM32UbU5Ui?=
 =?us-ascii?q?ms4qt3VBPljjoMOiUn+2/LlMN/kKNboAqgpxNhxY7UfJqVP+d6cq/EYN8WWX?=
 =?us-ascii?q?ZNUsNXWiNPGIO8a5YEAfQHM+hWsoLxo0ICoBW6CAWpAu7k1z1GiWLs3aAizu?=
 =?us-ascii?q?ovER/I3AIjEdwAvnvbo9f6O7sdX+2u0KnFzi/OY+9K1Trz6oXFdA0qr/GWXb?=
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
X-IPAS-Result: =?us-ascii?q?A2DUAAD3i59d/wHyM5BmHAEBAQEBBwEBEQEEBAEBgWgGA?=
 =?us-ascii?q?QELAYFzLGxTMiqEI45dTQYGgTaJd48zgXsJAQEBAQEBAQEBIxEBAgEBhEACg?=
 =?us-ascii?q?lwjNQgOAgwBAQEEAQEBAQEFAwEBbIUtDII6KQGCaAEFIw8BBVEJAg4KAgImA?=
 =?us-ascii?q?gJXBgEMBgIBAYJfPwGCUiWWM5tygTKIfoFIgQwoAYwNGHiBB4ERJ4I9Lj6BF?=
 =?us-ascii?q?4Y7gl4ErUOCLIIvhFmOCwYbgyyWFI4tmzICNYFYKwgCGAghD4MnCUcQFIsnh?=
 =?us-ascii?q?QolAzCBBgEBj24BAQ?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 10 Oct 2019 19:57:50 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x9AJvoCP008740;
        Thu, 10 Oct 2019 15:57:50 -0400
Subject: Re: [PATCH 2/2] python/semanage: Add support for DCCP and SCTP
 protocols
From:   Stephen Smalley <sds@tycho.nsa.gov>
To:     Vit Mojzis <vmojzis@redhat.com>, selinux@vger.kernel.org
References: <20191008122213.9227-1-vmojzis@redhat.com>
 <20191008122213.9227-2-vmojzis@redhat.com>
 <8820fee0-2472-3209-ba5d-1ef957e4d559@tycho.nsa.gov>
Message-ID: <dfac02ea-b8fb-8d15-7c61-120050f4c51e@tycho.nsa.gov>
Date:   Thu, 10 Oct 2019 15:57:50 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <8820fee0-2472-3209-ba5d-1ef957e4d559@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 10/9/19 10:39 AM, Stephen Smalley wrote:
> On 10/8/19 8:22 AM, Vit Mojzis wrote:
>> Fixes:
>>     # semanage port -a -p sctp -t port_t 1234
>>     ValueError: Protocol udp or tcp is required
>>     # semanage port -d -p sctp -t port_t 1234
>>     ValueError: Protocol udp or tcp is required
>>
>> Signed-off-by: Vit Mojzis <vmojzis@redhat.com>
> 
> For both patches,
> 
> Acked-by: Stephen Smalley <sds@tycho.nsa.gov>

Thanks, applied.

> 
>> ---
>>   python/semanage/seobject.py | 14 ++++++++------
>>   1 file changed, 8 insertions(+), 6 deletions(-)
>>
>> diff --git a/python/semanage/seobject.py b/python/semanage/seobject.py
>> index f4c29854..dc413ca5 100644
>> --- a/python/semanage/seobject.py
>> +++ b/python/semanage/seobject.py
>> @@ -1058,13 +1058,15 @@ class portRecords(semanageRecords):
>>               pass
>>       def __genkey(self, port, proto):
>> -        if proto == "tcp":
>> -            proto_d = SEMANAGE_PROTO_TCP
>> +        protocols = {"tcp": SEMANAGE_PROTO_TCP,
>> +                     "udp": SEMANAGE_PROTO_UDP,
>> +                     "sctp": SEMANAGE_PROTO_SCTP,
>> +                     "dccp": SEMANAGE_PROTO_DCCP}
>> +
>> +        if proto in protocols.keys():
>> +            proto_d = protocols[proto]
>>           else:
>> -            if proto == "udp":
>> -                proto_d = SEMANAGE_PROTO_UDP
>> -            else:
>> -                raise ValueError(_("Protocol udp or tcp is required"))
>> +            raise ValueError(_("Protocol has to be one of udp, tcp, 
>> dccp or sctp"))
>>           if port == "":
>>               raise ValueError(_("Port is required"))
>>
> 

