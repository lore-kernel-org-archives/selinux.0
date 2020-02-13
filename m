Return-Path: <SRS0=XRjJ=4B=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90B30C352A3
	for <selinux@archiver.kernel.org>; Thu, 13 Feb 2020 23:10:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53AD02082F
	for <selinux@archiver.kernel.org>; Thu, 13 Feb 2020 23:10:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="CdA1vqDF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727347AbgBMXKt (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 13 Feb 2020 18:10:49 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:33112 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726780AbgBMXKs (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 13 Feb 2020 18:10:48 -0500
Received: by mail-ed1-f65.google.com with SMTP id r21so8945169edq.0
        for <selinux@vger.kernel.org>; Thu, 13 Feb 2020 15:10:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kE8AaL01y2JjmOwnox1j868y+DHxpIZOxazWqzK9LH0=;
        b=CdA1vqDF89g5uEN9QfDyGsEmw4Exog880McANoZIPL8TR6qdSzN04eMmk2iDRRgQkT
         JTwFVuIAJeFAgx8epFMeqMEm2RZcfoFg/Lj1STyr3NLILgmjCA8BC2qBJtOk+pQknrjd
         3SpAttWMB+P8PR+JwXzr5IsCxKEg9HToS/bFxhaVknlKKOmhjiEZv2UZxa9YBg2EtabU
         HIbBEsUd9gdin5xGSnL+jpRRlYSICdzry4+D1LkOAeKdgFkG+Au4vvVlgPrTtUYmp9wi
         KkZLcgBVExKrcQw+RKegYVFwhIbC3ha5s+9w8Ih5GKmKtfcQMHCK5DzGAK4+BL7VpzVh
         U8wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kE8AaL01y2JjmOwnox1j868y+DHxpIZOxazWqzK9LH0=;
        b=rAqF7Z+RNcG10OCbfTDmRV5Ra3FEc0IOsH6IeJCRs7qhF79+ZrS5bY06soXBenPf36
         SyqhzyOZF1+bC6eOPGiG2VbFLyKl0qL4uNVpyOV0xfEEXVAaXWNvkWNmBmCRoqpwJi5q
         WGSV794PZSg53Narpr1Xc7Kbe8KBqez716UcQEGtCAMxOYD+LDdZ6+JHJlX05MU5k7Rp
         a1ClDO7G3HxkrpTUAfe/Xo3NTktiDmEomzZIYhZ7U8vKSwIF3Ms/Cz3cqCrXvju4xQMS
         kDt0Tk8XT4hUuquwobupIkEzJggO5lbKB0DpEL8kNyCD7oNGCkiLfpgFah2sfyJcMXzO
         9fkQ==
X-Gm-Message-State: APjAAAUQEA2XV9zvH7DqMIpFRls6Z/bYqS2lO0t5hOgBWkaeYqEdXxjI
        07E43UoWTPWRVSZ0oAyh+WrT71ImiPUZl1/kFsJq
X-Google-Smtp-Source: APXvYqx+urRKXMxivsZpQdi6Yx8U6Ac/YV40v1OhiIUIABtcUyf+n20tKLeOsJA52PLRd/PyZ24OpCmDrYe549FfHN4=
X-Received: by 2002:aa7:cd49:: with SMTP id v9mr28962edw.269.1581635446356;
 Thu, 13 Feb 2020 15:10:46 -0800 (PST)
MIME-Version: 1.0
References: <20200212112255.105678-1-omosnace@redhat.com> <20200212112255.105678-2-omosnace@redhat.com>
In-Reply-To: <20200212112255.105678-2-omosnace@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 13 Feb 2020 18:10:35 -0500
Message-ID: <CAHC9VhRH-DiScv_D7qowKvC=BneLEbQahoR_ctQuHQSYrHgNqQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] selinux: factor out loop body from filename_trans_read()
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     selinux@vger.kernel.org, Stephen Smalley <sds@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Feb 12, 2020 at 6:23 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> It simplifies cleanup in the error path. This will be extra useful in
> later patch.
>
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>  security/selinux/ss/policydb.c | 122 +++++++++++++++++----------------
>  1 file changed, 63 insertions(+), 59 deletions(-)

Merged into selinux/next.

-- 
paul moore
www.paul-moore.com
