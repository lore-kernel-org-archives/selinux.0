Return-Path: <SRS0=i/ur=NR=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 451E2C46464
	for <selinux@archiver.kernel.org>; Tue,  6 Nov 2018 19:19:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17A7C20827
	for <selinux@archiver.kernel.org>; Tue,  6 Nov 2018 19:19:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17A7C20827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.nsa.gov
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387862AbeKGEqB (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 6 Nov 2018 23:46:01 -0500
Received: from ucol19pa12.eemsg.mail.mil ([214.24.24.85]:26637 "EHLO
        ucol19pa12.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387804AbeKGEqB (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 6 Nov 2018 23:46:01 -0500
X-EEMSG-check-008: 653706668|UCOL19PA12_EEMSG_MP10.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.54,472,1534809600"; 
   d="scan'208";a="653706668"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by ucol19pa12.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 06 Nov 2018 19:19:13 +0000
X-IronPort-AV: E=Sophos;i="5.54,472,1534809600"; 
   d="scan'208";a="20344303"
IronPort-PHdr: =?us-ascii?q?9a23=3Aw2qAoBzH2L63tVbXCy+O+j09IxM/srCxBDY+r6?=
 =?us-ascii?q?Qd2usSIJqq85mqBkHD//Il1AaPAd2Eraocw8Pt8InYEVQa5piAtH1QOLdtbD?=
 =?us-ascii?q?Qizfssogo7HcSeAlf6JvO5JwYzHcBFSUM3tyrjaRsdF8nxfUDdrWOv5jAOBB?=
 =?us-ascii?q?r/KRB1JuPoEYLOksi7ze+/94HRbglSmDaxfa55IQmrownWqsQYm5ZpJLwryh?=
 =?us-ascii?q?vOrHtIeuBWyn1tKFmOgRvy5dq+8YB6/ShItP0v68BPUaPhf6QlVrNYFygpM3?=
 =?us-ascii?q?o05MLwqxbOSxaE62YGXWUXlhpIBBXF7A3/U5zsvCb2qvZx1S+HNsDtU7s6RS?=
 =?us-ascii?q?qt4LtqSB/wiScIKTg58H3MisdtiK5XuQ+tqwBjz4LRZoyaOuB+fqfAdt0EQ2?=
 =?us-ascii?q?RPUNtaWyhYDo+ic4cDCuwMNvtaoYbgvVsDtQawCxeiBO3vyTFGiHH50qI43O?=
 =?us-ascii?q?s9Hg/LxxAgEtEUvXjIsNn4OqUfXOaox6fI1zXDaPZW1C//6InGbh8uu+uMXa?=
 =?us-ascii?q?5ufcHMzkQvFQ3EgUmKpoz/IzOZyP8As3Sb7uV8VeKvjHQrqwdqoje13MsshY?=
 =?us-ascii?q?7JhpwMx13C6C53w541KMWlREN0btOoCptduzyAO4doTc4uXXtktDs8x7Ybo5?=
 =?us-ascii?q?C0ZjIKx44ixxPHbvyHdJWH7Qz7WeaKJDd4mGpleLWihxau6USgyvPzVs2z0F?=
 =?us-ascii?q?tSsipKiMPMtnEQ1xzI8MSHVvt88Vuh2TaIzQzT7P1LIVsomqbBLp4hw7owmo?=
 =?us-ascii?q?ISsUTFACD2hF37gLKZe0gr4OSl6/nrbq/4qpKTKYN4kBzyPrwrmsOlAOQ4Ng?=
 =?us-ascii?q?YOX3Kc+eS5zLDj/0P4T6lQgf0sjqnVrovXJdgbp6GlAw9V1Zwv6xCkDzi8yt?=
 =?us-ascii?q?gYkn4HLExddBKdk4fpI03OIOz/DfqnhVSskStkx/fCPrL7GZXBNHnDkLDmfb?=
 =?us-ascii?q?Zm8E5R0w8zwN9Q5p5ODbEBOv3zUFfrtNPEFh85LxC0w+H/BdVmyIweXWOPAq?=
 =?us-ascii?q?mEMKLdqlKI+O0vLPeWZIMPuzbyNeIl5/jwgn89g1MderOp3ZREIEy/S896Ll?=
 =?us-ascii?q?2ZbHykudIIFWMHr0JqV+DxoEGTWj5UIXCpVuQz4S9tTMqADIzEQom2yJ2G2z?=
 =?us-ascii?q?ygVslQZ2tBDlmXV3bvcJ6fc/JQeGSVOMA31nQfWLygTZIx/Q+huRW8yLd9KO?=
 =?us-ascii?q?fQvCoCusHNzt9wsu/Mnhgo6WY8W8aC2GiXUztcgnIDRzhw2rt250N61AHQgu?=
 =?us-ascii?q?BDn/VEGIkLtLtyWQAgOMuZlrYiBg=3D=3D?=
X-IPAS-Result: =?us-ascii?q?A2B/AACv5+Fb/wHyM5BkGgEBAQEBAgEBAQEHAgEBAQGBZ?=
 =?us-ascii?q?YFbKWlMMxQTg3aUMIFoJZkqOAGEQAKDWCI4FgEDAQEBAQEBAgFsKII2JAGCX?=
 =?us-ascii?q?wEBAQECASMECwEFRgsJAgkFCgICJgICVwYBDAYCAQGCXj8pAYFQCI1nm097M?=
 =?us-ascii?q?4U8hGqBC4ptgVdAgTgMgl+IAoJXAoEqAY5Dj0kGA4oThnkGGIFWh3wmhmyZJ?=
 =?us-ascii?q?SGBVSsKQYFogU6QeCEDMIEFAQGMbAEB?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 06 Nov 2018 19:19:10 +0000
Received: from [192.168.25.4] (moss-lions [192.168.25.4])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id wA6JJAvB004122;
        Tue, 6 Nov 2018 14:19:10 -0500
Subject: Re: [PATCH 1/1] libsepol: mark permissive types when loading a binary
 policy
To:     Stephen Smalley <sds@tycho.nsa.gov>,
        Nicolas Iooss <nicolas.iooss@m4x.org>, selinux@vger.kernel.org
References: <20181105210001.31499-1-nicolas.iooss@m4x.org>
 <e5aece95-c1b5-073c-8add-510ee908df57@tycho.nsa.gov>
From:   jwcart2 <jwcart2@tycho.nsa.gov>
Message-ID: <ac49729e-3125-9e0d-36d3-a839ce552339@tycho.nsa.gov>
Date:   Tue, 6 Nov 2018 14:19:43 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <e5aece95-c1b5-073c-8add-510ee908df57@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 11/6/18 11:22 AM, Stephen Smalley wrote:
> On 11/5/18 4:00 PM, Nicolas Iooss wrote:
>> When using checkpolicy to read a binary policy, permissive types are not
>> written in the output file. In order to reproduce this issue, a test
>> policy can be written from minimal.cil with the following commands:
>>
>>      $ cd secilc/test/
>>      $ cp minimum.cil my_policy.cil
>>      $ echo '(typepermissive TYPE)' >> my_policy.cil
>>      $ secilc my_policy.cil
>>      $ checkpolicy -bC -o /dev/stdout policy.31
>>
>>      # There is no "(typepermissive TYPE)" in checkpolicy output.
>>
>> This is because TYPE_FLAGS_PERMISSIVE is added to typdatum->flags only
>> when loading a module, which uses the permissive flag in the type
>> properties. A kernel policy defines permissive types in a dedicated
>> bitmap, which gets loaded as p->permissive_map before the types are
>> loaded. Use this bitmap to mark permissive types in the loaded policy.
>>
>> Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
> 
> Or we could directly use the permissive_map in kernel_to_cil/kernel_to_conf?  

I think that this is the more natural way to do it.
Jim

> Regardless,
> 
> Acked-by: Stephen Smalley <sds@tycho.nsa.gov>
> 
>> ---
>>   libsepol/src/policydb.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/libsepol/src/policydb.c b/libsepol/src/policydb.c
>> index 96176d805d59..f2beaf041fc7 100644
>> --- a/libsepol/src/policydb.c
>> +++ b/libsepol/src/policydb.c
>> @@ -2469,6 +2469,9 @@ static int type_read(policydb_t * p, hashtab_t h, struct 
>> policy_file *fp)
>>           if (properties & TYPEDATUM_PROPERTY_PERMISSIVE
>>               && p->policy_type != POLICY_KERN)
>>               typdatum->flags |= TYPE_FLAGS_PERMISSIVE;
>> +        if (p->policy_type == POLICY_KERN
>> +            && ebitmap_get_bit(&p->permissive_map, typdatum->s.value))
>> +            typdatum->flags |= TYPE_FLAGS_PERMISSIVE;
>>           typdatum->bounds = le32_to_cpu(buf[++pos]);
>>       } else {
>>
> 


-- 
James Carter <jwcart2@tycho.nsa.gov>
National Security Agency
