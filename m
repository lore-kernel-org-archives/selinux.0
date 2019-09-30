Return-Path: <SRS0=KDcg=XZ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6683DC32792
	for <selinux@archiver.kernel.org>; Mon, 30 Sep 2019 21:28:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22ADC20815
	for <selinux@archiver.kernel.org>; Mon, 30 Sep 2019 21:28:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="BXOZ5pxF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727720AbfI3V22 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 30 Sep 2019 17:28:28 -0400
Received: from USFB19PA35.eemsg.mail.mil ([214.24.26.198]:33736 "EHLO
        USFB19PA35.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726504AbfI3V22 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 30 Sep 2019 17:28:28 -0400
X-EEMSG-check-017: 13420382|USFB19PA35_ESA_OUT05.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.64,568,1559520000"; 
   d="scan'208";a="13420382"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by USFB19PA35.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 30 Sep 2019 18:05:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1569866748; x=1601402748;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=EmpJFsOqadeM/i9JGLjVqIpMtNI2p9x9EFoqL/88ru4=;
  b=BXOZ5pxFT8c430rIs7pMg/bKI+AZr0pBYq8pi9TQLMRb986lWAvNgtpl
   xW4cxxMIzZx/z/2QZdWvLaZus0P5RZGnwGvd528ui/rp6lUP/xb7L1Xvh
   p1w/Qk10V622SzeF0Omja8FNfFS+FmE6dAFAd9wnZRvxUvEQqvQRpz5gJ
   coJcgBld5EjSTMOACxKEm5LOxjsK7LZ4WEKXTnjyTabf2ZKrFEPiEGtZu
   STUSojmlxEEpsXHWK8cC+ODYRbAwndGIs7uDd5lVCsVW5T79mooI9zoJ7
   +XaRNCsqHR+cQDyvre6PkaBxCJepWMqWh8pCe2MGxcpQQmTmYO2b29jQd
   w==;
X-IronPort-AV: E=Sophos;i="5.64,568,1559520000"; 
   d="scan'208";a="33537683"
IronPort-PHdr: =?us-ascii?q?9a23=3Ahm67LhOeaIDHDH4oY3El6mtUPXoX/o7sNwtQ0K?=
 =?us-ascii?q?IMzox0I/3/rarrMEGX3/hxlliBBdydt6sfzbaM+Pm5BiQp2tWoiDg6aptCVh?=
 =?us-ascii?q?sI2409vjcLJ4q7M3D9N+PgdCcgHc5PBxdP9nC/NlVJSo6lPwWB6nK94iQPFR?=
 =?us-ascii?q?rhKAF7Ovr6GpLIj8Swyuu+54Dfbx9HiTagb75+Nhq7oRveusULnIdvKLs6xw?=
 =?us-ascii?q?fUrHdPZ+lY335jK0iJnxb76Mew/Zpj/DpVtvk86cNOUrj0crohQ7BAAzsoL2?=
 =?us-ascii?q?465MvwtRneVgSP/WcTUn8XkhVTHQfI6gzxU4rrvSv7sup93zSaPdHzQLspVz?=
 =?us-ascii?q?mu87tnRRn1gyocKTU37H/YhdBxjKJDoRKuuRp/w5LPYIqIMPZyZ77Rcc8GSW?=
 =?us-ascii?q?ZEWMteWTZBAoehZIURCeQPM/tTo43kq1YAqRayAA+hD/7txDBVnH/7xbA03f?=
 =?us-ascii?q?ovEQ/G3wIuEdwBv3vWo9rpO6kfSvy1wavSwDnfc/9b1zXw5Y7VeR4hu/GMWr?=
 =?us-ascii?q?dwfNLMx0kzCQzFllWQppLjPziIy+oNtnKU7+5kVe2xi28stgZ8oiOyycc3kY?=
 =?us-ascii?q?TJmoIUxUzE9SV+2oo1I8a4R1Rhbd6rF5tQqTiXOo1rSc0sRGFovTw1yrwAuZ?=
 =?us-ascii?q?OjYCgF1o4rxx/Za/CffIiI4w7jVOaMIThjnn5qZLW/hxO0/EO9yeP8TtG53E?=
 =?us-ascii?q?tFoydKiNXBtm0B2wbN5sWIVPdx5Fqt1DCS3A7J8O5EO1o7la/DJp4kxb4/i4?=
 =?us-ascii?q?QcvFzYHi/zhEX2lKiWdlg4+uSw6+TofLHmppiEOo9okA7+KKUumtGkAegiLg?=
 =?us-ascii?q?gPX3SU+eS71LH5+032XK5KgeEsnqncsZDaIdwXpq+/AwBLzoYu8wuzAjip3d?=
 =?us-ascii?q?gCnXQLMUhJdAyIgoT3IV3CPej0DfKljFStlDdryerGPrrkApjVNXjMjazhcK?=
 =?us-ascii?q?1h609c1AUzzddf64hSCrEaOv3/QEDxtNvGDhMhKQy73/7nCMlh1oMZQW+PBa?=
 =?us-ascii?q?qZMKTJsV+O/O0gP/eDaZQPuDnjNvcl5+ThjWMjlVABeqmp2IMdaGqkEfR+P0?=
 =?us-ascii?q?WZfX3sj88aEWgUugo+TerqiECNUDNIeXayULwz5ishBIKlE4jDXIatj6KF3C?=
 =?us-ascii?q?uhGZ1WfG9GWRiwFiLPcYmeVvVETSWJJMZqnz9MAb+kTJQn3BqjnBX3x7puMq?=
 =?us-ascii?q?zf/ShO5rz5090g3PHejRE/83RPCs2Z12ycBzVvknggWy493Kc5p1d0jFiEz/?=
 =?us-ascii?q?4r0LRjCdVP6qYRAU8BPpnGwrk/UoujVw=3D=3D?=
X-IPAS-Result: =?us-ascii?q?A2CBAAAYQ5Jd/wHyM5BmGwEBAQEDAQEBDAMBAQGBVgMBA?=
 =?us-ascii?q?QELAYFzKm1SATIqhCKPQQEBAQaBNol1kSoJAQEBAQEBAQEBKwkBAgEBhEACg?=
 =?us-ascii?q?0MjNwYOAgwBAQEEAQEBAQEFAwEBbIUtDII6KQGCaAEFIxVBEAsOCgICJgICV?=
 =?us-ascii?q?wYNBgIBAYJfPwGBdhQPrHIbNXWBMoVNgyeBSIEMKAGMDRh4gQeBESeCaz6BD?=
 =?us-ascii?q?oFTAoRuglgEjHmJGZcNgiyCLoRXhRUHiGQGG4Mplg2VSHGNKIVvI4FYKwgCG?=
 =?us-ascii?q?AghD4MnCUcQFIVCglaCbIEPhB4lAzCBBgEBkBoBAQ?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 30 Sep 2019 18:05:46 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x8UI5jUx005227;
        Mon, 30 Sep 2019 14:05:45 -0400
Subject: Re: [PATCH testsuite 3/3] travis: test building the test policy
 package
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>
References: <20190930104850.5482-1-omosnace@redhat.com>
 <20190930104850.5482-4-omosnace@redhat.com>
 <2dfde121-d786-6ba3-0820-953cfbba7033@tycho.nsa.gov>
 <CAFqZXNsKFb6QJ2jqYM8qS5Mx27sXaztn67-MxC-oanFQB7QaOg@mail.gmail.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <ca6ae7be-edd3-e86a-1b4a-94882471350c@tycho.nsa.gov>
Date:   Mon, 30 Sep 2019 14:05:45 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <CAFqZXNsKFb6QJ2jqYM8qS5Mx27sXaztn67-MxC-oanFQB7QaOg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 9/30/19 11:02 AM, Ondrej Mosnacek wrote:
> On Mon, Sep 30, 2019 at 3:44 PM Stephen Smalley <sds@tycho.nsa.gov> wrote:
>> On 9/30/19 6:48 AM, Ondrej Mosnacek wrote:
>>> Download, build, and install Fedora policy & refpolicy and try building
>>> the test policy package against both of them.
>>
>> I guess this is a necessary first step to actually getting the testsuite
>> to run on travis, which would be the more important goal.  That
>> obviously requires actually enabling SELinux on bionic, unless we could
>> get travis-ci to offer fedora or centos images.
>>
>>>
>>> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
>>> ---
>>>    .travis.yml                         | 24 ++++++++++++++++++--
>>>    travis-ci/enable-policy.sh          | 10 +++++++++
>>>    travis-ci/setup-policy-fedora.sh    | 35 +++++++++++++++++++++++++++++
>>>    travis-ci/setup-policy-refpolicy.sh | 22 ++++++++++++++++++
>>>    4 files changed, 89 insertions(+), 2 deletions(-)
>>>    create mode 100644 travis-ci/enable-policy.sh
>>>    create mode 100644 travis-ci/setup-policy-fedora.sh
>>>    create mode 100644 travis-ci/setup-policy-refpolicy.sh
>>>
>>> diff --git a/.travis.yml b/.travis.yml
>>> index fbbe98d..c8cd44e 100644
>>> --- a/.travis.yml
>>> +++ b/.travis.yml
>>> @@ -1,6 +1,6 @@
>>>    language: c
>>>
>>> -dist: xenial
>>> +dist: bionic
>>>
>>>    addons:
>>>      apt:
>>> @@ -8,6 +8,14 @@ addons:
>>>          - astyle
>>>          - libselinux1-dev
>>>          - libsctp-dev
>>> +      - checkpolicy
>>> +      - semodule-utils
>>> +
>>> +cache:
>>> +  directories:
>>> +    - selinux-policy
>>> +    - container-selinux
>>> +    - refpolicy
>>>
>>>    before_install:
>>>      # FYI: known good with HEAD at 8551fc60fc515cd290ba38ee8c758c1f4df52b56
>>> @@ -17,7 +25,19 @@ before_install:
>>>         perl Makefile.PL &&
>>>         make &&
>>>         sudo make install)
>>> +  # install libbpf from sources
>>> +  - git clone https://github.com/libbpf/libbpf
>>> +  - (cd libbpf/src && make PREFIX=/usr/local)
>>> +  - (cd libbpf/src && sudo make install PREFIX=/usr/local)
>>
>> Not packaged on bionic or not recent enough?
> 
> Not packaged, AFAICT.
> 
>>
>>> +  # install Fedora policy and refpolicy
>>> +  - bash travis-ci/setup-policy-fedora.sh
>>> +  - bash travis-ci/setup-policy-refpolicy.sh
>>> +  # establish a fake "selinuxfs" mount (policy/Makefile just greps for selinuxfs)
>>> +  - sudo mkdir -p /tmp/fake-selinuxfs
>>> +  - sudo mount -t tmpfs tmpfs /tmp/fake-selinuxfs
>>> +  - echo 31 >/tmp/fake-selinuxfs/policyvers
>>
>> Fragile; maybe use checkpolicy -V | awk '{print $1}' or equivalent?
> 
> This will get the policy version that checkpolicy supports, but the
> policy Makefile also checks the version supported by the running
> kernel. Since the policy won't actually be loaded in this case, it
> makes sense to just report the highest known version so that the
> Makefile tries to build as much as it can with the checkpolicy it has.
> On second thought, we might even put in just some "infinity" number
> (e.g. 999), since it should be just an additional upper bound to the
> checkpolicy upper bound.

