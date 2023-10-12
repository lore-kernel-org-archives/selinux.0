Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1554CDB46E
	for <selinux@archiver.kernel.org>; Thu, 12 Oct 2023 17:55:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379657AbjJLRzf (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 12 Oct 2023 13:55:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379656AbjJLRze (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 12 Oct 2023 13:55:34 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48F2DBB
        for <selinux@vger.kernel.org>; Thu, 12 Oct 2023 10:55:32 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-50435ad51bbso1658733e87.2
        for <selinux@vger.kernel.org>; Thu, 12 Oct 2023 10:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697133330; x=1697738130; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rHwUV/QcwX3VmnwPADkSLghiIcqewPcseU8lI3j5T4M=;
        b=hI71WX3vrkrLHfF3lJN6t8ZT8P9H9aP5A884qG3Fbt4F9ALeUHkNhU1lrdoAtDzanf
         0hVtZIJWNQjnCHhEGGjMtH4xojRmyjoEM3TXZli9X/gQJTadAC/bZ1GodKvz4gYP+GBh
         VhIItN6cpQri/mw6HAHkMIMwyTe9mzielUiwrKpT6+afCsbS7JGUj1WR/EJfjTBtXOIt
         YvCXrh4dFSXB56/oxrxhOrmNFTzfxxeStpMai4I5hsoxtI9hOCrj+/9pzMCktnN8E1AQ
         0PNPnPSK0R9MxjZcQwNLiLBzCMGjc3UJSYQK6USeq/dN2GdxPfvBR+9luEKuCd2NAWv9
         69UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697133330; x=1697738130;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rHwUV/QcwX3VmnwPADkSLghiIcqewPcseU8lI3j5T4M=;
        b=SfNTo0kshuG28rlK+h4XCHhLM/pYOrukjil3vtL6EJh5MSWoErac7AI2bR8Dl5NjG8
         c8dr4qCvsQyRCaA348cHxItcpYptTR/7B9YDNvLzi7mjeSkciwzm43i+h0CxmSYSCF3+
         jUsRu0g2edoOQbFsfPnZAzuTjdKv71g3IAluDO5GLVJhsXzeOPchypDvJrijV42CSc1f
         nhnZ1u9XkFhASPHtbYQdpbcHOgcIiK05KTQsmbUOOcvApsjg5Cm0ApiLGJJ49BrggmXB
         MBfiWoPW6YC9GHGLKmpnj25S49r9/HeRMPIsUt/VWQ+sBmX205ZdSXSXHUe7qTOk047R
         FVAw==
X-Gm-Message-State: AOJu0Yy0bHLJ2Qk3SDsL127YMXd2uLiP6SoOi7E9Qk6qPudOFArfi8dP
        DeROoBD5UuZ3pAeuBpqh3Y1BO507Wm0UA7PgqZsa5hCe2oY=
X-Google-Smtp-Source: AGHT+IGiApZhehUxwTscSnwTN2RlknJnDYD8G/20G1nNVWxP+IMDalaSqOjhTAOz1veSyrnzXpMjeZw60q43rxc1+4c=
X-Received: by 2002:a19:4f4d:0:b0:500:bff5:54ec with SMTP id
 a13-20020a194f4d000000b00500bff554ecmr20028592lfk.3.1697133330390; Thu, 12
 Oct 2023 10:55:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230814132025.45364-1-cgzones@googlemail.com>
 <20230814132025.45364-17-cgzones@googlemail.com> <CAP+JOzSGjo0xFmyfTajV-S0VA47fXE12SLdj0HS2Ds8ztirGuw@mail.gmail.com>
In-Reply-To: <CAP+JOzSGjo0xFmyfTajV-S0VA47fXE12SLdj0HS2Ds8ztirGuw@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Thu, 12 Oct 2023 13:55:19 -0400
Message-ID: <CAP+JOzSeTKo9SUB6eAkLsqs1gJQVtxUm6Jp-GSJYxdR1YWqfMg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 16/27] libselinux: update string_to_mode()
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Oct 10, 2023 at 11:18=E2=80=AFAM James Carter <jwcart2@gmail.com> w=
rote:
>
> On Mon, Aug 14, 2023 at 9:41=E2=80=AFAM Christian G=C3=B6ttsche
> <cgzones@googlemail.com> wrote:
> >
> > Drop parameter NULL check since the only caller does a NULL check on th=
e
> > argument.
> >
> > Avoid strlen(3) call by comparing by hand.
> >
> > Drop unreachable return statement.
> >
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Acked-by: James Carter <jwcart2@gmail.com>
>
Merged.
Thanks,
Jim

> > ---
> >  libselinux/src/label_file.h | 15 ++++-----------
> >  1 file changed, 4 insertions(+), 11 deletions(-)
> >
> > diff --git a/libselinux/src/label_file.h b/libselinux/src/label_file.h
> > index 190bc175..1363c83c 100644
> > --- a/libselinux/src/label_file.h
> > +++ b/libselinux/src/label_file.h
> > @@ -97,15 +97,10 @@ struct saved_data {
> >         struct selabel_sub *subs;
> >  };
> >
> > -static inline mode_t string_to_mode(char *mode)
> > +static inline mode_t string_to_mode(const char *mode)
> >  {
> > -       size_t len;
> > -
> > -       if (!mode)
> > -               return 0;
> > -       len =3D strlen(mode);
> > -       if (mode[0] !=3D '-' || len !=3D 2)
> > -               return -1;
> > +       if (mode[0] !=3D '-' || mode[1] =3D=3D '\0' || mode[2] !=3D '\0=
')
> > +               return (mode_t)-1;
> >         switch (mode[1]) {
> >         case 'b':
> >                 return S_IFBLK;
> > @@ -122,10 +117,8 @@ static inline mode_t string_to_mode(char *mode)
> >         case '-':
> >                 return S_IFREG;
> >         default:
> > -               return -1;
> > +               return (mode_t)-1;
> >         }
> > -       /* impossible to get here */
> > -       return 0;
> >  }
> >
> >  static inline int grow_specs(struct saved_data *data)
> > --
> > 2.40.1
> >
