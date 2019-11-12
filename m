Return-Path: <SRS0=MTWr=ZE=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACA2DC43331
	for <selinux@archiver.kernel.org>; Tue, 12 Nov 2019 14:35:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 697212067B
	for <selinux@archiver.kernel.org>; Tue, 12 Nov 2019 14:35:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="N/C8U5Kt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727505AbfKLOfc (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 12 Nov 2019 09:35:32 -0500
Received: from UHIL19PA40.eemsg.mail.mil ([214.24.21.199]:14029 "EHLO
        UHIL19PA40.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726497AbfKLOfb (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 12 Nov 2019 09:35:31 -0500
X-EEMSG-check-017: 47686333|UHIL19PA40_ESA_OUT06.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.68,296,1569283200"; 
   d="scan'208";a="47686333"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by UHIL19PA40.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 12 Nov 2019 14:35:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1573569329; x=1605105329;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=9J5jPb/D0cF63vhy8CUevx6/2XBG6DIlL/AO9U3aouM=;
  b=N/C8U5Ktaa/XriwuCHVOXoNFyMYGuJfGZQeNpbaRIyLLy7gW0QlEZjrl
   dxvZzbwscaTbb5Uu6BfBz0fe47vkAisdW9VNjJkU9NgiUOBfTNm9ZLoqn
   MVwk1vDocKb6e4tlpW3bGW4Yq9u8wmUn9ZYpVXnpJst1c5BYSxbk1oCCc
   eJ6VKXkc1WGFZ2O7XF7zWPIh5Jpfg/9MpLo4ae4D3oga9iPhu0YkyRdMm
   UcjnSz8mCEOZp3XPh6QCg6hVFMW3hphLo9OMK6yPQot7L6cLBHjyrnVEH
   QCHxDNCbRa97GNovmaCf9YXyLSvT30sOtnzKlhEcfLk20K8yAg650RPQE
   w==;
X-IronPort-AV: E=Sophos;i="5.68,296,1569283200"; 
   d="scan'208";a="29989011"
IronPort-PHdr: =?us-ascii?q?9a23=3ArnJ/IRDJ6jgr9oxXXd58UyQJP3N1i/DPJgcQr6?=
 =?us-ascii?q?AfoPdwSPX+ocbcNUDSrc9gkEXOFd2Cra4d0KyP6fGrBzFIyK3CmUhKSIZLWR?=
 =?us-ascii?q?4BhJdetC0bK+nBN3fGKuX3ZTcxBsVIWQwt1Xi6NU9IBJS2PAWK8TW94jEIBx?=
 =?us-ascii?q?rwKxd+KPjrFY7OlcS30P2594HObwlSizexfL1/IA+roQnPssQajopvJ6YswR?=
 =?us-ascii?q?bVv3VEfPhby3l1LlyJhRb84cmw/J9n8ytOvv8q6tBNX6bncakmVLJUFDspPX?=
 =?us-ascii?q?w7683trhnDUBCA5mAAXWUMkxpHGBbK4RfnVZrsqCT6t+592C6HPc3qSL0/RD?=
 =?us-ascii?q?qv47t3RBLulSwKLCAy/n3JhcNsjaJbuBOhqAJ5w47Ie4GeKf5ycrrAcd8GWW?=
 =?us-ascii?q?ZNW8BcWCJbAoO4coABEewPM+hFpIX5vlcCsx+zCQyqCejyyDFHm2X20LUn3e?=
 =?us-ascii?q?o/HwHI3A8uEdwAv3vbrtr6KKgcXPupzKTL1zjPc+9a1Dn/5YXObxsvoeuMXb?=
 =?us-ascii?q?V1ccfJ1EcvCx3Kjk2QqYP7OTOey/kDs22B4OpkUeKglW4moBx2rzi028gskZ?=
 =?us-ascii?q?LEhp4Vy1/Y9SV5x5w5JdujSEFhe9KkH5xQtz+DOoZwX8gsTWZouCMgxb0Hv5?=
 =?us-ascii?q?62ZCcKyJU7xx7fdvyIaJKE7Q7kVOaUOTt4gXVld6+lixap8Uis0uv8VtKu31?=
 =?us-ascii?q?pQoSpFlcfMu3YQ3BLQ8siKUuZx80iu1DqV1w3f9/tILV47mKbFMZIt37g9nY?=
 =?us-ascii?q?cJv0vZBC/5gkD2gbeTdkUj5+en9fzqYq7jpp+AL490jRz+Mrg2lsy/H+s4Ng?=
 =?us-ascii?q?8OUnCH+eumzr3j/FD5QK5Qgv0qkqjWrJDaJcMBqq6/HwBVyZos5wy6Dzen1N?=
 =?us-ascii?q?QUhXgHLFRbdxKbl4XlJl7DLf/iAfq/nligiilnyv/YMrH7H5nBNn3Dn63gfb?=
 =?us-ascii?q?Z55U5c0g0zzdVH6pJPF74BO+n+WlPxtdPEDh85NBa4w+D8CNpnzI8eVmWPAr?=
 =?us-ascii?q?GBPKPIrVCI/v4vI/WLZIINoDb9L+Iq5+PyjX8jglASZ7Kk3YEJZ3+lHvRpOV?=
 =?us-ascii?q?mZbWDwjdcGFGcAphA+Q/DyiF2eTT5TYG6/X7ki6TE/CYKmC5rDR4+2jbyf0y?=
 =?us-ascii?q?e0AIdWanpFCl+SC3focZuLW/MWZCKVOM9hnW9Mab/0c4I9z1mKvRLm0bBuJe?=
 =?us-ascii?q?qcrjUcvI//ztJ8z/femRE76Xp/CMHLlymWQmV1mH4YbyE50bo5okFnzFqHl6?=
 =?us-ascii?q?9ijK92D9tWsshVXx86OJiU9OlzD9T/S0qVZduSYEq3SdWhRzcqR5Q+xMFYMB?=
 =?us-ascii?q?U1IMmrkh2Wh3niOLQSjbHeQcVuo68=3D?=
X-IPAS-Result: =?us-ascii?q?A2DaAAAmwMpd/wHyM5AaA0gaAQEBAQEBAQEBAwEBAQERA?=
 =?us-ascii?q?QEBAgIBAQEBgX4CgXIsbFUyKoQpjwRUBoE2iWaOZQKCXAkBAQEBAQEBAQErC?=
 =?us-ascii?q?QECAQGDe0UCgh0kOBMCDgEBAQQBAQEBAQUDAQFshQsIJAyCOykBgm0BBSMPA?=
 =?us-ascii?q?QURQAkCDgoCAiYCAlcGAQwGAgEBgl8eFwoBglIlD5EGgVpam3KBMoQ5AYEUg?=
 =?us-ascii?q?zKBSIEOKAGMExh4gQeBOIJrPoIBVgsChHGCXgSND4oGlnuCL4I2hGGOJwYbg?=
 =?us-ascii?q?y+WShmENYl5hzx6k1EigVgrCAIYCCEPO4JsCUcRFIVFi0GDI4F/iHIjAzABg?=
 =?us-ascii?q?QQBAZBXAQE?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 12 Nov 2019 14:35:28 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id xACEZQXW022778;
        Tue, 12 Nov 2019 09:35:28 -0500
Subject: Re: [PATCH] Replace www.nsa.gov references by
 github.com/SELinuxProject
To:     Petr Lautrbach <plautrba@redhat.com>, selinux@vger.kernel.org
References: <20191106163043.1081424-1-plautrba@redhat.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <e0b9085a-0daf-dcb0-6fba-765a37070a88@tycho.nsa.gov>
Date:   Tue, 12 Nov 2019 09:35:26 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <20191106163043.1081424-1-plautrba@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 11/6/19 11:30 AM, Petr Lautrbach wrote:
> The original page doesn't exist anymore.
> 
> Fixes: https://github.com/SELinuxProject/selinux/issues/170
> 
> Signed-off-by: Petr Lautrbach <plautrba@redhat.com>

Thanks, applied.

> ---
>   checkpolicy/checkmodule.8        | 3 +--
>   checkpolicy/checkpolicy.8        | 3 +--
>   checkpolicy/ru/checkmodule.8     | 3 +--
>   checkpolicy/ru/checkpolicy.8     | 4 +---
>   libselinux/man/man8/selinux.8    | 2 +-
>   libselinux/man/ru/man8/selinux.8 | 2 +-
>   python/sepolgen/HACKING          | 2 --
>   7 files changed, 6 insertions(+), 13 deletions(-)
> 
> diff --git a/checkpolicy/checkmodule.8 b/checkpolicy/checkmodule.8
> index e55582f3..e597d9d4 100644
> --- a/checkpolicy/checkmodule.8
> +++ b/checkpolicy/checkmodule.8
> @@ -59,8 +59,7 @@ $ checkmodule \-M \-m httpd.te \-o httpd.mod
>   
>   .SH "SEE ALSO"
>   .B semodule(8), semodule_package(8)
> -SELinux documentation at http://www.nsa.gov/research/selinux,
> -especially "Configuring the SELinux Policy".
> +SELinux Reference Policy documentation at https://github.com/SELinuxProject/refpolicy/wiki
>   
>   
>   .SH AUTHOR
> diff --git a/checkpolicy/checkpolicy.8 b/checkpolicy/checkpolicy.8
> index bdfd6acd..97e10ca7 100644
> --- a/checkpolicy/checkpolicy.8
> +++ b/checkpolicy/checkpolicy.8
> @@ -60,8 +60,7 @@ Show version information.
>   Show usage information.
>   
>   .SH "SEE ALSO"
> -SELinux documentation at http://www.nsa.gov/research/selinux,
> -especially "Configuring the SELinux Policy".
> +SELinux Reference Policy documentation at https://github.com/SELinuxProject/refpolicy/wiki
>   
>   
>   .SH AUTHOR
> diff --git a/checkpolicy/ru/checkmodule.8 b/checkpolicy/ru/checkmodule.8
> index 93e68e70..a1d687e3 100644
> --- a/checkpolicy/ru/checkmodule.8
> +++ b/checkpolicy/ru/checkmodule.8
> @@ -46,8 +46,7 @@ $ checkmodule \-M \-m httpd.te \-o httpd.mod
>   
>   .SH "СМОТРИТЕ ТАКЖЕ"
>   .B semodule(8), semodule_package(8)
> -Документация SELinux по адресу http://www.nsa.gov/research/selinux,
> -в частности - "Настройка политики SELinux".
> +Документация SELinux Reference Policy по адресу https://github.com/SELinuxProject/refpolicy/wiki
>   
>   
>   .SH АВТОРЫ
> diff --git a/checkpolicy/ru/checkpolicy.8 b/checkpolicy/ru/checkpolicy.8
> index 2ad39b8e..25b0e555 100644
> --- a/checkpolicy/ru/checkpolicy.8
> +++ b/checkpolicy/ru/checkpolicy.8
> @@ -51,9 +51,7 @@ checkpolicy \- компилятор политики SELinux
>   Показать сведения об использовании.
>   
>   .SH "СМОТРИТЕ ТАКЖЕ"
> -Документация SELinux по адресу http://www.nsa.gov/research/selinux,
> -в частности - "Настройка политики SELinux".
> -
> +Документация SELinux Reference Policy по адресу https://github.com/SELinuxProject/refpolicy/wiki
>   
>   .SH АВТОРЫ
>   Эта страница руководства была написана Arpad Magosanyi <mag@bunuel.tii.matav.hu>,
> diff --git a/libselinux/man/man8/selinux.8 b/libselinux/man/man8/selinux.8
> index e37aee68..31364271 100644
> --- a/libselinux/man/man8/selinux.8
> +++ b/libselinux/man/man8/selinux.8
> @@ -10,7 +10,7 @@ enforcement of many kinds of mandatory access control policies,
>   including those based on the concepts of Type Enforcement®, Role-
>   Based Access Control, and Multi-Level Security.  Background
>   information and technical documentation about SELinux can be found at
> -http://www.nsa.gov/research/selinux.
> +https://github.com/SELinuxProject.
>   
>   The
>   .I /etc/selinux/config
> diff --git a/libselinux/man/ru/man8/selinux.8 b/libselinux/man/ru/man8/selinux.8
> index 5cc48df8..271809de 100644
> --- a/libselinux/man/ru/man8/selinux.8
> +++ b/libselinux/man/ru/man8/selinux.8
> @@ -9,7 +9,7 @@ Linux с улучшенной безопасностью от NSA - это ре
>   включая основанные на концепциях Type Enforcement® (принудительное присвоение типов),
>   Role-Based Access Control (управление доступом на основе ролей) и Multi-Level Security
>   (многоуровневая безопасность). Дополнительная информация и техническая документация по
> -SELinux доступна по адресу http://www.nsa.gov/research/selinux.
> +SELinux доступна по адресу https://github.com/SELinuxProject.
>   
>   Файл конфигурации
>   .I /etc/selinux/config
> diff --git a/python/sepolgen/HACKING b/python/sepolgen/HACKING
> index e624a1b4..f7d07774 100644
> --- a/python/sepolgen/HACKING
> +++ b/python/sepolgen/HACKING
> @@ -75,5 +75,3 @@ Information about the SELinux object classes. This is semantic
>   information about the object classes - including information flow. It
>   is separated to keep the core from being concerned about the details
>   of the object classes.
> -
> -[selist]: http://www.nsa.gov/research/selinux/info/list.cfm
> 

