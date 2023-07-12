Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B7EEEB64DA
	for <selinux@archiver.kernel.org>; Wed, 12 Jul 2023 17:35:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231891AbjGLRfP (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 12 Jul 2023 13:35:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232165AbjGLRfO (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 12 Jul 2023 13:35:14 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2F2E2123
        for <selinux@vger.kernel.org>; Wed, 12 Jul 2023 10:35:02 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2b6f943383eso117949081fa.2
        for <selinux@vger.kernel.org>; Wed, 12 Jul 2023 10:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689183301; x=1691775301;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zjAMDR6bZAbdM1zsIzk7ZjQzhljMsdTV/9tNOEwT+SQ=;
        b=S2RW0Qxp9XGDHM6EP72OR7fPIqmaCGxWpIxPVJ3axpQuwbE3z4BrZEf/+HFHJGUaj7
         8hJh0bjVZVbRWEJ7LvN+7lB7CJUro7zd9+EbHzFnMBJ09W73CRowcCphuKLQEKJgofLO
         8phIX5x7u2WT2geYWklKirPmRceECQ43gE8eI/AluncGn712wOSAMWodhhx257FEqcCn
         cYMX7Ij8JBVBM6GjhSvF0MFs5zeVWJzXM+eE+bR1mtWzDXiSnishSn1H2AEA/kvkDJ9F
         4jhKtq0dNLmMHF7ds2gGpP/qK+mq/xhy1db+XsPPc65LBFZcXHHpIDaHWI+d1Nm9T+Lj
         drGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689183301; x=1691775301;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zjAMDR6bZAbdM1zsIzk7ZjQzhljMsdTV/9tNOEwT+SQ=;
        b=d5Wf+g6BGIC/GTbUPeSXCr0VonBndq+XIPPXQ2zmojoVqVQl0q0ARFpB0MxORWXTRn
         6pdTUBzqu+8x17+ExMwcvcLZUgX0c4KLnC7pHV23FmepD6cfvA3et4KRZ+CjFC+ovy53
         JIPjDBGQPPnaPHIzZwRED/Puhveux4IY3V87T6FgRnf4WZbfcDDeFbsv0mplRxfh0uDk
         nfTpldYrhN8Z3BDMeCJSxJ+zHLZahOT7FWcl9dD7zUfHojMkw+umyDlIPwJoMtEAqBmr
         Jh2k94qlukNYNee/UmYSa9OsJdK/pH29r0FhS7QzgmK5fWyPD0/KuPE2pGFxHZHHfphO
         sptw==
X-Gm-Message-State: ABy/qLa45r7/cqAMkxqxCVr9WIqrStH63tvQgvN8+b42kxGkyyA8mREm
        2/UZreNxt3XBHVHudYbWKADWomI/ndLVSOu6Zv7rB1Tg
X-Google-Smtp-Source: APBJJlFvZwso0QbH8pXPZh6akezmI0+9hlV3DUAuoXqPkD5916hdPJxCgFkjJspOE3HlX9W8b7Fb9dgHGJbJmxghHb8=
X-Received: by 2002:a2e:8909:0:b0:2b6:9f5d:e758 with SMTP id
 d9-20020a2e8909000000b002b69f5de758mr19292134lji.9.1689183300699; Wed, 12 Jul
 2023 10:35:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230706135221.43544-1-cgzones@googlemail.com> <CAP+JOzQM=PEaTsbcPX1wnhTx=t_dqoiuRAo+RMq+mT4Wj7gTQQ@mail.gmail.com>
In-Reply-To: <CAP+JOzQM=PEaTsbcPX1wnhTx=t_dqoiuRAo+RMq+mT4Wj7gTQQ@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Wed, 12 Jul 2023 13:34:49 -0400
Message-ID: <CAP+JOzQk-Frejn31LpEfC+SfBMOURW+J1y3GWEvV79n6Pgkaww@mail.gmail.com>
Subject: Re: [PATCH] libsepol: free initial sid names
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Jul 11, 2023 at 2:45=E2=80=AFPM James Carter <jwcart2@gmail.com> wr=
ote:
>
> On Thu, Jul 6, 2023 at 10:01=E2=80=AFAM Christian G=C3=B6ttsche
> <cgzones@googlemail.com> wrote:
> >
> > Commit 55b75a2c ("libsepol: stop translating deprecated intial SIDs to
> > strings") dropped several names of obsolete initial sids ans replaced
> > them with NULL.  This leads to their printable string being dynamically
> > allocated but not free'd.
> > Instead of keeping track of which name was allocated dynamically and
> > which not, allocate all on the heap, which simplifies the later cleanup=
.
> >
> > While on it also free the name in case of a strs_add_at_index() failure=
.
> >
> > Reported-by: oss-fuzz (issue 60271)
> > Fixes: 55b75a2c ("libsepol: stop translating deprecated intial SIDs to =
strings")
> >
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Acked-by: James Carter <jwcart2@gmail.com>
>

Merged.
Thanks,
Jim


> > ---
> >  libsepol/src/kernel_to_cil.c  | 18 ++++++++----------
> >  libsepol/src/kernel_to_conf.c | 16 +++++++---------
> >  2 files changed, 15 insertions(+), 19 deletions(-)
> >
> > diff --git a/libsepol/src/kernel_to_cil.c b/libsepol/src/kernel_to_cil.=
c
> > index a3d8d139..8fcc385d 100644
> > --- a/libsepol/src/kernel_to_cil.c
> > +++ b/libsepol/src/kernel_to_cil.c
> > @@ -569,18 +569,19 @@ static int write_sids_to_cil(FILE *out, const cha=
r *const *sid_to_str,
> >         for (isid =3D isids; isid !=3D NULL; isid =3D isid->next) {
> >                 i =3D isid->sid[0];
> >                 if (i < num_sids && sid_to_str[i]) {
> > -                       sid =3D (char *)sid_to_str[i];
> > +                       sid =3D strdup(sid_to_str[i]);
> >                 } else {
> >                         snprintf(unknown, 18, "%s%u", "UNKNOWN", i);
> >                         sid =3D strdup(unknown);
> > -                       if (!sid) {
> > -                               ERR(NULL, "Out of memory");
> > -                               rc =3D -1;
> > -                               goto exit;
> > -                       }
> > +               }
> > +               if (!sid) {
> > +                       ERR(NULL, "Out of memory");
> > +                       rc =3D -1;
> > +                       goto exit;
> >                 }
> >                 rc =3D strs_add_at_index(strs, sid, i);
> >                 if (rc !=3D 0) {
> > +                       free(sid);
> >                         goto exit;
> >                 }
> >         }
> > @@ -611,10 +612,7 @@ static int write_sids_to_cil(FILE *out, const char=
 *const *sid_to_str,
> >         sepol_printf(out, "))\n");
> >
> >  exit:
> > -       for (i=3Dnum_sids; i<strs_num_items(strs); i++) {
> > -               sid =3D strs_read_at_index(strs, i);
> > -               free(sid);
> > -       }
> > +       strs_free_all(strs);
> >         strs_destroy(&strs);
> >         if (rc !=3D 0) {
> >                 ERR(NULL, "Error writing sid rules to CIL");
> > diff --git a/libsepol/src/kernel_to_conf.c b/libsepol/src/kernel_to_con=
f.c
> > index 0710572d..b0ae16d9 100644
> > --- a/libsepol/src/kernel_to_conf.c
> > +++ b/libsepol/src/kernel_to_conf.c
> > @@ -466,17 +466,18 @@ static int write_sids_to_conf(FILE *out, const ch=
ar *const *sid_to_str,
> >         for (isid =3D isids; isid !=3D NULL; isid =3D isid->next) {
> >                 i =3D isid->sid[0];
> >                 if (i < num_sids && sid_to_str[i]) {
> > -                       sid =3D (char *)sid_to_str[i];
> > +                       sid =3D strdup(sid_to_str[i]);
> >                 } else {
> >                         snprintf(unknown, sizeof(unknown), "%s%u", "UNK=
NOWN", i);
> >                         sid =3D strdup(unknown);
> > -                       if (!sid) {
> > -                               rc =3D -1;
> > -                               goto exit;
> > -                       }
> > +               }
> > +               if (!sid) {
> > +                       rc =3D -1;
> > +                       goto exit;
> >                 }
> >                 rc =3D strs_add_at_index(strs, sid, i);
> >                 if (rc !=3D 0) {
> > +                       free(sid);
> >                         goto exit;
> >                 }
> >         }
> > @@ -490,10 +491,7 @@ static int write_sids_to_conf(FILE *out, const cha=
r *const *sid_to_str,
> >         }
> >
> >  exit:
> > -       for (i=3Dnum_sids; i<strs_num_items(strs); i++) {
> > -               sid =3D strs_read_at_index(strs, i);
> > -               free(sid);
> > -       }
> > +       strs_free_all(strs);
> >         strs_destroy(&strs);
> >         if (rc !=3D 0) {
> >                 ERR(NULL, "Error writing sid rules to policy.conf");
> > --
> > 2.40.1
> >
