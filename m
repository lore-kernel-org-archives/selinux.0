Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22CA1C43334
	for <selinux@archiver.kernel.org>; Wed,  6 Jul 2022 20:11:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233117AbiGFULj (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 6 Jul 2022 16:11:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233061AbiGFULj (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 6 Jul 2022 16:11:39 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CE681C931
        for <selinux@vger.kernel.org>; Wed,  6 Jul 2022 13:11:38 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id s13-20020a0568301e0d00b00616ad12fee7so12563366otr.10
        for <selinux@vger.kernel.org>; Wed, 06 Jul 2022 13:11:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MSldGo1FqjK5R/w1GvpGfScuLcM22X3WFBw1CAdZF18=;
        b=chHS1NCjNUIJzjcpR+J8KX7go2LH7xag6ZB2oPk05sEFs8X/9/KneMsDCMbQskdeHM
         NcJlMHrIFiGL+gowbp9pybbR4T+XzjaKIBVeVZvuN1wXFJaR1BgNboGsH/AP4SPC36Wz
         eBmhWUKQzjLgosDqkxeD+lD28T/mPBFcbgfIxBl64g8jIb8yWgC5SuD7pBo1iXapy5pF
         jtTuNM6jIdc2uEwI6YLOPkFKpA/kO45yvCLVQ7pjPzvy27GZhh21/EWGNU0QeuAwX4dl
         XngHn4N0+wHjEN1PFjiOrrCpjpQAC9gV4OZr6legbHmCAp25O6ijG530ogDKUXULkbQv
         cC1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MSldGo1FqjK5R/w1GvpGfScuLcM22X3WFBw1CAdZF18=;
        b=7wdb4Xf/UbgsnI+DcYLg+/XP7Fpxb55og4zLhOEXSCx+lIY0QE/VBuVcAUTNAWLz4U
         K4k/9VXmq2N8FKoqpz3h/Uw1CKQKh29M0pHKYgRJ+YO2Sty4zuvL1g8KhCDG+MnujD6i
         S910Vv5ydeEs16u0z350zcB82ENlPvxnkctbf6cqO2NVS1u1mJwrD3LL2icEfziGgv6X
         qvCJV8JkG96pG/6U9YnfxWE7dnnwlMWUD6EeaLGuNXivv0qYlB/5HQSQ3munVja5yz2P
         PFOR1HJOThuuShveVAfvNjR9peYKsHrDn5+K5tHvdSafX8YGNwMZzjJ4AcNLs6GVkSz0
         5yAg==
X-Gm-Message-State: AJIora/8ZcEcA7/LaKjm+xi80IAHOnjGbNeNBJgiFeNQJk4jmfXQr6i9
        XXVNYjnfF5UkPsfREnfmn+aszNeuWDJ/R7m6s0A=
X-Google-Smtp-Source: AGRyM1vkS7lrbTxsKSWkikqbf9u+SSQARwWEccV6amrmxGtIsz4Z48zYxf7pIeeoUu6wYarzUBmB5nEbqVRoJvB/778=
X-Received: by 2002:a05:6830:61cd:b0:618:d560:b787 with SMTP id
 cc13-20020a05683061cd00b00618d560b787mr13131523otb.154.1657138297773; Wed, 06
 Jul 2022 13:11:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220629072055.2653695-1-nicolas.iooss@m4x.org> <CAP+JOzRXjoneNg4sQ3W9sMSneQETHqCw1yGUP1hdmXqbXXMwsQ@mail.gmail.com>
In-Reply-To: <CAP+JOzRXjoneNg4sQ3W9sMSneQETHqCw1yGUP1hdmXqbXXMwsQ@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Wed, 6 Jul 2022 16:11:26 -0400
Message-ID: <CAP+JOzQ1EG5B9PruozO3jiuGugNtTUWXTX+m_ipRwSJvRnyqoQ@mail.gmail.com>
Subject: Re: [PATCH userspace 1/1] libsepol: initialize s in constraint_expr_eval_reason
To:     Nicolas Iooss <nicolas.iooss@m4x.org>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Jun 29, 2022 at 4:06 PM James Carter <jwcart2@gmail.com> wrote:
>
> On Wed, Jun 29, 2022 at 3:37 AM Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
> >
> > clang's static analyzer reports that s[0] can be uninitialized when used
> > in:
> >
> >     sprintf(tmp_buf, "%s %s\n",
> >                     xcontext ? "Validatetrans" : "Constraint",
> >                     s[0] ? "GRANTED" : "DENIED");
> >
> > Silence this false-positive issue by making s always initialized.
> >
> > Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
>
> Acked-by: James Carter <jwcart2@gmail.com>
>

Merged.
Thanks,
Jim

> > ---
> >  libsepol/src/services.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/libsepol/src/services.c b/libsepol/src/services.c
> > index d7510e9dae51..db769cdcfaf9 100644
> > --- a/libsepol/src/services.c
> > +++ b/libsepol/src/services.c
> > @@ -394,7 +394,7 @@ static int constraint_expr_eval_reason(context_struct_t *scontext,
> >         role_datum_t *r1, *r2;
> >         mls_level_t *l1, *l2;
> >         constraint_expr_t *e;
> > -       int s[CEXPR_MAXDEPTH];
> > +       int s[CEXPR_MAXDEPTH] = {};
> >         int sp = -1;
> >         char tmp_buf[128];
> >
> > --
> > 2.36.1
> >
