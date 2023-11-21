Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E30AC61D92
	for <selinux@archiver.kernel.org>; Tue, 21 Nov 2023 14:10:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234040AbjKUOKi (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 21 Nov 2023 09:10:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234127AbjKUOKh (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 21 Nov 2023 09:10:37 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF82C10DE
        for <selinux@vger.kernel.org>; Tue, 21 Nov 2023 06:10:32 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-507962561adso8160461e87.0
        for <selinux@vger.kernel.org>; Tue, 21 Nov 2023 06:10:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700575831; x=1701180631; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CG9D2a9D5/GMt0cOL8nRiDtygBtF9JpnHne+17QFuts=;
        b=DjOX6/u0ev4QRgSFtcUxsoDQ/6rY3+X2m8LqBl95gdqhYs4cMJVr5h5y5aT/eEIVeQ
         8Il+kDKG1OSncVXVZCOjG+kJ1OQsoqoqqS2sWFsfZBnpt9T8VcWL813tlP8FiKvv+OMg
         ZzpynmVvwuiS8P6r9PmVLMixWOkcUzZxgRYeq6PZURKQC8x88uCp2H2V/21GCQbHbPLb
         9PLmyrZEJ8rCWRn22yCFTV6njXf4DYISwFbrFzKOYwAIDsioT06lKSurJ1HsR2gDDDx2
         1CXQJCDKUvCPbfObzlG3riRvT1QYj8anC5QN41RTPkJFzLrAYbdIWpxyk02eMUsfSjju
         jZvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700575831; x=1701180631;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CG9D2a9D5/GMt0cOL8nRiDtygBtF9JpnHne+17QFuts=;
        b=nehxf6pYPNA3U4ifO0r/F56Nb2rsaJc26EF61ngM0q3hFBblzfmv4hkkETLnQD3uXS
         bGu8bMbwfi5p8NZEkQA0GZOuGLZv0UZvJjsenQ5Mt0K/0qr0fIiU5HbN3SiWm/4kOxnp
         rPS+R9dY/bizkYMwwqvhSXRN98OXeOrd7OXsv5JhMyI73lNqx6Gbig/1dnmLHcGhVaL7
         V37DRWcx27X5fUG4Fg1oQumhqxdSdCCc8VFH45VFX4ddGqo8DuXIRh//mQG39kJcbCo6
         7TCCJtP4Tb1jhizUrlwmrkTpm375J4TUs+H77MsTTi1EiSEucgB+S0UL0hpkgsdAKL8n
         2OsA==
X-Gm-Message-State: AOJu0YzUcHWlTZrk0L/QyZuD8RZv7LRQYibsM8W2DnNeWpGg2BRn6Lii
        U5lHpoUglYVgkakQ+8ecdbXGHPmYbqSwIRZxgG6P1a9p
X-Google-Smtp-Source: AGHT+IEYFpp7mXrzS4ZAkKugdXhFq1YRsbd1+fJtWai15hPpUnx7tSa6yhvY9XuwILL9Ry/0Wu+tNkRivrJXE01Y78c=
X-Received: by 2002:a05:6512:485b:b0:4fe:1681:9377 with SMTP id
 ep27-20020a056512485b00b004fe16819377mr7599853lfb.44.1700575830630; Tue, 21
 Nov 2023 06:10:30 -0800 (PST)
MIME-Version: 1.0
References: <20230927190021.1164278-1-jwcart2@gmail.com> <20230927190021.1164278-2-jwcart2@gmail.com>
 <4b23ff1b-6b93-f21b-26f4-193efcd9db93@linux.microsoft.com>
 <CAP+JOzQA64fXdpow02ZDy9rcDx48v3jq2VGiSuG4akNVDn3xvQ@mail.gmail.com>
 <2c0b5552-84b8-fe63-6d4c-0a42c7b8a753@linux.microsoft.com>
 <87a5rxhknz.fsf@redhat.com> <CAP+JOzTSnP3xDK5uA2Cy0R2FSWbyb_H9UeNMsKtUKaVXwxL33w@mail.gmail.com>
In-Reply-To: <CAP+JOzTSnP3xDK5uA2Cy0R2FSWbyb_H9UeNMsKtUKaVXwxL33w@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Tue, 21 Nov 2023 09:10:19 -0500
Message-ID: <CAP+JOzTq3iSJ_bN6SfPGJsx+=9y+3V91BPBFer53CNEUoD6A1A@mail.gmail.com>
Subject: Re: [PATCH 1/9] libsepol/cil: Use struct cil_db * instead of void *
To:     Petr Lautrbach <lautrbach@redhat.com>
Cc:     Daniel Burgener <dburgener@linux.microsoft.com>,
        selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Nov 17, 2023 at 10:29=E2=80=AFAM James Carter <jwcart2@gmail.com> w=
rote:
>
> On Wed, Nov 1, 2023 at 5:45=E2=80=AFAM Petr Lautrbach <lautrbach@redhat.c=
om> wrote:
> >
> > Daniel Burgener <dburgener@linux.microsoft.com> writes:
> >
> > > On 9/27/2023 4:41 PM, James Carter wrote:
> > >> On Wed, Sep 27, 2023 at 3:27=E2=80=AFPM Daniel Burgener
> > >> <dburgener@linux.microsoft.com> wrote:
> > >>>
> > >>>> @@ -3661,21 +3615,17 @@ static int cil_check_for_bad_inheritance(s=
truct cil_tree_node *node)
> > >>>>        return rc;
> > >>>>    }
> > >>>>
> > >>>> -static int __cil_resolve_ast_node(struct cil_tree_node *node, voi=
d *extra_args)
> > >>>> +static int __cil_resolve_ast_node(struct cil_tree_node *node, str=
uct cil_args_resolve *args)
> > >>>>    {
> > >>>>        int rc =3D SEPOL_OK;
> > >>>> -     struct cil_args_resolve *args =3D extra_args;
> > >>>> +     struct cil_db *db =3D args->db;
> > >>>>        enum cil_pass pass =3D 0;
> > >>>>
> > >>>> -     if (node =3D=3D NULL || args =3D=3D NULL) {
> > >>>> -             goto exit;
> > >>>> -     }
> > >>>> -
> > >>>
> > >>> Is deleting the "node =3D=3D NULL" part of this check intended here=
?  It
> > >>> seems unrelated to the rest of the commit, and it's not locally obv=
ious
> > >>> that it's safe.
> > >>
> > >> You are right. It is not related to the rest of the commit. There ar=
e
> > >> a bunch of these sorts of checks that are useless and really annoy m=
e.
> > >> The function __cil_resolve_ast_node() is called once from
> > >> __cil_resolve_ast_node_helper() and neither node nor args can be NUL=
L.
> > >> Since I was changing something nearby, I guess I couldn't resist. I
> > >> can leave it in, if people prefer. It doesn't cause any harm, other
> > >> than annoying me.
> > >>
> > >
> > > As is is fine by me.  Your explanation makes sense.  I mostly wanted =
to
> > > make sure it was reasoned out rather than an accidental drop, but now
> > > that you point it out, it does look impossible for this to be NULL.
> > >
> > > Reviewed-by: Daniel Burgener <dburgener@linux.microsoft.com>
> >
> > Acked-by: Petr Lautrbach <lautrbach@redhat.com>
> >
> >
> > Petr
> >
>
> I plan on merging this series next week, unless someone objects.
> Jim

These nine patches have been merged.
Jim
