Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5B4AC433E0
	for <selinux@archiver.kernel.org>; Mon, 15 Mar 2021 21:35:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9824C64F51
	for <selinux@archiver.kernel.org>; Mon, 15 Mar 2021 21:35:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230021AbhCOVe5 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 15 Mar 2021 17:34:57 -0400
Received: from mx1.polytechnique.org ([129.104.30.34]:52895 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233137AbhCOVeu (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 15 Mar 2021 17:34:50 -0400
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id AFFC2564B8A
        for <selinux@vger.kernel.org>; Mon, 15 Mar 2021 22:34:48 +0100 (CET)
Received: by mail-pg1-f170.google.com with SMTP id n10so21248191pgl.10
        for <selinux@vger.kernel.org>; Mon, 15 Mar 2021 14:34:48 -0700 (PDT)
X-Gm-Message-State: AOAM5324E8YvJ4jnsJtrLZhtrTYtP0s4IsFUKuwS5ZBMJsmWlI0NIdBt
        Zr34v4CkL2tl+8hXRX4rAG2rMr+9OChBQMNoHWM=
X-Google-Smtp-Source: ABdhPJyxl0LSHvPDFuRt+ngRZNumz/+aaxIn1P1hSfPIhyTqYeKSiEHNLvTBUz2OJO3OVrrFylm0Oy9NqM8bLpC336g=
X-Received: by 2002:a62:5cc3:0:b029:203:54be:e4c9 with SMTP id
 q186-20020a625cc30000b029020354bee4c9mr11901285pfb.80.1615844087430; Mon, 15
 Mar 2021 14:34:47 -0700 (PDT)
MIME-Version: 1.0
References: <20210314201651.474432-1-nicolas.iooss@m4x.org> <CAP+JOzThBfc5-JtYYuPfhBHX6phxWMCJksy8WPggDiDFJyTpaw@mail.gmail.com>
In-Reply-To: <CAP+JOzThBfc5-JtYYuPfhBHX6phxWMCJksy8WPggDiDFJyTpaw@mail.gmail.com>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Mon, 15 Mar 2021 22:34:36 +0100
X-Gmail-Original-Message-ID: <CAJfZ7==YxFEzOidB4E6SpSEHPdF=9eX2YROXjX_-H4Fi1MU=gA@mail.gmail.com>
Message-ID: <CAJfZ7==YxFEzOidB4E6SpSEHPdF=9eX2YROXjX_-H4Fi1MU=gA@mail.gmail.com>
Subject: Re: [PATCH 1/6] libsepol/cil: fix out-of-bound read of a file context
 pattern ending with "\"
To:     James Carter <jwcart2@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Mon Mar 15 22:34:49 2021 +0100 (CET))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Mar 15, 2021 at 10:02 PM James Carter <jwcart2@gmail.com> wrote:
>
> On Sun, Mar 14, 2021 at 4:23 PM Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
> >
> > OSS-Fuzz found a Heap-buffer-overflow in the CIL compiler when trying to
> > compile the following policy:
> >
> >     (sid SID)
> >     (sidorder(SID))
> >     (filecon "\" any ())
> >     (filecon "" any ())
> >
> > When cil_post_fc_fill_data() processes "\", it goes beyond the NUL
> > terminator of the string. Fix this by returning when '\0' is read after
> > a backslash.
> >
> > Fixes: https://bugs.chromium.org/p/oss-fuzz/issues/detail?id=28484
> > Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
> > ---
> >  libsepol/cil/src/cil_post.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/libsepol/cil/src/cil_post.c b/libsepol/cil/src/cil_post.c
> > index a55df1ea5bb0..5f9cf4efd242 100644
> > --- a/libsepol/cil/src/cil_post.c
> > +++ b/libsepol/cil/src/cil_post.c
> > @@ -179,6 +179,12 @@ void cil_post_fc_fill_data(struct fc_data *fc, char *path)
> >                         break;
> >                 case '\\':
> >                         c++;
>
> The patch below is fine, but I can't figure out the reason for the
> line above. I guess it means that fc->str_len++ will be skipped, but
> if that is the purpose, it is not very clear. Does anyone know if this
> is correct?

Which line? "break;" ? In case you and/or other people are confused
about the code in cil_post_fc_fill_data, this "break;" exits the
switch(path[c]) block but still executes the lines right after
("fc->str_len++;" and "c++;"):

while (path[c] != '\0') {
    switch (path[c]) {
    case '.':
    /* ... */
    case '{':
        fc->meta = 1;
        break;
    case '\\':
        c++;
        /* FALLTHRU */
    default:
// This code is executed for every character before a special one
// (while "meta" is false)
// and "\c" counts as a single character, for c being anything.
        if (!fc->meta) {
            fc->stem_len++;
        }
        break;
    }
// These lines are executed for every character.
// "str_len" counts the number of unescaped characters
// ("\c" counts as a single character)
    fc->str_len++;
    c++;
}

In my opinion, the code looks correct, but this could be verified with
a new unit test which could computes str_len and stem_len for some
strings.

Cheers,
Nicolas

