Return-Path: <SRS0=6oqa=Y7=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 610F5C43331
	for <selinux@archiver.kernel.org>; Thu,  7 Nov 2019 19:34:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CBAB2087E
	for <selinux@archiver.kernel.org>; Thu,  7 Nov 2019 19:34:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="MrQAIVF2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725916AbfKGTen (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 7 Nov 2019 14:34:43 -0500
Received: from UCOL19PA35.eemsg.mail.mil ([214.24.24.195]:9892 "EHLO
        UCOL19PA35.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725785AbfKGTen (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 7 Nov 2019 14:34:43 -0500
X-EEMSG-check-017: 47290750|UCOL19PA35_ESA_OUT02.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.68,279,1569283200"; 
   d="scan'208";a="47290750"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by UCOL19PA35.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 07 Nov 2019 19:34:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1573155278; x=1604691278;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=D35g4LJyxs2xBDe/TP+fx8bW4Ut5KKUlqdDf51V3+PU=;
  b=MrQAIVF2EZasSbbgGaE2nMX8Sest4BdfETbk4xa8DEHCCG6mazmgVFI9
   pPxZs/DoCFxxlbONC594cYiPQA91KrPVsEK0VQcIdl+gaR+Wtug2gGt8s
   8Nu3duHhUxCnaa3KjSh2b77h15Df20CzsJ4C9qixyGzz2wRuzBDXMMU4/
   kQS4yB8pqwt/Rw/PD4TC/BvCD5PjhRa2/c2ASUPOKt9ZUlhJBIwZ11V37
   3bSPStA7B3lZd2CGt52FbIE0ZRj8ASa3OV0VVapP4dHYpF5qQEG8ZeZqP
   h6VfRNIZMDmmrjfCd8IUmwtnD2lGL4+gSU8TCWxZh3L5bYbTcvSW81YxF
   g==;
X-IronPort-AV: E=Sophos;i="5.68,279,1569283200"; 
   d="scan'208";a="29888046"
IronPort-PHdr: =?us-ascii?q?9a23=3AnbffoR2e36fudEmTsmDT+DRfVm0co7zxezQtwd?=
 =?us-ascii?q?8ZseMTI/ad9pjvdHbS+e9qxAeQG9mCsLQd0rud6vq9EUU7or+5+EgYd5JNUx?=
 =?us-ascii?q?JXwe43pCcHRPC/NEvgMfTxZDY7FskRHHVs/nW8LFQHUJ2mPw6arXK99yMdFQ?=
 =?us-ascii?q?viPgRpOOv1BpTSj8Oq3Oyu5pHfeQpFiCezbL9oMRm6sAHcusYLjYd8Kqs61w?=
 =?us-ascii?q?fErGZPd+lK321jOEidnwz75se+/Z5j9zpftvc8/MNeUqv0Yro1Q6VAADspL2?=
 =?us-ascii?q?466svrtQLeTQSU/XsTTn8WkhtTDAfb6hzxQ4r8vTH7tup53ymaINH2QLUpUj?=
 =?us-ascii?q?ms86tnVBnlgzocOjUn7G/YlNB/jKNDoBKguRN/xZLUYJqIP/Z6Z6/RYM8WSX?=
 =?us-ascii?q?ZEUstXWSNBGIe8ZJYRAeQHM+hTso3xq0IQoRa6AAWhAv7kxD1ViX/sxaA0zv?=
 =?us-ascii?q?ovEQ/G0gIjEdwBvnvbo9fpO6kdSu210KrFwC/fY/9K1zrw6o7FeQ0hr/GWWr?=
 =?us-ascii?q?JwdNLcx1QzFwzbllWQqZLqPzWI3eoQtmiU9e5gVeaxhG8ntgp8pSOvydo3io?=
 =?us-ascii?q?TSmoIUykzL9SV+wIovI924U1R0bcSrEJtXqSGXLo17Sd4sTWFvvSY10LwGuZ?=
 =?us-ascii?q?ijcSgFyZQn2x7fa+GcfISS/h3jU+ORLS99hHJiZb2znQ2y8Ui4xu36Tcm7yk?=
 =?us-ascii?q?xGriVCktnSsH0Gyh/d6tCfR/dg8Uqs1iyD2gDO5u1eP0w5mrTXJ4Q8zrM2i5?=
 =?us-ascii?q?Edq17MHjXsl0XzlKKWc0Ik9fW25On/ebXmo4OcN5dzigHjLqQigsy/Dvo8Mg?=
 =?us-ascii?q?gJR2Wb5f6z1Kfi/U3kW7VGlOE2k6nFv5DaIsQXvKi5DBNO0ok/8Rq/Cjam0N?=
 =?us-ascii?q?AAkXkGKlJKZg6HgpD0N1zBL/30F/eyj0m2nDt1yP3KIKftDojVInjGirjhfL?=
 =?us-ascii?q?J960BGyAo0yNBS/4lUBawaIP/oRk/wtMDXDh8+MwCuxebnE89y2pkRWWKIHK?=
 =?us-ascii?q?+VKLnSvkOQ5uIzP+mMY5cYuC75K/c/+v7ukWU5lkQHcqSyx5sYdm23HvR8LE?=
 =?us-ascii?q?WFe3bjntABEWIStAokUOPqkEGCUSJUZ3uqRKIz+DU7CIOgDYfeSYGgm6KB3C?=
 =?us-ascii?q?ilEZ1MfGxGCU6DEW3ud4qaX/cAciWSItVukm9Mab/0c4I9z1mKvRLm0bBuJe?=
 =?us-ascii?q?qcrjUcvI//ztJ8z/femRE76Xp/CMHLlymWQmV1mH4YbyE50bo5okFnzFqHl6?=
 =?us-ascii?q?9ijK92D9tWsshVXx86OJiU9OlzD9T/S0qVZduSYEq3SdWhRzcqR5Q+xMFYMB?=
 =?us-ascii?q?U1IMmrkh2Wh3niOLQSjbHeQcVuo68=3D?=
X-IPAS-Result: =?us-ascii?q?A2DRAAA9cMRd/wHyM5AaA0gaAQEBAQEBAQEBAwEBAQERA?=
 =?us-ascii?q?QEBAgIBAQEBgX4CgXIsbFUyKoQpjxlSAQEGgTaJZI5lAoJcCQEBAQEBAQEBA?=
 =?us-ascii?q?SsJAQIBAYN7RQKEDiQ4EwIOAQEBBAEBAQEBBQMBAWyFCwYmDII7KQGCbAEBA?=
 =?us-ascii?q?QECASMPAQURQAkCDgoCAiYCAlcGAQwGAgEBgl8eFwoBglIFIA+TOhyDJZp9d?=
 =?us-ascii?q?YEyhDkBgRSDLoFIgQ4oAYwTGHiBB4E4gms+ggFWCwKEcYJeBI0KigKWeIIug?=
 =?us-ascii?q?jaEYY4kBhuDLpZEGYQ1iXiHN3qTSiKBWCsIAhgIIQ87gmwJRxEUhUWLQYMjg?=
 =?us-ascii?q?X+IciMDMAGBBAEBkC4BAQ?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 07 Nov 2019 19:34:38 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id xA7JYbQi026729;
        Thu, 7 Nov 2019 14:34:38 -0500
Subject: Re: [PATCH] Replace www.nsa.gov references by
 github.com/SELinuxProject
To:     Petr Lautrbach <plautrba@redhat.com>, selinux@vger.kernel.org
References: <20191106163043.1081424-1-plautrba@redhat.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <b88fa654-dd3d-e9be-201c-718c31a74254@tycho.nsa.gov>
Date:   Thu, 7 Nov 2019 14:34:37 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
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

No objections although I can't verify the ru files myself aside from the 
URL matching.  I suppose someone might object on the grounds that 
SELinux can be used with policies other than refpolicy, but the only 
other potential references I can think of would be the SELinux Notebook 
or SELinux by Example.  Or we could just drop the text and URLs 
altogether and only list other man pages under the SEE ALSO sections.

> 
> Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
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

