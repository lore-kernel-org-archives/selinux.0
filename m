Return-Path: <SRS0=XbfQ=AU=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D95AC433E0
	for <selinux@archiver.kernel.org>; Thu,  9 Jul 2020 23:11:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D45E2070E
	for <selinux@archiver.kernel.org>; Thu,  9 Jul 2020 23:11:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="xxaA6/r+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726789AbgGIXLF (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 9 Jul 2020 19:11:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726222AbgGIXLF (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 9 Jul 2020 19:11:05 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D759C08C5CE
        for <selinux@vger.kernel.org>; Thu,  9 Jul 2020 16:11:05 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id d16so3107222edz.12
        for <selinux@vger.kernel.org>; Thu, 09 Jul 2020 16:11:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=skDPU/CglHgbF8B87zwr+kins9zSl+lc3iCajobsfh4=;
        b=xxaA6/r+0CIkKOO48WgpYELq7yfQEIzEh/UANE2MtODfBBm8+zzlMdr4RO9TqFywk8
         wAfe1jtNCyIkZzgXaZJafbwGk9ZvQSuCovxJU3u+BRNHx+yHZVUu9+VLl5i5WewOL5Qf
         4HHyH3MFxsJX7py5K3MMN3Ac37w7Ql9rlT6MwNkwymQaC5vhEB9Zqx0LOT61Spc1ETdb
         RQa7PVL25tRheVpEgmgnqExyn54pRYJNg8yXqp3+FYuy+/9MDjK+4e3xOjqibxcQPw/N
         nxJs4TOckv+bVCAEiCeBqZJyenT8pVIHJ8Q28xIgJ75/WF7fMZdZSSeD+Y+8tqtV79jj
         K5jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=skDPU/CglHgbF8B87zwr+kins9zSl+lc3iCajobsfh4=;
        b=Qz7RFwVCA5j9sExU56vOsGsY9dwEKWZH8Ay86MR4JJhTMDZFzhLmAqFZPTfWqQchET
         xfQ36wOCRL7Tu09XgQfmj9PtH2C1ijIVFgTP5YI5dSMMklwqHV7OHLAG/7USwqYV4mpY
         PujCjFwlOMmMwhzglup5YZIvXtkEHyZsDdlVP8jnNG+HO9jetBoTf923upRVuBly5Ljf
         PrrxolqfFhXFSTdtmi+7E+4W5oiK4bHBu9ygIYd9gNwMUoIDOu202uSZPYcV7vd1vORA
         6Fh4lCgKW4XmfDez5pP9J0TzW7Rvu2NSxkgbSgAyuFYFxEifj2UBmi3TE/AC6oj9tIqI
         CkDw==
X-Gm-Message-State: AOAM530WbokrgWhbOK+oKFwRel1+pYbQbYhNkT9+luEM5xIj8fku/wT/
        TATYmlkshhvDJvrb2wyxckbZUyj21+GnzEUg5QIS
X-Google-Smtp-Source: ABdhPJxQfriPU+lnq+P0naYkBqT57Nt4ST3prdXDmzbUKrU+S131896+jA8myYT6IA2L9EyfWw36ZNsaIlmbXCnnIs0=
X-Received: by 2002:aa7:c883:: with SMTP id p3mr76610437eds.128.1594336263858;
 Thu, 09 Jul 2020 16:11:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200709191952.435970-1-omosnace@redhat.com> <20200709191952.435970-3-omosnace@redhat.com>
In-Reply-To: <20200709191952.435970-3-omosnace@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 9 Jul 2020 19:10:53 -0400
Message-ID: <CAHC9VhR7vpJ7Q0JB0=jGGxxiBOV9Dx8YGWHtSkdLhzAedxx_=Q@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] selinux: complete the inlining of hashtab functions
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     selinux@vger.kernel.org,
        Stephen Smalley <stephen.smalley.work@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Jul 9, 2020 at 3:20 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> Move (most of) the definitions of hashtab_search() and hashtab_insert()
> to the header file. In combination with the previous patch, this avoids
> calling the callbacks indirectly by function pointers and allows for
> better optimization, leading to a drastic performance improvement of
> these operations.
>
> With this patch, I measured a speed up in the following areas (measured
> on x86_64 F32 VM with 4 CPUs):
>   1. Policy load (`load_policy`) - takes ~150 ms instead of ~230 ms.
>   2. `chcon -R unconfined_u:object_r:user_tmp_t:s0:c381,c519 /tmp/linux-src`
>      where /tmp/linux-src is an extracted linux-5.7 source tarball -
>      takes ~522 ms instead of ~576 ms. This is because of many
>      symtab_search() calls in string_to_context_struct() when there are
>      many categories specified in the context.
>   3. `stress-ng --msg 1 --msg-ops 10000000` - takes 12.41 s instead of
>      13.95 s (consumes 18.6 s of kernel CPU time instead of 21.6 s).
>      This is thanks to security_transition_sid() being ~43% faster after
>      this patch.
>
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---
>  security/selinux/ss/hashtab.c | 59 +++-----------------------------
>  security/selinux/ss/hashtab.h | 63 ++++++++++++++++++++++++++++++++---
>  2 files changed, 63 insertions(+), 59 deletions(-)

Patches 1/2 and 2/2 merged into selinux/next.

-- 
paul moore
www.paul-moore.com
