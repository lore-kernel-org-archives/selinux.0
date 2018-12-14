Return-Path: <SRS0=bqQ6=OX=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89949C43387
	for <selinux@archiver.kernel.org>; Fri, 14 Dec 2018 14:32:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFD02206BA
	for <selinux@archiver.kernel.org>; Fri, 14 Dec 2018 14:32:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="UbWlCq7w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730023AbeLNOcT (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 14 Dec 2018 09:32:19 -0500
Received: from ucol19pa14.eemsg.mail.mil ([214.24.24.87]:27090 "EHLO
        ucol19pa14.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729720AbeLNOcT (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 14 Dec 2018 09:32:19 -0500
X-EEMSG-check-008: 654291672|UCOL19PA14_EEMSG_MP12.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.56,353,1539648000"; 
   d="scan'208";a="654291672"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by ucol19pa14.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 14 Dec 2018 14:32:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1544797938; x=1576333938;
  h=subject:from:to:cc:references:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=Rs/O1hht9ZjfbgO3vG/vUeWcFo1cEhNvDG/kcecwnJQ=;
  b=UbWlCq7wC36o9rQGzNBrkDaGZEQ17AllpfV9JyAcOaovVYylSyYbFGyg
   uv+FJOn5xuZFMwhe+Gn+cpnUlMuoFRws0AFyo6r0ryS/xLPT6UaLqTqow
   iDZiRleTfVNfOb79X2HD5MY1o7/ghLKE5a1odMQ++cAeJFzqiMNHvxG+C
   Eby4/qx5AZNlVx2IqObFcxqf5+b9GLYEbZfR02oDNf+KrD1ybXrME045A
   gEEGBrVhyktRv/K/QnrCxUIbDciAiLehHm0Bjs1IOr8ZC1IQwxiw2NXmy
   xV8dpDfsv4ZGC2lvdlzaW3fAz2+3KCjOi6rmIvl7obOynbeM5YEwes1uO
   g==;
X-IronPort-AV: E=Sophos;i="5.56,353,1539648000"; 
   d="scan'208";a="18717173"
IronPort-PHdr: =?us-ascii?q?9a23=3AEhv7sxP4z5kah7Y5bsQl6mtUPXoX/o7sNwtQ0K?=
 =?us-ascii?q?IMzox0I/j/rarrMEGX3/hxlliBBdydt6oUzbKO+4nbGkU4qa6bt34DdJEeHz?=
 =?us-ascii?q?Qksu4x2zIaPcieFEfgJ+TrZSFpVO5LVVti4m3peRMNQJW2aFLduGC94iAPER?=
 =?us-ascii?q?vjKwV1Ov71GonPhMiryuy+4ZLebxlLiTanfb9+MAi9oBnMuMURnYZsMLs6xA?=
 =?us-ascii?q?HTontPdeRWxGdoKkyWkh3h+Mq+/4Nt/jpJtf45+MFOTav1f6IjTbxFFzsmKH?=
 =?us-ascii?q?w65NfqtRbYUwSC4GYXX3gMnRpJBwjF6wz6Xov0vyDnuOdxxDWWMMvrRr0vRz?=
 =?us-ascii?q?+s87lkRwPpiCcfNj427mfXitBrjKlGpB6tvgFzz5LIbI2QMvdxcLndfdcHTm?=
 =?us-ascii?q?RfWMhfWTFKDoelY4cRE+YNOOBVpJT/qVQTtxuzHRSiCuPxxD9GhXH406M13O?=
 =?us-ascii?q?sjHg7a0wItBM4OvXfOodnpKKsfX+K4wa/VxjvDdfNW3jL95ZDVfBA9v/6MRb?=
 =?us-ascii?q?JwftTXyUIyCg3Fi0+fqYjhPzyL1uUGrm+W7/F9WuK0kGMntwFwrSSvxscrkI?=
 =?us-ascii?q?XJgJkVxUre+SV2x4Y1O8S1RUhmatCnCJtdrzyWOoR5T884Q2xkpTw2xqMJtJ?=
 =?us-ascii?q?KlZiQG1ZIqzAPFZfOdaYiH+BfjWf6UITd/mX1qZqqyhw238Ui80u38UdS00E?=
 =?us-ascii?q?pSoipFjNbMsncN2gTP6sedUPt9/1qh2S2V2wDP6uBLPUA0la3BJ54n3rEwjY?=
 =?us-ascii?q?YcvV7GHi/3nEX6lK6WdkM69ei08+nrf7rrq5CGO4J0lw3yKLoil8OhDegiLw?=
 =?us-ascii?q?QCR22b9v691L3n8035WrJKjvgun6nCrZ/aPt8WprK5AgBJ0oYj7AyzDzG90N?=
 =?us-ascii?q?sCh3UHI1VFeAyfg4jzJ17OOOz4Deu4g1m0izhrxvTGPrn7DprRNHTDirDhcq?=
 =?us-ascii?q?1j5E5G1Aoz1stS551RCr4bIfLzXlX9u8DfDh88Kwa02froCM1h1oMCXmKCGr?=
 =?us-ascii?q?SZP73WsV+J4OIvPuaNaZQLuDbyNfcl/eTijXwnll8He6mmw58XZGq/HvR8LE?=
 =?us-ascii?q?WTeWDsjcsZEWcWogo+S/TniVODUT5XY3ayXrgz5jQhBI26F4vDXIetj6ef0y?=
 =?us-ascii?q?ehAp1WfXtLClGKEXf0aYqEX+0AZz6VIs9kwXQ4Uu2rSoslkxrorgjwxqB7Nc?=
 =?us-ascii?q?Lb/yQZsdTo090xr/bekRA06CxcEcuQySeOQntyk2dOQCU5j45lpkko8UuOya?=
 =?us-ascii?q?h1hbRjENVX4/5YGlMhOYX00/1xC9e0XBnIONiOVgD1EZ2dHTgtQ4dpkJc1aE?=
 =?us-ascii?q?FnFoDn10qb0g=3D=3D?=
X-IPAS-Result: =?us-ascii?q?A2AGAABgvhNc/wHyM5BkGgEBAQEBAgEBAQEHAgEBAQGBU?=
 =?us-ascii?q?gQBAQEBCwGBWimBaCeDfJRcAQEBAQEBBoEICCWJFA6ONYF6OAGEQAKDBSI1C?=
 =?us-ascii?q?A0BAwEBAQEBAQIBbCiCNiQBgmEBAQEBAyMPAQVBEAkCFQMCAiYCAiE2BwwGA?=
 =?us-ascii?q?gEBgl4/gWkDCA2KGptSgS+IBQ2CHIELizMXeIEHgTgMgl+CV4UwgjUiAokeh?=
 =?us-ascii?q?yyQHy8JjiqDKgYYkVIsiQ+GCItmAzOBVisIAhgIIQ+DJ5B5IQMwAYEEAQGNN?=
 =?us-ascii?q?wEB?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 14 Dec 2018 14:32:18 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto.infosec.tycho.ncsc.mil [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id wBEEW7KV026698;
        Fri, 14 Dec 2018 09:32:07 -0500
Subject: Re: [PATCH 1/2] Makefile: fix _FORTIFY_SOURCE redefined build error
From:   Stephen Smalley <sds@tycho.nsa.gov>
To:     bill.c.roberts@gmail.com, selinux@vger.kernel.org
Cc:     William Roberts <william.c.roberts@intel.com>,
        James Carter <jwcart2@tycho.nsa.gov>
References: <1544736761-7920-1-git-send-email-william.c.roberts@intel.com>
 <a31ecb59-e330-08c8-95d3-8c9fe5a4022d@tycho.nsa.gov>
Message-ID: <877d53f9-3296-368c-979f-cf73cfc50ebb@tycho.nsa.gov>
Date:   Fri, 14 Dec 2018 09:34:39 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <a31ecb59-e330-08c8-95d3-8c9fe5a4022d@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 12/14/18 8:43 AM, Stephen Smalley wrote:
> On 12/13/18 4:32 PM, bill.c.roberts@gmail.com wrote:
>> From: William Roberts <william.c.roberts@intel.com>
>>
>> Certain builds of gcc enable _FORTIFY_SOURCE which results in the error:
>> <command-line>:0:0: warning: "_FORTIFY_SOURCE" redefined
>> <command-line>:0:0: note: this is the location of the previous definition
>>
>> Correct this by undefining it first and redefining it. Also, the previous
>> command line option was using -Wp which passing the value *AS IS* to the
>> pre-processor rather than to the compiler driver. The C pre-processor has
>> an undocumented interface subject to change per man 1 gcc. Just use the
>> -D option as is.
> 
> See commit ca07a2ad46be141dad90d885dd33a2ac31c6559a ("libselinux: avoid 
> redefining _FORTIFY_SOURCE") for why we don't specify a value for 
> _FORTIFY_SOURCE here.  Not sure about the -Wp,-D vs -D rationale.

I guess the issue here is that we want to provide sane defaults for 
building without breaking the build when others specify their own 
definitions and without weakening those definitions.  By undefining and 
re-defining, it seems like we might weaken existing builds that were 
specifying 2.

> 
>>
>> Signed-off-by: William Roberts <william.c.roberts@intel.com>
>> ---
>>   libselinux/src/Makefile   | 2 +-
>>   libselinux/utils/Makefile | 2 +-
>>   2 files changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
>> index 977b5c8cfcca..ee55bd0dbff7 100644
>> --- a/libselinux/src/Makefile
>> +++ b/libselinux/src/Makefile
>> @@ -64,7 +64,7 @@ ifeq ($(COMPILER), gcc)
>>   EXTRA_CFLAGS = -fipa-pure-const -Wlogical-op 
>> -Wpacked-bitfield-compat -Wsync-nand \
>>       -Wcoverage-mismatch -Wcpp -Wformat-contains-nul -Wnormalized=nfc 
>> -Wsuggest-attribute=const \
>>       -Wsuggest-attribute=noreturn -Wsuggest-attribute=pure 
>> -Wtrampolines -Wjump-misses-init \
>> -    -Wno-suggest-attribute=pure -Wno-suggest-attribute=const 
>> -Wp,-D_FORTIFY_SOURCE
>> +    -Wno-suggest-attribute=pure -Wno-suggest-attribute=const 
>> -U_FORTIFY_SOURCE -D_FORTIFY_SOURCE=1
>>   else
>>   EXTRA_CFLAGS = -Wunused-command-line-argument
>>   endif
>> diff --git a/libselinux/utils/Makefile b/libselinux/utils/Makefile
>> index d06ffd66893b..64ab877015c6 100644
>> --- a/libselinux/utils/Makefile
>> +++ b/libselinux/utils/Makefile
>> @@ -30,7 +30,7 @@ CFLAGS ?= -O -Wall -W -Wundef -Wformat-y2k 
>> -Wformat-security -Winit-self -Wmissi
>>             -Wformat-extra-args -Wformat-zero-length -Wformat=2 
>> -Wmultichar \
>>             -Woverflow -Wpointer-to-int-cast -Wpragmas \
>>             -Wno-missing-field-initializers -Wno-sign-compare \
>> -          -Wno-format-nonliteral 
>> -Wframe-larger-than=$(MAX_STACK_SIZE) -Wp,-D_FORTIFY_SOURCE \
>> +          -Wno-format-nonliteral 
>> -Wframe-larger-than=$(MAX_STACK_SIZE) -U_FORTIFY_SOURCE 
>> -D_FORTIFY_SOURCE=1 \
>>             -fstack-protector-all --param=ssp-buffer-size=4 
>> -fexceptions \
>>             -fasynchronous-unwind-tables -fdiagnostics-show-option 
>> -funit-at-a-time \
>>             -Werror -Wno-aggregate-return -Wno-redundant-decls \
>>
> 

