Return-Path: <SRS0=KDcg=XZ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DEFEC32792
	for <selinux@archiver.kernel.org>; Mon, 30 Sep 2019 13:52:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32A742086A
	for <selinux@archiver.kernel.org>; Mon, 30 Sep 2019 13:52:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="C4sY8+6f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731122AbfI3NwA (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 30 Sep 2019 09:52:00 -0400
Received: from USFB19PA34.eemsg.mail.mil ([214.24.26.197]:39173 "EHLO
        USFB19PA34.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730876AbfI3NwA (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 30 Sep 2019 09:52:00 -0400
X-EEMSG-check-017: 13183484|USFB19PA34_ESA_OUT04.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.64,567,1559520000"; 
   d="scan'208";a="13183484"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by USFB19PA34.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 30 Sep 2019 13:51:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1569851518; x=1601387518;
  h=subject:from:to:references:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=qhEaiISgDK3T1UOsdE4rbELt1Uk+72E2jqjq8KNm8W0=;
  b=C4sY8+6fq3VBYaFfQOiBjV+B2le6IuahXHI5OFsHHQbxGmbtdX7CTv1p
   BP0FQDZWPV0BVBVe+BWZy4XF1/ebloldcVqVq66Sy5lcJ8f+cKlBARP1C
   O8P4RW76rZ2osgS2qFEu/mkmde9DKJiw97PWj2EwUjbC6fGUfh6ky52De
   xuBEbHNTaIp7JHQDvBtBcntYgvy1yByWttIKgMF3HaEXYsoFHxS5epQ0e
   7mv4SPLFm1lH1/w6YDa4HM3W6jsJAOH5oQ/Ns7QszeY3LWkhBFUOP0geZ
   WKir4tf6JALN4F8gdSXrEVPfQcPrYOTd5lgmub3jMgXaST+StE43Ehl4m
   g==;
X-IronPort-AV: E=Sophos;i="5.64,567,1559520000"; 
   d="scan'208";a="28454176"
IronPort-PHdr: =?us-ascii?q?9a23=3ALlb+QRZJyl7sDNamVpkDPdD/LSx+4OfEezUN45?=
 =?us-ascii?q?9isYplN5qZrs+8bnLW6fgltlLVR4KTs6sC17ON9fy6EjJbqb+681k6OKRWUB?=
 =?us-ascii?q?EEjchE1ycBO+WiTXPBEfjxciYhF95DXlI2t1uyMExSBdqsLwaK+i764jEdAA?=
 =?us-ascii?q?jwOhRoLerpBIHSk9631+ev8JHPfglEnjWwba58IRmsogjdqMYajIpsJ60s1h?=
 =?us-ascii?q?bHv3xEdvhMy2h1P1yThRH85smx/J5n7Stdvu8q+tBDX6vnYak2VKRUAzs6PW?=
 =?us-ascii?q?874s3rrgTDQhCU5nQASGUWkwFHDBbD4RrnQ5r+qCr6tu562CmHIc37SK0/VD?=
 =?us-ascii?q?q+46t3ThLjlTwKPCAl/m7JlsNwjbpboBO/qBx5347Ue5yeOP5ncq/AYd8WWW?=
 =?us-ascii?q?9NU8BfWCxbBoO3cpUBAewPM+1Fq4XxvlUDoB+7CQSqGejhyCJHhmXu0KMn0+?=
 =?us-ascii?q?ovDw/G0g8uEd0Av3vbrsn6OqgJXOCpz6TF1ynPY+9Y1Dr/7oXDbxAvoeuLXb?=
 =?us-ascii?q?J1acff1FUvGB3djlWQt4PlOS6e2PkIs2eB6+pgUfygim46oAx2uTig29wsh5?=
 =?us-ascii?q?LVhoMV1l/E9SJ5zJwzJd2jUkF3e9GkEJxOtyyDMYZ9X80sQ2ZtuCkgy70Gv4?=
 =?us-ascii?q?a2fDQUx5g9xh7fbeSLc4eJ4hL/VOaRPCx3iGh5d7K4gha/91WrxO7kVsSszV?=
 =?us-ascii?q?pHoSVInsPMu3wQzRDf9MeKRuVn8ku83zuEyhrd5fteIU8ukKrWM5shwrktmZ?=
 =?us-ascii?q?UNqUnDBSr2mFnujK+Ra0Uk5vCk6+T5bbXioZ+RL5N0hRvkMqQvh8y/Gv40Mh?=
 =?us-ascii?q?QOXmeH+eS806fv/UvlT7VRkvI6iKzZsJHeJcgDp665BRFa0po75hqiADqr38?=
 =?us-ascii?q?4UkHkaIF5fZh6KgJblN0vTLPzgCPewmVWskDNlx/DcOb3hB43ALmPen7f6Zr?=
 =?us-ascii?q?t9905dxxYzzdBY/Z5UDKoBL+jpVk/+s9zYEAc1MxaozOb/FNV9yoQeVHqIAq?=
 =?us-ascii?q?+cN6PSqlmI6fgzLOaSf4IVoijyJOUl5/H0kX81g0MSfa6s3ZEPcnC3AuxmI1?=
 =?us-ascii?q?mFYXrrmtoBCnkFvg4/TOzslV2DXiVeZ2i9X60i/DE3EoGmApnZRoCrnrOB2D?=
 =?us-ascii?q?23HppMZmBJWRiwFiLPcYmeVvVETSWJJMZqnz9MAb+kTJQn3BqjnBX3x7puMq?=
 =?us-ascii?q?zf/ShO8dr42dx04fDDvQ89+CYyDMmH1WyJCWZukTAmXTgziZtjrFR9x1HL6q?=
 =?us-ascii?q?1xh/hVBJQH/P9SehsrPp7biephApb9XRyXLYTBc0qvXtjzWWJ5ddk22dJbJh?=
 =?us-ascii?q?8mStg=3D?=
X-IPAS-Result: =?us-ascii?q?A2CvAACZBJJd/wHyM5BmGwEBAQEDAQEBDAMBAQGBVgMBA?=
 =?us-ascii?q?QELAYFzKm1TMiqEIo5vUAMGgTaJdZEqCQEBAQEBAQEBASsJAQIBAYRAAoNDI?=
 =?us-ascii?q?zcGDgIMAQEBBAEBAQEBBQMBAWyFLQyCOikBgmgBBSMPAQVRCQIOCgICJgICV?=
 =?us-ascii?q?wYBDAYCAQGCXz8BgXYUD5FDmiwbNXWBMohzgUiBDCgBjA0YeIEHgREngms+g?=
 =?us-ascii?q?Q6BUwKEbIJYBK0XgiyCLoRXhRUHiGQGG4Mplg2OIYcncY0ohW8igVgrCAIYC?=
 =?us-ascii?q?CEPgycJRxAUhUCCVoJsgQ+EHiUDMIEGAQGPeAEB?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 30 Sep 2019 13:51:57 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x8UDptbY028071;
        Mon, 30 Sep 2019 09:51:56 -0400
Subject: Re: [PATCH testsuite 3/3] travis: test building the test policy
 package
From:   Stephen Smalley <sds@tycho.nsa.gov>
To:     Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org
References: <20190930104850.5482-1-omosnace@redhat.com>
 <20190930104850.5482-4-omosnace@redhat.com>
 <2dfde121-d786-6ba3-0820-953cfbba7033@tycho.nsa.gov>
Message-ID: <a94ca288-49a6-b985-03d3-8fa9fc5e7a11@tycho.nsa.gov>
Date:   Mon, 30 Sep 2019 09:51:55 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <2dfde121-d786-6ba3-0820-953cfbba7033@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 9/30/19 9:43 AM, Stephen Smalley wrote:
> On 9/30/19 6:48 AM, Ondrej Mosnacek wrote:
>> Download, build, and install Fedora policy & refpolicy and try building
>> the test policy package against both of them.
> 
> I guess this is a necessary first step to actually getting the testsuite 
> to run on travis, which would be the more important goal.  That 
> obviously requires actually enabling SELinux on bionic, unless we could 
> get travis-ci to offer fedora or centos images.
> 
>>
>> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
>> ---
>>   .travis.yml                         | 24 ++++++++++++++++++--
>>   travis-ci/enable-policy.sh          | 10 +++++++++
>>   travis-ci/setup-policy-fedora.sh    | 35 +++++++++++++++++++++++++++++
>>   travis-ci/setup-policy-refpolicy.sh | 22 ++++++++++++++++++
>>   4 files changed, 89 insertions(+), 2 deletions(-)
>>   create mode 100644 travis-ci/enable-policy.sh
>>   create mode 100644 travis-ci/setup-policy-fedora.sh
>>   create mode 100644 travis-ci/setup-policy-refpolicy.sh
>>
>> diff --git a/.travis.yml b/.travis.yml
>> index fbbe98d..c8cd44e 100644
>> --- a/.travis.yml
>> +++ b/.travis.yml
>> @@ -1,6 +1,6 @@
>>   language: c
>> -dist: xenial
>> +dist: bionic
>>   addons:
>>     apt:
>> @@ -8,6 +8,14 @@ addons:
>>         - astyle
>>         - libselinux1-dev
>>         - libsctp-dev
>> +      - checkpolicy
>> +      - semodule-utils
>> +
>> +cache:
>> +  directories:
>> +    - selinux-policy
>> +    - container-selinux
>> +    - refpolicy
>>   before_install:
>>     # FYI: known good with HEAD at 
>> 8551fc60fc515cd290ba38ee8c758c1f4df52b56
>> @@ -17,7 +25,19 @@ before_install:
>>        perl Makefile.PL &&
>>        make &&
>>        sudo make install)
>> +  # install libbpf from sources
>> +  - git clone https://github.com/libbpf/libbpf
>> +  - (cd libbpf/src && make PREFIX=/usr/local)
>> +  - (cd libbpf/src && sudo make install PREFIX=/usr/local)
> 
> Not packaged on bionic or not recent enough?
> 
>> +  # install Fedora policy and refpolicy
>> +  - bash travis-ci/setup-policy-fedora.sh
>> +  - bash travis-ci/setup-policy-refpolicy.sh
>> +  # establish a fake "selinuxfs" mount (policy/Makefile just greps 
>> for selinuxfs)
>> +  - sudo mkdir -p /tmp/fake-selinuxfs
>> +  - sudo mount -t tmpfs tmpfs /tmp/fake-selinuxfs
>> +  - echo 31 >/tmp/fake-selinuxfs/policyvers
> 
> Fragile; maybe use checkpolicy -V | awk '{print $1}' or equivalent?

