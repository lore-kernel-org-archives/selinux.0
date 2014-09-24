Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s8O18g4o026409
 for <selinux@tycho.nsa.gov>; Tue, 23 Sep 2014 21:08:42 -0400
Message-ID: <5422199C.1000903@windriver.com>
Date: Wed, 24 Sep 2014 09:08:44 +0800
From: Rongqing Li <rongqing.li@windriver.com>
MIME-Version: 1.0
To: kuangjiou <kuangjiou@huawei.com>
Subject: Re: problem about making selinux userspace
References: <60ABE64B4BE4AC45964F1A967BA76CB2BBCF4F@SZXEML507-MBX.china.huawei.com>
In-Reply-To: <60ABE64B4BE4AC45964F1A967BA76CB2BBCF4F@SZXEML507-MBX.china.huawei.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Cc: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

your gcc is too old, it does not support these options.

-Roy

On 09/23/2014 09:39 AM, kuangjiou wrote:
> i have some problems when make selinux userspace (version:
> selinux-20140826-rc1) in 64-bit sles 11 sp1(the version of kernel is
> 2.6.32).
>
> I get the error messeges below when I run " make LIBDIR=/usr/lib64
> SHLIBDIR=/lib64 install install-pywrap relabel "
>
> can anyone help out with this problem? thanks!
>
> cc1: error: unrecognized command line option "-Wbuiltin-macro-redefined"
>
> cc1: error: unrecognized command line option "-Wmudflap"
>
> cc1: error: unrecognized command line option "-Wpacked-bitfield-compat"
>
> cc1: error: unrecognized command line option "-Wsync-nand"
>
> cc1: error: unrecognized command line option "-Wcpp"
>
> cc1: error: unrecognized command line option "-Wdouble-promotion"
>
> cc1: error: unrecognized command line option "-Wsuggest-attribute=const"
>
> cc1: error: unrecognized command line option "-Wsuggest-attribute=noreturn"
>
> cc1: error: unrecognized command line option "-Wsuggest-attribute=pure"
>
> cc1: error: unrecognized command line option "-Wtrampolines"
>
> cc1: error: unrecognized command line option "-Wjump-misses-init"
>
> cc1: error: unrecognized command line option "-Wframe-larger-than=32768"
>
> cc1: error: unrecognized command line option "-Wno-suggest-attribute=pure"
>
> cc1: error: unrecognized command line option "-Wno-suggest-attribute=const"
>
> make[2]: *** [avc.o] Error 1
>
> make[2]: Leaving directory `/home/selinux-20140826-rc1/libselinux/src'
>
> make[1]: *** [install-pywrap] Error 2
>
> make[1]: Leaving directory `/home/selinux-20140826-rc1/libselinux'
>
> make: *** [install-pywrap] Error 1
>
>
>
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.
>

-- 
Best Reagrds,
Roy | RongQing Li
