Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1118C04A6A
	for <selinux@archiver.kernel.org>; Mon,  7 Aug 2023 13:42:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233620AbjHGNmX (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 7 Aug 2023 09:42:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234167AbjHGNmJ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 7 Aug 2023 09:42:09 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C247210E0
        for <selinux@vger.kernel.org>; Mon,  7 Aug 2023 06:41:53 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2b9d07a8d84so72975611fa.3
        for <selinux@vger.kernel.org>; Mon, 07 Aug 2023 06:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691415709; x=1692020509;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zhvkoNUKWqBMYXjniUbl2Oz89L8yLq7OSBCc8wlB6SA=;
        b=XAW+aSkD85kKNQUElcEUZJZnp3mbzjMriO/WsqDHUETlpNKW/H2R6ifZuwZdJOAu+t
         ib2c45CScNzzkcuOhL43TiSMYHYmVhNht6qUk8fzWf2ZH+krH8oYEyUGmMH1ZYTwhuCk
         XZod/R9c9qySc12ouhbqEOIT0sTPcMOdb172nB0Vdn79LCqc6pu5o9MW+KnNhHD16kPg
         lt1560pFfvagTPWyrBGaQIWcqm48K5XEvgtSS6H6aiPP4sCqM2RocUu+SZJz2hhENjKH
         EsNCYcMiD5E4X+S55V3WfRT97vjnNCweo1kHc/I4MLN4TyOeuJ97wgHnuhJp14u3nd7s
         e1OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691415709; x=1692020509;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zhvkoNUKWqBMYXjniUbl2Oz89L8yLq7OSBCc8wlB6SA=;
        b=kDlEzdj07c0EWlEMDTgwq9hf+JTpsFvM7Ku4saOIPUaiNrl2axdLKkx4maP2T8iBfU
         SAyiVz2jOKetYhXmXItgLcy33ws+WVkJnnWLvhONT/tyEjF9M7QKiXQ+UZkd0fpEEzvQ
         Outuy/VIVQ7QmyjiUDLRwt+m/5lN+keKHbe55Mj1G0T/K7F/QYRTyY3mXus/y5Oqe1r9
         O5vV7RzoScupTQm2OC7t6j7X/BoK75a2dD56zIDZqfXoiBSu7l99Scn+3Ge/Ri6SpP89
         eW23UKLfJBqnxSu83wayY3OrFo14M98oC+b6xHFhAj4YVpS6rdz3+mLFuMPKagmpZJ4Z
         MD+Q==
X-Gm-Message-State: AOJu0Yy++dr2aM1Q5y22/hJTxGkcZyUufv0y3D5b3s6v9ZYGwLYpZS2P
        NJkB+Fv81lvWk/geKibyfk/fi1tHy0G5Ffhn1enn1sWA
X-Google-Smtp-Source: AGHT+IF9chxIrkx7Z8NAKm6Aoqb1UrLPM4Cnq93//wfeDJq4bDTXksjNroLVmLjCQsVS0IwTFX4D+xD58DI0xyhkI5Q=
X-Received: by 2002:a2e:9e0c:0:b0:2b9:a6a1:f12 with SMTP id
 e12-20020a2e9e0c000000b002b9a6a10f12mr6295557ljk.43.1691415708557; Mon, 07
 Aug 2023 06:41:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230714182918.30917-1-cgzones@googlemail.com> <CAP+JOzSt6w0Upwd=8tywUR3xwcuzKZ6JQwrkzKbEYmGg15-8rA@mail.gmail.com>
In-Reply-To: <CAP+JOzSt6w0Upwd=8tywUR3xwcuzKZ6JQwrkzKbEYmGg15-8rA@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Mon, 7 Aug 2023 09:41:37 -0400
Message-ID: <CAP+JOzSYcTa6UTuCsveorctpqazxgBMmKdPGfD9docVzN=kUug@mail.gmail.com>
Subject: Re: [PATCH] libsepol: use explicit type for function parameters
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Jul 31, 2023 at 3:54=E2=80=AFPM James Carter <jwcart2@gmail.com> wr=
ote:
>
> On Fri, Jul 14, 2023 at 2:46=E2=80=AFPM Christian G=C3=B6ttsche
> <cgzones@googlemail.com> wrote:
> >
> > Use a pointer to the explicit type struct policy_file instead of void
> > for increased type safety and readability.
> >
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Acked-by: James Carter <jwcart2@gmail.com>
>

This patch was for the prefix/suffix patches, so it is no longer applicable=
.
Jim

> > ---
> >  libsepol/include/sepol/policydb/avtab.h | 2 +-
> >  libsepol/src/avtab.c                    | 6 +++---
> >  2 files changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/libsepol/include/sepol/policydb/avtab.h b/libsepol/include=
/sepol/policydb/avtab.h
> > index 7d892879..2bb583f5 100644
> > --- a/libsepol/include/sepol/policydb/avtab.h
> > +++ b/libsepol/include/sepol/policydb/avtab.h
> > @@ -158,7 +158,7 @@ extern int avtab_insert_filename_trans(avtab_t *a, =
avtab_key_t *key,
> >                                        uint32_t otype, const char *name=
,
> >                                        uint8_t name_match,
> >                                        uint32_t *present_otype);
> > -extern int avtab_filename_trans_read(void *fp, uint32_t vers, avtab_t =
*a);
> > +extern int avtab_filename_trans_read(struct policy_file *fp, uint32_t =
vers, avtab_t *a);
> >
> >  #ifdef __cplusplus
> >  }
> > diff --git a/libsepol/src/avtab.c b/libsepol/src/avtab.c
> > index 99fdaa87..7a35fc17 100644
> > --- a/libsepol/src/avtab.c
> > +++ b/libsepol/src/avtab.c
> > @@ -843,7 +843,7 @@ bad:
> >         return rc;
> >  }
> >
> > -static int filename_trans_read_one(avtab_t *a, void *fp)
> > +static int filename_trans_read_one(avtab_t *a, struct policy_file *fp)
> >  {
> >         int rc;
> >         uint32_t buf[4], len, otype;
> > @@ -882,7 +882,7 @@ err:
> >         return SEPOL_ERR;
> >  }
> >
> > -static int filename_trans_comp_read_one(avtab_t *a, void *fp)
> > +static int filename_trans_comp_read_one(avtab_t *a, struct policy_file=
 *fp)
> >  {
> >         int rc;
> >         uint32_t buf[3], len, ndatum, i, bit, otype;
> > @@ -941,7 +941,7 @@ err:
> >         return rc;
> >  }
> >
> > -int avtab_filename_trans_read(void *fp, uint32_t vers, avtab_t *a)
> > +int avtab_filename_trans_read(struct policy_file *fp, uint32_t vers, a=
vtab_t *a)
> >  {
> >         uint32_t buf[1], nel, i;
> >         int rc;
> > --
> > 2.40.1
> >