Looks like the idiom we use in selinux-testsuite/policy/Makefile and 
refpolicy/Rules.monolithic is checkpolicy -V | cut -f 1 -d ' '

> 
>>   script:
>>     - tools/check-syntax -f && git diff --exit-code
>> -  - make
>> +  - bash travis-ci/enable-policy.sh targeted  && make 
>> POLDEV=/usr/share/selinux/targeted
>> +  - bash travis-ci/enable-policy.sh refpolicy && make 
>> POLDEV=/usr/share/selinux/refpolicy
>> diff --git a/travis-ci/enable-policy.sh b/travis-ci/enable-policy.sh
>> new file mode 100644
>> index 0000000..ae53fbe
>> --- /dev/null
>> +++ b/travis-ci/enable-policy.sh
>> @@ -0,0 +1,10 @@
>> +#!/bin/bash
>> +
>> +set -e
>> +
>> +# create a dummy /etc/selinux/config
>> +sudo mkdir -p /etc/selinux
>> +sudo tee /etc/selinux/config >/dev/null <<EOF
>> +SELINUX=disabled
>> +SELINUXTYPE=$1
>> +EOF
>> diff --git a/travis-ci/setup-policy-fedora.sh 
>> b/travis-ci/setup-policy-fedora.sh
>> new file mode 100644
>> index 0000000..192e234
>> --- /dev/null
>> +++ b/travis-ci/setup-policy-fedora.sh
>> @@ -0,0 +1,35 @@
>> +#!/bin/bash
>> +
>> +set -ex
>> +
>> +if ! [ -d selinux-policy/.git ]; then
>> +    git clone --recursive 
>> https://github.com/fedora-selinux/selinux-policy
>> +    (cd selinux-policy/policy/modules/contrib && git checkout rawhide)
>> +else
>> +    (cd selinux-policy && git pull || { git checkout '*' && git pull; })
>> +    (cd selinux-policy/policy/modules/contrib && git pull)
>> +fi
>> +
>> +if ! [ -d container-selinux/.git ]; then
>> +    git clone https://github.com/containers/container-selinux.git
>> +    for f in container.if container.te; do
>> +        ln -s ../../../../container-selinux/$f \
>> +            selinux-policy/policy/modules/contrib/$f
>> +    done
>> +else
>> +    (cd container-selinux && git pull)
>> +fi
> 
> Seem brittle / tightly tied to fedora policy internals - is there some 
> more general facility or perhaps they even provide a script for doing 
> this that we could just reuse?
> 
>> +
>> +cd selinux-policy
>> +
>> +grep -q refpolicy build.conf && sed -i 's/refpolicy/targeted/' 
>> build.conf
>> +grep -q '^portcon sctp' policy/modules/kernel/corenetwork.te.in && \
>> +    sed -i '/^portcon sctp/d' policy/modules/kernel/corenetwork.te.in
> 
> Is this a limitation of the checkpolicy packaged in bionic?  If so, 
> should we just grab the upstream selinux userspace and build it ourselves?
> 
>> +
>> +[ -f policy/modules.conf ] || make conf
>> +
>> +make -j`nproc --all`
>> +sudo make install install-headers
>> +
>> +# workaround for different Makefile location in Fedora RPMs
>> +sudo ln -s include/Makefile /usr/share/selinux/targeted/Makefile
>> diff --git a/travis-ci/setup-policy-refpolicy.sh 
>> b/travis-ci/setup-policy-refpolicy.sh
>> new file mode 100644
>> index 0000000..d89b041
>> --- /dev/null
>> +++ b/travis-ci/setup-policy-refpolicy.sh
>> @@ -0,0 +1,22 @@
>> +#!/bin/bash
>> +
>> +set -ex
>> +
>> +if ! [ -d refpolicy/.git ]; then
>> +    git clone https://github.com/SELinuxProject/refpolicy
>> +else
>> +    git pull || { git checkout '*' && git pull; }
>> +fi
>> +
>> +cd refpolicy
>> +
>> +[ -f policy/modules.conf ] || make conf
>> +
>> +grep -q '^portcon sctp' policy/modules/kernel/corenetwork.te.in && \
>> +    sed -i '/^portcon sctp/d' policy/modules/kernel/corenetwork.te.in
>> +
>> +make -j`nproc --all`
>> +sudo make install install-headers
>> +
>> +# workaround for different Makefile location in Fedora RPMs
>> +sudo ln -s include/Makefile /usr/share/selinux/refpolicy/Makefile
>>
> 

