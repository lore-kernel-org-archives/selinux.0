Return-Path: <SRS0=M/73=ZN=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CCEAC432C0
	for <selinux@archiver.kernel.org>; Thu, 21 Nov 2019 17:03:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB7C0206CC
	for <selinux@archiver.kernel.org>; Thu, 21 Nov 2019 17:02:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="Q38xSTB4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726541AbfKURC7 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 21 Nov 2019 12:02:59 -0500
Received: from USFB19PA33.eemsg.mail.mil ([214.24.26.196]:3863 "EHLO
        USFB19PA33.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726379AbfKURC7 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 21 Nov 2019 12:02:59 -0500
X-EEMSG-check-017: 28947961|USFB19PA33_ESA_OUT03.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.69,226,1571702400"; 
   d="scan'208";a="28947961"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by USFB19PA33.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 21 Nov 2019 17:02:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1574355777; x=1605891777;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=XapnBdsfM52tYJIk0wzLTvZw2Llm+3a8yWAsLyTnmPs=;
  b=Q38xSTB4YPCR0vPrUKRg6I+Pot0PdA4Zyq+R7OeyDiNOY1hzWZ0BLAV8
   aVRgkBgi9cXGN4R1KvPJ4ansLvwCcf4QszB/g5SOBWzyKTVEGmVsPbCdz
   rCl10sdfvGt/vNrILPfD1lU+QjnxMNrVcBxOJH8mnFPzJBQwuUcs/sNRV
   4vRb/fncQDOBB1XavyXMa7OrSVsXoLbimQ+yKzbNbib9HmvAPt1oswz30
   gIs3RnSdHqmeL3UaExHQUv6KIdsPnFmk9ODIzHv1yVh9EOrH9PQd+sivO
   rm58px1AsfEaUSiLmAPLl5gEkF7mKXpmBbHJ1oIjfIAKKY9i1aPzyBvaF
   g==;
X-IronPort-AV: E=Sophos;i="5.69,226,1571702400"; 
   d="scan'208";a="30372775"
IronPort-PHdr: =?us-ascii?q?9a23=3AfYUjnhIeaw3gXoosN9mcpTZWNBhigK39O0sv0r?=
 =?us-ascii?q?FitYgfLvXxwZ3uMQTl6Ol3ixeRBMOHsqkC0reM+PG9EUU7or+5+EgYd5JNUx?=
 =?us-ascii?q?JXwe43pCcHRPC/NEvgMfTxZDY7FskRHHVs/nW8LFQHUJ2mPw6arXK99yMdFQ?=
 =?us-ascii?q?viPgRpOOv1BpTSj8Oq3Oyu5pHfeQpFiCezbL9oMRm7rRvdusYSjIZiN6081g?=
 =?us-ascii?q?bHrnxUdupM2GhmP0iTnxHy5sex+J5s7SFdsO8/+sBDTKv3Yb02QaRXAzo6PW?=
 =?us-ascii?q?814tbrtQTYQguU+nQcSGQWnQFWDAXD8Rr3Q43+sir+tup6xSmaIcj7Rq06VD?=
 =?us-ascii?q?i+86tmTgLjhTwZPDAl7m7Yls1wjLpaoB2/oRx/35XUa5yROPZnY6/RYc8WSW?=
 =?us-ascii?q?9HU8lfTSxBBp63YZUJAeQPIO1Uq5Dxq0UKoBe7AwSnGeHhxSJShnLuwKM0ze?=
 =?us-ascii?q?ohHwHF0gIuEd0Bv3bbo8n6OqoJTeC4zrPFwSnfY/5Y2zrw7pXDfBA7ofGLWL?=
 =?us-ascii?q?J9adffyVUxGAPdjlWft4rlNC6I2OQIqWeb6+5gWvyvimU6rAxxuSWgxtw3h4?=
 =?us-ascii?q?nVhoMa1lDE9SJjzIYzPt23UlR3YdGjEJtOriyXMZZ9TM0lQ2Ftoik6y7sGtI?=
 =?us-ascii?q?a4fCcU0pQnwQDQa/idf4iP+BLjW/6dITh5hHJ5eLK/mg29/VK8xe37U8m51k?=
 =?us-ascii?q?tBoCldktTUq3wA2BPe5tKHR/dg5EutxzmC2x7J5u1ZJ00/iLDVJIQ7wrEqk5?=
 =?us-ascii?q?oeqUHDHijrl0rolKKWbUAk+vSw6+Tgf7XmuoeQN49qhQH6NaQjgtC/Dv4iMg?=
 =?us-ascii?q?gPQmib4v6w1KHj/ELlQLVKiec6kq/Fv5DBOcsXvKu5Aw5R0oo76ha/CSmp0M?=
 =?us-ascii?q?gAkHUaI19IdwiLgoj0N13UPvz1Aumzj06xnDtzwvDJJLzhApHDLnjZl7fheK?=
 =?us-ascii?q?5w61VBxwoo1t1f+5JVBa0BIPL0QEPxssfYAQUjPwy7xObnFs1x1pkCVmKXHq?=
 =?us-ascii?q?+ZLKTSvEeP5uIqJOmMf4kVtyzhJPc7/PPul2E2lkIdfaazwZsbcmy3HvNjI0?=
 =?us-ascii?q?+Be3rjns8BEXsWvgo5VOHqk0ONUTpSZ3a0QqI96So2CJypDYjdXIChmr+B0z?=
 =?us-ascii?q?mhHp1QeG9GDkqAEXDyd4WLCL8wb3e1JMN7nz5McL+6TYYq2BLm4Aj/zKFhJ+?=
 =?us-ascii?q?HZ0jcVuZLqyJ5+4OiF0Vkp+Dh1CdmN+3+CQnsynW4SQTIymqdlrh9T0FCGhJ?=
 =?us-ascii?q?NkjuRYGNob3PZAVgM3JNaI1OBhI8zjUQLGONGSQRCpRcvwUmJ5dc4439JbOx?=
 =?us-ascii?q?U1IN6llB2WmnPwUrI=3D?=
X-IPAS-Result: =?us-ascii?q?A2ClAAAAw9Zd/wHyM5BlGgEBAQEBAQEBAQMBAQEBEQEBA?=
 =?us-ascii?q?QICAQEBAYF+gXQsbFUyKoQqjwNUBoE3iWeRQwkBAQEBAQEBAQErCQECAQGEQ?=
 =?us-ascii?q?AKCKCQ4EwIQAQEBBAEBAQEBBQMBAWyFNwyCOykBgm0BBSMVUQsOCgICJgICV?=
 =?us-ascii?q?wYBDAYCAQGCXz8BglIlD6xwGjV1gTKFToM1gUiBDiiMFhp4gQeBESeCaz6BD?=
 =?us-ascii?q?oE7GQKEcYJeBJZfRpcLgjWCN4RjhScHiQIGG4MxlmeOSIc+eo1uhXcigVgrC?=
 =?us-ascii?q?AIYCCEPgycJRxEUijuFFC6BD4QgIwMwAYEEAQGQPgEB?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 21 Nov 2019 17:02:47 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id xALH2jBm014473;
        Thu, 21 Nov 2019 12:02:46 -0500
Subject: Re: [PATCH testsuite v4 3/3] travis: test building the test policy
 package
To:     Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org
References: <20191118145238.408124-1-omosnace@redhat.com>
 <20191118145238.408124-4-omosnace@redhat.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <5883b9fc-882e-27ea-bd3a-0301bf2afae4@tycho.nsa.gov>
Date:   Thu, 21 Nov 2019 12:02:45 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191118145238.408124-4-omosnace@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 11/18/19 9:52 AM, Ondrej Mosnacek wrote:
> Download, build, and install Fedora policy & refpolicy and try building
> the test policy package against both of them.
> 
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>

Thanks, all 3 patches applied.

> ---
>   .travis.yml                         | 48 ++++++++++++++++++++++++++---
>   policy/Makefile                     | 11 ++++---
>   travis-ci/enable-policy.sh          | 10 ++++++
>   travis-ci/setup-policy-fedora.sh    | 33 ++++++++++++++++++++
>   travis-ci/setup-policy-refpolicy.sh | 19 ++++++++++++
>   5 files changed, 113 insertions(+), 8 deletions(-)
>   create mode 100644 travis-ci/enable-policy.sh
>   create mode 100644 travis-ci/setup-policy-fedora.sh
>   create mode 100644 travis-ci/setup-policy-refpolicy.sh
> 
> diff --git a/.travis.yml b/.travis.yml
> index fbbe98d..42b2490 100644
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
> @@ -8,16 +8,56 @@ addons:
>         - astyle
>         - libselinux1-dev
>         - libsctp-dev
> +      - libaudit-dev
> +      - libcap-dev
> +      - libdbus-glib-1-dev
> +      - xmlto
> +
> +cache:
> +  directories:
> +    - selinux-policy
> +    - container-selinux
> +    - refpolicy
>   
>   before_install:
> +  - export LIBRARY_PATH=/usr/local/lib
> +  - export LD_LIBRARY_PATH=/usr/local/lib
>     # FYI: known good with HEAD at 8551fc60fc515cd290ba38ee8c758c1f4df52b56
>     - git clone https://github.com/perltidy/perltidy.git perltidy
>     - |
>       (cd perltidy &&
>        perl Makefile.PL &&
> -     make &&
> -     sudo make install)
> +     make PREFIX=/usr/local &&
> +     sudo make install PREFIX=/usr/local)
> +  # install libbpf from sources
> +  - git clone https://github.com/libbpf/libbpf
> +  - (cd libbpf/src && make PREFIX=/usr/local)
> +  - (cd libbpf/src && sudo make install PREFIX=/usr/local)
> +  # install keyutils from sources
> +  - git clone https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/keyutils.git
> +  - KEYUTILS_OPTS=""
> +  - KEYUTILS_OPTS+="BINDIR=/usr/local/bin SBINDIR=/usr/local/sbin "
> +  - KEYUTILS_OPTS+="LIBDIR=/usr/local/lib USRLIBDIR=/usr/local/lib "
> +  - KEYUTILS_OPTS+="INCLUDEDIR=/usr/local/include "
> +  - KEYUTILS_OPTS+="SHAREDIR=/usr/local/share/keyutils MANDIR=/usr/local/share/man"
> +  - (cd keyutils && make $KEYUTILS_OPTS)
> +  - (cd keyutils && sudo make install $KEYUTILS_OPTS)
> +  # install SELinux userspace from source
> +  - git clone https://github.com/SELinuxProject/selinux
> +  - (cd selinux && sudo make install PREFIX=/usr/local SHLIBDIR=/usr/local/lib)
> +  # install Fedora policy and refpolicy
> +  - bash travis-ci/setup-policy-fedora.sh
> +  - bash travis-ci/setup-policy-refpolicy.sh
> +  # establish a fake "selinuxfs" mount (policy/Makefile just greps for selinuxfs)
> +  - sudo mkdir -p /tmp/fake-selinuxfs
> +  - sudo mount -t tmpfs tmpfs /tmp/fake-selinuxfs
> +  - echo 999 >/tmp/fake-selinuxfs/policyvers
>   
>   script:
>     - tools/check-syntax -f && git diff --exit-code
> -  - make
> +  - |
> +    bash travis-ci/enable-policy.sh targeted &&
> +    make PREFIX=/usr/local POLDEV=/usr/share/selinux/targeted
> +  - |
> +    bash travis-ci/enable-policy.sh refpolicy &&
> +    make PREFIX=/usr/local POLDEV=/usr/share/selinux/refpolicy
> diff --git a/policy/Makefile b/policy/Makefile
> index ff65153..39ae84a 100644
> --- a/policy/Makefile
> +++ b/policy/Makefile
> @@ -1,8 +1,11 @@
>   
> -POLDEV ?= /usr/share/selinux/devel
> -SEMODULE = /usr/sbin/semodule
> -CHECKPOLICY = /usr/bin/checkpolicy
> -CHECKMODULE = /usr/bin/checkmodule
> +PREFIX ?= /usr
> +BINDIR ?= $(PREFIX)/bin
> +SBINDIR ?= $(PREFIX)/sbin
> +POLDEV ?= $(PREFIX)/share/selinux/devel
> +SEMODULE = $(SBINDIR)/semodule
> +CHECKPOLICY = $(BINDIR)/checkpolicy
> +CHECKMODULE = $(BINDIR)/checkmodule
>   
>   DISTRO=$(shell ../tests/os_detect)
>   
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
> index 0000000..d2793f0
> --- /dev/null
> +++ b/travis-ci/setup-policy-fedora.sh
> @@ -0,0 +1,33 @@
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
> +
> +cd selinux-policy
> +
> +grep -q refpolicy build.conf && sed -i 's/refpolicy/targeted/' build.conf
> +
> +[ -f policy/modules.conf ] || make conf
> +
> +make -j`nproc --all` BINDIR=/usr/local/bin SBINDIR=/usr/local/sbin
> +sudo make install install-headers
> +
> +# workaround for different Makefile location in Fedora RPMs
> +sudo ln -s include/Makefile /usr/share/selinux/targeted/Makefile
> diff --git a/travis-ci/setup-policy-refpolicy.sh b/travis-ci/setup-policy-refpolicy.sh
> new file mode 100644
> index 0000000..abd4ca4
> --- /dev/null
> +++ b/travis-ci/setup-policy-refpolicy.sh
> @@ -0,0 +1,19 @@
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
> +make -j`nproc --all` BINDIR=/usr/local/bin SBINDIR=/usr/local/sbin
> +sudo make install install-headers
> +
> +# workaround for different Makefile location in Fedora RPMs
> +sudo ln -s include/Makefile /usr/share/selinux/refpolicy/Makefile
> 

