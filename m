Return-Path: <SRS0=JZpt=3E=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 941B5C33C9E
	for <selinux@archiver.kernel.org>; Wed, 15 Jan 2020 00:24:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5016A24658
	for <selinux@archiver.kernel.org>; Wed, 15 Jan 2020 00:24:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728791AbgAOAYm (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 14 Jan 2020 19:24:42 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:38965 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728774AbgAOAYl (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 14 Jan 2020 19:24:41 -0500
Received: from static-50-53-33-191.bvtn.or.frontiernet.net ([50.53.33.191] helo=[192.168.192.153])
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <john.johansen@canonical.com>)
        id 1irWU4-00007o-87; Wed, 15 Jan 2020 00:24:32 +0000
Subject: Re: Perf Data on LSM in v5.3
To:     Wenhui Zhang <wenhui@gwmail.gwu.edu>,
        Casey Schaufler <casey@schaufler-ca.com>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>,
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
From:   John Johansen <john.johansen@canonical.com>
Organization: Canonical
Message-ID: <abd4dddb-8968-2655-3d80-ce446451b3de@canonical.com>
Date:   Tue, 14 Jan 2020 16:24:29 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CAOSEQ1p0q4gxVwN3MJkP=xxn4GUVaKsaArtQpxNy5rv7vYvVVw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 1/14/20 1:15 PM, Wenhui Zhang wrote:
> 
> On Tue, Jan 14, 2020 at 4:08 PM Casey Schaufler <casey@schaufler-ca.com <mailto:casey@schaufler-ca.com>> wrote:
> 
>     On 1/14/2020 12:15 PM, Wenhui Zhang wrote:
>      > Hi, Casey:
>      >
>      > I just performed a performance check on
>      > 1. v5.3 with DAC only, and
>      > 2. v5.3 with DAC and MAC framework, an empty-policy enabled in sub-modules(e.g. selinux)
>      > It seems like the downgrade is quite obvious. (here the perf is described in range 0 - 1, 0 is 0% and 1 is 100%).
>      > I am using a typical laptop for test,  4 2750MHz CPU, with SSD and 8G memory.
>      > Hope this might raise the performance issue.
> 
>     Thank you for doing this. Unfortunately, your graph is unreadable.
>     Could you provide some more detail about your results?
> 
> 
> Sure.  In summary, most of the benchmarks has more than 20% of performance downgrade, some even have 80% performance downgrade.
> I am attaching some details as following.
> 
Nice to see some testing, it is much needed and appreciated.

this doesn't really measure the MAC framework overhead but MAC
framework + selinux + unknown. Even without policy each LSM will
have its own overhead that should be measured separately from the
overhead of the LSM infrastructure. The "unknown" component above
is that we don't have your configs so we can't see what other LSM
modules might be enabled.

to make a proper comparison of the infrastructure compare DAC
(no CONFIG_SECURITY)

to LSM + only the capabilities module

   security=capability
or
   lsm=capability

or clearing the ordered lsm list in the config.

which is the equivalent of just DAC with the LSM infrastructure.

Further measurements can then be made against each LSM component.
Eg. if you have integrity and ima they will each introduce some
overhead of their own.




> without MAC FS perf:
> 
> stat
> Creating benchmark environment...done.
> default
> Simple stat median=0.7133 [mean=0.7254 +/-0.0057] microseconds
> var: 0.002553 sd: 0.050524 runs: 300
> Simple stat median=0.7159 [mean=0.7258 +/-0.0038] microseconds
> var: 0.001152 sd: 0.033934 runs: 300
> FFF
> Simple stat median=0.5378 [mean=0.5496 +/-0.0065] microseconds
> var: 0.003344 sd: 0.057826 runs: 300
> Simple stat median=0.5384 [mean=0.5442 +/-0.0018] microseconds
> var: 0.000246 sd: 0.015683 runs: 300
> XXX/FFF
> Simple stat median=0.5798 [mean=0.5893 +/-0.0038] microseconds
> var: 0.001124 sd: 0.033528 runs: 300
> Simple stat median=0.5796 [mean=0.6125 +/-0.0130] microseconds
> var: 0.013272 sd: 0.115206 runs: 300
> XXX/YYY/ZZZ/FFF
> Simple stat median=0.6556 [mean=0.6762 +/-0.0108] microseconds
> var: 0.009025 sd: 0.095001 runs: 300
> Simple stat median=0.6572 [mean=0.6641 +/-0.0021] microseconds
> var: 0.000340 sd: 0.018430 runs: 300
> XXX/YYY/ZZZ/AAA/BBB/CCC/DDD/FFF
> Simple stat median=0.8264 [mean=0.8377 +/-0.0037] microseconds
> var: 0.001052 sd: 0.032440 runs: 300
> Simple stat median=0.8262 [mean=0.8447 +/-0.0096] microseconds
> var: 0.007220 sd: 0.084971 runs: 300
> XXX/YYY/ZZZ/LLL
> Simple stat median=0.7934 [mean=0.8129 +/-0.0117] microseconds
> var: 0.010681 sd: 0.103351 runs: 300
> Simple stat median=0.7882 [mean=0.7957 +/-0.0021] microseconds
> var: 0.000329 sd: 0.018143 runs: 300
> LLL/YYY/ZZZ/FFF
> Simple stat median=0.7230 [mean=0.7317 +/-0.0041] microseconds
> var: 0.001298 sd: 0.036026 runs: 300
> Simple stat median=0.7212 [mean=0.7291 +/-0.0021] microseconds
> var: 0.000349 sd: 0.018693 runs: 300
> XXX/YYY/ZZZ/NNN
> Simple stat median=0.5068 [mean=0.5119 +/-0.0024] microseconds
> var: 0.000456 sd: 0.021350 runs: 300
> Simple stat median=0.5059 [mean=0.5106 +/-0.0017] microseconds
> var: 0.000227 sd: 0.015053 runs: 300
> NNN/YYY/ZZZ/FFF
> Simple stat median=0.3928 [mean=0.3970 +/-0.0017] microseconds
> var: 0.000236 sd: 0.015357 runs: 300
> Simple stat median=0.3928 [mean=0.3961 +/-0.0017] microseconds
> var: 0.000218 sd: 0.014781 runs: 300
> XXX/../FFF
> Simple stat median=0.6139 [mean=0.6259 +/-0.0076] microseconds
> var: 0.004464 sd: 0.066816 runs: 300
> Simple stat median=0.6171 [mean=0.6237 +/-0.0037] microseconds
> var: 0.001051 sd: 0.032415 runs: 300
> XXX/YYY/../../AAA/BBB/../../FFF
> Simple stat median=0.8165 [mean=0.8279 +/-0.0067] microseconds
> var: 0.003469 sd: 0.058901 runs: 300
> Simple stat median=0.8167 [mean=0.8225 +/-0.0023] microseconds
> var: 0.000428 sd: 0.020688 runs: 300
> open
> Creating benchmark environment...default
> Simple open/close median=1.4779 [mean=1.5905 +/-0.0385] microseconds
> var: 0.116006 sd: 0.340596 runs: 300
> Simple open/close median=1.4086 [mean=1.6213 +/-0.0497] microseconds
> var: 0.192852 sd: 0.439150 runs: 300
> FFF
> Simple open/close median=1.3212 [mean=1.4896 +/-0.0526] microseconds
> var: 0.215954 sd: 0.464709 runs: 300
> Simple open/close median=1.2311 [mean=1.5243 +/-0.0699] microseconds
> var: 0.381443 sd: 0.617610 runs: 300
> XXX/FFF
> Simple open/close median=1.2690 [mean=1.5006 +/-0.0577] microseconds
> var: 0.260051 sd: 0.509952 runs: 300
> Simple open/close median=1.2713 [mean=1.4765 +/-0.0502] microseconds
> var: 0.196706 sd: 0.443516 runs: 300
> XXX/YYY/ZZZ/FFF
> Simple open/close median=1.3574 [mean=1.5633 +/-0.0476] microseconds
> var: 0.177268 sd: 0.421033 runs: 300
> Simple open/close median=1.3325 [mean=1.5841 +/-0.0500] microseconds
> var: 0.195362 sd: 0.441998 runs: 300
> XXX/YYY/ZZZ/AAA/BBB/CCC/DDD/FFF
> Simple open/close median=1.4976 [mean=1.7416 +/-0.0628] microseconds
> var: 0.307634 sd: 0.554648 runs: 300
> Simple open/close median=1.5089 [mean=1.7448 +/-0.0611] microseconds
> var: 0.291463 sd: 0.539873 runs: 300
> XXX/YYY/ZZZ/LLL
> Simple open/close median=1.4776 [mean=1.7033 +/-0.0554] microseconds
> var: 0.239411 sd: 0.489297 runs: 300
> Simple open/close median=1.4884 [mean=1.7037 +/-0.0652] microseconds
> var: 0.331621 sd: 0.575866 runs: 300
> LLL/YYY/ZZZ/FFF
> Simple open/close median=1.4718 [mean=1.5590 +/-0.0401] microseconds
> var: 0.125453 sd: 0.354193 runs: 300
> Simple open/close median=1.4658 [mean=1.5995 +/-0.0389] microseconds
> var: 0.118034 sd: 0.343561 runs: 300
> XXX/YYY/ZZZ/NNN
> Simple open/close median=0.8414 [mean=1.1660 +/-0.0772] microseconds
> var: 0.465053 sd: 0.681948 runs: 300
> Simple open/close median=0.8202 [mean=1.1470 +/-0.0713] microseconds
> var: 0.396935 sd: 0.630027 runs: 300
> NNN/YYY/ZZZ/FFF
> Simple open/close median=0.7096 [mean=1.0043 +/-0.0818] microseconds
> var: 0.522749 sd: 0.723014 runs: 300
> Simple open/close median=0.7075 [mean=1.0112 +/-0.0670] microseconds
> var: 0.351028 sd: 0.592476 runs: 300
> XXX/../FFF
> Simple open/close median=1.3065 [mean=1.5606 +/-0.0610] microseconds
> var: 0.290301 sd: 0.538796 runs: 300
> Simple open/close median=1.3355 [mean=1.6094 +/-0.0722] microseconds
> var: 0.406936 sd: 0.637915 runs: 300
> XXX/YYY/../../AAA/BBB/../../FFF
> Simple open/close median=1.4716 [mean=1.7323 +/-0.0649] microseconds
> var: 0.329295 sd: 0.573843 runs: 300
> Simple open/close median=1.5467 [mean=1.8504 +/-0.0767] microseconds
> var: 0.459608 sd: 0.677944 runs: 300
> chmod
> DIR0
> Simple chmod median=1.1741 [mean=1.1911 +/-0.0048] microseconds
> var: 0.001773 sd: 0.042103 runs: 300
> Simple chmod median=1.1699 [mean=1.1840 +/-0.0046] microseconds
> var: 0.001680 sd: 0.040990 runs: 300
> DIR10
> Simple chmod median=1.2598 [mean=1.2770 +/-0.0090] microseconds
> var: 0.006326 sd: 0.079539 runs: 300
> Simple chmod median=1.1693 [mean=1.1820 +/-0.0039] microseconds
> var: 0.001164 sd: 0.034113 runs: 300
> DIR100
> Simple chmod median=1.1676 [mean=1.1831 +/-0.0069] microseconds
> var: 0.003680 sd: 0.060666 runs: 300
> Simple chmod median=1.1696 [mean=1.2417 +/-0.0288] microseconds
> var: 0.064871 sd: 0.254698 runs: 300
> DIR1000
> Simple chmod median=1.1823 [mean=1.1946 +/-0.0035] microseconds
> var: 0.000972 sd: 0.031174 runs: 300
> Simple chmod median=1.1801 [mean=1.1939 +/-0.0040] microseconds
> var: 0.001277 sd: 0.035735 runs: 300
> DIR10000
> Simple chmod median=1.1893 [mean=1.2031 +/-0.0054] microseconds
> var: 0.002237 sd: 0.047294 runs: 300
> Simple chmod median=1.1824 [mean=1.1966 +/-0.0046] microseconds
> var: 0.001654 sd: 0.040671 runs: 300
> rename
> DIR0
> Simple rename median=3.9288 [mean=4.1751 +/-0.0999] microseconds
> var: 0.779841 sd: 0.883086 runs: 300
> Simple rename median=3.9200 [mean=4.1499 +/-0.0917] microseconds
> var: 0.656825 sd: 0.810447 runs: 300
> DIR10
> Simple rename median=4.5611 [mean=4.8041 +/-0.0992] microseconds
> var: 0.768976 sd: 0.876913 runs: 300
> Simple rename median=4.5597 [mean=4.7682 +/-0.0695] microseconds
> var: 0.377366 sd: 0.614301 runs: 300
> DIR100
> Simple rename median=4.6055 [mean=4.7385 +/-0.0687] microseconds
> var: 0.368270 sd: 0.606853 runs: 300
> Simple rename median=4.6258 [mean=4.7810 +/-0.0807] microseconds
> var: 0.509114 sd: 0.713523 runs: 300
> DIR1000
> Simple rename median=4.5710 [mean=4.8293 +/-0.0921] microseconds
> var: 0.662712 sd: 0.814071 runs: 300
> Simple rename median=4.6070 [mean=4.8313 +/-0.0874] microseconds
> var: 0.597162 sd: 0.772762 runs: 300
> DIR10000
> Simple rename median=4.6285 [mean=4.7643 +/-0.0717] microseconds
> var: 0.401634 sd: 0.633746 runs: 300
> Simple rename median=4.5886 [mean=4.8419 +/-0.0946] microseconds
> var: 0.698920 sd: 0.836014 runs: 300
> LMBench mkstemp benchmark...
> FILE0,
> Simple mkstemp median=10.7036 [mean=11.4172 +/-0.2403] microseconds
> var: 4.508005 sd: 2.123206 runs: 300
> Simple mkstemp median=10.7332 [mean=11.6058 +/-0.2749] microseconds
> var: 5.900492 sd: 2.429093 runs: 300
> FILE10,
> Simple mkstemp median=10.9459 [mean=11.6833 +/-0.2566] microseconds
> var: 5.140533 sd: 2.267274 runs: 300
> Simple mkstemp median=11.3235 [mean=11.4085 +/-0.0802] microseconds
> var: 0.502234 sd: 0.708685 runs: 300
> FILE100,
> Simple mkstemp median=12.7990 [mean=13.5488 +/-0.2515] microseconds
> var: 4.939811 sd: 2.222569 runs: 300
> Simple mkstemp median=12.7536 [mean=13.5472 +/-0.2460] microseconds
> var: 4.725637 sd: 2.173853 runs: 300
> FILE1000,
> Simple mkstemp median=16.3758 [mean=17.2494 +/-0.3032] microseconds
> var: 7.180255 sd: 2.679600 runs: 300
> Simple mkstemp median=16.4186 [mean=16.6040 +/-0.1322] microseconds
> var: 1.365365 sd: 1.168488 runs: 300
> FILE10000,
> Simple mkstemp median=16.9423 [mean=17.7549 +/-0.2862] microseconds
> var: 6.394964 sd: 2.528827 runs: 300
> Simple mkstemp median=17.2046 [mean=17.4739 +/-0.1404] microseconds
> var: 1.538521 sd: 1.240371 runs: 300
> LMBench readdir benchmark...
> FILE0,
> Simple readdir median=3.2470 [mean=3.4157 +/-0.0748] microseconds
> var: 0.437047 sd: 0.661095 runs: 300
> Simple readdir median=3.2251 [mean=3.4753 +/-0.0918] microseconds
> var: 0.658597 sd: 0.811540 runs: 300
> FILE10,
> Simple readdir median=6.0984 [mean=6.1701 +/-0.0368] microseconds
> var: 0.105670 sd: 0.325069 runs: 300
> Simple readdir median=6.1509 [mean=6.2974 +/-0.0764] microseconds
> var: 0.456050 sd: 0.675315 runs: 300
> FILE100,
> Simple readdir median=34.3000 [mean=34.6490 +/-0.1500] microseconds
> var: 1.755986 sd: 1.325136 runs: 300
> Simple readdir median=33.2237 [mean=33.6693 +/-0.1680] microseconds
> var: 2.203202 sd: 1.484319 runs: 300
> FILE1000,
> Simple readdir median=355.0667 [mean=357.5527 +/-0.9898] microseconds
> var: 76.511562 sd: 8.747089 runs: 300
> Simple readdir median=358.6667 [mean=362.1251 +/-0.9766] microseconds
> var: 74.479095 sd: 8.630127 runs: 300
> FILE10000,
> Simple readdir median=3575.5000 [mean=3609.3333 +/-10.8026] microseconds
> var: 9113.105909 sd: 95.462589 runs: 300
> Simple readdir median=3576.0000 [mean=3610.7967 +/-9.8897] microseconds
> var: 7637.921728 sd: 87.395204 runs: 300
> rename-creat
> Creating benchmark environment...done.
> Simple rename-create median=12.0409 [mean=13.2621 +/-0.4418] microseconds
> var: 15.242249 sd: 3.904132 runs: 300
> Simple rename-create median=12.2638 [mean=12.6817 +/-0.2750] microseconds
> var: 5.906039 sd: 2.430234 runs: 300
> open-unlink
> Creating benchmark environment...done.
> Simple open-unlink median=10.1657 [mean=11.2717 +/-0.5313] microseconds
> var: 22.041715 sd: 4.694860 runs: 300
> Simple open-unlink median=10.1726 [mean=11.2655 +/-0.3946] microseconds
> var: 12.156986 sd: 3.486687 runs: 300
> Running lm_symlink-unlink as part of whole set.
> symlink
> Creating benchmark environment...done.
> Simple symlink-unlink median=8.6493 [mean=8.7250 +/-0.0511] microseconds
> var: 0.204218 sd: 0.451905 runs: 300
> Simple symlink-unlink median=8.6155 [mean=9.0742 +/-0.1571] microseconds
> var: 1.928171 sd: 1.388586 runs: 300
> fstatat
> Creating benchmark environment...done.
> fstatat /test/FFF
> Simple fstatat median=0.5885 [mean=0.5955 +/-0.0043] microseconds
> var: 0.001426 sd: 0.037759 runs: 300
> Simple fstatat median=0.5861 [mean=0.5912 +/-0.0013] microseconds
> var: 0.000139 sd: 0.011810 runs: 300
> openat
> Creating benchmark environment...done.
> openat /test/FFF
> Simple openat/close median=1.2482 [mean=1.4966 +/-0.0583] microseconds
> var: 0.265530 sd: 0.515296 runs: 300
> Simple openat/close median=1.2745 [mean=1.5138 +/-0.0558] microseconds
> var: 0.243167 sd: 0.493120 runs: 300
> 
> 
> with MAC perf:
> stat
> Creating benchmark environment...done.
> default
> Simple stat median=1.0480 [mean=1.0491 +/-0.0004] microseconds
> var: 0.000012 sd: 0.003456 runs: 300
> Simple stat median=1.0464 [mean=1.0535 +/-0.0062] microseconds
> var: 0.003004 sd: 0.054809 runs: 300
> FFF
> Simple stat median=0.8577 [mean=0.8588 +/-0.0004] microseconds
> var: 0.000016 sd: 0.003959 runs: 300
> Simple stat median=0.8574 [mean=0.8583 +/-0.0005] microseconds
> var: 0.000018 sd: 0.004232 runs: 300
> XXX/FFF
> Simple stat median=0.9006 [mean=0.9011 +/-0.0004] microseconds
> var: 0.000014 sd: 0.003807 runs: 300
> Simple stat median=0.9007 [mean=0.9012 +/-0.0002] microseconds
> var: 0.000003 sd: 0.001859 runs: 300
> XXX/YYY/ZZZ/FFF
> Simple stat median=0.9811 [mean=0.9824 +/-0.0005] microseconds
> var: 0.000020 sd: 0.004496 runs: 300
> Simple stat median=0.9813 [mean=0.9821 +/-0.0004] microseconds
> var: 0.000011 sd: 0.003269 runs: 300
> XXX/YYY/ZZZ/AAA/BBB/CCC/DDD/FFF
> Simple stat median=1.1593 [mean=1.1604 +/-0.0004] microseconds
> var: 0.000013 sd: 0.003634 runs: 300
> Simple stat median=1.1562 [mean=1.1578 +/-0.0006] microseconds
> var: 0.000027 sd: 0.005194 runs: 300
> XXX/YYY/ZZZ/LLL
> Simple stat median=1.1247 [mean=1.1260 +/-0.0006] microseconds
> var: 0.000024 sd: 0.004876 runs: 300
> Simple stat median=1.1221 [mean=1.1234 +/-0.0004] microseconds
> var: 0.000014 sd: 0.003802 runs: 300
> LLL/YYY/ZZZ/FFF
> Simple stat median=1.0496 [mean=1.0508 +/-0.0005] microseconds
> var: 0.000017 sd: 0.004162 runs: 300
> Simple stat median=1.0501 [mean=1.0528 +/-0.0006] microseconds
> var: 0.000028 sd: 0.005285 runs: 300
> XXX/YYY/ZZZ/NNN
> Simple stat median=0.8228 [mean=0.8237 +/-0.0004] microseconds
> var: 0.000015 sd: 0.003844 runs: 300
> Simple stat median=0.8207 [mean=0.8216 +/-0.0004] microseconds
> var: 0.000014 sd: 0.003686 runs: 300
> NNN/YYY/ZZZ/FFF
> Simple stat median=0.7080 [mean=0.7083 +/-0.0003] microseconds
> var: 0.000006 sd: 0.002355 runs: 300
> Simple stat median=0.7106 [mean=0.7108 +/-0.0002] microseconds
> var: 0.000003 sd: 0.001608 runs: 300
> XXX/../FFF
> Simple stat median=0.9376 [mean=0.9391 +/-0.0005] microseconds
> var: 0.000017 sd: 0.004171 runs: 300
> Simple stat median=0.9388 [mean=0.9396 +/-0.0004] microseconds
> var: 0.000011 sd: 0.003335 runs: 300
> XXX/YYY/../../AAA/BBB/../../FFF
> Simple stat median=1.1465 [mean=1.1470 +/-0.0003] microseconds
> var: 0.000006 sd: 0.002415 runs: 300
> Simple stat median=1.1414 [mean=1.1484 +/-0.0074] microseconds
> var: 0.004312 sd: 0.065662 runs: 300
> open
> Creating benchmark environment...default
> Simple open/close median=2.0144 [mean=2.1228 +/-0.0356] microseconds
> var: 0.098701 sd: 0.314167 runs: 300
> Simple open/close median=2.0121 [mean=2.1171 +/-0.0290] microseconds
> var: 0.065570 sd: 0.256066 runs: 300
> FFF
> Simple open/close median=1.8145 [mean=1.9360 +/-0.0346] microseconds
> var: 0.093339 sd: 0.305515 runs: 300
> Simple open/close median=1.8091 [mean=1.9537 +/-0.0351] microseconds
> var: 0.096164 sd: 0.310103 runs: 300
> XXX/FFF
> Simple open/close median=1.8510 [mean=1.9833 +/-0.0377] microseconds
> var: 0.110944 sd: 0.333083 runs: 300
> Simple open/close median=1.8584 [mean=1.9888 +/-0.0324] microseconds
> var: 0.082185 sd: 0.286679 runs: 300
> XXX/YYY/ZZZ/FFF
> Simple open/close median=1.9393 [mean=2.0653 +/-0.0378] microseconds
> var: 0.111844 sd: 0.334430 runs: 300
> Simple open/close median=1.9261 [mean=2.0403 +/-0.0289] microseconds
> var: 0.065310 sd: 0.255559 runs: 300
> XXX/YYY/ZZZ/AAA/BBB/CCC/DDD/FFF
> Simple open/close median=2.1273 [mean=2.2631 +/-0.0407] microseconds
> var: 0.129379 sd: 0.359692 runs: 300
> Simple open/close median=2.1257 [mean=2.2406 +/-0.0343] microseconds
> var: 0.091647 sd: 0.302733 runs: 300
> XXX/YYY/ZZZ/LLL
> Simple open/close median=2.1023 [mean=2.2059 +/-0.0310] microseconds
> var: 0.074962 sd: 0.273791 runs: 300
> Simple open/close median=2.0772 [mean=2.1913 +/-0.0342] microseconds
> var: 0.091148 sd: 0.301907 runs: 300
> LLL/YYY/ZZZ/FFF
> Simple open/close median=2.0171 [mean=2.1292 +/-0.0307] microseconds
> var: 0.073511 sd: 0.271129 runs: 300
> Simple open/close median=2.0214 [mean=2.1321 +/-0.0347] microseconds
> var: 0.094190 sd: 0.306904 runs: 300
> XXX/YYY/ZZZ/NNN
> Simple open/close median=1.1434 [mean=1.3551 +/-0.0469] microseconds
> var: 0.171409 sd: 0.414016 runs: 300
> Simple open/close median=1.1451 [mean=1.3604 +/-0.0492] microseconds
> var: 0.188978 sd: 0.434716 runs: 300
> NNN/YYY/ZZZ/FFF
> Simple open/close median=1.0258 [mean=1.2390 +/-0.0529] microseconds
> var: 0.218527 sd: 0.467468 runs: 300
> Simple open/close median=1.0288 [mean=1.2522 +/-0.0489] microseconds
> var: 0.186869 sd: 0.432284 runs: 300
> XXX/../FFF
> Simple open/close median=1.9067 [mean=2.0070 +/-0.0265] microseconds
> var: 0.054636 sd: 0.233744 runs: 300
> Simple open/close median=1.9052 [mean=2.0134 +/-0.0295] microseconds
> var: 0.067930 sd: 0.260633 runs: 300
> XXX/YYY/../../AAA/BBB/../../FFF
> Simple open/close median=2.1170 [mean=2.2358 +/-0.0365] microseconds
> var: 0.104043 sd: 0.322557 runs: 300
> Simple open/close median=2.1003 [mean=2.2050 +/-0.0277] microseconds
> var: 0.059771 sd: 0.244480 runs: 300
> chmod
> DIR0
> Simple chmod median=1.5073 [mean=1.5094 +/-0.0008] microseconds
> var: 0.000045 sd: 0.006707 runs: 300
> Simple chmod median=1.5005 [mean=1.5049 +/-0.0036] microseconds
> var: 0.001031 sd: 0.032105 runs: 300
> DIR10
> Simple chmod median=1.5105 [mean=1.5112 +/-0.0004] microseconds
> var: 0.000012 sd: 0.003517 runs: 300
> Simple chmod median=1.5129 [mean=1.5140 +/-0.0006] microseconds
> var: 0.000025 sd: 0.005034 runs: 300
> DIR100
> Simple chmod median=1.4978 [mean=1.5002 +/-0.0008] microseconds
> var: 0.000044 sd: 0.006644 runs: 300
> Simple chmod median=1.4986 [mean=1.4998 +/-0.0006] microseconds
> var: 0.000024 sd: 0.004863 runs: 300
> DIR1000
> Simple chmod median=1.5031 [mean=1.5037 +/-0.0004] microseconds
> var: 0.000015 sd: 0.003918 runs: 300
> Simple chmod median=1.4982 [mean=1.4987 +/-0.0005] microseconds
> var: 0.000017 sd: 0.004133 runs: 300
> DIR10000
> Simple chmod median=1.5000 [mean=1.5104 +/-0.0085] microseconds
> var: 0.005691 sd: 0.075440 runs: 300
> Simple chmod median=1.4962 [mean=1.4977 +/-0.0007] microseconds
> var: 0.000037 sd: 0.006091 runs: 300
> rename
> DIR0
> Simple rename median=4.3412 [mean=4.5044 +/-0.0774] microseconds
> var: 0.467785 sd: 0.683948 runs: 300
> Simple rename median=4.3242 [mean=4.4593 +/-0.0558] microseconds
> var: 0.243436 sd: 0.493393 runs: 300
> DIR10
> Simple rename median=4.9872 [mean=5.1361 +/-0.0711] microseconds
> var: 0.395092 sd: 0.628564 runs: 300
> Simple rename median=5.0441 [mean=5.0370 +/-0.0061] microseconds
> var: 0.002923 sd: 0.054063 runs: 300
> DIR100
> Simple rename median=4.9964 [mean=5.1442 +/-0.0742] microseconds
> var: 0.430474 sd: 0.656105 runs: 300
> Simple rename median=5.0445 [mean=5.0416 +/-0.0120] microseconds
> var: 0.011194 sd: 0.105800 runs: 300
> DIR1000
> Simple rename median=4.9845 [mean=5.1282 +/-0.0677] microseconds
> var: 0.358090 sd: 0.598406 runs: 300
> Simple rename median=5.0471 [mean=5.0451 +/-0.0103] microseconds
> var: 0.008237 sd: 0.090756 runs: 300
> DIR10000
> Simple rename median=4.9964 [mean=5.1478 +/-0.0737] microseconds
> var: 0.424529 sd: 0.651559 runs: 300
> Simple rename median=4.9825 [mean=5.1054 +/-0.0639] microseconds
> var: 0.319208 sd: 0.564985 runs: 300
> mkstemp
> FILE0,
> Simple mkstemp median=12.1161 [mean=12.0418 +/-0.0220] microseconds
> var: 0.037909 sd: 0.194703 runs: 300
> Simple mkstemp median=12.0065 [mean=12.5739 +/-0.2383] microseconds
> var: 4.433779 sd: 2.105654 runs: 300
> FILE10,
> Simple mkstemp median=12.3333 [mean=12.3107 +/-0.0477] microseconds
> var: 0.177861 sd: 0.421736 runs: 300
> Simple mkstemp median=12.4115 [mean=12.3578 +/-0.0230] microseconds
> var: 0.041201 sd: 0.202981 runs: 300
> FILE100,
> Simple mkstemp median=14.1658 [mean=14.1391 +/-0.0352] microseconds
> var: 0.096515 sd: 0.310668 runs: 300
> Simple mkstemp median=14.0754 [mean=14.6226 +/-0.2178] microseconds
> var: 3.705642 sd: 1.925004 runs: 300
> FILE1000,
> Simple mkstemp median=17.6864 [mean=17.6896 +/-0.0335] microseconds
> var: 0.087457 sd: 0.295731 runs: 300
> Simple mkstemp median=17.7267 [mean=17.7408 +/-0.0231] microseconds
> var: 0.041653 sd: 0.204090 runs: 300
> FILE10000,
> Simple mkstemp median=18.2997 [mean=18.2899 +/-0.0278] microseconds
> var: 0.060245 sd: 0.245449 runs: 300
> Simple mkstemp median=18.3661 [mean=18.7377 +/-0.1909] microseconds
> var: 2.846606 sd: 1.687189 runs: 300
> readdir
> FILE0,
> Simple readdir median=4.7133 [mean=4.7005 +/-0.0105] microseconds
> var: 0.008640 sd: 0.092952 runs: 300
> Simple readdir median=4.7382 [mean=4.7298 +/-0.0093] microseconds
> var: 0.006816 sd: 0.082557 runs: 300
> FILE10,
> Simple readdir median=7.8227 [mean=7.8351 +/-0.0074] microseconds
> var: 0.004320 sd: 0.065726 runs: 300
> Simple readdir median=7.8251 [mean=7.8318 +/-0.0064] microseconds
> var: 0.003214 sd: 0.056692 runs: 300
> FILE100,
> Simple readdir median=37.9407 [mean=37.9916 +/-0.0272] microseconds
> var: 0.057637 sd: 0.240076 runs: 300
> Simple readdir median=37.2230 [mean=37.2814 +/-0.0375] microseconds
> var: 0.109620 sd: 0.331090 runs: 300
> FILE1000,
> Simple readdir median=392.7692 [mean=393.2500 +/-0.1673] microseconds
> var: 2.186940 sd: 1.478831 runs: 300
> Simple readdir median=394.6923 [mean=394.4895 +/-0.2133] microseconds
> var: 3.552738 sd: 1.884871 runs: 300
> FILE10000,
> Simple readdir median=3904.0000 [mean=3906.6100 +/-1.2472] microseconds
> var: 121.477826 sd: 11.021698 runs: 300
> Simple readdir median=3941.0000 [mean=3943.0550 +/-1.6803] microseconds
> var: 220.497801 sd: 14.849168 runs: 300
> rename-creat
> Creating benchmark environment...done.
> Simple rename-create median=12.8961 [mean=13.7555 +/-0.3549] microseconds
> var: 9.837528 sd: 3.136483 runs: 300
> Simple rename-create median=13.0416 [mean=12.9491 +/-0.0268] microseconds
> var: 0.055950 sd: 0.236538 runs: 300
> open-unlink
> Creating benchmark environment...done.
> Simple open-unlink median=11.1903 [mean=12.0262 +/-0.3293] microseconds
> var: 8.466363 sd: 2.909702 runs: 300
> Simple open-unlink median=11.2495 [mean=12.0415 +/-0.3062] microseconds
> var: 7.320019 sd: 2.705553 runs: 300
> Running lm_symlink-unlink as part of whole set.
> symlink
> Creating benchmark environment...done.
> Simple symlink-unlink median=9.3716 [mean=9.3743 +/-0.0274] microseconds
> var: 0.058533 sd: 0.241937 runs: 300
> Simple symlink-unlink median=9.3537 [mean=9.3497 +/-0.0215] microseconds
> var: 0.036230 sd: 0.190342 runs: 300
> fstatat
> Creating benchmark environment...done.
> fstatat /test/FFF
> Simple fstatat median=0.9153 [mean=0.9157 +/-0.0002] microseconds
> var: 0.000003 sd: 0.001746 runs: 300
> Simple fstatat median=0.9089 [mean=0.9097 +/-0.0004] microseconds
> var: 0.000010 sd: 0.003129 runs: 300
> openat
> Creating benchmark environment...done.
> openat /test/FFF
> Simple openat/close median=1.8632 [mean=1.9830 +/-0.0334] microseconds
> var: 0.087134 sd: 0.295185 runs: 300
> Simple openat/close median=1.8593 [mean=1.9708 +/-0.0275] microseconds
> var: 0.059013 sd: 0.242927 runs: 300
> 
> 
>      >
>      > The last paper mentioning about performance of LSM was about 20 years ago, where Chris was using a setup of 4 700MHz CPU, 128MB memory with Disk.
>      >
>      > Due to the change of hardware, performance on filesystem changes a lot.
>      >
>      >
>      > sec1.png
>      >
>      > --
>      > V/R,
>      >
>      > Wenhui Zhang
>      >
>      > Email: wenhui@gwmail.gwu.edu <mailto:wenhui@gwmail.gwu.edu> <mailto:wenhui@gwmail.gwu.edu <mailto:wenhui@gwmail.gwu.edu>>
>      >            Telephone: 1-(703) 424 3193
>      >
>      >
>      >
>      >
>      >
>      >
> 
> 
> 
> -- 
> V/R,
> 
> Wenhui Zhang
> 
> Email: wenhui@gwmail.gwu.edu <mailto:wenhui@gwmail.gwu.edu>
>             Telephone: 1-(703) 424 3193
> 
> 
> 
> 
> 
> 

