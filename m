Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A4DFC433DB
	for <selinux@archiver.kernel.org>; Tue, 16 Mar 2021 13:35:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 666CE64DD8
	for <selinux@archiver.kernel.org>; Tue, 16 Mar 2021 13:35:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235181AbhCPNfA (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 16 Mar 2021 09:35:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235160AbhCPNec (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 16 Mar 2021 09:34:32 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD700C06174A
        for <selinux@vger.kernel.org>; Tue, 16 Mar 2021 06:34:31 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id x135so33603743oia.9
        for <selinux@vger.kernel.org>; Tue, 16 Mar 2021 06:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7Uq5lMPomr5PLr9XRGG/xHFv9pYoCWiZRZRmglywt00=;
        b=X88q3pVcerzfGeFeA5HuArN3LE9RaZSuNQ+JT8gNKX05oLdD8yWzXkKKhWANNsVkf2
         QGcvtQJq5AaIg+Ixo43BtQvxxH34h8k35dUxj7gxD7oC+lIf0Yv5Ul0TM7xZ5AwFNmp2
         a/78SKweOdAmjSSIPSejAWMi+t7eww/5Cx0ENgdzpuRPb3VwdPGjMjYEGVr/lkr5OXg1
         Deovplv4S98EfnH++k+DArbH0qAdGO2W0uHwc8RyiUo5+rjLu2iUc/RrOptbvpE7j7F1
         2+jAxZ/Ey+DGjAWCHTt2M8ZUsqKBQn5RFLHCaFSEboT5RhH7lqNRXQNKqF9h8eK6AYXv
         WvgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7Uq5lMPomr5PLr9XRGG/xHFv9pYoCWiZRZRmglywt00=;
        b=UeMOhECIw684JSev+NE6S+tYZuoJY+vLqSUFe74RbAqkGitwCeAYtOXedCI/YCMcEB
         rDgCyDyb8Y7Bn72cbTECO5+1isiW6tIvG5QCtw+5JZTJGBj1i4HS392yjg6eQUJPjAET
         pdKlbbO9nuljPtSQxqOkrdKa9+GVOnamVaC/5YRA/FBVfyhIHhHlOmOwaztCBtowB1Ek
         N9EgxUD6uXXd/u8hyio2Y6DBryKxHgtovHonUCqO/XCf+EU9Ate1zfs7bKGKSYNoHpmm
         OpQxud+D/hBOwEgGA9TF+CAZLg7p0SpfkS1MXo162HfPipAZd7ejl0fg8vvO40iuET9Q
         9AWw==
X-Gm-Message-State: AOAM531IzbJc813TgYVJMW/Tr7dXN4uKavshzHFcXQ0DdXPDKmSF8RKo
        cQvYh9m5Yc+LG/knDdcb13pGS/I6RkMGHeKkoC4=
X-Google-Smtp-Source: ABdhPJw0/tj7ET89btHdKXDz9G2L9ogh6ZZidSvWBzcdcqPCWf7HOZFE6BLv6bHYtkkswxi5LeCwqjD5EAOZHnLZqfk=
X-Received: by 2002:aca:5ad6:: with SMTP id o205mr3524038oib.128.1615901671171;
 Tue, 16 Mar 2021 06:34:31 -0700 (PDT)
MIME-Version: 1.0
References: <20210314201651.474432-1-nicolas.iooss@m4x.org>
 <CAP+JOzThBfc5-JtYYuPfhBHX6phxWMCJksy8WPggDiDFJyTpaw@mail.gmail.com> <CAJfZ7==YxFEzOidB4E6SpSEHPdF=9eX2YROXjX_-H4Fi1MU=gA@mail.gmail.com>
In-Reply-To: <CAJfZ7==YxFEzOidB4E6SpSEHPdF=9eX2YROXjX_-H4Fi1MU=gA@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Tue, 16 Mar 2021 09:34:20 -0400
Message-ID: <CAP+JOzRFvwFKYhqrdjy=AjLqsiprbT8p2fc-cbuPGEhSMvNFiw@mail.gmail.com>
Subject: Re: [PATCH 1/6] libsepol/cil: fix out-of-bound read of a file context
 pattern ending with "\"
To:     Nicolas Iooss <nicolas.iooss@m4x.org>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Mar 15, 2021 at 5:34 PM Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
>
> On Mon, Mar 15, 2021 at 10:02 PM James Carter <jwcart2@gmail.com> wrote:
> >
> > On Sun, Mar 14, 2021 at 4:23 PM Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
> > >
> > > OSS-Fuzz found a Heap-buffer-overflow in the CIL compiler when trying to
> > > compile the following policy:
> > >
> > >     (sid SID)
> > >     (sidorder(SID))
> > >     (filecon "\" any ())
> > >     (filecon "" any ())
> > >
> > > When cil_post_fc_fill_data() processes "\", it goes beyond the NUL
> > > terminator of the string. Fix this by returning when '\0' is read after
> > > a backslash.
> > >
> > > Fixes: https://bugs.chromium.org/p/oss-fuzz/issues/detail?id=28484
> > > Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
> > > ---
> > >  libsepol/cil/src/cil_post.c | 6 ++++++
> > >  1 file changed, 6 insertions(+)
> > >
> > > diff --git a/libsepol/cil/src/cil_post.c b/libsepol/cil/src/cil_post.c
> > > index a55df1ea5bb0..5f9cf4efd242 100644
> > > --- a/libsepol/cil/src/cil_post.c
> > > +++ b/libsepol/cil/src/cil_post.c
> > > @@ -179,6 +179,12 @@ void cil_post_fc_fill_data(struct fc_data *fc, char *path)
> > >                         break;
> > >                 case '\\':
> > >                         c++;
> >
> > The patch below is fine, but I can't figure out the reason for the
> > line above. I guess it means that fc->str_len++ will be skipped, but
> > if that is the purpose, it is not very clear. Does anyone know if this
> > is correct?
>
> Which line? "break;" ? In case you and/or other people are confused
> about the code in cil_post_fc_fill_data, this "break;" exits the
> switch(path[c]) block but still executes the lines right after
> ("fc->str_len++;" and "c++;"):
>

Sorry, I wasn't very clear. I am wondering what the "c++" is doing
here because after the switch statement there is another "c++" (after
"fc->str_length++"), so this skips the character after the "/". Why
would one do that? My only thought is that maybe "/" is not supposed
to count towards the string length and the author thought not counting
the next character works just as well? Except, of course, it doesn't
if there is no next character.

Jim

> while (path[c] != '\0') {
>     switch (path[c]) {
>     case '.':
>     /* ... */
>     case '{':
>         fc->meta = 1;
>         break;
>     case '\\':
>         c++;
>         /* FALLTHRU */
>     default:
> // This code is executed for every character before a special one
> // (while "meta" is false)
> // and "\c" counts as a single character, for c being anything.
>         if (!fc->meta) {
>             fc->stem_len++;
>         }
>         break;
>     }
> // These lines are executed for every character.
> // "str_len" counts the number of unescaped characters
> // ("\c" counts as a single character)
>     fc->str_len++;
>     c++;
> }
>
> In my opinion, the code looks correct, but this could be verified with
> a new unit test which could computes str_len and stem_len for some
> strings.
>
> Cheers,
> Nicolas
>
