Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BC00C433DB
	for <selinux@archiver.kernel.org>; Fri, 19 Mar 2021 03:34:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D33D764DEF
	for <selinux@archiver.kernel.org>; Fri, 19 Mar 2021 03:34:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231599AbhCSDd2 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 18 Mar 2021 23:33:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbhCSDdX (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 18 Mar 2021 23:33:23 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80E6DC06174A
        for <selinux@vger.kernel.org>; Thu, 18 Mar 2021 20:33:23 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id r12so7353066ejr.5
        for <selinux@vger.kernel.org>; Thu, 18 Mar 2021 20:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BjdiZRflOIy24Sc8tHlV56lqnBBBbp9z1FlL9PYymfk=;
        b=iGlyxgq6iw4iH0Nzpu6E5aYPlfcf8Rp7F0daguE4/sahNPg30ANUjG8YsQfXxV8Ab7
         /5SseMqr7gomam+HBxM2gSslk9+Y35fVHdiIcLzoD+9nOiIwleRuoL2Rc0ztJULotbhU
         OnKhJSXXU+FMJkTP0/uIvF80u2cpruLImzjqyYit3YSb6fH0yG+11vXTqTBTtmfBtzc4
         HpZAlHEa7FqGis99On4BmgwFhONneXrT+P/eqABQshstXBeWyX+7Fc+WbCwEikUAjqNd
         BTt+HAej8gQyqhOLwezhhhKOzhu7kiNjCr7oegNXF0RMHIjMV/l4NUZKGb+lk6TIiSSj
         ccSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BjdiZRflOIy24Sc8tHlV56lqnBBBbp9z1FlL9PYymfk=;
        b=OzRB2Mx4PPbKmnx25SmFIPOIa41rySPnofS/TL8QmCr21JnnJPRCulWcGCA5DoqWYs
         x0NwDT+IXpwSIkFa+9uzbY1znHqBCY+7eQUjSVEqkZXrHyc6gEd+wyVGYmNOnaM/Re3w
         URCPbw//USSLDIG532It+z8o6gFwEYQr3eJcBL4YfZ+leJhpsnq57pSdjjWQ006s1CE9
         +hdiDFglv+IqQnKcg/DlL7qtNukGKh0WUSpljk42xoFVFuQGn9d2x9qM0TtaZlzKEHwo
         mQ2N3KQu4GhxPEgHMElvYQmA+LoBvny8ywNTDHbQDT9zaue89/4crpHQ05tZrzctvqYG
         MEGg==
X-Gm-Message-State: AOAM53270xp38VJDn8z874Pdry/eau+alvzLaq336IXrMhiRXnUe7MU2
        RbDhyl1QB8hOttjkEhlS2+/Iv4C4xrIlUsPtVM8Q
X-Google-Smtp-Source: ABdhPJxr31Ir7kMa34TlO2KRGAVV59Yw7c18aqpjXJhLIb4aw7xy8eZw5YS7+c20jthIZx2UDWi7+4wQMYhAKD0lK4c=
X-Received: by 2002:a17:906:a443:: with SMTP id cb3mr1960203ejb.542.1616124801937;
 Thu, 18 Mar 2021 20:33:21 -0700 (PDT)
MIME-Version: 1.0
References: <20210318215303.2578052-1-omosnace@redhat.com>
In-Reply-To: <20210318215303.2578052-1-omosnace@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 18 Mar 2021 23:33:08 -0400
Message-ID: <CAHC9VhTLjcU0FXS+68wJExRVJrZh_w_-2QYXypf9gsn4YvkUcQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] selinux: policy load fixes
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     selinux@vger.kernel.org,
        Stephen Smalley <stephen.smalley.work@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Mar 18, 2021 at 5:53 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> Changes in v3:
> - move new struct declarations to the top of services.c
> - add another patch to clean up error reporting during policy load
>
> Changes in v2:
> - switch to a more minimal fix which allocates the conversion params
>   dynamically and passes them between the functions
> - split out the MAC_POLICY_LOAD record fix into a separate patch
>
> Ondrej Mosnacek (3):
>   selinux: don't log MAC_POLICY_LOAD record on failed policy load
>   selinux: fix variable scope issue in live sidtab conversion
>   selinuxfs: unify policy load error reporting
>
>  security/selinux/include/security.h | 15 +++++--
>  security/selinux/selinuxfs.c        | 22 +++++-----
>  security/selinux/ss/services.c      | 63 ++++++++++++++++++-----------
>  3 files changed, 59 insertions(+), 41 deletions(-)

Thanks Ondrej.  I've merged all three of these into the
selinux/stable-5.12 branch and if testing goes well I'll send it up to
Linus next week.  I was a little undecided on if patch 3/3 qualified
as -stable material, but it does fix a user-visible issue and is small
enough in scope that I don't think it should be a problem.

-- 
paul moore
www.paul-moore.com
