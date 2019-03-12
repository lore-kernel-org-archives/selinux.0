Return-Path: <SRS0=/sJJ=RP=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B921C43381
	for <selinux@archiver.kernel.org>; Tue, 12 Mar 2019 20:21:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D028B214AE
	for <selinux@archiver.kernel.org>; Tue, 12 Mar 2019 20:21:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="oCcrZQQT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726510AbfCLUVU (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 12 Mar 2019 16:21:20 -0400
Received: from upbd19pa12.eemsg.mail.mil ([214.24.27.87]:50437 "EHLO
        upbd19pa12.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726487AbfCLUVU (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 12 Mar 2019 16:21:20 -0400
X-EEMSG-check-017: 196149196|UPBD19PA12_EEMSG_MP12.csd.disa.mil
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by upbd19pa12.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 12 Mar 2019 20:21:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1552422062; x=1583958062;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=AJ6uoGYzwnG6v1r9poWuiQzJMhgHbv7AkuySoSRjsUU=;
  b=oCcrZQQTyziOhuGFO74A99eUxWFrndrZk09a6kwaV+aoEKTlD6wQSxzL
   V6G5mMPWdrKFipmXky13PQ2gkGh7gzIULvc+lngUkcP+pH0Dr1CuQtbxF
   J2hKF5NrJoH3ETBUcgfFpw9/C0qCpMc3q4m53CwvWFajgY84MWTBc4fe4
   E8LhWquAO4LJ6r5jVE8kKCtEscb5P+dyDeQjmAjINS3wkU1WJO4651B7c
   7I0ewk2OBN4mJyUacOb2iN1kL+cr7FkvYa+5fNaMPomP7uwPjwG17shG5
   WKRjuQ6OH1ugASpANOzcMaXJQYynakvIQihlCS56ZLw+GkkiFrmpZ21c7
   g==;
X-IronPort-AV: E=Sophos;i="5.58,471,1544486400"; 
   d="scan'208";a="24949589"
IronPort-PHdr: =?us-ascii?q?9a23=3Ajz0LXxYm2zM1Aq9HDBDIfej/LSx+4OfEezUN45?=
 =?us-ascii?q?9isYplN5qZps2zYB7h7PlgxGXEQZ/co6odzbaP6+a4ACQp2tWoiDg6aptCVh?=
 =?us-ascii?q?sI2409vjcLJ4q7M3D9N+PgdCcgHc5PBxdP9nC/NlVJSo6lPwWB6nK94iQPFR?=
 =?us-ascii?q?rhKAF7Ovr6GpLIj8Swyuu+54Dfbx9HiTagfb9+Ngm6oRjMvcQKnIVuLbo8xA?=
 =?us-ascii?q?HUqXVSYeRWwm1oJVOXnxni48q74YBu/SdNtf8/7sBMSar1cbg2QrxeFzQmLn?=
 =?us-ascii?q?s65Nb3uhnZTAuA/WUTX2MLmRdVGQfF7RX6XpDssivms+d2xSeXMdHqQb0yRD?=
 =?us-ascii?q?+v9LlgRgP2hygbNj456GDXhdJ2jKJHuxKquhhzz5fJbI2JKPZye6XQct0ARW?=
 =?us-ascii?q?pFQ81fSSpPDI2hZIcLFuYNI+JVo4z7qlATrxWxGBOsCfvyxDFWiH/43a403e?=
 =?us-ascii?q?ovHg7J3gMvA90AvW/IrNj3LqoeTfy5wafKwDjFcvhY2S396I/Nch05vP+MQa?=
 =?us-ascii?q?x/cdLRyUYxEQPOk0ieqYn/MDOR0uQCrWia5PdnWOK0lmEnsBp8oiSvx8gwio?=
 =?us-ascii?q?nJgZgZylbf9Spj2oo1Ktq4SFBibNOiDZBeuSaaN45sTcMjRWFloCU6xaMcuZ?=
 =?us-ascii?q?69YicKzI4rxxnFa/yIdYWD/xHtVP6JLDtli39od6izihav/US61OHxWde43E?=
 =?us-ascii?q?xXoidDj9LCrGoC1wbJ5ciCUvZ9+0Ch1iuR2A3L8eFEJFw0lbLcK5483r48jp?=
 =?us-ascii?q?oTvlrHHi/xgEj2kLWZdl8l+ui18OTreKnmp5+AOI90jQHyKKIuldCkAeskKA?=
 =?us-ascii?q?QOWmmb+eCk2L3i+032XqlKg+UrnqTWv53WP8QWqrOjDwNL3Ysv9QyzAyq+3N?=
 =?us-ascii?q?Qdh3YHLVZFeBydj4juPlHDOOv4Auqkg1m3jDdqx+zJPr3mApnXKHjDi63uca?=
 =?us-ascii?q?xy605b1go/1cpf6I5MCrEdPPLzXVf8tN7fDh85KQO0xeDnB8tm1o4FW2KPBL?=
 =?us-ascii?q?SWMLnIvV+N+O0lO/OMa5MNuDbhN/gl4ObjjWcjll8AeamkxoMXZ2qlHvRiOk?=
 =?us-ascii?q?mZZH3sgtAbEWgUpAYxUOvqiFiaWz5Je3myR7485i08CI++E4jDXpqigKaA3C?=
 =?us-ascii?q?egBZBWfnpJCkqNEXfzb4WEX+0DZz6MLcN7lTwET7ehQZc71R6yrA/616ZnLu?=
 =?us-ascii?q?3M9y0Dq53j0Nl15+vOlRA97jF0Ecud3H+XT21unWMHWSU23KZhrkx50FuD1r?=
 =?us-ascii?q?J4g/NAH9xJ+/xJShs6NYLbz+FiD9DyWwTBfsqGSVq/QdWpHysxTtQvzN8KeE?=
 =?us-ascii?q?t9BdqigQ7Z3yawAL8aiaaLBJoq/aLYxXTxINx9y3mVnJUm2nshQsJJM2C9zo?=
 =?us-ascii?q?Rl+gPTG4vAlUPRw6Stda0a2iPW3GWFx3DIuUwOFEZIWLjBFVUYYVHb5YDh71?=
 =?us-ascii?q?7GZ6enFLBiNwxG08PEIaxPPJmhoE9HT7/bMc7feCrlln+5HxeT7quFdovxY2?=
 =?us-ascii?q?EU1yibD1ILxURb5nuCNA4jFg+/rG/ESj9jD1TiZwXr6+Y64He6SFIkigKHdU?=
 =?us-ascii?q?ts05Kr9RMPw/+RUfUe2vQDoihyhS9zGQOGw9/OC9eG7zFkdaFYbMJ1tExLzk?=
 =?us-ascii?q?rFpgd9OdqmNKkkiVkAJVck93jy3gl6X90T2fMhq2knmU8rc/OV?=
X-IPAS-Result: =?us-ascii?q?A2CCAADzE4hc/wHyM5BkHQEBBQEHBQGBUwYBCwGBZSpog?=
 =?us-ascii?q?QMnhAqTU0wBAQEBAQEGgQgtiT+ObIF7MAgBhEAChDkiNgcNAQEDAQEBCAEDA?=
 =?us-ascii?q?gFsHAyCOikBgmYBAQEBAyMVUQsRAwECAQICJgICTwgGAQwGAgEBgl8/AYFoD?=
 =?us-ascii?q?Q+wXIEvhDABgRSEbQWBCyQBiywXeIEHgTiCa4gLglcDkHZMkmwJh1WLOgYZg?=
 =?us-ascii?q?XmFZotdLYpNgROEV4lDhRwIKYFWKwgCGAghD4MnE4IDF4hfhVsjAzABAYEDA?=
 =?us-ascii?q?QGQPwEB?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 12 Mar 2019 20:21:01 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x2CKKxt8009864;
        Tue, 12 Mar 2019 16:20:59 -0400
Subject: Re: [PATCH] selinux: use kernel definition of PF_MAX in scripts
To:     Johannes Brechtmann <johannes@jnbr.me>,
        Paul Moore <paul@paul-moore.com>,
        Eric Paris <eparis@parisplace.org>, selinux@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190312194758.6f411a8b@t440s.fritz.box>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <30b42bae-2aef-071f-6d59-fda40d2e4ff2@tycho.nsa.gov>
Date:   Tue, 12 Mar 2019 16:16:54 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190312194758.6f411a8b@t440s.fritz.box>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 3/12/19 2:47 PM, Johannes Brechtmann wrote:
>  From 1892b9ff8045bac6fe166802b2d8a8a3111c1e0c Mon Sep 17 00:00:00 2001
> From: Johannes Brechtmann <johannes@jnbr.me>
> Date: Tue, 12 Mar 2019 17:50:12 +0100
> Subject: [PATCH] selinux: use kernel definition of PF_MAX in scripts
> 
> Building selinux scripts of old releases on a current host fails with:
> 
>      In file included from scripts/selinux/genheaders/genheaders.c:19:
>      ./security/selinux/include/classmap.h:245:2: error: #error New
>      address family defined, please update secclass_map.
> 
> Fix the issue by including linux/socket.h from kernel instead of
> sys/socket.h from host.
> 
> Signed-off-by: Johannes Brechtmann <johannes@jnbr.me>

Thanks, but already covered by
https://lore.kernel.org/selinux/20190225005528.28371-1-paulo@paulo.ac/

> ---
>   scripts/selinux/genheaders/genheaders.c | 2 +-
>   scripts/selinux/mdp/mdp.c               | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/scripts/selinux/genheaders/genheaders.c b/scripts/selinux/genheaders/genheaders.c
> index 1ceedea847dd..6db7e07fbc4c 100644
> --- a/scripts/selinux/genheaders/genheaders.c
> +++ b/scripts/selinux/genheaders/genheaders.c
> @@ -9,7 +9,7 @@
>   #include <string.h>
>   #include <errno.h>
>   #include <ctype.h>
> -#include <sys/socket.h>
> +#include <linux/socket.h>
>   
>   struct security_class_mapping {
>   	const char *name;
> diff --git a/scripts/selinux/mdp/mdp.c b/scripts/selinux/mdp/mdp.c
> index 073fe7537f6c..744d9fc9c0bd 100644
> --- a/scripts/selinux/mdp/mdp.c
> +++ b/scripts/selinux/mdp/mdp.c
> @@ -32,7 +32,7 @@
>   #include <stdlib.h>
>   #include <unistd.h>
>   #include <string.h>
> -#include <sys/socket.h>
> +#include <linux/socket.h>
>   
>   static void usage(char *name)
>   {
> 