When building policies, we should always build the highest version 
supported by checkpolicy.  libselinux will downgrade automatically at 
load time if necessary to the kernel's version.

> 
>>
>>>
>>>    script:
>>>      - tools/check-syntax -f && git diff --exit-code
>>> -  - make
>>> +  - bash travis-ci/enable-policy.sh targeted  && make POLDEV=/usr/share/selinux/targeted
>>> +  - bash travis-ci/enable-policy.sh refpolicy && make POLDEV=/usr/share/selinux/refpolicy
>>> diff --git a/travis-ci/enable-policy.sh b/travis-ci/enable-policy.sh
>>> new file mode 100644
>>> index 0000000..ae53fbe
>>> --- /dev/null
>>> +++ b/travis-ci/enable-policy.sh
>>> @@ -0,0 +1,10 @@
>>> +#!/bin/bash
>>> +
>>> +set -e
>>> +
>>> +# create a dummy /etc/selinux/config
>>> +sudo mkdir -p /etc/selinux
>>> +sudo tee /etc/selinux/config >/dev/null <<EOF
>>> +SELINUX=disabled
>>> +SELINUXTYPE=$1
>>> +EOF
>>> diff --git a/travis-ci/setup-policy-fedora.sh b/travis-ci/setup-policy-fedora.sh
>>> new file mode 100644
>>> index 0000000..192e234
>>> --- /dev/null
>>> +++ b/travis-ci/setup-policy-fedora.sh
>>> @@ -0,0 +1,35 @@
>>> +#!/bin/bash
>>> +
>>> +set -ex
>>> +
>>> +if ! [ -d selinux-policy/.git ]; then
>>> +     git clone --recursive https://github.com/fedora-selinux/selinux-policy
>>> +     (cd selinux-policy/policy/modules/contrib && git checkout rawhide)
>>> +else
>>> +     (cd selinux-policy && git pull || { git checkout '*' && git pull; })
>>> +     (cd selinux-policy/policy/modules/contrib && git pull)
>>> +fi
>>> +
>>> +if ! [ -d container-selinux/.git ]; then
>>> +     git clone https://github.com/containers/container-selinux.git
>>> +     for f in container.if container.te; do
>>> +             ln -s ../../../../container-selinux/$f \
>>> +                     selinux-policy/policy/modules/contrib/$f
>>> +     done
>>> +else
>>> +     (cd container-selinux && git pull)
>>> +fi
>>
>> Seem brittle / tightly tied to fedora policy internals - is there some
>> more general facility or perhaps they even provide a script for doing
>> this that we could just reuse?
> 
> No, this is simply how the Fedora policy repos are structured. I
> mostly mirrored the logic of .travis.yml from the main repo [1] I
> don't think there's a better way to do this.
> 
> [1] https://github.com/fedora-selinux/selinux-policy/
> 
>>
>>> +
>>> +cd selinux-policy
>>> +
>>> +grep -q refpolicy build.conf && sed -i 's/refpolicy/targeted/' build.conf
>>> +grep -q '^portcon sctp' policy/modules/kernel/corenetwork.te.in && \
>>> +     sed -i '/^portcon sctp/d' policy/modules/kernel/corenetwork.te.in
>>
>> Is this a limitation of the checkpolicy packaged in bionic?  If so,
> 
> Yes, I think it is due to checkpolicy/-module being too old. Maybe it
> should actually be handled in policy/Makefile with a [MOD_]POL_VERS
> check... I'll need to look more carefully into this.
> 
>> should we just grab the upstream selinux userspace and build it ourselves?
> 
> I tried to keep the number of dynamic dependencies on the minimum, but
> perhaps that's indeed the better way to go here...
> 
>>
>>> +
>>> +[ -f policy/modules.conf ] || make conf
>>> +
>>> +make -j`nproc --all`
>>> +sudo make install install-headers
>>> +
>>> +# workaround for different Makefile location in Fedora RPMs
>>> +sudo ln -s include/Makefile /usr/share/selinux/targeted/Makefile
>>> diff --git a/travis-ci/setup-policy-refpolicy.sh b/travis-ci/setup-policy-refpolicy.sh
>>> new file mode 100644
>>> index 0000000..d89b041
>>> --- /dev/null
>>> +++ b/travis-ci/setup-policy-refpolicy.sh
>>> @@ -0,0 +1,22 @@
>>> +#!/bin/bash
>>> +
>>> +set -ex
>>> +
>>> +if ! [ -d refpolicy/.git ]; then
>>> +     git clone https://github.com/SELinuxProject/refpolicy
>>> +else
>>> +     git pull || { git checkout '*' && git pull; }
>>> +fi
>>> +
>>> +cd refpolicy
>>> +
>>> +[ -f policy/modules.conf ] || make conf
>>> +
>>> +grep -q '^portcon sctp' policy/modules/kernel/corenetwork.te.in && \
>>> +     sed -i '/^portcon sctp/d' policy/modules/kernel/corenetwork.te.in
>>> +
>>> +make -j`nproc --all`
>>> +sudo make install install-headers
>>> +
>>> +# workaround for different Makefile location in Fedora RPMs
>>> +sudo ln -s include/Makefile /usr/share/selinux/refpolicy/Makefile
>>>
>>
> 

