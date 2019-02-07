Return-Path: <SRS0=93oN=QO=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 315A4C282C2
	for <selinux@archiver.kernel.org>; Thu,  7 Feb 2019 18:17:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAC892086C
	for <selinux@archiver.kernel.org>; Thu,  7 Feb 2019 18:17:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="WDUJ9czR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726758AbfBGSRT (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 7 Feb 2019 13:17:19 -0500
Received: from uphb19pa11.eemsg.mail.mil ([214.24.26.85]:32015 "EHLO
        USFB19PA14.eemsg.mail.mil" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726319AbfBGSRT (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 7 Feb 2019 13:17:19 -0500
X-EEMSG-check-017: 118155984|USFB19PA14_EEMSG_MP10.csd.disa.mil
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by USFB19PA14.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 07 Feb 2019 18:17:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1549563436; x=1581099436;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=wGd/gUQW1M+/KeF6Pd12zzOz97phL0yIfDoQ38KyHRA=;
  b=WDUJ9czRw0tkjZ0zgsTsJirSjnHMvqHJKyL9KazY5xjDat7xZEyT6rHO
   9EcjBau94p9RCS95xJVgy1Y79U2A8z0wIVenPtZ8W2gmhuWfbawp14VNS
   ZsoFVHyaXvPCX3eIJXfQW3FnN5yMU5K6SuncaZ/KGwpxxWVvIrpbUrtKY
   Gz9WTDZk5k3Tq2m+uPEWzxTZdEgkFJJPzpbo1Tz0XfzuvNask1lEW0sH+
   to/8zlfBXUo4ZWsaKvpw53xA/z0kVqy86vVZNrfcdRshn3W2BXSinVlX7
   Fl8xw6m1dxB+5th4uZYFAscLf3EbD+ZAe5K7oWnwZxSaJQB4Xhe9/nbF0
   w==;
X-IronPort-AV: E=Sophos;i="5.58,345,1544486400"; 
   d="scan'208";a="20315782"
IronPort-PHdr: =?us-ascii?q?9a23=3AF2o0YBN5Xs3254x9NvEl6mtUPXoX/o7sNwtQ0K?=
 =?us-ascii?q?IMzox0K/zzp8bcNUDSrc9gkEXOFd2Cra4c26yO6+jJYi8p2d65qncMcZhBBV?=
 =?us-ascii?q?cuqP49uEgeOvODElDxN/XwbiY3T4xoXV5h+GynYwAOQJ6tL1LdrWev4jEMBx?=
 =?us-ascii?q?7xKRR6JvjvGo7Vks+7y/2+94fcbglUhzexe69+IAmrpgjNq8cahpdvJLwswR?=
 =?us-ascii?q?XTuHtIfOpWxWJsJV2Nmhv3+9m98p1+/SlOovwt78FPX7n0cKQ+VrxYES8pM3?=
 =?us-ascii?q?sp683xtBnMVhWA630BWWgLiBVIAgzF7BbnXpfttybxq+Rw1DWGMcDwULs5Qi?=
 =?us-ascii?q?qp4bt1RxD0iScHLz85/3/Risxsl6JQvRatqwViz4LIfI2ZMfxzca3HfdMeWG?=
 =?us-ascii?q?FPQMBfWSJcCY+4docDEfYNMeNeooLgpVUBsAG+CBGxCu3xxD9Ghnz406M03O?=
 =?us-ascii?q?suEw7JwAMuEskSsHnXttj5KLseXO63waTO0D7Nb+lW2TD46IXQbx4hve+DXa?=
 =?us-ascii?q?pwccXPz0kkCh7LjlCKpozhOzOayOQMuHWc4up7SO2vkHUqqx1xozezxscsjZ?=
 =?us-ascii?q?PFhoQOyl/e7yl5z4E1JcOhRUN9fNWqE4NQujmHO4Z5Tc4uWWFltDsgxrEYtp?=
 =?us-ascii?q?O3YjIGxIkhyhXCcfKIaZKI7QjmVOuJJDd4g29qd6ynihap9Eig1vX8Vs6p0F?=
 =?us-ascii?q?ZWtiZFksfDtnQK1xHL9siIUOF9/ka82TaUzQzT9uFFLlw0larcMZIhxKI/lo?=
 =?us-ascii?q?EPvkjZGy/2mUH2gLeXdkUi5Oeo9/zqbqjpq5KTLYN5ihzyPr4wlsGwH+g0KB?=
 =?us-ascii?q?UCU3Ce+eum1b3j+UP5QK9Njv0ziqTZq43VJd8Aq66lAw5azoYj6xGlAzegy9?=
 =?us-ascii?q?QXh2MLLF1CeBKZl4TpIU3BIOjkDfejhFShiDlqx/HCPr3lA5XCNH3DnK39cr?=
 =?us-ascii?q?pn8U5czxE8ws5F55JIEbEMO/PzWknttNPGCh81KRC7w+HiCN9lzIMRRXqPAr?=
 =?us-ascii?q?OFMKPVqVKI/uYvLPORZI8JojbyMOIq6uX0jXAnhFAdfbOm3YcNZH+kGfRmJl?=
 =?us-ascii?q?2TYWDwjdcZDWcKog0+QfTxiFKcVT5TZnCyX78z5zwgFoKmApnMRpq3jLyCwi?=
 =?us-ascii?q?i7BJtWaX5CClyWFnfobYqEUe8WaC2OOs9hjiAEVb+5Ro8m0BGusxT6y7x9Ie?=
 =?us-ascii?q?XI5CIVrojj28Zo6O3Tjx4y6SZ4ANia02GIHClImTZCfTg80bpjugg19VaH1a?=
 =?us-ascii?q?lxhrRzX5QH+PJNVgYzMNjXifZ9Ad3oRhnpf9GVRVLgSdKjV3V5dt8t2Zcqal?=
 =?us-ascii?q?thAd+rhRCLizKuCqIJjbaCLIY5/qLVwz76IMMrjz6Mz6Qljl87UuNROmC8wK?=
 =?us-ascii?q?1y7Q7eA8jOiUrT3/KxeKAd2jPd3HmMwHDIv0xCVgN0F6LfUiZMSFHRqIHC+k?=
 =?us-ascii?q?7aT7KoQY8iOw9FxN/KfrBGcfX1nF5GQ7HlI92YbGWvzTTjTS2Uz6+BOdK5M1?=
 =?us-ascii?q?4W2z/QXQ1dyVge?=
X-IPAS-Result: =?us-ascii?q?A2BgAADKdFxc/wHyM5BkGwEBAQEDAQEBBwMBAQGBVAMBA?=
 =?us-ascii?q?QELAYFaKYE4MieEA5QJUgaBCC2JNpBWOAGEQAKDKCI3Bg0BAwEBAQEBAQIBb?=
 =?us-ascii?q?CiCOikBgmYBAQEBAyMPAQVBDAQLEQQBAQECAiMDAgJGCQgGAQwGAgEBgmE/g?=
 =?us-ascii?q?XUNrSSBL4VEhGmBC4s4F3iBB4E4gmuICoJXApE7kVUJkj8GGZJVii2TUiKBV?=
 =?us-ascii?q?isIAhgIIQ+DJ5B7IQMwAYEEAQGNcwEB?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 07 Feb 2019 18:17:14 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto.infosec.tycho.ncsc.mil [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x17IH1dk006422;
        Thu, 7 Feb 2019 13:17:03 -0500
Subject: Re: gcc 9.0.0 build issues
To:     "Roberts, William C" <william.c.roberts@intel.com>,
        Petr Lautrbach <plautrba@redhat.com>,
        "selinux@vger.kernel.org" <selinux@vger.kernel.org>
Cc:     Ondrej Mosnacek <omosnace@redhat.com>
References: <pjdtvhns3pq.fsf@redhat.com>
 <CAFqZXNt8Df0KX9qVmsGtxZroy6s1SFBt1Qmi5Psuv6z0+kTB7Q@mail.gmail.com>
 <pjdlg2rydoj.fsf@redhat.com>
 <476DC76E7D1DF2438D32BFADF679FC5649CDF45F@ORSMSX101.amr.corp.intel.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <3a9f2281-aad4-58fd-ab8e-cb99a8da0fae@tycho.nsa.gov>
Date:   Thu, 7 Feb 2019 13:17:01 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <476DC76E7D1DF2438D32BFADF679FC5649CDF45F@ORSMSX101.amr.corp.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 2/7/19 12:52 PM, Roberts, William C wrote:
> 
> 
>> -----Original Message-----
>> From: Petr Lautrbach [mailto:plautrba@redhat.com]
>> Sent: Thursday, February 7, 2019 4:40 AM
>> To: selinux@vger.kernel.org
>> Cc: Petr Lautrbach <plautrba@redhat.com>; Roberts, William C
>> <william.c.roberts@intel.com>; Ondrej Mosnacek <omosnace@redhat.com>
>> Subject: Re: gcc 9.0.0 build issues
>>
>>
>> Ondrej Mosnacek <omosnace@redhat.com> writes:
>>
>>> On Fri, Feb 1, 2019 at 8:36 PM Petr Lautrbach <plautrba@redhat.com>
>>> wrote:
>>>> gcc-9.0.0-0.3.fc30.x86_64 from Fedora Rawhide:
>>>>
>>>> gcc version 9.0.0 20190119 (Red Hat 9.0.0-0.3) (GCC)
>>>>
>> ...
>>>> When libselinux is built separately, other CFLAGS is used:
>>>>
>>>> $ cd libselinux
>>>>
>>>> $ make DESTDIR=~/obj install install-pywrap ...
>>>>
>>>> make[1]: Entering directory
>>>> '/home/build/SELinuxProject-selinux/libselinux/src'
>>>>
>>>> cc -O -Wall -W -Wundef -Wformat-y2k -Wformat-security -Winit-self
>>>> -Wmissing-include-dirs -Wunused -Wunknown-pragmas -Wstrict-aliasing
>>>> -Wshadow -Wpointer-arith -Wbad-function-cast -Wcast-align
>>>> -Wwrite-strings -Waggregate-return -Wstrict-prototypes
>>>> -Wold-style-definition -Wmissing-prototypes -Wmissing-declarations
>>>> -Wmissing-noreturn -Wmissing-format-attribute -Wredundant-decls
>>>> -Wnested-externs -Winline -Winvalid-pch -Wvolatile-register-var
>>>> -Wdisabled-optimization -Wbuiltin-macro-redefined -Wattributes
>>>> -Wmultichar -Wdeprecated-declarations -Wdiv-by-zero
>>>> -Wdouble-promotion -Wendif-labels -Wextra -Wformat-extra-args
>>>> -Wformat-zero-length -Wformat=2 -Wmultichar -Woverflow
>>>> -Wpointer-to-int-cast -Wpragmas -Wno-missing-field-initializers
>>>> -Wno-sign-compare -Wno-format-nonliteral
>>>> -Wframe-larger-than=32768
>>>> -fstack-protector-all --param=ssp-buffer-size=4 -fexceptions
>>>> -fasynchronous-unwind-tables -fdiagnostics-show-option
>>>> -funit-at-a-time -Werror -Wno-aggregate-return -Wno-redundant-decls
>>>> -fipa-pure-const -Wlogical-op -Wpacked-bitfield-compat -Wsync-nand
>>>> -Wcoverage-mismatch -Wcpp -Wformat-contains-nul -Wnormalized=nfc
>>>> -Wsuggest-attribute=const -Wsuggest-attribute=noreturn
>>>> -Wsuggest-attribute=pure -Wtrampolines -Wjump-misses-init
>>>> -Wno-suggest-attribute=pure -Wno-suggest-attribute=const
>>>> -U_FORTIFY_SOURCE
>>>> -D_FORTIFY_SOURCE=2
>>>> -Wstrict-overflow=5 -I../include -D_GNU_SOURCE
>>>> -DNO_ANDROID_BACKEND   -c -o booleans.o booleans.c
>>>> booleans.c: In function ‘security_get_boolean_names’:
>>>> booleans.c:39:5: error: assuming signed overflow does not occur when
>>>> changing X +- C1 cmp C2 to X cmp C2 -+ C1 [-Werror=strict-overflow]
>>>>     39 | int security_get_boolean_names(char ***names, int *len)
>>>>        |     ^~~~~~~~~~~~~~~~~~~~~~~~~~
>>>> cc1: all warnings being treated as errors
>>>
>>> This one is really weird... Perhaps a bug in GCC? At the very least
>>> the warning message and source code location are super confusing,
>>> which is a bug on its own...
>>
>> It's detected only with -Wstrict-overflow=3 and higher. Makefile in libselinux uses
>> level 5 which was added by commit
>> 9fe430345 ("Makefile: add -Wstrict-overflow=5 to CFLAGS)
>>
>> The problem code is on lines 84 and 85 in
>> libselinux/src/booleans.c:
>>
>> 84:	for (--i; i >= 0; --i)
>> 85:    free(n[i]);
>>
>>
>> It could be suppressed by something like this:
>>
>> --- a/libselinux/src/booleans.c
>> +++ b/libselinux/src/booleans.c
>> @@ -39,7 +39,7 @@ static int filename_select(const struct dirent
>> *d)
>>   int security_get_boolean_names(char ***names, int *len)  {
>>          char path[PATH_MAX];
>> -       int i, rc;
>> +       int i, j, rc;
>>          struct dirent **namelist;
>>          char **n;
>>
>> @@ -81,8 +81,8 @@ int security_get_boolean_names(char ***names, int *len)
>>          free(namelist);
>>          return rc;
>>         bad_freen:
>> -       for (--i; i >= 0; --i)
>> -               free(n[i]);
>> +       for (j = 0; j < i; j++)
>> +               free(n[j]);
>>          free(n);
>>         bad:
>>          goto out;
>>
>>
>> William, what would you consider to be the right fix in this case?
> 
> The previous code looks correct IMO, I can't see an actual problem. Looks like
> GCC complaining incorrectly or were missing something. In the case of gcc
> Incorrectly complaining I usually take a course of action to work around it, but
> Im not sure how other maintainers feel about that @sds anything?

AFAICS, the code is correct as is.  Not a fan of rewriting code to 
appease overly zealous compilers...


