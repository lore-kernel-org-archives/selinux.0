Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ADA1C433E6
	for <selinux@archiver.kernel.org>; Tue, 12 Jan 2021 15:10:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BBE6F2310A
	for <selinux@archiver.kernel.org>; Tue, 12 Jan 2021 15:10:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732490AbhALPKx (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 12 Jan 2021 10:10:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726862AbhALPKx (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 12 Jan 2021 10:10:53 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6F66C061575
        for <selinux@vger.kernel.org>; Tue, 12 Jan 2021 07:10:12 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id d17so3969437ejy.9
        for <selinux@vger.kernel.org>; Tue, 12 Jan 2021 07:10:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=F8aYSMy96X+gIGLdeEKhbFD32Fx86Tb9TIO4gK0g/TQ=;
        b=HTEaBZRcYwgw8HzGXbJODEPuwj2Umq2QaExLcsLstr+R8Eiedz9ZZYAfrqK6kiMzKR
         TIhqqdEWfBEBJwDR7C3Y7BQ3jjwjiZZEznvD7/hv7vBnKQxeuDMZANY3b+GO+JREDy13
         c4xhbUL4SU7z9akBC2LDDEcfC+V6ZAkxG9vmaWc3k86Bklfc8S1lQ7lxmXaVKOqbTKkU
         RO/WE5NboJg42LLooVqfyNcVd2rq0OQbZUpy89lFxpx5/9StqWSECqqTYqLHiiAGBZI1
         pO7vkNxH+CIpavjPOl9tdfEZqacv8225tp7VtXJQoIf+b3SGwX5jzcABAL5dvearKtCF
         9A5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=F8aYSMy96X+gIGLdeEKhbFD32Fx86Tb9TIO4gK0g/TQ=;
        b=m/o4no6dnG+7luePiVXOiAkD+SGSNy7CFqmVtGuFl5vFBl9QqDRsk0ifTd5f7hBgCw
         shNIflvkPViVyjzls2ubLRdwaNUGlKn5BwC0qd8bZMmAo9CoKzCGnifbYaqHWj7D7+El
         gfJOL3kNAKA8BFTYtYM+WR/A95J9YVoFnA4/uRDrvy61vcy1VSgOBEQ+yDKofAnxVUBz
         pVt4KbS5j4x10Qhv1CCjARzve++q295vDGhdx/dmAYo0TRtzk59urKqOmw4nqcfzcHjw
         qFHByyJP1c8OJFgLYctK/owOgtkJ3JXDvp4RXlSJL7dDP7eG3iMW5PEwUmuHX1OHLaZb
         g36A==
X-Gm-Message-State: AOAM533pwqUtZGSI6qZILc1GFLO/1E6Tepu4iZHpoqkTFm+6aCzu+1hO
        dyNCSfcXtDoTej4GVvE4K6YrUHagxXkB7LoAls09
X-Google-Smtp-Source: ABdhPJwSZ9d/tbTqw/zQy6tSr5j7tbCUk+HP+M3Fu19BWcRZgnEscK2NhBZsrzimwy6NbN8gpyRkjR1U372GhHbZut0=
X-Received: by 2002:a17:906:aec6:: with SMTP id me6mr3543822ejb.542.1610464211462;
 Tue, 12 Jan 2021 07:10:11 -0800 (PST)
MIME-Version: 1.0
References: <20210106132622.1122033-1-omosnace@redhat.com> <20210106132622.1122033-4-omosnace@redhat.com>
In-Reply-To: <20210106132622.1122033-4-omosnace@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 12 Jan 2021 10:10:00 -0500
Message-ID: <CAHC9VhQbUjwHR+CAnD3=Ev-Ru1kFCdH51JLm+5c5rvzpQnmL3w@mail.gmail.com>
Subject: Re: [PATCH 3/5] selinux: make selinuxfs_mount static
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     selinux@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Jan 6, 2021 at 8:26 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> It is not referenced outside selinuxfs.c, so remove its extern header
> declaration and make it static.
>
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>  security/selinux/include/security.h | 1 -
>  security/selinux/selinuxfs.c        | 2 +-
>  2 files changed, 1 insertion(+), 2 deletions(-)

Merged into selinux/next, thanks.

-- 
paul moore
www.paul-moore.com
