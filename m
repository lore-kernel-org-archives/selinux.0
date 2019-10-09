Return-Path: <SRS0=kJgC=YC=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C3CCECE58D
	for <selinux@archiver.kernel.org>; Wed,  9 Oct 2019 14:39:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40D4020640
	for <selinux@archiver.kernel.org>; Wed,  9 Oct 2019 14:39:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="aZMydtAs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731037AbfJIOjd (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 9 Oct 2019 10:39:33 -0400
Received: from UHIL19PA39.eemsg.mail.mil ([214.24.21.198]:20239 "EHLO
        UHIL19PA39.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729491AbfJIOjc (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 9 Oct 2019 10:39:32 -0400
X-EEMSG-check-017: 35100664|UHIL19PA39_ESA_OUT05.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.67,276,1566864000"; 
   d="scan'208";a="35100664"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by UHIL19PA39.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 09 Oct 2019 14:39:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1570631970; x=1602167970;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=eL6WWRHJmd0hJJQbbkcrONH/oXcvHPoybd83pK+ofzQ=;
  b=aZMydtAslPTvi13EeZ3Y5y1aeAXjA3+PcZdEIq/bYtqxyg4PbnkaCPwh
   cBy19xZmWPoG/S0lG3JIAgfzjmbzlS1BycI3OUz+20kbVGpTkO7T3aYzD
   CgUyXBkCJPbO/Lwbb3lIy+lIK9Lus4ytGwzGSMAbLGgtDZNwHh5U+vOkn
   LGm3VLV/ZCmOI4oy2bSPcsgPEIwitIEFlEmMq8Ek95t9KuG/mjbugMFjt
   +H4055Rsh48EHcI/PB5lNaIl6x/gENny1+KSKW4HiYM/rFme9AtdaEeIZ
   FRmySCOT0liiO2mLBDiJqabIL8kuawx96gewsbGz0twT+guCOEcieYGAP
   A==;
X-IronPort-AV: E=Sophos;i="5.67,276,1566864000"; 
   d="scan'208";a="33957225"
IronPort-PHdr: =?us-ascii?q?9a23=3A0OKUzx2q0iCxVdyKsmDT+DRfVm0co7zxezQtwd?=
 =?us-ascii?q?8ZseIRIvad9pjvdHbS+e9qxAeQG9mCsLQa0qGL6ujJYi8p2d65qncMcZhBBV?=
 =?us-ascii?q?cuqP49uEgeOvODElDxN/XwbiY3T4xoXV5h+GynYwAOQJ6tL1LdrWev4jEMBx?=
 =?us-ascii?q?7xKRR6JvjvGo7Vks+7y/2+94fcbglVijexe7J/IAi5oQjRq8UdnJdvJLs2xh?=
 =?us-ascii?q?bVuHVDZv5YxXlvJVKdnhb84tm/8Zt++ClOuPwv6tBNX7zic6s3UbJXAjImM3?=
 =?us-ascii?q?so5MLwrhnMURGP5noHXWoIlBdDHhXI4wv7Xpf1tSv6q/Z91SyHNsD4Ubw4RT?=
 =?us-ascii?q?Kv5LpwRRT2lCkIKSI28GDPisxxkq1bpg6hpwdiyILQeY2ZKeZycr/Ycd4cS2?=
 =?us-ascii?q?VBRMJRXDFfDI26YYUEEu4NMf9WooT5olcDqwa1CwuxC+P10jJGm2H43aM63e?=
 =?us-ascii?q?oiHw/J0gMvENASv3rbt9j1KKUfXPqpwKXUwzjObfVb0ir95ojSdRAhpOmBU6?=
 =?us-ascii?q?9sccXP0UkvFx3KjlONooL4OjOazOANs2yF4OtgSOmijHUnpBxqojW02sctip?=
 =?us-ascii?q?XGhoISylze8yV525w6Kce3SE58f96pCZ1dvDyZOYtuWs4uXm5ltSkgxrAGpJ?=
 =?us-ascii?q?K3ZjYGxZs5yxLFdvCKdZWD7Aj5W+aLOzh4gWpoeLe4hxmv70et0vb8Vsyo0F?=
 =?us-ascii?q?ZSqSpFj8XMumgN1xPN7siHTeNw/lu71jaV1gDT9/pELVoolavbN5Ehwrkwmo?=
 =?us-ascii?q?AVsUvfBS/5hF/6jKqXdkUg4uSo6uLnbav6ppKEKoN5hQ7zPr4ul8CiG+g0LA?=
 =?us-ascii?q?cDU3aB9eihzLHj+Ff2QLROjv04iKnZt5XaKNwApqGkGA9YyZoj6hajADem19?=
 =?us-ascii?q?QUh38HLElfdx6dgIjpPE/OLOjiDfijm1SsjCtrx/feM73/B5XNKXrDkbbgfb?=
 =?us-ascii?q?Zm8ENc0hQ8ws1f551OFrENOu78Wkj0tNbAFB82LxS0w/r7CNV6zo4eQnyAAq?=
 =?us-ascii?q?uYMKPUrF+J6fkiI/eDZIALojbxMfsl6OD0jX8/h1AdebOl3ZwNaHC3TbxaJB?=
 =?us-ascii?q?CnYGakp9ADA2YR9l4gSevomlyZeSRea3a7Q+Q34TRtTMq9AIPCQJ29qKKO0T?=
 =?us-ascii?q?39HZBMYG1CTFeWHiTGbYKBDswQZTqSL8kpqTkNUbysWsd1zh21nBPrwLpgaO?=
 =?us-ascii?q?zP82sXsoy1h4s93PHaiRxnrW88NM+ayWzYCjgvz24=3D?=
X-IPAS-Result: =?us-ascii?q?A2ARCgDt751d/wHyM5BlHAEBAQEBBwEBEQEEBAEBgXuBd?=
 =?us-ascii?q?CptUgEyKoQjjlxTBoERJYl4kS4JAQEBAQEBAQEBIxEBAgEBhEACgk8jOBMCD?=
 =?us-ascii?q?AEBAQQBAQEBAQUDAQFshS0MgjopAYJoAQUjFVELDgoCAiYCAlcGAQwGAgEBg?=
 =?us-ascii?q?l8/AYF2FLA4gTKFTYMvgUiBDCiMDhh4gQeBEScMgjEuPoEXhjuCWASWJ5ccg?=
 =?us-ascii?q?iyCL4RZjgsGG4MslhSOLZtHIoFYKwgCGAghD4MnCUcQFIsnhQolAzCBBgEBk?=
 =?us-ascii?q?10BAQ?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 09 Oct 2019 14:39:29 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x99EdTPS018516;
        Wed, 9 Oct 2019 10:39:29 -0400
Subject: Re: [PATCH 2/2] python/semanage: Add support for DCCP and SCTP
 protocols
To:     Vit Mojzis <vmojzis@redhat.com>, selinux@vger.kernel.org
References: <20191008122213.9227-1-vmojzis@redhat.com>
 <20191008122213.9227-2-vmojzis@redhat.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <8820fee0-2472-3209-ba5d-1ef957e4d559@tycho.nsa.gov>
Date:   Wed, 9 Oct 2019 10:39:29 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20191008122213.9227-2-vmojzis@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 10/8/19 8:22 AM, Vit Mojzis wrote:
> Fixes:
>     # semanage port -a -p sctp -t port_t 1234
>     ValueError: Protocol udp or tcp is required
>     # semanage port -d -p sctp -t port_t 1234
>     ValueError: Protocol udp or tcp is required
> 
> Signed-off-by: Vit Mojzis <vmojzis@redhat.com>

For both patches,

Acked-by: Stephen Smalley <sds@tycho.nsa.gov>

> ---
>   python/semanage/seobject.py | 14 ++++++++------
>   1 file changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/python/semanage/seobject.py b/python/semanage/seobject.py
> index f4c29854..dc413ca5 100644
> --- a/python/semanage/seobject.py
> +++ b/python/semanage/seobject.py
> @@ -1058,13 +1058,15 @@ class portRecords(semanageRecords):
>               pass
>   
>       def __genkey(self, port, proto):
> -        if proto == "tcp":
> -            proto_d = SEMANAGE_PROTO_TCP
> +        protocols = {"tcp": SEMANAGE_PROTO_TCP,
> +                     "udp": SEMANAGE_PROTO_UDP,
> +                     "sctp": SEMANAGE_PROTO_SCTP,
> +                     "dccp": SEMANAGE_PROTO_DCCP}
> +
> +        if proto in protocols.keys():
> +            proto_d = protocols[proto]
>           else:
> -            if proto == "udp":
> -                proto_d = SEMANAGE_PROTO_UDP
> -            else:
> -                raise ValueError(_("Protocol udp or tcp is required"))
> +            raise ValueError(_("Protocol has to be one of udp, tcp, dccp or sctp"))
>           if port == "":
>               raise ValueError(_("Port is required"))
>   
> 

