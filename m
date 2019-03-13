Return-Path: <SRS0=LIAv=RQ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F4EEC43381
	for <selinux@archiver.kernel.org>; Wed, 13 Mar 2019 17:26:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE48E2087C
	for <selinux@archiver.kernel.org>; Wed, 13 Mar 2019 17:26:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="TLenKFO3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726033AbfCMR0z (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 13 Mar 2019 13:26:55 -0400
Received: from upbd19pa10.eemsg.mail.mil ([214.24.27.85]:27432 "EHLO
        upbd19pa10.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725856AbfCMR0z (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 13 Mar 2019 13:26:55 -0400
X-EEMSG-check-017: 207393415|UPBD19PA10_EEMSG_MP10.csd.disa.mil
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by upbd19pa10.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 13 Mar 2019 17:26:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1552498007; x=1584034007;
  h=subject:from:to:references:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=C+05Ag2dpAsfCdLEOEbaWvV8isRzEKPSItzsD1aL86s=;
  b=TLenKFO3osF0p4d6GBj5Bh+m6gIqHx06DRBCqy6uVNrJExQ5OCZjg/5z
   bVKoFhBBs95k9QHDEIjcqk6CJ0IPv18bfV8CSl7C9PA59Ba3jqzoVxQgU
   AtvsCLaRb3UmQ2gyc7DicvtuubptiAEf8JApgaDixRe6AkoPLd6urg7kf
   9CVl5TpsyKhdwODOqyDcEbRLjLiNVX0HDdKB1mtPE3GNrw1oaIC6DvHJE
   ts0pIHeDVmDnyX8dwhQUbWAdCpk2zqjFVawBbhkoV9+yzk5qrQlPIo7Xb
   M9nw6tzYYiLClXhHrzNePHLSm0YK3fKiYtIJaLQrdIghydBGqRoduwhVI
   g==;
X-IronPort-AV: E=Sophos;i="5.58,475,1544486400"; 
   d="scan'208";a="24996337"
IronPort-PHdr: =?us-ascii?q?9a23=3AWiJW3hRA3SS7xTNgOruJHZS9WNpsv+yvbD5Q0Y?=
 =?us-ascii?q?Iujvd0So/mwa6zZhaN2/xhgRfzUJnB7Loc0qyK6vimATVIyK3CmUhKSIZLWR?=
 =?us-ascii?q?4BhJdetC0bK+nBN3fGKuX3ZTcxBsVIWQwt1Xi6NU9IBJS2PAWK8TW94jEIBx?=
 =?us-ascii?q?rwKxd+KPjrFY7OlcS30P2594HObwlSizexfK9+IA+qoQnMq8IbnZZsJqEtxx?=
 =?us-ascii?q?XTv3BGYf5WxWRmJVKSmxbz+MK994N9/ipTpvws6ddOXb31cKokQ7NYCi8mM3?=
 =?us-ascii?q?0u683wqRbDVwqP6WACXWgQjxFFHhLK7BD+Xpf2ryv6qu9w0zSUMMHqUbw5Xy?=
 =?us-ascii?q?mp4rx1QxH0ligIKz858HnWisNuiqJbvAmhrAF7z4LNfY2ZKOZycqbbcNwUX2?=
 =?us-ascii?q?pBWttaWTJHDI2ycoADC/MNMfhcooX4oVYFsBmwChS2BO731zFGhmH43aM53e?=
 =?us-ascii?q?ovHw7J0w4vEM4BvnnPsNX4N70fXfypwKTGzzjOae5d1zfn6IjPdxAsueyCXa?=
 =?us-ascii?q?5ufsrJyUkgCQXFhUiNp4zgJTyV0uANvHab7uF9Uu+vkHMoqxpqrzizxsYjlo?=
 =?us-ascii?q?nJhoUPxlDC7iV22pw5JdK/SE5leNOpFoZbuS+dN4tzWMwiQmdotT4hyr0BpJ?=
 =?us-ascii?q?67ZjQFx4opxhHFcfyIbZKE4hX5VOaeJzpzmXFreKqnihqv/kWtxffwW8mp3F?=
 =?us-ascii?q?pQsCZIncfAumoQ2xHV98OJUOFy/l271jaKzw3T7+ZELl0qmqfDMJ4hx6Iwlo?=
 =?us-ascii?q?IUsUTeAi/6gEX2g7GSdkUj4uWo9/7oYq/npp+BLI94kB3+M6Qylcy/BuQ0KA?=
 =?us-ascii?q?4OUHSA+eugzrHj+Ez5QLFSgv03lKnWrozaKNwGqqO2DAJZyIYu5wulAzu439?=
 =?us-ascii?q?kUg2MLIE9ddBKClYfpOlXOIP7iDfe4hlShiCxryO3dPrD6HpXMLmTMkLfmfb?=
 =?us-ascii?q?pn7U5c0xA8wcpQ55JTFLENOOjzVVPptNzEEh85NBS5w/7jCNpny4MeRXiPDb?=
 =?us-ascii?q?SDP67Jq1+H+P8gI+mWa48JojryN/8l5/v2h38jhVAdZbWp3YcQaH2gBfRpPU?=
 =?us-ascii?q?GZYXvqgtccHmYHpRQ+TOP0h12YSzJTZGi9X7g65j4lDIKqF4DDRpqigO/J4C?=
 =?us-ascii?q?DuJpBKfChiA02QC33hfIXMD+8IYT+OOMVouiYJWbioV8kq0hT48Efhxr5mKP?=
 =?us-ascii?q?fE0jMXuIil19Vv4eDX0xYo+m9aFcOYhlqRQnl0k2VAfDo/2KRysAQp0VuY+b?=
 =?us-ascii?q?RpiPxfU9pI7rVGVRlsZs2U9PBzF92nAlGJRdyOUlvzB4z8UDw=3D?=
X-IPAS-Result: =?us-ascii?q?A2BFAAAlPIlc/wHyM5BkHAEBAQQBAQcEAQGBUQcBAQsBg?=
 =?us-ascii?q?WUqaFAzJ4QKiBqLIEwBAQEBAQEGgQgtiT+Ob4F7MAgBgUuCdQKERiI0CQ0BA?=
 =?us-ascii?q?QMBAQEIAQMCAWwcDII6KQGCZwEFIw8BBVEJAg4KAgImAgJXBgEMBgIBAYJfP?=
 =?us-ascii?q?wGBaA0PkxibZoEviiwFgQskAYssF3iBB4E4gmuDHgQYhFGCVwOkOgmHWIs/B?=
 =?us-ascii?q?hmTR4p9hW+OYDiBVisIAhgIIQ+DJ4IWF4hfhVsjAzCBBQEBkEABAQ?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 13 Mar 2019 17:26:45 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x2DHQiOe008283;
        Wed, 13 Mar 2019 13:26:44 -0400
Subject: Re: [PATCH] libselinux: Do not define gettid() if glibc >= 2.30 is
 used
From:   Stephen Smalley <sds@tycho.nsa.gov>
To:     Petr Lautrbach <plautrba@redhat.com>, selinux@vger.kernel.org
References: <20190311150041.373-1-plautrba@redhat.com>
 <5d91e4f6-db03-c7af-4ed9-2b7aef533830@tycho.nsa.gov>
Message-ID: <f54f3298-1fe4-3c93-aeba-af5dfd9b45c6@tycho.nsa.gov>
Date:   Wed, 13 Mar 2019 13:26:39 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <5d91e4f6-db03-c7af-4ed9-2b7aef533830@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 3/11/19 12:23 PM, Stephen Smalley wrote:
> On 3/11/19 11:00 AM, Petr Lautrbach wrote:
>> Since version 2.30 glibc implements gettid() system call wrapper, see
>> https://sourceware.org/bugzilla/show_bug.cgi?id=6399
>>
>> Fixes:
>> cc -O2 -g -pipe -Wall -Werror=format-security -Wp,-D_FORTIFY_SOURCE=2 
>> -Wp,-D_GLIBCXX_ASSERTIONS -fexceptions -fstack-protector-strong 
>> -grecord-gcc-switches -specs=/usr/lib/rpm/redhat/redhat-hardened-cc1 
>> -specs=/usr/lib/rpm/redhat/redhat-annobin-cc1 -m64 -mtune=generic 
>> -fasynchronous-unwind-tables -fstack-clash-protection -fcf-protection 
>> -I../include -D_GNU_SOURCE  -DNO_ANDROID_BACKEND   -c -o procattr.o 
>> procattr.c
>> procattr.c:28:14: error: static declaration of ‘gettid’ follows 
>> non-static declaration
>>     28 | static pid_t gettid(void)
>>        |              ^~~~~~
>> In file included from /usr/include/unistd.h:1170,
>>                   from procattr.c:2:
>> /usr/include/bits/unistd_ext.h:34:16: note: previous declaration of 
>> ‘gettid’ was here
>>     34 | extern __pid_t gettid (void) __THROW;
>>        |                ^~~~~~
>>
>> Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
> 
> I assume the glibc change will break a lot of software out there that 
> assumed that "never" meant "never" and rolled their own gettid() 
> wrapper.  Would have been nice if they had at least added some #define 
> to indicate that it is now provided for easy testing rather than needing 
> to test minor version number.  Anyway, regardless,
> 
> Acked-by: Stephen Smalley <sds@tycho.nsa.gov>

Thanks, applied.

> 
>> ---
>>   libselinux/src/procattr.c | 15 +++++++++++++--
>>   1 file changed, 13 insertions(+), 2 deletions(-)
>>
>> diff --git a/libselinux/src/procattr.c b/libselinux/src/procattr.c
>> index 48dd8aff..c6799ef2 100644
>> --- a/libselinux/src/procattr.c
>> +++ b/libselinux/src/procattr.c
>> @@ -22,8 +22,19 @@ static pthread_key_t destructor_key;
>>   static int destructor_key_initialized = 0;
>>   static __thread char destructor_initialized;
>> -#ifndef __BIONIC__
>> -/* Bionic declares this in unistd.h and has a definition for it */
>> +/* Bionic and glibc >= 2.30 declare gettid() system call wrapper in 
>> unistd.h and
>> + * has a definition for it */
>> +#ifdef __BIONIC__
>> +  #define OVERRIDE_GETTID 0
>> +#elif !defined(__GLIBC_PREREQ)
>> +  #define OVERRIDE_GETTID 1
>> +#elif !__GLIBC_PREREQ(2,30)
>> +  #define OVERRIDE_GETTID 1
>> +#else
>> +  #define OVERRIDE_GETTID 0
>> +#endif
>> +
>> +#if OVERRIDE_GETTID
>>   static pid_t gettid(void)
>>   {
>>       return syscall(__NR_gettid);
>>
> 

