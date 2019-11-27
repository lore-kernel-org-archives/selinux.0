Return-Path: <SRS0=LgiC=ZT=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD393C432C0
	for <selinux@archiver.kernel.org>; Wed, 27 Nov 2019 15:21:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B0EA2053B
	for <selinux@archiver.kernel.org>; Wed, 27 Nov 2019 15:21:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="g3U/0kb/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726603AbfK0PV2 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 27 Nov 2019 10:21:28 -0500
Received: from USFB19PA35.eemsg.mail.mil ([214.24.26.198]:28863 "EHLO
        USFB19PA35.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726514AbfK0PV1 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 27 Nov 2019 10:21:27 -0500
X-EEMSG-check-017: 30857421|USFB19PA35_ESA_OUT05.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.69,249,1571702400"; 
   d="scan'208";a="30857421"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by USFB19PA35.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 27 Nov 2019 15:21:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1574868085; x=1606404085;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=vAB3/Dw4IbuAF5jw5QGPGOUBGVieCsmtrhwcuOmhDZ0=;
  b=g3U/0kb/VDVS++dRpPHGoNZtI1Q5VvdCEF69IgumUuQHKfyEd3Fl6JCR
   yPLlJqO7D1pmzCgDIzjTCQx/4C9BHn1LEh09RiSl104Dog/5icUQu+pKi
   t5sdQd+KBzvqoXXSXkfA5CE3uTMhKtas0HFQV5Qm/KL00jreA6c3sN7Xm
   XGpBgfhx4R3YoTScwJqMqzvyXbJ4QhYvNxGWlw8lVDbnqjxbsFu9XbHzN
   MSFEd8CzvjYDx1B7tzW9d3/msEXZPcbrB4idaEHPX5OrUxSsykPNNdhH9
   dkk/fEKt/gHgMM6OC1PkTBIaHZYZXryyyBShoWSaSR5Pozi6N0nFsrrtZ
   w==;
X-IronPort-AV: E=Sophos;i="5.69,249,1571702400"; 
   d="scan'208";a="36084592"
IronPort-PHdr: =?us-ascii?q?9a23=3A8tTCaB98aYR4Ov9uRHKM819IXTAuvvDOBiVQ1K?=
 =?us-ascii?q?B20+8cTK2v8tzYMVDF4r011RmVBN6dsqwZwLWO+4nbGkU4qa6bt34DdJEeHz?=
 =?us-ascii?q?Qksu4x2zIaPcieFEfgJ+TrZSFpVO5LVVti4m3peRMNQJW2aFLduGC94iAPER?=
 =?us-ascii?q?vjKwV1Ov71GonPhMiryuy+4ZLebxhGiTanfL9/LRW7oQrTu8UKnIBvNrs/xh?=
 =?us-ascii?q?zVr3VSZu9Y33loJVWdnxb94se/4ptu+DlOtvwi6sBNT7z0c7w3QrJEAjsmNX?=
 =?us-ascii?q?s15NDwuhnYUQSP/HocXX4InRdOHgPI8Qv1Xpb1siv9q+p9xCyXNtD4QLwoRT?=
 =?us-ascii?q?iv6bpgRQT2gykbKTE27GDXitRxjK1FphKhuwd/yJPQbI2MKfZyYr/RcdYcSG?=
 =?us-ascii?q?VPRMZRUzFKDJ26YYUBEuENOf9Uoof5qlcLqxa1GAuiC/71yjJQm3H4w6M63e?=
 =?us-ascii?q?QiHw/I0gMvENABv2jbotjuKKcfU/q4wLXUwTjNbf5b3yr25ojSchAmpPGBRa?=
 =?us-ascii?q?9+cdbPxkk3FwPKkFOQopH4MTOQzOsNt2yb4PRgVOmyjGMnsBx+oiO0y8cwio?=
 =?us-ascii?q?jGmoIVylfe+SV/24Y6P8e0SEF8Yd66CZZdsTyROYhuQs46Xm1ltyk3xqcGtJ?=
 =?us-ascii?q?KmZiQG1psqywDFZ/CadYWD/wjtW/yLIThigXJoYLe/hxGv/ke+0uD8Tcy00E?=
 =?us-ascii?q?pSripCj9nMqmgB1xzN5ciDTftw5luh1iyV1wDS9+FEOlo4lavdK54vxb4wjY?=
 =?us-ascii?q?QcvljZEi/qmET5kK+WdkI+9uiu9+vneanpqoWZN491jgHyKqUumsqhDuQkKg?=
 =?us-ascii?q?UCQmeW9Oum2LDj4EH1WqtGg/IonqXDrZzWPcEbqbS4Aw9R3IYj8RG/DzK+3d?=
 =?us-ascii?q?QDgHYHN0lIeA6Hjof1O1HOJ+r0DfGkg1u2ijtryPfGPqP5DpXXMnfDiKvhfa?=
 =?us-ascii?q?p660NEzwozyNdf54lSCr4bPP38RFT8tMbGARAkMwy72frnBM9h2YMZXGKFGr?=
 =?us-ascii?q?WZP7/KsV+U+uIvJPGBZJQLtzb5Kvgl4ePujHAilF8Dcqmmw4EXZGq7Hvt4OU?=
 =?us-ascii?q?WZZ2TjgtMbHWcNpAo+Q7+itFrXdjhffXuwF4c7/TcyA4+lRdPEQ4e2hrWK0Q?=
 =?us-ascii?q?+hE5FWb3wAAVeJRzOgbIiAWvEReAqMLcJ71D8JT76sT8kmzx79mhX9zu9cMu?=
 =?us-ascii?q?fM+iAe/anm3dxx6vybwQo+7hRoHs+d1CeLVGgykWQWEWxllJtjqFBwnw/QmZ?=
 =?us-ascii?q?NzhOZVQJkKvKJE?=
X-IPAS-Result: =?us-ascii?q?A2DFAABAk95d/wHyM5BlGwEBAQEBAQEFAQEBEQEBAwMBA?=
 =?us-ascii?q?QGBfoF0gRhVIBIqhCuJA4ZaBoESJYlpkUQJAQEBAQEBAQEBJxABAYRAAoIkO?=
 =?us-ascii?q?BMCEAEBAQQBAQEBAQUDAQFshTcMgjspAYJtAQEBAQIBIxVRCw4KAgImAgJXB?=
 =?us-ascii?q?gEMBgIBAYJfPwGCUgUgsWZ1gTKFT4NDgUiBDiiII4QNeYEHgTgMA4JdPodZg?=
 =?us-ascii?q?l4ElmNGlxCCN4I5hGSOMwYbmh+OSJwlIoFYKwgCGAghD4MnCUcRFJEMhCAjA?=
 =?us-ascii?q?zCOPQEB?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 27 Nov 2019 15:21:24 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id xARFLJnX012155;
        Wed, 27 Nov 2019 10:21:19 -0500
Subject: Re: [PATCH testsuite] travis: improve selinuxfs mocking
To:     Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org
References: <20191127134643.822677-1-omosnace@redhat.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <bf470995-b4ec-90af-6187-d4e405775ad4@tycho.nsa.gov>
Date:   Wed, 27 Nov 2019 10:21:35 -0500
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

This seems fine but note that several test scripts also access 
/sys/fs/selinux for various purposes:
tests/mkdir/test:    @locations = ( '/selinux', '/sys/fs/selinux' );
tests/nnp_nosuid/test:"grep -q 1 
/sys/fs/selinux/policy_capabilities/nnp_nosuid_transition 2> /dev/null"
tests/checkreqprot/default_value.sh:	grep -q 0 
/sys/fs/selinux/checkreqprot 2> /dev/null
tests/mmap/test:    if ( system("grep -q 0 /sys/fs/selinux/checkreqprot 
2> /dev/null") == 0 ) {
tests/mmap/test:    if ( -e '/sys/fs/selinux/class/file/perms/map' ) {

This won't matter until/unless we get to the point of actually running 
the testsuite on travis, in which case we should have a real 
/sys/fs/selinux so it may not matter.

> 
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>

Acked-by: Stephen Smalley <sds@tycho.nsa.gov>

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

