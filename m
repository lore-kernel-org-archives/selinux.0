Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12A6BC4332F
	for <selinux@archiver.kernel.org>; Tue,  7 Nov 2023 21:41:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235321AbjKGVlt (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 7 Nov 2023 16:41:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233982AbjKGVls (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 7 Nov 2023 16:41:48 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 959D710E4
        for <selinux@vger.kernel.org>; Tue,  7 Nov 2023 13:41:45 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-32deb2809daso3652399f8f.3
        for <selinux@vger.kernel.org>; Tue, 07 Nov 2023 13:41:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699393304; x=1699998104; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X93vMyDbY1x3FTqx7bHy1Th4Qi3W4j+1MqkqZTPeTWg=;
        b=HPYYadIanLYb+wGUzLTF+erLY6MtA/rerJRSn6a5txqzsI5cJgpItT8K6BKzSQwot1
         tPWTfkWaFN2xSO2nNxShw+pNgP6zedPaVFRLjx+Ddaghkr1qbRx+BdCJM5u4UZ4Zx6N9
         sa1p2enH7ozXBYqwuOcUB+gPm4Ng+E+oRAJfv5U+fM7nbDEH+jLj6oDZdOXZBbFiMzde
         caYQuPMdErqdn0L4yeAGulJSwcqKDQbSoqygxbS71Gr3wY5xGVkkDkkmKi3DioSXQIfy
         lc2Tw0YYmyAzMmOQuJhrw+RSJQTiaCk3T2rWT/DsUzBQrZoZc1hi5wIffjDalpYdMwLt
         7h8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699393304; x=1699998104;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X93vMyDbY1x3FTqx7bHy1Th4Qi3W4j+1MqkqZTPeTWg=;
        b=LvH4/C07/0K0hfsipXWm07QmwJrHpEuRV3OapMlLHismvEW90gUwB4o3A6h5ZyrUJg
         i1lDfwZgpzks1J7TirU+xxJYuo/qWryi2SJAQxMfd+aWXe7UNcW/OuPOfUc5+1pIeSR5
         3/8ezWvmBvF+2+akhYCN68q5YGy0CLGtxyukofMZg4On5vvQ0SlRDQ8jRlxYu5jCU/Jc
         XMj0tPhcE6CymyZ1YOMmjwtO7Vg/D1oqVsN5fq3DjZ0xL4fGLwRYtLZ/In6n8PB168+d
         yI7C2L7SudCR4jpPzbsn4QGdLfciXS3g/YYYcRk8mLVOMz8EaKLPhNYKLPfDsYQQx9ku
         GtgA==
X-Gm-Message-State: AOJu0Yx5D1BvCb8VmsOX5au99AUf6VSXcE4pOFHxlSZ67KKmKS8T4Yk7
        UgBmVb+yXWlcCyy+noOuJjEMli8FKzHmrRbAIRNyAZNR
X-Google-Smtp-Source: AGHT+IGsY4J+HZ7vrRCFCAokmQP4FvaYF2hYYi/S27OLGOgZUTnSQhaHsHZLRWnndxxsy3Pgt6UqZ+s198HAcubYsT8=
X-Received: by 2002:ac2:4846:0:b0:507:aaa4:e3b3 with SMTP id
 6-20020ac24846000000b00507aaa4e3b3mr22140694lfy.50.1699393283168; Tue, 07 Nov
 2023 13:41:23 -0800 (PST)
MIME-Version: 1.0
References: <20231101163725.177237-1-cgzones@googlemail.com> <CAP+JOzRUv4x1f6qTpREzDE9Edr+c-tx17EnAcnqZ12oJEC5TzQ@mail.gmail.com>
In-Reply-To: <CAP+JOzRUv4x1f6qTpREzDE9Edr+c-tx17EnAcnqZ12oJEC5TzQ@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Tue, 7 Nov 2023 16:41:12 -0500
Message-ID: <CAP+JOzR2OerekWG_EsDQPDmL+ETYKzMH5P6933p857JZ_S_cuw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] libsepol: reject avtab entries with invalid specifier
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Nov 2, 2023 at 11:17=E2=80=AFAM James Carter <jwcart2@gmail.com> wr=
ote:
>
> On Wed, Nov 1, 2023 at 12:38=E2=80=AFPM Christian G=C3=B6ttsche
> <cgzones@googlemail.com> wrote:
> >
> > Neverallow avtab entries are not supported (normal and extended). Rejec=
t
> > them to avoid lookup confusions via avtab_search(), e.g. when searching
> > for a invalid key of AVTAB_TRANSITION|AVTAB_NEVERALLOW and the result o=
f
> > only AVTAB_NEVERALLOW has no transition value.
> >
> > Simplify the check for the number of specifiers by using the compiler
> > popcount builtin (already used in libsepol).
> >
> > Reported-by: oss-fuzz (issue 60568), caused at the time by the filetran=
s
> >              prefix proposal
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> For these two patches:
> Acked-by: James Carter <jwcart2@gmail.com>
>

These two patches have been merged.
Thanks,
Jim

> > ---
> > v2:
> >    rebase after revert of filename prefix proposal
> > ---
> >  libsepol/src/avtab.c | 13 ++++++-------
> >  1 file changed, 6 insertions(+), 7 deletions(-)
> >
> > diff --git a/libsepol/src/avtab.c b/libsepol/src/avtab.c
> > index 6ab49c5e..1ef5ee00 100644
> > --- a/libsepol/src/avtab.c
> > +++ b/libsepol/src/avtab.c
> > @@ -441,7 +441,6 @@ int avtab_read_item(struct policy_file *fp, uint32_=
t vers, avtab_t * a,
> >         avtab_key_t key;
> >         avtab_datum_t datum;
> >         avtab_extended_perms_t xperms;
> > -       unsigned set;
> >         unsigned int i;
> >         int rc;
> >
> > @@ -535,13 +534,13 @@ int avtab_read_item(struct policy_file *fp, uint3=
2_t vers, avtab_t * a,
> >         key.target_class =3D le16_to_cpu(buf16[items++]);
> >         key.specified =3D le16_to_cpu(buf16[items++]);
> >
> > -       set =3D 0;
> > -       for (i =3D 0; i < ARRAY_SIZE(spec_order); i++) {
> > -               if (key.specified & spec_order[i])
> > -                       set++;
> > +       if (key.specified & ~(AVTAB_AV | AVTAB_TYPE | AVTAB_XPERMS | AV=
TAB_ENABLED)) {
> > +               ERR(fp->handle, "invalid specifier");
> > +               return -1;
> >         }
> > -       if (!set || set > 1) {
> > -               ERR(fp->handle, "more than one specifier");
> > +
> > +       if (__builtin_popcount(key.specified & ~AVTAB_ENABLED) !=3D 1) =
{
> > +               ERR(fp->handle, "not exactly one specifier");
> >                 return -1;
> >         }
> >
> > --
> > 2.42.0
> >
