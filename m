Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DE9DECAAD3
	for <selinux@archiver.kernel.org>; Thu,  1 Sep 2022 19:59:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232619AbiIAT7d (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 1 Sep 2022 15:59:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234747AbiIAT7N (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 1 Sep 2022 15:59:13 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F68A91D0F
        for <selinux@vger.kernel.org>; Thu,  1 Sep 2022 12:59:02 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id r7so25994ile.11
        for <selinux@vger.kernel.org>; Thu, 01 Sep 2022 12:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=j0QS5OdP35l7sy/20J60rTBqmW3LOyEZ9jFCDWoWfoI=;
        b=S4uq/NZyTTLCbTLJTNgQLDFjbs8OEbMmuU/8EI05niiTEmWkGAZLZEpSiwbshwPZGS
         IAn05pvEWTu5eaN1S/v4paO/bTiJBGBaOo6ItHJtkj93FyXZR9gqpYGLNMH9mK5jyDCM
         QH76wAAO6CIQaj+fhG+HB7TLjnlEsqmG0tbOs48UQDuPFcvd8mSQmKp1qJ9ncYv2xHSL
         jb6e5gxhC+54fKNBGeFyq4m8Coi1RKH7+HDKSyG7iyVSPoK31k2PYDXIvVlDpHBawA/K
         Bc7TTM8qYpvQNdeJhkKP/LuAmxUDfClGEGtNFglS6Xj1RlFF80ICw9VmqSZaSG9SDxdU
         QfTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=j0QS5OdP35l7sy/20J60rTBqmW3LOyEZ9jFCDWoWfoI=;
        b=FLU8o/0cZnQB3eVIK/+VP8waoNRNYmKx0UkZ7utETgdNKHJgvGiE6ohzMrb3+IxK27
         KDyic+uNeYE1eMdonnrQ2RZW2yBGPyy480MP1B2Q+IHl/SqXOVgNZRo8mF+C2PeL80uc
         f++WcdpT3gAevGA+9BaieAQTAYrPoNcO+oc2icDuxkPYcP/4v4RGh8viwFM/emFRVwlo
         ZijledvwktXJYWKHyiaUOctAmAz0vCD+gppmEEhyge1KRIxxdOzXAb598kxTFgG+SRc+
         UQdIfHKR0EHTuwJZnYJe4iRihIAqvCp1NrapO6QEThZ/PSVFn+Z2fg+hVho9BnN1em9x
         4AQg==
X-Gm-Message-State: ACgBeo28a3GoeEqt7TTFoYQCHQyxaExenyZdTJK5PtVt7MTmt1OMq1kz
        R80yHYysN/iS6LvdRxGrQ4JphsM0ExRFcvV+xhEj66Fb
X-Google-Smtp-Source: AA6agR4WYleeCjj618xdgjNU9WjnOWm8UbWj/SiIc9MW0N/t20V3fOjULaXmCF4ePoFSlQHoUpJDmmMkc00m0ih9Gmo=
X-Received: by 2002:a05:6e02:194a:b0:2eb:7105:dd65 with SMTP id
 x10-20020a056e02194a00b002eb7105dd65mr5915655ilu.20.1662062341946; Thu, 01
 Sep 2022 12:59:01 -0700 (PDT)
MIME-Version: 1.0
References: <89653753-717f-3ef9-9538-c90ad2aa62b1@gmail.com> <CAP+JOzT-kWKqTOGrYso7eWYh_4KBoUn61r_cPUGR8OvefxTVHw@mail.gmail.com>
In-Reply-To: <CAP+JOzT-kWKqTOGrYso7eWYh_4KBoUn61r_cPUGR8OvefxTVHw@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Thu, 1 Sep 2022 15:58:51 -0400
Message-ID: <CAP+JOzSKUQaGXihRm+LJttCzdrHgu5N6MBZ8cekB9ocrtoL=eg@mail.gmail.com>
Subject: Re: [PATCH 3/3] secilc/docs: disable pandoc default css for html docs
To:     bauen1 <j2468h@googlemail.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Aug 31, 2022 at 7:55 AM James Carter <jwcart2@gmail.com> wrote:
>
> On Sun, Aug 28, 2022 at 8:16 AM bauen1 <j2468h@googlemail.com> wrote:
> >
> > Some time ago pandoc started shipping a default css file for html, while
> > that is nice, it limits the max-width of the body element to 36em. We
> > have a lot of tables, code examples, etc... in the manual that are too
> > big for that, requiring constant scrolling.
> >
> > See https://github.com/jgm/pandoc/blob/master/data/templates/styles.html
> > for the default used.
> >
> > While some styling, perhaps even dark/light mode support in the CSS
> > would be nice, I didn't manage to find a simple way to achieve this, so
> > for now just disable the CSS.
> >
> > Expand the arguments for pandoc in the Makefile for better readability.
> >
> > Signed-off-by: Jonathan Hettwer (bauen1) <j2468h@gmail.com>
>
> Acked-by: James Carter <jwcart2@gmail.com>
>

This patch has been merged.
Thanks,
Jim

> > ---
> >   secilc/docs/Makefile | 18 ++++++++++++++++--
> >   1 file changed, 16 insertions(+), 2 deletions(-)
> >
> > diff --git a/secilc/docs/Makefile b/secilc/docs/Makefile
> > index a03ebeed..7e2ba40e 100644
> > --- a/secilc/docs/Makefile
> > +++ b/secilc/docs/Makefile
> > @@ -58,11 +58,25 @@ $(TMPDIR)/policy.cil: $(TESTDIR)/policy.cil
> >
> >   html: $(PANDOC_FILE_LIST) $(TMPDIR)/policy.cil secil.xml
> >         mkdir -p $(HTMLDIR)
> > -       $(PANDOC) --highlight-style=$(PANDOC_HIGHLIGHT_STYLE) --syntax-definition=secil.xml --standalone --metadata title="CIL Reference Guide" -t html $(PANDOC_FILE_LIST) $(TMPDIR)/policy.cil  -o $(HTMLDIR)/$(HTML_OUT)
> > +       $(PANDOC) \
> > +               --highlight-style=$(PANDOC_HIGHLIGHT_STYLE) \
> > +               --syntax-definition=secil.xml \
> > +               --standalone \
> > +               --metadata title="CIL Reference Guide" \
> > +               --metadata document-css=false \
> > +               -t html \
> > +               $(PANDOC_FILE_LIST) $(TMPDIR)/policy.cil \
> > +               -o $(HTMLDIR)/$(HTML_OUT)
> >
> >   pdf: $(PANDOC_FILE_LIST) $(TMPDIR)/policy.cil secil.xml
> >         mkdir -p $(PDFDIR)
> > -       $(PANDOC) --highlight-style=$(PANDOC_HIGHLIGHT_STYLE) --syntax-definition=secil.xml --standalone --toc $(PANDOC_FILE_LIST) $(TMPDIR)/policy.cil -o $(PDFDIR)/$(PDF_OUT)
> > +       $(PANDOC) \
> > +               --highlight-style=$(PANDOC_HIGHLIGHT_STYLE) \
> > +               --syntax-definition=secil.xml \
> > +               --standalone \
> > +               --toc \
> > +               $(PANDOC_FILE_LIST) $(TMPDIR)/policy.cil \
> > +               -o $(PDFDIR)/$(PDF_OUT)
> >
> >   clean:
> >         rm -rf $(HTMLDIR)
> > --
> > 2.36.1
> >
