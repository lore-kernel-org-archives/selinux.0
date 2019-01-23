Return-Path: <SRS0=b/dN=P7=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5674FC282C5
	for <selinux@archiver.kernel.org>; Wed, 23 Jan 2019 14:16:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1910720870
	for <selinux@archiver.kernel.org>; Wed, 23 Jan 2019 14:16:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="Z3mj7vhG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726359AbfAWOQm (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 23 Jan 2019 09:16:42 -0500
Received: from uhil19pa13.eemsg.mail.mil ([214.24.21.86]:3887 "EHLO
        uhil19pa13.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727322AbfAWOQl (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 23 Jan 2019 09:16:41 -0500
X-EEMSG-check-017: 364514078|UHIL19PA13_EEMSG_MP11.csd.disa.mil
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by uhil19pa13.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 23 Jan 2019 14:16:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1548252999; x=1579788999;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=5Znb61IqnPGfsGI5sIjR80O0ixItWeTYHl2T6zvBUdM=;
  b=Z3mj7vhG4dSFhcRYOajEby5h69Mxyzzn4gjwhHVGWX5k7BqwOxN95ucT
   xz51/Dks4oZ2TkFOj987NBmE5WwX+v8ZBrPALrJ15CW/MS664jfbPXB6W
   WKkbeCj9GpYaoZPwhu8bWBP4z7IQidTRX3/qPEbXruqrURpfxonSkFLGH
   ajmfC41NrNBpH2sl5B7v8jJHlrNqiGCS9ybJhSDqXmLCvWMjGosOQln2W
   0bTtBYfj2ffBCvb/cuZ6IaLtO7rYtHXNkI1N/Tal3VSHCPegfqW5zG9Tf
   Er0A/xr56nwhBCaR7BiCfU5CFM41NE1PMozIhuN5DHUFCFxwUP2+d6LOY
   A==;
X-IronPort-AV: E=Sophos;i="5.56,511,1539648000"; 
   d="scan'208";a="22974528"
IronPort-PHdr: =?us-ascii?q?9a23=3ApngHhxU2xFjChwcM/htSvuaBUkbV8LGtZVwlr6?=
 =?us-ascii?q?E/grcLSJyIuqrYbRWDt8tkgFKBZ4jH8fUM07OQ7/iwHzRYqb+681k6OKRWUB?=
 =?us-ascii?q?EEjchE1ycBO+WiTXPBEfjxciYhF95DXlI2t1uyMExSBdqsLwaK+i764jEdAA?=
 =?us-ascii?q?jwOhRoLerpBIHSk9631+ev8JHPfglEnjWwba9xIRmssQndqtQdjJd/JKo21h?=
 =?us-ascii?q?bHuGZDdf5MxWNvK1KTnhL86dm18ZV+7SleuO8v+tBZX6nicKs2UbJXDDI9M2?=
 =?us-ascii?q?Ao/8LrrgXMTRGO5nQHTGoblAdDDhXf4xH7WpfxtTb6tvZ41SKHM8D6Uaw4VD?=
 =?us-ascii?q?K/5KpwVhTmlDkIOCI48GHPi8x/kqRboA66pxdix4LYeZyZOOZicq/Ye94VS3?=
 =?us-ascii?q?BBXsJMXCJfBI2yYZYEA+4YMepFs4Xxol0Dpga8CwaxHuPi0iJGiGH43aM60O?=
 =?us-ascii?q?ovHw/J0wMiEN0Sv3rZt8n1OaUIXOyp0KXFwzfOYvVL0jn98ojIdRUhrOmRU7?=
 =?us-ascii?q?Jsb8XR0UkvGB3Djl6NtILlOima1uAJs2eF7+trSOWii3U6pAFquTWv2scthZ?=
 =?us-ascii?q?XJhoIS0FzE8z55z5wvKd23T057f8epHZ1NvC+UMIt2R9ktQ2BuuCsi0L0Jp4?=
 =?us-ascii?q?O0fCgQx5Q73RLQd/uHc42O7xn+V+iROS91iG9qdb+wnRq/8VWsxvfiWsS7zl?=
 =?us-ascii?q?pGtDdJn9/RvX4XzRPT8NKISv5l80ek3jaAyh7c5/lfIUAxiarbM5khwqMslp?=
 =?us-ascii?q?YLsUTMACv2mELuga+KbEok4Omo6/n8Yrn8up+dN5N7igH5Mqg0nMywHf84PR?=
 =?us-ascii?q?QUU2ie+OS80KXv/Uz/QLpUkv07irTVvZ/VKMgBpqO1HhVZ3pgs5hqhFTuqzc?=
 =?us-ascii?q?wUnXwdI1JEfBKHgZLpO1bLIP3gFvewnk+snSx3x/HGIrLhApLNImLFkLf6Z7?=
 =?us-ascii?q?lx8UFcyA0tzdxH/ZJbFqkBIO7vWk/2rNHYFhs5PBapw+b7EtVyzZkRVHmVAq?=
 =?us-ascii?q?CHLazSsUWH5v41L+aQY48VvS73K+I56P72kX85hVgdcLGy3ZQJbHC4H/JmI1?=
 =?us-ascii?q?iWYHf3nNcBHnkFvhAkQOzpllKCSzhTaGi2X64m4TE7Eo2mXs//QdWVjaCblA?=
 =?us-ascii?q?OyA4FMbGlNChjYCXPhapmeUf4kci+eIsZ91DcDUO7lA5Qs0RCoqR/S1bVqNK?=
 =?us-ascii?q?zX9zceuJal08J6tMPJkhRnziB5F8SQ1Sm2Smhwmm4ZD2st0LtXvV12ylDF17?=
 =?us-ascii?q?NxxfNfC4oAtLtyTg4mOMuEnKRBANfoV1eEJ47RRQ=3D=3D?=
X-IPAS-Result: =?us-ascii?q?A2AkAACHdkhc/wHyM5BjGwEBAQEDAQEBBwMBAQGBUwQBA?=
 =?us-ascii?q?QELAYFaKWZPMyeEAZQKTAEBAQEBAQaBCC2JNI5PgXswCAGEQAKCfCI2Bw0BA?=
 =?us-ascii?q?wEBAQEBAQIBbBwMgjopAYJnAQUjFVELDgoCAiYCAlcGAQwGAgEBgl8/AYF0D?=
 =?us-ascii?q?Q+sHYEvhUOEZwWBC4s2F3iBB4ERJ4I9LoMeBBiBEINAgjUiAolThwI5kRgJh?=
 =?us-ascii?q?yaKdAYYkhiKB4UhjVMDLoFWKwgCGAghD4MnhgmKcSEDMAGBBAEBh0iCTQEB?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 23 Jan 2019 14:16:38 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto.infosec.tycho.ncsc.mil [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x0NEGcDF005606;
        Wed, 23 Jan 2019 09:16:38 -0500
Subject: Re: [PATCH] restorecond: Install DBUS service file with 644
 permissions
To:     Petr Lautrbach <plautrba@redhat.com>, selinux@vger.kernel.org
References: <20190122114724.1766-1-plautrba@redhat.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <cf455f73-f954-12c4-d1ee-19ce4e6a5499@tycho.nsa.gov>
Date:   Wed, 23 Jan 2019 09:19:37 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190122114724.1766-1-plautrba@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 1/22/19 6:47 AM, Petr Lautrbach wrote:
> The original 600 permissions make the service file unreadable for dbus daemon.
> 
> Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=1626462
> 
> Signed-off-by: Petr Lautrbach <plautrba@redhat.com>

Acked-by: Stephen Smalley <sds@tycho.nsa.gov>

> ---
>   restorecond/Makefile | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/restorecond/Makefile b/restorecond/Makefile
> index 8a0ada1f..6155ca4a 100644
> --- a/restorecond/Makefile
> +++ b/restorecond/Makefile
> @@ -50,7 +50,7 @@ install: all
>   	-mkdir -p $(DESTDIR)$(AUTOSTARTDIR)
>   	install -m 644 restorecond.desktop $(DESTDIR)$(AUTOSTARTDIR)/restorecond.desktop
>   	-mkdir -p $(DESTDIR)$(DBUSSERVICEDIR)
> -	install -m 600 org.selinux.Restorecond.service  $(DESTDIR)$(DBUSSERVICEDIR)/org.selinux.Restorecond.service
> +	install -m 644 org.selinux.Restorecond.service  $(DESTDIR)$(DBUSSERVICEDIR)/org.selinux.Restorecond.service
>   	-mkdir -p $(DESTDIR)$(SYSTEMDDIR)/system
>   	install -m 644 restorecond.service $(DESTDIR)$(SYSTEMDDIR)/system/
>   relabel: install
> 

