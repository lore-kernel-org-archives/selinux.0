Return-Path: <SRS0=UzQU=QG=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 236E0C282D7
	for <selinux@archiver.kernel.org>; Wed, 30 Jan 2019 21:35:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF8C82184D
	for <selinux@archiver.kernel.org>; Wed, 30 Jan 2019 21:35:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="ZF6cDgfz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730993AbfA3Vfc (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 30 Jan 2019 16:35:32 -0500
Received: from ucol19pa11.eemsg.mail.mil ([214.24.24.84]:1684 "EHLO
        UCOL19PA11.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730971AbfA3Vfc (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 30 Jan 2019 16:35:32 -0500
X-EEMSG-check-017: 638826064|UCOL19PA11_EEMSG_MP9.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.56,542,1539648000"; 
   d="scan'208";a="638826064"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by UCOL19PA11.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 30 Jan 2019 21:35:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1548884129; x=1580420129;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=DvRFKn+PWHAdUXcQKcLBf8DKBsvKhkPzNEhKH1xhQdE=;
  b=ZF6cDgfzuPdTwGItSy1z7ymxMO6t4HeD3YPMWXvy1g2NzsmWMsgKZmDC
   ZBbyWVUvVPdRZpoazDcEhNEqjshkFb1TLhxvO5z5IM97G7NLKJwTisHcK
   K7+BZrSNVKbNS3qxWI2x44OfETddOEWl8ytC/KApf6tRd7ppcivwByYJ5
   DbgPPfp/WorNSeVF8OnMSCvNX/0+44UKM3qc9Ug/qz2JKuMWKrVK+6q0y
   66tksCFiKkOLp/aFtFMWSlX7TQXwev9eFCPQE3ZmxGQM4BZvkQMmlGPbh
   G5aUoPPhaRi3hYK1Y7WRTplRDoc/gf8ix4cZHXWU4Gblg0bn1kQIZSeUu
   Q==;
X-IronPort-AV: E=Sophos;i="5.56,542,1539648000"; 
   d="scan'208";a="20038341"
IronPort-PHdr: =?us-ascii?q?9a23=3AA7Kd5x/Gcys8h/9uRHKM819IXTAuvvDOBiVQ1K?=
 =?us-ascii?q?B30O8cTK2v8tzYMVDF4r011RmVBdWds6oMotGVmpioYXYH75eFvSJKW713fD?=
 =?us-ascii?q?hBt/8rmRc9CtWOE0zxIa2iRSU7GMNfSA0tpCnjYgBaF8nkelLdvGC54yIMFR?=
 =?us-ascii?q?XjLwp1Ifn+FpLPg8it2O2+557ebx9UiDahfLh/MAi4oQLNu8cMnIBsMLwxyh?=
 =?us-ascii?q?zHontJf+RZ22ZlLk+Nkhj/+8m94odt/zxftPw9+cFAV776f7kjQrxDEDsmKW?=
 =?us-ascii?q?E169b1uhTFUACC+2ETUmQSkhpPHgjF8BT3VYr/vyfmquZw3jSRMsPsTbAwRD?=
 =?us-ascii?q?+s8aFlRhH1gysDLjI17n3bhsl2galGohyuugZ/zpbJbo+LOvpwfqDTc90USm?=
 =?us-ascii?q?VOXMleSyNPD5igb4YMFecNIfpUoof/qlYIsBCwBROsBOTqyjJQm3H2wbM10/?=
 =?us-ascii?q?whEQ7Y2gwrAs8AsHHOo9XxMKcdT+C0x7TPwDXYcvxWwizw6JTIcx89ofGMWq?=
 =?us-ascii?q?h8cczKyUY1DQ/FgVKQqZL8Mj6Ty+8DsHCb4vJ9We+ghGMrsQF8riW1yssyhY?=
 =?us-ascii?q?TFmJgZxk3C+C5k2og6P8e4R1R+YdO8FZtQsDyVOJVuT8M5RmFopD46yrobuZ?=
 =?us-ascii?q?6nZCQKyIooxxrYa/Gfb4iH+AjjVOeMITdjnn5lZLK+iAqy8Uin0OH8UNW70E?=
 =?us-ascii?q?1WoSZfl9nMt3QN2wTS6siBVPR94l+s1SuA2g3c8O1JIV04mbDFJ5Mu3LI8jI?=
 =?us-ascii?q?cfvVzGHiDsmUX2iKGWdl8j+uit8+nneajppoSHOo9oigDxLqQumsulDeQ+KQ?=
 =?us-ascii?q?gBRXKX+eu71L395UH5WqlFjuUqkqnFt5DXPd4UprSnDA9Mz4Yj6g6/ACmg0N?=
 =?us-ascii?q?QfhnQHI1dFdwiGj4jtIV3BPPf4DfKniVS2jDhr3+zGPqHmApjVNXjMjrPhfb?=
 =?us-ascii?q?d7605Bxws+1s5f551KBbEbOv7zWVH+tMbeDhAnNwy42eHnCM9y1tBWZWXaI6?=
 =?us-ascii?q?afeJvTtVSI6/hnd+CWaZYIuS7wLf8N6PvnjHt/klgYK+3hxpYTaXalDtx4LE?=
 =?us-ascii?q?iDJ3nhmNEMFSENpAVtYvbtjQi5TTNLZ3u0F5k57zU/BZPuWZzPXaixkbeB22?=
 =?us-ascii?q?G9BZQQaWdYXAPfWUz0fpmJDq9fIBmZJdVsx3leDbU=3D?=
X-IPAS-Result: =?us-ascii?q?A2AZAwDHF1Jc/wHyM5BjHAEBAQQBAQcEAQGBZYFbKYE3M?=
 =?us-ascii?q?4QqlA1MAQEBAQEBBoEILYk0kFQ4AYRAAoMHIjgSAQMBAQEBAQECAWwogjopg?=
 =?us-ascii?q?mgBBSMPAQVRCw4KAgImAgJXBgEMCAEBgl8/gXUNrFmBL4VDhHOBC4s1F3iBB?=
 =?us-ascii?q?4E4gmuICoJXAolbh0lWkF4JkiwGGJIzihmTJiGBVisIAhgIIQ+DKIImF448I?=
 =?us-ascii?q?QOBNQEBjngBAQ?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 30 Jan 2019 21:35:28 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto.infosec.tycho.ncsc.mil [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x0ULZRYd021567;
        Wed, 30 Jan 2019 16:35:28 -0500
Subject: Re: runcon in enforcing mode
To:     Ian Pilcher <arequipeno@gmail.com>, selinux@vger.kernel.org
References: <cc6dec3a-74e0-cf79-c46a-9377b83ccceb@gmail.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <9034023e-74af-8d08-edbf-8cd48b433075@tycho.nsa.gov>
Date:   Wed, 30 Jan 2019 16:38:21 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <cc6dec3a-74e0-cf79-c46a-9377b83ccceb@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 1/30/19 4:21 PM, Ian Pilcher wrote:
> Does $SUBJECT ever work?
> 
> I am trying to figure out why a script is failing when run by
> certmonger (system_u:system_r:certmonger_t:s0), but attempting to run
> any executable is giving me a denial.
> 
> $ sudo runcon system_u:system_r:certmonger_t:s0 /bin/true
> runcon: ‘/bin/true’: Permission denied
> 
> type=AVC msg=audit(1548883146.502:300): avc:  denied  { entrypoint } for 
>   pid=12697 comm="runcon" path="/usr/bin/true" dev="dm-3" ino=2190 
> scontext=system_u:system_r:certmonger_t:s0 
> tcontext=system_u:object_r:bin_t:s0 tclass=file permissive=0
> 
> Am I doing something wrong?

A key aspect of type enforcement is ensuring that a given domain can 
only be entered via an approved executable and can only execute 
authorized code.  Hence, the entrypoint check.  This means that if you 
want to experiment with running some other program in a domain, you must 
do one of the following:

1) Label the file in question with the authorized type, e.g.
cp /bin/true .
chcon -t certmonger_exec_t true
runcon system_u:system_r:certmonger_t:s0 ./true

2) Create and insert a local policy module allowing entrypoint to the 
type of the file,

-or-

3) Make the domain permissive or set the global enforcing mode to 
permissive.

You may also encounter other denials related to the transition since 
normally certmonger wouldn't be started this way.

