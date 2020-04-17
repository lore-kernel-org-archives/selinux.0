Return-Path: <SRS0=6dkg=6B=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7947C2D0EF
	for <selinux@archiver.kernel.org>; Fri, 17 Apr 2020 20:09:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9FDA2221EC
	for <selinux@archiver.kernel.org>; Fri, 17 Apr 2020 20:09:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="cnt0WJZV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730705AbgDQUJN (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 17 Apr 2020 16:09:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730573AbgDQUJM (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 17 Apr 2020 16:09:12 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EE16C061A0C
        for <selinux@vger.kernel.org>; Fri, 17 Apr 2020 13:09:12 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id s3so2483763eji.6
        for <selinux@vger.kernel.org>; Fri, 17 Apr 2020 13:09:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zoZznSpCyUvc8fgJPyCTVlVm7SRAQUYsp6K8PnU/nEY=;
        b=cnt0WJZVimgp6olkgVT4++ILU7b9NHi+lMM+r/05hsQofhqtuELyko7BgZjdlPSc62
         vybLKJagJtcnkjMGRIUfFLmk16djyLSjy720w3yK700YnyeoWKC2Guj7j9gNhMNbKLg2
         5Fn9US0TBvKb7hsxyOBhFWMibOlGvBYyYWTc7CrT95IFSuSWZzg80TqvJGu9JocBZ0x9
         RD3GEODLO0mVsdz2vm8A/H/lSKtKIEq7WWsyicy63oaeiu7TPAub05ZzSli2ZGySg9Wn
         HDmXO3fYWwNErqgzmpRemwEmA9qEJNrK8VrK4qE987HaWkbWD+78ztzvrJ2/cXtbTwV6
         McOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zoZznSpCyUvc8fgJPyCTVlVm7SRAQUYsp6K8PnU/nEY=;
        b=kkFcwJ8m95d3D9mXqNiHd+jWBHEe2XfW2iFWhFAg2/80FUR15tcw5pI3kd7w3NU64w
         I69nKNANHHdX3cCyxVl4V7Q1XDFQf527lzvOW1zbLhhEHW3ngQ6TVwZNlrESUnnT0FeK
         3kXYG8v+hn3EDObU17+knOJOSFb22kLQh1DZBI6/fvSbRE5EXa7cOPYsDPpZl3kTdbAV
         t1Vqbl/VuJpHcMJfAPSe/P0y/bfLpDORlk0KQFFe7xil14cfWM54xvXDWMOlHBNklOpM
         PCWkfuUTTccnhyWJsGNV9/nZDQQL37KXWKLSMrCxbTBDyQE3wbRznLwmAzr7gvBUk/sQ
         4ATQ==
X-Gm-Message-State: AGi0PuZqnSTyVD2wj7tEjwc64M1yn3R33MV2sMa46xtwiB/q0Ruv7D/w
        CH64GA1m1OSc5C4zPcZkXB6eqUiht69pxEfGGPvu
X-Google-Smtp-Source: APiQypIvCkbC92vm+Y1OMRFFaTDYlCRNde9HDIwSf6twMvsX+Syy65R/Ifmjh0QBQfiqMFPwsJk0AIjbRweb4FG/1rU=
X-Received: by 2002:a17:906:f288:: with SMTP id gu8mr4844452ejb.281.1587154151093;
 Fri, 17 Apr 2020 13:09:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200417081157.606789-1-omosnace@redhat.com> <20200417081157.606789-3-omosnace@redhat.com>
In-Reply-To: <20200417081157.606789-3-omosnace@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 17 Apr 2020 16:09:00 -0400
Message-ID: <CAHC9VhSdemWxLYPnpMZXb531GsxBNQQc_W774XwKjCu94rEWig@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] selinux: move context hashing under sidtab
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     selinux@vger.kernel.org, Stephen Smalley <sds@tycho.nsa.gov>,
        Jeff Vander Stoep <jeffv@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Apr 17, 2020 at 4:12 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> Now that context hash computation no longer depends on policydb, we can
> simplify things by moving the context hashing completely under sidtab.
> The hash is still cached in sidtab entries, but not for the in-flight
> context structures.
>
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>  security/selinux/ss/context.h  | 11 +------
>  security/selinux/ss/policydb.c |  2 --
>  security/selinux/ss/services.c | 59 +++++++++++++++-------------------
>  security/selinux/ss/sidtab.c   | 32 ++++++++++--------
>  security/selinux/ss/sidtab.h   |  1 +
>  5 files changed, 47 insertions(+), 58 deletions(-)

Merged into selinux/next, thanks.

-- 
paul moore
www.paul-moore.com
