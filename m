Return-Path: <SRS0=yIcu=YI=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D70F3C10F14
	for <selinux@archiver.kernel.org>; Tue, 15 Oct 2019 14:17:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA80E20650
	for <selinux@archiver.kernel.org>; Tue, 15 Oct 2019 14:17:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="MSIxXwPS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732490AbfJOORu (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 15 Oct 2019 10:17:50 -0400
Received: from UCOL19PA37.eemsg.mail.mil ([214.24.24.197]:16646 "EHLO
        UCOL19PA37.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731553AbfJOORu (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 15 Oct 2019 10:17:50 -0400
X-EEMSG-check-017: 35694204|UCOL19PA37_ESA_OUT04.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.67,300,1566864000"; 
   d="scan'208";a="35694204"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by UCOL19PA37.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 15 Oct 2019 14:17:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1571149062; x=1602685062;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=ldX5kGJ6CVADJqn/Wtl4jASwh5uTpf5ShHyjCJZxUrk=;
  b=MSIxXwPSiNnACf2A/BOOV43/s+eFAfPDiVW4i1Pzw4ny3HpNCoFiM6Ue
   Grgp7qw41NkO8F0sx4o12XidWVlFdt9GA2GMFGV9pd7lovc/AYxPy5diA
   j1naEaQxC7UuXYr71gmFQUxY3sBbUSVlfKRWe1HMrR4Zrkp1RrjVgLoU0
   GqoXqPovs74BkpRgoCNWgUhvf3nPlvKjxiGmvjNdE4Fqh6gYO+xZgVLRq
   dT6om8popUsbODSg2zKruP/+vLDzHzBa4sJFg6TR79ZfgsLmQgFs7nZ9u
   CiZe9hoX/z0Cynk/Ezb72PxUbwMX8256QHTBeZL5+SUSv1HFeoNTs8erd
   g==;
X-IronPort-AV: E=Sophos;i="5.67,300,1566864000"; 
   d="scan'208";a="34163713"
IronPort-PHdr: =?us-ascii?q?9a23=3A33dVHR9GWzepMP9uRHKM819IXTAuvvDOBiVQ1K?=
 =?us-ascii?q?B21u0cTK2v8tzYMVDF4r011RmVBN6dtKkP1LKempujcFRI2YyGvnEGfc4EfD?=
 =?us-ascii?q?4+ouJSoTYdBtWYA1bwNv/gYn9yNs1DUFh44yPzahANS47xaFLIv3K98yMZFA?=
 =?us-ascii?q?nhOgppPOT1HZPZg9iq2+yo9JDffgtFiCC/bL58Ixm7rxndvdQKjIV/Lao81g?=
 =?us-ascii?q?HHqWZSdeRMwmNoK1OTnxLi6cq14ZVu7Sdete8/+sBZSan1cLg2QrJeDDQ9Lm?=
 =?us-ascii?q?A6/9brugXZTQuO/XQTTGMbmQdVDgff7RH6WpDxsjbmtud4xSKXM9H6QawyVD?=
 =?us-ascii?q?+/9KpgVgPmhzkbOD446GHXi9J/jKRHoBK6uhdzx5fYbJyJOPZie6/Qe90VRX?=
 =?us-ascii?q?BFXs1MSSJPBI2yZJYLA+YYI+pVq4zxql0TphW8GAasHvvixCJWiH/43aM00O?=
 =?us-ascii?q?ovHg/J0wMiA90Av2/ZrMn3OaoITey50KfFwDfFYvhL2Tn98o/IchU5rP+RQb?=
 =?us-ascii?q?J/b9LRyUkxGAPDk16etInlMCmR1uQJrWea7/drWOW0i2E6sAF8uSSvx8cwhY?=
 =?us-ascii?q?nJgYIZ0FbE9T5jz4ovKt24T1B7bMeiHZBNuS+aMI52TdkjQ2FuoCs6xbwGuY?=
 =?us-ascii?q?K7fCgX05sr3QLQa/uCc4WO/xntV/6RLC9liH9qd7+znRa//VW6xuHiWcS4zk?=
 =?us-ascii?q?xGojdDn9LRrH4CzQbT5dKCSvZl+0eh3iuA2B7L5+FfJEA0ibLbK5k8wr4sjp?=
 =?us-ascii?q?YTsVrMHivxmEjukK+ZbF8k+um16+T8eLnmup+dOJN0igH5KKgunNCwAf8kPQ?=
 =?us-ascii?q?QUWmib+OC82KXi/U3/XrpKkuU7nrTWvZ3VP8gWprO1DxVL3oss9RqzFSqq3M?=
 =?us-ascii?q?wdnXYdLVJFfByHj5LuO1HLOP34Fuqwg0+3nTd3x/HJIr3hApLXInjFi7fuZ6?=
 =?us-ascii?q?xx60FbyAot1dxf/Y5bCqkdIPLvXU/8rNrYDh4lPAyzx+boEs592pkfWWKIBa?=
 =?us-ascii?q?+ZK7jSvESN5u8gLOiAfogVuCzyK/I9/f7hkWc5mUMBfamuxZYXc263HvBnI0?=
 =?us-ascii?q?WffHrtjcwMEXkFvgUgVuzmkl6CXiBJZ3a0Qa084is3CIW8DYfMXoqtmqCO3D?=
 =?us-ascii?q?+nHp1KYWBLEkiMEXPyeIWZR/cMcjmdLdV6nzweS7euVo8h2guytAPg17VnKe?=
 =?us-ascii?q?/UqWUkssfF1dNy4+TI3TA18idvR5Cb0mqKS2hv2GIPQCQt9KUjsQp60FjVgo?=
 =?us-ascii?q?ZihPkNLsBe//NEVE8BMJfYy+FrQ4TpVhnpYsaCSFHgRM6vRz42UIRikJc1f0?=
 =?us-ascii?q?9hFoD63Vj41C2wDupQzubaCQ=3D=3D?=
X-IPAS-Result: =?us-ascii?q?A2CLAACc1KVd/wHyM5BmHAEBAQEBBwEBEQEEBAEBgWgGA?=
 =?us-ascii?q?QELAYFzLGxTATIqhCWPLgEBAQEBAQaBNol4jzSBewkBAQEBAQEBAQErCQECA?=
 =?us-ascii?q?QGDe0UCgm4kNQgOAgwBAQEEAQEBAQEFAwEBbIUtDII6KQGCaAEFIxVBEAsYA?=
 =?us-ascii?q?gImAgJXBg0GAgEBgl8/AYJSJQ+vN4EyhU2DMYFIgQwoAYwNGHiBB4E4gms+g?=
 =?us-ascii?q?mECgSqDRYJeBJYrlx+CLIIxhFmOCwYbgyyWFZZUkxQBNoFYKwgCGAghD4MnC?=
 =?us-ascii?q?UcQFIVChWWFCiUDMIEGAQGNbYJUAQE?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 15 Oct 2019 14:17:41 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x9FEHes2017295;
        Tue, 15 Oct 2019 10:17:40 -0400
Subject: Re: [PATCH v2] python/sepolicy: call segenxml.py with python3
To:     Nicolas Iooss <nicolas.iooss@m4x.org>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Petr Lautrbach <plautrba@redhat.com>
References: <20191009142024.9278-1-sds@tycho.nsa.gov>
 <CAJfZ7=mQ1MwfWC-R+QM45runiOunGQqTq-cjA8LZptN1n8g-2w@mail.gmail.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <0fddfce9-6f24-d793-f6b6-fc665ebdca15@tycho.nsa.gov>
Date:   Tue, 15 Oct 2019 10:17:40 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <CAJfZ7=mQ1MwfWC-R+QM45runiOunGQqTq-cjA8LZptN1n8g-2w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 10/10/19 3:48 PM, Nicolas Iooss wrote:
> On Wed, Oct 9, 2019 at 4:20 PM Stephen Smalley <sds@tycho.nsa.gov> wrote:
>>
>> Fixes: https://github.com/SELinuxProject/selinux/issues/61
>> Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
>> ---
>> v2 wraps basedir + filename in parentheses as per Nicolas Iooss' suggestion.
> 
> Acked-by: Nicolas Iooss <nicolas.iooss@m4x.org>

Thanks, applied.

> 
>>
>>   python/sepolicy/sepolicy/interface.py | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/python/sepolicy/sepolicy/interface.py b/python/sepolicy/sepolicy/interface.py
>> index 583091ae18aa..187419fa7822 100644
>> --- a/python/sepolicy/sepolicy/interface.py
>> +++ b/python/sepolicy/sepolicy/interface.py
>> @@ -196,7 +196,7 @@ def get_xml_file(if_file):
>>           from subprocess import getstatusoutput
>>       basedir = os.path.dirname(if_file) + "/"
>>       filename = os.path.basename(if_file).split(".")[0]
>> -    rc, output = getstatusoutput("python /usr/share/selinux/devel/include/support/segenxml.py -w -m %s" % basedir + filename)
>> +    rc, output = getstatusoutput("/usr/bin/python3 /usr/share/selinux/devel/include/support/segenxml.py -w -m %s" % (basedir + filename))
>>       if rc != 0:
>>           sys.stderr.write("\n Could not proceed selected interface file.\n")
>>           sys.stderr.write("\n%s" % output)
>> --
>> 2.21.0
>>
> 

