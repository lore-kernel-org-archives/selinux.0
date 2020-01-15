Return-Path: <SRS0=JZpt=3E=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C54A7C33CB1
	for <selinux@archiver.kernel.org>; Wed, 15 Jan 2020 15:54:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 934102187F
	for <selinux@archiver.kernel.org>; Wed, 15 Jan 2020 15:54:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="K9W1MTXA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728982AbgAOPyB (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 15 Jan 2020 10:54:01 -0500
Received: from USAT19PA25.eemsg.mail.mil ([214.24.22.199]:56618 "EHLO
        USAT19PA25.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726574AbgAOPyA (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 15 Jan 2020 10:54:00 -0500
X-EEMSG-check-017: 69981850|USAT19PA25_ESA_OUT06.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.70,323,1574121600"; 
   d="scan'208";a="69981850"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by USAT19PA25.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 15 Jan 2020 15:33:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1579102422; x=1610638422;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=WUGWphAeSZBwi4cuTVhp3wQF0Tp2xsIJMPVJYMBn4vM=;
  b=K9W1MTXA5q29iBJrtJVIESo/LvZdvv85ImzoP9Mi33RlHhvH3jtgeouJ
   JLlq2KlXPjaZ9O9pctN554n+IFeLiymm2rOPlmAdYm6yvXHGyWpViOeXM
   Etak+QpT/8++65NQA7h7L8PUt9OAPZy45LzqF8iOdgbFHiIvwFOrWbU5n
   sWzU5THptR4ceamy0xmRrj+/NKDX2Ns+5gjvmmUCEDbhxWUNhdfWFaxRg
   Kv1Wi6IzI2GydkmOuRg4nkrbn5UDFSFp9lKFJzCgDOKENOy2on1XP43zr
   fAT8c4uterlhoTgfVRGknCvb5SSPGfJd2Km61JZerPhhFhj4hgO+KXpxY
   g==;
X-IronPort-AV: E=Sophos;i="5.70,322,1574121600"; 
   d="scan'208";a="31980805"
IronPort-PHdr: =?us-ascii?q?9a23=3AD25W1B3FW5UkoyDhsmDT+DRfVm0co7zxezQtwd?=
 =?us-ascii?q?8ZsesSLvTxwZ3uMQTl6Ol3ixeRBMOHsq4C07Gd7PyoGTRZp8rY6zZaKN0Efi?=
 =?us-ascii?q?RGoP1epxYnDs+BBB+zB9/RRAt+Iv5/UkR49WqwK0lfFZW2TVTTpnqv8WxaQU?=
 =?us-ascii?q?2nZkJ6KevvB4Hdkdm82fys9J3PeQVIgye2ba9vIBmsogjdq8YbjZF+Jqs/xR?=
 =?us-ascii?q?fEoHRFcPlSyW90OF6fhRnx6tq+8ZJ57yhcp/ct/NNcXKvneKg1UaZWByk8PW?=
 =?us-ascii?q?Av483ruxjDTQ+R6XYZT24bjBlGDRXb4R/jRpv+vTf0ueR72CmBIM35Vqs0Vi?=
 =?us-ascii?q?i476dqUxDnliEKPCMk/W7Ni8xwiKVboA+9pxF63oXZbp2ZOOZ4c6jAZt4RW3?=
 =?us-ascii?q?ZPUdhNWCxAGoO8bpUAD+wdPeZDsoLxo0ICoQaiCQWwAe/izDFHhmXy3aYnze?=
 =?us-ascii?q?ovFw/I1xEkE94XsHnZqND5OaEPWu630abI1y3OYe5I1zfz6IbGcR4vrv+DUr?=
 =?us-ascii?q?1ybcXfxlIiFx/Gg1iKtYDpIz2Y2+YLvmOG7+RgT+Wvi2s/pg9svjig2N8sio?=
 =?us-ascii?q?nXiYIT11vK6CB5z5wxJd28VkF6YcOvHZxLty6HLIt7Wd8iQmF0tyY6zb0Ko5?=
 =?us-ascii?q?i7fDMQx5g9yB7fbOKHfpGO7xn+V+iROS91iG9qdb+wnRq/8VWsxvfiWsS7zl?=
 =?us-ascii?q?pGtDdJn9/RvX4XzRPT8NKISv5l80ek3jaAyh7c5/lfIUAxiarbM5khwqMslp?=
 =?us-ascii?q?YLsUTMACv2mELuga+KbEok4Omo6/n8Yrn8p5+cMYF0igblMqswhsOzG/g4Mw?=
 =?us-ascii?q?gSUGib/uSwzrvj8lHiQLpWlPE2l6jZsJTCKcQaoK62HRNV354+5xuwADqqyt?=
 =?us-ascii?q?QVkWQdIF5bdx+LkZLlN0zWLPD9F/i/glCskDlxx/DBO73sGo7NIWXYkLr6Yb?=
 =?us-ascii?q?Z861JTyAo0zdxF4ZJUEasOLOj8Wk/2qtzUFgU5PBCsw+b7FNV90ZsTWGyRDa?=
 =?us-ascii?q?+fMKPSrF6I6/kgI+iCYY8aojf9K/w/6/7hg345hEURcre00psKcHq4BOhpI1?=
 =?us-ascii?q?2FYXrwhdcMCWUKvg0+TOzsklGCUzlTZ3aoUKI6/TE0FoSmAJzfSY+3hryB2y?=
 =?us-ascii?q?G7HpxKaW9cDlCAC2vnd4KBW/0UciKdPtdhkiAYVbimU4IuyQuhtBTkxLtnNe?=
 =?us-ascii?q?fU4TEXtZL529ho6e3TkQ899SZtA8uByW6BVX17nmQNRzUuxqBwvVR9ykuf0a?=
 =?us-ascii?q?h/m/FXCcZc5+hXXQY6L5Lc1PB1C9DoVQLccNeJTEipQs+9DDEwSNIx38EBY0?=
 =?us-ascii?q?JnF9q+iRDD2jKgA6UJmLyTGJw07qXc0mDzJ8Z4zHbGzrMhj1g9QsZUM22pnK?=
 =?us-ascii?q?t/+BbSB4LTlEWZjamqf7wG3CHR7GeD0XaOvEZAXQ50UKXFW20fZ0TPodTi+E?=
 =?us-ascii?q?zNU6KuCa4mMgtdyc+OM65Katr0glVbQPfsJs/TY3y+m2iuHxaE3LCMY5Twe2?=
 =?us-ascii?q?UbwirdDFIIkwcJ/XaJLQI+HDuuo3rCDDxyElLie1js/vd6qHO6SE800g6LYl?=
 =?us-ascii?q?Z/17q65BEVn+aQS/AN0bIevicutTF0EEy639LMBNqKvxBhc7lEYdMh/FdH0n?=
 =?us-ascii?q?rUtw9jMZO+NKBtmlkecwN0v071yxp3Cp9Akc8vrHMr0QpyLLiU0FRbdzOXxZ?=
 =?us-ascii?q?rwIKHYKnHu/BCzbK7bwkne38iQ+qcA9fQ4qlPjsBiqFkU86XVn1cda03+H65?=
 =?us-ascii?q?XLFQYSVZXxUlgp+BRgvLHVeCo9557O1XJ2K6W0tCHN18grBOs90hygZctQML?=
 =?us-ascii?q?uYFA/uFM0XH9CuJ/Y3m1itdR8EJPpd9LMwP8+/cvuG36mrPPx+kz68kWtH54?=
 =?us-ascii?q?V9gQqw8H9DR+jIwpdN8fGR2ATPAyjxile8s+j4hoVNZDVUEXWijyXoGdgCSL?=
 =?us-ascii?q?d1eNMwFWq2I8Cxju57jprpVm8QoEWvHHsaycSpflyUdFW70gpOgxdE6Ue7kD?=
 =?us-ascii?q?e1mmQn2woiqbCSiWmXnrXv?=
X-IPAS-Result: =?us-ascii?q?A2DcAwAMMB9e/wHyM5BkDg4BAQEBAQcBAREBBAQBAYF7g?=
 =?us-ascii?q?XgFgWwBIBIqhA+JA4ZcBoE3iW6RSQkBAQEBAQEBAQE3AQGEQAKCIzgTAhABA?=
 =?us-ascii?q?QEEAQEBAQEFAwEBbIVDgjspAYJ6AQUjDwEFQRALGAICIwMCAkYRBg0GAgEBg?=
 =?us-ascii?q?mM/glclpjuBMoVKg0yBPoEOKIwyeYEHgTgPgi8uPoQDH4M3gl4EjUWCTIdfl?=
 =?us-ascii?q?1SCQoJJk2EGG4JHiAOERItgq20igVgrCAIYCCEPgydQGA2IDReNaFkjAzCLH?=
 =?us-ascii?q?REXghsBAQ?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 15 Jan 2020 15:33:41 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id 00FFWr9o103673;
        Wed, 15 Jan 2020 10:32:54 -0500
Subject: Re: Perf Data on LSM in v5.3
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
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <1479ac1a-b957-f907-b983-c0bcefd51457@tycho.nsa.gov>
Date:   Wed, 15 Jan 2020 10:34:22 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <CAOSEQ1o3nhY-svtsFSSv+M=V+NchxmBbhY-FvqoTzJgMnZ1ydw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 1/15/20 10:21 AM, Wenhui Zhang wrote:
> 
> On Wed, Jan 15, 2020 at 9:08 AM Stephen Smalley <sds@tycho.nsa.gov 
> <mailto:sds@tycho.nsa.gov>> wrote:
> 
>     On 1/15/20 8:40 AM, Stephen Smalley wrote:
>      > On 1/14/20 8:00 PM, Wenhui Zhang wrote:
>      >> Hi, John:
>      >>
>      >> It seems like, the MAC hooks are default to*return 0 or empty void
>      >> hooks* if CONFIG_SECURITY, CONFIG_SECURITY_NETWORK ,
>      >> CONFIG_PAGE_TABLE_ISOLATION, CONFIG_SECURITY_INFINIBAND,
>      >> CONFIG_SECURITY_PATH, CONFIG_INTEL_TXT,
>      >> CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR,
>      >> CONFIG_HARDENED_USERCOPY, CONFIG_HARDENED_USERCOPY_FALLBACK *are
>     NOT
>      >> set*.
>      >>
>      >> If HOOKs are "return 0 or empty void hooks", MAC is not enabled.
>      >> In runtime of fs-benchmarks, if CONFIG_DEFAULT_SECURITY_DAC=y, then
>      >> capability is enabled.
>      >>
>      >> Please correct me if I am wrong.
>      >>
>      >> For the first test, wo-sec is tested with:
>      >> # CONFIG_SECURITY_DMESG_RESTRICT is not set
>      >> # CONFIG_SECURITY is not set
>      >> # CONFIG_SECURITYFS is not set
>      >> # CONFIG_PAGE_TABLE_ISOLATION is not set
>      >> # CONFIG_INTEL_TXT is not set
>      >> CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR=y
>      >> # CONFIG_HARDENED_USERCOPY is not set
>      >> CONFIG_FORTIFY_SOURCE=y
>      >> # CONFIG_STATIC_USERMODEHELPER is not set
>      >> CONFIG_DEFAULT_SECURITY_DAC=y
>      >>
>      >>
>      >> For the second test, w-sec is tested with:
>      >> # CONFIG_SECURITY_DMESG_RESTRICT is not set
>      >> CONFIG_SECURITY=y
>      >> CONFIG_SECURITYFS=y
>      >> # CONFIG_SECURITY_NETWORK is not set
>      >> CONFIG_PAGE_TABLE_ISOLATION=y
>      >> CONFIG_SECURITY_INFINIBAND=y
>      >> CONFIG_SECURITY_PATH=y
>      >> CONFIG_INTEL_TXT=y
>      >> CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR=y
>      >> CONFIG_HARDENED_USERCOPY=y
>      >> CONFIG_HARDENED_USERCOPY_FALLBACK=y
>      >> # CONFIG_HARDENED_USERCOPY_PAGESPAN is not set
>      >> CONFIG_FORTIFY_SOURCE=y
>      >> # CONFIG_STATIC_USERMODEHELPER is not set
>      >> # CONFIG_SECURITY_SMACK is not set
>      >> # CONFIG_SECURITY_TOMOYO is not set
>      >> # CONFIG_SECURITY_APPARMOR is not set
>      >> # CONFIG_SECURITY_LOADPIN is not set
>      >> # CONFIG_SECURITY_YAMA is not set
>      >> # CONFIG_SECURITY_SAFESETID is not set
>      >> # CONFIG_INTEGRITY is not set
>      >> CONFIG_DEFAULT_SECURITY_DAC=y
>      >> #
>      >>
>     CONFIG_LSM="yama,loadpin,safesetid,integrity,apparmor,selinux,smack,tomoyo"
> 
>      >>
>      >
>      > Your configs should only differ with respect to CONFIG_SECURITY*
>     if you
>      > want to evaluate LSM, SELinux, etc overheads.  PAGE_TABLE_ISOLATION,
>      > INTEL_TXT, and HARDENED_USERCOPY are not relevant to LSM itself.
>      >
>      > Also, what benchmarks are you using?  Your own home-grown ones, a
>     set of
>      > open source standard benchmarks (if so, which ones?).  You should
>      > include both micro and macro benchmarks in your suite.
>      >
>      > How stable are your results?  What kind of variance / standard
>     deviation
>      > are you seeing?
>      >
>      > It is hard to get meaningful, reliable performance measurements
>     so going
>      > down this road is not to be done lightly.
> 
>     Also, I note that you don't enable CONFIG_SECURITY_NETWORK above.  That
>     means you aren't including the base LSM overhead for the networking
>     security hooks.  So if you then compare that against SELinux (which
>     requires CONFIG_SECURITY_NETWORK), you are going to end up attributing
>     the cost of both the LSM overhead and SELinux overhead all to SELinux.
>     If you truly want to isolate the base LSM overhead, you need to enable
>     all the hooks.
> 
> I will give it a try for enabling CONFIG_SECURITY_NETWORK later this 
> week, however I wonder if this would affect the test results that much.
> I am testing with LMBench 2.5 , with focusing on filesystem unit tests, 
> however not network stack at this time.
> My understanding of why this result is so different from previous paper 
> 20 years ago, is that the Bottleneck changes.
> As Chris was testing with 4 cores , each 700MHz CPU, and 128MB memory, 
> with HDD (latency is about 20,000,000 ns for sequential read).
> The  Bottleneck of accessing files w/ MAC are mostly on I/O.
> However hardware setup is different now,  we have much larger and faster 
> memory (better prefetching as well), with SSD (latency is about 49,000 
> ns for sequential read). , while CPU speed is not increasing as much as 
> that of I/O.
> The Bottleneck of accessing files w/ MAC are mostly on CPU now.

Don't know if lmbench is still a good benchmark and I recall struggling 
with it even back then to get stable results.

Could be bottleneck changes, could be the fact that your kernel config 
changes aren't limited to CONFIG_SECURITY* (e.g. PTI introduces 
non-trivial overheads), could be changes to LSM since that time (e.g. 
stacking support, moving security_ calls out-of-line, more hooks, ...), 
could be that running SELinux w/o policy is flooding the system logs 
with warnings or other messages since it wasn't really designed to be 
used that way past initialization.  Lots of options, can't tell without 
more info on your details.


