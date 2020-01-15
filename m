Return-Path: <SRS0=JZpt=3E=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94407C33CB1
	for <selinux@archiver.kernel.org>; Wed, 15 Jan 2020 15:41:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53D0F2053B
	for <selinux@archiver.kernel.org>; Wed, 15 Jan 2020 15:41:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="lZbQ+xra"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726566AbgAOPli (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 15 Jan 2020 10:41:38 -0500
Received: from UPDC19PA19.eemsg.mail.mil ([214.24.27.194]:64886 "EHLO
        UPDC19PA19.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726132AbgAOPli (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 15 Jan 2020 10:41:38 -0500
X-EEMSG-check-017: 45965506|UPDC19PA19_ESA_OUT01.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.70,322,1574121600"; 
   d="scan'208";a="45965506"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by UPDC19PA19.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 15 Jan 2020 15:41:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1579102893; x=1610638893;
  h=subject:from:to:cc:references:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=/39wwLgj7JsPwYlkvaFWgyq5seF5g62wCJkkHut2fRE=;
  b=lZbQ+xracwFthsH5eptVe3SOs3AuwmTpKGuTMmMqTvptU3XOK0zm0kt5
   B4/9MhwIyGekfDQJJxrJeZvfP/1woaBIG4LtBn6d/Hm1ap6sNWrtTzSTH
   ecuqnVmMv3QmlgFS4w4C1isO90rc8+rz5Sd7pIxVkjt65LmDebOEn10EV
   m894aEXgNrjDGYXtMxFBxVah/jbuNlowzT/Qa8fCX1rvgeYVrfKESeMSn
   ZYw/O4XikqKDfNoU/AixKCnkjzfaUJ7I5B10xFMtCnr80RWdMT7GYsW/d
   a0V/uH2sViNyxzVrjx+iNMnrO2Mp52yYBI/kZ1R2SxWRNJ0ExQbsQw8Z9
   A==;
X-IronPort-AV: E=Sophos;i="5.70,322,1574121600"; 
   d="scan'208";a="37812765"
IronPort-PHdr: =?us-ascii?q?9a23=3A/3tfMxU6kw7I2tGMuzL7xomEVgPV8LGtZVwlr6?=
 =?us-ascii?q?E/grcLSJyIuqrYZRCDtadThVPEFb/W9+hDw7KP9fy5BSpYut3e7DhCKMUKC0?=
 =?us-ascii?q?Zez51O3kQJO42sMQXDNvnkbig3ToxpdWRO2DWFC3VTA9v0fFbIo3e/vnY4Ex?=
 =?us-ascii?q?T7MhdpdKyuQtaBx8u42Pqv9JLNfg5GmCSyYa9oLBWxsA7dqtQajZFtJ6osxR?=
 =?us-ascii?q?bFuGdEdupZyW5qKl+YghLw6tut8JJ5/Clcpvws+9RcXanmeqgzUKBVAikhP2?=
 =?us-ascii?q?0p/sPgqAPNTRGI5nsSU2UWlgRHDg3Y5xzkXZn/rzX3uPNl1CaVIcP5Q7Y0WS?=
 =?us-ascii?q?+/76hwUx/nlD0HNz8i/27JjMF7kb9Wrwigpxx7xI7UfZ2VOf9jda7TYd8WWW?=
 =?us-ascii?q?xMVdtKWidfHo2zcZcAD+sZPeZZsYb9oUcOrQCjDgWoHe/j1yNEimPz0aA83e?=
 =?us-ascii?q?shCwXG1xE+EdwIvnrfsdH5OL4SXO2xyaXFyyjIYfFL1jfn8IXGbxAvr++CXb?=
 =?us-ascii?q?xzf8Tex0YgGAHZgVufsoHlIzCY2/4Rv2SH4edtV+SigHMnpQFrpTivw98hhJ?=
 =?us-ascii?q?TVho0L0lDE9Tt2wIAoLtOlTU50e9qkEJ9OuCCaKoB7RdgiTHxzuCsh1r0HuY?=
 =?us-ascii?q?K0fCgNyJg9wR7fcOaIf5KH4hLkSuacODF1j29mdrKnnxu+7Eetx+LmWsS0zV?=
 =?us-ascii?q?pGtDRJn9bSunwXyhDe7NWMROFn8Ue7wzmP0hje6uRDIU8pi6XWM4Uhwrsslp?=
 =?us-ascii?q?oLtkTDAzP2lF32jKCIckUk/fCl6/j9bbX8p5+cKpR0hhv/MqQolMy/Bv84PR?=
 =?us-ascii?q?YSUGSB5eS91KHs/U3+QLlQiP05jrLZv4zAKcQep665BxdZ0ocl6xmhEzeryM?=
 =?us-ascii?q?kUkHYIIV5feB+LkpLlN0/BLfzmF/uznkygkDJxyPDHOr3hDI/NLn/GkLr5Zr?=
 =?us-ascii?q?Zy9lVcxREvzdFf+51UCrYBLOj1Wk/qrtPUFBA5Mwuqw+r/EtVyypseWX6TAq?=
 =?us-ascii?q?+eKK7Tv0GH5uQvI+mRZY8Yozn9KvYg5/H0jH85nUURfaan3JsKcny3AOlpI1?=
 =?us-ascii?q?iBa3r2ntgBCXsKvhY5TOHyil2CVj5TZ3CoU6I+4TE7CJipDYHYRo+zhryMxz?=
 =?us-ascii?q?u0EYdQZmBBDFCMEGvneJ+AW/sWdC2SJcphmCQeVbe9U48hyQ2utAjixrV7NO?=
 =?us-ascii?q?XU4TMXtJL42dhu++LTlQs99SF6D8SZzW6NVXh4kX8SSDMswK9/pkl9wE+Z0a?=
 =?us-ascii?q?dkm/xYCcBT5/RRXwgmL5Hc1PJ1CtDoVgLaYtiJSEypQsioATE1UN0x2cQDY0?=
 =?us-ascii?q?d7G9W+kB/D2zCmDKMSl7yOHJY06L7T32DtJ8ZhzHbLzKshj1whQstVL22mh7?=
 =?us-ascii?q?V/+hPVB4HTlkWWiaeqeb4b3C7X+2eJ1XCOs11AUA5sTaXFWmgSZk/XrdT/+0?=
 =?us-ascii?q?PDQKaiCa85PQRd1M6CMKpKasHpjFlfQffjP8nRY3+1m2iuHhuI2LyMY5Twe2?=
 =?us-ascii?q?kH3yXSFlIEkwYN8naCLwQ+AT2ho23GBjx0CV3ve1/s8fV5qH6jVU870QWKb0?=
 =?us-ascii?q?xn17qo9R8YnuKcS/wN0bIeoishqCt7HEy7393ID9qMvQ1hfL9TYdkl+ldIyX?=
 =?us-ascii?q?rZtxBhPpynN61ihUARfBpsv0zy0BV3DYZAnNM2o3Mq1gpyLqeY0FJcdzOdx5?=
 =?us-ascii?q?zwPafXKmbq9hC1d6HWwk3e0MqR+qoX8PQ3tVPjvA60Fkoj9XVrytpV3GWG5p?=
 =?us-ascii?q?XMEgUSVYn8Ukcu+xh+oLHafDcy65nP1XJ2Mqm0ryXC1MgzCOsj1BmsZdVfML?=
 =?us-ascii?q?ucHg/oD8IaH9SuKPAtm1WxdhILJv1S9KovMsO+bfSGxaqrMP9lnDKhimRH+p?=
 =?us-ascii?q?5y3liQ+Cp7T+6bl6oCls6V2AuaVn/OjF6nvYijho1CZSwTNmWgzCHlAMheeb?=
 =?us-ascii?q?A0cIoWXzSAOcqyk+5iiobtVngQz1uqA1cLyYf9YhaJR0Ds1g1Xk0IMqDqonj?=
 =?us-ascii?q?XunG88qC0gsqfKhH+G+O/lbhdSfzcWFWQ=3D?=
X-IPAS-Result: =?us-ascii?q?A2DcAwDtMR9e/wHyM5BkDg4BAQEBAQcBAREBBAQBAYF7g?=
 =?us-ascii?q?X2BbAEgEiqED4kDhlwGgTeJbpFJCQEBAQEBAQEBATcBAYRAAoIjOBMCEAEBA?=
 =?us-ascii?q?QQBAQEBAQUDAQFshUOCOykBgnoBBSMPAQVBEAkCGAICIwMCAkYRBg0GAgEBg?=
 =?us-ascii?q?mM/glclikabdIEyiRGBPoEOKIwyeYEHgTgPgi8uPoQDH4M3gl4EjUWCTIdfl?=
 =?us-ascii?q?1SCQoJJk2EGG4JHiAOERItgq20igVgrCAIYCCEPgydQGA2IDReNaFkjAzCLH?=
 =?us-ascii?q?REXghsBAQ?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 15 Jan 2020 15:41:31 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id 00FFem4N103813;
        Wed, 15 Jan 2020 10:40:48 -0500
Subject: Re: Perf Data on LSM in v5.3
From:   Stephen Smalley <sds@tycho.nsa.gov>
To:     Wenhui Zhang <wenhui@gwmail.gwu.edu>
Cc:     John Johansen <john.johansen@canonical.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Casey Schaufler <casey.schaufler@intel.com>,
        James Morris <jmorris@namei.org>,
        linux-security-module@vger.kernel.org,
        SELinux <selinux@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        penguin-kernel@i-love.sakura.ne.jp,
        Paul Moore <paul@paul-moore.com>
References: <CAOSEQ1poqrUQdRc+ZLNbEoPqgd4MMomeYmefjca_mj-2zxrdUA@mail.gmail.com>
 <7ebd42d8-5392-90f6-fc08-4364176cfbb6@schaufler-ca.com>
 <CAOSEQ1p0q4gxVwN3MJkP=xxn4GUVaKsaArtQpxNy5rv7vYvVVw@mail.gmail.com>
 <abd4dddb-8968-2655-3d80-ce446451b3de@canonical.com>
 <CAOSEQ1rBu+wRzgk_Jh2RsZpf8Lv1+WUi-Pte-EsBMphnEr4SsQ@mail.gmail.com>
 <e7cfc960-32fb-7712-b21c-37999cf29430@tycho.nsa.gov>
 <2a984c76-a499-53f6-68c5-5d3604094ba4@tycho.nsa.gov>
 <CAOSEQ1o3nhY-svtsFSSv+M=V+NchxmBbhY-FvqoTzJgMnZ1ydw@mail.gmail.com>
 <1479ac1a-b957-f907-b983-c0bcefd51457@tycho.nsa.gov>
Message-ID: <fe62d7a7-5f7c-cb14-01b1-f3d7fef2862b@tycho.nsa.gov>
Date:   Wed, 15 Jan 2020 10:42:17 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <1479ac1a-b957-f907-b983-c0bcefd51457@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 1/15/20 10:34 AM, Stephen Smalley wrote:
> On 1/15/20 10:21 AM, Wenhui Zhang wrote:
>>
>> On Wed, Jan 15, 2020 at 9:08 AM Stephen Smalley <sds@tycho.nsa.gov 
>> <mailto:sds@tycho.nsa.gov>> wrote:
>>
>>     On 1/15/20 8:40 AM, Stephen Smalley wrote:
>>      > On 1/14/20 8:00 PM, Wenhui Zhang wrote:
>>      >> Hi, John:
>>      >>
>>      >> It seems like, the MAC hooks are default to*return 0 or empty 
>> void
>>      >> hooks* if CONFIG_SECURITY, CONFIG_SECURITY_NETWORK ,
>>      >> CONFIG_PAGE_TABLE_ISOLATION, CONFIG_SECURITY_INFINIBAND,
>>      >> CONFIG_SECURITY_PATH, CONFIG_INTEL_TXT,
>>      >> CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR,
>>      >> CONFIG_HARDENED_USERCOPY, CONFIG_HARDENED_USERCOPY_FALLBACK *are
>>     NOT
>>      >> set*.
>>      >>
>>      >> If HOOKs are "return 0 or empty void hooks", MAC is not enabled.
>>      >> In runtime of fs-benchmarks, if CONFIG_DEFAULT_SECURITY_DAC=y, 
>> then
>>      >> capability is enabled.
>>      >>
>>      >> Please correct me if I am wrong.
>>      >>
>>      >> For the first test, wo-sec is tested with:
>>      >> # CONFIG_SECURITY_DMESG_RESTRICT is not set
>>      >> # CONFIG_SECURITY is not set
>>      >> # CONFIG_SECURITYFS is not set
>>      >> # CONFIG_PAGE_TABLE_ISOLATION is not set
>>      >> # CONFIG_INTEL_TXT is not set
>>      >> CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR=y
>>      >> # CONFIG_HARDENED_USERCOPY is not set
>>      >> CONFIG_FORTIFY_SOURCE=y
>>      >> # CONFIG_STATIC_USERMODEHELPER is not set
>>      >> CONFIG_DEFAULT_SECURITY_DAC=y
>>      >>
>>      >>
>>      >> For the second test, w-sec is tested with:
>>      >> # CONFIG_SECURITY_DMESG_RESTRICT is not set
>>      >> CONFIG_SECURITY=y
>>      >> CONFIG_SECURITYFS=y
>>      >> # CONFIG_SECURITY_NETWORK is not set
>>      >> CONFIG_PAGE_TABLE_ISOLATION=y
>>      >> CONFIG_SECURITY_INFINIBAND=y
>>      >> CONFIG_SECURITY_PATH=y
>>      >> CONFIG_INTEL_TXT=y
>>      >> CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR=y
>>      >> CONFIG_HARDENED_USERCOPY=y
>>      >> CONFIG_HARDENED_USERCOPY_FALLBACK=y
>>      >> # CONFIG_HARDENED_USERCOPY_PAGESPAN is not set
>>      >> CONFIG_FORTIFY_SOURCE=y
>>      >> # CONFIG_STATIC_USERMODEHELPER is not set
>>      >> # CONFIG_SECURITY_SMACK is not set
>>      >> # CONFIG_SECURITY_TOMOYO is not set
>>      >> # CONFIG_SECURITY_APPARMOR is not set
>>      >> # CONFIG_SECURITY_LOADPIN is not set
>>      >> # CONFIG_SECURITY_YAMA is not set
>>      >> # CONFIG_SECURITY_SAFESETID is not set
>>      >> # CONFIG_INTEGRITY is not set
>>      >> CONFIG_DEFAULT_SECURITY_DAC=y
>>      >> #
>>      >>
>>     
>> CONFIG_LSM="yama,loadpin,safesetid,integrity,apparmor,selinux,smack,tomoyo" 
>>
>>
>>      >>
>>      >
>>      > Your configs should only differ with respect to CONFIG_SECURITY*
>>     if you
>>      > want to evaluate LSM, SELinux, etc overheads.  
>> PAGE_TABLE_ISOLATION,
>>      > INTEL_TXT, and HARDENED_USERCOPY are not relevant to LSM itself.
>>      >
>>      > Also, what benchmarks are you using?  Your own home-grown ones, a
>>     set of
>>      > open source standard benchmarks (if so, which ones?).  You should
>>      > include both micro and macro benchmarks in your suite.
>>      >
>>      > How stable are your results?  What kind of variance / standard
>>     deviation
>>      > are you seeing?
>>      >
>>      > It is hard to get meaningful, reliable performance measurements
>>     so going
>>      > down this road is not to be done lightly.
>>
>>     Also, I note that you don't enable CONFIG_SECURITY_NETWORK above.  
>> That
>>     means you aren't including the base LSM overhead for the networking
>>     security hooks.  So if you then compare that against SELinux (which
>>     requires CONFIG_SECURITY_NETWORK), you are going to end up 
>> attributing
>>     the cost of both the LSM overhead and SELinux overhead all to 
>> SELinux.
>>     If you truly want to isolate the base LSM overhead, you need to 
>> enable
>>     all the hooks.
>>
>> I will give it a try for enabling CONFIG_SECURITY_NETWORK later this 
>> week, however I wonder if this would affect the test results that much.
>> I am testing with LMBench 2.5 , with focusing on filesystem unit 
>> tests, however not network stack at this time.
>> My understanding of why this result is so different from previous 
>> paper 20 years ago, is that the Bottleneck changes.
>> As Chris was testing with 4 cores , each 700MHz CPU, and 128MB memory, 
>> with HDD (latency is about 20,000,000 ns for sequential read).
>> The  Bottleneck of accessing files w/ MAC are mostly on I/O.
>> However hardware setup is different now,  we have much larger and 
>> faster memory (better prefetching as well), with SSD (latency is about 
>> 49,000 ns for sequential read). , while CPU speed is not increasing as 
>> much as that of I/O.
>> The Bottleneck of accessing files w/ MAC are mostly on CPU now.
> 
> Don't know if lmbench is still a good benchmark and I recall struggling 
> with it even back then to get stable results.
> 
> Could be bottleneck changes, could be the fact that your kernel config 
> changes aren't limited to CONFIG_SECURITY* (e.g. PTI introduces 
> non-trivial overheads), could be changes to LSM since that time (e.g. 
> stacking support, moving security_ calls out-of-line, more hooks, ...), 
> could be that running SELinux w/o policy is flooding the system logs 
> with warnings or other messages since it wasn't really designed to be 
> used that way past initialization.  Lots of options, can't tell without 
> more info on your details.

I'd think that these days one would leverage perf and/or lkp for Linux 
kernel performance measurements, not lmbench.


