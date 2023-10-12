Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AFA0CDB46E
	for <selinux@archiver.kernel.org>; Thu, 12 Oct 2023 17:56:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441911AbjJLR4J (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 12 Oct 2023 13:56:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1441848AbjJLR4I (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 12 Oct 2023 13:56:08 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B019FBB
        for <selinux@vger.kernel.org>; Thu, 12 Oct 2023 10:56:06 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-5041bb9ce51so1664777e87.1
        for <selinux@vger.kernel.org>; Thu, 12 Oct 2023 10:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697133365; x=1697738165; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bu2Qz4WX0NnQdRJj6yZMCYMVpN2CrddvugihVxrlzEE=;
        b=afvp7ITLEvwiBCDXOiOyo3PDK5taOPdH/Nk7Bh7i8g41yOOY1/AGvSAK7cQjpTgoda
         N74r2Ta+u+5K5iV8oc2/yDfEUroKZIOfvh7T7peJjztNgAMOKryPwnDqxP9SpaBZjsVl
         PtCctAjh/dilaxcJXho116QymByJ7HYgVH4/hTk6tA7Y26DjIhwBRj6AsWCKtkAO6xal
         0kJMK7Rvz91M2xwKzBpXc/RI1xRhETGZQFzJ+o0ddqYnu2tZipITBv7QVoXG+OYM4kyP
         nUJjU85k2Dou1vgQ8cl9us36MckGH7GosEpkG0mNHQOsJ+Au1s2mSAoVnE97z2l6BeSj
         I+uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697133365; x=1697738165;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bu2Qz4WX0NnQdRJj6yZMCYMVpN2CrddvugihVxrlzEE=;
        b=PZzS/I9HdWtEF4bIpPQ6Ki11LJ+ruivW2+EHCWOhByEnKOtRspnhAJqDfIPE+NSut+
         K10xoIXIpm279ww9ZD89avpn9sjtIhKrKYlw2qiozGajBGzqkX5ZcC52X7h5PI3rv1md
         v6xUEmycTLFrrbasQyIoAw6QmFbhHsF0nLAAVU4A90ZpTq4HihWIyZeCllXE0iSf80ju
         x4LFKQD0I2i9OftGCxaoVDoUYVIdWmobl+LbaPIb4VdbOA/1ZY4PlU+5CtgJa9sg3tLE
         0MP5B+j6oDemtDqAgR5EKO2Qw8JiW2l+srXUiUqegVdsB6wA/b68y/RheIvXRdKMhGGT
         liUA==
X-Gm-Message-State: AOJu0YwnFx9hGMlOc1qpYimkRdnndkzBfi5AVV6BqPiCAPTyjy9bvdX7
        Rd3nTBuo5aB/p3eMjbUmgxCuZVSttPaju/dDBWLa8ugx4PQ=
X-Google-Smtp-Source: AGHT+IEDsrNjZtUJ9GGn5L9Xn/+LYjv6ZwiaXJb2qL0VtPDfiCcupn7Y7FcEqJ9Br8rVmxjEAZa6aMUA+tWqaWFncGM=
X-Received: by 2002:a05:6512:1089:b0:503:3808:389a with SMTP id
 j9-20020a056512108900b005033808389amr25087163lfg.11.1697133364723; Thu, 12
 Oct 2023 10:56:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230814132025.45364-1-cgzones@googlemail.com>
 <20230814132025.45364-20-cgzones@googlemail.com> <CAP+JOzSaSUuZJjEv0HC+SC_ZJMr=GRqOMa87QhFaRjp=ZHY-5g@mail.gmail.com>
In-Reply-To: <CAP+JOzSaSUuZJjEv0HC+SC_ZJMr=GRqOMa87QhFaRjp=ZHY-5g@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Thu, 12 Oct 2023 13:55:53 -0400
Message-ID: <CAP+JOzTzsA3d5bv9Vnhf7Jmcn=atNmVgATJo0-DzwxFL0Hbi-A@mail.gmail.com>
Subject: Re: [RFC PATCH v2 19/27] libselinux: avoid unused function
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Oct 10, 2023 at 3:15=E2=80=AFPM James Carter <jwcart2@gmail.com> wr=
ote:
>
> On Mon, Aug 14, 2023 at 9:41=E2=80=AFAM Christian G=C3=B6ttsche
> <cgzones@googlemail.com> wrote:
> >
> > Define selabel_subs_init() only if its call-sites are enabled.
> >
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Acked-by: James Carter <jwcart2@gmail.com>
>
Merged.
Thanks,
Jim

> > ---
> >  libselinux/src/label_file.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c
> > index f9f4648a..471fd56b 100644
> > --- a/libselinux/src/label_file.c
> > +++ b/libselinux/src/label_file.c
> > @@ -674,6 +674,7 @@ static char *selabel_sub(struct selabel_sub *ptr, c=
onst char *src)
> >         return NULL;
> >  }
> >
> > +#if !defined(BUILD_HOST) && !defined(ANDROID)
> >  static int selabel_subs_init(const char *path, struct selabel_digest *=
digest,
> >                        struct selabel_sub **out_subs)
> >  {
> > @@ -756,6 +757,7 @@ err:
> >         }
> >         goto out;
> >  }
> > +#endif
> >
> >  static char *selabel_sub_key(struct saved_data *data, const char *key)
> >  {
> > --
> > 2.40.1
> >
