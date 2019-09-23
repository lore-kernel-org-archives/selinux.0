Return-Path: <SRS0=61sA=XS=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDEE8C04EBF
	for <selinux@archiver.kernel.org>; Mon, 23 Sep 2019 13:54:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C2F220820
	for <selinux@archiver.kernel.org>; Mon, 23 Sep 2019 13:54:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="c+OaO/pB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406985AbfIWNyW (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 23 Sep 2019 09:54:22 -0400
Received: from UPDC19PA24.eemsg.mail.mil ([214.24.27.199]:26721 "EHLO
        UPDC19PA24.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405257AbfIWNyV (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 23 Sep 2019 09:54:21 -0400
X-EEMSG-check-017: 16260497|UPDC19PA24_ESA_OUT06.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.64,540,1559520000"; 
   d="scan'208";a="16260497"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by UPDC19PA24.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 23 Sep 2019 13:54:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1569246858; x=1600782858;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=7Zowg5MSKx2YTqrFY/6GVdjp+m6M4ZVa2hBHjo+UYtQ=;
  b=c+OaO/pBX+NaWFry4KFIZD9R+3CwPLcWgqCQkA8QJvsSft/P3+QNUw+i
   cgHQKWCS4oB1x5t0T+2d8AlHnnfvBrykOyOrGHHYezeLZRMAF2aNh9QQC
   Yw07slNLSETawi51i3MGu7l7lFJU1yHyjJ/xVzA8q98DCrbUxkThod9xk
   g1n7mti75Wad4FsN9ydCOCtIEnc4IR65J7+4vWBnDdvQYguhlwf4Vb/9O
   6wMowlJ/Fy/m9nmaMInnqHgQSOJpbibe2ooQcg18vgu1623L79poTebpL
   WKo1AHnoFz/ycFIA8ap8GHnnf8uXK/KJrxsT4Ti5hl0BRKQB9Gkt0eH1T
   Q==;
X-IronPort-AV: E=Sophos;i="5.64,540,1559520000"; 
   d="scan'208";a="28198693"
IronPort-PHdr: =?us-ascii?q?9a23=3ACAbrfxZ+igMglNehfSPC+XH/LSx+4OfEezUN45?=
 =?us-ascii?q?9isYplN5qZrs68bnLW6fgltlLVR4KTs6sC17ON9fqwEjJdqdbZ6TZeKcYKD0?=
 =?us-ascii?q?dEwewt3CUYSPafDkP6KPO4JwcbJ+9lEGFfwnegLEJOE9z/bVCB6le77DoVBw?=
 =?us-ascii?q?mtfVEtfre9FYHdldm42P6v8JPPfQpImCC9YbRvJxmqsAndrMYbjZZsJ6or1B?=
 =?us-ascii?q?fEoXREduVWyGh1IV6fgwvw6t2/8ZJ+7Shcoe4t+9JFXa7nY6k2ULtUASg8PW?=
 =?us-ascii?q?so/sPrrx7DTQWO5nsYTGoblwdDDhbG4h/nQJr/qzP2ueVh1iaUO832Vq00Vi?=
 =?us-ascii?q?+576h3Uh/oiTwIOCA//WrKl8F/lqNboBampxxi347ZZZyeOfRicq/Be94RWH?=
 =?us-ascii?q?FMVdhNWSNfHoy8bpMPD+sfMuZes4n9vEYFoR+nCQWxGO/j1jpEi3n40q0g1+?=
 =?us-ascii?q?QqDB/I0gouEdkTtHjYtdv4OaMXXe2z0aLGzyjMb+lO1Dng9obIfBAvr/KCU7?=
 =?us-ascii?q?1+fsXey1UgGQzeg1WMq4HoJS+Z2vgDvmWZ6edrSOKhi3QgqwF0ujWh29sshZ?=
 =?us-ascii?q?fRhoIV1F/E8zhyzpswJdKiTE57ZcCrEZtNvCydLIt5X9giTnp0uCc61rIGuZ?=
 =?us-ascii?q?m7cDIMyJQ83RHTcfOHc4+W4h/6UuuaPDR2hGp9db6iiBu//lKsx+3hWsWuzl?=
 =?us-ascii?q?pHoTRJnsPRun0Lyhfd8NKISuFn8UekwTuP0gfT5fxaLk0sjqrbLoIhwqY3lp?=
 =?us-ascii?q?oOrUTPBi/2l1vyjK+Rbkgk5vKn6/7mYrX7vZ+QLZN0iwHiPaQuncyzG+I4PR?=
 =?us-ascii?q?QVX2eH4+i80bzj/UnhTLVLiP05jLXZvYjHKckUqaO1GQ9Y3ps55xqhADqqzs?=
 =?us-ascii?q?4UkWQfIFJAYh2HjozpO1/UIPD/CPeym0+snypwx/3dIr3gAonCLnjEkLv7e7?=
 =?us-ascii?q?Z98FRTxBA8zdBY+ZJYEqsBL+7rWk/tqNzYCQc0Mwq1w+n7D9V90pkRWXmVDq?=
 =?us-ascii?q?+YN6PStkSI5vk0LumJa4IUtyzxK/8/5/7hlXU5g0MSfbG13ZsLb3C1Bu9mLF?=
 =?us-ascii?q?udYXrthNcBDGgLsxEgTOzlllKCSyRfZ3WsUKIm4DE0FoamAZ3ERoC3j7zSlB?=
 =?us-ascii?q?u8S7tXbWdCA0vEMHDvbJ7MD/ENYyWWK9QnkzsDTqOJTtMxkxa0u1m+g6FqKu?=
 =?us-ascii?q?vS5z0wq53uzp526vfVmBV08iZ7XOqH1GTYdH15hmMFQXcN2al7pUFsggOY3b?=
 =?us-ascii?q?NQn+1TFdsV4ehAFAg9K8iPnKRBF9nuV1eZLZ+yQ1G8T4DjWGpgQw=3D=3D?=
X-IPAS-Result: =?us-ascii?q?A2D4AABJzIhd/wHyM5BlHAEBAQQBAQwEAQGBUwcBAQsBg?=
 =?us-ascii?q?XMqgUAyKoQiiByGcU0BAQEBAQEGgTaJdY8tgXsJAQEBAQEBAQEBNAECAQGDP?=
 =?us-ascii?q?wEBfgKDFiM0CQ4CDAEBAQQBAQEBAQUDAQFshTmCOikBgmYBAQEBAgEjBBFRC?=
 =?us-ascii?q?xgCAiYCAlcGAQwGAgEBgl8/gXcFD6wCc38zhUyDLIFIgQwoAYwIGHiBB4E4g?=
 =?us-ascii?q?ms+h0+CWASWApcKgiyCLpJWBhuZJY4amw84gVgrCAIYCCEPgydQEBSBWheOP?=
 =?us-ascii?q?iQDMIEGAQGMIAEB?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 23 Sep 2019 13:54:16 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x8NDsF9g025838;
        Mon, 23 Sep 2019 09:54:15 -0400
Subject: Re: [PATCH v2 2/2] libselinux: do not add rc to pos twice
To:     Nicolas Iooss <nicolas.iooss@m4x.org>, selinux@vger.kernel.org
References: <20190920055955.2780-1-nicolas.iooss@m4x.org>
 <20190920055955.2780-2-nicolas.iooss@m4x.org>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <6a9e7263-8af0-81b9-03ae-8655a20e0ec6@tycho.nsa.gov>
Date:   Mon, 23 Sep 2019 09:54:15 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20190920055955.2780-2-nicolas.iooss@m4x.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 9/20/19 1:59 AM, Nicolas Iooss wrote:
> In regex_format_error(), when error_data->error_offset is zero, rc is
> not updated and should not be added to pos again.

Thanks, both patches applied.

> 
> Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
> ---
>   libselinux/src/regex.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/libselinux/src/regex.c b/libselinux/src/regex.c
> index c835dd1b0e5d..770bc3ea1310 100644
> --- a/libselinux/src/regex.c
> +++ b/libselinux/src/regex.c
> @@ -552,10 +552,10 @@ void regex_format_error(struct regex_error_data const *error_data, char *buffer,
>   #endif
>   		if (rc < 0)
>   			abort();
> +		pos += rc;
> +		if (pos >= buf_size)
> +			goto truncated;
>   	}
> -	pos += rc;
> -	if (pos >= buf_size)
> -		goto truncated;
>   
>   #ifdef USE_PCRE2
>   	rc = pcre2_get_error_message(error_data->error_code,
> 

