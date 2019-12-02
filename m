Return-Path: <SRS0=5g5+=ZY=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 567FFC432C0
	for <selinux@archiver.kernel.org>; Mon,  2 Dec 2019 14:37:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E6CA20718
	for <selinux@archiver.kernel.org>; Mon,  2 Dec 2019 14:37:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="DawuuRr+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727406AbfLBOhl (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 2 Dec 2019 09:37:41 -0500
Received: from UCOL19PA36.eemsg.mail.mil ([214.24.24.196]:8664 "EHLO
        UCOL19PA36.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727401AbfLBOhl (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 2 Dec 2019 09:37:41 -0500
X-EEMSG-check-017: 55861238|UCOL19PA36_ESA_OUT03.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.69,268,1571702400"; 
   d="scan'208";a="55861238"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by UCOL19PA36.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 02 Dec 2019 14:37:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1575297432; x=1606833432;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=XH2SbaIMxHiJZ1MRHFbMob0MrJRtIUYxDzMazqiz868=;
  b=DawuuRr+T+H//rnLWxP5PuNGvdhhlT39SLj1h5ieIQvByzDthLYKlLY1
   G1fYkpFxjYgo8dWpIz2iwKn1EMPlkaUiiVXURK6rQRpW1unpE7PEBhydK
   mbLvX4TDqPQoB9KEUDaiRpaMLOlfk9Zuw3rIvk3BjwX9kbZ2xuf5NoWYS
   SjSGxswSlEoLSY2BmHAsUyzP5qqthqZsbc9eAejjKySwxLZVXhIqMl8Il
   +xBl6t9rS3WQU4bHK/tBEjAvWU0jkQTE5grbggSsecYTTs9GlIazwWD0j
   RQY9n72EB1ETgDUHFMFuPvi5Ye8OjaJmbf/ag80mmF1NY/E3yI1kNX5bQ
   A==;
X-IronPort-AV: E=Sophos;i="5.69,268,1571702400"; 
   d="scan'208";a="30637714"
IronPort-PHdr: =?us-ascii?q?9a23=3A0QJbSBBJrM+E4AqLvC6zUyQJP3N1i/DPJgcQr6?=
 =?us-ascii?q?AfoPdwSPXzpMbcNUDSrc9gkEXOFd2Cra4d0KyP7P2rBzJIyK3CmUhKSIZLWR?=
 =?us-ascii?q?4BhJdetC0bK+nBN3fGKuX3ZTcxBsVIWQwt1Xi6NU9IBJS2PAWK8TW94jEIBx?=
 =?us-ascii?q?rwKxd+KPjrFY7OlcS30P2594HObwlSizexfL1/IA+roQjTtsQajopvJ6cswR?=
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
X-IPAS-Result: =?us-ascii?q?A2BfAACOG+Vd/wHyM5BmGgEBAQEBAQEBAQMBAQEBEQEBA?=
 =?us-ascii?q?QICAQEBAYF+gXSBbAEgEiqEK4kDhlwGgTeJaYoghyQJAQEBAQEBAQEBNwEBh?=
 =?us-ascii?q?EACgi84EwIQAQEBBAEBAQEBBQMBAWyFQ4I7KQGCbgEFIxVBEAsOCgICJgICV?=
 =?us-ascii?q?wYBDAYCAQGCXz+CRwMJJbF1gTKFT4MngUiBDiiMMHmBB4E4D4JdPoIbhT6CX?=
 =?us-ascii?q?gSNB4lgRpcRgjiCOZMaBhuCQYwsizYtjh2BQppmIoFYKwgCGAghD4MnUBEUm?=
 =?us-ascii?q?0ojAzCRTgEB?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 02 Dec 2019 14:37:07 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id xB2Eavva263893;
        Mon, 2 Dec 2019 09:36:58 -0500
Subject: Re: [PATCH testsuite v6] policy: use the kernel_request_load_module()
 interface
To:     Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org
Cc:     Richard Haines <richard_c_haines@btinternet.com>
References: <20191128140807.900061-1-omosnace@redhat.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <f8c21ed7-eda6-e63b-7e94-616055852244@tycho.nsa.gov>
Date:   Mon, 2 Dec 2019 09:37:56 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191128140807.900061-1-omosnace@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 11/28/19 9:08 AM, Ondrej Mosnacek wrote:
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
> Change in v6: avoid apostrophes in comments
> Change in v5: call the macro only once for the whole domain
> Change in v4: fix copy-paste mistakes spotted by Richard
> Change in v3: use different approach as suggested by Stephen
> Change in v2: update also tests/Makefile for consistency
> 
>   policy/test_key_socket.te | 8 +++-----
>   policy/test_policy.if     | 8 +++++++-
>   2 files changed, 10 insertions(+), 6 deletions(-)
> 
> diff --git a/policy/test_key_socket.te b/policy/test_key_socket.te
> index cde426b..64d2cee 100644
> --- a/policy/test_key_socket.te
> +++ b/policy/test_key_socket.te
> @@ -12,8 +12,6 @@ typeattribute test_key_sock_t keysockdomain;
>   # key_socket rules:
>   allow test_key_sock_t self:capability { net_admin };
>   allow test_key_sock_t self:key_socket { create write read setopt };
> -# For CONFIG_NET_KEY=m
> -allow test_key_sock_t kernel_t:system { module_request };
>   
>   ################## Deny capability { net_admin } ##########################
>   #
> @@ -29,7 +27,6 @@ typeattribute test_key_sock_no_net_admin_t testdomain;
>   typeattribute test_key_sock_no_net_admin_t keysockdomain;
>   
>   allow test_key_sock_no_net_admin_t self:key_socket { create write read setopt };
> -allow test_key_sock_no_net_admin_t kernel_t:system { module_request };
>   
>   ####################### Deny key_socket { create } ##########################
>   type test_key_sock_no_create_t;
> @@ -50,7 +47,6 @@ typeattribute test_key_sock_no_write_t keysockdomain;
>   
>   allow test_key_sock_no_write_t self:capability { net_admin };
>   allow test_key_sock_no_write_t self:key_socket { create read setopt };
> -allow test_key_sock_no_write_t kernel_t:system { module_request };
>   
>   ####################### Deny key_socket { read } ##########################
>   type test_key_sock_no_read_t;
> @@ -61,10 +57,12 @@ typeattribute test_key_sock_no_read_t keysockdomain;
>   
>   allow test_key_sock_no_read_t self:capability { net_admin };
>   allow test_key_sock_no_read_t self:key_socket { create write setopt };
> -allow test_key_sock_no_read_t kernel_t:system { module_request };
>   
>   #
>   ########### Allow these domains to be entered from sysadm domain ############
>   #
>   miscfiles_domain_entry_test_files(keysockdomain)
>   userdom_sysadm_entry_spec_domtrans_to(keysockdomain)
> +
> +# For CONFIG_NET_KEY=m
> +kernel_request_load_module(keysockdomain)
> diff --git a/policy/test_policy.if b/policy/test_policy.if
> index e1175e8..cefc8fb 100644
> --- a/policy/test_policy.if
> +++ b/policy/test_policy.if
> @@ -76,9 +76,15 @@ interface(`mount_rw_pid_files', `
>   ')
>   ')
>   
> -# Refpolicy doesn't have admin_home_t - assume /root will be user_home_dir_t.
> +# Refpolicy does not have admin_home_t - assume /root will be user_home_dir_t.
>   ifdef(`userdom_search_admin_dir', `', ` dnl
>   interface(`userdom_search_admin_dir', `
>       userdom_search_user_home_content($1)
>   ')
>   ')
> +
> +# If the macro is not defined, then most probably module_request permission
> +# is just not supported (and relevant operations should be just allowed).
> +ifdef(`kernel_request_load_module', `', ` dnl
> +interface(`kernel_request_load_module', `')
> +')
> 

