Return-Path: <SRS0=n8ca=RC=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF7FCC43381
	for <selinux@archiver.kernel.org>; Wed, 27 Feb 2019 17:27:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE8E020C01
	for <selinux@archiver.kernel.org>; Wed, 27 Feb 2019 17:27:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="IkjGLXOE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726397AbfB0R1q (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 27 Feb 2019 12:27:46 -0500
Received: from upbd19pa10.eemsg.mail.mil ([214.24.27.85]:46313 "EHLO
        upbd19pa10.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726223AbfB0R1p (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 27 Feb 2019 12:27:45 -0500
X-EEMSG-check-017: 203389446|UPBD19PA10_EEMSG_MP10.csd.disa.mil
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by upbd19pa10.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 27 Feb 2019 17:27:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1551288462; x=1582824462;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=kIMMIE5Ej4reTGc+RraoiW5y3aQZVAN618jhyB5MfA8=;
  b=IkjGLXOEUc7Kn0alBNBL1Tr9K1fO9m3v3dui4b/zVuezX1TzbkY3uxjD
   bKnT5TGFRlZCgTVQng05gYdY0ASmcGl1DTSdTt4I2Wq9/teMpN14xUbUV
   gtNoSELMFRalemA2K3kTkjKxZpzOn5xYwVNzsidHyQgFyaPsR0xolzNYG
   SGPp5RntVkyXdKujRp7wP7supXSz4jyd0d42Vhew2LSCqAx+m1QOtlV8x
   NDAkoaK78zaZY2EaT9tsqDzyRKW/uohDutPzt4IYjg/g8uwJ/Urk/GBB+
   PQxjcMPEqXwcJfxWtkawO+Q3UjLdoFeFRlEhldB75b3RB+8dx7f1DR0Bn
   g==;
X-IronPort-AV: E=Sophos;i="5.58,420,1544486400"; 
   d="scan'208";a="20950606"
IronPort-PHdr: =?us-ascii?q?9a23=3AxJXaKhOLVGWNp05L7owl6mtUPXoX/o7sNwtQ0K?=
 =?us-ascii?q?IMzox0I/39rarrMEGX3/hxlliBBdydt6oUzbKO+4nbGkU4qa6bt34DdJEeHz?=
 =?us-ascii?q?Qksu4x2zIaPcieFEfgJ+TrZSFpVO5LVVti4m3peRMNQJW2aFLduGC94iAPER?=
 =?us-ascii?q?vjKwV1Ov71GonPhMiryuy+4ZLebxlLiTanfb9+MAi9oBnMuMURnYZsMLs6xA?=
 =?us-ascii?q?HTontPdeRWxGdoKkyWkh3h+Mq+/4Nt/jpJtf45+MFOTav1f6IjTbxFFzsmKH?=
 =?us-ascii?q?w65NfqtRbYUwSC4GYXX3gMnRpJBwjF6wz6Xov0vyDnuOdxxDWWMMvrRr0vRz?=
 =?us-ascii?q?+s87lkRwPpiCcfNj427mfXitBrjKlGpB6tvgFzz5LIbI2QMvdxcLndfdcHTm?=
 =?us-ascii?q?RfWMhfWTFKDoelY4cRE+YNOOBVpJT/qVQTtxuzHRSiCv3hyjFIhXH406M13O?=
 =?us-ascii?q?sjHg7a0wItBM4OvXbOodnpKKsfX+K4wa/VxjvDdfNW3jL95ZDVfBA9v/6MRb?=
 =?us-ascii?q?JwftTXyUIyCg3Fi0+fqYjhPzyL1uUGrm+W7/F9WuK0kGMntwFwrSSvxscrkI?=
 =?us-ascii?q?XJgJkVxUre+SV2x4Y1O8S1RUhmatCnCJtdrzyWOoR5T884Q2xkpTw2xqMJtJ?=
 =?us-ascii?q?KlZiQG1ZIqzAPFZfOdaYiH+BfjWf6UITd/mX1qZqqyhw238Ui80u38UdS00E?=
 =?us-ascii?q?pSoipFjNbMsncN2gTP6sedUPt9/1qh2S2V2wDP6uBLPUA0la3BJ54n3rEwjY?=
 =?us-ascii?q?YcvV7GHi/3nEX6lK6WdkM69ei08+nrf7rrq5CGO4J0lw3yKLoil8OhDegiLw?=
 =?us-ascii?q?QCR22b9v691L3n8035WrJKjvgun6nCrZ/aPt8WprK5AgBJ0oYj7AyzDzG90N?=
 =?us-ascii?q?sCh3UHI1VFeAyfg4jzJ17OOOz4Deu4g1m0iDdk3e3GPrnmApjWNnjMiqrhfb?=
 =?us-ascii?q?J660JG0gU80chV54hIBbEZPPLzRkjxucTDDhAnNwy0wuDnCMhy144FR2KPDb?=
 =?us-ascii?q?GWMLnIvV+L+O0vOe+Ma5ERuDrnLPgl/fHuh2cjmVABZampwYcXaHegE/R+OU?=
 =?us-ascii?q?qZfH7sj8wZEWgQowo+SPXmiFiFUT5UfXa9Qbgw6S08CIKjXs//QdWViaGF22?=
 =?us-ascii?q?+SGpZfYHxPEFnERW/haoGDc+8FdSaVZMZqxHhMTrWlSok8xTmwuwLgjblqNO?=
 =?us-ascii?q?zZ/msfr52w+sJy4rjoiRwq9TFyR/+Y2mWJQnA8yngEXBcqzat/pgp70V7F3q?=
 =?us-ascii?q?9m1a8LXedP7u9EB19pfaXXyPZ3XpWrAFrM?=
X-IPAS-Result: =?us-ascii?q?A2ApAQARyHZc/wHyM5BkHAEBAQQBAQcEAQGBVAQBAQsBg?=
 =?us-ascii?q?VkqgWonhAiUNAEBAQEBAQaBCC2JPJBfOAGEQAKEDSI3Bg0BAwEBAQEBAQIBb?=
 =?us-ascii?q?CiCOikBgmcBBSMVQRALGAICJgICVwYBDAYCAQGCXz2BZg2reYEvhUSEaIELi?=
 =?us-ascii?q?z0XeIEHgREngmuIC4JXApBYSzuSDAmSZAYZgXOFX4NGiAQtijCBEo1jhSYig?=
 =?us-ascii?q?VYrCAIYCCEPgyeCKBeOPCEDMIEFAQGRPwEB?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 27 Feb 2019 17:27:40 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x1RHRexJ002966;
        Wed, 27 Feb 2019 12:27:40 -0500
Subject: Re: [PATCH] selinux: use kernel linux/socket.h definitions for PF_MAX
To:     Paulo Alcantara <paulo@paulo.ac>, selinux@vger.kernel.org
Cc:     paul@paul-moore.com
References: <20190225005528.28371-1-paulo@paulo.ac>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <43e38f1b-60c4-133c-1e9e-6ad622f69264@tycho.nsa.gov>
Date:   Wed, 27 Feb 2019 12:23:44 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190225005528.28371-1-paulo@paulo.ac>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 2/24/19 7:55 PM, Paulo Alcantara wrote:
> When compiling genheaders and mdp from a newer host kernel, the
> following error happens:
> 
>      In file included from scripts/selinux/genheaders/genheaders.c:18:
>      ./security/selinux/include/classmap.h:238:2: error: #error New
>      address family defined, please update secclass_map.  #error New
>      address family defined, please update secclass_map.  ^~~~~
>      make[3]: *** [scripts/Makefile.host:107:
>      scripts/selinux/genheaders/genheaders] Error 1 make[2]: ***
>      [scripts/Makefile.build:599: scripts/selinux/genheaders] Error 2
>      make[1]: *** [scripts/Makefile.build:599: scripts/selinux] Error 2
>      make[1]: *** Waiting for unfinished jobs....
> 
> Instead of relying on the host definition, include linux/socket.h in
> classmap.h to have PF_MAX.
> 
> Signed-off-by: Paulo Alcantara <paulo@paulo.ac>

Acked-by: Stephen Smalley <sds@tycho.nsa.gov>

> ---
>   scripts/selinux/genheaders/genheaders.c | 1 -
>   scripts/selinux/mdp/mdp.c               | 1 -
>   security/selinux/include/classmap.h     | 1 +
>   3 files changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/scripts/selinux/genheaders/genheaders.c b/scripts/selinux/genheaders/genheaders.c
> index 1ceedea847dd..544ca126a8a8 100644
> --- a/scripts/selinux/genheaders/genheaders.c
> +++ b/scripts/selinux/genheaders/genheaders.c
> @@ -9,7 +9,6 @@
>   #include <string.h>
>   #include <errno.h>
>   #include <ctype.h>
> -#include <sys/socket.h>
>   
>   struct security_class_mapping {
>   	const char *name;
> diff --git a/scripts/selinux/mdp/mdp.c b/scripts/selinux/mdp/mdp.c
> index 073fe7537f6c..6d51b74bc679 100644
> --- a/scripts/selinux/mdp/mdp.c
> +++ b/scripts/selinux/mdp/mdp.c
> @@ -32,7 +32,6 @@
>   #include <stdlib.h>
>   #include <unistd.h>
>   #include <string.h>
> -#include <sys/socket.h>
>   
>   static void usage(char *name)
>   {
> diff --git a/security/selinux/include/classmap.h b/security/selinux/include/classmap.h
> index bd5fe0d3204a..201f7e588a29 100644
> --- a/security/selinux/include/classmap.h
> +++ b/security/selinux/include/classmap.h
> @@ -1,5 +1,6 @@
>   /* SPDX-License-Identifier: GPL-2.0 */
>   #include <linux/capability.h>
> +#include <linux/socket.h>
>   
>   #define COMMON_FILE_SOCK_PERMS "ioctl", "read", "write", "create", \
>       "getattr", "setattr", "lock", "relabelfrom", "relabelto", "append", "map"
> 

