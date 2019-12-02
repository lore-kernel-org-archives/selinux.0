Return-Path: <SRS0=5g5+=ZY=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6752AC432C0
	for <selinux@archiver.kernel.org>; Mon,  2 Dec 2019 17:21:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3455E20833
	for <selinux@archiver.kernel.org>; Mon,  2 Dec 2019 17:21:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="O5WvGecR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727493AbfLBRVv (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 2 Dec 2019 12:21:51 -0500
Received: from USAT19PA20.eemsg.mail.mil ([214.24.22.194]:19952 "EHLO
        USAT19PA20.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727460AbfLBRVv (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 2 Dec 2019 12:21:51 -0500
X-EEMSG-check-017: 56073373|USAT19PA20_ESA_OUT01.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.69,270,1571702400"; 
   d="scan'208";a="56073373"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by USAT19PA20.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 02 Dec 2019 17:21:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1575307310; x=1606843310;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=G/A4LG6f5GB7dE4K2YtYjCvtSjz8wMeqKktb7/wHCN0=;
  b=O5WvGecRvVf9c0XcDh1S4DbGd1ywpwkhxCMAfZ5m2g+gPb9s8b1grfbP
   qflsIRBN1/CSxWu/Jcu3Z8m2TbMdZmk7kcBKLCtfieG9OehP5tWANvpLV
   K89vouF1BwTFxsezdqF7sVyDShpSPnF34jrjOi8pbYnjtt6IpipK4wDrm
   IFrhWHhpM9UqbpkgyaLxRvz9ycKjd7MAwDrtP/oXpB6vX6mThISe+52XW
   rbGcUnIG2oZ53kV/M/mhQWQ3fnHZxSPww+UlLmJkbYrhBxQF17h9tR3qE
   wpRbi6SGe6H7B0py0/VKE3FrMlLc8GuMtWvzK+6PVsSQrFd1M402sLa7s
   Q==;
X-IronPort-AV: E=Sophos;i="5.69,270,1571702400"; 
   d="scan'208";a="30650960"
IronPort-PHdr: =?us-ascii?q?9a23=3AczjMyRcaTc4HZ0LQNvtzci7WlGMj4u6mDksu8p?=
 =?us-ascii?q?Mizoh2WeGdxcW6bB7h7PlgxGXEQZ/co6odzbaP6Oa5BjFLuM7Z+Fk5M7V0Hy?=
 =?us-ascii?q?cfjssXmwFySOWkMmbcaMDQUiohAc5ZX0Vk9XzoeWJcGcL5ekGA6ibqtW1aFR?=
 =?us-ascii?q?rwLxd6KfroEYDOkcu3y/qy+5rOaAlUmTaxe7x/IAi4oAnLq8Ubg4tvJqksxh?=
 =?us-ascii?q?fVvndDZvhby35vKV+PhRj3+92+/IRk8yReuvIh89BPXKDndKkmTrJWESorPX?=
 =?us-ascii?q?kt6MLkqRfMQw2P5mABUmoNiRpHHxLF7BDhUZjvtCbxq/dw1zObPc3ySrA0RC?=
 =?us-ascii?q?ii4qJ2QxLmlCsLKzg0+3zMh8dukKxUvg6upx1nw47Vfo6VMuZ+frjAdt8eXG?=
 =?us-ascii?q?ZNQ9pdWzBEDo66YYQPFe4BNvtGoYf7qVUFsB+yCRCiCe7rzzNFgGL9068n3O?=
 =?us-ascii?q?Q7CQzIwRIuH9wOvnrXotv6OqgdXuKpw6fH1jjDc/Fb1C3h5ITUfB0so/eBVq?=
 =?us-ascii?q?9wf8rLzkkvEhvIgEiMqYP7JzOV1voCs26G5OR9UOKgkWonqwVvrTmv28whjZ?=
 =?us-ascii?q?LJiZ8Oyl3f6SV4wJo6Jd2/SEJhZ96kC4FfuzuVN4txXMMvWmdlszs5xL0eoZ?=
 =?us-ascii?q?O3YScHxZs9yxPfdvCLaZaE7x39WOqLPDt1gm9udqiliBao60egz/XxVsyz0F?=
 =?us-ascii?q?lXsCVIisLMtnUR1xzL7ciHV+d98l+h2TmR0wDT7flJIVwumqrBKp4h36Uwmo?=
 =?us-ascii?q?ASsUTFEC/2n172g7GKeUk+5uip6/joYrXhppOGMY97lhr+Pbg0lsy6AOQ4Nh?=
 =?us-ascii?q?ACX2md+euiyL3u5VD1TbpFg/EskqTVrYrWKdoUq6KnGQNZz54v6xOlADen1N?=
 =?us-ascii?q?QYk2MHLFVAeB+flIjmJkrOLevkDfa/n1uskDBry+rAPr36GJrBNHfDkLD/fb?=
 =?us-ascii?q?pl8U5T1BIzzcxD55JTErwBJ/fzWkjqtNzeFBA2LxK7zv39CNpjy4weWXiAAr?=
 =?us-ascii?q?ODPKzOtl+I4/olI/OQa48NpDb9N/8l6ub1jXAnnV8dfK+p3YYYaX2jAPRmLF?=
 =?us-ascii?q?uWYWD2jtcCD2gKpAw+Q/LuiFGYVj5TfXmyDOoA4WQcDo68AIWLY4e2hrWK0S?=
 =?us-ascii?q?TzSppTYXtAA1uBOW3le4WNR7EHbyfEZod6nzgFU6WxY5Eu2AvotwLgzbdjaO?=
 =?us-ascii?q?3O9X42r5XmgeNp6vXTmBd6zjl9C8CQwinZVG1vtn8ZTD8xmqZkqApyzUnVgv?=
 =?us-ascii?q?swuOBRCdEGv6ABaQw9L5OJirUhWt0=3D?=
X-IPAS-Result: =?us-ascii?q?A2BHAwDURuVd/wHyM5BmHAEBAQEBBwEBEQEEBAEBgX6Bd?=
 =?us-ascii?q?IEYVAEgEiqEK4kDhlcBAQEBAQEGgTeJaZFECQEBAQEBAQEBAScQAQGEQAKCL?=
 =?us-ascii?q?zgTAhABAQEEAQEBAQEFAwEBbIU3DII7KQGCbgEFIxVRCw4KAgImAgJXBgEMB?=
 =?us-ascii?q?gIBAYJfPwGCUiWzKIEyhU+DJoFIgQ4ojDB5gQeBOA+CXT6HWYJeBJZnRpcRg?=
 =?us-ascii?q?jiCOYRljjUGG5ojjkqcKCKBWCsIAhgIIQ+DJwlHERSXKoQgIwMwkUgBAQ?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 02 Dec 2019 17:21:49 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id xB2HLfki069555;
        Mon, 2 Dec 2019 12:21:41 -0500
Subject: Re: [PATCH testsuite] travis: improve selinuxfs mocking
To:     Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org
References: <20191127134643.822677-1-omosnace@redhat.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <f0305aac-c30a-8f09-65f0-143cfffbf414@tycho.nsa.gov>
Date:   Mon, 2 Dec 2019 12:21:59 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191127134643.822677-1-omosnace@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 11/27/19 8:46 AM, Ondrej Mosnacek wrote:
> Modify all Makefiles to allow overriding the path to the selinuxfs
> mountpoint via the SELINUXFS variable and use it in the Travis script to
> allow more stuff to be built (namely the extended_socket_class subdir).
> 
> This patch also drops the auto-detection of selinuxfs mount from
> policy/Makefile in favor of overriding it via the variable if it differs
> from the usual /sys/fs/selinux/.
> 
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>

Thanks, applied.

> ---
>   .travis.yml     | 8 ++++----
>   policy/Makefile | 2 +-
>   tests/Makefile  | 5 +++--
>   3 files changed, 8 insertions(+), 7 deletions(-)
> 
> diff --git a/.travis.yml b/.travis.yml
> index d1e5056..2c8e416 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -51,15 +51,15 @@ before_install:
>     - bash travis-ci/setup-policy-fedora.sh
>     - bash travis-ci/setup-policy-refpolicy.sh
>     # establish a fake "selinuxfs" mount (policy/Makefile just greps for selinuxfs)
> -  - sudo mkdir -p /tmp/fake-selinuxfs
> -  - sudo mount -t tmpfs tmpfs /tmp/fake-selinuxfs
> +  - mkdir -p /tmp/fake-selinuxfs/policy_capabilities
> +  - echo 1 > /tmp/fake-selinuxfs/policy_capabilities/extended_socket_class
>     - echo 999 >/tmp/fake-selinuxfs/policyvers
>   
>   script:
>     - tools/check-syntax -f && git diff --exit-code
>     - |
>       bash travis-ci/enable-policy.sh targeted &&
> -    make PREFIX=/usr/local POLDEV=/usr/share/selinux/targeted
> +    make SELINUXFS=/tmp/fake-selinuxfs PREFIX=/usr/local POLDEV=/usr/share/selinux/targeted
>     - |
>       bash travis-ci/enable-policy.sh refpolicy &&
> -    make PREFIX=/usr/local POLDEV=/usr/share/selinux/refpolicy
> +    make SELINUXFS=/tmp/fake-selinuxfs PREFIX=/usr/local POLDEV=/usr/share/selinux/refpolicy
> diff --git a/policy/Makefile b/policy/Makefile
> index 87b2856..dda2e16 100644
> --- a/policy/Makefile
> +++ b/policy/Makefile
> @@ -3,6 +3,7 @@ PREFIX ?= /usr
>   BINDIR ?= $(PREFIX)/bin
>   SBINDIR ?= $(PREFIX)/sbin
>   POLDEV ?= $(PREFIX)/share/selinux/devel
> +SELINUXFS ?= /sys/fs/selinux
>   SEMODULE = $(SBINDIR)/semodule
>   CHECKPOLICY = $(BINDIR)/checkpolicy
>   CHECKMODULE = $(BINDIR)/checkmodule
> @@ -11,7 +12,6 @@ DISTRO=$(shell ../tests/os_detect)
>   
>   POL_VERS := $(shell $(CHECKPOLICY) -V |cut -f 1 -d ' ')
>   MOD_POL_VERS := $(shell $(CHECKMODULE) -V |cut -f 2 -d '-')
> -SELINUXFS := $(shell cat /proc/mounts | grep selinuxfs | cut -f 2 -d ' ')
>   MAX_KERNEL_POLICY := $(shell cat $(SELINUXFS)/policyvers)
>   
>   TARGETS = \
> diff --git a/tests/Makefile b/tests/Makefile
> index 1cdb1ac..0d33fbf 100644
> --- a/tests/Makefile
> +++ b/tests/Makefile
> @@ -1,5 +1,6 @@
>   INCLUDEDIR ?= /usr/include
>   POLDEV ?= /usr/share/selinux/devel
> +SELINUXFS ?= /sys/fs/selinux
>   
>   export CFLAGS+=-g -O0 -Wall -D_GNU_SOURCE
>   
> @@ -19,11 +20,11 @@ SUBDIRS += cap_userns
>   endif
>   endif
>   
> -ifeq ($(shell grep -q icmp_socket $(POLDEV)/include/support/all_perms.spt && grep -q 1 /sys/fs/selinux/policy_capabilities/extended_socket_class && echo true),true)
> +ifeq ($(shell grep -q icmp_socket $(POLDEV)/include/support/all_perms.spt && grep -q 1 $(SELINUXFS)/policy_capabilities/extended_socket_class && echo true),true)
>   SUBDIRS += extended_socket_class
>   endif
>   
> -ifeq ($(shell grep -q corenet_sctp_bind_all_nodes $(POLDEV)/include/kernel/corenetwork.if && grep -q 1 /sys/fs/selinux/policy_capabilities/extended_socket_class && echo true),true)
> +ifeq ($(shell grep -q corenet_sctp_bind_all_nodes $(POLDEV)/include/kernel/corenetwork.if && grep -q 1 $(SELINUXFS)/policy_capabilities/extended_socket_class && echo true),true)
>   ifneq ($(shell ./kvercmp $$(uname -r) 4.20.17),-1)
>   SUBDIRS += sctp
>   endif
> 

