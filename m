Return-Path: <SRS0=Oqwf=4H=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A12D0C34047
	for <selinux@archiver.kernel.org>; Wed, 19 Feb 2020 14:54:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74EE1206ED
	for <selinux@archiver.kernel.org>; Wed, 19 Feb 2020 14:54:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="ZSWUUlu5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726582AbgBSOyT (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 19 Feb 2020 09:54:19 -0500
Received: from UPDC19PA23.eemsg.mail.mil ([214.24.27.198]:37259 "EHLO
        UPDC19PA23.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726569AbgBSOyS (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 19 Feb 2020 09:54:18 -0500
X-EEMSG-check-017: 60103117|UPDC19PA23_ESA_OUT05.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.70,459,1574121600"; 
   d="scan'208";a="60103117"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by UPDC19PA23.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 19 Feb 2020 14:54:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1582124056; x=1613660056;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=P24TyBnc6F8PUiM6WTWiXdHxb8Q4YKIRVlE86OgesiI=;
  b=ZSWUUlu5OtdIqUFLT2bRJJQ+eVXJ/rdonh1bHgkP+JapbANpRS+WGqeM
   wZ2gy8H63d385prIF/paS8sA9or/HVsRrPoFqBA7zRKLANuTEi0miO+16
   7Vn/a/13PSdgRdsQY/imUEDxYeWEkWqlXPwol8GU1N/XfwY5M9Cdvsy+W
   b4XxhVhhMrszBK9V4U01Uz/5s68GEOGX1El0Nd/i2aHOBGRe/k2sidOgi
   /cCH/bnY3acGbUoR7/I6G0eCa4YWJqS9dgL2d/EFPkweh3FLu/IpIgM9C
   FMT1RYjZEMS7dYor9jmqe1tTa4qtjPR4tgLG9GMaw/f6liewnsSyARIj8
   Q==;
X-IronPort-AV: E=Sophos;i="5.70,459,1574121600"; 
   d="scan'208";a="33206481"
IronPort-PHdr: =?us-ascii?q?9a23=3AmMLRjRFjkBnliBgUmIAu8p1GYnF86YWxBRYc79?=
 =?us-ascii?q?8ds5kLTJ7zr86wAkXT6L1XgUPTWs2DsrQY0raQ4/irBzxIyK3CmU5BWaQEbw?=
 =?us-ascii?q?UCh8QSkl5oK+++Imq/EsTXaTcnFt9JTl5v8iLzG0FUHMHjew+a+SXqvnYdFR?=
 =?us-ascii?q?rlKAV6OPn+FJLMgMSrzeCy/IDYbxlViDanbr5+MRq7oR/Su8UKjodvK6U8wQ?=
 =?us-ascii?q?bVr3VVfOhb2WxnKVWPkhjm+8y+5oRj8yNeu/Ig885PT6D3dLkmQLJbETorLX?=
 =?us-ascii?q?k76NXkuhffQwSP4GAcUngNnRpTHwfF9hD6UYzvvSb8q+FwxTOVPczyTbAzRD?=
 =?us-ascii?q?Si86JmQwLmhSsbKzI09nzch9duh6xHvh2uux1/w5bVYI6LMvp+Yrjdds4eSW?=
 =?us-ascii?q?ZYQ8pdSzBNDoa6YoQBFeoBOftToZf7qVUAsBCyARCgCePrxzNNgHL9wK803P?=
 =?us-ascii?q?k7EQzewQIuAdwOvnTXotv7OqgdXuK6w7XHwzjYc/Nb2y3w5JTUfh0vo/yBW6?=
 =?us-ascii?q?97f8rLyUkoEgPIlleQqIL5MDyPzOQNr3aX5PdnWOKthW8otxt+oiKzxssykY?=
 =?us-ascii?q?TJmoIUxUzE9SV+2oo1I8a4R1Rhbd6rF5tQqTiXOo1rSc0hW2FloDs2x7IJtJ?=
 =?us-ascii?q?KhfCUG1Y4rywDQZvCZaYSE/xTuX/uLLzhinnJqYre/ig638Uin1+LzSNG50E?=
 =?us-ascii?q?1PripZitnMsW0N1wDL5siHVPR9+kCh1C6T1w/J8OFEIF00lbHBJ54gxL4wmJ?=
 =?us-ascii?q?0TsV/dESDqgkn2kK+XeVkk+uiv8ejnZKnppoSAOINujwH+M6AultS+AeQ+LA?=
 =?us-ascii?q?cOQ3CW9fmz2bDs50H0QKhGguconqTWrpzWP9kXqra8AwBP04Yj7xi/Dy2h0N?=
 =?us-ascii?q?QdhXQHLlxEdw6dgIjzJ1HCPuv1Deu/gluwkDdrwOrKPrv6AprXNHTDn7Dhfa?=
 =?us-ascii?q?hl505G1AUz1cxf545TCrwZJ/LzX0jxtMfeDhAjLwO73f3qCM9j2YwDWWKAGL?=
 =?us-ascii?q?OZPLnOvl+P4+IlO/OMa5MNuDbhN/gl4ObjjWQnll8ZfKmp24YXaX+jE/R4LE?=
 =?us-ascii?q?WWf2Dsjs0CEWgUpAo+SvLliFmYXT5UfXayUPF02jZuL4SqF4rBDqWqm7qI1y?=
 =?us-ascii?q?q4VslRY2ddDFmHHF/yeomEUutKYyWXdJxPiDsBALq+QIY7yUvm4A3lwLN9Mr?=
 =?us-ascii?q?D85jwTtZWl0sN8oeLUi0dhpnRPE82B3jTVHClPlWQSSmpzhf0urA=3D=3D?=
X-IPAS-Result: =?us-ascii?q?A2BsAQC0Sk1e/wHyM5BmHAEBAQEBBwEBEQEEBAEBgWoEA?=
 =?us-ascii?q?QELAYF8gWwBMiqEFIkDiBabOgkBAQEBAQEBAQE3BAEBghOCLQKCKDcGDgIQA?=
 =?us-ascii?q?QEBBQEBAQEBBQMBAWyFQ4I7KQGDAgEFIwQRQRALCQUKAgImAgJXBg0GAgEBg?=
 =?us-ascii?q?mM/gnytdX8zhUqDbIE+gQ4qAY19QIE4D4JdPodbgl4EgT8BlhdGl3QGgj+WW?=
 =?us-ascii?q?gYcmystrBcjgVgrCkGBaIFOUBgNjlWOLCMDMI8TAQE?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 19 Feb 2020 14:54:14 +0000
Received: from moss-lions.infosec.tycho.ncsc.mil (moss-lions [192.168.25.4])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id 01JErBY4175064;
        Wed, 19 Feb 2020 09:53:13 -0500
Subject: Re: [Non-DoD Source] Re: [PATCH] libsepol: Use ebitmap_length() to
 check for an empty ebitmap
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>
References: <20200218203911.30502-1-jwcart2@tycho.nsa.gov>
 <CAFqZXNth6mpsSJ1--czyyfSXCbHTD26MzR+u3UhF5Qn8meHKLg@mail.gmail.com>
From:   jwcart2 <jwcart2@tycho.nsa.gov>
Message-ID: <3f4796be-3dd1-1f4f-fbb9-93f358f9ba33@tycho.nsa.gov>
Date:   Wed, 19 Feb 2020 09:55:38 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAFqZXNth6mpsSJ1--czyyfSXCbHTD26MzR+u3UhF5Qn8meHKLg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 2/19/20 3:25 AM, Ondrej Mosnacek wrote:
> On Tue, Feb 18, 2020 at 9:45 PM James Carter <jwcart2@tycho.nsa.gov> wrote:
>> When checking whether or not an ebitmap has any bits set, use
>> ebitmap_length() instead of ebitmap_cardinality().
>>
>> There is no need to find out how many bits are set, if all that is
>> needed is to determine if any bits are set at all.
>>
>> Signed-off-by: James Carter <jwcart2@tycho.nsa.gov>
>> ---
>>   libsepol/src/kernel_to_cil.c  | 10 +++++-----
>>   libsepol/src/kernel_to_conf.c |  8 ++++----
>>   libsepol/src/module_to_cil.c  | 16 ++++++++--------
>>   3 files changed, 17 insertions(+), 17 deletions(-)
> 
> Thanks, this looks good! Although I'm thinking if we shouldn't add a
> specific function for this, e.g.:
> 
> static inline bool ebitmap_is_empty(ebitmap_t *e)
> {
>          return ebitmap_length(e) == 0;
> }
> 
> ...because ebitmap_length() is kind of an implementation detail and it
> is easy to confuse ebitmap_length() and ebitmap_cardinality(). Note
> there are already some existing callers of ebitmap_length() that would
> also need converting to ebitmap_is_empty() in that case.
> 
> <diff snipped>
> 

I think ebitmap_is_empty() is a good idea, but I think a macro will work fine.

#define ebitmap_is_empty(e) (((e)->highbit) == 0)

Jim

-- 
James Carter <jwcart2@tycho.nsa.gov>
National Security Agency
