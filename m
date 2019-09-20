Return-Path: <SRS0=JJ8R=XP=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B585C49ED7
	for <selinux@archiver.kernel.org>; Fri, 20 Sep 2019 14:23:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F630207E0
	for <selinux@archiver.kernel.org>; Fri, 20 Sep 2019 14:23:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="BPi5heWJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387892AbfITOXJ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 20 Sep 2019 10:23:09 -0400
Received: from USAT19PA22.eemsg.mail.mil ([214.24.22.196]:41537 "EHLO
        USAT19PA22.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387698AbfITOXJ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 20 Sep 2019 10:23:09 -0400
X-EEMSG-check-017: 30148367|USAT19PA22_ESA_OUT03.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.64,528,1559520000"; 
   d="scan'208";a="30148367"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by USAT19PA22.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 20 Sep 2019 14:22:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1568989361; x=1600525361;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=14WHOdOxF9udAoV0PbFtgMA/wNK6jBNeyOwZAL72mdA=;
  b=BPi5heWJYDlUvU93ZU1O/Kv0/ySmpk4+gyH9VMxDNQIjA9PBtipLXJ2D
   0l8aiC2PYfa7uoFSwnTlWfvYIVgAM/pxkMOFoQxrNjgiK1mTiaiyhPhBk
   +KLdMjy64OEl4Mbc9KzI13qJmeI9q6XdDEaVFMaTnoxSSBm8aYS2BQZid
   buZR+BkEBB7V4jcH7A8rF5uAAG/HRfkRpItayWFRB3SG8KjsPGOA73EbO
   d57FQkPWWNsbHwqjrN4qE7gWJtOCVsf7hidDhlaPi8HqvGv4dn7eg0Y9U
   nL5AMXLNHJewUMCoMx+CGwQuqQJTXMjkJU6TTkZoOxErqfQcUTfANXg5d
   w==;
X-IronPort-AV: E=Sophos;i="5.64,528,1559520000"; 
   d="scan'208";a="28143917"
IronPort-PHdr: =?us-ascii?q?9a23=3AJTVYJxD6s0sCX4hePbxmUyQJP3N1i/DPJgcQr6?=
 =?us-ascii?q?AfoPdwSPX5ocbcNUDSrc9gkEXOFd2Cra4d0KyM6eu/BSRAuc/H7ClYNsQUFl?=
 =?us-ascii?q?cssoY/p0QYGsmLCEn2frbBThcRO4B8bmJj5GyxKkNPGczzNBX4q3y26iMOSF?=
 =?us-ascii?q?2kbVImbuv6FZTPgMupyuu854PcYxlShDq6fLh+MAi6oR/eu8ULj4ZuMLg9xg?=
 =?us-ascii?q?XGrnZKdOld2GdkKU6Okxrm6cq84YBv/z5Mt/498sJLTLn3cbk/QbFEFjotLn?=
 =?us-ascii?q?o75NfstRnNTAuP4mUTX2ALmRdWAAbL8Q/3UI7pviT1quRy1i+aPdbrTb8vQj?=
 =?us-ascii?q?St871rSB7zhygZMTMy7XzahdZxjKJfpxKhugB/zovJa4ybKPZyYqXQds4BSG?=
 =?us-ascii?q?FfQsheSTBOAoKkb4sOEeUBO/pYr5LgrFcKtBeyGBWgCP/qxjJOiHD2x6k62P?=
 =?us-ascii?q?k/Hw/A0gIrAtYCvG3aodjxMasfV/2+wqvVwjXZd/5YxCnz6IbIfB4ir/+DU7?=
 =?us-ascii?q?1/fsjNxkcgDA7FkledpJb5Mz+J2OkAsW6W5PdgW+K1jG4nrhl8rCWzxsgyko?=
 =?us-ascii?q?nJhpwaylbZ/itkxYY6P9m4SEplbt+kDZBdsDqaOJZtQs45X2FpuDo1yr0BuZ?=
 =?us-ascii?q?KheigK044oywTQa/yAbYiF+xTuX/uSLzdgnH9pZb2yihmo/UWg1+HwTNe43V?=
 =?us-ascii?q?lUoiZfj9XBsG0G2QbJ5cidUPR9+1+s2TOI1w/O9O5JOVs0la/HK545xb4wi4?=
 =?us-ascii?q?YTvVzDHiDonEX2i7ebdlk+9eiy6uTnf67mqoWAN450lg7+MqMulta5AeskKQ?=
 =?us-ascii?q?gBQ3KX+eG91L3n5UH5QbNKgeMqkqTBrZzXKssWqrS5DgNIyIov9RmyAym83N?=
 =?us-ascii?q?gFhXUHKUhKeBODj4jnIVHOJ/X4AO+kg1uxizdm3OzGP739DZXNKXjPirHhfa?=
 =?us-ascii?q?1n5EJGxwozys5f64pOCr4dOPLzRlPxtNvAAx8/Mgy73+HnCNFn2YMFQ26PA6?=
 =?us-ascii?q?iZMKTJsV+T/e8vJuaBZYAPtDb6Mfgl6ObkjWUlll8FYampwZwXZWijHvt4J0?=
 =?us-ascii?q?WZYHzsgsoOEGoRoAo+Q/LliEeYXT5QeXmyRaQ86S8/CI68CofDXI+t0/S923?=
 =?us-ascii?q?KdH5ZRYmldQnGLFmzzP9GCWvwLbCuJZM5mlScffb39W8kmzx748Efhxr5mKP?=
 =?us-ascii?q?fE0jMXuIil19Vv4eDX0xYo+m9aFcOYhlqRQnl0k2VAfDo/2KRysAQp0VuY+b?=
 =?us-ascii?q?RpiPxfU9pI7rVGVRlsZs2U9PBzF92nAlGJRdyOUlvzB4z9UDw=3D?=
X-IPAS-Result: =?us-ascii?q?A2A6NQDR34Rd/wHyM5BlHAEBAQQBAQcEAQGBZ4F0KoFAM?=
 =?us-ascii?q?iqEIo8XTQEBAQEBAQaBESWJdZEoCQEBAQEBAQEBATQBAgEBgz8BAX4CgwkjO?=
 =?us-ascii?q?BMCDAEBAQQBAQEBAQUDAQFshTmCOikBgmcBBSMEEVELGAICJgICVwYBDAYCA?=
 =?us-ascii?q?QGCXz+BdxSsGH8zhUyDNoFJgQwojAkYeIEHgTgMgl8+h0+CWASWApcLgiyCL?=
 =?us-ascii?q?pJWBhuZJo4amyghgVgrCAIYCCEPgydQEBSBWheOPiQDMIEGAQGONgEB?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 20 Sep 2019 14:22:40 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x8KEMe1n009336;
        Fri, 20 Sep 2019 10:22:40 -0400
Subject: Re: [PATCH v2 2/2] libselinux: do not add rc to pos twice
To:     Nicolas Iooss <nicolas.iooss@m4x.org>, selinux@vger.kernel.org
References: <20190920055955.2780-1-nicolas.iooss@m4x.org>
 <20190920055955.2780-2-nicolas.iooss@m4x.org>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <16024ca5-6af2-0812-a16d-71d13396f18e@tycho.nsa.gov>
Date:   Fri, 20 Sep 2019 10:22:40 -0400
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
> 
> Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>

Acked-by: Stephen Smalley <sds@tycho.nsa.gov>

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

