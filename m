Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32CA1C4332F
	for <selinux@archiver.kernel.org>; Mon, 21 Nov 2022 20:55:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229509AbiKUUz0 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 21 Nov 2022 15:55:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbiKUUzZ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 21 Nov 2022 15:55:25 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F338C68B4
        for <selinux@vger.kernel.org>; Mon, 21 Nov 2022 12:55:24 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id h23so10039952edj.1
        for <selinux@vger.kernel.org>; Mon, 21 Nov 2022 12:55:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KevsXqz+o1Pw8mm8J94zSB6SwLNTVyCdfUoouYkWLnc=;
        b=fY6fz7XPzJy7hwzo4oZeuSVQ//HHcJ9eBUL7EJNj67Ub1YA2CB14azovj049LlxXZ3
         Qc97VRA2ax+D2YlGiszfLmWF5qygbUjdhtGvWysBvlqmRzTw88AB9gSs4XPSbVjxU0Sm
         HhsQlQ+6XgW6XMGvXkUYeRav61FUSTZTraL0mliErBb8oUHvndx9UDQObJpKnCwqcCph
         9Pddyha2PSdjrozqx1mRF1A9oG/gT+ovsRG4B0uMWdlYl40LzIBl5ylC5Hnzz4l6aqZk
         B1EoOuOgCjnNusI1T0E1gzwpUxVXvIkKA9A5DyJvnH1N0/Tgnb9nFg7Gs9aY9d8tON24
         L1nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KevsXqz+o1Pw8mm8J94zSB6SwLNTVyCdfUoouYkWLnc=;
        b=sNGG+HMf3inQac5kEvpzSUDYSQnQxwX58CQuDuYJB2VwS/IQRZY2cobaTBKoS7QdsQ
         MTR6eKWkeLspqECiGc1+4se3KD907J3gC89cdYCcwdUQW4bgyco9W2gHGLYoL2xX4F03
         Q4wg6cSq7Rspexw1P/8MVbfoAAn/zHUpTISwQS9CdfRek/6pRVbHz9y1TASXtHtjPTIf
         qcXsqo7Jk9qU/FxPiYi8+QceEEML8sJWAGggFyXw2WcdOxMXuBEOyrJSZlxBAdceCqvW
         /BaScQK2p64qU+KdXnU4f/t1tc/E+O4YeiUdAIqMBP7n37YFIeafOwl//AmwKJ52ojPo
         DeNA==
X-Gm-Message-State: ANoB5pnUdtJPH4VTo2Z2TqkT2h9qte9i1LBuq7kNzwv8kgp8xRkrrlHN
        79yNE0l804Fr9qFuZBRTtr5imc24rZYIbMl5e2Zqj75l
X-Google-Smtp-Source: AA0mqf6cCKFn5RtEAt03BRuFDSKrN2wV2irgr8x3R/6s4xCpzmcR5BAwad7U90mi3bTSNM3AgXYhIvBSgozlFvCmo/Y=
X-Received: by 2002:aa7:c6da:0:b0:469:172:1f38 with SMTP id
 b26-20020aa7c6da000000b0046901721f38mr15735635eds.195.1669064122680; Mon, 21
 Nov 2022 12:55:22 -0800 (PST)
MIME-Version: 1.0
References: <20221109105327.1181753-1-plautrba@redhat.com> <CAP+JOzRCKet4qcg9SN2cuDKDDXAT9AdPEacJ4uFOWKQo2pX5UQ@mail.gmail.com>
In-Reply-To: <CAP+JOzRCKet4qcg9SN2cuDKDDXAT9AdPEacJ4uFOWKQo2pX5UQ@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Mon, 21 Nov 2022 15:55:11 -0500
Message-ID: <CAP+JOzTQnfJLDiMQ+vEaArnt49iNH0Mb8tj2XFQT3DELT+278w@mail.gmail.com>
Subject: Re: [PATCH v2] python: Fix typo in audit2allow.1 example
To:     Petr Lautrbach <plautrba@redhat.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Nov 9, 2022 at 12:16 PM James Carter <jwcart2@gmail.com> wrote:
>
> On Wed, Nov 9, 2022 at 5:59 AM Petr Lautrbach <plautrba@redhat.com> wrote:
> >
> > Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
>
> Acked-by: James Carter <jwcart2@gmail.com>
>
Merged.
Thanks,
Jim

> > ---
> >  python/audit2allow/audit2allow.1 | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/python/audit2allow/audit2allow.1 b/python/audit2allow/audit2allow.1
> > index c61067b33688..04ec32398011 100644
> > --- a/python/audit2allow/audit2allow.1
> > +++ b/python/audit2allow/audit2allow.1
> > @@ -151,7 +151,7 @@ policy_module(local, 1.0)
> >  gen_require(`
> >          type myapp_t;
> >          type etc_t;
> > - };
> > +\[aq])
> >
> >  files_read_etc_files(myapp_t)
> >  <review local.te and customize as desired>
> > --
> > 2.37.3
> >
