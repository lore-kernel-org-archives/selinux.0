Return-Path: <SRS0=Oqwf=4H=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47CBCC34053
	for <selinux@archiver.kernel.org>; Wed, 19 Feb 2020 14:59:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DDAB24670
	for <selinux@archiver.kernel.org>; Wed, 19 Feb 2020 14:59:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="JcTFgDUN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726645AbgBSO7r (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 19 Feb 2020 09:59:47 -0500
Received: from USAT19PA24.eemsg.mail.mil ([214.24.22.198]:57143 "EHLO
        USAT19PA24.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726663AbgBSO7q (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 19 Feb 2020 09:59:46 -0500
X-EEMSG-check-017: 79253157|USAT19PA24_ESA_OUT05.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.70,459,1574121600"; 
   d="scan'208";a="79253157"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by USAT19PA24.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 19 Feb 2020 14:59:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1582124384; x=1613660384;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=r8ioO9Nk69gIgQFITyayZPYCwYDl15ZsUojeqmEBUSg=;
  b=JcTFgDUNvpip0X/uUQfAf93NqaqeBahgFeIQHcmAke/JL6lit+w1t6xZ
   csR69W8nqXLQAqtM22dQ8/wed73EnIwNH0FW7kAz6pUNpTyKTmBM38Ye3
   u8rNP2DO8h95VTWiWM/jXqKogv0fFIhyQc0jR+XR2eyTqf9DeFWwH5Ier
   UHeTENlxt32TwLE2p02BmAc3FT3b7Kz8/1Tv3NZeUgFgvCoK7Xcc1af/u
   Lix32QdeIENoE5QcEalahe8VNgQvYBpkeQtws22QM/lzU3hCRM5oW+XZs
   Z5UXUGaj4olGPeXhzvmP8huBjGF/VHLe80dcYPKGRLcR1hA0MGze03OpD
   g==;
X-IronPort-AV: E=Sophos;i="5.70,459,1574121600"; 
   d="scan'208";a="33206759"
IronPort-PHdr: =?us-ascii?q?9a23=3AFCucRRXjjxBZILXhsMGTZPgzzuDV8LGtZVwlr6?=
 =?us-ascii?q?E/grcLSJyIuqrYbBWHt8tkgFKBZ4jH8fUM07OQ7/m8HzxYqsnZ+Fk5M7VyFD?=
 =?us-ascii?q?Y9wf0MmAIhBMPXQWbaF9XNKxIAIcJZSVV+9Gu6O0UGUOz3ZlnVv2HgpWVKQk?=
 =?us-ascii?q?a3OgV6PPn6FZDPhMqrye+y54fTYwJVjzahfL9+Nhq7oRjeu8UMgoZuNqk9xx?=
 =?us-ascii?q?nVrnBVZ+lY2GRkKE6ckBr7+sq+5oNo/T5Ku/Im+c5AUKH6cLo9QLdFEjkoMH?=
 =?us-ascii?q?076dPyuxXbQgSB+nUTUmMNkhpVGAfF9w31Xo3wsiThqOVw3jSRMNDsQrA1XT?=
 =?us-ascii?q?Si6LprSAPthSwaOTM17H3bh8pth61VuhKhowF0zZDSbo+bKfFyerrRcNMeSG?=
 =?us-ascii?q?ZEWMtaSi5PDZ6mb4YXEuQPI+hYoYn+qVUAoxSxCgujC//gxDJTmn/73rc33/?=
 =?us-ascii?q?g9HQzI3gEtGc8FvnTOrNXyMacfSeK1zafUwjrZdfNWxSnx45XPfxAjr/CDQa?=
 =?us-ascii?q?h/cdDNyUUxDA7FklWRppDlPzOSzOgNtXOb4PB6WeKgjG4ntRh8rz6yzckvko?=
 =?us-ascii?q?nEnp8Zx1/L+CljwIs5OMe0RFB0bNK6CpdcqieXPJZsTMw4WWFnoiM6x6UDuZ?=
 =?us-ascii?q?68YScF1owqxwXaa/yba4iI5Q/jVPqJLTd4mn1lfLW/ig6u8Ue60O38V9S00E?=
 =?us-ascii?q?1QoipElNnMuHcN1wfN5cebUPd94keg1iqP1wDU8O1EJ1w7lbHHJJI7x74wl5?=
 =?us-ascii?q?4TvVzCHi/whkr2kLebelgr9+Wn8ejqYqjqqoWCO4J7lA3yKLkiltS6AesiMw?=
 =?us-ascii?q?gOW2ab+f671L3m5UD5QrtLgeEsnanDrJDWO98WprK5AgBJ0oYj7AyzDzG90N?=
 =?us-ascii?q?sCh3UHI1VFeAyfg4jzJ17OOOz4Deu4g1m0izdk2fTGPrznApXQIXnOi6nhfb?=
 =?us-ascii?q?lj5E5G0gYzzs5Q54hSCr4fJPL/QEjxtMbXDkxxDwvh+PrqENVw0MslXGuLBq?=
 =?us-ascii?q?KIePfJvUSg+vMkI+7KYpQc/jn6Na5hr+XjiX4/hE81Y6akx90UZWq+E/AgJF?=
 =?us-ascii?q?+WMlT2hdJUE3gBtxAiFqS+ikKJWCRPPV6uTqk84Xc9E4vgAoDdENP+yIed1T?=
 =?us-ascii?q?u2S8UFLltNDUqBRDK1Jog=3D?=
X-IPAS-Result: =?us-ascii?q?A2DQAAAZTE1e/wHyM5BmHAEBAQEBBwEBEQEEBAEBgWkFA?=
 =?us-ascii?q?QELAYF8gWwBMhYUhBSJA4gVmT+BewkBAQEBAQEBAQE3BAEBghOCLQKCKDYHD?=
 =?us-ascii?q?gIQAQEBBQEBAQEBBQMBAWyFQ4I7KYMDAQUjBAsBBVEJAgkFCgICJgICVwYBD?=
 =?us-ascii?q?AYCAQGCYz8rAYJQkXebeX8zhUqDboE+gQ4qAY19QIE4D4JdPodbgl4EgT8Bl?=
 =?us-ascii?q?l2XdAaCP5ZaBhybKy2OQp1GByuBWCsKQYFogU5QGA2dASMDMI8TAQE?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 19 Feb 2020 14:59:43 +0000
Received: from moss-lions.infosec.tycho.ncsc.mil (moss-lions [192.168.25.4])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id 01JEwgD5176484;
        Wed, 19 Feb 2020 09:58:42 -0500
Subject: Re: [PATCH] libsepol: Use ebitmap_length() to check for an empty
 ebitmap
To:     Stephen Smalley <sds@tycho.nsa.gov>, selinux@vger.kernel.org
References: <20200218203911.30502-1-jwcart2@tycho.nsa.gov>
 <1193c757-7b16-a8fc-5ae8-4e722fb56bb3@tycho.nsa.gov>
From:   jwcart2 <jwcart2@tycho.nsa.gov>
Message-ID: <f8e0ab9e-140a-517f-21f0-bdb459dc5a0e@tycho.nsa.gov>
Date:   Wed, 19 Feb 2020 10:01:09 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <1193c757-7b16-a8fc-5ae8-4e722fb56bb3@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 2/19/20 8:30 AM, Stephen Smalley wrote:
> On 2/18/20 3:39 PM, James Carter wrote:
>> When checking whether or not an ebitmap has any bits set, use
>> ebitmap_length() instead of ebitmap_cardinality().
>>
>> There is no need to find out how many bits are set, if all that is
>> needed is to determine if any bits are set at all.
>>
>> Signed-off-by: James Carter <jwcart2@tycho.nsa.gov>
>> ---
> 
>> diff --git a/libsepol/src/module_to_cil.c b/libsepol/src/module_to_cil.c
>> index e20c3d44..b1cbef08 100644
>> --- a/libsepol/src/module_to_cil.c
>> +++ b/libsepol/src/module_to_cil.c
>> @@ -2149,7 +2149,7 @@ static int role_to_cil(int indent, struct policydb *pdb, 
>> struct avrule_block *UN
>>               }
>>           }
>> -        if (ebitmap_cardinality(&role->dominates) > 1) {
>> +        if (ebitmap_length(&role->dominates) > 1) {
>>               log_err("Warning: role 'dominance' statement unsupported in CIL. 
>> Dropping from output.");
>>           }
> 
> Noticed that this test differs from the rest, checking > 1 rather than just 
> comparing with 0.  Not sure if it matters but ebitmap_length() will be > 1 if 
> role->dominates is non-empty even if it only has one bit set. So maybe this one 
> is supposed to really be ebitmap_cardinality()?
> 

You are right. I misread this one.

Jim


-- 
James Carter <jwcart2@tycho.nsa.gov>
National Security Agency
