Return-Path: <SRS0=RPjD=AF=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45C29C433DF
	for <selinux@archiver.kernel.org>; Wed, 24 Jun 2020 00:52:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E4A220CC7
	for <selinux@archiver.kernel.org>; Wed, 24 Jun 2020 00:52:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="xSGH4qdn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388159AbgFXAwx (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 23 Jun 2020 20:52:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388103AbgFXAwx (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 23 Jun 2020 20:52:53 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8349C061573
        for <selinux@vger.kernel.org>; Tue, 23 Jun 2020 17:52:51 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id cy7so202151edb.5
        for <selinux@vger.kernel.org>; Tue, 23 Jun 2020 17:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xv5wkwilzKVVaWqxZixcp7w+W5IpwDMbvBD64/wGQnA=;
        b=xSGH4qdnY9Ww9YZC4+4Xo/tRjZ1OI+8LvVjWw79fXTw3+/itzBNkxt7x0dO2CHNjHv
         xy2n8jqVkeY7jU2xOf/CHhtCFTlqyrSBtJy7DiGHAXQQ/x+K+Oi1C6LB43bckEqY5V1I
         CCGmZwwqdEoivcG+wo3lyqJDzLD2QIzB6bj/lfz+dMY9G0dS2QD4Em18NrrsowA5w+az
         X0v7zpWYGGvPxJXNyw7z56qOOy0YA6C7t/slpmJr/qVtHWA8jXRxE0X+UXPuse6a8D8J
         UMPS84pgg7whAUyiQpqBBQkOE6SOfHVWdmeHBg+/Pckd4dcIY/dysdjXUFksNEpwD+8C
         fz0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xv5wkwilzKVVaWqxZixcp7w+W5IpwDMbvBD64/wGQnA=;
        b=LUPabK9ljI1iy8RJnvCjOxIwvHas9iaXTzSgCjXEsOMrESobhjnOkgHl5ndZRYnE+b
         Nwq+TxR4hoksYEwOHO/iyGApQb94DlkTy9cqDscEKG5fe+fn9mDE3m0yx+kgJHBdmINO
         DZoePcYb7G45DiRUeyXrEQGzMxEYjNvEluKQHC0m6+1VvM0eEzA127yZ2DYkUd1Lb/ln
         G5dBmWvCZgCWxoDDYdwXgo8R7tKAHnF1YacueIyCeiRocGli3/1INR+38/Pd+vrxXvKw
         6EwxjgllNVZ+WxDepx4WHeDADfAP7YpDmQam5rQMXLLtmuEH9DOYcEJrvM/XTHEGB0zh
         HNaw==
X-Gm-Message-State: AOAM530wL0QJfAIpV6rk3YTZVBGuO2CRZwc0B6QeNJ6z1GO7YEXzzFFA
        pWYu11iAWZcr3ximrjfI6eR3IXoQYAmKL+Gadzvfaew=
X-Google-Smtp-Source: ABdhPJz9JcDOTgiz5NZbLdEcjzFkmGnJ0uMTRwgx9iJsEmYXGuR2nHsXWS27iwtFAvQ8Ud4n7jhp3iBD67HHzbcoRgg=
X-Received: by 2002:a50:a881:: with SMTP id k1mr23977113edc.12.1592959970615;
 Tue, 23 Jun 2020 17:52:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200617192216.69444-1-stephen.smalley.work@gmail.com>
In-Reply-To: <20200617192216.69444-1-stephen.smalley.work@gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 23 Jun 2020 20:52:39 -0400
Message-ID: <CAHC9VhQh0XBPaa2KW3U_v80SCe6h2ZFDCmQUxxPF+pWUaMQ0pA@mail.gmail.com>
Subject: Re: [PATCH] scripts/selinux/mdp: fix initial SID handling
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     selinux@vger.kernel.org, Ondrej Mosnacek <omosnace@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Jun 17, 2020 at 3:22 PM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> commit e3e0b582c321 ("selinux: remove unused initial SIDs and improve
> handling") broke scripts/selinux/mdp since the unused initial SID names
> were removed and the corresponding generation of policy initial SID
> definitions by mdp was not updated accordingly.  Fix it.  With latest
> upstream checkpolicy it is no longer necessary to include the SID context
> definitions for the unused initial SIDs but retain them for compatibility
> with older checkpolicy.
>
> Fixes: e3e0b582c321 ("selinux: remove unused initial SIDs and improve handling")
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---
>  scripts/selinux/mdp/mdp.c | 23 ++++++++++++++++++-----
>  1 file changed, 18 insertions(+), 5 deletions(-)

Merged into selinux/next, thanks Stephen.

-- 
paul moore
www.paul-moore.com
