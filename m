Return-Path: <SRS0=KDcg=XZ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56E9BC32792
	for <selinux@archiver.kernel.org>; Mon, 30 Sep 2019 13:45:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19EE9216F4
	for <selinux@archiver.kernel.org>; Mon, 30 Sep 2019 13:45:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="ClcuGUBj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730583AbfI3NpJ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 30 Sep 2019 09:45:09 -0400
Received: from USAT19PA22.eemsg.mail.mil ([214.24.22.196]:65241 "EHLO
        USAT19PA22.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730266AbfI3NpJ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 30 Sep 2019 09:45:09 -0400
X-EEMSG-check-017: 33590196|USAT19PA22_ESA_OUT03.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.64,567,1559520000"; 
   d="scan'208";a="33590196"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by USAT19PA22.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 30 Sep 2019 13:43:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1569851039; x=1601387039;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=eYEi6j4hZe9cNRd+MlZ90kl8Sv3g/2OxZ5dc4g0vZHY=;
  b=ClcuGUBjRDxu8rwOvNAzvgaO3C1xSRwhVm7HKs8SOpHsvxNontLoxvAZ
   9xsxqC1Ha+oK2u4wXYsFC0q7KgbWlbr4NzzjwZkbX791FSTwJF9P16Ik2
   5KW73VQGPxKOqBqT153z/zejU3xm+nJgxUhk33l4cwWcdbtIHtD+czToo
   saugC377AFa3F6qY0y0FK76rCSNCvcsUppK1Gu9W11i73m8xg8d32CfcO
   MLL/JVD7uqOlY2q9uslksjwHGn+brR9MxmmK/MdJUn9GgoMYHMHV8Xad5
   exb/dr05UHRekfWQYpe09nDFz7PkGDZL5ginUE65ej/yoBJultRya8W2p
   g==;
X-IronPort-AV: E=Sophos;i="5.64,567,1559520000"; 
   d="scan'208";a="33513931"
IronPort-PHdr: =?us-ascii?q?9a23=3A7QTiQxWqvdMtzDPybQgmmdEMD7DV8LGtZVwlr6?=
 =?us-ascii?q?E/grcLSJyIuqrYbReBt8tkgFKBZ4jH8fUM07OQ7/m7HzBaqsjZ+Fk5M7V0Hy?=
 =?us-ascii?q?cfjssXmwFySOWkMmbcaMDQUiohAc5ZX0Vk9XzoeWJcGcL5ekGA6ibqtW1aFR?=
 =?us-ascii?q?rwLxd6KfroEYDOkcu3y/qy+5rOaAlUmTaxe7x/IAi4oAnLucQan4RuJ6ctxh?=
 =?us-ascii?q?DUvnZGZuNayH9yK1mOhRj8/MCw/JBi8yRUpf0s8tNLXLv5caolU7FWFSwqPG?=
 =?us-ascii?q?8p6sLlsxnDVhaP6WAHUmoKiBpIAhPK4w/8U5zsryb1rOt92C2dPc3rUbA5XC?=
 =?us-ascii?q?mp4ql3RBP0jioMKiU0+3/LhMNukK1boQqhpx1hzI7SfIGVL+d1cqfEcd8HWW?=
 =?us-ascii?q?ZNQsNdWipPDYOma4sEEvQPM+BWoYLgo1cCtBWzCA2pCO7p1zRGhGL53bci3u?=
 =?us-ascii?q?o8Dw/G0gwuEdEAvnvao9r6NrsdX++uwanUzzjOde9a1Svz5YXKdB0qvPGCXa?=
 =?us-ascii?q?h3ccrU0UQhCh/FgUuIqYzlITyV0PkGvXWe7+V6UeKvj3AoqgFsqTWo3ccjl5?=
 =?us-ascii?q?LJi5kJylHE6Sp5wIE1Kce+SE5ge9GoCpRQtyaEN4ZvRM4pXm9muCE/yrIcuJ?=
 =?us-ascii?q?67ejAHyIg5yBLFavyHdZCE4h3iVOaNITd4mWlqdKijiBa19EitzPD3WMqs0F?=
 =?us-ascii?q?tSsyZIndbBumoN2hDO8MSLVPRw8lm71TqS0Q3Y9/tKLloulaXBLp4s2rswlp?=
 =?us-ascii?q?0OvkvdBiL2g0D2jLOOdkUj5+io9/zrYrX4qZ+YMI95kh3+Pb40msy+HOQ4KR?=
 =?us-ascii?q?ICX3Sb+Oug1L3j+lf1QLNWgf0tjqbVqpXaJcUfpqKhAg9V1Jgs6wqnAju739?=
 =?us-ascii?q?kVkmMLIVJYdB6dkYTkNE/CLOrlAfunhlSjijZrx/TIPr37BZXNK2DOkKz8cr?=
 =?us-ascii?q?Zm8ENc1Aoywsxf55JTEL0BJunzVVXruNzXCR85LRS4w/z7B9VlyoMeRWWPD7?=
 =?us-ascii?q?eeMKPXtl+I/eQvLPOQa4ALozv9MeYq6OPujXAjhV8RZ7Wm3ZwSaHqgBPRpP1?=
 =?us-ascii?q?2ZYWbwgtcGCWoKpRQxTOjriF2ETD5SaG2/X7wz5j4lEoKqF4TDSZ63gLyHwi?=
 =?us-ascii?q?i7GodaZmdcClCDQj/UcNCjXfsWZSDaB8h6lDUPWLvpH4gk0gqovQT346BqIu?=
 =?us-ascii?q?rd5msTspe1kJBu6unSkwwi3SJ7At7b0GyXSWxw2GQSSGwYxqd69Hdhx0+D3K?=
 =?us-ascii?q?4wuPlREdhe9rsdSQshHYLNxOx9TdbpU0TOecnfGwXuecmvHTxkFoF5+NQJeU?=
 =?us-ascii?q?soXoz53x0=3D?=
X-IPAS-Result: =?us-ascii?q?A2CnCAChA5Jd/wHyM5BmHAEBAQQBAQwEAQGBZ4F0Km1TM?=
 =?us-ascii?q?iqEIo5wUAMGgREliXWRKgkBAQEBAQEBAQErCQECAQGEQAKDQyM4EwIMAQEBB?=
 =?us-ascii?q?AEBAQEBBQMBAWyFLQyCOikBgmcBAQEBAgEjFVELDgoCAiYCAlcGAQwGAgEBg?=
 =?us-ascii?q?l8/AYF2BQ8Pq2gbNXWBMoVNgyaBSIEMKIwOGHiBB4ERJwyCXz6BDoFTAoRsg?=
 =?us-ascii?q?lgElgqXDYIsgi6EV4UVB4hkBhuDKZYNjiGHJ3GNKIVwIYFYKwgCGAghD4MnC?=
 =?us-ascii?q?UcQFIVAglaCbIEPhB4lAzCBBgEBj3gBAQ?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 30 Sep 2019 13:43:58 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x8UDhwJG028001;
        Mon, 30 Sep 2019 09:43:58 -0400
Subject: Re: [PATCH testsuite 3/3] travis: test building the test policy
 package
To:     Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org
References: <20190930104850.5482-1-omosnace@redhat.com>
 <20190930104850.5482-4-omosnace@redhat.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <2dfde121-d786-6ba3-0820-953cfbba7033@tycho.nsa.gov>
Date:   Mon, 30 Sep 2019 09:43:58 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20190930104850.5482-4-omosnace@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 9/30/19 6:48 AM, Ondrej Mosnacek wrote:
> Download, build, and install Fedora policy & refpolicy and try building
> the test policy package against both of them.

I guess this is a necessary first step to actually getting the testsuite 
to run on travis, which would be the more important goal.  That 
obviously requires actually enabling SELinux on bionic, unless we could 
get travis-ci to offer fedora or centos images.

> 
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>   .travis.yml                         | 24 ++++++++++++++++++--
>   travis-ci/enable-policy.sh          | 10 +++++++++
>   travis-ci/setup-policy-fedora.sh    | 35 +++++++++++++++++++++++++++++
>   travis-ci/setup-policy-refpolicy.sh | 22 ++++++++++++++++++
>   4 files changed, 89 insertions(+), 2 deletions(-)
>   create mode 100644 travis-ci/enable-policy.sh
>   create mode 100644 travis-ci/setup-policy-fedora.sh
>   create mode 100644 travis-ci/setup-policy-refpolicy.sh
> 
> diff --git a/.travis.yml b/.travis.yml
> index fbbe98d..c8cd44e 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -1,6 +1,6 @@
>   language: c
>   
> -dist: xenial
> +dist: bionic
>   
>   addons:
>     apt:
> @@ -8,6 +8,14 @@ addons:
>         - astyle
>         - libselinux1-dev
>         - libsctp-dev
> +      - checkpolicy
> +      - semodule-utils
> +
> +cache:
> +  directories:
> +    - selinux-policy
> +    - container-selinux
> +    - refpolicy
>   
>   before_install:
>     # FYI: known good with HEAD at 8551fc60fc515cd290ba38ee8c758c1f4df52b56
> @@ -17,7 +25,19 @@ before_install:
>        perl Makefile.PL &&
>        make &&
>        sudo make install)
> +  # install libbpf from sources
> +  - git clone https://github.com/libbpf/libbpf
> +  - (cd libbpf/src && make PREFIX=/usr/local)
> +  - (cd libbpf/src && sudo make install PREFIX=/usr/local)

