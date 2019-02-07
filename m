Return-Path: <SRS0=93oN=QO=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64714C282C2
	for <selinux@archiver.kernel.org>; Thu,  7 Feb 2019 18:22:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B5952086C
	for <selinux@archiver.kernel.org>; Thu,  7 Feb 2019 18:22:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="JFzrO7ED"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726775AbfBGSWB (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 7 Feb 2019 13:22:01 -0500
Received: from ucol19pa13.eemsg.mail.mil ([214.24.24.86]:51874 "EHLO
        ucol19pa13.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726401AbfBGSWB (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 7 Feb 2019 13:22:01 -0500
X-EEMSG-check-017: 675726531|UCOL19PA13_EEMSG_MP11.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.39,1,1493683200"; 
   d="scan'208";a="675726531"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by ucol19pa13.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 07 Feb 2019 18:21:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1549563674; x=1581099674;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=dZZnU7q6AiT5gCwZHxwhgbPSpa2rGb9XVigwJ90ORGU=;
  b=JFzrO7ED7aNonclczyAMtbPf4UeFrBxfaEUZrQAOUSuuXjiH4qXxMIiY
   Ge2bOaFNOGMHZLhwTZFKcCqg77laGLqUh5YuFgbxICNs5qNRlaW+YC+5Y
   TPcwuyUGIDtJxPCDFP2ub8yjXr+348iy1x9OV4ELGDaDJjA0MMDQF2sya
   PnfMyuVBaNPmU55wEZG07lKWZRbFEMizddTxDC6P8wP0qSGbpuvH9rSIF
   em0B8T5ekLRUVx1hVqOgWPwaNQZZO2NK2mC3cf4h8eCmV++v4xSSkHI3u
   fdrW90fzQavm48lXs/lCe6wkkFrnQcxHAbIkk/iIq/6Bz2/0nXFiUeMQ7
   Q==;
X-IronPort-AV: E=Sophos;i="5.58,345,1544486400"; 
   d="scan'208";a="23639748"
IronPort-PHdr: =?us-ascii?q?9a23=3AEFjWVx/OYD0F0P9uRHKM819IXTAuvvDOBiVQ1K?=
 =?us-ascii?q?B+0+IWIJqq85mqBkHD//Il1AaPAd2Lraocw8Pt8InYEVQa5piAtH1QOLdtbD?=
 =?us-ascii?q?Qizfssogo7HcSeAlf6JvO5JwYzHcBFSUM3tyrjaRsdF8nxfUDdrWOv5jAOBB?=
 =?us-ascii?q?r/KRB1JuPoEYLOksi7ze+/94HQbglSmDaxfa55IQmrownWqsQYm5ZpJLwryh?=
 =?us-ascii?q?vOrHtIeuBWyn1tKFmOgRvy5dq+8YB6/ShItP0v68BPUaPhf6QlVrNYFygpM3?=
 =?us-ascii?q?o05MLwqxbOSxaE62YGXWUXlhpIBBXF7A3/U5zsvCb2qvZx1S+HNsDtU7s6RS?=
 =?us-ascii?q?qt4LtqSB/wiScIKTg58H3MisdtiK5XuQ+tqwBjz4LRZoyaOuB+fqfAdt0EQ2?=
 =?us-ascii?q?RPUNtaWyhYDo+ic4cDCuwMNvtaoYbgvVsDtQawCxeiBO3vyTFGiHH50qI43O?=
 =?us-ascii?q?s9Hg/LxxAgEtEUvXjIsNn4OqUfXOaox6fI1zXDaPZW1C/g5ojUbB8hufGMUq?=
 =?us-ascii?q?x2ccHM1EcvEhnKjlGUqYP7PzKey+MAs3OG4Op7Tu+vl24mpB1xojio3MssjJ?=
 =?us-ascii?q?LJiZgPxlDL8iV53p84KNulQ0B4ed6pCIZcui6VOodsQs4uXntktDg1x7EYo5?=
 =?us-ascii?q?K3YS4Hw4k9yRHFcfyIaY2I7wrmVOaWPDh3mmpoeKm6hxau6UigzfD8VtWs3F?=
 =?us-ascii?q?ZKsCVFlt7Mu2gR1xPJ8MiHS+Z9/ly71TaT1wHc9uFEIUcumardN5Eh2aI/mo?=
 =?us-ascii?q?AWsUTCGi/6gET2jKmIeUU44uWk9uvqb7r8qpKcKoN4kB/yP6swlsClHOg0Kg?=
 =?us-ascii?q?0OUHKa+eS42r3j50r5QLBSg/0tj6bZq4vXJdgbp6GlAw9V1Zwv6xCkDzi8yt?=
 =?us-ascii?q?gYkn4HLExddBKdk4fpI03OIOz/DfqnjVWskTNrx/THPrL7B5XBNGTMnK37fb?=
 =?us-ascii?q?Z68EFT1hAzzcxE559PC7EBJu7zVVH1tNDCEhA5NAm0yf79CNphzoMeRX6PAq?=
 =?us-ascii?q?iBPaPKtV+H/P8vI/WWZIAOojnwMOIl6ODzgn85g1AdYbOl0ocQaHC9Bv5mOV?=
 =?us-ascii?q?mWYWLwgtcdFmcHphE+Q/LuiF2DVz5TenmzUrki5jE0Fo2mF53PRoOzj7yb2i?=
 =?us-ascii?q?e0AJlWanpBClCWHnfib5+EVOsUaCKOPs9hlSQJVb+kS48mzhGushX1xKZ5Ie?=
 =?us-ascii?q?fP4C0Xq4/s1Nhv6O3Pjx096Tt0D8HOm12KGitOmWkFXSMtmOhAoEh5y16GmY?=
 =?us-ascii?q?Myy6hHFNhX5vpMFAx8L5nWwvZmEPjzXB7MepGCT1PwBp2eDC0rBvY43sMUaU?=
 =?us-ascii?q?92G532lhTKwjawCbY9jbGHBJUotKnb2i61b4xmxnLH0rQxp0cpT9EJNmC8gK?=
 =?us-ascii?q?N7sQ/JCMSBx16Uk6esaLQ0wiHA7iGAwHCIsUUeVxR/B/brR3caM3DKoMz560?=
 =?us-ascii?q?WKdLqnDbAqI0MV0sKZArdbYd3uy1NdTbHsP8qIMDH5oHu5GRvdnuDEV4HtYW?=
 =?us-ascii?q?hImXyHUEU=3D?=
X-IPAS-Result: =?us-ascii?q?A2BgAAC9dlxc/wHyM5BkGwEBAQEDAQEBBwMBAQGBVAMBA?=
 =?us-ascii?q?QELAYFaKYE4MieEA5QJUgaBCC2JNpBWOAGEQAKDKCI3Bg0BAwEBAQEBAQIBb?=
 =?us-ascii?q?CiCOikBgmYBAQEBAyMPAQVBDAQLEQQBAQECAiMDAgJGCQgGAQwGAgEBgmE/g?=
 =?us-ascii?q?XUNrSyBL4VEhGqBC4s4F3iBB4E4gmuICoJXApE7kVUJkj8GGZJVii2TUiKBV?=
 =?us-ascii?q?isIAhgIIQ+DJ5B7IQMwAYEEAQGNcwEB?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 07 Feb 2019 18:20:55 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto.infosec.tycho.ncsc.mil [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x17IKtgd006475;
        Thu, 7 Feb 2019 13:20:55 -0500
Subject: Re: gcc 9.0.0 build issues
To:     "Roberts, William C" <william.c.roberts@intel.com>,
        Petr Lautrbach <plautrba@redhat.com>,
        "selinux@vger.kernel.org" <selinux@vger.kernel.org>
Cc:     Ondrej Mosnacek <omosnace@redhat.com>
References: <pjdtvhns3pq.fsf@redhat.com>
 <CAFqZXNt8Df0KX9qVmsGtxZroy6s1SFBt1Qmi5Psuv6z0+kTB7Q@mail.gmail.com>
 <pjdlg2rydoj.fsf@redhat.com>
 <476DC76E7D1DF2438D32BFADF679FC5649CDF45F@ORSMSX101.amr.corp.intel.com>
 <3a9f2281-aad4-58fd-ab8e-cb99a8da0fae@tycho.nsa.gov>
 <476DC76E7D1DF2438D32BFADF679FC5649CDF4F5@ORSMSX101.amr.corp.intel.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <4a32cbaa-4dfa-e4e7-d113-fd03d6225554@tycho.nsa.gov>
Date:   Thu, 7 Feb 2019 13:20:55 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <476DC76E7D1DF2438D32BFADF679FC5649CDF4F5@ORSMSX101.amr.corp.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 2/7/19 1:18 PM, Roberts, William C wrote:
> 
> 
>> -----Original Message-----
>> From: Stephen Smalley [mailto:sds@tycho.nsa.gov]
>> Sent: Thursday, February 7, 2019 10:17 AM
>> To: Roberts, William C <william.c.roberts@intel.com>; Petr Lautrbach
>> <plautrba@redhat.com>; selinux@vger.kernel.org
>> Cc: Ondrej Mosnacek <omosnace@redhat.com>
>> Subject: Re: gcc 9.0.0 build issues
>>
>> On 2/7/19 12:52 PM, Roberts, William C wrote:
>>>
>>>
>>>> -----Original Message-----
>>>> From: Petr Lautrbach [mailto:plautrba@redhat.com]
>>>> Sent: Thursday, February 7, 2019 4:40 AM
>>>> To: selinux@vger.kernel.org
>>>> Cc: Petr Lautrbach <plautrba@redhat.com>; Roberts, William C
>>>> <william.c.roberts@intel.com>; Ondrej Mosnacek <omosnace@redhat.com>
>>>> Subject: Re: gcc 9.0.0 build issues
>>>>
>>>>
>>>> Ondrej Mosnacek <omosnace@redhat.com> writes:
>>>>
>>>>> On Fri, Feb 1, 2019 at 8:36 PM Petr Lautrbach <plautrba@redhat.com>
>>>>> wrote:
>>>>>> gcc-9.0.0-0.3.fc30.x86_64 from Fedora Rawhide:
>>>>>>
>>>>>> gcc version 9.0.0 20190119 (Red Hat 9.0.0-0.3) (GCC)
>>>>>>
>>>> ...
>>>>>> When libselinux is built separately, other CFLAGS is used:
>>>>>>
>>>>>> $ cd libselinux
>>>>>>
>>>>>> $ make DESTDIR=~/obj install install-pywrap ...
>>>>>>
>>>>>> make[1]: Entering directory
>>>>>> '/home/build/SELinuxProject-selinux/libselinux/src'
>>>>>>
>>>>>> cc -O -Wall -W -Wundef -Wformat-y2k -Wformat-security -Winit-self
>>>>>> -Wmissing-include-dirs -Wunused -Wunknown-pragmas -Wstrict-aliasing
>>>>>> -Wshadow -Wpointer-arith -Wbad-function-cast -Wcast-align
>>>>>> -Wwrite-strings -Waggregate-return -Wstrict-prototypes
>>>>>> -Wold-style-definition -Wmissing-prototypes -Wmissing-declarations
>>>>>> -Wmissing-noreturn -Wmissing-format-attribute -Wredundant-decls
>>>>>> -Wnested-externs -Winline -Winvalid-pch -Wvolatile-register-var
>>>>>> -Wdisabled-optimization -Wbuiltin-macro-redefined -Wattributes
>>>>>> -Wmultichar -Wdeprecated-declarations -Wdiv-by-zero
>>>>>> -Wdouble-promotion -Wendif-labels -Wextra -Wformat-extra-args
>>>>>> -Wformat-zero-length -Wformat=2 -Wmultichar -Woverflow
>>>>>> -Wpointer-to-int-cast -Wpragmas -Wno-missing-field-initializers
>>>>>> -Wno-sign-compare -Wno-format-nonliteral
>>>>>> -Wframe-larger-than=32768
>>>>>> -fstack-protector-all --param=ssp-buffer-size=4 -fexceptions
>>>>>> -fasynchronous-unwind-tables -fdiagnostics-show-option
>>>>>> -funit-at-a-time -Werror -Wno-aggregate-return -Wno-redundant-decls
>>>>>> -fipa-pure-const -Wlogical-op -Wpacked-bitfield-compat -Wsync-nand
>>>>>> -Wcoverage-mismatch -Wcpp -Wformat-contains-nul -Wnormalized=nfc
>>>>>> -Wsuggest-attribute=const -Wsuggest-attribute=noreturn
>>>>>> -Wsuggest-attribute=pure -Wtrampolines -Wjump-misses-init
>>>>>> -Wno-suggest-attribute=pure -Wno-suggest-attribute=const
>>>>>> -U_FORTIFY_SOURCE
>>>>>> -D_FORTIFY_SOURCE=2
>>>>>> -Wstrict-overflow=5 -I../include -D_GNU_SOURCE
>>>>>> -DNO_ANDROID_BACKEND   -c -o booleans.o booleans.c
>>>>>> booleans.c: In function ‘security_get_boolean_names’:
>>>>>> booleans.c:39:5: error: assuming signed overflow does not occur
>>>>>> when changing X +- C1 cmp C2 to X cmp C2 -+ C1 [-Werror=strict-overflow]
>>>>>>      39 | int security_get_boolean_names(char ***names, int *len)
>>>>>>         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~
>>>>>> cc1: all warnings being treated as errors
>>>>>
>>>>> This one is really weird... Perhaps a bug in GCC? At the very least
>>>>> the warning message and source code location are super confusing,
>>>>> which is a bug on its own...
>>>>
>>>> It's detected only with -Wstrict-overflow=3 and higher. Makefile in
>>>> libselinux uses level 5 which was added by commit
>>>> 9fe430345 ("Makefile: add -Wstrict-overflow=5 to CFLAGS)
>>>>
>>>> The problem code is on lines 84 and 85 in
>>>> libselinux/src/booleans.c:
>>>>
>>>> 84:	for (--i; i >= 0; --i)
>>>> 85:    free(n[i]);
>>>>
>>>>
>>>> It could be suppressed by something like this:
>>>>
>>>> --- a/libselinux/src/booleans.c
>>>> +++ b/libselinux/src/booleans.c
>>>> @@ -39,7 +39,7 @@ static int filename_select(const struct dirent
>>>> *d)
>>>>    int security_get_boolean_names(char ***names, int *len)  {
>>>>           char path[PATH_MAX];
>>>> -       int i, rc;
>>>> +       int i, j, rc;
>>>>           struct dirent **namelist;
>>>>           char **n;
>>>>
>>>> @@ -81,8 +81,8 @@ int security_get_boolean_names(char ***names, int
>> *len)
>>>>           free(namelist);
>>>>           return rc;
>>>>          bad_freen:
>>>> -       for (--i; i >= 0; --i)
>>>> -               free(n[i]);
>>>> +       for (j = 0; j < i; j++)
>>>> +               free(n[j]);
>>>>           free(n);
>>>>          bad:
>>>>           goto out;
>>>>
>>>>
>>>> William, what would you consider to be the right fix in this case?
>>>
>>> The previous code looks correct IMO, I can't see an actual problem.
>>> Looks like GCC complaining incorrectly or were missing something. In
>>> the case of gcc Incorrectly complaining I usually take a course of
>>> action to work around it, but Im not sure how other maintainers feel about that
>> @sds anything?
>>
>> AFAICS, the code is correct as is.  Not a fan of rewriting code to appease overly
>> zealous compilers...
>>
> I guess whomever is building can override CFLAGS and drop the value down. We should
> Probably file a bug with gcc?

Yes, that would be helpful if someone could do that.


