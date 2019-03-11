Return-Path: <SRS0=naTH=RO=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77F2FC43381
	for <selinux@archiver.kernel.org>; Mon, 11 Mar 2019 16:26:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45F5D2148D
	for <selinux@archiver.kernel.org>; Mon, 11 Mar 2019 16:26:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="F0l3p66W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726625AbfCKQ0r (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 11 Mar 2019 12:26:47 -0400
Received: from upbd19pa11.eemsg.mail.mil ([214.24.27.86]:65194 "EHLO
        upbd19pa11.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726000AbfCKQ0q (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 11 Mar 2019 12:26:46 -0400
X-EEMSG-check-017: 196092283|UPBD19PA11_EEMSG_MP11.csd.disa.mil
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by upbd19pa11.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 11 Mar 2019 16:26:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1552321598; x=1583857598;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=XPHjNN7wxaPfR+gkrzOviLYf4rVtM5xvtUuWuxJgILM=;
  b=F0l3p66WXkg/wYNACqiNpFYx+CoIdb78EqcGR9cmhk2anYv/Je5zu/F+
   SLSE35iCh4cglVJdyCU2ex7Lz8VGbt+MngV3GUUrQSFT7FXewnTwokJVa
   WvjfFj/2UEmLrf3mGhRp7V4LK/fZlwAUoFOG8Z8iRDPYB6+8+6p36Ltw7
   pWt11MlKR7t2YtA4oWt7AHBqAixwVfby8zd2oiHA50kgDkfYzErnWe3na
   JGWZSfm/inDwCvtbylewn3VgB9LDPnQQucC04qsIfxRJPJ/qm8zQJXldx
   eI0NN/OjDVG8YR7Hgv4NK/3ymMAR/609JTqeaxqefII3AFyYS7qEtd1u+
   w==;
X-IronPort-AV: E=Sophos;i="5.58,468,1544486400"; 
   d="scan'208";a="24887771"
IronPort-PHdr: =?us-ascii?q?9a23=3Al0hx+RDmZM3n1jn3+YNLUyQJP3N1i/DPJgcQr6?=
 =?us-ascii?q?AfoPdwSPX5pcbcNUDSrc9gkEXOFd2Cra4d06yO6ujJYi8p2d65qncMcZhBBV?=
 =?us-ascii?q?cuqP49uEgeOvODElDxN/XwbiY3T4xoXV5h+GynYwAOQJ6tL1LdrWev4jEMBx?=
 =?us-ascii?q?7xKRR6JvjvGo7Vks+7y/2+94fcbglVmDaxe69+IAirpgjNq8cahpdvJLwswR?=
 =?us-ascii?q?XTuHtIfOpWxWJsJV2Nmhv3+9m98p1+/SlOovwt78FPX7n0cKQ+VrxYES8pM3?=
 =?us-ascii?q?sp683xtBnMVhWA630BWWgLiBVIAgzF7BbnXpfttybxq+Rw1DWGMcDwULs5Qi?=
 =?us-ascii?q?qp4bt1RxD0iScHLz85/3/Risxsl6JQvRatqwViz4LIfI2ZMfxzca3HfdMeWG?=
 =?us-ascii?q?FPQMBfWSJcCY+4docDEe4MMeNeooLgpVUBsAG+CBGxCu3xxD9Ghnz406M03O?=
 =?us-ascii?q?suEw7JwAMuEskSsHnXttj5KLseXO63waTO0D7Nb+lW2TD46IXQbx4hve+DXa?=
 =?us-ascii?q?pwccXPz0kkCh7LjlCKpozhOzOayOQMuHWc4up7SO2vkHUqqx1xozezxscsjZ?=
 =?us-ascii?q?PFhoQOyl/e7yl5z4E1JcOhRUN9fNWqHpxQtySAOIt3RMMvW3pouCEnyr0cpZ?=
 =?us-ascii?q?G0YiYLx449xxHBcfCHdJKI4h3lWe2MIjl4nGpodK+wihu960StyvDwWtOq3F?=
 =?us-ascii?q?tFsCZJiMTAu3YQ3BLJ8MeHUOFy/kK51DaK0ADc9/9LLFgvlareN54h2rkwlo?=
 =?us-ascii?q?cPsUjbHi/5hkH2jKiOe0U44Oeo8eXnYqj9ppOGK491ih3xMqQpmsClB+Q3Lh?=
 =?us-ascii?q?MOUHSB9eS51b3j+VX1QLRMjvIojqnUqI3WKMsUq6KjAwJZz5wv5wiwAju4yt?=
 =?us-ascii?q?gUgGELLFdfdxKGi4jpNUvOIPf9DfqnmFSjjSxryuvaPrzhHprNLn/DnK3nfb?=
 =?us-ascii?q?Zm8UFQ0gUzzddB555MELEOPOrzWlPttNzfFhI5Kwi0zPz6CNVhzIMRQniAD7?=
 =?us-ascii?q?SDMKzMrFCI5vggI/WWaIAJvzb9LuAv5+Tygn8hhV8dYa6p0IMMaH+mGvRmIk?=
 =?us-ascii?q?OZYWfjg9oaD2cKsRQxTPbwhF2BTzFTfXCyULw45j0hD4KmF4jDFciRh+m50T?=
 =?us-ascii?q?uhVrlfe3xcAFmHET+8b4GNRusWYiu6OMJtkjUYE7OmTtllnQqjsA781qpPMO?=
 =?us-ascii?q?XZ4GsbuIjl2dwz4Pfcxj8o8jkhNNiQy2GASSlPm2oMQzInlPRkrVdV1kaI0a?=
 =?us-ascii?q?8+hedRU9NU+aUaAU8BKZfAwrkiWJjJUQXbc4LMEQz3Tw=3D=3D?=
X-IPAS-Result: =?us-ascii?q?A2BoAADkioZc/wHyM5BkHAEBAQQBAQcEAQGBUgYBAQsBg?=
 =?us-ascii?q?WUqaIEDJ4QJk0xMAQEBAQEBBoEILYk/jmeBezAIAYFLgnUChDoiNQgNAQEDA?=
 =?us-ascii?q?QEBBgEDAgFsHAyCOikBgmcBBSMPAQVRCw4KAgImAgJXBgEMBgIBAYJfPwGBa?=
 =?us-ascii?q?A0PsAWBL4VFhGEFgQskAYssF3iBB4E4gmuDHgQYhFGCVwOkIQmHUYs1BhmTO?=
 =?us-ascii?q?op4hWWOUgE2gVYrCAIYCCEPgyeCFheIX4VbIwMwgQUBAY85AQE?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 11 Mar 2019 16:26:36 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x2BGQaSo025414;
        Mon, 11 Mar 2019 12:26:36 -0400
Subject: Re: [PATCH] libselinux: Do not define gettid() if glibc >= 2.30 is
 used
To:     Petr Lautrbach <plautrba@redhat.com>, selinux@vger.kernel.org
References: <20190311150041.373-1-plautrba@redhat.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <5d91e4f6-db03-c7af-4ed9-2b7aef533830@tycho.nsa.gov>
Date:   Mon, 11 Mar 2019 12:23:21 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190311150041.373-1-plautrba@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 3/11/19 11:00 AM, Petr Lautrbach wrote:
> Since version 2.30 glibc implements gettid() system call wrapper, see
> https://sourceware.org/bugzilla/show_bug.cgi?id=6399
> 
> Fixes:
> cc -O2 -g -pipe -Wall -Werror=format-security -Wp,-D_FORTIFY_SOURCE=2 -Wp,-D_GLIBCXX_ASSERTIONS -fexceptions -fstack-protector-strong -grecord-gcc-switches -specs=/usr/lib/rpm/redhat/redhat-hardened-cc1 -specs=/usr/lib/rpm/redhat/redhat-annobin-cc1 -m64 -mtune=generic -fasynchronous-unwind-tables -fstack-clash-protection -fcf-protection -I../include -D_GNU_SOURCE  -DNO_ANDROID_BACKEND   -c -o procattr.o procattr.c
> procattr.c:28:14: error: static declaration of ‘gettid’ follows non-static declaration
>     28 | static pid_t gettid(void)
>        |              ^~~~~~
> In file included from /usr/include/unistd.h:1170,
>                   from procattr.c:2:
> /usr/include/bits/unistd_ext.h:34:16: note: previous declaration of ‘gettid’ was here
>     34 | extern __pid_t gettid (void) __THROW;
>        |                ^~~~~~
> 
> Signed-off-by: Petr Lautrbach <plautrba@redhat.com>

I assume the glibc change will break a lot of software out there that 
assumed that "never" meant "never" and rolled their own gettid() 
wrapper.  Would have been nice if they had at least added some #define 
to indicate that it is now provided for easy testing rather than needing 
to test minor version number.  Anyway, regardless,

Acked-by: Stephen Smalley <sds@tycho.nsa.gov>

> ---
>   libselinux/src/procattr.c | 15 +++++++++++++--
>   1 file changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/libselinux/src/procattr.c b/libselinux/src/procattr.c
> index 48dd8aff..c6799ef2 100644
> --- a/libselinux/src/procattr.c
> +++ b/libselinux/src/procattr.c
> @@ -22,8 +22,19 @@ static pthread_key_t destructor_key;
>   static int destructor_key_initialized = 0;
>   static __thread char destructor_initialized;
>   
> -#ifndef __BIONIC__
> -/* Bionic declares this in unistd.h and has a definition for it */
> +/* Bionic and glibc >= 2.30 declare gettid() system call wrapper in unistd.h and
> + * has a definition for it */
> +#ifdef __BIONIC__
> +  #define OVERRIDE_GETTID 0
> +#elif !defined(__GLIBC_PREREQ)
> +  #define OVERRIDE_GETTID 1
> +#elif !__GLIBC_PREREQ(2,30)
> +  #define OVERRIDE_GETTID 1
> +#else
> +  #define OVERRIDE_GETTID 0
> +#endif
> +
> +#if OVERRIDE_GETTID
>   static pid_t gettid(void)
>   {
>   	return syscall(__NR_gettid);
> 

