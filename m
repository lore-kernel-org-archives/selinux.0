Return-Path: <SRS0=UID1=TY=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B5CEC072B5
	for <selinux@archiver.kernel.org>; Fri, 24 May 2019 16:47:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E23521773
	for <selinux@archiver.kernel.org>; Fri, 24 May 2019 16:47:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="YmMa//8z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390413AbfEXQrg (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 24 May 2019 12:47:36 -0400
Received: from upbd19pa07.eemsg.mail.mil ([214.24.27.82]:14156 "EHLO
        upbd19pa07.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390346AbfEXQrg (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 24 May 2019 12:47:36 -0400
X-EEMSG-check-017: 227302762|UPBD19PA07_EEMSG_MP7.csd.disa.mil
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by upbd19pa07.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 24 May 2019 16:47:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1558716451; x=1590252451;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=7Bx98lIcgDLNOxd+xO7k1IwL5ppujPgRHRLri4Ru3ws=;
  b=YmMa//8zxe3990DP6qNb1fVQ05opg0Tu4cb0izfMrTp56anYDfx91F/b
   UilWeEh2yQ2TS+7YyigO6JmPA5JMyAYXbnszHoEvlmyLMK+FlDUzcyoPc
   EpiWP7R5it/weQwt5a6CFzjuAH6N4nW4M/8/9js6RoYR/xLo4797EMYcf
   WZvaEuldCV2vwSkMYwBCPWjmWQrksseTrCM8qgugh7uC15NnYrD7na4au
   50QiIiVl3ROZayBuO3ZLhULyegBURhfBnnMEvtOYAl64cyAu+aJb3CLuR
   OB1/e56lUp6tRcQm4dULZsIdPKH6kQjk+3jPVpWZaZ+Y7F+4a0LYm2uRk
   Q==;
X-IronPort-AV: E=Sophos;i="5.60,507,1549929600"; 
   d="scan'208";a="28156750"
IronPort-PHdr: =?us-ascii?q?9a23=3A18Lh5BBazQ7RbDjgmLSDUyQJP3N1i/DPJgcQr6?=
 =?us-ascii?q?AfoPdwSPX5ocbcNUDSrc9gkEXOFd2Cra4d0qyP6v6rADRdqb+681k6OKRWUB?=
 =?us-ascii?q?EEjchE1ycBO+WiTXPBEfjxciYhF95DXlI2t1uyMExSBdqsLwaK+i764jEdAA?=
 =?us-ascii?q?jwOhRoLerpBIHSk9631+ev8JHPfglEnjWwba5vIBmssAndq8gbjYR/Jqotyh?=
 =?us-ascii?q?bCv2dFdflRyW50P1yYggzy5t23/J5t8iRQv+wu+stdWqjkfKo2UKJVAi0+P2?=
 =?us-ascii?q?86+MPkux/DTRCS5nQHSWUZjgBIAwne4x7kWJr6rzb3ufB82CmeOs32UKw0VD?=
 =?us-ascii?q?G/5KplVBPklCEKPCMi/WrJlsJ/kr5UoBO5pxx+3YHUZp2VNOFjda/ZZN8WWH?=
 =?us-ascii?q?ZNUtpUWyFHDIy8dY8PBPcfM+heoYf2ul8CoQKgCQSoAe/izCJDiH3r0q0gy+?=
 =?us-ascii?q?kvDB/I3AIgEdwNvnrbotr6O6UOXu6616TI0TfOYulK1Tvh5oXFcBYsquyMU7?=
 =?us-ascii?q?JqdsrRzFEiGR7ZjlqOsYzlPy2a1uIQuGaG6upvT+avi2o5pABxvzOiwdwshZ?=
 =?us-ascii?q?TSho8O1lDF9Tl2wIYyJdGiTk57esSrHIFftyGdKYt7W8UvSHxmtiY9z70Jo5?=
 =?us-ascii?q?+7fC4SxZQi3RHfbf6Kf5KP4hL5W+acJypzinF9eL+nmhq//ketxvf8W8Wpyl?=
 =?us-ascii?q?pGsCVInsfWunwQ0RHY99KJReFn/ki73DaCzwXT6uZZLk8qjafbMJshwqIolp?=
 =?us-ascii?q?oUrETDAjf6mEXog6+ScUUp4vSo5P79YrXnu5+cLJV4ih3+M6symsy/Bv40Mg?=
 =?us-ascii?q?4SUGiA5euwzrjj/Uz9QLlSj/02lLfWsIzCKMgGqaO0DBVZ34Y+5xqlETur38?=
 =?us-ascii?q?oUkWMaIF5dfRKIlYnpO1XAIPDiCve/hkyhkCx2yPDdJbDhHpXMIWTDkLfmZ7?=
 =?us-ascii?q?p97VVcxxApwdBQ4JJUFKkNIOjvVU/pqNzYEhg5PhSzw+biD9V9zYUeVniTDa?=
 =?us-ascii?q?CHK67Sq0GH6f8vI+aWeI8ZoiryK/8g5/T2l382hUcdfbW13ZsQcH24BeppI0?=
 =?us-ascii?q?GYYXrqn9cAHnwHvhQxTOP0kl2OSz1TaGioX6I6+D47DJiqDYDZRoCi0/S923?=
 =?us-ascii?q?KcGJFMa2IOL1eXF37jeobMD/AJbzmUK8RsuiYJWbioV8kq0hT48Efhxr5mKP?=
 =?us-ascii?q?fE0jMXuIil19Vv4eDX0xYo+m9aFcOYhlqRQnl0k2VAfDo/2KRysAQp0VuY+b?=
 =?us-ascii?q?RpiPxfU9pI7rVGVRlsZs2U9PBzF92nAlGJRdyOUlvzB4z8UDw=3D?=
X-IPAS-Result: =?us-ascii?q?A2BMCQDeH+hc/wHyM5BlHQEBBQEHBQGBZYFnKmlRATIoh?=
 =?us-ascii?q?BOTDEwBAQEDBoE1iU6RBQkBAQEBAQEBAQErCQECAQGEQAKCPyM4EwEDAQEBB?=
 =?us-ascii?q?AEBAQEDAQFsHAyCOikBgmYBAQEBAgEjFVELDgoCAhQMBgICVwYBDAYCAQGCX?=
 =?us-ascii?q?z8BgXYFDw+mCoEvg0SCA4MsgUaBDCiLUxd4gQeBOIJrPoJhBIIugjuCWASTV?=
 =?us-ascii?q?5RwCYIPghKEIYxZBhuDBpM7LYw7hwCQeyGBVysIAhgIIQ+DJwkWinSFWyMDM?=
 =?us-ascii?q?AGBBQEBi1eCLgEB?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 24 May 2019 16:47:14 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x4OGlETS022790;
        Fri, 24 May 2019 12:47:14 -0400
Subject: Re: [PATCH userspace] run_init: fix build when crypt() is not in
 unistd.h
To:     Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org
References: <20190513115826.22475-1-omosnace@redhat.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <7fc27051-f82c-62a0-9bee-468c69f00d2e@tycho.nsa.gov>
Date:   Fri, 24 May 2019 12:47:14 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190513115826.22475-1-omosnace@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 5/13/19 7:58 AM, Ondrej Mosnacek wrote:
> According to [1], crypt() support in POSIX is optional, so include
> also <crypt.h> when _XOPEN_CRYPT is not defined or is defined to -1.
> Without this I can't build run_init from source out-of-the-box on
> Fedora 29.
> 
> [1] http://man7.org/linux/man-pages/man3/crypt.3.html#NOTES

Thanks, applied.  We generally don't see this because pam-devel is 
installed and thus USE_PAM gets enabled instead.

> 
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>   policycoreutils/run_init/run_init.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/policycoreutils/run_init/run_init.c b/policycoreutils/run_init/run_init.c
> index 4bc32b1c..a007ce49 100644
> --- a/policycoreutils/run_init/run_init.c
> +++ b/policycoreutils/run_init/run_init.c
> @@ -159,6 +159,14 @@ int authenticate_via_pam(const struct passwd *p_passwd_line)
>   #include <shadow.h>		/* for shadow passwd functions */
>   #include <string.h>		/* for strlen(), memset() */
>   
> +/*
> + * crypt() may not be defined in unistd.h; see:
> + *   http://man7.org/linux/man-pages/man3/crypt.3.html#NOTES
> + */
> +#if !defined(_XOPEN_CRYPT) || _XOPEN_CRYPT == -1
> +#include <crypt.h>
> +#endif
> +
>   #define PASSWORD_PROMPT _("Password:")	/* prompt for getpass() */
>   
>   int authenticate_via_shadow_passwd(const struct passwd *);
> 