Not packaged on bionic or not recent enough?

> +  # install Fedora policy and refpolicy
> +  - bash travis-ci/setup-policy-fedora.sh
> +  - bash travis-ci/setup-policy-refpolicy.sh
> +  # establish a fake "selinuxfs" mount (policy/Makefile just greps for selinuxfs)
> +  - sudo mkdir -p /tmp/fake-selinuxfs
> +  - sudo mount -t tmpfs tmpfs /tmp/fake-selinuxfs
> +  - echo 31 >/tmp/fake-selinuxfs/policyvers

Fragile; maybe use checkpolicy -V | awk '{print $1}' or equivalent?

>   
>   script:
>     - tools/check-syntax -f && git diff --exit-code
> -  - make
> +  - bash travis-ci/enable-policy.sh targeted  && make POLDEV=/usr/share/selinux/targeted
> +  - bash travis-ci/enable-policy.sh refpolicy && make POLDEV=/usr/share/selinux/refpolicy
> diff --git a/travis-ci/enable-policy.sh b/travis-ci/enable-policy.sh
> new file mode 100644
> index 0000000..ae53fbe
> --- /dev/null
> +++ b/travis-ci/enable-policy.sh
> @@ -0,0 +1,10 @@
> +#!/bin/bash
> +
> +set -e
> +
> +# create a dummy /etc/selinux/config
> +sudo mkdir -p /etc/selinux
> +sudo tee /etc/selinux/config >/dev/null <<EOF
> +SELINUX=disabled
> +SELINUXTYPE=$1
> +EOF
> diff --git a/travis-ci/setup-policy-fedora.sh b/travis-ci/setup-policy-fedora.sh
> new file mode 100644
> index 0000000..192e234
> --- /dev/null
> +++ b/travis-ci/setup-policy-fedora.sh
> @@ -0,0 +1,35 @@
> +#!/bin/bash
> +
> +set -ex
> +
> +if ! [ -d selinux-policy/.git ]; then
> +	git clone --recursive https://github.com/fedora-selinux/selinux-policy
> +	(cd selinux-policy/policy/modules/contrib && git checkout rawhide)
> +else
> +	(cd selinux-policy && git pull || { git checkout '*' && git pull; })
> +	(cd selinux-policy/policy/modules/contrib && git pull)
> +fi
> +
> +if ! [ -d container-selinux/.git ]; then
> +	git clone https://github.com/containers/container-selinux.git
> +	for f in container.if container.te; do
> +		ln -s ../../../../container-selinux/$f \
> +			selinux-policy/policy/modules/contrib/$f
> +	done
> +else
> +	(cd container-selinux && git pull)
> +fi

