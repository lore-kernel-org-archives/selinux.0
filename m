Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 230C1C433EF
	for <selinux@archiver.kernel.org>; Wed,  6 Apr 2022 21:16:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233955AbiDFVST (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 6 Apr 2022 17:18:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235429AbiDFVRw (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 6 Apr 2022 17:17:52 -0400
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com [IPv6:2607:f8b0:4864:20::c2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F17D100A5B
        for <selinux@vger.kernel.org>; Wed,  6 Apr 2022 13:06:13 -0700 (PDT)
Received: by mail-oo1-xc2e.google.com with SMTP id p34-20020a4a95e5000000b003248d73d460so567819ooi.1
        for <selinux@vger.kernel.org>; Wed, 06 Apr 2022 13:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vmOWZBP7okeImYUJcRiGfsgwNbamA1MYGu8Uo37Cz4Y=;
        b=jt3ilwJe8zQpBs49iVzbeXET1F59So42hQS7so4K78mAoa6DZ3gXOzTsh1/0SEv/Jn
         x9ob02rRUirGP+JT2BBQnTKYCIxaHMh0dS4MNVGRimIaA7ujLDxrG8hqWTfM1MRRbNdG
         DyJ+l6F7vdo2Y46E3qsMtUn46sU9i8N0ecM25/SnJxFGZ8ZBGGBT4sjSjPshDBuwk4NH
         7ylz87PkJo4KKnRBmU8o3y6tmXve0mnK+shmXmlMjzk0WKI/z+ZNLAmNh9muHqWowtME
         FwAmGrwfZQQp4KqGwaMtRAfV32zBAyBwpVJY9MjG/xdzWt7axOzGAezpJ+KFZDW2/J/0
         YnwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vmOWZBP7okeImYUJcRiGfsgwNbamA1MYGu8Uo37Cz4Y=;
        b=s1o5+qg3+vQOxLUIG3dEDkDar/oqDd9UxaEbS60u3jE7HnwN/Mxs+A2L5EpUJccTxq
         FGUbmMlwsb76DBqTbcqQZb0mQB9mObZlG6paKdZB8QkxdpAbR5X5k3MLLZk+NSsM0iui
         pu7MqS0hJJyRKcIjjFY25AJmgnBr2UtaqjT8gtpkpsbXY4NII/HTHJVsMoPBPGaF2U59
         krX++TPCkEOTgZZPJ+UJ0RizHgfUEqvqxowMPuGqdEV1JdW3iber6HhsYclaPqqKNDXK
         JRip9TCx/uh7SYvmspXIkMg7/tDpzyliYmbIuuTzEiZKH8WaCPejYFnXJhZeWQ7Ey9cV
         s6pw==
X-Gm-Message-State: AOAM533Qs5VI8XGuYYyhyBVqkHTEzbITUQGfaMD3Wr+PojfbEULREzR5
        3zsLYnbLDc9teNawuU2pEnoqZCx0ZbIDBJb+K7U=
X-Google-Smtp-Source: ABdhPJzGNH8cOztme0oQMHOwrXZo/vAJZexsjkVVfxyGZ3mLHdzwZItBWPzmZ49Sh/lwkmzDooottb7H2BT+RDYVPow=
X-Received: by 2002:a4a:8904:0:b0:323:7039:6c68 with SMTP id
 f4-20020a4a8904000000b0032370396c68mr3288798ooi.8.1649275572814; Wed, 06 Apr
 2022 13:06:12 -0700 (PDT)
MIME-Version: 1.0
References: <CAP+JOzTVdo2N8YKuhaS7xBVYCUjNFfb7NHk=yqTN1LZRncB+gA@mail.gmail.com>
 <20220405071735.251995-1-plautrba@redhat.com>
In-Reply-To: <20220405071735.251995-1-plautrba@redhat.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Wed, 6 Apr 2022 16:06:02 -0400
Message-ID: <CAP+JOzQq2oEwLoe=AzguxnyA4oLnSyAdUjeSWa0Dg4RqSJ2zaA@mail.gmail.com>
Subject: Re: [PATCH v2] setfiles.8: -q is deprecated and has no effect
To:     Petr Lautrbach <plautrba@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Apr 5, 2022 at 3:38 AM Petr Lautrbach <plautrba@redhat.com> wrote:
>
> Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
> ---
>  policycoreutils/setfiles/setfiles.8 | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/policycoreutils/setfiles/setfiles.8 b/policycoreutils/setfiles/setfiles.8
> index 15f939d1bee0..5267064de3b5 100644
> --- a/policycoreutils/setfiles/setfiles.8
> +++ b/policycoreutils/setfiles/setfiles.8
> @@ -124,7 +124,9 @@ and
>  options are mutually exclusive.
>  .TP
>  .B \-q
> -Deprecated, was only used to stop printing inode association parameters.
> +Deprecated and replaced by
> +.B \-v
> +. Has no effect on other options or on program behavior.

The "." at the beginning causes that line to not appear.

I am no man page expert, but this seems to work.

.B \-q
Deprecated and replaced by \fB\-v\fR. Has no effect on other options
or on program
behavior.

Thanks,
Jim

>  .TP
>  .BI \-r \ rootpath
>  use an alternate root path. Used in meta-selinux for OpenEmbedded/Yocto builds
> --
> 2.35.1
>
