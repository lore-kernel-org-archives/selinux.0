Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6CCACCA478
	for <selinux@archiver.kernel.org>; Thu,  2 Jun 2022 13:04:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233152AbiFBNEZ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 2 Jun 2022 09:04:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235132AbiFBNEY (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 2 Jun 2022 09:04:24 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48D1F6CF5D
        for <selinux@vger.kernel.org>; Thu,  2 Jun 2022 06:04:22 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id r65so6405009oia.9
        for <selinux@vger.kernel.org>; Thu, 02 Jun 2022 06:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=2V9ah5j3vUk8wjtlEWKqSqK1r2N1+px8zKTyjMuacRA=;
        b=DvoV2ly1BKJaedZWDb9ibD4Z/BHDc6AsuN9l15W0BJ52CWX34ZiXp2k9n/ivsQOLMJ
         2P44bZXjmmmiqaXmkRCbpL+U1w7xHaOi5v7zjPAXnD7kZ7l1gu91HCTTrKHgrEYjNb9w
         YL6mvdAsU1Rb2FT9gd4kR3WYMPc+QVGFV+7TfqpatLV9WwCx3z2yu5uuLdaM+it0KP2f
         xEMcJ4fNAfSXuxKarystYwMw5H/unqtmTFGqZ0KvcBmnO+RE7ssMKdgJHiGSWIjvCdJI
         bgwS59DbaBTvtX4naQ2emPyhvHyRhmuGM86cBRB5V4msVfyMS3YBdxGb1ZHd1uDKRQiR
         HHMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=2V9ah5j3vUk8wjtlEWKqSqK1r2N1+px8zKTyjMuacRA=;
        b=lgEIVxP5Bef/gF6HSDrwM48OPv/cOoGVwN7Ck1rBWhRZyGXZOr9Jg4Xuz7ifYLfUQW
         dnguZu3/RUinXmFq5IzUpEDT4OH6ZkC580LAflZKecAvu1irzMecPkCsLCUiNqZWh54l
         lkTyAAsEmUNeMZVIdbX+1pvchBcMAiw38Ura/RXaXA1geUdz+VK1zVouUUEzRd1P3wNs
         puXREhzvOTSraNZ1cOXpP2AQvbogzEsmOjgwpi6hzXOSsPek2qpAIVdORI+xnZB4jrQL
         RTSbisuP6LlH+Ouo+WJihS4s1U7+sEVsxRrdCqBvYfEeoRXOUPQURJk62KiM4QPgCAhL
         41oA==
X-Gm-Message-State: AOAM533Yc4pAkn1wLYgcUrC6Y0khsmcNBPeGGzjvIqiVkJmGhsEi1wc5
        BcLT7nlHhqtFSCh8Hcy2iv9wXT4jAG4gCyxPxZQ=
X-Google-Smtp-Source: ABdhPJyWBGHa+Uam25nKgwJsSI8IS3nOKyG6SoxA+b2e/TDBkb1uRAYvqWCF0HpHoz5fw7UHriC0gLobxORMbtVqJfk=
X-Received: by 2002:a05:6808:ec5:b0:2f9:a7fb:4dfb with SMTP id
 q5-20020a0568080ec500b002f9a7fb4dfbmr18306348oiv.156.1654175061583; Thu, 02
 Jun 2022 06:04:21 -0700 (PDT)
MIME-Version: 1.0
References: <20220520131610.11867-1-cgzones@googlemail.com> <CAJfZ7=k5BqgsVgMt1=M69bPUrfh7+6c3oijoi-eUNsWCxM=j2A@mail.gmail.com>
In-Reply-To: <CAJfZ7=k5BqgsVgMt1=M69bPUrfh7+6c3oijoi-eUNsWCxM=j2A@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Thu, 2 Jun 2022 09:04:10 -0400
Message-ID: <CAP+JOzTnajCuoXh7peCeCdmY0A8MJg2S1z_U845mUCZafPCEpQ@mail.gmail.com>
Subject: Re: [PATCH] libselinux: declare return value of context_str(3) const
To:     Nicolas Iooss <nicolas.iooss@m4x.org>
Cc:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Sun, May 29, 2022 at 8:54 PM Nicolas Iooss <nicolas.iooss@m4x.org> wrote=
:
>
> On Fri, May 20, 2022 at 3:16 PM Christian G=C3=B6ttsche
> <cgzones@googlemail.com> wrote:
> >
> > context_str(3) returns a string representation of the given context.
> > This string is owned by the context and free'd on context_free(3).
> > Declare it const, as already done in the man page, since it must not be
> > free'd by the caller.
> >
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Acked-by: Nicolas Iooss <nicolas.iooss@m4x.org>
>

Merged.
Thanks,
Jim

> Thanks!
>
> > ---
> >  libselinux/include/selinux/context.h |  2 +-
> >  libselinux/src/context.c             |  2 +-
> >  libselinux/src/get_context_list.c    | 11 ++++++-----
> >  libselinux/src/query_user_context.c  |  2 +-
> >  policycoreutils/newrole/newrole.c    |  2 +-
> >  5 files changed, 10 insertions(+), 9 deletions(-)
> >
> > diff --git a/libselinux/include/selinux/context.h b/libselinux/include/=
selinux/context.h
> > index 949fb1e1..82f4e690 100644
> > --- a/libselinux/include/selinux/context.h
> > +++ b/libselinux/include/selinux/context.h
> > @@ -25,7 +25,7 @@ extern "C" {
> >   * for the same context_t*
> >   */
> >
> > -       extern char *context_str(context_t);
> > +       extern const char *context_str(context_t);
> >
> >  /* Free the storage used by a context */
> >         extern void context_free(context_t);
> > diff --git a/libselinux/src/context.c b/libselinux/src/context.c
> > index b2144c7c..9dddbc5a 100644
> > --- a/libselinux/src/context.c
> > +++ b/libselinux/src/context.c
> > @@ -116,7 +116,7 @@ void context_free(context_t context)
> >  /*
> >   * Return a pointer to the string value of the context.
> >   */
> > -char *context_str(context_t context)
> > +const char *context_str(context_t context)
> >  {
> >         context_private_t *n =3D context->ptr;
> >         int i;
> > diff --git a/libselinux/src/get_context_list.c b/libselinux/src/get_con=
text_list.c
> > index cfe38e59..d774b9cf 100644
> > --- a/libselinux/src/get_context_list.c
> > +++ b/libselinux/src/get_context_list.c
> > @@ -143,6 +143,7 @@ static int get_context_user(FILE * fp,
> >         char *linerole, *linetype;
> >         char **new_reachable =3D NULL;
> >         char *usercon_str;
> > +       const char *usercon_str2;
> >         context_t con;
> >         context_t usercon;
> >
> > @@ -257,20 +258,20 @@ static int get_context_user(FILE * fp,
> >                         rc =3D -1;
> >                         goto out;
> >                 }
> > -               usercon_str =3D context_str(usercon);
> > -               if (!usercon_str) {
> > +               usercon_str2 =3D context_str(usercon);
> > +               if (!usercon_str2) {
> >                         context_free(usercon);
> >                         rc =3D -1;
> >                         goto out;
> >                 }
> >
> >                 /* check whether usercon is already in reachable */
> > -               if (is_in_reachable(*reachable, usercon_str)) {
> > +               if (is_in_reachable(*reachable, usercon_str2)) {
> >                         context_free(usercon);
> >                         start =3D end;
> >                         continue;
> >                 }
> > -               if (security_check_context(usercon_str) =3D=3D 0) {
> > +               if (security_check_context(usercon_str2) =3D=3D 0) {
> >                         new_reachable =3D realloc(*reachable, (*nreacha=
ble + 2) * sizeof(char *));
> >                         if (!new_reachable) {
> >                                 context_free(usercon);
> > @@ -278,7 +279,7 @@ static int get_context_user(FILE * fp,
> >                                 goto out;
> >                         }
> >                         *reachable =3D new_reachable;
> > -                       new_reachable[*nreachable] =3D strdup(usercon_s=
tr);
> > +                       new_reachable[*nreachable] =3D strdup(usercon_s=
tr2);
> >                         if (new_reachable[*nreachable] =3D=3D NULL) {
> >                                 context_free(usercon);
> >                                 rc =3D -1;
> > diff --git a/libselinux/src/query_user_context.c b/libselinux/src/query=
_user_context.c
> > index b8125c96..29a1b360 100644
> > --- a/libselinux/src/query_user_context.c
> > +++ b/libselinux/src/query_user_context.c
> > @@ -115,7 +115,7 @@ int manual_user_enter_context(const char *user, cha=
r ** newcon)
> >         int mls_enabled =3D is_selinux_mls_enabled();
> >
> >         context_t new_context;  /* The new context chosen by the user  =
   */
> > -       char *user_context =3D NULL;      /* String value of the user's=
 context     */
> > +       const char *user_context =3D NULL;        /* String value of th=
e user's context     */
> >         int done =3D 0;           /* true if a valid sid has been obtai=
ned  */
> >
> >         /* Initialize the context.  How this is done depends on whether
> > diff --git a/policycoreutils/newrole/newrole.c b/policycoreutils/newrol=
e/newrole.c
> > index ae37d725..c2afa37e 100644
> > --- a/policycoreutils/newrole/newrole.c
> > +++ b/policycoreutils/newrole/newrole.c
> > @@ -842,7 +842,7 @@ static int parse_command_line_arguments(int argc, c=
har **argv, char *ttyn,
> >         char *type_ptr =3D NULL;  /* stores malloc'd data from get_defa=
ult_type */
> >         char *level_s =3D NULL;   /* level spec'd by user in argv[] */
> >         char *range_ptr =3D NULL;
> > -       char *new_con =3D NULL;
> > +       const char *new_con =3D NULL;
> >         char *tty_con =3D NULL;
> >         context_t context =3D NULL;       /* manipulatable form of new_=
context */
> >         const struct option long_options[] =3D {
> > --
> > 2.36.1
> >
>
