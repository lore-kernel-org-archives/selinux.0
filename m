Return-Path: <SRS0=RO9B=6P=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1EE5C47253
	for <selinux@archiver.kernel.org>; Fri,  1 May 2020 19:20:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 854772166E
	for <selinux@archiver.kernel.org>; Fri,  1 May 2020 19:20:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="qKZidYXN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbgEATUZ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 1 May 2020 15:20:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726045AbgEATUY (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 1 May 2020 15:20:24 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DAA0C061A0C
        for <selinux@vger.kernel.org>; Fri,  1 May 2020 12:20:23 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id k8so8318258ejv.3
        for <selinux@vger.kernel.org>; Fri, 01 May 2020 12:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Pt5Ozvmf53UZLojBGCWU1ltzq46EyU/Z/pBdusPfwHI=;
        b=qKZidYXNWcqcANOf4MMH46I0ctf77GfWBqg4a9Gm5Bop5wtYUWFDzEgYSrv0oVbCU0
         qoQgWM+IaZHp784pDenWDuNqvDBIn3gOJ+nI/hEMZLfAXM0AO8QPrLOX7RbhLxtsh/il
         XFHqUc3qR1T01IlDYVhTknUATbIrMCRU29vZnEppE2lEMUEdxPWJbi7+klrP75yV5F5O
         lxDXHvFc7EeqQ8YE1Cj+swqCWbzIaeXu+WEX6EC+j18yTvmGzT83nwE99oZkKaZzkx9C
         BML3ctyIKmgHp9bAXMD6Ij5cKMqHe2KhsYDm0ke8BYXZvqWww0o1rP9dOW2eb9TjNHgf
         l5DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Pt5Ozvmf53UZLojBGCWU1ltzq46EyU/Z/pBdusPfwHI=;
        b=PP1WTlw0UO55piyevb85z+shJE7R+dpKmxztEfKhcZbgyCrNynILw9iN3TjvjiVsuk
         SjMfFk/O5s7gm4UReXhSaOf65uloU84MVy1cauaqEwB1y83WP4ox966ElbH4cZZgtCi/
         9K0XCBV/rN8g7RlJLcP6ByA6srBxIy3Q5R2hyeD0a0w9zussZVmbcoMJ46WzpJT/nFBx
         92HOn7K1q570QaB/H6j2+/4Bm+5FqGW91c4DRAEmQnYM2FZdOF5HU7WeMxdacxEdp12Q
         9aS8INmdSOb+vqjVuvCse/iAz+QVdZ+o2M6xGOHygdkaEsQke7HDqR8jE0LiFY9akNTl
         /gXw==
X-Gm-Message-State: AGi0PuYfc1LqkyV/9+9A4OMY2xcuKnFLAU1D5OcDqgCARabyNFhGLizO
        rFXd1jYebg/qIO1VIWC0OTBCYFGccXsAc+VbCOrT
X-Google-Smtp-Source: APiQypLJ7swifGyyBP3xSVd10tQJrF3ginEFqugAK5NLWJoZYOvW+PAblYn6TiX2kXx01azBBN28lsaoLPTC5HBzqeg=
X-Received: by 2002:a17:906:35d0:: with SMTP id p16mr4560420ejb.77.1588360821721;
 Fri, 01 May 2020 12:20:21 -0700 (PDT)
MIME-Version: 1.0
References: <20200428125514.2780171-1-omosnace@redhat.com> <20200428125514.2780171-2-omosnace@redhat.com>
In-Reply-To: <20200428125514.2780171-2-omosnace@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 1 May 2020 15:20:10 -0400
Message-ID: <CAHC9VhSdyhG4D2VtOa8nPR+XSqRwpLxSpkyJ8DYXhSejqdz2Ag@mail.gmail.com>
Subject: Re: [PATCH 1/4] selinux: simplify range_write()
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     selinux@vger.kernel.org,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Stephen Smalley <sds@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Apr 28, 2020 at 8:55 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> No need to traverse the hashtab to count its elements, hashtab already
> tracks it for us.
>
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>  security/selinux/ss/policydb.c | 18 ++----------------
>  1 file changed, 2 insertions(+), 16 deletions(-)

Merged into selinux/next, thanks.

-- 
paul moore
www.paul-moore.com
