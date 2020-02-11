Return-Path: <SRS0=fAir=37=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD331C35242
	for <selinux@archiver.kernel.org>; Tue, 11 Feb 2020 20:29:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B446F20708
	for <selinux@archiver.kernel.org>; Tue, 11 Feb 2020 20:29:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="POywTGNY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727964AbgBKU3a (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 11 Feb 2020 15:29:30 -0500
Received: from UPDC19PA23.eemsg.mail.mil ([214.24.27.198]:33706 "EHLO
        UPDC19PA23.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727111AbgBKU3a (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 11 Feb 2020 15:29:30 -0500
X-EEMSG-check-017: 58175464|UPDC19PA23_ESA_OUT05.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.70,428,1574121600"; 
   d="scan'208";a="58175464"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by UPDC19PA23.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 11 Feb 2020 20:29:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1581452967; x=1612988967;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=9DDyX5F9WVfy9JieisUxQ7Z+xQ5v6DCHlXnXAlF+92E=;
  b=POywTGNYpMXri1E+29YzFEGs6kQYCsRdjOxuwNXaMgW8mPCzkhnXPoed
   N8ZLxEXTmkRYOhw/8e1FHQFDQ54tvyJpiQq37LqF2yz9LfTieyazygjC8
   zg+QunqHhltXZ+P07fUeYz5WaQKn1NnWsG1aH0FCq0wgKW19xf6P9c0UF
   WvuX3EVTD3DCxar5kbZ9lBNS9JTazlxYRzDp5NqCHMzoY71R0WQkL/PXz
   D2NVKrR73o6H4Rp0kR6/8SAEmEUXzUUM14TKEGL1TB0GcO9CpRsqJUwX8
   o724VbPqWdgQ3ko89PimuG5Dh6o5za6KDGBEZPudvvx61ywCESszeJN5r
   Q==;
X-IronPort-AV: E=Sophos;i="5.70,428,1574121600"; 
   d="scan'208";a="32945065"
IronPort-PHdr: =?us-ascii?q?9a23=3Ad7RzPBKrcnCPvV/vbdmcpTZWNBhigK39O0sv0r?=
 =?us-ascii?q?FitYgfKvXxwZ3uMQTl6Ol3ixeRBMOHsq4C1bGd6vqxEUU7or+/81k6OKRWUB?=
 =?us-ascii?q?EEjchE1ycBO+WiTXPBEfjxciYhF95DXlI2t1uyMExSBdqsLwaK+i764jEdAA?=
 =?us-ascii?q?jwOhRoLerpBIHSk9631+ev8JHPfglEnjWwba59IRmsrAjcuMYajZZ8Jqs11x?=
 =?us-ascii?q?DEvmZGd+NKyGxnIl6egwzy7dqq8p559CRQtfMh98peXqj/Yq81U79WAik4Pm?=
 =?us-ascii?q?4s/MHkugXNQgWJ5nsHT2UZiQFIDBTf7BH7RZj+rC33vfdg1SaAPM32Sbc0WS?=
 =?us-ascii?q?m+76puVRTlhjsLOyI//WrKkcF7kr5Vrwy9qBx+247UYZ+aNPxifqPGYNgWQX?=
 =?us-ascii?q?NNUttNWyBdB4+xaYUAD/AFPe1FsYfzoVUApga6CQW1Cu7izjpEi3nr1qM4zu?=
 =?us-ascii?q?shCxnL0hE+EdIAsHrar9v7O6kdXu+30KbGwi7Ob+9U1Drn9ITEbh4srPOKUL?=
 =?us-ascii?q?ltccTR004vFwbdg1uNtYzqISuV1uQTvGid8uFuSOevhHQjqwF1vDeuxtonh4?=
 =?us-ascii?q?7Sho0I0VDJ7jl5wYYpKt24T053e9ikEIBKuC2AOIt2Rd0iTnhutS0nybMGoY?=
 =?us-ascii?q?a2cDUFxZko3RLSa+GLf5KW7h/sSuqdOyp0iXR4c7ylnRmy61KvyujkW8mx11?=
 =?us-ascii?q?ZFszRKn8HXtnAIyxzT8s+HSuZh/ku52TaAyQTT6uZcLEAoj6XbMZ8hwqMrlp?=
 =?us-ascii?q?YJsETDGCH2mELtjKCIakoo4PSo6uT7bbXmoZ+QLYl0hR3lMqsygMC/BOU4Mg?=
 =?us-ascii?q?wWU2ia/+SzyqHj8FXkTLhFgfA6iKnUvI3AKcgFqaO1HRVZ3ps75xa6FTim0d?=
 =?us-ascii?q?AYnXcdLFJCfRKKl5PpNEzVIP3jEfe+g0ijkDdsx/zcOL3hGY/CImLMkLfmY7?=
 =?us-ascii?q?Zx81RcxxYrzdBD+5JUDakMIOrpVU/ssNzVFQc5PBapw+bjEdl904QeWWWVAq?=
 =?us-ascii?q?CHKq/drViI5uc3KemWeIAVoCr9K+Qi5/P2ln82h1sdfaiv3ZsKZ3G1BepmI0?=
 =?us-ascii?q?qHbnr2mNsBEnkFvhA4TOP0jF2OSzlTZ2y9X/F02jZuMIu7Cc/mQYe3jfTVxC?=
 =?us-ascii?q?6mGrVOb31CT1WLFm3lMY6DXqFIIDmfJs5njywsS7esUcki2AuouQu8zKBofc?=
 =?us-ascii?q?TO/ShNjo7uzNh44aXokBg28TFlR5CG33qlU3B/nmROQSQ/mq94vxoumR+4za?=
 =?us-ascii?q?FkjqkARpRo7PRTX1J/bMWNwg=3D=3D?=
X-IPAS-Result: =?us-ascii?q?A2DjAgDDDUNe/wHyM5BmHAEBAQEBBwEBEQEEBAEBgXuBf?=
 =?us-ascii?q?YEYVSASKoQViQOGaAEBAQaBN4lwkUsJAQEBAQEBAQEBIxQBAYRAAoJrOBMCE?=
 =?us-ascii?q?AEBAQQBAQEBAQUDAQFshTcMgjspAYMBAQEBAQMjFVELFQMCAiYCAlcGAQwGA?=
 =?us-ascii?q?gEBgmM/AYJWJatHdYEyhUqDQYE+gQ4qjD15gQeBOA+CXT6ELoMtgl4El0JGl?=
 =?us-ascii?q?2qCRIJOhH6FSQeJKgYbg0GXTo5knTYigVgrCAIYCCEPO4JsCUcYDY5Vh0OGa?=
 =?us-ascii?q?SMDMIwmgkIBAQ?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 11 Feb 2020 20:29:25 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id 01BKSUih073051;
        Tue, 11 Feb 2020 15:28:30 -0500
Subject: Re: [PATCH] selinux-testsuite: add the quota package to the list of
 deps in README.md
To:     Paul Moore <paul@paul-moore.com>, selinux@vger.kernel.org
References: <158143665924.193851.6057679833915268046.stgit@chester>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <5bc73b28-2a6e-0a64-5cb1-5dd7b2bfa94b@tycho.nsa.gov>
Date:   Tue, 11 Feb 2020 15:30:24 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <158143665924.193851.6057679833915268046.stgit@chester>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 2/11/20 10:57 AM, Paul Moore wrote:
> From: Paul Moore <paul@paul-moore.com>
> 
> The filesystem tests require the quota tools.
> 
> Signed-off-by: Paul Moore <paul@paul-moore.com>

Acked-by: Stephen Smalley <sds@tycho.nsa.gov>

> ---
>   0 files changed
> 
> diff --git a/README.md b/README.md
> index 64f80c8..27c9d56 100644
> --- a/README.md
> +++ b/README.md
> @@ -54,6 +54,7 @@ similar dependencies):
>   * libbpf-devel _(tools used by the bpf tests)_
>   * keyutils-libs-devel _(tools used by the keys tests)_
>   * kernel-devel _(used by the kernel module tests)_
> +* quota _(used by the filesystem tests)_
>   
>   On a modern Fedora system you can install these dependencies with the
>   following command:
> @@ -71,7 +72,8 @@ following command:
>   		attr \
>   		libbpf-devel \
>   		keyutils-libs-devel \
> -		kernel-devel
> +		kernel-devel \
> +		quota
>   
>   The testsuite requires a pre-existing base policy configuration of SELinux,
>   using either the old example policy or the reference policy as the baseline.
> 

