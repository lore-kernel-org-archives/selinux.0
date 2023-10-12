Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F1CFCDB46E
	for <selinux@archiver.kernel.org>; Thu, 12 Oct 2023 17:55:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379655AbjJLRzS (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 12 Oct 2023 13:55:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379656AbjJLRzR (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 12 Oct 2023 13:55:17 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A859EB8
        for <selinux@vger.kernel.org>; Thu, 12 Oct 2023 10:55:15 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-505a62d24b9so1643091e87.2
        for <selinux@vger.kernel.org>; Thu, 12 Oct 2023 10:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697133314; x=1697738114; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9ya5Sa0Qn8ufqopa45SSCLIxjGxIg7niSAXuLXULSc0=;
        b=WaNnDmgQJb+doGSeY6i1gQ4nQ+oQ6kL+P4vVpOH5W2MPLW/WVTI+v911psiMcHIDA8
         8QD0BUxtgiMvt3gNigae0A0+M3lD5qmezKooUTdk2a3rh/LDiQQT+DOBKBXaI/Qf7z2P
         1bApoUSqGUlb1S21K5UwoxckPGMjO5YT5+syVLOBLTRmxZmUV4+UKVQjmeLPhWXhPibN
         U3LFmqsxDr4VaZbrt0OiD/Zt1uCjPw/ZG0P5/uW+qwCsnLzVo8/2OWvlo4PlEOZbne/D
         qYu5KfdX5ShcbZtC8Ta/x8bZpj8FHkPwJrrPgRhXML59kWfDrKK1yN3+6vLHDs5oSoXs
         effQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697133314; x=1697738114;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9ya5Sa0Qn8ufqopa45SSCLIxjGxIg7niSAXuLXULSc0=;
        b=SpBAocvf/luFOQGZmU9cBqf+jVRfsNkfv4Xz5RHrgRdSY9b8hNyaOg83mM7UmDLjZq
         ZJSD2mPAgTKQnlO4IW/QOZRuTiOLEvLEigFsxik81yMFdtN/lG2XXbwvjfKeP8t81ZiW
         jGC5uOJKGhEDKnR2BAGcR4GjlFlDDFz7IJSJkMrLauITco1o1QQ2gOkgYTddDgpTtUdc
         UZXWP7jU8FwhNJCX3uEAwmrzmVV6lagVw0kmBkfjliY2CmX/XwDRBADtL1VZ5oHrFk7C
         9MQj0U5+OdaqcDSozL0afJHxDgHTFSZQ03vcm/uFjdnT52Goroqi7HOp31oUiyBxO+R3
         Nz0Q==
X-Gm-Message-State: AOJu0Yzc1PfmfB65pkEnqAb0ZQLDIE7oK2XeBAiZhsCA0YiGBpLIookv
        QcHoXtKQFhuIq1XQGvypEwUFsGzLRm2QDY0Iu0bPo5VzuhA=
X-Google-Smtp-Source: AGHT+IGaJt2V4z1s8yTOHQ2m4LPCzfvYdBg85snief2b3YJmd97J8T7hXMCCR1WzobhwdehBK/m6KUi3riNvEwcVvW4=
X-Received: by 2002:a19:5004:0:b0:503:3245:6eda with SMTP id
 e4-20020a195004000000b0050332456edamr20031263lfb.40.1697133313923; Thu, 12
 Oct 2023 10:55:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230814132025.45364-1-cgzones@googlemail.com>
 <20230814132025.45364-16-cgzones@googlemail.com> <CAP+JOzQXnPoyO1bFS_n9WBYmUF83f5gZ=qDYp4hsNGtaEvwX4g@mail.gmail.com>
In-Reply-To: <CAP+JOzQXnPoyO1bFS_n9WBYmUF83f5gZ=qDYp4hsNGtaEvwX4g@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Thu, 12 Oct 2023 13:55:02 -0400
Message-ID: <CAP+JOzTwPJpLsUhvpgSQAreZuFOQVB3+jPovFg2un6VRBF_v4g@mail.gmail.com>
Subject: Re: [RFC PATCH v2 15/27] libselinux/utils: use correct type for
 backend argument
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Oct 5, 2023 at 11:49=E2=80=AFAM James Carter <jwcart2@gmail.com> wr=
ote:
>
> On Mon, Aug 14, 2023 at 9:42=E2=80=AFAM Christian G=C3=B6ttsche
> <cgzones@googlemail.com> wrote:
> >
> > selabel_open(3) expects the backend to be of type unsigned int.
> >
> > Also initialize with a macro flag instead raw 0.
> >
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Acked-by: James Carter <jwcart2@gmail.com>
>
Merged.
Thanks,
Jim

> > ---
> >  libselinux/utils/selabel_digest.c | 3 ++-
> >  libselinux/utils/selabel_lookup.c | 3 ++-
> >  2 files changed, 4 insertions(+), 2 deletions(-)
> >
> > diff --git a/libselinux/utils/selabel_digest.c b/libselinux/utils/selab=
el_digest.c
> > index 6a8313a2..bf22b472 100644
> > --- a/libselinux/utils/selabel_digest.c
> > +++ b/libselinux/utils/selabel_digest.c
> > @@ -59,7 +59,8 @@ static int run_check_digest(char *cmd, char *selabel_=
digest)
> >
> >  int main(int argc, char **argv)
> >  {
> > -       int backend =3D 0, rc, opt, validate =3D 0;
> > +       unsigned int backend =3D SELABEL_CTX_FILE;
> > +       int rc, opt, validate =3D 0;
> >         char *baseonly =3D NULL, *file =3D NULL, *digest =3D (char *)1;
> >         char **specfiles =3D NULL;
> >         unsigned char *sha1_digest =3D NULL;
> > diff --git a/libselinux/utils/selabel_lookup.c b/libselinux/utils/selab=
el_lookup.c
> > index 112ffda1..5dc32548 100644
> > --- a/libselinux/utils/selabel_lookup.c
> > +++ b/libselinux/utils/selabel_lookup.c
> > @@ -32,7 +32,8 @@ static __attribute__ ((__noreturn__)) void usage(cons=
t char *progname)
> >
> >  int main(int argc, char **argv)
> >  {
> > -       int raw =3D 0, type =3D 0, backend =3D 0, rc, opt;
> > +       int raw =3D 0, type =3D 0, rc, opt;
> > +       unsigned int backend =3D SELABEL_CTX_FILE;
> >         char *validate =3D NULL, *key =3D NULL, *context =3D NULL, *fil=
e =3D NULL;
> >
> >         struct selabel_handle *hnd;
> > --
> > 2.40.1
> >
