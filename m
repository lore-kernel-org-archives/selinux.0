Return-Path: <SRS0=SqeD=ZS=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00068C432C0
	for <selinux@archiver.kernel.org>; Tue, 26 Nov 2019 14:14:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93BD32073F
	for <selinux@archiver.kernel.org>; Tue, 26 Nov 2019 14:14:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="TRwt3nHJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726876AbfKZOOB (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 26 Nov 2019 09:14:01 -0500
Received: from UCOL19PA35.eemsg.mail.mil ([214.24.24.195]:19183 "EHLO
        UCOL19PA35.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726536AbfKZOOB (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 26 Nov 2019 09:14:01 -0500
X-EEMSG-check-017: 54961101|UCOL19PA35_ESA_OUT02.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.69,246,1571702400"; 
   d="scan'208";a="54961101"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by UCOL19PA35.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 26 Nov 2019 14:13:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1574777639; x=1606313639;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=LFRuWZ49gDb4eYiMfc6u0DgvnoJcR0wUsJhAYZlxtL4=;
  b=TRwt3nHJWIwnPh+RmQ/P51pKEs+nPHCLaq89wlTl1TS2M5CDaXCT9y+Y
   bkGHde8uBeTJpkMwKKDmX65e5H7A7Jyx2/IQVHo7XWeeFdULgrDej5j46
   76lfL1Ic30tVFUQJh0D4qmIH864F2tYL4hX4wbeqODtziHUOM9C96JBVJ
   BoUgb9dK7xo7jPtL4fBwzReiJ+UkdFoiM5zA3w1R3S4ajLkl8LsR8z7VC
   WONY+ziERA/sROFQbyTecKzrE2/dO8M2hwRxwjQKM3sKkq2aofzU27zIX
   0QPWVmqEBlq7+BTgIgl9JIVq5uhei5HzB84VTiyQI8aIdX55wNjb+2krl
   g==;
X-IronPort-AV: E=Sophos;i="5.69,246,1571702400"; 
   d="scan'208";a="36017849"
IronPort-PHdr: =?us-ascii?q?9a23=3ABwjImBAGtQWjGua/D4SeUyQJP3N1i/DPJgcQr6?=
 =?us-ascii?q?AfoPdwSPXzpMbcNUDSrc9gkEXOFd2Cra4d0KyP7furBDxIyK3CmUhKSIZLWR?=
 =?us-ascii?q?4BhJdetC0bK+nBN3fGKuX3ZTcxBsVIWQwt1Xi6NU9IBJS2PAWK8TW94jEIBx?=
 =?us-ascii?q?rwKxd+KPjrFY7OlcS30P2594HObwlSizexfL1/IA+roQjQuMQajotvJ6UswR?=
 =?us-ascii?q?bVv3VEfPhby3l1LlyJhRb84cmw/J9n8ytOvv8q6tBNX6bncakmVLJUFDspPX?=
 =?us-ascii?q?w7683trhnDUBCA5mAAXWUMkxpHGBbK4RfnVZrsqCT6t+592C6HPc3qSL0/RD?=
 =?us-ascii?q?qv47t3RBLulSwKLCAy/n3JhcNsjaJbuBOhqAJ5w47Ie4GeKf5ycrrAcd8GWW?=
 =?us-ascii?q?ZNW8BcWCJbAoO4coABEewPM+hFpIX5vlcDox+zCQyqCejyyDFHm2X20LUn3e?=
 =?us-ascii?q?o/HwHI3A8uEdwAv3vbrtr6KKgcXPupzKTK1zjPc+9a1Dn/5YXObxsvoeuMXb?=
 =?us-ascii?q?V1ccfJ1EcvCx3Kjk2QqYP7OTOey/kDs22B4OpkUeKglW4moBx2rzi028gskZ?=
 =?us-ascii?q?LEhp4Vy1/Y9SV5x5w5JdujSEFhe9KkH5xQtz+DOoZwX8gsQHlotT4nxrAJtp?=
 =?us-ascii?q?O3ZigHxIk9yxLBZPGLbZKE7g/lWe2MOzl3nmhld6i6hxuq9EigzfDzWdes3V?=
 =?us-ascii?q?ZRqypFjsHMtncQ1xzP8sSHSuVy/kOm2TuXywDc8PtEIUEplarAMZIhw7gwlp?=
 =?us-ascii?q?QUsUTYACD5hF/6jLOWd0o4+uio7P7rYrP6qZ+HK4B4kAT+MqUqmsCnAOQ4NB?=
 =?us-ascii?q?YBX3SD9Oih27Du8lf1TbVXgvEsjKXUv47WKd4GqqKhBg9ayIcj6xKxDze819?=
 =?us-ascii?q?QYmGEKLElYdxKclIXpJ1HPL+z4Dfe4mVislixryOrcMr3uBZXNMGDPkK39cr?=
 =?us-ascii?q?Zl905c1A0zwMhY55JRDbEBO/TzVVXtu9PGFRI5KRK7zPvnCNpnyoMSQ36AAq?=
 =?us-ascii?q?icMKnKq1+H+vovI/WQZI8SoDv9MOYq5/rvjX8/hF8ccrKk3YUYaH+mBPRqOU?=
 =?us-ascii?q?aZbmT2gtcHD2gKuhAyTOvwiF2NSTRTfWq9X7og5jEnD4KrFZ3DRoGxj7yBxi?=
 =?us-ascii?q?i7BIBZaXhaBV+UEXfnbYSEW/ESZyKJOcJuiSAEVbmnS489yx6urgn6xKR7Lu?=
 =?us-ascii?q?bO5iIYspfjh5BJ4Lj0kx0o+D48KsOG1WiGQmI8ymQNQCQw1atyiVZwxleKze?=
 =?us-ascii?q?5zhPkOUZRI6vdIVBoqHYDTwvY8CN3oXA/FONCTRwWIWNKjVAotQ8oxztlGWE?=
 =?us-ascii?q?N0H9Gvn1iXxCaxK6MEnLyMQpov++TT2GandJU18GrPyKR01wpuecBIL2Dzw/?=
 =?us-ascii?q?ckpgU=3D?=
X-IPAS-Result: =?us-ascii?q?A2BNAADHMd1d/wHyM5BkGgEBAQEBAQEBAQMBAQEBEQEBA?=
 =?us-ascii?q?QICAQEBAYF+gXSBbSASKoQriQOGUQEBAQEBAQaBEiWJaYoghyQJAQEBAQEBA?=
 =?us-ascii?q?QEBNwEBhEACgho4EwIQAQEBBAEBAQEBBQMBAWyFQ4I7KQGCbgEFIxVBEAsOC?=
 =?us-ascii?q?gICJgICVwYBDAYCAQGCXz+CRwMJJbMKgTKFT4M8gUiBDiiMMHiBB4E4DAOCX?=
 =?us-ascii?q?T6CG4U+gl4ElmJGlwyCNoI5kxcGG4I/jCiLNi2OG4FCmmEigVgrCAIYCCEPg?=
 =?us-ascii?q?ydQERSVLCMDMI9vAQE?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 26 Nov 2019 14:13:59 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id xAQEDrud075399;
        Tue, 26 Nov 2019 09:13:55 -0500
Subject: Re: [PATCH testsuite v3] policy: use the kernel_request_load_module()
 interface
To:     Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org
Cc:     Richard Haines <richard_c_haines@btinternet.com>
References: <20191126120623.736870-1-omosnace@redhat.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <ce8fcc07-6383-74c4-5400-d73bb365d76d@tycho.nsa.gov>
Date:   Tue, 26 Nov 2019 09:14:31 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191126120623.736870-1-omosnace@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 11/26/19 7:06 AM, Ondrej Mosnacek wrote:
> ...instead of open-coding the rules. Also define a fallback to allow the
> policy to build even if the interface is not defined.
> 
> Fixes: f5e5a0b8d005 ("selinux-testsuite: Add key_socket tests")
> Cc: Richard Haines <richard_c_haines@btinternet.com>
> Suggested-by: Stephen Smalley <sds@tycho.nsa.gov>
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>

Acked-by: Stephen Smalley <sds@tycho.nsa.gov>

> ---
> 
> Change in v3: use different approach as suggested by Stephen
> Change in v2: update also tests/Makefile for consistency
> 
>   policy/test_key_socket.te | 8 ++++----
>   policy/test_policy.if     | 6 ++++++
>   2 files changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/policy/test_key_socket.te b/policy/test_key_socket.te
> index cde426b..f1c1606 100644
> --- a/policy/test_key_socket.te
> +++ b/policy/test_key_socket.te
> @@ -13,7 +13,7 @@ typeattribute test_key_sock_t keysockdomain;
>   allow test_key_sock_t self:capability { net_admin };
>   allow test_key_sock_t self:key_socket { create write read setopt };
>   # For CONFIG_NET_KEY=m
> -allow test_key_sock_t kernel_t:system { module_request };
> +kernel_request_load_module(test_key_sock_t)
>   
>   ################## Deny capability { net_admin } ##########################
>   #
> @@ -29,7 +29,7 @@ typeattribute test_key_sock_no_net_admin_t testdomain;
>   typeattribute test_key_sock_no_net_admin_t keysockdomain;
>   
>   allow test_key_sock_no_net_admin_t self:key_socket { create write read setopt };
> -allow test_key_sock_no_net_admin_t kernel_t:system { module_request };
> +kernel_request_load_module(test_key_sock_t)
>   
>   ####################### Deny key_socket { create } ##########################
>   type test_key_sock_no_create_t;
> @@ -50,7 +50,7 @@ typeattribute test_key_sock_no_write_t keysockdomain;
>   
>   allow test_key_sock_no_write_t self:capability { net_admin };
>   allow test_key_sock_no_write_t self:key_socket { create read setopt };
> -allow test_key_sock_no_write_t kernel_t:system { module_request };
> +kernel_request_load_module(test_key_sock_t)
>   
>   ####################### Deny key_socket { read } ##########################
>   type test_key_sock_no_read_t;
> @@ -61,7 +61,7 @@ typeattribute test_key_sock_no_read_t keysockdomain;
>   
>   allow test_key_sock_no_read_t self:capability { net_admin };
>   allow test_key_sock_no_read_t self:key_socket { create write setopt };
> -allow test_key_sock_no_read_t kernel_t:system { module_request };
> +kernel_request_load_module(test_key_sock_t)
>   
>   #
>   ########### Allow these domains to be entered from sysadm domain ############
> diff --git a/policy/test_policy.if b/policy/test_policy.if
> index e1175e8..3f163cb 100644
> --- a/policy/test_policy.if
> +++ b/policy/test_policy.if
> @@ -82,3 +82,9 @@ interface(`userdom_search_admin_dir', `
>       userdom_search_user_home_content($1)
>   ')
>   ')
> +
> +# If the macro isn't defined, then most probably module_request permission
> +# is just not supported (and relevant operations should be just allowed).
> +ifdef(`kernel_request_load_module', `', ` dnl
> +interface(`kernel_request_load_module', `')
> +')
> 

