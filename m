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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DFE8C433ED
	for <selinux@archiver.kernel.org>; Mon, 19 Apr 2021 14:34:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6FFDB611CE
	for <selinux@archiver.kernel.org>; Mon, 19 Apr 2021 14:34:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239880AbhDSOej (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 19 Apr 2021 10:34:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232302AbhDSOeh (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 19 Apr 2021 10:34:37 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F408FC06174A
        for <selinux@vger.kernel.org>; Mon, 19 Apr 2021 07:34:06 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id o13-20020a9d404d0000b029028e0a0ae6b4so13696414oti.10
        for <selinux@vger.kernel.org>; Mon, 19 Apr 2021 07:34:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KAXVf1a0M1Cs+V+5laxxDg48u/tczzLKO/k7DwF/GGs=;
        b=S9vLliSew77rJ5pcLpjqjJuT2MvCvCtVJyjy83uOdfBfxgSIeUVovTzUeTKUn+mgB5
         sinEmV3NyJmACPuGPzVY+3CF6zoDp+NaIvR7GDSN1prszArxNnRps/gT98T0LFFCm4rr
         EsqzjL0Opo0w03Be04x2tF75GkKpRZwREBTHwVmVQIpvYL01fBx4TGsx0HbQngmWlIs8
         FqqykB6BFnqLfdQWlqPX4f/bj5JKzAAJnuzP6NaG4KlEmrA1utYX2JjMFqmMBIxUkWam
         l1ZJRzqY9HUzyXxVrkwXsVA0SRM3hl3qIK/5BHk2Rvg9gzoWfuIBlM3mLLwScTts28WP
         j5wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KAXVf1a0M1Cs+V+5laxxDg48u/tczzLKO/k7DwF/GGs=;
        b=Ww4XPvqXSRWJp/RuWDACuQVANbB3OzIUdINm1pM/FMDQvLS++WhUdR3/+Cl3opg3Xp
         F9jOc5a0anMVJpawM6qjp3NyKWTelpIfDJbIS7SzTnaLT1tr4bL8NNT4n6BB/LD8xgCN
         L5Q2IOPMpcpQbnPVBCUZFCEVPtiazBwK494gdzLLO3R4WpcpTIlyCfiJW/mdL5HGJc/W
         QIfJ5S3OMTfU1q21N2dG6MxAvAYipVoCWk2+CGUReww5xFipZ5/6G2EyZDbwm15D7fDc
         FrXxtXRyOEROiujrHrxzhDgrd5vlcVSCXmkpoafcwdsoF1iyg3PP3uCCTwUmycnY09C6
         8gig==
X-Gm-Message-State: AOAM530nwKxbzlgoX/mU477YxJrm8GwOCUm7cRYtAzUrj3PdJW99FwyK
        K9C9kXMidg98itV2iJ/qHz6SYyJD3txrjtK2ivM=
X-Google-Smtp-Source: ABdhPJwP5jYkK0zHJzuQRWiObScu1oFA+ez1IcN7jnF0cLuduw5RsPXG3L2B+qoNL6/SHDx0RxqOTMhYjB2OmgF17fM=
X-Received: by 2002:a05:6830:1beb:: with SMTP id k11mr675702otb.59.1618842846455;
 Mon, 19 Apr 2021 07:34:06 -0700 (PDT)
MIME-Version: 1.0
References: <20210414141027.3494107-1-yochiang@google.com> <CAP+JOzSCEfgouyWfjkZjPwrEZM0SSKqGH2QJdirp8zkHPyXBfg@mail.gmail.com>
In-Reply-To: <CAP+JOzSCEfgouyWfjkZjPwrEZM0SSKqGH2QJdirp8zkHPyXBfg@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Mon, 19 Apr 2021 10:33:55 -0400
Message-ID: <CAP+JOzSaRAOHwfiD19_i=8Q_y-_Quv0MQG+TQvJhJSX3GnSYsw@mail.gmail.com>
Subject: Re: [PATCH] secilc.c: Don't fail if input file is empty
To:     Yi-Yo Chiang <yochiang@google.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Apr 14, 2021 at 3:18 PM James Carter <jwcart2@gmail.com> wrote:
>
> On Wed, Apr 14, 2021 at 12:32 PM Yi-Yo Chiang <yochiang@google.com> wrote:
> >
> > fread(3) returns zero if |size| is zero. This confuses secilc, and
> > causes it to fail with a "Failure reading file" error, even though there
> > is no error.
> >
> > Add a shortcut that closes and skips an input file if file size is zero.
> >
> > Signed-off-by: Yi-Yo Chiang <yochiang@google.com>
>
> Acked-by: James Carter <jwcart2@gmail.com>
>

Applied.
Thanks,
Jim

> > ---
> >  secilc/secilc.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/secilc/secilc.c b/secilc/secilc.c
> > index 186c5a73..9c78e425 100644
> > --- a/secilc/secilc.c
> > +++ b/secilc/secilc.c
> > @@ -268,6 +268,12 @@ int main(int argc, char *argv[])
> >                 }
> >                 file_size = filedata.st_size;
> >
> > +               if (!file_size) {
> > +                       fclose(file);
> > +                       file = NULL;
> > +                       continue;
> > +               }
> > +
> >                 buffer = malloc(file_size);
> >                 rc = fread(buffer, file_size, 1, file);
> >                 if (rc != 1) {
> > --
> > 2.31.1.295.g9ea45b61b8-goog
> >
