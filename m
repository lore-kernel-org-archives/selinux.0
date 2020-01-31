Return-Path: <SRS0=DB+f=3U=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15616C33CB2
	for <selinux@archiver.kernel.org>; Fri, 31 Jan 2020 04:22:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA2DE205F4
	for <selinux@archiver.kernel.org>; Fri, 31 Jan 2020 04:22:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="MMSPVNs7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727949AbgAaEWX (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 30 Jan 2020 23:22:23 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:42277 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727933AbgAaEWX (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 30 Jan 2020 23:22:23 -0500
Received: by mail-ed1-f67.google.com with SMTP id e10so6317245edv.9
        for <selinux@vger.kernel.org>; Thu, 30 Jan 2020 20:22:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qzPZQaDxgL+LxPf6LoENpbGstS7DdqrEXPXkc8bd+7o=;
        b=MMSPVNs7e5tzwwhl2TRX4SSyAWui23C2J+fRGkg/dY3Q8qF5ZYvgkKoXFM6yoxxKSt
         myrp6zF2/NT6JxK4ap/LGFMbiisuCplZnoZP2qbb6YMQDhE5SlJMuLpPFgV57wxPYam9
         p+yJIWjaUI+Yc9c0TjWHej7Ofj3/v5QQ+lJUtyrKQouOl5LmuFKIDQcq/S9bLRxAe9OQ
         VWpxA+WOKJIpmmVj2EhMjC3Xzh7/d07MsmgthfTws2zK3ld91yCEmirWtDtmE7XVzFU7
         onZlqx5wgA80WlSgoiMT4ltyOAmxBu5fwRzOchQMnCI4XnJ0M909z33mgE5WC/IRGQyi
         zVIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qzPZQaDxgL+LxPf6LoENpbGstS7DdqrEXPXkc8bd+7o=;
        b=jtYqLTPKgvCBLnjv1hkcDK94OuPcdq5jkvBQTHHtRZ37/P9wftVfN4ZVAIBSOgBLV/
         eiJo1DOjNdQMtp/vcJQ1MfyAPt7WVq3AEVNgDsJEx38bWU367dCKE28ROxGtzPMm8pjy
         quEoB/ynvb6e32WDqJMke4YWb8VxD9joQp1M1Q8LmL79sQokqTz3SaTel3Q9As1ygDVL
         BHo4amwGKKm0RD+tEBA7gi+9dXV4nbOq/1N5f3IR+36+3rEwyHxZvTJYYTC5OZ2VIANb
         1rkdqZ7kqjFxwOxHkGtNIH59OFHKSEkX6QebeHYn/KrsANDB3+hdRA2ajghrIBf1l3qk
         Nucg==
X-Gm-Message-State: APjAAAXeI+53A6tiZZqIzIeb64HRxkG/vmtgxV3nGwXgIexBW9SSPs11
        15QgYbm0UsKfKo+khSQ+n3OiJ927/YxVYFfcsqbLaNRjag==
X-Google-Smtp-Source: APXvYqy4dPqaAYNldGLZKSfWWiAaahSHUapEsT5bgD72jJR4I0umRS+Dly9LsKaKOeIWRIDOcypA0AfKxckbQXjYHdk=
X-Received: by 2002:aa7:db55:: with SMTP id n21mr6690639edt.31.1580444541071;
 Thu, 30 Jan 2020 20:22:21 -0800 (PST)
MIME-Version: 1.0
References: <20200117085836.445797-1-omosnace@redhat.com> <20200117085836.445797-5-omosnace@redhat.com>
In-Reply-To: <20200117085836.445797-5-omosnace@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 30 Jan 2020 23:22:10 -0500
Message-ID: <CAHC9VhRo2JhRSJ=2XxF4u5wm1640ycQmJ5H9nLjmw-2N-V9NrQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] selinux: convert cond_expr to array
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     selinux@vger.kernel.org, Stephen Smalley <sds@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Jan 17, 2020 at 3:58 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> Since it is fixed-size after allocation and we know the size beforehand,
> using a plain old array is simpler and more efficient.
>
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> Reviewed-by: Stephen Smalley <sds@tycho.nsa.gov>
> ---
>  security/selinux/ss/conditional.c | 62 ++++++++++++-------------------
>  security/selinux/ss/conditional.h | 14 ++++---
>  2 files changed, 33 insertions(+), 43 deletions(-)

This patch looks fine, but since I think you may need to respin at
least one of the earlier patches I'm going to hold off on merging this
for now.

-- 
paul moore
www.paul-moore.com
