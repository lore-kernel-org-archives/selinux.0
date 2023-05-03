Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C116EC77B78
	for <selinux@archiver.kernel.org>; Wed,  3 May 2023 16:23:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229506AbjECQXW (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 3 May 2023 12:23:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjECQXV (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 3 May 2023 12:23:21 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E96F4EEC
        for <selinux@vger.kernel.org>; Wed,  3 May 2023 09:23:20 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2ac770a99e2so7495641fa.3
        for <selinux@vger.kernel.org>; Wed, 03 May 2023 09:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683130999; x=1685722999;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WtRx1xyyefH3XzE3f265szyGfoZ/quUk92nZi8qZUjY=;
        b=sWBOhZjhhidkUJK0Ie9YIkN7zPYr8IolwZjdidhRMLyKJp2DhBJ8BKNVMOmh732f7C
         tdAkH2g/APePOeXofqOS5WFbN3NnhG65hLOcWnml8qUSOpyD7wsjHsC8Dm/DsdWqT7PO
         adPay8yqxomkIfFgwfDaHX9/NNK/DtcTUZN8Qi9CIYnWcZp+N3c6FWfgPchqLyznWFFC
         eBLdeeEURII+Xs9CVgHjrEQHNxir9JJGBlbUYtDbWbHFyOoY08oEmFPvOW5eZHLoCCu8
         PtZwS7jM+Q2GU0j1V9g6sQUOGS5+hYCgHFNENc4An4GxmN0PTltGsB2zbo9kn20SrPyR
         hI2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683130999; x=1685722999;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WtRx1xyyefH3XzE3f265szyGfoZ/quUk92nZi8qZUjY=;
        b=Q+JA/wqvXhBbVbj1EsxAlOQ41HthffIfU9BPq2dQAhZXVDCBOsKm1wjEfQBlko0fPj
         XwfcYpNO24ICF558BbQze2FnKmJABAKfgiKb/xQ0UOWS/G+//eeeTncDhvjkxipssA+A
         MJTPH5BgwdgqX/EVpi0Tjv9C1m/2JY4KspaHRLbtVT5/rY6/hPOFrSwre1ORDkoezqpv
         3N9WxIX8yKGAxdX9giwQNYWgt39htDF+oFch0dgFDraI2xITHdL0UTLfTo5ChQaP0PCh
         uWFfsmeZ3sn4RVXp0UO6wb7T3ZbNyLTnafHb4YPEMVlcKuGevuyCt+UUzVgDZVtEWqbC
         R2pQ==
X-Gm-Message-State: AC+VfDyUTDPAmAtyirgeyp6Ny52EOTzihNwGGOC+N60/4YvIXFFEod9q
        5HdWauzbCYVv0T6azh4cQaTV34HLVL8Beb2wU2BjX1u8
X-Google-Smtp-Source: ACHHUZ4JNBaeztYJot/boTu8trG6o63jvQaC5+mNIeCY6W0s1VRjNgzJjNSDIRCmoE8DWWR66u0aU+Jkmqmg2DkHCK8=
X-Received: by 2002:ac2:55bb:0:b0:4ed:88fe:62e0 with SMTP id
 y27-20020ac255bb000000b004ed88fe62e0mr1019252lfg.68.1683130998768; Wed, 03
 May 2023 09:23:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230401124902.76959-1-cgzones@googlemail.com>
 <20230420151500.23679-1-cgzones@googlemail.com> <CAP+JOzTz_tm-wFby3xuiR1n8J-=CMc3E9ZXoao8gD2LSD8cs=g@mail.gmail.com>
In-Reply-To: <CAP+JOzTz_tm-wFby3xuiR1n8J-=CMc3E9ZXoao8gD2LSD8cs=g@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Wed, 3 May 2023 12:23:07 -0400
Message-ID: <CAP+JOzSJp4qw+_i0MOS82OUK_L+EmeaL5DSxdaNmH3Jv7HzyAA@mail.gmail.com>
Subject: Re: [PATCH RESEND] libsemanage: fix memory leak in semanage_user_roles
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Apr 20, 2023 at 4:58=E2=80=AFPM James Carter <jwcart2@gmail.com> wr=
ote:
>
> On Thu, Apr 20, 2023 at 11:25=E2=80=AFAM Christian G=C3=B6ttsche
> <cgzones@googlemail.com> wrote:
> >
> > The output parameter `role_arr` of semanage_user_get_roles() is an arra=
y
> > of non-owned role names.  Since the array is never used again, as its
> > contents have been copied into the return value `roles`, free it.
> >
> > Example leak report from useradd(8):
> >
> >     Direct leak of 8 byte(s) in 1 object(s) allocated from:
> >     #0 0x5597624284a8 in __interceptor_calloc (./shadow/src/useradd+0xe=
e4a8)
> >     #1 0x7f53aefcbbf9 in sepol_user_get_roles src/user_record.c:270:21
> >
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Acked-by: James Carter <jwcart2@gmail.com>
>

Merged.
Thanks,
Jim

> > ---
> > same as v1, only signed-of
> > ---
> >  libsemanage/src/seusers_local.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/libsemanage/src/seusers_local.c b/libsemanage/src/seusers_=
local.c
> > index 6508ec05..795a33d6 100644
> > --- a/libsemanage/src/seusers_local.c
> > +++ b/libsemanage/src/seusers_local.c
> > @@ -47,6 +47,7 @@ static char *semanage_user_roles(semanage_handle_t * =
handle, const char *sename)
> >                                                 }
> >                                         }
> >                                 }
> > +                               free(roles_arr);
> >                         }
> >                         semanage_user_free(user);
> >                 }
> > --
> > 2.40.0
> >
