Return-Path: <SRS0=jdxV=XO=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,URI_HEX,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 332A5C3A5A6
	for <selinux@archiver.kernel.org>; Thu, 19 Sep 2019 16:57:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06DAC21907
	for <selinux@archiver.kernel.org>; Thu, 19 Sep 2019 16:57:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="buFGuA7r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389317AbfISQ5Z (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 19 Sep 2019 12:57:25 -0400
Received: from USAT19PA21.eemsg.mail.mil ([214.24.22.195]:18286 "EHLO
        USAT19PA21.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388945AbfISQ5Z (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 19 Sep 2019 12:57:25 -0400
X-EEMSG-check-017: 29896711|USAT19PA21_ESA_OUT02.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.64,524,1559520000"; 
   d="scan'208";a="29896711"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by USAT19PA21.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 19 Sep 2019 16:57:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1568912241; x=1600448241;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=GdYp5PFyOGUODiyUdUuvCxFeO9igiaq8U+GI8/W4wls=;
  b=buFGuA7rdLSOr7wpanrPi2NFKXgxYcK4e1apTlM0op7N6r9caieJzo/m
   2ZydjHQ1hah6dRVV3/huXEY7Fq/wYLhlUi+gWEathOKbKCPn9xxB9zDtV
   EiWz8Y5I7gbhmovcE9J/oKBjwQR+ywqNWkmMs5ZWCyGtTNRD0i/3dNM4y
   8teNXvnakpQAp0B5lDAMROFRanPwJWSAVxSBa+ITJ1AEtiaRQ1ip2bLa+
   9tOuqjARxtzLMmCe0bVItEa3vLQcm6aZeUVAT5BZe/YtPr9xfvZB1B9M2
   lnrbReqRfaphlXm0HXRfSlw+g0dg9STw84KrWFlLB7zf+ydRVnyH4vEri
   Q==;
X-IronPort-AV: E=Sophos;i="5.64,524,1559520000"; 
   d="scan'208";a="33088818"
IronPort-PHdr: =?us-ascii?q?9a23=3AmEYOdxMg3gUcxzo98Bcl6mtUPXoX/o7sNwtQ0K?=
 =?us-ascii?q?IMzox0I/T8rarrMEGX3/hxlliBBdydt6sfzbCO+Pm4BiRAuc/H7ClYNsQUFl?=
 =?us-ascii?q?cssoY/p0QYGsmLCEn2frbBThcRO4B8bmJj5GyxKkNPGczzNBX4q3y26iMOSF?=
 =?us-ascii?q?2kbVImbuv6FZTPgMupyuu854PcYxlShDq6fLh+MAi6oR/eu8ULj4ZuMLg9xg?=
 =?us-ascii?q?fGrndVZ+hbx35jKVaPkxrh/Mu984Nv/zpKt/4968JMVLjxcrglQ7BfEDkoKX?=
 =?us-ascii?q?0+6tfxtRnEQwuP538cXXsTnxFVHQXL7wz0U4novCfiueVzxCeVPcvtTbApQj?=
 =?us-ascii?q?ui9LtkSAXpiCgcKTE09nzch9Fqg6JapBKhoAF/w5LRbYqIOvdyYr/RcNUHTm?=
 =?us-ascii?q?daQM1fSzJODZ+9b4sXDuoOI+BYr5Xmp1ATqReyHBSgCP/zxjNNgHL507c60+?=
 =?us-ascii?q?A8Gg/Y2gIuEc8FvHDNoNnrMKoeVOa4x7TKwzredfNbwSrz5pbGch4hov+CU7?=
 =?us-ascii?q?x/fsXTxkYzGA3IlUmQpI7/Mj+JyugAvWqW4ux9XuyvkW4nrARxryCyyMcwlI?=
 =?us-ascii?q?bJnoIVxU7C9S5k3Yg1IMe3SEp/YdG6EJpbqiaXN5BrTcM5WGxopCY7xaEGuZ?=
 =?us-ascii?q?68ZiQKzo8nyATFZ/yIdIiI/AvuWeCMKjl2g3Jlfaiwhxe08UW41uL8V9O030?=
 =?us-ascii?q?pOriVbi9XDrGoN1wDS6siJUPRy4luh2S2V2w/P7eFEJEY5nrfYJZ452rM8i5?=
 =?us-ascii?q?UevEvZEiL2hUn6lrGae0o69uSy9ujqZKjtqIWGOI9ukA7+N7wjmsm4AeslLA?=
 =?us-ascii?q?cDR3Ob+eGg1L37+k35XalKguU2kqbHtJDaItwWprKjDA9P04Yj9g2/Ay260N?=
 =?us-ascii?q?UYgXYHLFVFdAiBj4f1IFHBPOr0DfK+g1SoiDtrxvbGMaP9ApjVM3TOn7jsca?=
 =?us-ascii?q?x95kJB0gY/099S64xOBr0cOP7zX1X+tN3cDh83KQy0xOPnBc1m1owDQmKCGb?=
 =?us-ascii?q?OZMaPOvl+I4eIjOe+MZJQPtzrnJPgl4ODugWcjmVABZampwYcXaHegE/RgIk?=
 =?us-ascii?q?WWfX3sgtMbHmcRpAY+TevqiFqZUT5IfHuyWq0x5z4hBIKhF4fDSZingKad0y?=
 =?us-ascii?q?ejAp1WemdGB0iXEXj2c4WEWvEMaD+dI8J6jDwEWqauS5U72RGtqgD60bxnIf?=
 =?us-ascii?q?TQ+iECspLjztd1tKXvkkQU9DdzC82Gm0CKSHpv1jcORjQx2Klk5016zUyY+a?=
 =?us-ascii?q?0kk7pfD9MFo7tSXwM7M4PM5/J1Bsq0WQ/beNqNDlG8TYaIGzY0G+ktzscObk?=
 =?us-ascii?q?A1INCrihTOzmL+GLMOv6CaD5wztKTH1j7+INgrmCWO77Uok1RzGpgHDmahnK?=
 =?us-ascii?q?MqslGJVoM=3D?=
X-IPAS-Result: =?us-ascii?q?A2CxAQAisoNd/wHyM5BlHQEBBQEHBQGBVAcBCwGBbSptU?=
 =?us-ascii?q?gEyKoQijxRNAQEBAQEBBoE2iXSPLYF7CQEBAQEBAQEBAS8FAQIBAYQ/AoMDI?=
 =?us-ascii?q?zUIDgIMAQEBBAEBAQEBBQMBAWyFLQyCOikBgmYBAQEBAgEjBBFRCxgCAiYCA?=
 =?us-ascii?q?lcGAQwGAgEBgl8/AYF2BQ8PrEN/M4Q3AQMBAgMIQ0CDKoFDBoEMKAGMCBh4g?=
 =?us-ascii?q?QeBESeCaz6CYQSBKINCglgEjE2JM5cGgiyCLoRXjX0GG5kjjhabDQE1gVgrC?=
 =?us-ascii?q?AIYCCEPgycTPRAUgVoXgQQBAoJIim8kAzABgQUBAY0aglQBAQ?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 19 Sep 2019 16:57:17 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x8JGvGWg015413;
        Thu, 19 Sep 2019 12:57:16 -0400
Subject: Re: [PATCH 1/1] libselinux: ensure strlen() is not called on NULL
To:     Nicolas Iooss <nicolas.iooss@m4x.org>, selinux@vger.kernel.org
References: <20190918210450.8692-1-nicolas.iooss@m4x.org>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <1800df5d-121c-e275-f3bc-ec71d2b0d3e7@tycho.nsa.gov>
Date:   Thu, 19 Sep 2019 12:57:16 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20190918210450.8692-1-nicolas.iooss@m4x.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 9/18/19 5:04 PM, Nicolas Iooss wrote:
> When compile_regex() calls regex_prepare_data() and this function fails
> in the following condition:
> 
>      *regex = regex_data_create();
>      if (!(*regex))
>          return -1;
> 
> ... error_data has been zero-ed and compile_regex() calls:
> 
>      regex_format_error(&error_data,
>          regex_error_format_buffer,
>          sizeof(regex_error_format_buffer));
> 
> This leads to a call to strlen(error_data->error_buffer), where
> error_data->error_buffer is NULL.
> 
> Avoid this by checking that error_data->error_buffer is not NULL before
> calling strlen().

It seems like regex_format_error() should just return immediately if 
!error_data->error_code (#ifdef USE_PCRE2) or !error_data->error_buffer 
(#ifndef USE_PCRE2), since there is no back-end error message to get and 
report in that situation.

> 
> This issue has been found using clang's static analyzer:
> https://337-118970575-gh.circle-artifacts.com/0/output-scan-build/2019-09-01-181851-6152-1/report-0b122b.html#EndPath
> 
> Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
> ---
>   libselinux/src/regex.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/libselinux/src/regex.c b/libselinux/src/regex.c
> index a6fcbbfec1f3..f967efe4a32f 100644
> --- a/libselinux/src/regex.c
> +++ b/libselinux/src/regex.c
> @@ -546,7 +546,7 @@ void regex_format_error(struct regex_error_data const *error_data, char *buffer,
>   	if (rc < 0)
>   		abort();
>   
> -	if ((size_t)rc < strlen(error_data->error_buffer))
> +	if (error_data->error_buffer && (size_t)rc < strlen(error_data->error_buffer))
>   		goto truncated;
>   #endif
>   
> 

