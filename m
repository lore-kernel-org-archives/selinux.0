Return-Path: <SRS0=DB+f=3U=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA223C33CB2
	for <selinux@archiver.kernel.org>; Fri, 31 Jan 2020 03:38:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A68F020CC7
	for <selinux@archiver.kernel.org>; Fri, 31 Jan 2020 03:38:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="MbL6yoh4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727933AbgAaDi4 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 30 Jan 2020 22:38:56 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:42155 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727824AbgAaDi4 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 30 Jan 2020 22:38:56 -0500
Received: by mail-ed1-f65.google.com with SMTP id e10so6234914edv.9
        for <selinux@vger.kernel.org>; Thu, 30 Jan 2020 19:38:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pUrlL7l1gw7olkkFSXMZx1B7KFbLjtcMb9i3zs3Exqs=;
        b=MbL6yoh4/n53yCC/0icoIzzXAlIvK57cq5cqScDRQilEPs6GyE6zcWdNFuDZ4rJpsq
         /umgx33Nho5lMy6MMN02aFwM5wTbdG5RD6h8NisaZOvZMUN38+wSLovQC39vNcHVGqyp
         sG29MFGxQnBRDRR/asNxIE9BSg8oMLKduojOlxcezt+4gWCRvQ2xnvAmT6k7JCrDJU8U
         N321YC6qeegiScKdEs2M9BMKVdzVntdXoU8dXBBRlE2B0E7M5Kv1Hj/UnxRjnaKS4k4q
         D1D2Mdqop67Q6SsAkfMoCjVeJGs5a3WkD0N14rdre8NzNHn8rSqohZn6vfiH57l25z/j
         WvhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pUrlL7l1gw7olkkFSXMZx1B7KFbLjtcMb9i3zs3Exqs=;
        b=F+gow/QUL3EdWfwDX7YrOw9+1caDyRNUSQXjgUhNqdwn70DtmJIzNoat6S4k9qJc/Z
         koQBcJiPs26uSJexNYYnFMFVa14wGqggR5P/9izQriIyjd5oGFjdf3FZRkPD4XfYHxRi
         VOtJkSPmdnb4bwonAQjAq0FXPDbVkoeL/iJND0pavFl57Gv+WO2mGNSRnB4YfmsZShdL
         0NGBrfoMMQ1G5IyvWYRs8vZlu8DmibruMloIGjnsYNDL0r/VfgNUZB8ilvbA+7xx+HR8
         eV1RAwLQxDOHZ/UY8n1sJxcM2shKNHWH7cUMYmRYjkEQsSVFiKmLLO+Qi1/IU6wXXDFO
         Ru/Q==
X-Gm-Message-State: APjAAAXT418zAGeX9I0UP9yMw4EjJcTj1Ui/Bkz4fgwQCD7JyTQhgaoX
        F6axz8FRKkpU/AA3rJKcq3Z+k1WVbBvLsAxnX9GpviuRnw==
X-Google-Smtp-Source: APXvYqwzBvBWUq3p9CTsdeLKMpUJ9JVgrTZXKjNoITRzyLIL34+Xz7YDzT0McAmkxvGHLK+draIElaJbWkCjThLzEQI=
X-Received: by 2002:a50:ec1a:: with SMTP id g26mr6619210edr.164.1580441932798;
 Thu, 30 Jan 2020 19:38:52 -0800 (PST)
MIME-Version: 1.0
References: <20200117131514.496122-1-omosnace@redhat.com>
In-Reply-To: <20200117131514.496122-1-omosnace@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 30 Jan 2020 22:38:42 -0500
Message-ID: <CAHC9VhTZm08YCg3TOjpN20WeRQ9Fmbg=KMfvKnmD18KjGArv4Q@mail.gmail.com>
Subject: Re: [PATCH] selinux: move status variables out of selinux_ss
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     selinux@vger.kernel.org, Stephen Smalley <sds@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Jan 17, 2020 at 8:15 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> It fits more naturally in selinux_state, since it reflects also global
> state (the enforcing and policyload fields).
>
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>  security/selinux/Makefile           |  4 ++--
>  security/selinux/hooks.c            |  1 +
>  security/selinux/include/security.h |  4 ++++
>  security/selinux/ss/services.c      |  2 --
>  security/selinux/ss/services.h      |  2 --
>  security/selinux/{ss => }/status.c  | 32 ++++++++++++++---------------
>  6 files changed, 23 insertions(+), 22 deletions(-)
>  rename security/selinux/{ss => }/status.c (81%)

Makes sense to me too.  I've queued this up in selinux/next, you'll
see it in the tree once the merge window closes.

-- 
paul moore
www.paul-moore.com
