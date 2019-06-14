Return-Path: <SRS0=ZMzQ=UN=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 679EDC31E4B
	for <selinux@archiver.kernel.org>; Fri, 14 Jun 2019 13:37:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03C2020866
	for <selinux@archiver.kernel.org>; Fri, 14 Jun 2019 13:37:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="T3qaxvmS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727827AbfFNNhz (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 14 Jun 2019 09:37:55 -0400
Received: from uhil19pa11.eemsg.mail.mil ([214.24.21.84]:5838 "EHLO
        uhil19pa11.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727808AbfFNNhz (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 14 Jun 2019 09:37:55 -0400
X-EEMSG-check-017: 420042986|UHIL19PA11_EEMSG_MP9.csd.disa.mil
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by uhil19pa11.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 14 Jun 2019 13:37:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1560519472; x=1592055472;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=wBC1vEhFyqSoR5X7E7rdQsQ9wAjtSTVWzGPrKWTWGGQ=;
  b=T3qaxvmSX6Tz/nlSvODg9BysA73Nr/14vJ6PBQhop13QI3IMX8bMCJon
   pjg7gvVUjosQY74K1t7+TudjLZb+EDWyN98W6jA07Jr+WUjZL4bRjfmOA
   9WQHz9kmA+IxeDc4XyWdzKGr09KhhJZOrpXpfm/74yp/8Jrb3cquR1g1q
   h3yHZy2nPzUGUVt8STdEuypAZTB+E17sx/HR2DIbAl+e+OsXuoExXrz4/
   xRmwePtpbHjjB+WxGVpRqNJu6zajqQxe4ZjvR0JO4ojdSLuF7r/Bl/+dZ
   B/2mg1H25+Xj6M6cJPoMMZy5WNhKCqSZk3z8n9HrFcVQmZ6oKV3slIdKW
   w==;
X-IronPort-AV: E=Sophos;i="5.63,373,1557187200"; 
   d="scan'208";a="28977698"
IronPort-PHdr: =?us-ascii?q?9a23=3Apij8kx8K+jta3v9uRHKM819IXTAuvvDOBiVQ1K?=
 =?us-ascii?q?B20+gcTK2v8tzYMVDF4r011RmVBNydsqwdwLSK+4nbGkU4qa6bt34DdJEeHz?=
 =?us-ascii?q?Qksu4x2zIaPcieFEfgJ+TrZSFpVO5LVVti4m3peRMNQJW2aFLduGC94iAPER?=
 =?us-ascii?q?vjKwV1Ov71GonPhMiryuy+4ZLebxhViDanfL9/LQi6oQrQu8QZnIBvNrs/xh?=
 =?us-ascii?q?zVr3VSZu9Y33loJVWdnxb94se/4ptu+DlOtvwi6sBNT7z0c7w3QrJEAjsmNX?=
 =?us-ascii?q?s15NDwuhnYUQSP/HocXX4InRdOHgPI8Qv1Xpb1siv9q+p9xCyXNtD4QLwoRT?=
 =?us-ascii?q?iv6bpgRQT2gykbKTE27GDXitRxjK1FphKhuwd/yJPQbI2MKfZyYr/RcdYcSG?=
 =?us-ascii?q?VPRMZRUzFKDJ26YYUBEuENOf9Uoof5qlcLqxa1GAuiC/71yjJQm3H4w6M63e?=
 =?us-ascii?q?QiHw/I0gMvENABv2jbotjuKKcfU/q4wLXUwTjNbf5b3yr25ojSchAmpPGBRb?=
 =?us-ascii?q?BwcMTNxkY1DQPFkkucopHiMjOX2OUCr3KU7/B8Ve6xkGMntwFwrSSvxscrkI?=
 =?us-ascii?q?XJgJkVxUre+SV2x4Y1O8S1RUhmatCqF5tQsjuVN4pwQs46X25ovyA6yrMftZ?=
 =?us-ascii?q?6gYCcF0pInywTba/OcdYWD/xHtVP6JLDtli39od6izihav/US61OHxWde43E?=
 =?us-ascii?q?xXoidDj9LCrGoC1wbJ5ciCUvZ9+0Ch1iuR2A3L8eFEJFw0lbLcK5483r48jp?=
 =?us-ascii?q?oTvlrHHi/xgEj2kLWZdl8l+ui18OTreKnmp5+AOI90jQHyKKIuldCkAeskKA?=
 =?us-ascii?q?QOWmmb+eCk2L3i+032XqlKg+UrnqTWv53WP8QWqrOjDwNL3Ysv9QyzAyq+3N?=
 =?us-ascii?q?Qdh3YHLVZFeBydj4juPlHDOPL4DPmjjFu2ijdr2+7KM6b9ApTNMnfDkLDhca?=
 =?us-ascii?q?x7605H0gU/199f55VKCr0ZOvL8RlfxtMDEDh8+KwG0xOPnCNJm1oMYQ22AHr?=
 =?us-ascii?q?GWPbjIsVCW++0vI/ODZJMPtDnhLPgl4ubkjWUlll8FYampwZwXZWijHvt4J0?=
 =?us-ascii?q?WZYHzsgsoOEGoRoAo+Q/LliEeYXT5QeXmyRaQ86S8/CI68CofDXI+t0/S923?=
 =?us-ascii?q?KcGJFMa2IOL1eXF37jeobMD/AJbzmUK8RsuiYJWbioV8kq0hT45yHgzL8yLP?=
 =?us-ascii?q?Xf8zcE79q31sd+7vfPzzku5Dd0CIKbyGjLQGZqyDBbDwQq1bxy9BQugmyI1r?=
 =?us-ascii?q?J11rkBTo1e?=
X-IPAS-Result: =?us-ascii?q?A2BcAwDEoQNd/wHyM5BmHQEBBQEHBQGBVAUBCwGBZiqBb?=
 =?us-ascii?q?iiEFpReJZpeCQEBAQEBAQEBATQBAgEBgUtHgi4CgkwjNwYOAQMBAQEEAQEBA?=
 =?us-ascii?q?QMBAWwogjopAYJnAQUjBBFBEAsJBQoCAiYCAlcGDQYCAQGCXz+CC6oCfjOFR?=
 =?us-ascii?q?4MegUaBDCgBi1yBVkCBEScMgl8+gReCdoNBglgEgS0BijiHZVeVMgYDghKLJ?=
 =?us-ascii?q?YNzhDMGG4IoL4ZTjgimBSKBWCsKQUqBHoFOgkaOKCMDMIEGAQGNAYJSAQE?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 14 Jun 2019 13:37:51 +0000
Received: from moss-lions.infosec.tycho.ncsc.mil (moss-lions [192.168.25.4])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x5EDbpHL028323;
        Fri, 14 Jun 2019 09:37:51 -0400
Subject: Re: [Non-DoD Source] [PATCH userspace v4 2/4] libsemanage: optionally
 optimize policy on rebuild
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>
References: <20190613114558.32621-1-omosnace@redhat.com>
 <20190613114558.32621-3-omosnace@redhat.com>
 <0e7cdb7f-b4a1-8ac7-e837-9bbb7523f4ff@tycho.nsa.gov>
 <CAFqZXNsgRTcH_=AUWNeGTdVNwBSDpw6EG9xu4B8uQJwa7zJdPA@mail.gmail.com>
From:   jwcart2 <jwcart2@tycho.nsa.gov>
Message-ID: <2721d28c-c07c-2893-0443-4919cc5e2494@tycho.nsa.gov>
Date:   Fri, 14 Jun 2019 09:38:50 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAFqZXNsgRTcH_=AUWNeGTdVNwBSDpw6EG9xu4B8uQJwa7zJdPA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 6/14/19 6:18 AM, Ondrej Mosnacek wrote:
> On Thu, Jun 13, 2019 at 9:51 PM jwcart2 <jwcart2@tycho.nsa.gov> wrote:
>> On 6/13/19 7:45 AM, Ondrej Mosnacek wrote:
>>> When building binary policy, optionally run it through
>>> sepol_policydb_optimize() just before writing it out.
>>>
>>> Add an optimize-policy variable to semanage.conf(5) that controls
>>
>> Sorry I didn't notice this in v3, but why not use "optimize" instead of
>> "optimize-policy"?
> 
> Since this is in a global libsemanage config file, I thought it would
> be better if the name described also what is being optimized. In
> secilc or checkpolicy it is more or less obvious; in the config file
> it can't hurt to be more specific, IMHO.
> 

Ok. I just wanted to make sure we had thought about it.

Jim

>>
>> Jim
>>
>>> whether optimization will be applied during libsemanage operations.
>>>
>>> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
>>> ---
>>>    libsemanage/man/man5/semanage.conf.5 |  5 +++++
>>>    libsemanage/src/conf-parse.y         | 15 ++++++++++++++-
>>>    libsemanage/src/conf-scan.l          |  1 +
>>>    libsemanage/src/direct_api.c         |  7 +++++++
>>>    libsemanage/src/semanage_conf.h      |  1 +
>>>    5 files changed, 28 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/libsemanage/man/man5/semanage.conf.5 b/libsemanage/man/man5/semanage.conf.5
>>> index 8f8de55a..8efc7dd5 100644
>>> --- a/libsemanage/man/man5/semanage.conf.5
>>> +++ b/libsemanage/man/man5/semanage.conf.5
>>> @@ -121,6 +121,11 @@ and by default it is set to "false".
>>>    Please note that since this option deletes all HLL files, an updated HLL compiler will not be able to recompile the original HLL file into CIL.
>>>    In order to compile the original HLL file into CIL, the same HLL file will need to be reinstalled.
>>>
>>> +.TP
>>> +.B optimize-policy
>>> +When set to "true", the kernel policy will be optimized upon rebuilds.
>>> +It can be set to either "true" or "false" and by default it is set to "false".
>>> +
>>>    .SH "SEE ALSO"
>>>    .TP
>>>    semanage(8)
>>> diff --git a/libsemanage/src/conf-parse.y b/libsemanage/src/conf-parse.y
>>> index b527e893..9bf9364a 100644
>>> --- a/libsemanage/src/conf-parse.y
>>> +++ b/libsemanage/src/conf-parse.y
>>> @@ -59,7 +59,7 @@ static int parse_errors;
>>>            char *s;
>>>    }
>>>
>>> -%token MODULE_STORE VERSION EXPAND_CHECK FILE_MODE SAVE_PREVIOUS SAVE_LINKED TARGET_PLATFORM COMPILER_DIR IGNORE_MODULE_CACHE STORE_ROOT
>>> +%token MODULE_STORE VERSION EXPAND_CHECK FILE_MODE SAVE_PREVIOUS SAVE_LINKED TARGET_PLATFORM COMPILER_DIR IGNORE_MODULE_CACHE STORE_ROOT OPTIMIZE_POLICY
>>>    %token LOAD_POLICY_START SETFILES_START SEFCONTEXT_COMPILE_START DISABLE_GENHOMEDIRCON HANDLE_UNKNOWN USEPASSWD IGNOREDIRS
>>>    %token BZIP_BLOCKSIZE BZIP_SMALL REMOVE_HLL
>>>    %token VERIFY_MOD_START VERIFY_LINKED_START VERIFY_KERNEL_START BLOCK_END
>>> @@ -95,6 +95,7 @@ single_opt:     module_store
>>>        |       bzip_blocksize
>>>        |       bzip_small
>>>        |       remove_hll
>>> +     |       optimize_policy
>>>            ;
>>>
>>>    module_store:   MODULE_STORE '=' ARG {
>>> @@ -268,6 +269,17 @@ remove_hll:  REMOVE_HLL'=' ARG {
>>>        free($3);
>>>    }
>>>
>>> +optimize_policy:  OPTIMIZE_POLICY '=' ARG {
>>> +     if (strcasecmp($3, "false") == 0) {
>>> +             current_conf->optimize_policy = 0;
>>> +     } else if (strcasecmp($3, "true") == 0) {
>>> +             current_conf->optimize_policy = 1;
>>> +     } else {
>>> +             yyerror("optimize-policy can only be 'true' or 'false'");
>>> +     }
>>> +     free($3);
>>> +}
>>> +
>>>    command_block:
>>>                    command_start external_opts BLOCK_END  {
>>>                            if (new_external->path == NULL) {
>>> @@ -352,6 +364,7 @@ static int semanage_conf_init(semanage_conf_t * conf)
>>>        conf->bzip_small = 0;
>>>        conf->ignore_module_cache = 0;
>>>        conf->remove_hll = 0;
>>> +     conf->optimize_policy = 0;
>>>
>>>        conf->save_previous = 0;
>>>        conf->save_linked = 0;
>>> diff --git a/libsemanage/src/conf-scan.l b/libsemanage/src/conf-scan.l
>>> index 607bbf0b..b06a896c 100644
>>> --- a/libsemanage/src/conf-scan.l
>>> +++ b/libsemanage/src/conf-scan.l
>>> @@ -54,6 +54,7 @@ handle-unknown    return HANDLE_UNKNOWN;
>>>    bzip-blocksize      return BZIP_BLOCKSIZE;
>>>    bzip-small  return BZIP_SMALL;
>>>    remove-hll  return REMOVE_HLL;
>>> +optimize-policy return OPTIMIZE_POLICY;
>>>    "[load_policy]"   return LOAD_POLICY_START;
>>>    "[setfiles]"      return SETFILES_START;
>>>    "[sefcontext_compile]"      return SEFCONTEXT_COMPILE_START;
>>> diff --git a/libsemanage/src/direct_api.c b/libsemanage/src/direct_api.c
>>> index c58961be..0153091f 100644
>>> --- a/libsemanage/src/direct_api.c
>>> +++ b/libsemanage/src/direct_api.c
>>> @@ -1461,6 +1461,13 @@ rebuild:
>>>
>>>                cil_db_destroy(&cildb);
>>>
>>> +             /* Remove redundancies in binary policy if requested. */
>>> +             if (sh->conf->optimize_policy) {
>>> +                     retval = sepol_policydb_optimize(out);
>>> +                     if (retval < 0)
>>> +                             goto cleanup;
>>> +             }
>>> +
>>>                /* Write the linked policy before merging local changes. */
>>>                retval = semanage_write_policydb(sh, out,
>>>                                                 SEMANAGE_LINKED);
>>> diff --git a/libsemanage/src/semanage_conf.h b/libsemanage/src/semanage_conf.h
>>> index c99ac8c7..23c4b8b4 100644
>>> --- a/libsemanage/src/semanage_conf.h
>>> +++ b/libsemanage/src/semanage_conf.h
>>> @@ -47,6 +47,7 @@ typedef struct semanage_conf {
>>>        int bzip_small;
>>>        int remove_hll;
>>>        int ignore_module_cache;
>>> +     int optimize_policy;
>>>        char *ignoredirs;       /* ";" separated of list for genhomedircon to ignore */
>>>        struct external_prog *load_policy;
>>>        struct external_prog *setfiles;
>>>
>>
>>
>> --
>> James Carter <jwcart2@tycho.nsa.gov>
>> National Security Agency
> 
> 
> 
> --
> Ondrej Mosnacek <omosnace at redhat dot com>
> Software Engineer, Security Technologies
> Red Hat, Inc.
> 


-- 
James Carter <jwcart2@tycho.nsa.gov>
National Security Agency
