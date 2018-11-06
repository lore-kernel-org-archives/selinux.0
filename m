Return-Path: <SRS0=i/ur=NR=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53B80C32789
	for <selinux@archiver.kernel.org>; Tue,  6 Nov 2018 16:11:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BD452081D
	for <selinux@archiver.kernel.org>; Tue,  6 Nov 2018 16:11:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BD452081D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.nsa.gov
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389184AbeKGBhf (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 6 Nov 2018 20:37:35 -0500
Received: from ucol19pa12.eemsg.mail.mil ([214.24.24.85]:34833 "EHLO
        ucol19pa12.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389007AbeKGBhf (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 6 Nov 2018 20:37:35 -0500
X-EEMSG-check-008: 653604588|UCOL19PA12_EEMSG_MP10.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.54,472,1534809600"; 
   d="scan'208";a="653604588"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by ucol19pa12.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 06 Nov 2018 16:11:40 +0000
X-IronPort-AV: E=Sophos;i="5.54,472,1534809600"; 
   d="scan'208";a="20330276"
IronPort-PHdr: =?us-ascii?q?9a23=3ApjcsvBZMusYg5TCU7FSffIj/LSx+4OfEezUN45?=
 =?us-ascii?q?9isYplN5qZr8S7bnLW6fgltlLVR4KTs6sC17KJ9fi4EUU7or+5+EgYd5JNUx?=
 =?us-ascii?q?JXwe43pCcHRPC/NEvgMfTxZDY7FskRHHVs/nW8LFQHUJ2mPw6arXK99yMdFQ?=
 =?us-ascii?q?viPgRpOOv1BpTSj8Oq3Oyu5pHfeQpFiCa/bL9oMBm6sRjau9ULj4dlNqs/0A?=
 =?us-ascii?q?bCrGFSe+RRy2NoJFaTkAj568yt4pNt8Dletuw4+cJYXqr0Y6o3TbpDDDQ7KG?=
 =?us-ascii?q?81/9HktQPCTQSU+HQRVHgdnwdSDAjE6BH6WYrxsjf/u+Fg1iSWIdH6QLYpUj?=
 =?us-ascii?q?m58axlVAHnhzsGNz4h8WHYlMpwjL5AoBm8oxBz2pPYbJ2JOPZ7eK7Sc8kaRW?=
 =?us-ascii?q?5cVchPUSJPDJ63Y48WA+YfIepUqo/wrEYMoxSjHwmhHP7hxCFGhnH23qM03e?=
 =?us-ascii?q?ouHg7E0wM8ENwDq2jUodbvOasOTey4wqvFwDPeZP1Wwzf9743Ifwg8r/GQQ7?=
 =?us-ascii?q?1wacrRxlcpFwjYk1uQrJbqPzeR1usTs2mQ8u1tVfmyhG48sAxxvjiuydssio?=
 =?us-ascii?q?nOnI4VzEvE+j9jzIY6It24Vld2bNi5G5VTryGXL5Z6T8wtTm1yuCs216cKtY?=
 =?us-ascii?q?C0cSQU0pgr2hjSYOGdfYeS+BLsTuORLC99hHJiZb2wmQ6/8VOlyu3gTsm010?=
 =?us-ascii?q?tKrjZdntnMqH8N0xvT59CbSvRn5Eeh2CuP1xvJ5uFYIUE7iarbK5k7zr42ip?=
 =?us-ascii?q?UTqljMEjXzmEX3iK+abkQk+u625OT7erjqu5CROoBuhgz+L6gigNKzDOsmPg?=
 =?us-ascii?q?QUQmSX4eG826fi/U39TrVKlPo2kqzBvZDBOMsbvbW0AxNV04k/6xa/CC2q0N?=
 =?us-ascii?q?IDnXYdNl5FdxWHj5bxN1HUPP/4Feu/g0irkDpzwfDGP6HuApLJLnfZi7ftZ7?=
 =?us-ascii?q?d960lbyAoo1tBS/JdUB74OIf7pXU/xrtPYBAcjMwOo2+bnFMl91oQGVGKUHK?=
 =?us-ascii?q?CZNKLSsVmV5uMgOOSMeoAVtyjnK/Q/5P7hk2U5mVkDcqmtx5cXb2q4Hvs1a3?=
 =?us-ascii?q?meNFztidAFGHxCnw05V/ei3FuDWjlXbm30XqU7/SoTDd62S4DZSdbpyKeM2C?=
 =?us-ascii?q?a9A41+eG9LEBaPHG3ueoHCXO0DOwyIJco0qSAJTbisTcca0BiqsALrg+58Iv?=
 =?us-ascii?q?H85jwTtZWl0sN8oeLUi0dhpnRPE82B3jTVHClPlWQSSmpzhfonrA=3D=3D?=
X-IPAS-Result: =?us-ascii?q?A2DlAQA5vOFb/wHyM5BkHAEBAQQBAQcEAQGBVAQBAQsBg?=
 =?us-ascii?q?VopgTUzJ4N2lDBMAQEBAQEBBoE1iRGJKIZxOAGEQAKDWCI3Cg0BAwEBAQEBA?=
 =?us-ascii?q?QIBbCiCNiQBgmABBSMPAQVRCxgCAiYCAlcGAQwGAgEBgl4/gXUNqDqBLoU8h?=
 =?us-ascii?q?HaBC4ptF3mBB4E4gmuER4M7glcCj26PSQmRDAYYkGQsmHgigVUrCAIYCCEPg?=
 =?us-ascii?q?yeCUI4oIQMwgQUBAYofgk0BAQ?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 06 Nov 2018 16:11:39 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id wA6GBcho009498;
        Tue, 6 Nov 2018 11:11:38 -0500
Subject: Re: [PATCH 1/1] libselinux: selinux_restorecon: fix printf format
 string specifier for uint64_t
To:     Nicolas Iooss <nicolas.iooss@m4x.org>, selinux@vger.kernel.org
References: <20181105205710.15548-1-nicolas.iooss@m4x.org>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <cd516a2d-1d18-ea4b-ec7b-4180dde81806@tycho.nsa.gov>
Date:   Tue, 6 Nov 2018 11:13:59 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181105205710.15548-1-nicolas.iooss@m4x.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 11/5/18 3:57 PM, Nicolas Iooss wrote:
> fc_count is defined as uint64_t, which needs to be printed with PRIu64
> (it is "llu" on x86 and "lu" on x86-64). Otherwise, building with
> 'CC="gcc -m32"' fails with:
> 
>      selinux_restorecon.c: In function ‘restorecon_sb’:
>      selinux_restorecon.c:633:26: error: format ‘%lu’ expects argument of
>      type ‘long unsigned int’, but argument 3 has type ‘uint64_t’ {aka
>      ‘long long unsigned int’} [-Werror=format=]
>           fprintf(stdout, "\r%luk", fc_count / STAR_COUNT);
>                              ~~^
>                              %llu
> 
> Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>

Acked-by: Stephen Smalley <sds@tycho.nsa.gov>

> ---
>   libselinux/src/selinux_restorecon.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/libselinux/src/selinux_restorecon.c b/libselinux/src/selinux_restorecon.c
> index 41f2225081e0..3df2d382d50b 100644
> --- a/libselinux/src/selinux_restorecon.c
> +++ b/libselinux/src/selinux_restorecon.c
> @@ -15,6 +15,7 @@
>   #include <errno.h>
>   #include <fcntl.h>
>   #include <fts.h>
> +#include <inttypes.h>
>   #include <limits.h>
>   #include <stdint.h>
>   #include <sys/types.h>
> @@ -630,7 +631,7 @@ static int restorecon_sb(const char *pathname, const struct stat *sb,
>   					     fc_count / efile_count) : 100;
>   				fprintf(stdout, "\r%-.1f%%", (double)pc);
>   			} else {
> -				fprintf(stdout, "\r%luk", fc_count / STAR_COUNT);
> +				fprintf(stdout, "\r%" PRIu64 "k", fc_count / STAR_COUNT);
>   			}
>   			fflush(stdout);
>   		}
> 

