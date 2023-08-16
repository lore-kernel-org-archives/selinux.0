Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE117C001B0
	for <selinux@archiver.kernel.org>; Wed, 16 Aug 2023 17:39:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243331AbjHPRiv (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 16 Aug 2023 13:38:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345267AbjHPRig (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 16 Aug 2023 13:38:36 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF728270D
        for <selinux@vger.kernel.org>; Wed, 16 Aug 2023 10:38:34 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2b9cf2b1309so1155361fa.0
        for <selinux@vger.kernel.org>; Wed, 16 Aug 2023 10:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692207513; x=1692812313;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EjJawf70BQUO+MEs9ux6GIhdoNJ+Iav5JvM13ms0dDQ=;
        b=V1EXNhD/6pLxi0YvJwdz5n15aKAmBVHymPjYuozEOm56WAHUTQZEuROp1XwgJGH4eO
         wgMhYoj5QLwEvgdVKBD3QTAlLsXy73HUYCnRbWIrUSPYBe800ZY6eyaj91lc+50F5Bok
         PwYL1tOPXPKpu0JotduruTZmmhilez1yVDCZkZdqB4mcCV/oMA1/gL4LGViu3xuZrBR1
         xegYfwxpyOuEGE/jMZ9ha68+VoS/pi22cznkmcGEjxOyOMpdlpT3gaDSBiY8FL6EHGTb
         LxQ6by97dBneaLXP8GwJPsnY3bWggTv8Rf8AerngVT/YVYaYXfwiaTRHb7qlRCPBil9b
         r5yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692207513; x=1692812313;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EjJawf70BQUO+MEs9ux6GIhdoNJ+Iav5JvM13ms0dDQ=;
        b=QLnhVIdd+rxLWH2HNer59SHsfZ9QOPoNsmN9F/1aNeW33k9CCQmha4SCzal39ShqDH
         /hueW0Gi5HPs7ks0ZUE/yV6Qm1wdFWxXLRZiasp1rymbkQGQl14E5KBMFgewyNWgYqYp
         xjSivRG/XlhsWvt+E4kN5pq5x3hqBoM4K4UQbJNanGdAaONfXb9+f0TsrP5w+q6qODtY
         H4XCrnf87yNsraLlD9VXVXQBxVdGtVVBu9lbOp4+AfQhxJC5yRwKdvEfNhDbxL2RDqzk
         37oBxWEcuPAZBE1ayVYwK9eCNQqQ+ZQ1ntb5fLyixip37z2JTJbCvubah4HBBUR0ktmt
         PXKg==
X-Gm-Message-State: AOJu0YyZ37uCF941pB+m7cnzOuGaWzCfJm1oQWbSyep3m+uPUHDsr/6D
        NsT+FhW7w+3xarGwpfiI+BlsXV1QiVD/k1iWZJayq1ua
X-Google-Smtp-Source: AGHT+IHOj2w5qfcPJ/ywRvjnoPMcJsNosDY7CCboy4oXNpbY+LUPJWmnYN5vGtZM0/A3rOarx+n6twUdPL8cg1mIN98=
X-Received: by 2002:a05:651c:1191:b0:2bb:8bf1:7472 with SMTP id
 w17-20020a05651c119100b002bb8bf17472mr136802ljo.12.1692207512942; Wed, 16 Aug
 2023 10:38:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230805094418.18828-1-cgzones@googlemail.com> <CAP+JOzTcZjH8kY5rgGb7SvcuVwMwZJ1Oah+g7fioizLMmTiy2A@mail.gmail.com>
In-Reply-To: <CAP+JOzTcZjH8kY5rgGb7SvcuVwMwZJ1Oah+g7fioizLMmTiy2A@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Wed, 16 Aug 2023 13:38:21 -0400
Message-ID: <CAP+JOzR4U4atjDb_v1D1uwyNHP3=ic1W5Lb31oB5g0sjfVxQ6A@mail.gmail.com>
Subject: Re: [PATCH] libsemanage/tests: use strict prototypes
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Aug 9, 2023 at 10:18=E2=80=AFAM James Carter <jwcart2@gmail.com> wr=
ote:
>
> On Sat, Aug 5, 2023 at 6:18=E2=80=AFAM Christian G=C3=B6ttsche
> <cgzones@googlemail.com> wrote:
> >
> >     utilities.c:39:22: error: a function declaration without a prototyp=
e is deprecated in all versions of C [-Werror,-Wstrict-prototypes]
> >     int create_test_store() {
> >                          ^
> >                           void
> >     utilities.c:171:23: error: a function declaration without a prototy=
pe is deprecated in all versions of C [-Werror,-Wstrict-prototypes]
> >     int destroy_test_store() {
> >                           ^
> >                            void
> >
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Acked-by: James Carter <jwcart2@gmail.com>
>

Merged.
Thanks,
Jim

> > ---
> >  libsemanage/tests/utilities.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/libsemanage/tests/utilities.c b/libsemanage/tests/utilitie=
s.c
> > index 71d7af1e..806869e0 100644
> > --- a/libsemanage/tests/utilities.c
> > +++ b/libsemanage/tests/utilities.c
> > @@ -36,7 +36,7 @@ void test_msg_handler(void *varg, semanage_handle_t *=
handle, const char *fmt,
> >  {
> >  }
> >
> > -int create_test_store() {
> > +int create_test_store(void) {
> >         FILE *fptr;
> >
> >         if (mkdir("test-policy", 0700) < 0)
> > @@ -168,7 +168,7 @@ int write_test_policy_src(unsigned char *data, unsi=
gned int data_len) {
> >         return 0;
> >  }
> >
> > -int destroy_test_store() {
> > +int destroy_test_store(void) {
> >         FTS *ftsp =3D NULL;
> >         FTSENT *curr =3D NULL;
> >         int ret =3D 0;
> > --
> > 2.40.1
> >
