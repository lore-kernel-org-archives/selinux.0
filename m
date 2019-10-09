Return-Path: <SRS0=kJgC=YC=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8658FC47404
	for <selinux@archiver.kernel.org>; Wed,  9 Oct 2019 14:42:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B7F02190F
	for <selinux@archiver.kernel.org>; Wed,  9 Oct 2019 14:42:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="WDppy/w5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731397AbfJIOmL (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 9 Oct 2019 10:42:11 -0400
Received: from UCOL19PA38.eemsg.mail.mil ([214.24.24.198]:45651 "EHLO
        UCOL19PA38.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731155AbfJIOmK (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 9 Oct 2019 10:42:10 -0400
X-EEMSG-check-017: 33979451|UCOL19PA38_ESA_OUT05.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.67,276,1566864000"; 
   d="scan'208";a="33979451"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by UCOL19PA38.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 09 Oct 2019 14:41:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1570632119; x=1602168119;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=a6JEyqLU/qzmqJ8vAjCyc+x+08pTPyakaVzI1WUVqxI=;
  b=WDppy/w5ZL7nol7vHiY8vLsBfmqJ6fJz/+vjlbtpwZjT9mCk0Ex1uHZw
   M8qw2LFjzEXk1D7hRGr9axqXY0l5+u3PcXz8LvIMEIlhgtnG1jITO7wpK
   NoEG4XlspVF+rWWtqR4jwvzbK6S1zDWA0XYikR3QFCNvr/U/iRyPb32Tb
   f4mj2JIIirXLTPHsvZYKBHoadnrD/IVumaVbtZs7TfoDf9XJV+OEdDGkr
   jZkj2351BzII2TZKIv6hGi6gPQCPptBiayLgaBrvPGauovqdaDO6/XcOh
   C16QRU20RCNmOS8QgsqgfTKRUvoeCrUEymnTNjgfy3RvRSueoOkdTeIHq
   A==;
X-IronPort-AV: E=Sophos;i="5.67,276,1566864000"; 
   d="scan'208";a="33957415"
IronPort-PHdr: =?us-ascii?q?9a23=3AuiBa9BZ+lDZG0SXyHP8Izyv/LSx+4OfEezUN45?=
 =?us-ascii?q?9isYplN5qZr8S6bnLW6fgltlLVR4KTs6sC17ON9f65EjFZqb+681k6OKRWUB?=
 =?us-ascii?q?EEjchE1ycBO+WiTXPBEfjxciYhF95DXlI2t1uyMExSBdqsLwaK+i764jEdAA?=
 =?us-ascii?q?jwOhRoLerpBIHSk9631+ev8JHPfglEnjWwba58IRmsrAjdq8YajIt/Jq0s1h?=
 =?us-ascii?q?bHv3xEdvhMy2h1P1yThRH85smx/J5n7Stdvu8q+tBDX6vnYak2VKRUAzs6PW?=
 =?us-ascii?q?874s3rrgTDQhCU5nQASGUWkwFHDBbD4RrnQ5r+qCr6tu562CmHIc37SK0/VD?=
 =?us-ascii?q?q+46t3ThLjlTwKPCAl/m7JlsNwjbpboBO/qBx5347Ue5yeOP5ncq/AYd8WWW?=
 =?us-ascii?q?9NU8BfWCxbBoO3cpUBAewPM+1Fq4XxvlUDoB+7CQSqGejhyCJHhmXu0KMnze?=
 =?us-ascii?q?ohHwHI0g8uEd0Av3vbrsn6OqgJXOCpzqTF1ynPY+9Y1Dr/7oXDbxAvoeuLXb?=
 =?us-ascii?q?J1acff1FUvGB3djlWQt4PlOS6e2PkIs2eB6+pgUfygim46oAx2uTig29wsh5?=
 =?us-ascii?q?LVhoMV1l/E9SJ5zJwzJd2jUkF3e9GkEJxOtyyDMYZ9X8AsQ3lwtSonxbALto?=
 =?us-ascii?q?S3cSgXxJg92RLSZOKLf5KV7h/lSe2fOy13hGh/d7K6nxuy9E+gxfDiWcSsy1?=
 =?us-ascii?q?ZKqzZFksHLtnAQyxzf8siHReV5/kemwTuPyxrc6vtFIUApjqrXMYIhw74smZ?=
 =?us-ascii?q?oTtkTPBCn2l1ntjKCKbEkk/+mo6+D/brXnoJ+TKZN0hxnjPqkhlcGzG+Q1Ph?=
 =?us-ascii?q?UUU2SF9umwyqfv8VDhTLVPlPI2k63ZsJ7AJcQco660GxRV3Zs46xukEzen0M?=
 =?us-ascii?q?gXnXkALF5ffhKHlJLmN0vBIPD/E/ezm06snytzx/DaIr3hBY3AL3jZn7fkZ7?=
 =?us-ascii?q?l990lcxREpzd9B+p1UCqsOIO7pVkDts9zYCwczMxaozOb/FNV9yoQeVHqUAq?=
 =?us-ascii?q?CHNKPSsFmI5v8gIuSXeo8VtyjyK+I/6/7tk3A5g1kdcret3ZcNb3C4BPtmcA?=
 =?us-ascii?q?2lZi/Ji8wIDW4Js0IPZcnDtHrKBS9aYn+uWIom6z07AZ7gBoDGEMTlm7GF3S?=
 =?us-ascii?q?GmDrVIaW1cTFOBC3Hlc8ODQfhfRjiVJ5pajjEcVbWnA7Qk3BWquR6yn6FrNc?=
 =?us-ascii?q?LI6yYYstTlz9Ez6OrNw0JhvQdoBtiQhjneB1p/mXkFEnpvh/Fy?=
X-IPAS-Result: =?us-ascii?q?A2ARCgAf8Z1d/wHyM5BlHAEBAQEBBwEBEQEEBAEBgXuBd?=
 =?us-ascii?q?CqBPwEyKoQjjlxTBoERJYl4kS4JAQEBAQEBAQEBNAECAQGEQAKCTyM4EwIMA?=
 =?us-ascii?q?QEBBAEBAQEBBQMBAWyFOYI6KQGCZwEBAQECASMVUQsYAgImAgJXBgEMBgIBA?=
 =?us-ascii?q?YJfP4F3BQ+vR3WBMoVNgy6BSIEMKIwOGHiBB4E4DIJfPodSglgElieXHIIsg?=
 =?us-ascii?q?i+SZAYbgjqHTo84ji2bRyKBWCsIAhgIIQ+DJ1AQFIFbFxWOKiUDMIEGAQGTX?=
 =?us-ascii?q?QEB?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 09 Oct 2019 14:41:58 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x99EfwgY018566;
        Wed, 9 Oct 2019 10:41:58 -0400
Subject: Re: [Non-DoD Source] [PATCH 2/5] dispol: add an option for printing
 the command usage
To:     Masatake YAMATO <yamato@redhat.com>, selinux@vger.kernel.org
References: <20191008064500.8651-1-yamato@redhat.com>
 <20191008064500.8651-4-yamato@redhat.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <41f518a5-7e1b-7fa5-6338-c0341f48b671@tycho.nsa.gov>
Date:   Wed, 9 Oct 2019 10:41:58 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20191008064500.8651-4-yamato@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 10/8/19 2:44 AM, Masatake YAMATO wrote:
> Signed-off-by: Masatake YAMATO <yamato@redhat.com>
> ---
>   checkpolicy/test/dispol.c | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/checkpolicy/test/dispol.c b/checkpolicy/test/dispol.c
> index 1d9556f4..37b22cf8 100644
> --- a/checkpolicy/test/dispol.c
> +++ b/checkpolicy/test/dispol.c
> @@ -39,7 +39,7 @@ static policydb_t policydb;
>   static __attribute__((__noreturn__)) void usage(const char *progname,
>   						int status)
>   {
> -	printf("usage:  %s binary_pol_file\n\n", progname);
> +	printf("usage:  %s [-h] binary_pol_file\n\n", progname);
>   	exit(status);
>   }
>   
> @@ -395,7 +395,11 @@ int main(int argc, char **argv)
>   	int state;
>   	struct policy_file pf;
>   
> -	if (argc != 2)
> +	if (argc <= 1)
> +		usage(argv[0], 1);
> +	else if (strcmp(argv[1], "-h") == 0)
> +		usage(argv[0], 0);
> +	else if (argc != 2)
>   		usage(argv[0], 1);

Use getopt(3) or getopt_long(3) please for option handling.

>   
>   	fd = open(argv[1], O_RDONLY);
> 

