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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B261BC433DB
	for <selinux@archiver.kernel.org>; Wed, 17 Mar 2021 14:36:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 698BF64F26
	for <selinux@archiver.kernel.org>; Wed, 17 Mar 2021 14:36:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231849AbhCQOf4 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 17 Mar 2021 10:35:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231784AbhCQOff (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 17 Mar 2021 10:35:35 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4026C06174A
        for <selinux@vger.kernel.org>; Wed, 17 Mar 2021 07:35:35 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id v24-20020a9d69d80000b02901b9aec33371so1972253oto.2
        for <selinux@vger.kernel.org>; Wed, 17 Mar 2021 07:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ekT2H1fgYsTk514g0nay1e00mkuPeg84o3uNs6TArTo=;
        b=TihFXeYqOWuoo7t/G25s7M3ch39Q+9WAd/Jm8NCNEX4kPB6cp61IhHVAGuFtC7hinV
         qunDPgiXmFSI5Si2clKY/35vYZoJ41SkMjQw0oFzh0uJtqXSKQQ75Ke/y/2WUWmrvzyL
         IlZDU9j5a/PVHcEn4nGcpNQIn7zQu5MBa1WjQAf84m5vTQSQ+SFsJPTqueYkPBnHDMvA
         RGB4/wveHJOqmREB58z5ldvpxLuINZ0lTusfDjLMpH0AGyHFb2CZm4ilit9fyRE1Vhoo
         z96CmiLbsJ+avcjcUM3DMYdnUZajd3AG2a0KPZ3KG8cKXl3fg/AutQdhwkpB+SKBQI35
         LsGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ekT2H1fgYsTk514g0nay1e00mkuPeg84o3uNs6TArTo=;
        b=ieB92yRCc17Nr1UEnufTwsfZhzwpcVFBFQo/uAGkBJQ5KyBnD7VoKmmmXU9B/TZpRX
         JJcRr5aDpL6NFFRyva0rt4jV+0G8FWgWRZlHHUPQ5c8OJnUsE9SOZIy7P4JjhWwPW54+
         TGBbx/h5eS+E+QOWRsm9hTmn9J/SdTfigmOsjbwVj/g08a2HJE/PLHOYbFqFItFVjRj/
         KvA04hUfWgTeh82Fv7zk8bjJYePy9zJ1ljASH0/UVY7/LBIDCVR/wef9e9Tlol1hWvBt
         jLt1R9ap1XbyVEXynTgrVONvHo7IiR6F9KX0BRIMDZ+Xeabh82pUuD3dp1ypra72mfNM
         xh+Q==
X-Gm-Message-State: AOAM533Q12OUgzmB5vVC8D7G4iZW40bTBljA3vspXrsEBSM9rA5G2/PX
        jnIPQl24KZ4q6+LPNOeXV7RkhmlzUqOpPrkQnHtmHShm
X-Google-Smtp-Source: ABdhPJy+1uhDXTiQRcyW3hPBO33nNhqUDGiHM/aUsYxEonE1WZY+ZNiJ8/ZiwW3j1FoozfGI80eDFrr0B51AN0Tw6OE=
X-Received: by 2002:a9d:6c94:: with SMTP id c20mr3580966otr.59.1615991735216;
 Wed, 17 Mar 2021 07:35:35 -0700 (PDT)
MIME-Version: 1.0
References: <20210314201651.474432-1-nicolas.iooss@m4x.org>
 <CAP+JOzThBfc5-JtYYuPfhBHX6phxWMCJksy8WPggDiDFJyTpaw@mail.gmail.com>
 <CAJfZ7==YxFEzOidB4E6SpSEHPdF=9eX2YROXjX_-H4Fi1MU=gA@mail.gmail.com>
 <CAP+JOzRFvwFKYhqrdjy=AjLqsiprbT8p2fc-cbuPGEhSMvNFiw@mail.gmail.com> <CAJfZ7=nFZ10MTyBmWsVg_Y4HKRijo1Mrt0b-DTbfg1m-1xqdHw@mail.gmail.com>
In-Reply-To: <CAJfZ7=nFZ10MTyBmWsVg_Y4HKRijo1Mrt0b-DTbfg1m-1xqdHw@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Wed, 17 Mar 2021 10:35:24 -0400
Message-ID: <CAP+JOzSbCsMX7zSpw9_B6q85OzmBVO++6fippHR0nWpBWoQDdg@mail.gmail.com>
Subject: Re: [PATCH 1/6] libsepol/cil: fix out-of-bound read of a file context
 pattern ending with "\"
To:     Nicolas Iooss <nicolas.iooss@m4x.org>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Mar 17, 2021 at 3:45 AM Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
>
> On Tue, Mar 16, 2021 at 2:34 PM James Carter <jwcart2@gmail.com> wrote:
> >
> > On Mon, Mar 15, 2021 at 5:34 PM Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
> > >
> > > On Mon, Mar 15, 2021 at 10:02 PM James Carter <jwcart2@gmail.com> wrote:
> > > >
> > > > On Sun, Mar 14, 2021 at 4:23 PM Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
> > > > >
> > > > > OSS-Fuzz found a Heap-buffer-overflow in the CIL compiler when trying to
> > > > > compile the following policy:
> > > > >
> > > > >     (sid SID)
> > > > >     (sidorder(SID))
> > > > >     (filecon "\" any ())
> > > > >     (filecon "" any ())
> > > > >
> > > > > When cil_post_fc_fill_data() processes "\", it goes beyond the NUL
> > > > > terminator of the string. Fix this by returning when '\0' is read after
> > > > > a backslash.
> > > > >
> > > > > Fixes: https://bugs.chromium.org/p/oss-fuzz/issues/detail?id=28484
> > > > > Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
> > > > > ---
> > > > >  libsepol/cil/src/cil_post.c | 6 ++++++
> > > > >  1 file changed, 6 insertions(+)
> > > > >
> > > > > diff --git a/libsepol/cil/src/cil_post.c b/libsepol/cil/src/cil_post.c
> > > > > index a55df1ea5bb0..5f9cf4efd242 100644
> > > > > --- a/libsepol/cil/src/cil_post.c
> > > > > +++ b/libsepol/cil/src/cil_post.c
> > > > > @@ -179,6 +179,12 @@ void cil_post_fc_fill_data(struct fc_data *fc, char *path)
> > > > >                         break;
> > > > >                 case '\\':
> > > > >                         c++;
> > > >
> > > > The patch below is fine, but I can't figure out the reason for the
> > > > line above. I guess it means that fc->str_len++ will be skipped, but
> > > > if that is the purpose, it is not very clear. Does anyone know if this
> > > > is correct?
> > >
> > > Which line? "break;" ? In case you and/or other people are confused
> > > about the code in cil_post_fc_fill_data, this "break;" exits the
> > > switch(path[c]) block but still executes the lines right after
> > > ("fc->str_len++;" and "c++;"):
> > >
> >
> > Sorry, I wasn't very clear. I am wondering what the "c++" is doing
> > here because after the switch statement there is another "c++" (after
> > "fc->str_length++"), so this skips the character after the "/". Why
> > would one do that? My only thought is that maybe "/" is not supposed
> > to count towards the string length and the author thought not counting
> > the next character works just as well? Except, of course, it doesn't
> > if there is no next character.
>
> The matched character is a backslash ("\"), not a slash ("/"). I

I am an idiot. The code makes a lot more sense now. You only want to
count an escaped character as one character.

> understand that this implementation of "c++; without fc->str_len++;
> nor fc->stem_len++;" is there in order to count sequences such as
> "\(", "\.", "\["... as a single character. More precisely, when for
> example the two-character sequence "\." is encountered in a path
> (which happens often, as it is the way to escape dots in file context
> patterns):
>
> * c is increased twice ("c++;" in present twice in the while loop), in
> order to go to the character next to the sequence ;
> * fc->str_len is increased once (this sequence counts as a single
> non-special character) ;
> * if fc->meta is false (i.e. if no meta character such as ".", "(",
> "["... has been encountered yet), fc->stem_len is increased once (this
> sequence counts as a single non-special character in the "stem" of the
> path)
>
> The code I added in my patch made fc->stem_len increase when a path
> ends with "\" (the character after the backslash character is a NUL
> string terminator), before exiting cil_post_fc_fill_data. Now I am
> wondering whether fc->str_len should also be increased, in order to
> "count the backslash". In fact, finishing a path pattern with an
> incomplete escape sequence is weird and I do not precisely know the
> semantic of the length counters in such a case. What do you think?
>

I think that it is an invalid path, so maybe I need to add some sort
of verification to the path at some point.

I finally found the source of this code in
refpolicy/support/fc_sort.py where the function compute_diffdata() is
very similar. That function would increment str_len in this case, so
to be consistent with that fc->str_len should also be incremented.

Jim


> Nicolas
>
> > > while (path[c] != '\0') {
> > >     switch (path[c]) {
> > >     case '.':
> > >     /* ... */
> > >     case '{':
> > >         fc->meta = 1;
> > >         break;
> > >     case '\\':
> > >         c++;
> > >         /* FALLTHRU */
> > >     default:
> > > // This code is executed for every character before a special one
> > > // (while "meta" is false)
> > > // and "\c" counts as a single character, for c being anything.
> > >         if (!fc->meta) {
> > >             fc->stem_len++;
> > >         }
> > >         break;
> > >     }
> > > // These lines are executed for every character.
> > > // "str_len" counts the number of unescaped characters
> > > // ("\c" counts as a single character)
> > >     fc->str_len++;
> > >     c++;
> > > }
> > >
> > > In my opinion, the code looks correct, but this could be verified with
> > > a new unit test which could computes str_len and stem_len for some
> > > strings.
> > >
> > > Cheers,
> > > Nicolas
> > >
>
