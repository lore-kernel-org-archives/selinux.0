Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69C8BC4338F
	for <selinux@archiver.kernel.org>; Tue, 10 Aug 2021 16:31:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5063E60F13
	for <selinux@archiver.kernel.org>; Tue, 10 Aug 2021 16:31:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233409AbhHJQcQ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 10 Aug 2021 12:32:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231709AbhHJQcQ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 10 Aug 2021 12:32:16 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DC90C0613C1
        for <selinux@vger.kernel.org>; Tue, 10 Aug 2021 09:31:54 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id u10so29655735oiw.4
        for <selinux@vger.kernel.org>; Tue, 10 Aug 2021 09:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3ezbpXknzc+vUNqDy4JgUHkIjsW5FxQdGSQkG7Z/W1U=;
        b=I4W44iLLH07aiLg6c4Q3CwPdAWP3oZNlOZZD4xDYVvKh/wj6THyCoo2Iw70QvAi44X
         vCarRlkRB6DUo1qtXVxmijcgIaa0MvTO36GC9+PRr8G/e5BUSYvMHHcstnWlRXKcrwZ5
         xts740P6gDnpOxZuJbuSWNIdJ5xafGogCauG11YRzUB4cYA3z3RURVU75K+IrJ7ui+gc
         bh3ibWxX17lY/J3eVGdE16f361mYp5Yq2EjSQJ6GgwV7xiBatAo/7JFcrQpar+vAi9AO
         qk7pjok8coGYmgYBmJrTL2h4y+hQJ4DBpddDCLaGxScKNf/KW65CLdPJBT6auz4PeW47
         +IZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3ezbpXknzc+vUNqDy4JgUHkIjsW5FxQdGSQkG7Z/W1U=;
        b=EdnK6DZU5iPH0kH/MMznzV9gh3NuhaTG2oYz3lyyxbGp73vWAFuQMcRbL9RIl5ROcH
         g0EO0b3CtICdNtfWAH6QGLmXU2gNSuGi0MHZp69o0f2oaeLaJPQzYlf3mLBaE39hbYaS
         2Fet4jTP+q4uQbySctEQ2+q6xGL5fYOj0LkkxEgzDYKZZrYUjq1l7UPEA+PQGkUq1yS4
         OwXy7FI7ZBJpOuKtqG75QKirBKzNicFh2lWlmUyx5K0YWjV+Kyg6HMI8KufXWVmp16LY
         oFKaBuqRggepbe7gYdrOSrLWZDb0NvHOE24WoUX7EydIOSQ+GPl4U/HjKfuTfvyymRYj
         nFLw==
X-Gm-Message-State: AOAM532YGWvQ/SbE7Ofm2hhHndeTcFWC4PvWDR691UmMZLFzHoGcve1B
        wEh+3OYlI1v90wfNlFraxo/i1RkkPHV0SsMRAvY=
X-Google-Smtp-Source: ABdhPJyLkSdNG7zYZ3Zty3NSOtG86kQ4HZlWFKyuz31elM0KyI7TYOw4hOw2vLKxRrrUDOLRc5guwxomQgHfmn0gGBA=
X-Received: by 2002:aca:1815:: with SMTP id h21mr4201243oih.128.1628613113642;
 Tue, 10 Aug 2021 09:31:53 -0700 (PDT)
MIME-Version: 1.0
References: <20210806083340.160333-1-plautrba@redhat.com> <CAP+JOzR3twm0Jg5EFsRP=2mzEdthUnwVv=8WKcXV=3zVzz+c1w@mail.gmail.com>
In-Reply-To: <CAP+JOzR3twm0Jg5EFsRP=2mzEdthUnwVv=8WKcXV=3zVzz+c1w@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Tue, 10 Aug 2021 12:31:42 -0400
Message-ID: <CAP+JOzTxtN42OF9+C5EeKNUAq76RRaP4nrHuiLuG3dLU_U=APg@mail.gmail.com>
Subject: Re: [PATCH] mcstrans: Improve mlstrans-test output
To:     Petr Lautrbach <plautrba@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Aug 6, 2021 at 4:06 PM James Carter <jwcart2@gmail.com> wrote:
>
> On Fri, Aug 6, 2021 at 4:34 AM Petr Lautrbach <plautrba@redhat.com> wrote:
> >
> > Fixes:
> >     trans: a:b:c:s9 -> a:b:c:TOP SECRET != a:b:c:TOP SECRET SUCCESS
> >     untrans: a:b:c:T O P S E C R E T -> a:b:c:s9 != a:b:c:s9 SUCCESS
> >
> > Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
>
> Acked-by: James Carter <jwcart2@gmail.com>
>
Merged.
Thanks,
Jim

> > ---
> >  mcstrans/share/util/mlstrans-test | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/mcstrans/share/util/mlstrans-test b/mcstrans/share/util/mlstrans-test
> > index 085fa82ddd25..df34e0e67c84 100644
> > --- a/mcstrans/share/util/mlstrans-test
> > +++ b/mcstrans/share/util/mlstrans-test
> > @@ -15,7 +15,7 @@ def untrans(trans, val):
> >          errors += 1
> >      else:
> >          if verbose:
> > -            print("untrans: %s -> %s != %s SUCCESS" % (trans, raw, val))
> > +            print("untrans: '%s' -> '%s' == '%s' SUCCESS" % (trans, raw, val))
> >
> >
> >  def trans(raw, val):
> > @@ -26,7 +26,7 @@ def trans(raw, val):
> >          errors += 1
> >      else:
> >          if verbose:
> > -            print("trans: %s -> %s != %s SUCCESS" % (raw, trans, val))
> > +            print("trans: '%s' -> '%s' == '%s' SUCCESS" % (raw, trans, val))
> >
> >
> >  if len(sys.argv) > 1 and sys.argv[1] == "-v":
> > --
> > 2.32.0
> >
