Return-Path: <SRS0=naTH=RO=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF911C43381
	for <selinux@archiver.kernel.org>; Mon, 11 Mar 2019 17:14:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B514A205F4
	for <selinux@archiver.kernel.org>; Mon, 11 Mar 2019 17:14:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="Mrfhrgvs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727118AbfCKROj (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 11 Mar 2019 13:14:39 -0400
Received: from uphb19pa09.eemsg.mail.mil ([214.24.26.83]:41366 "EHLO
        USFB19PA12.eemsg.mail.mil" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726864AbfCKROj (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 11 Mar 2019 13:14:39 -0400
X-EEMSG-check-017: 261450341|USFB19PA12_EEMSG_MP8.csd.disa.mil
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by USFB19PA12.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 11 Mar 2019 17:13:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1552324432; x=1583860432;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=9BLqNv4oyTWfL1Y+AxGu78/sHNIU0CqMSVvXbcSXasc=;
  b=MrfhrgvsH2HX+PQJZJ5bD5C/taAuN9kG8wubxT9SB/9jZZdb73Yn/qPB
   xo9+d9JSQoxMaXlQXzjDgwkA9HnA53NwEs8rXKXad/Z103fk0UXNgZaqi
   gnFI13HrLuotrBSwAUy6VCqsFUX/HFfF5/4L3bc2L1vTdAHvP9gsiZK9a
   qSLXSjtoHOBQYlzSjXP5ZuLOvuKN+Op+afQoPLpmYm2UPPGmMhBbDjctX
   PVRDS0LfY48KzmSR/UhhahQQ/wArLKKdPDJzWXeW7/X1KWujWKl98c4ui
   SmMTpw1Z3BpgEUx3Y0u91c7RUU0xJJBEOhGwt5CohIeVCOePVWi4wtCXj
   A==;
X-IronPort-AV: E=Sophos;i="5.58,468,1544486400"; 
   d="scan'208";a="24890973"
IronPort-PHdr: =?us-ascii?q?9a23=3AlQZRDxbeum9j+WmLpmAat4n/LSx+4OfEezUN45?=
 =?us-ascii?q?9isYplN5qZrs2zbnLW6fgltlLVR4KTs6sC17OO9fi5EUU7or+5+EgYd5JNUx?=
 =?us-ascii?q?JXwe43pCcHRPC/NEvgMfTxZDY7FskRHHVs/nW8LFQHUJ2mPw6arXK99yMdFQ?=
 =?us-ascii?q?viPgRpOOv1BpTSj8Oq3Oyu5pHfeQpFiCehbb9oMBm6sBjau9ULj4dlNqs/0A?=
 =?us-ascii?q?bCrGFSe+RRy2NoJFaTkAj568yt4pNt8Dletuw4+cJYXqr0Y6o3TbpDDDQ7KG?=
 =?us-ascii?q?81/9HktQPCTQSU+HQRVHgdnwdSDAjE6BH6WYrxsjf/u+Fg1iSWIdH6QLYpUj?=
 =?us-ascii?q?m58axlVAHnhzsGNz4h8WHYlMpwjL5AoBm8oxBz2pPYbJ2JOPZ7eK7Sc8kaRW?=
 =?us-ascii?q?5cVchPUSJPDJ63Y48WA+YfOetUqo/wrEYMoxSjHwmhHP7hxCFGhnH23qM03e?=
 =?us-ascii?q?ouHg7E0wM8ENwDq2jUodbvOasOTey4wqvFwDPeZP1Wwzf9743Ifwg8r/GQQ7?=
 =?us-ascii?q?1wacrRxlcpFwjYk1uQrJbqPzeR1usTs2mQ8u1tVfmyhG48sAxxvjiuydssio?=
 =?us-ascii?q?nOnI4VzEvE+j9jzIY6It24Vld2bNi5G5VesCGaMpF5QsIkQ2xwoiY11KAJuZ?=
 =?us-ascii?q?6hcygW0pgo2xnfa/mff4iT5RLjSfyRLitmi3NrYr2/nQi9/VKnyu3mWcm51k?=
 =?us-ascii?q?tBoCldktTUq3wA2BPe5tKHR/dg5EutxzmC2x7J5u1ZJ00/iLDVJIQ7wrEqk5?=
 =?us-ascii?q?oeqUHDHijrl0rolKKWbUAk+vSw6+Tgf7XmuoeQN49qhQH6NaQjgtC/Dv4iMg?=
 =?us-ascii?q?gPQmib4v6w1KHj/ELlQLVKiec6kq/Fv5DBOcsXvKu5Aw5R0oo76ha/CSmp0M?=
 =?us-ascii?q?gAkHUaI19IdwiLgoj0N13UPvz1Aumzj06xnDtzwvDJJLzhApHDLnjZl7fheK?=
 =?us-ascii?q?5w61VBxwoo1t1f+5JVBa0BIPL0QEPxssfYAQUjPwy7xObnFs1x1pkCVmKXHq?=
 =?us-ascii?q?+ZLKTSvEeQ5uIrOeaMeZMVuCzmJPc//PPul2E2lkIdfaazwZsbcmy3HvNjI0?=
 =?us-ascii?q?+Be3rjns8BEXsWvgo5VOHqk0ONUTpSZ3a0QqI96So2CJypDYjdXIChmr+B0z?=
 =?us-ascii?q?mhHp1QeG9GDkqAEXDyd4WLCL8wb3eqL9N72hgNSKS7QYYq1Vn6rAvz1qZ9JO?=
 =?us-ascii?q?P84CAUtZv/ktNy4ruAuws18GlPE8mF02yLB1pxl2cMSi5+iLtzumRh21yD1u?=
 =?us-ascii?q?5+mPUeGttNsaAaGjwmPILRmrQpQ+v5XRjMK5LQEger?=
X-IPAS-Result: =?us-ascii?q?A2A8AAB0loZc/wHyM5BkHAEBAQQBAQcEAQGBUQcBAQsBg?=
 =?us-ascii?q?WUqaIEDJ4QJiBqLfwEBAQEBAQaBCC2JP45ngXswCAGBS4J1AoQ6IjQJDQEBA?=
 =?us-ascii?q?wEBAQYBAwIBbBwMgjopAYJnAQUjDwEFQRAJAg4KAgImAgJXBg0GAgEBgl8/A?=
 =?us-ascii?q?YFoDQ+UOptmgS+FRYRkBYELJAGLLBd4gQeBOIJrgx4EGIRRglcDpCEJh1GDf?=
 =?us-ascii?q?Ic5BhmTOpBdjlE4gVYrCAIYCCEPgyeCFheDS4UUhVsjAzABgQQBAY85AQE?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 11 Mar 2019 17:13:47 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x2BHDkfd011569;
        Mon, 11 Mar 2019 13:13:47 -0400
Subject: Re: [PATCH] libselinux: Do not define gettid() if glibc >= 2.30 is
 used
To:     Petr Lautrbach <plautrba@redhat.com>
Cc:     selinux@vger.kernel.org
References: <20190311150041.373-1-plautrba@redhat.com>
 <5d91e4f6-db03-c7af-4ed9-2b7aef533830@tycho.nsa.gov>
 <pjdimwpgy6p.fsf@redhat.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <acc3256f-fa65-38fe-da5e-ddd56ac97269@tycho.nsa.gov>
Date:   Mon, 11 Mar 2019 13:10:30 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <pjdimwpgy6p.fsf@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 3/11/19 12:42 PM, Petr Lautrbach wrote:
> 
> Stephen Smalley <sds@tycho.nsa.gov> writes:
> 
>> On 3/11/19 11:00 AM, Petr Lautrbach wrote:
>>> Since version 2.30 glibc implements gettid() system call wrapper, see
>>> https://sourceware.org/bugzilla/show_bug.cgi?id=6399
>>>
>>> Fixes:
>>> cc -O2 -g -pipe -Wall -Werror=format-security -Wp,-D_FORTIFY_SOURCE=2 
>>> -Wp,-D_GLIBCXX_ASSERTIONS -fexceptions -fstack-protector-strong 
>>> -grecord-gcc-switches -specs=/usr/lib/rpm/redhat/redhat-hardened-cc1 
>>> -specs=/usr/lib/rpm/redhat/redhat-annobin-cc1 -m64 -mtune=generic 
>>> -fasynchronous-unwind-tables -fstack-clash-protection -fcf-protection 
>>> -I../include -D_GNU_SOURCE  -DNO_ANDROID_BACKEND   -c -o procattr.o 
>>> procattr.c
>>> procattr.c:28:14: error: static declaration of ‘gettid’ follows 
>>> non-static declaration
>>>     28 | static pid_t gettid(void)
>>>        |              ^~~~~~
>>> In file included from /usr/include/unistd.h:1170,
>>>                   from procattr.c:2:
>>> /usr/include/bits/unistd_ext.h:34:16: note: previous declaration of 
>>> ‘gettid’ was here
>>>     34 | extern __pid_t gettid (void) __THROW;
>>>        |                ^~~~~~
>>>
>>> Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
>>
>> I assume the glibc change will break a lot of software out there that 
>> assumed
>> that "never" meant "never" and rolled their own gettid() wrapper.  
>> Would have
>> been nice if they had at least added some #define to indicate that it 
>> is now
>> provided for easy testing rather than needing to test minor version 
>> number.
>> Anyway, regardless,
>>
> 
> I asked for an advice from glibc Fedora maintainer [1] as the current
> version is Fedora Rawhide is still 2.29 but it already ships gettid
> wrapped linked as gettid@@GLIBC_2.30. The response was that I should
> rename libselinux gettid() to something else in order to prevent such
> conflict. It would mean that libselinux won't depend on glibc
> implementation. But I decided to test the minor version and use
> the new glibc wrapper when it's possible.

Yes, your way seems better - no point in providing our own wrapper once 
glibc has it.

> 
> [1] https://bugzilla.redhat.com/show_bug.cgi?id=1685594
> 
>> Acked-by: Stephen Smalley <sds@tycho.nsa.gov>
>>
>>> ---
>>>   libselinux/src/procattr.c | 15 +++++++++++++--
>>>   1 file changed, 13 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/libselinux/src/procattr.c b/libselinux/src/procattr.c
>>> index 48dd8aff..c6799ef2 100644
>>> --- a/libselinux/src/procattr.c
>>> +++ b/libselinux/src/procattr.c
>>> @@ -22,8 +22,19 @@ static pthread_key_t destructor_key;
>>>   static int destructor_key_initialized = 0;
>>>   static __thread char destructor_initialized;
>>>   -#ifndef __BIONIC__
>>> -/* Bionic declares this in unistd.h and has a definition for it */
>>> +/* Bionic and glibc >= 2.30 declare gettid() system call wrapper in 
>>> unistd.h and
>>> + * has a definition for it */
>>> +#ifdef __BIONIC__
>>> +  #define OVERRIDE_GETTID 0
>>> +#elif !defined(__GLIBC_PREREQ)
>>> +  #define OVERRIDE_GETTID 1
>>> +#elif !__GLIBC_PREREQ(2,30)
>>> +  #define OVERRIDE_GETTID 1
>>> +#else
>>> +  #define OVERRIDE_GETTID 0
>>> +#endif
>>> +
>>> +#if OVERRIDE_GETTID
>>>   static pid_t gettid(void)
>>>   {
>>>       return syscall(__NR_gettid);
>>>
> 

