Return-Path: <SRS0=nPuh=ZR=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77735C432C0
	for <selinux@archiver.kernel.org>; Mon, 25 Nov 2019 15:18:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D41B2082F
	for <selinux@archiver.kernel.org>; Mon, 25 Nov 2019 15:18:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="cfwN2FaM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728243AbfKYPSi (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 25 Nov 2019 10:18:38 -0500
Received: from UCOL19PA38.eemsg.mail.mil ([214.24.24.198]:14592 "EHLO
        UCOL19PA38.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727785AbfKYPSi (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 25 Nov 2019 10:18:38 -0500
X-EEMSG-check-017: 54049474|UCOL19PA38_ESA_OUT05.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.69,241,1571702400"; 
   d="scan'208";a="54049474"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by UCOL19PA38.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 25 Nov 2019 15:18:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1574695093; x=1606231093;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=r96SDE1XaZclxSIhXxZsSihqPvoIUNwsqrDkS4Hw7jg=;
  b=cfwN2FaMjufvmc6DHsiNTjo9YY5XEoQuDDJwvv+q3Yv2a66jDjBZQhnJ
   mtoZEOp5x8qstN3OB4KvWOggP6WAd1ZIRjWv2pompGzxP2sf2OepHr5c8
   QSjfWLNVti0ltNWQSyeKgB+gQL0VvzkHQ6PZBIuhuOOsLvl9MNWlKVLWA
   09+kX/gkZfAX1N6Rg6iPVpn2cShg6WpWbONFKMLFaYj1NGYQWSqoW6HKG
   vmD/Pdy6Bo4iqfeEIrFG1oB2MaL1cI8GfLMoOwe18wadVURw2HyqF/TRZ
   Ok/vo7HNB0y1un/2M7ipmIMgVxFr+NGgIOjXnUm2VeL63EqwX5z0Npq9X
   A==;
X-IronPort-AV: E=Sophos;i="5.69,241,1571702400"; 
   d="scan'208";a="35970486"
IronPort-PHdr: =?us-ascii?q?9a23=3AB/SMdhZFvz4b7AeWEn1cjxD/LSx+4OfEezUN45?=
 =?us-ascii?q?9isYplN5qZrsy/bnLW6fgltlLVR4KTs6sC17ON9fm+ACdfut6oizMrSNR0TR?=
 =?us-ascii?q?gLiMEbzUQLIfWuLgnFFsPsdDEwB89YVVVorDmROElRH9viNRWJ+iXhpTEdFQ?=
 =?us-ascii?q?/iOgVrO+/7BpDdj9it1+C15pbffxhEiCCybL9vIhi6txjdu8gLjYdtKKs8xA?=
 =?us-ascii?q?bCr2dVdehR2W5mP0+YkQzm5se38p5j8iBQtOwk+sVdT6j0fLk2QKJBAjg+PG?=
 =?us-ascii?q?87+MPktR/YTQuS/XQcSXkZkgBJAwfe8h73WIr6vzbguep83CmaOtD2TawxVD?=
 =?us-ascii?q?+/4apnVAPkhSEaPDMi7mrZltJ/g75aoBK5phxw3YjUYJ2ONPFjeq/RZM4WSX?=
 =?us-ascii?q?ZdUspUUSFODJm8b48SBOQfO+hWoZT2q18XoRawAQSgAeXiwSJKiHDrx603y/?=
 =?us-ascii?q?kvHx/I3AIgHNwAvnrbo9r3O6gOXu6417XIwDfZYv9KxTvw5orFfxY8qv+MR7?=
 =?us-ascii?q?Jwds/RxFEyGQPZkFqQsYzlMC2T1u8Qrmab6vBvVeari2E5qwB6vz+ixtwxhY?=
 =?us-ascii?q?nSnY8V1lDF+jl5wIYyP9G4TlV7bsS+HJtfsCGaKZJ7T8U/SG9roCY30qAKtJ?=
 =?us-ascii?q?G0cSQQyJkr2gTTZ+KIfoSW+B7vSeCcKipiin1/YrKwnROy/FClyu37S8a7zk?=
 =?us-ascii?q?5HrjFAktnQrnAN0AHT6tSfRvt94Eih3TGP2hjP6u5eO0A0lLfbK4U7zr4xkJ?=
 =?us-ascii?q?oTv0PDHjTol0rqlqOWakUl9fSo6+TgeLnmoIOTN5RohQ3kN6Qum8i/Dfw5Mg?=
 =?us-ascii?q?gIQWeb5fyx2KDs8ED2WrlHjuA6nrPHvJ3VO8gXvLO1DxdQ0ok56ha/Czmm0M?=
 =?us-ascii?q?4fnXkCNF9FYw+Ij5PyNlHSIPH3Efe/g1O2nDdt3PDJJKftAprKLnjdiLvhZ6?=
 =?us-ascii?q?py61ZAyAovytBS/5VUCrQGIPLoXE/+rsDXAQEiPgyu3enoFdV92ZkCWW6VHq?=
 =?us-ascii?q?CZN6bSu0eS5u0zO+mMeJMVuDHlJvg++fHuiX45mVkAfaimxpYXdn+4Eep8I0?=
 =?us-ascii?q?mDYnrjnM0BEWEUsQo6VuDqj0eCUTEAL0q1CoU66is2CsqDCpzFT4ugg/TV2y?=
 =?us-ascii?q?K8BZtfbW1uEF2AEX70MY6DXqFIIDmfJs5njywsS7esUcki2AuouQu8zKBofc?=
 =?us-ascii?q?TO/ShNjo7uzNh44aXokBg28TFlR5CG33qlU3B/nmROQSQ/mq94vxoumR+4za?=
 =?us-ascii?q?FkjqkARpRo7PRTX1J/bMWNwg=3D=3D?=
X-IPAS-Result: =?us-ascii?q?A2DXAwDZ79td/wHyM5BlHAEBAQEBBwEBEQEEBAEBgX6Bd?=
 =?us-ascii?q?IFsASASKoQriQOGUAEBAQEBAQaBEiWJaZFECQEBAQEBAQEBATcBAYRAAoJSO?=
 =?us-ascii?q?BMCEAEBAQQBAQEBAQUDAQFshUOCOykBgm4BBSMVUQsOCgICJgICVwYBDAYCA?=
 =?us-ascii?q?QGCXz+CUyWxGIEyhU+DPIFIgQ4ojDB4gQeBEScMA4JdPodZgl4ElmFGlwuCN?=
 =?us-ascii?q?YI4kxYGG5ocLY4bnCEigVgrCAIYCCEPgydQERSVLCMDMI5NAQE?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 25 Nov 2019 15:18:12 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id xAPFJr0I205237;
        Mon, 25 Nov 2019 10:19:58 -0500
Subject: Re: [PATCH testsuite] policy: check for module_request support for
 key_socket
To:     Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org
References: <20191125151323.701716-1-omosnace@redhat.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <1d19a918-9856-751d-495e-6a8bbc751138@tycho.nsa.gov>
Date:   Mon, 25 Nov 2019 10:18:33 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191125151323.701716-1-omosnace@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 11/25/19 10:13 AM, Ondrej Mosnacek wrote:
> E.g. RHEL-5 has key_socket class in the policy, but not the
> system::module_request permission.
> 
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>   policy/Makefile | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/policy/Makefile b/policy/Makefile
> index 57cc172..7c2d21e 100644
> --- a/policy/Makefile
> +++ b/policy/Makefile
> @@ -94,8 +94,10 @@ TARGETS+=test_notify.te
>   endif
>   
>   ifeq ($(shell grep -q key_socket $(POLDEV)/include/support/all_perms.spt && echo true),true)
> +ifeq ($(shell grep -q module_request $(POLDEV)/include/support/all_perms.spt && echo true),true)
>   TARGETS += test_key_socket.te
>   endif
> +endif
>   
>   ifeq (x$(DISTRO),$(filter x$(DISTRO),xRHEL4 xRHEL5 xRHEL6))
>   TARGETS:=$(filter-out test_overlayfs.te test_mqueue.te test_ibpkey.te, $(TARGETS))
> 

Alternatively, consider wrapping use of module_request in 
test_key_socket.te with a suitable ifdef.  Probably ought to be using 
the policy interface, kernel_request_load_module(), and then we can just 
wrap it with ifdef(`kernel_request_load_module', ...).  Rationale: The 
purpose of this test and its policy is to test the key_socket checks, 
not module_request; allowing module_request is just incidental.

