Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EBB6C433E6
	for <selinux@archiver.kernel.org>; Wed, 17 Mar 2021 07:46:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D634C64F8B
	for <selinux@archiver.kernel.org>; Wed, 17 Mar 2021 07:46:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbhCQHqM (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 17 Mar 2021 03:46:12 -0400
Received: from mx1.polytechnique.org ([129.104.30.34]:52605 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230033AbhCQHpk (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 17 Mar 2021 03:45:40 -0400
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 2E193561257
        for <selinux@vger.kernel.org>; Wed, 17 Mar 2021 08:45:37 +0100 (CET)
Received: by mail-pj1-f48.google.com with SMTP id kk2-20020a17090b4a02b02900c777aa746fso868587pjb.3
        for <selinux@vger.kernel.org>; Wed, 17 Mar 2021 00:45:37 -0700 (PDT)
X-Gm-Message-State: AOAM5338bgv0OVfijzg70NH3jZqNf8bLFhxDzlPAsRYN25auEzaFGE3b
        bFwJHFm7W4TIdFZrhCkCdZDx0SAoErNbrEoObW4=
X-Google-Smtp-Source: ABdhPJwcmD0fEQVtjQ7dG/vp4a5DFKRa3AtIcCPY4H3aCdVQfwR0hZcV0pNSqLTIB5s19t/dQuxB5VD0TipJLTuFG2o=
X-Received: by 2002:a17:902:c952:b029:e4:89ad:fae2 with SMTP id
 i18-20020a170902c952b02900e489adfae2mr3294686pla.14.1615967135853; Wed, 17
 Mar 2021 00:45:35 -0700 (PDT)
MIME-Version: 1.0
References: <20210314201651.474432-1-nicolas.iooss@m4x.org>
 <CAP+JOzThBfc5-JtYYuPfhBHX6phxWMCJksy8WPggDiDFJyTpaw@mail.gmail.com>
 <CAJfZ7==YxFEzOidB4E6SpSEHPdF=9eX2YROXjX_-H4Fi1MU=gA@mail.gmail.com> <CAP+JOzRFvwFKYhqrdjy=AjLqsiprbT8p2fc-cbuPGEhSMvNFiw@mail.gmail.com>
In-Reply-To: <CAP+JOzRFvwFKYhqrdjy=AjLqsiprbT8p2fc-cbuPGEhSMvNFiw@mail.gmail.com>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Wed, 17 Mar 2021 08:45:24 +0100
X-Gmail-Original-Message-ID: <CAJfZ7=nFZ10MTyBmWsVg_Y4HKRijo1Mrt0b-DTbfg1m-1xqdHw@mail.gmail.com>
Message-ID: <CAJfZ7=nFZ10MTyBmWsVg_Y4HKRijo1Mrt0b-DTbfg1m-1xqdHw@mail.gmail.com>
Subject: Re: [PATCH 1/6] libsepol/cil: fix out-of-bound read of a file context
 pattern ending with "\"
To:     James Carter <jwcart2@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Wed Mar 17 08:45:37 2021 +0100 (CET))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Mar 16, 2021 at 2:34 PM James Carter <jwcart2@gmail.com> wrote:
>
> On Mon, Mar 15, 2021 at 5:34 PM Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
> >
> > On Mon, Mar 15, 2021 at 10:02 PM James Carter <jwcart2@gmail.com> wrote:
> > >
> > > On Sun, Mar 14, 2021 at 4:23 PM Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
> > > >
> > > > OSS-Fuzz found a Heap-buffer-overflow in the CIL compiler when trying to
> > > > compile the following policy:
> > > >
> > > >     (sid SID)
> > > >     (sidorder(SID))
> > > >     (filecon "\" any ())
> > > >     (filecon "" any ())
> > > >
> > > > When cil_post_fc_fill_data() processes "\", it goes beyond the NUL
> > > > terminator of the string. Fix this by returning when '\0' is read after
> > > > a backslash.
> > > >
> > > > Fixes: https://bugs.chromium.org/p/oss-fuzz/issues/detail?id=28484
> > > > Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
> > > > ---
> > > >  libsepol/cil/src/cil_post.c | 6 ++++++
> > > >  1 file changed, 6 insertions(+)
> > > >
> > > > diff --git a/libsepol/cil/src/cil_post.c b/libsepol/cil/src/cil_post.c
> > > > index a55df1ea5bb0..5f9cf4efd242 100644
> > > > --- a/libsepol/cil/src/cil_post.c
> > > > +++ b/libsepol/cil/src/cil_post.c
> > > > @@ -179,6 +179,12 @@ void cil_post_fc_fill_data(struct fc_data *fc, char *path)
> > > >                         break;
> > > >                 case '\\':
> > > >                         c++;
> > >
> > > The patch below is fine, but I can't figure out the reason for the
> > > line above. I guess it means that fc->str_len++ will be skipped, but
> > > if that is the purpose, it is not very clear. Does anyone know if this
> > > is correct?
> >
> > Which line? "break;" ? In case you and/or other people are confused
> > about the code in cil_post_fc_fill_data, this "break;" exits the
> > switch(path[c]) block but still executes the lines right after
> > ("fc->str_len++;" and "c++;"):
> >
>
> Sorry, I wasn't very clear. I am wondering what the "c++" is doing
> here because after the switch statement there is another "c++" (after
> "fc->str_length++"), so this skips the character after the "/". Why
> would one do that? My only thought is that maybe "/" is not supposed
> to count towards the string length and the author thought not counting
> the next character works just as well? Except, of course, it doesn't
> if there is no next character.

The matched character is a backslash ("\"), not a slash ("/"). I
understand that this implementation of "c++; without fc->str_len++;
nor fc->stem_len++;" is there in order to count sequences such as
"\(", "\.", "\["... as a single character. More precisely, when for
example the two-character sequence "\." is encountered in a path
(which happens often, as it is the way to escape dots in file context
patterns):

* c is increased twice ("c++;" in present twice in the while loop), in
order to go to the character next to the sequence ;
* fc->str_len is increased once (this sequence counts as a single
non-special character) ;
* if fc->meta is false (i.e. if no meta character such as ".", "(",
"["... has been encountered yet), fc->stem_len is increased once (this
sequence counts as a single non-special character in the "stem" of the
path)

The code I added in my patch made fc->stem_len increase when a path
ends with "\" (the character after the backslash character is a NUL
string terminator), before exiting cil_post_fc_fill_data. Now I am
wondering whether fc->str_len should also be increased, in order to
"count the backslash". In fact, finishing a path pattern with an
incomplete escape sequence is weird and I do not precisely know the
semantic of the length counters in such a case. What do you think?

Nicolas

> > while (path[c] != '\0') {
> >     switch (path[c]) {
> >     case '.':
> >     /* ... */
> >     case '{':
> >         fc->meta = 1;
> >         break;
> >     case '\\':
> >         c++;
> >         /* FALLTHRU */
> >     default:
> > // This code is executed for every character before a special one
> > // (while "meta" is false)
> > // and "\c" counts as a single character, for c being anything.
> >         if (!fc->meta) {
> >             fc->stem_len++;
> >         }
> >         break;
> >     }
> > // These lines are executed for every character.
> > // "str_len" counts the number of unescaped characters
> > // ("\c" counts as a single character)
> >     fc->str_len++;
> >     c++;
> > }
> >
> > In my opinion, the code looks correct, but this could be verified with
> > a new unit test which could computes str_len and stem_len for some
> > strings.
> >
> > Cheers,
> > Nicolas
> >

