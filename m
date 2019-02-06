Return-Path: <SRS0=09KC=QN=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0DEEC169C4
	for <selinux@archiver.kernel.org>; Wed,  6 Feb 2019 14:34:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAA00217F9
	for <selinux@archiver.kernel.org>; Wed,  6 Feb 2019 14:34:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="SCSl2X4y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729735AbfBFOej (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 6 Feb 2019 09:34:39 -0500
Received: from uhil19pa10.eemsg.mail.mil ([214.24.21.83]:39502 "EHLO
        uhil19pa10.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726914AbfBFOej (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 6 Feb 2019 09:34:39 -0500
X-EEMSG-check-017: 382910146|UHIL19PA10_EEMSG_MP8.csd.disa.mil
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by uhil19pa10.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 06 Feb 2019 14:33:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1549463585; x=1580999585;
  h=subject:from:to:cc:references:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=Qa41W3K2mNaFNOvgB2kHXF1JApgSr8N6mHWUPkgySjU=;
  b=SCSl2X4yO+XeFBsxfYG1zg3pylHxdF90naIT9MZfJAr9LHq6uplkrQ6E
   CXj/vRsrbpcM9t2YtL9bIX9uqpNPLyeJ1UjnwAPq393lPDMidWdl8c3Ql
   F7m0tJ9pDLLkj+yVHGjmFetYSvaYrScjkfBb7cVyRbuhoAHMunmK5Mce3
   YJZuDYGIwa/cdXP9+aWYDMV8GAiH7mLfUZVrN/ExDP2qdMKmAkDr1AOkK
   r7PGE+ubZ7iTIS8vo30/MQMs0nmpM2QU+o236/A+AjW/7KfrVAveB1F+x
   uxFY2jiiJpwiZPKxKp8pwIojZJoevjWL4OADPmPo0RuWtbBgU3MbDn29b
   w==;
X-IronPort-AV: E=Sophos;i="5.58,340,1544486400"; 
   d="scan'208";a="23566519"
IronPort-PHdr: =?us-ascii?q?9a23=3Adl4YLBDmS9fzBBdqCSwPUyQJP3N1i/DPJgcQr6?=
 =?us-ascii?q?AfoPdwSPX+osbcNUDSrc9gkEXOFd2Cra4c26yO6+jJYi8p2d65qncMcZhBBV?=
 =?us-ascii?q?cuqP49uEgeOvODElDxN/XwbiY3T4xoXV5h+GynYwAOQJ6tL1LdrWev4jEMBx?=
 =?us-ascii?q?7xKRR6JvjvGo7Vks+7y/2+94fcbglUhzexe69+IAmrpgjNq8cahpdvJLwswR?=
 =?us-ascii?q?XTuHtIfOpWxWJsJV2Nmhv3+9m98p1+/SlOovwt78FPX7n0cKQ+VrxYES8pM3?=
 =?us-ascii?q?sp683xtBnMVhWA630BWWgLiBVIAgzF7BbnXpfttybxq+Rw1DWGMcDwULs5Qi?=
 =?us-ascii?q?qp4bt1RxD0iScHLz85/3/Risxsl6JQvRatqwViz4LIfI2ZMfxzca3HfdMeWG?=
 =?us-ascii?q?FPQMBfWSJcCY+4docDEfYNMeNeooLgpVUBsAG+CBGxCu3v1DFIiHz406M03O?=
 =?us-ascii?q?suEw7JwAMuEskSsHnXttj5KLseXO63waTO0D7Nb+lW2TD46IXQbx4hve+DXa?=
 =?us-ascii?q?pwccXPz0kkCh7LjlCKpozhOzOayOQMuHWc4up7SO2vkHUqqx1xozezxscsjZ?=
 =?us-ascii?q?PFhoQOyl/e7yl5z4E1JcOhRUN9fNWqE4NQujmHO4Z5Tc4uWWFltDsgxrEYtp?=
 =?us-ascii?q?O3YjIGxIkhyhXCcfKIaZKI7QjmVOuJJDd4g29qd6ynihap9Eig1vX8Vs6p0F?=
 =?us-ascii?q?ZWtiZFksfDtnQK1xHL9siIUOF9/ka82TaUzQzT9uFFLlw0larcMZIhxKI/lo?=
 =?us-ascii?q?EPvkjZGy/2mUH2gLeXdkUi5Oeo9/zqbqjpq5KTLYN5ihzyPr4wlsGwH+g0KB?=
 =?us-ascii?q?UCU3Ce+eum1b3j+UP5QK9Njv0ziqTZq43VJd8Aq66lAw5azoYj6xGlAzegy9?=
 =?us-ascii?q?QXh2MLLF1CeBKZl4TpIU3BIOjkDfejhFShiDlqx/HCPr3lA5XCNH3DnazvfL?=
 =?us-ascii?q?Z+9UFczgwzzdFZ55JbFrEBJ/TzVlXtu9zfCx8zKxa0zPr/CNVhyoMeXnqCAr?=
 =?us-ascii?q?SHP6PWsF+I4P8vIuaXaY8LtzbyNeIl6+TtjXAng18de7em3Z8NZHC/BPRmLF?=
 =?us-ascii?q?2TYWDwjdcZDWcKog0+QfTyiFKYTD5TY22/X7om6TEmDIKqFILDRoeqgLybwi?=
 =?us-ascii?q?i3BIFZZmdDCgPELXC9PbqFX/MNYSfaC4kpsTECU7mnRJMm01mPlS6wg+54L+?=
 =?us-ascii?q?7Q+yQdnY3g2d5z5uvciRY0szdzCpLZm3qAS2Byg3MgWTA7xuZ8rFZ7x1PF1r?=
 =?us-ascii?q?J30NJCEtkG3O9ESgc3M9bnyuV+D93jElbacsyhVEetQtLgByo4CN023YldMA?=
 =?us-ascii?q?5GB9y+g0WbjGKRCLgPmunOXcZs/w=3D=3D?=
X-IPAS-Result: =?us-ascii?q?A2BIAQCw7lpc/wHyM5BlGwEBAQEDAQEBBwMBAQGBZYFbK?=
 =?us-ascii?q?WdQATInhAOUUQEBAQEBAQaBCC2JNZBVKBABhEACgxoiOBIBAwEBAQEBAQIBb?=
 =?us-ascii?q?BwMgjopAYJnAQUjDwEFQRAJAhgCAiYCAlcGAQwGAgEBgl8/AYF0DZEjm2GBL?=
 =?us-ascii?q?4o8gQuLOBd4gQeBESeCa4RKg0CCVwKQNYEFkU4JhzeLBgYZgj6QEIosk0shg?=
 =?us-ascii?q?VYrCAIYCCEPO4JsCYtDhS8hAzCBBQEBiyaCTQEB?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 06 Feb 2019 14:33:04 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto.infosec.tycho.ncsc.mil [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x16EX19e002822;
        Wed, 6 Feb 2019 09:33:03 -0500
Subject: Re: [PATCH] selinux: Fix classmap for BPF
From:   Stephen Smalley <sds@tycho.nsa.gov>
To:     "William A. Kennington III" <william@wkennington.com>,
        selinux@vger.kernel.org
Cc:     Paul Moore <paul@paul-moore.com>
References: <20190206041747.11377-1-william@wkennington.com>
 <cebc12f0-5fb0-218c-331a-a785e2eece70@tycho.nsa.gov>
Message-ID: <3cee3c78-348f-1b10-b687-9d1ab5837716@tycho.nsa.gov>
Date:   Wed, 6 Feb 2019 09:33:01 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <cebc12f0-5fb0-218c-331a-a785e2eece70@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 2/6/19 9:04 AM, Stephen Smalley wrote:
> On 2/5/19 11:17 PM, William A. Kennington III wrote:
>> Entries in the secclass_map are expexted to be null terminated. The BPF
>> entry was added without the NULL terminating and incosistent formatting.
>> This patch cleans that up.
> 
> Thanks.  A few minor nits:
> 
> A couple of spelling errors above (expected, inconsistent).  Also, per 
> Documentation/process/submitting-patches.rst, rather than say "This 
> patch cleans that up", say "Clean that up" or similar.
> 
> Can add a:
> Fixes:  ec27c3568a34c7f ("selinux: bpf: Add selinux check for eBPF 
> syscall operations")

Although I guess there isn't really a bug here; this is just a 
consistency / style issue.  secclass_map[] is defined as:

struct security_class_mapping {
         const char *name;
         const char *perms[sizeof(u32) * 8 + 1];
};

struct security_class_mapping secclass_map[];

So even if you were to omit the terminating NULL from each permission 
list, any remaining slots in the perms array should be initialized to 
NULL automatically.  We only truly need the explicit NULL terminator to 
end the class list.

> 
>>
>> Signed-off-by: William A. Kennington III <william@wkennington.com>
>> ---
>>   security/selinux/include/classmap.h | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/security/selinux/include/classmap.h 
>> b/security/selinux/include/classmap.h
>> index bd5fe0d3204a..7ff68a5e4c58 100644
>> --- a/security/selinux/include/classmap.h
>> +++ b/security/selinux/include/classmap.h
>> @@ -239,7 +239,7 @@ struct security_class_mapping secclass_map[] = {
>>       { "infiniband_endport",
>>         { "manage_subnet", NULL } },
>>       { "bpf",
>> -      {"map_create", "map_read", "map_write", "prog_load", 
>> "prog_run"} },
>> +      { "map_create", "map_read", "map_write", "prog_load", 
>> "prog_run", NULL } },
> 
> Should likely break the line to make checkpatch.pl happy:
> 
> $ ./scripts/checkpatch.pl -g HEAD
> WARNING: line over 80 characters
> #24: FILE: security/selinux/include/classmap.h:242:
> +      { "map_create", "map_read", "map_write", "prog_load", "prog_run", 
> NULL } },
> 
> 
>>       { "xdp_socket",
>>         { COMMON_SOCK_PERMS, NULL } },
>>       { NULL }
>>
> 

