Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D5C7CDB46E
	for <selinux@archiver.kernel.org>; Thu, 12 Oct 2023 17:51:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347352AbjJLRv1 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 12 Oct 2023 13:51:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379681AbjJLRv0 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 12 Oct 2023 13:51:26 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 631B1E6
        for <selinux@vger.kernel.org>; Thu, 12 Oct 2023 10:51:22 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-50437c618b4so1597395e87.2
        for <selinux@vger.kernel.org>; Thu, 12 Oct 2023 10:51:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697133080; x=1697737880; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hSQp/cV9jKMkTbaJdCHUNqcijktN0djosyYLhRIVft0=;
        b=GC4Jn/I43rXRG0HyhDyEqKZNp9y06zVZu00J70BAchmVNzjd0qyswaKTLlmJGHDuOZ
         BQ8Bhalc7IDfZ1XCcjVtC/MpwQHrFku1mIOH+Hz/b8IUwWUgipJ7WEM6uN+oiavKlpUA
         wr9vBkUGKk7AUcYxVtqBVIXWKSwemA6ydLeOF8Wrg/3k5BQU7bDbcOFnpj63W3hnNJGB
         nxKdxad3+hbFUBEcP8ahL2XT/RFYfQkUv+ip77tM87fYsztj+uHxiiI78+IZCJD5vvOU
         RpiH6YytNzKyq8+3Iy8Kv3d9BxlZle0QsWD+0/cpqgqcuo2QVdOJ0F8A952yIRxZY0H4
         aCEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697133080; x=1697737880;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hSQp/cV9jKMkTbaJdCHUNqcijktN0djosyYLhRIVft0=;
        b=OArGw/pithmXAM3xTyBict5PCp6YasQlEd6Kj/ZDWZLAlbYOLTsGqtYXE7YyOTgfOW
         oNMpYE+0j5TkfaiJtN6YVC5uE2QrUOaHJGSJGlSdhuYtEWdv3Ho9ZZigWywdRxcvFaW8
         RSj3Ys3BcoxDwhIopOPnJekvXq/tkJb4EZGrkfLYFRV4fgds4CO36iUsjwhonwA/DZ0/
         bghdhoRIZbYr98yOb8tLfArHUNJLnvTYsqrCWfkiWMHcsMv5zRYQcgZTRoek/V4FuGBg
         9guGoFqmODvL1aytCbkaw0Q5sI4eUZSAl/6mv6P0FTmDsV65+10jNV2zMIALiKALc3aM
         dkPA==
X-Gm-Message-State: AOJu0Yxv98yKCCtAXzF3doCCwgcUHyZ/5mCGeCX/a4H3x2IfOl+LrIeF
        GlxPCOJ954kxEfDw0nadppoiGFmCcRpWov16IE2p2nJS
X-Google-Smtp-Source: AGHT+IESesEemNyZ3Xx7kiC118aO6p8yp5MEL41Jtz6OfHzyzXekNTV6Aahc/As2PPinMh76/80U6Jdl0HwKsZrFXl8=
X-Received: by 2002:a19:644a:0:b0:502:9a2c:f766 with SMTP id
 b10-20020a19644a000000b005029a2cf766mr19892254lfj.30.1697133080295; Thu, 12
 Oct 2023 10:51:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230816190934.729086-1-jwcart2@gmail.com> <87ttsyktct.fsf@redhat.com>
In-Reply-To: <87ttsyktct.fsf@redhat.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Thu, 12 Oct 2023 13:51:08 -0400
Message-ID: <CAP+JOzTti2MQr55V6mvRPCfKOeAjE_M6KGNVH-biJxo=QfmiiA@mail.gmail.com>
Subject: Re: [PATCH] libsepol: Fix the version number for the latest exported function
To:     Petr Lautrbach <lautrbach@redhat.com>
Cc:     selinux@vger.kernel.org, cgzones@googlemail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Aug 17, 2023 at 3:42=E2=80=AFAM Petr Lautrbach <lautrbach@redhat.co=
m> wrote:
>
> James Carter <jwcart2@gmail.com> writes:
>
> > cil_write_post_ast() should be in libsepol version 3.6, since version
> > 3.5 has already been released.
> >
> > Signed-off-by: James Carter <jwcart2@gmail.com>
>
> Acked-by: Petr Lautrbach <lautrbach@redhat.com>
>

Merged.
Thanks,
Jim

> > ---
> >  libsepol/src/libsepol.map.in | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/libsepol/src/libsepol.map.in b/libsepol/src/libsepol.map.i=
n
> > index 6ad68f0b..e5e6608c 100644
> > --- a/libsepol/src/libsepol.map.in
> > +++ b/libsepol/src/libsepol.map.in
> > @@ -290,7 +290,7 @@ LIBSEPOL_3.4 {
> >       sepol_validate_transition_reason_buffer;
> >  } LIBSEPOL_3.0;
> >
> > -LIBSEPOL_3.5 {
> > +LIBSEPOL_3.6 {
> >    global:
> >       cil_write_post_ast;
> >  } LIBSEPOL_3.4;
> > --
> > 2.41.0
>
