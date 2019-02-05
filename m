Return-Path: <SRS0=HD60=QM=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 176B3C282CC
	for <selinux@archiver.kernel.org>; Tue,  5 Feb 2019 13:38:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4C4920844
	for <selinux@archiver.kernel.org>; Tue,  5 Feb 2019 13:38:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="SbY30j4Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729343AbfBENi0 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 5 Feb 2019 08:38:26 -0500
Received: from ucol19pa14.eemsg.mail.mil ([214.24.24.87]:60680 "EHLO
        ucol19pa14.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726731AbfBENi0 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 5 Feb 2019 08:38:26 -0500
X-EEMSG-check-017: 670002952|UCOL19PA14_EEMSG_MP12.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.56,564,1539648000"; 
   d="scan'208";a="670002952"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by ucol19pa14.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 05 Feb 2019 13:37:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1549373864; x=1580909864;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=hc12iFI4ZWVQ6ytiRdcE2lssFZ6gQDbXqTfa9LyAQ6Q=;
  b=SbY30j4ZaS395X9qw0lQ4YtTegndEqLshLIqC97zDsnEHObiGfG0XLmc
   GF1kTfa7b0HPke45sLoE7z7U5vjiEdV41QbVNSJ/n6+ADEhZtTGp8aNub
   wmplLEKdDpv+ClbMWhd2GLf5yS1j8cWDrILWZPJgqxWL2fZwhHULCanxH
   rz/qtMl1QvxCstXP3pYXQ2YgBq+rarcCComRO+T0fZok3sYfGeXQ4zRLG
   IDsHwvZdvXTU4M1Nc40Qq5gnhTQSFo+/7IzQSANGPkFZqr1lcMB9V9lXh
   qxDXixTgGgFln2EUbQ7repz2TbrdIN/xPSisaPgIunIqvdjSuHGNkgNn8
   w==;
X-IronPort-AV: E=Sophos;i="5.56,564,1539648000"; 
   d="scan'208";a="23503786"
IronPort-PHdr: =?us-ascii?q?9a23=3AbTMdWRE157946ADwQ0gMvJ1GYnF86YWxBRYc79?=
 =?us-ascii?q?8ds5kLTJ76p8y8bnLW6fgltlLVR4KTs6sC17KG9fi4EUU7or+5+EgYd5JNUx?=
 =?us-ascii?q?JXwe43pCcHRPC/NEvgMfTxZDY7FskRHHVs/nW8LFQHUJ2mPw6arXK99yMdFQ?=
 =?us-ascii?q?viPgRpOOv1BpTSj8Oq3Oyu5pHfeQpFiCa+bL9oMBm6sRjau9ULj4dlNqs/0A?=
 =?us-ascii?q?bCrGFSe+RRy2NoJFaTkAj568yt4pNt8Dletuw4+cJYXqr0Y6o3TbpDDDQ7KG?=
 =?us-ascii?q?81/9HktQPCTQSU+HQRVHgdnwdSDAjE6BH6WYrxsjf/u+Fg1iSWIdH6QLYpUj?=
 =?us-ascii?q?m58axlVAHnhzsGNz4h8WHYlMpwjL5AoBm8oxBz2pPYbJ2JOPZ7eK7Sc8kaRW?=
 =?us-ascii?q?5cVchPUSJPDJ63Y48WA+YfIepUqo/wrEYMoxSjHwmhHP7hxCFGhnH23qM03e?=
 =?us-ascii?q?ouHg7E0wM8ENwDq2jUodfvOasOTey4wqvFwDPeZP1Wwzf9743Ifwg8r/GQQ7?=
 =?us-ascii?q?1wacrRxlcpFwjYk1uQrJbqPzeR1usTs2mQ8u1tVfmyhG48sAxxvjiuydssio?=
 =?us-ascii?q?nOnI4VzEvE+j9jzIY6It24Vld2bNi5G5VTryGXL5Z6T8wtTm1yuCs216cKtY?=
 =?us-ascii?q?C0cSQU0pgr2hjSYOGdfYeS+BLsTuORLC99hHJiZb2wmQ6/8VOlyu3gTsm010?=
 =?us-ascii?q?tKrjZdntnMqH8N0xvT59CbSvRn5Eeh2CuP1xvJ5uFYIUE7iarbK5k7zr42ip?=
 =?us-ascii?q?UTqljMEjXzmEX3iK+abkQk+u625OT7erjqu5CROoBuhgz+L6gigNKzDOsmPg?=
 =?us-ascii?q?QUQmSX4eG826fi/U39TrVKlPo2kqzBvZDBOMsbvbW0AxNV04k/6xa/CC2q0N?=
 =?us-ascii?q?IDnXYdNl5FdxWHj5bxN1HUPP/4Feu/g0irkDpz2v/JJLvhDo/RIXfZirfhZa?=
 =?us-ascii?q?hy60hAyAUt19BS/JVUCqsbL/3vXk/+qsbUAQM+Mwyx2+znEsly1psCWWKTBa?=
 =?us-ascii?q?+UKL3SsV6S5uIoOOSNZZEauDD8K/g7/fLuiX45mVkAfaimx5cXb2q4Hvt8L0?=
 =?us-ascii?q?WEYnrmms0BHnsSvgoiUOzqj0WPUSVNaHa2XqI84Cw7CY29AIfdSYCinqaB0D?=
 =?us-ascii?q?24HpJIfGBGDE6DEXPye4WDQfcMZzqYItV9nTwcSbihV4gh2Am2tADg1rpnKv?=
 =?us-ascii?q?HZ+jUCupL+0Nh5/ujTlRY19TxuEcuRyX2CT2ZxnjBAezhj8Kl56Wd00E+O17?=
 =?us-ascii?q?R1mbQMGdVVofhASB83M4LR1cR9Edn5Xg+HddCMHhLuXNS8BhkjQ9Qw3ZkKYk?=
 =?us-ascii?q?BgC5OllB+Fwin5LaUSkumwGJEs8q/al0P0LsJ5xmeOgLItlHE6U8BPMiugna?=
 =?us-ascii?q?c5+A/NUd2a236FnrqnIPxPlBXG832OmC/X5hlV?=
X-IPAS-Result: =?us-ascii?q?A2CvAAARkVlc/wHyM5BlGgEBAQEBAgEBAQEHAgEBAQGBZ?=
 =?us-ascii?q?QKBWSmBODKEKpQPTAEBAQEBAQaBCAgliTWJTIcKOAGEQAKDEiI5BQwBAwEBA?=
 =?us-ascii?q?QEBAQIBbCiCOikBgmYBAQEBAgEjBBFBEAsYAgImAgJXBgEMCAEBgl8/gXUFC?=
 =?us-ascii?q?KtYfDOFRIRxgQuLNhd4gQeBEScMgl+BJoZkglcCkH06kUcJkjkGGZJHLYl9k?=
 =?us-ascii?q?0EggVYrCAIYCCEPgyiCJxeOPCEDgTUBAY1zAQE?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 05 Feb 2019 13:37:43 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto.infosec.tycho.ncsc.mil [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x15Dbfm0025526;
        Tue, 5 Feb 2019 08:37:43 -0500
Subject: Re: [bug report] selinux: kill selinux_sb_get_mnt_opts()
To:     Dan Carpenter <dan.carpenter@oracle.com>, viro@zeniv.linux.org.uk
Cc:     selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>
References: <20190205102006.GA6230@kadam>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <817f3005-1639-5e33-8fcf-8d43cc602a7e@tycho.nsa.gov>
Date:   Tue, 5 Feb 2019 08:37:41 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190205102006.GA6230@kadam>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 2/5/19 5:20 AM, Dan Carpenter wrote:
> Hello Al Viro,
> 
> The patch e3489f8974e1: "selinux: kill selinux_sb_get_mnt_opts()"
> from Dec 13, 2018, leads to the following static checker warning:
> 
> 	security/selinux/hooks.c:1075 show_sid()
> 	error: we previously assumed 'context' could be null (see line 1070)
> 
> security/selinux/hooks.c
>      1061 static int show_sid(struct seq_file *m, u32 sid)
>      1062 {
>      1063 	char *context = NULL;
>      1064 	u32 len;
>      1065 	int rc;
>      1066
>      1067 	rc = security_sid_to_context(&selinux_state, sid,
>      1068 					     &context, &len);
>      1069 	if (!rc) {
>      1070 		bool has_comma = context && strchr(context, ',');
>                                           ^^^^^^^
> Can context be NULL?

No, security_sid_to_context() should only return 0 if it has set context 
to a non-NULL value.

> 
>      1071
>      1072 		seq_putc(m, '=');
>      1073 		if (has_comma)
>      1074 			seq_putc(m, '\"');
> --> 1075 		seq_escape(m, context, "\"\n\\");
>                                        ^^^^^^^
> Because if it is, then we're toasted when we pass it to seq_escape().
> 
>      1076 		if (has_comma)
>      1077 			seq_putc(m, '\"');
>      1078 	}
>      1079 	kfree(context);
>      1080 	return rc;
>      1081 }
> 
> regards,
> dan carpenter
> 