Seem brittle / tightly tied to fedora policy internals - is there some 
more general facility or perhaps they even provide a script for doing 
this that we could just reuse?

> +
> +cd selinux-policy
> +
> +grep -q refpolicy build.conf && sed -i 's/refpolicy/targeted/' build.conf
> +grep -q '^portcon sctp' policy/modules/kernel/corenetwork.te.in && \
> +	sed -i '/^portcon sctp/d' policy/modules/kernel/corenetwork.te.in

Is this a limitation of the checkpolicy packaged in bionic?  If so, 
should we just grab the upstream selinux userspace and build it ourselves?

> +
> +[ -f policy/modules.conf ] || make conf
> +
> +make -j`nproc --all`
> +sudo make install install-headers
> +
> +# workaround for different Makefile location in Fedora RPMs
> +sudo ln -s include/Makefile /usr/share/selinux/targeted/Makefile
> diff --git a/travis-ci/setup-policy-refpolicy.sh b/travis-ci/setup-policy-refpolicy.sh
> new file mode 100644
> index 0000000..d89b041
> --- /dev/null
> +++ b/travis-ci/setup-policy-refpolicy.sh
> @@ -0,0 +1,22 @@
> +#!/bin/bash
> +
> +set -ex
> +
> +if ! [ -d refpolicy/.git ]; then
> +	git clone https://github.com/SELinuxProject/refpolicy
> +else
> +	git pull || { git checkout '*' && git pull; }
> +fi
> +
> +cd refpolicy
> +
> +[ -f policy/modules.conf ] || make conf
> +
> +grep -q '^portcon sctp' policy/modules/kernel/corenetwork.te.in && \
> +	sed -i '/^portcon sctp/d' policy/modules/kernel/corenetwork.te.in
> +
> +make -j`nproc --all`
> +sudo make install install-headers
> +
> +# workaround for different Makefile location in Fedora RPMs
> +sudo ln -s include/Makefile /usr/share/selinux/refpolicy/Makefile
> 

