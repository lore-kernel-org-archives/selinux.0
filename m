Return-Path: <SRS0=wOFf=QL=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE01DC282C4
	for <selinux@archiver.kernel.org>; Mon,  4 Feb 2019 16:54:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E51720815
	for <selinux@archiver.kernel.org>; Mon,  4 Feb 2019 16:54:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="eCDWmSi/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725980AbfBDQyl (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 4 Feb 2019 11:54:41 -0500
Received: from ucol19pa12.eemsg.mail.mil ([214.24.24.85]:32609 "EHLO
        ucol19pa12.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727308AbfBDQyl (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 4 Feb 2019 11:54:41 -0500
X-EEMSG-check-017: 682274522|UCOL19PA12_EEMSG_MP10.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.56,560,1539648000"; 
   d="scan'208";a="682274522"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by ucol19pa12.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 04 Feb 2019 16:54:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1549299251; x=1580835251;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=nRyuHHJWv9OvSr8qmW32wb0gISgjW2bRAiY5fVH/wHI=;
  b=eCDWmSi/o6yjri+p9EHcJ7wGAdUIRwGi01RE/9hQBCJusXOHNv/tL2n2
   EFAyHaLQGBryb7k/BfWZX29MGPhmcsEJefRSGdqeoNNEx0tsDTZlrOStE
   +m78Zks4iZPw6qXXyjhjgA+Qo5A5qkkxzipf99cTjE/T5Ng79kKZBrMmh
   bKf66PMgR/Ot2TJoZVp2OqAnjULyHxwfvjRBlzNABRfiTOw5XUwOSrwA0
   ZvxBzQ4eNkDCQPdELKm8dBtzrJNgsi8+HnFTpCJK07windcmgrzR6SX+7
   Ag545u9tXOHEHfRPrgZy0q/pZcDYjZ8OYJ7WWZDmBd+6P3j9vWFbPak3Y
   g==;
X-IronPort-AV: E=Sophos;i="5.56,560,1539648000"; 
   d="scan'208";a="23465286"
IronPort-PHdr: =?us-ascii?q?9a23=3AVLjRlR8RVCLxFf9uRHKM819IXTAuvvDOBiVQ1K?=
 =?us-ascii?q?B31O0cTK2v8tzYMVDF4r011RmVBdWds6oMotGVmpioYXYH75eFvSJKW713fD?=
 =?us-ascii?q?hBt/8rmRc9CtWOE0zxIa2iRSU7GMNfSA0tpCnjYgBaF8nkelLdvGC54yIMFR?=
 =?us-ascii?q?XjLwp1Ifn+FpLPg8it2O2+557ebx9UiDahfLh/MAi4oQLNu8cMnIBsMLwxyh?=
 =?us-ascii?q?zHontJf+RZ22ZlLk+Nkhj/+8m94odt/zxftPw9+cFAV776f7kjQrxDEDsmKW?=
 =?us-ascii?q?E169b1uhTFUACC+2ETUmQSkhpPHgjF8BT3VYr/vyfmquZw3jSRMNboRr4oRz?=
 =?us-ascii?q?ut86ZrSAfpiCgZMT457HrXgdF0gK5CvR6tuwBzz4vSbY6bLvp+er7Wc80cS2?=
 =?us-ascii?q?RPQ81dUzVNDp2gY4cKCecKIORWoJTnp1YWsBWwGwesCuPsxDFGiHD50q813P?=
 =?us-ascii?q?guHwzdwAwtHcgDvGjIoNj7NqofV/2+wqnSzTXEavNbwTX96YbUfR87u/GMQa?=
 =?us-ascii?q?x8etfWxEktGQLKkk+fqZb5Pz+LzekNr2ia4PZgVeKokWInrRpxrSK1yscjjY?=
 =?us-ascii?q?nJmJsYx1bZ/it62IY4PcC0RUF0bNK+EJZcqjuWO5V5T888WW1kpSA3waAct5?=
 =?us-ascii?q?GhZigF0pEnygbaa/yAboeH/AruVP2UITdknHJlf6+/hwqq/Uig1OL8Us603U?=
 =?us-ascii?q?5WriVfiNnMt20N1wfJ5sibSvpy4keh2TGV2wDV9u5EOlw7mbDeK54gxr48jp?=
 =?us-ascii?q?sTsULdES/qgEj6kaCbe0o+9uWo9ujreKvqq5CCO4Nulw3yKqEulda+AeQ8PA?=
 =?us-ascii?q?gORW+b+eGk2b3h80z2XK9FjucqkqXHq53aOcQaqbK5Aw9SyIoj7Q2/AC283N?=
 =?us-ascii?q?QXmnkHMkpJeAibgIjxJ1HOPPf4AO+5g1StjDhrwPTGMaf6ApnXL3jDl7Dhfa?=
 =?us-ascii?q?1m60NHzQo+wt9e64hTCrEbL/L5QlXxu8DADh8lLwy0xP7qCM5j2YMaWGKPBL?=
 =?us-ascii?q?KZMazJvF+W6eIgPfOMaJUWuDnjMfgl4eDhjXsjlV8aZ6mp0shfVHftOPVtJE?=
 =?us-ascii?q?GQejLNhdAaCi9euAs1S+jjkxuDVjlIfF63A7J64Ss0XsbuForHR4awkJSf0y?=
 =?us-ascii?q?qhWJ5bfGZLDhaLC3i7WZ+DXqIOdymbONM72mgGSrOoUZN7/Q2/vw/9jbx8J6?=
 =?us-ascii?q?zb/TNO5sGr78R8++CGzUJ6zjdzFcnIljjXF2w=3D?=
X-IPAS-Result: =?us-ascii?q?A2CnAAB6bVhc/wHyM5BkHAEBAQQBAQcEAQGBVAQBAQsBg?=
 =?us-ascii?q?VopgTgyJ4QDlA2BYC2aCjgBhEACgyAiNwYNAQMBAQEBAQECAWwogjopAYJnA?=
 =?us-ascii?q?QUjBBFRCwkPAgImAgJXBgEMBgIBAYJfP4ICqmp8M4VEhGqBC4s2gVZAgTiCa?=
 =?us-ascii?q?4gKglcCgSwBj0k6kUIGA5I0BhmSRC2JdpM4IoFWKwpBgWiBToJSjikhAzCBB?=
 =?us-ascii?q?QEBjW8BAQ?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 04 Feb 2019 16:54:11 +0000
Received: from moss-lions.infosec.tycho.ncsc.mil (moss-lions.infosec.tycho.ncsc.mil [192.168.25.4])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x14Gs9xj024266;
        Mon, 4 Feb 2019 11:54:09 -0500
Subject: Re: [Non-DoD Source] [PATCH 1/1] libsepol: do not use uninitialized
 value for low_value
To:     Nicolas Iooss <nicolas.iooss@m4x.org>, selinux@vger.kernel.org
References: <20190203110152.15064-1-nicolas.iooss@m4x.org>
From:   jwcart2 <jwcart2@tycho.nsa.gov>
Message-ID: <0e0c3fc1-e6db-d59f-5f8c-5cc1b58705d1@tycho.nsa.gov>
Date:   Mon, 4 Feb 2019 11:54:09 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190203110152.15064-1-nicolas.iooss@m4x.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 2/3/19 6:01 AM, Nicolas Iooss wrote:
> clang's static analyzer reports a warning when low_bit is used without
> having been initialized in statements such as:
> 
>      low_value = low_bit << 8;
> 
> The warning is: "Result of operation is garbage or undefined".
> 
> This is caused by low_bit being only initialized when in_range is true.
> This issue is not critical because low_value is only used in an
> "if (in_range)" block. Silence this warning by moving low_value's
> assignment inside this block.
> 
> Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>

Acked-by: James Carter <jwcart2@tycho.nsa.gov>

> ---
>   libsepol/src/kernel_to_cil.c | 4 ++--
>   libsepol/src/module_to_cil.c | 4 ++--
>   libsepol/src/util.c          | 4 ++--
>   3 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/libsepol/src/kernel_to_cil.c b/libsepol/src/kernel_to_cil.c
> index 63e4d4899758..cd3554e8dfd9 100644
> --- a/libsepol/src/kernel_to_cil.c
> +++ b/libsepol/src/kernel_to_cil.c
> @@ -1614,8 +1614,8 @@ static char *xperms_to_str(avtab_extended_perms_t *xperms)
>   
>   		if (xperms->specified & AVTAB_XPERMS_IOCTLFUNCTION) {
>   			value = xperms->driver<<8 | bit;
> -			low_value = xperms->driver<<8 | low_bit;
>   			if (in_range) {
> +				low_value = xperms->driver<<8 | low_bit;
>   				len = snprintf(p, remaining, " (range 0x%hx 0x%hx)", low_value, value);
>   				in_range = 0;
>   			} else {
> @@ -1623,8 +1623,8 @@ static char *xperms_to_str(avtab_extended_perms_t *xperms)
>   			}
>   		} else if (xperms->specified & AVTAB_XPERMS_IOCTLDRIVER) {
>   			value = bit << 8;
> -			low_value = low_bit << 8;
>   			if (in_range) {
> +				low_value = low_bit << 8;
>   				len = snprintf(p, remaining, " (range 0x%hx 0x%hx)", low_value, (uint16_t) (value|0xff));
>   				in_range = 0;
>   			} else {
> diff --git a/libsepol/src/module_to_cil.c b/libsepol/src/module_to_cil.c
> index 4cb44e0ee657..f04589edaeff 100644
> --- a/libsepol/src/module_to_cil.c
> +++ b/libsepol/src/module_to_cil.c
> @@ -655,8 +655,8 @@ static int xperms_to_cil(const av_extended_perms_t *xperms)
>   
>   		if (xperms->specified & AVTAB_XPERMS_IOCTLFUNCTION) {
>   			value = xperms->driver<<8 | bit;
> -			low_value = xperms->driver<<8 | low_bit;
>   			if (in_range) {
> +				low_value = xperms->driver<<8 | low_bit;
>   				cil_printf("(range 0x%hx 0x%hx)", low_value, value);
>   				in_range = 0;
>   			} else {
> @@ -664,8 +664,8 @@ static int xperms_to_cil(const av_extended_perms_t *xperms)
>   			}
>   		} else if (xperms->specified & AVTAB_XPERMS_IOCTLDRIVER) {
>   			value = bit << 8;
> -			low_value = low_bit << 8;
>   			if (in_range) {
> +				low_value = low_bit << 8;
>   				cil_printf("(range 0x%hx 0x%hx)", low_value, (uint16_t) (value|0xff));
>   				in_range = 0;
>   			} else {
> diff --git a/libsepol/src/util.c b/libsepol/src/util.c
> index b00251c69aa5..a4008882b94b 100644
> --- a/libsepol/src/util.c
> +++ b/libsepol/src/util.c
> @@ -159,16 +159,16 @@ char *sepol_extended_perms_to_string(avtab_extended_perms_t *xperms)
>   
>   		if (xperms->specified & AVTAB_XPERMS_IOCTLFUNCTION) {
>   			value = xperms->driver<<8 | bit;
> -			low_value = xperms->driver<<8 | low_bit;
>   			if (in_range) {
> +				low_value = xperms->driver<<8 | low_bit;
>   				len = snprintf(p, sizeof(xpermsbuf) - xpermslen, "0x%hx-0x%hx ", low_value, value);
>   			} else {
>   				len = snprintf(p, sizeof(xpermsbuf) - xpermslen, "0x%hx ", value);
>   			}
>   		} else if (xperms->specified & AVTAB_XPERMS_IOCTLDRIVER) {
>   			value = bit << 8;
> -			low_value = low_bit << 8;
>   			if (in_range) {
> +				low_value = low_bit << 8;
>   				len = snprintf(p, sizeof(xpermsbuf) - xpermslen, "0x%hx-0x%hx ", low_value, (uint16_t) (value|0xff));
>   			} else {
>   				len = snprintf(p, sizeof(xpermsbuf) - xpermslen, "0x%hx-0x%hx ", value, (uint16_t) (value|0xff));
> 


-- 
James Carter <jwcart2@tycho.nsa.gov>
National Security Agency
