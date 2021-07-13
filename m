Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2C81C07E95
	for <selinux@archiver.kernel.org>; Tue, 13 Jul 2021 20:01:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C8BB61178
	for <selinux@archiver.kernel.org>; Tue, 13 Jul 2021 20:01:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234411AbhGMUD4 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 13 Jul 2021 16:03:56 -0400
Received: from mx1.polytechnique.org ([129.104.30.34]:49910 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229944AbhGMUDz (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 13 Jul 2021 16:03:55 -0400
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 2039656479A
        for <selinux@vger.kernel.org>; Tue, 13 Jul 2021 22:01:04 +0200 (CEST)
Received: by mail-io1-f54.google.com with SMTP id k11so28771588ioa.5
        for <selinux@vger.kernel.org>; Tue, 13 Jul 2021 13:01:04 -0700 (PDT)
X-Gm-Message-State: AOAM533B7FizzUmyFK73ZOdVhmmtq4hjvSfrd6uv7Vh4vjvXx5dPwuBm
        sZLEhR8BZ8DUpfEPHVi9yXby2ChmXGGNUE/6YrI=
X-Google-Smtp-Source: ABdhPJwkKdVaGc0Pye4PctEwFIDARRmfPThV7Srr17ZKAHU9m0sKlhY2bxHpIjuvH25pZ2jVuNX7MVIIreGDo20C4tI=
X-Received: by 2002:a5d:8186:: with SMTP id u6mr4477522ion.45.1626206463313;
 Tue, 13 Jul 2021 13:01:03 -0700 (PDT)
MIME-Version: 1.0
References: <20210712084428.73440-1-nicolas.iooss@m4x.org> <CAP+JOzR-xRuU9x4qm5Ndp-wbjgxHj2UDxwdcvkGSxTg912=snw@mail.gmail.com>
In-Reply-To: <CAP+JOzR-xRuU9x4qm5Ndp-wbjgxHj2UDxwdcvkGSxTg912=snw@mail.gmail.com>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Tue, 13 Jul 2021 22:00:52 +0200
X-Gmail-Original-Message-ID: <CAJfZ7=nwwZXwmVxj1RXhdi0-jxyTTtd=RSuUr3EZYV1BLB0HJQ@mail.gmail.com>
Message-ID: <CAJfZ7=nwwZXwmVxj1RXhdi0-jxyTTtd=RSuUr3EZYV1BLB0HJQ@mail.gmail.com>
Subject: Re: [PATCH] libsepol/cil: do not allow \0 in quoted strings
To:     James Carter <jwcart2@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Tue Jul 13 22:01:04 2021 +0200 (CEST))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Jul 12, 2021 at 4:36 PM James Carter <jwcart2@gmail.com> wrote:
>
> On Mon, Jul 12, 2021 at 4:54 AM Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
> >
> > Using the '\0' character in strings in a CIL policy is not expected to
> > happen, and makes the flex tokenizer very slow. For example when
> > generating a file with:
> >
> >     python -c 'print("\"" + "\0"*100000 + "\"")' > policy.cil
> >
> > secilc fails after 26 seconds, on my desktop computer. Increasing the
> > numbers of \0 makes this time increase significantly. But replacing \0
> > with another character makes secilc fail in only few milliseconds.
> >
> > Fix this "possible denial of service" issue by forbidding \0 in strings
> > in CIL policies.
> >
> > Fixes: https://bugs.chromium.org/p/oss-fuzz/issues/detail?id=36016
> >
> > Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
>
> Acked-by: James Carter <jwcart2@gmail.com>

Merged.
Thanks!
Nicolas

> > ---
> >  libsepol/cil/src/cil_lexer.l | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/libsepol/cil/src/cil_lexer.l b/libsepol/cil/src/cil_lexer.l
> > index e28c33ecb9f1..8bf2b6e7765a 100644
> > --- a/libsepol/cil/src/cil_lexer.l
> > +++ b/libsepol/cil/src/cil_lexer.l
> > @@ -49,7 +49,7 @@ spec_char     [\[\]\.\@\=\/\*\-\_\$\%\+\-\!\|\&\^\:\~\`\#\{\}\'\<\>\?\,]
> >  symbol         ({digit}|{alpha}|{spec_char})+
> >  white          [ \t]
> >  newline                [\n\r]
> > -qstring                \"[^"\n]*\"
> > +qstring                \"[^"\n\0]*\"
> >  hll_lm          ^;;\*
> >  comment                ;
> >
> > --
> > 2.32.0
> >

