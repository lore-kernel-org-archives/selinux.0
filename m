Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 285FDC433EF
	for <selinux@archiver.kernel.org>; Thu, 27 Jan 2022 15:31:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235398AbiA0Pbn (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 27 Jan 2022 10:31:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229985AbiA0Pbn (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 27 Jan 2022 10:31:43 -0500
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BB69C061714
        for <selinux@vger.kernel.org>; Thu, 27 Jan 2022 07:31:43 -0800 (PST)
Received: by mail-oi1-x22f.google.com with SMTP id u129so6506813oib.4
        for <selinux@vger.kernel.org>; Thu, 27 Jan 2022 07:31:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Nw2X/tEDIyIXRIZkGyQfkHqUKNOWHnLDc7e0m4QD/tM=;
        b=VvjoqDt6RBuyMzviAj+Bq+zZ4vBCFGYSiG6KQJO4rgeXBIrU1E5mulT7t0UbSRjWf0
         EFQaSjI0Ht4FPHdZPLyat3eX7YkQ+A1WsQCnizmD2NwuVONahPwieQ6ySje7Iul/X+1i
         ON7qX8ttGyBTT+4VMzC/p6Lyx8eDSRoBn/gxwrSWZGGwGz591Rtc18qD6CMyZIeXeOjY
         M7p2oy13ieQqOSdkk7Pj6ZHIYFA8Mp7g3Nfd925/HjUWpscWh+L1E1EGjKMzBG4608NO
         i0B+B5Zljj34UIRcU6mMwEygfGdHctlo8CoTYeSc2Uqt5M7jtTQ3zptOobDmKHjGhbrm
         qqUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Nw2X/tEDIyIXRIZkGyQfkHqUKNOWHnLDc7e0m4QD/tM=;
        b=eAlri0HTGeKO0+dW9VKRzm8yi7TKOuKeqnVVdi8dmbrF+TiDUqie0Rlgb3neX+YSF6
         KeikiS7QuO+custDy+r8Kv75kywoSTBP7Fb0eXVu5x/JVEh2+4a8QAKfF70soln78TEA
         I5VP4SNuGbcofn6mHYO8VXpjvqJAuOuvuwkQcOlxp8PsMvGxCEPOB3KRJ4sKXe+urUC9
         sk+iRZafib7SHzDpc5m52wBWnJIkptDxV2xC00w0aGOgmuKe+gHxeLlyM+5DGcqhcErf
         85FIXnQ+unngGiUE424ASidj4slwzB60UjerSq2MUXB6BG6Rhko26HxuTuonLfcP8vTJ
         lOTw==
X-Gm-Message-State: AOAM530OUeVOuEXmEFGrP1OYA2nm4BfrXG6yoILbwq7YPLLZRh4NtzxT
        ZwI6Ckmvfp5yeKASqOd/wWnimp5OqLQin/MOPSU=
X-Google-Smtp-Source: ABdhPJzZQhob7yYflPp/1yFxzYT+EYzlx1q3vo7GVSkc/iXWQkYdFMNMt/Lcy9dsdcjVqv+pK1RgPdhWTBqxNv2NGk0=
X-Received: by 2002:a05:6808:1147:: with SMTP id u7mr7074653oiu.189.1643297502578;
 Thu, 27 Jan 2022 07:31:42 -0800 (PST)
MIME-Version: 1.0
References: <20220125135022.25513-1-cgzones@googlemail.com> <CAP+JOzRoFHqKKVSvgFirT+hscVfZtejRKkxPdPBbAjz1nKTYGw@mail.gmail.com>
In-Reply-To: <CAP+JOzRoFHqKKVSvgFirT+hscVfZtejRKkxPdPBbAjz1nKTYGw@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Thu, 27 Jan 2022 10:31:31 -0500
Message-ID: <CAP+JOzTTtPhHNFv8hA__6Jo-nEjPy1xuX+0EnvPifvbv2KDHpA@mail.gmail.com>
Subject: Re: [PATCH] libsepol: invert only valid range of role bitmap
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Jan 25, 2022 at 4:17 PM James Carter <jwcart2@gmail.com> wrote:
>
> On Tue, Jan 25, 2022 at 2:46 PM Christian G=C3=B6ttsche
> <cgzones@googlemail.com> wrote:
> >
> > The length of an ebitmap is the current highest allocated (not set) bit
> > and always a multiple of MAPTYPE (=3D 64). The role ebitmap should only
> > have valid role bits set, even after inverting. The length might be
> > smaller than the maximum number of defined roles leading to non defined
> > role bits set afterwards.
> > Only invert up to the number of roles defined instead the full ebitmap
> > length, similar to type_set_expand().
> >
> > This also avoids timeouts on an invalid huge highbit set, since the
> > ebitmap has not been validated yet, on which inverting will take
> > excessive amount of memory and time, found by oss-fuzz (#43709).
> >
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Acked-by: James Carter <jwcart2@gmail.com>
>

Merged.
Thanks,
Jim

> > ---
> > This patch supersedes "libsepol: reject invalid roles before inverting"
> > https://patchwork.kernel.org/project/selinux/patch/20220117150200.24953=
-1-cgzones@googlemail.com/
> > ---
> >  libsepol/src/expand.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/libsepol/src/expand.c b/libsepol/src/expand.c
> > index 898e6b87..df8683ef 100644
> > --- a/libsepol/src/expand.c
> > +++ b/libsepol/src/expand.c
> > @@ -2481,7 +2481,7 @@ int role_set_expand(role_set_t * x, ebitmap_t * r=
, policydb_t * out, policydb_t
> >
> >         /* if role is to be complimented, invert the entire bitmap here=
 */
> >         if (x->flags & ROLE_COMP) {
> > -               for (i =3D 0; i < ebitmap_length(r); i++) {
> > +               for (i =3D 0; i < p->p_roles.nprim; i++) {
> >                         if (ebitmap_get_bit(r, i)) {
> >                                 if (ebitmap_set_bit(r, i, 0))
> >                                         return -1;
> > --
> > 2.34.1
> >
