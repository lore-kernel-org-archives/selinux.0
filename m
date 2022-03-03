Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07E68C433EF
	for <selinux@archiver.kernel.org>; Thu,  3 Mar 2022 18:18:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235734AbiCCSTf (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 3 Mar 2022 13:19:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235654AbiCCSTf (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 3 Mar 2022 13:19:35 -0500
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com [IPv6:2607:f8b0:4864:20::c2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A780163051
        for <selinux@vger.kernel.org>; Thu,  3 Mar 2022 10:18:49 -0800 (PST)
Received: by mail-oo1-xc2d.google.com with SMTP id w3-20020a4ac183000000b0031d806bbd7eso6680057oop.13
        for <selinux@vger.kernel.org>; Thu, 03 Mar 2022 10:18:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VAy9U9DrDe/Dx0nQ8no4bPC8Sj0XsOPD+Cz/zpJtWRc=;
        b=i1ZsWW+HlPwM8EQkBhU5qXHCTL+EysY3bcdarQannEejKY7lD0TVNJ7XUT6wH2COGs
         pf86Q6ztkR9Lsvs3ixTWP7jwQV8ZXPz44g7e2PRJfmJTVDvSW/Uw5LfAPvr8lwvn7tRQ
         xP1Cxy+6OWLv/kbjzfk0EIEKlTK3sitGI09/5OZ40vXlKVxctgqpNLIH/l4AfWHHD0x5
         uY0ENkh7MrtF0+HfDt19HFbhkN+Nk7XbiA2L1ZZE8eOIt7wr9SF+aTialyBeFY5qVyxP
         WXjg0ZoJRdDF+2IlAwuVWEC5AAUGN2mn5raC6niett3zYtbMZebjADWv82W7jixPKqkW
         CNRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VAy9U9DrDe/Dx0nQ8no4bPC8Sj0XsOPD+Cz/zpJtWRc=;
        b=eJJun+WHt1nouWItz0+QYFaIn1bvwiGl1dof0L/HLdjEXPq8cW096u1vd5w41kVudI
         PB08qxJkVOWTT8/mElAG3MBLbd4U9KU/gt5XYyU3aHrKVDCeVjp8+wdZtTyX7YncVmbt
         pUy/XAzmem5P8VO9zISnwoIG+hNeQQ93zo8HYQPFTV+ixhefAXqk2aqh2QCsGl6uh1tb
         1+YkX+2eTzQ6guL2ypIEVylSDgWWHIty0iFj7ECZULr1XwO65B0zdzxACNyyVQ5mthPo
         30GDEefZvUvgesSKCNKN9qOeRS11L/z9uABI7g3dM8I1ekOscPCildrwpn1rV6YA+P/c
         8OAA==
X-Gm-Message-State: AOAM532FvyyzhacdXKlyqhOs20MGUppWSypmwbYCF/A48b/ks/nxVTo6
        ujEow9JzpBj3OxcEhIP3v/lzW5AXkkPJwn1RGVY=
X-Google-Smtp-Source: ABdhPJxXI3ZYWuGMBD3skEHjZaABsSDrErC4viY4o1ysWVcFcTiiRAn/n2lTtP1MeiD1ByaYIQaK8eFJwYMIEVAcJ2k=
X-Received: by 2002:a05:6870:7a3:b0:d7:5fbf:37b7 with SMTP id
 en35-20020a05687007a300b000d75fbf37b7mr4971127oab.16.1646331528772; Thu, 03
 Mar 2022 10:18:48 -0800 (PST)
MIME-Version: 1.0
References: <d7cf167d-1c12-5486-336e-1689c5223631@redhat.com>
 <20220217131415.1195383-1-vmojzis@redhat.com> <CAP+JOzSX3iLRQgOEwzt1uXEV=--r77n4bUFLT6uPHeFTp=vGjQ@mail.gmail.com>
In-Reply-To: <CAP+JOzSX3iLRQgOEwzt1uXEV=--r77n4bUFLT6uPHeFTp=vGjQ@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Thu, 3 Mar 2022 13:18:38 -0500
Message-ID: <CAP+JOzRmGdkhSK5n6NELPhiYYiVqbq=eTPc92_DNh=vh8GTjAA@mail.gmail.com>
Subject: Re: [PATCH v2] libselinux: Strip spaces before values in config
To:     Vit Mojzis <vmojzis@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Feb 28, 2022 at 3:22 PM James Carter <jwcart2@gmail.com> wrote:
>
> On Thu, Feb 17, 2022 at 1:24 PM Vit Mojzis <vmojzis@redhat.com> wrote:
> >
> > Spaces before values in /etc/selinux/config should be ignored just as
> > spaces after them are.
> >
> > E.g. "SELINUXTYPE= targeted" should be a valid value.
> >
> > Fixes:
> >    # sed -i 's/^SELINUXTYPE=/SELINUXTYPE= /g' /etc/selinux/config
> >    # dnf install <any_package>
> >    ...
> >    RPM: error: selabel_open: (/etc/selinux/ targeted/contexts/files/file_contexts) No such file or directory
> >    RPM: error: Plugin selinux: hook tsm_pre failed
> >    ...
> >    Error: Could not run transaction.
> >
> > Signed-off-by: Vit Mojzis <vmojzis@redhat.com>
>
> Acked-by: James Carter <jwcart2@gmail.com>
>

Merged.
Thanks,
Jim

> > ---
> >
> > Sorry for the delay. I sent the fixed patch to a wrong mailing list.
> >
> >  libselinux/src/selinux_config.c | 17 +++++++++++++----
> >  1 file changed, 13 insertions(+), 4 deletions(-)
> >
> > diff --git a/libselinux/src/selinux_config.c b/libselinux/src/selinux_config.c
> > index 97f81a8b..d2e49ee1 100644
> > --- a/libselinux/src/selinux_config.c
> > +++ b/libselinux/src/selinux_config.c
> > @@ -92,6 +92,7 @@ int selinux_getenforcemode(int *enforce)
> >         FILE *cfg = fopen(SELINUXCONFIG, "re");
> >         if (cfg) {
> >                 char *buf;
> > +               char *tag;
> >                 int len = sizeof(SELINUXTAG) - 1;
> >                 buf = malloc(selinux_page_size);
> >                 if (!buf) {
> > @@ -101,21 +102,24 @@ int selinux_getenforcemode(int *enforce)
> >                 while (fgets_unlocked(buf, selinux_page_size, cfg)) {
> >                         if (strncmp(buf, SELINUXTAG, len))
> >                                 continue;
> > +                       tag = buf+len;
> > +                       while (isspace(*tag))
> > +                               tag++;
> >                         if (!strncasecmp
> > -                           (buf + len, "enforcing", sizeof("enforcing") - 1)) {
> > +                           (tag, "enforcing", sizeof("enforcing") - 1)) {
> >                                 *enforce = 1;
> >                                 ret = 0;
> >                                 break;
> >                         } else
> >                             if (!strncasecmp
> > -                               (buf + len, "permissive",
> > +                               (tag, "permissive",
> >                                  sizeof("permissive") - 1)) {
> >                                 *enforce = 0;
> >                                 ret = 0;
> >                                 break;
> >                         } else
> >                             if (!strncasecmp
> > -                               (buf + len, "disabled",
> > +                               (tag, "disabled",
> >                                  sizeof("disabled") - 1)) {
> >                                 *enforce = -1;
> >                                 ret = 0;
> > @@ -176,7 +180,10 @@ static void init_selinux_config(void)
> >
> >                         if (!strncasecmp(buf_p, SELINUXTYPETAG,
> >                                          sizeof(SELINUXTYPETAG) - 1)) {
> > -                               type = strdup(buf_p + sizeof(SELINUXTYPETAG) - 1);
> > +                               buf_p += sizeof(SELINUXTYPETAG) - 1;
> > +                               while (isspace(*buf_p))
> > +                                       buf_p++;
> > +                               type = strdup(buf_p);
> >                                 if (!type) {
> >                                         free(line_buf);
> >                                         fclose(fp);
> > @@ -199,6 +206,8 @@ static void init_selinux_config(void)
> >                         } else if (!strncmp(buf_p, REQUIRESEUSERS,
> >                                             sizeof(REQUIRESEUSERS) - 1)) {
> >                                 value = buf_p + sizeof(REQUIRESEUSERS) - 1;
> > +                               while (isspace(*value))
> > +                                       value++;
> >                                 intptr = &require_seusers;
> >                         } else {
> >                                 continue;
> > --
> > 2.30.2
> >
