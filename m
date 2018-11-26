Return-Path: <SRS0=z32U=OF=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFE49C43441
	for <selinux@archiver.kernel.org>; Mon, 26 Nov 2018 23:28:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A914B208E4
	for <selinux@archiver.kernel.org>; Mon, 26 Nov 2018 23:28:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="kVcTGGjH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A914B208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=paul-moore.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727244AbeK0KYp (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 27 Nov 2018 05:24:45 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:34651 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726888AbeK0KYp (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 27 Nov 2018 05:24:45 -0500
Received: by mail-lf1-f67.google.com with SMTP id p6so14978452lfc.1
        for <selinux@vger.kernel.org>; Mon, 26 Nov 2018 15:28:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=e2S9nYqf22R6AJiB2SOXky+nRR1nvSALB5w92eIwDtk=;
        b=kVcTGGjHxUB+bGRfiBAu4cZ4/YoNKVg6C2iE2DJJ7jdr451IwaWNqNZB3gnKq64dMz
         SMbwiA+vMippmkcPpFqCbe5s6JiImY8hY18pYymGQj/Tjb+y7Bt0IpVXxWwxgVRdSnNY
         eSj3bu/oij520Gz+K+LeY7+X6zpex43b9hDI3ntSrULCDk5cxBcm78qt7McgnFHbjzzM
         9Pkuqu1VCVpTcZgr5DIuJRSqujRn+hLuzq1llkg9CPllrRM77G2iymucrsbWVfMRgGrG
         gPvOhuI1Sl0cxxc9CwzgFJVdCdCOGaXoqUu+eDLVUUcfM8Y5BV2L/OWGITNDkVutBV7k
         DaUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=e2S9nYqf22R6AJiB2SOXky+nRR1nvSALB5w92eIwDtk=;
        b=fR48TtOcgzwtK8+AMFaVLXpuTtb4U6AGflSIkl9j6K8R+c4n1ZGfN6+f5Rm6icFseb
         G05vKkVutR0FbQAlRMHgCcJEsHuY1pTqVp/9vq5WaXZ29Wu6Yibsw7vkJYelicqaMA9M
         AvQuUdGzE+Nsts0hddnNzBR9GbuERx5x7QnNOEF2L5B/AW33h0v1UrQT9Xc3CmjWS6qJ
         EpX5SXNjfAvZXFIFlFTtPzrqclObXV7+SORVBj75BiJydyP/CwQXBZaT5Ldk2ETpQ/+X
         m3UUjBGpEb8z47adgBfMBlRdylqQAmO1JY3u1Z+FkRCIA7L+7vFjG7JnKLpi8nauHr3h
         2aQA==
X-Gm-Message-State: AGRZ1gJ2gWdk2SyJgwRfSpPvN8qUzUtKdpCY6w/qrCs4OIdtQCtFFb1s
        j8E0KXZJRDZzcHBdaMpnRUDfDMu7aYC9mhKDwMBK2Ig=
X-Google-Smtp-Source: AJdET5fwUNKJuJA4qtTu+ShfvbDYJR3mu4wDvY5Md7f0PFzF032AGR8gOpfgUN5+NRcrAND4tNKpp0Snsb0DCqpFJps=
X-Received: by 2002:a19:8fce:: with SMTP id s75mr16617917lfk.151.1543274936725;
 Mon, 26 Nov 2018 15:28:56 -0800 (PST)
MIME-Version: 1.0
References: <20181124091132.GB10969@avx2>
In-Reply-To: <20181124091132.GB10969@avx2>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 26 Nov 2018 18:28:45 -0500
Message-ID: <CAHC9VhTyq4RbGZXJE2kmS+G-kKiqX7bywKbVnA8a-kAp-9YJ+g@mail.gmail.com>
Subject: Re: [PATCH] selinux: make "selinux_policycap_names[]" const char *
To:     adobriyan@gmail.com
Cc:     Stephen Smalley <sds@tycho.nsa.gov>,
        Eric Paris <eparis@parisplace.org>, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Sat, Nov 24, 2018 at 4:11 AM Alexey Dobriyan <adobriyan@gmail.com> wrote:
>
> Those strings aren't written.
>
> Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
> ---
>
>  security/selinux/include/security.h |    2 +-
>  security/selinux/ss/services.c      |    2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Merged into selinux/next, thanks.

> --- a/security/selinux/include/security.h
> +++ b/security/selinux/include/security.h
> @@ -81,7 +81,7 @@ enum {
>  };
>  #define POLICYDB_CAPABILITY_MAX (__POLICYDB_CAPABILITY_MAX - 1)
>
> -extern char *selinux_policycap_names[__POLICYDB_CAPABILITY_MAX];
> +extern const char *selinux_policycap_names[__POLICYDB_CAPABILITY_MAX];
>
>  /*
>   * type_datum properties
> --- a/security/selinux/ss/services.c
> +++ b/security/selinux/ss/services.c
> @@ -71,7 +71,7 @@
>  #include "audit.h"
>
>  /* Policy capability names */
> -char *selinux_policycap_names[__POLICYDB_CAPABILITY_MAX] = {
> +const char *selinux_policycap_names[__POLICYDB_CAPABILITY_MAX] = {
>         "network_peer_controls",
>         "open_perms",
>         "extended_socket_class",



-- 
paul moore
www.paul-moore.com
