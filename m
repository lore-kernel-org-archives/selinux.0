Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BFB1C433EF
	for <selinux@archiver.kernel.org>; Thu,  2 Jun 2022 13:04:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235132AbiFBNEq (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 2 Jun 2022 09:04:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234059AbiFBNEp (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 2 Jun 2022 09:04:45 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 847BC132767
        for <selinux@vger.kernel.org>; Thu,  2 Jun 2022 06:04:44 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id 61-20020a9d0bc3000000b0060b9bfcfe76so3333568oth.9
        for <selinux@vger.kernel.org>; Thu, 02 Jun 2022 06:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=p2XhIGtC0IiO85pzHm2Q4lGby4Om4JfEdGkJmcdm3Vw=;
        b=SgQlk6G1KwlX8MbNlBnX8attZYRU8gdi6RVwE1Hof3/1vXIPHOmNKgZz4mcNNn6pQN
         WPKJ1iWm+pq1hMLvbgPB2n3AiqTeE5QM8xf6wEff6eRkkL5niQgfKD7IGdD/IprLENXe
         h6bzoiaOQT09djbTG0WH3C5sFDKpwAR3gxcQ6q1Qo4d7URnAcZYNCXY1rG30PPFn1Hbu
         Ka+0qy+GAC5/tinvhcwGdh6+X4R0uBGtnaYVL5upyYY+JGBt1vxBJnFjN5o6Zznk+DEq
         NFtSlKNStXiPB+xistTpMb8uqCEAXlMSrFEQ4XrMt7A0KHLvCl+7g2cHp4HkygTPxBIb
         HieQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=p2XhIGtC0IiO85pzHm2Q4lGby4Om4JfEdGkJmcdm3Vw=;
        b=ouNwJ3LhuBBou4vMqpqOpThXp5x6+VS068hEmn8NaWs75yRVPYX5FnppbM+s2zYOgY
         ISnrwxUDVoFd4IXB10tbfTZwYO2Hna1h00/8Hf0byYKz3muKOP7Q4nXfTEKhkdr3dQQE
         sPmj200unmSNEoz8/1yjM9cF1bBP3aoG30ED4NuXM7Bh1YgwnkD3FhVG2Jy1/9J2AxZ/
         VactI0ZKTddPXB5gMLP7SZGZgMa0G4jiuxTmWW5oN+rRv2OqP4bYnRJF2vJeURVQN1nh
         MGSZaMakPH33UVvEO/zyXM7k5E4G/G+ibVQ87640PsUVBhu6NrvzU4K2eyJ6hrhVkeh/
         08VA==
X-Gm-Message-State: AOAM533OJIqnaI3yCLArNjfnUff+74rrcGwnFC8bn0DA3IoLXDHeKqNC
        LyzXEGJ/+JkX1kuy7+Phrrbc5TOenrYQCiOIvwk=
X-Google-Smtp-Source: ABdhPJw25gBHUT4wTfiX9ZSN73H6P5fIQJs7akeqQBSswiCwtP+c9Gm58MBXG0iZ55cdwXnCH6CxZ7jBjvro0Xo5Yv4=
X-Received: by 2002:a05:6830:99:b0:60b:222:66be with SMTP id
 a25-20020a056830009900b0060b022266bemr2001275oto.53.1654175083910; Thu, 02
 Jun 2022 06:04:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220520131952.12286-1-cgzones@googlemail.com> <CAJfZ7=k7C5tozzohGREYNuj8OP7VzrN_E3Ng0yi+=Vi0JW3weA@mail.gmail.com>
In-Reply-To: <CAJfZ7=k7C5tozzohGREYNuj8OP7VzrN_E3Ng0yi+=Vi0JW3weA@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Thu, 2 Jun 2022 09:04:33 -0400
Message-ID: <CAP+JOzT_LxsOXwqX9oigkbhWwPPaG4v9=dqqewq83bHu5orzTQ@mail.gmail.com>
Subject: Re: [PATCH] semodule: avoid toctou on output module
To:     Nicolas Iooss <nicolas.iooss@m4x.org>
Cc:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, May 30, 2022 at 1:00 AM Nicolas Iooss <nicolas.iooss@m4x.org> wrote=
:
>
> On Fri, May 20, 2022 at 3:20 PM Christian G=C3=B6ttsche
> <cgzones@googlemail.com> wrote:
> >
> > Do not check for file existence and open afterwards, open with the
> > exclusive flag (supported in Glibc and musl 0.9.6 and also standardized
> > in C11).
> >
> > Found by GitHub CodeQL.
> >
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> This looks good to me.
>
> Acked-by: Nicolas Iooss <nicolas.iooss@m4x.org>
>

Merged.
Thanks,
Jim

> Thanks!
>
> > ---
> >  policycoreutils/semodule/semodule.c | 13 +++++--------
> >  1 file changed, 5 insertions(+), 8 deletions(-)
> >
> > diff --git a/policycoreutils/semodule/semodule.c b/policycoreutils/semo=
dule/semodule.c
> > index 1ed8e690..48bc28dd 100644
> > --- a/policycoreutils/semodule/semodule.c
> > +++ b/policycoreutils/semodule/semodule.c
> > @@ -550,15 +550,12 @@ int main(int argc, char *argv[])
> >                                         goto cleanup_extract;
> >                                 }
> >
> > -                               if (access(output_path, F_OK) =3D=3D 0)=
 {
> > -                                       fprintf(stderr, "%s: %s is alre=
ady extracted with extension %s.\n", argv[0], mode_arg, lang_ext);
> > -                                       result =3D -1;
> > -                                       goto cleanup_extract;
> > -                               }
> > -
> > -                               output_fd =3D fopen(output_path, "w");
> > +                               output_fd =3D fopen(output_path, "wx");
> >                                 if (output_fd =3D=3D NULL) {
> > -                                       fprintf(stderr, "%s: Unable to =
open %s\n", argv[0], output_path);
> > +                                       if (errno =3D=3D EEXIST)
> > +                                               fprintf(stderr, "%s: %s=
 is already extracted with extension %s.\n", argv[0], mode_arg, lang_ext);
> > +                                       else
> > +                                               fprintf(stderr, "%s: Un=
able to open %s:  %s\n", argv[0], output_path, strerror(errno));
> >                                         result =3D -1;
> >                                         goto cleanup_extract;
> >                                 }
> > --
> > 2.36.1
> >
>
