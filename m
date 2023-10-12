Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 278D3CDB47E
	for <selinux@archiver.kernel.org>; Thu, 12 Oct 2023 17:55:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441906AbjJLRzv (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 12 Oct 2023 13:55:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1441848AbjJLRzu (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 12 Oct 2023 13:55:50 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 927F5B8
        for <selinux@vger.kernel.org>; Thu, 12 Oct 2023 10:55:49 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-50325ce89e9so1769124e87.0
        for <selinux@vger.kernel.org>; Thu, 12 Oct 2023 10:55:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697133348; x=1697738148; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4fNLyzogvnRDOp6myZ8II3pj5Qo7pHsfp+bJ5VVPLmc=;
        b=OWfYHRCUto2XwDgHpAVeZW5tnheAULvVZL/svtQi6GDfrN1/Icw3f5cAyIyr4Yz6iB
         9BhKJta3HVT2nK3u+MjVrJuhHI43CcvkFxmOAkWXVf6ESlinMV5HUHB814VdHXUa8dSQ
         D5ZJwhbMkkZ13fEs3Iul+/njo45JeP64qxEBd2+ve7Wqb5N+5WK8IuruUJGlxtHu7CQm
         hYxDMgqKNQhbvzM0ZWitWn86YyTXTC2umWb20FhyYmtslTc9wzOpSSKAXMs3EH+Btmya
         U/fzrRNDfX3MOmmxAoE0Q5F/Bc6O4X+7SyTUqZA7+MME1WaXejiO0VJjwcDcKwu3vy95
         2cgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697133348; x=1697738148;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4fNLyzogvnRDOp6myZ8II3pj5Qo7pHsfp+bJ5VVPLmc=;
        b=gZJ2i75tyCC+34G86SX+I7bguC3lObLRJm72veZ6ohmUAFU46zmFL7ZhkSzs2jpR74
         7dQix0vywuk4JJeO/OawvsDZLAh9c3JF1jBEsz6BJOZqekKqtOqssjV+0iBiaRDJnzVT
         2uu17NJdit3Vs1yUqu/7h40MFgOk05wU5Pb7OJoGyXobc5KYfIDuiJd7i6owurcbMS71
         zY4EQWGHnBLMppFFvIm2EfWSbQNDYe3WQ2ldlnxneF3YSWBtlE6ZGzLY7wdbufB4ux6J
         d5wAJ48ADYOk5TDolVgFjmg4R/UAKrnyzFmWvgiGwg8e7gjA7LlPszSsCPr6WSF7UpVl
         5KnQ==
X-Gm-Message-State: AOJu0YwhiKxlQaxZJqfrFKZwrl2yFRqYcjPRKrHcaBixkn1o6CX3JP8m
        PW9tlUm/H/gPf62M593ELoUWEA1x0lwPB0E+cW33p4W5tM0=
X-Google-Smtp-Source: AGHT+IEut8v0KtZ6iyrc+jgslQ25F5fgM+8x51tctJZM4/rULBmu7rtgjn01zWJWf+tGTjb6Ov8s6W4x0h2cQ/B6mgk=
X-Received: by 2002:ac2:5f64:0:b0:4fb:7c40:9f97 with SMTP id
 c4-20020ac25f64000000b004fb7c409f97mr19222023lfc.27.1697133347701; Thu, 12
 Oct 2023 10:55:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230814132025.45364-1-cgzones@googlemail.com>
 <20230814132025.45364-19-cgzones@googlemail.com> <CAP+JOzTdSgh0Sf5tf0x0ZE4hmnnCQyUury8A6Kjwx921s9=eVA@mail.gmail.com>
In-Reply-To: <CAP+JOzTdSgh0Sf5tf0x0ZE4hmnnCQyUury8A6Kjwx921s9=eVA@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Thu, 12 Oct 2023 13:55:36 -0400
Message-ID: <CAP+JOzQMyG0VRXyfz=YAQ3eVfJWtHNSVU8GnckRFE1u+fNzzDA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 18/27] libselinux: fix logic for building android backend
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Oct 10, 2023 at 3:13=E2=80=AFPM James Carter <jwcart2@gmail.com> wr=
ote:
>
> On Mon, Aug 14, 2023 at 9:42=E2=80=AFAM Christian G=C3=B6ttsche
> <cgzones@googlemail.com> wrote:
> >
> > Fix the typo and adjust the logic accordingly so the android backend is
> > not build by default, but if either ANDROID_HOST or
> > LABEL_BACKEND_ANDROID is set to y.
> >
> > Fixes: c2a58cc52574 ("libselinux: LABEL_BACKEND_ANDROID add option to e=
nable")
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Acked-by: James Carter <jwcart2@gmail.com>
>
Merged.
Thanks,
Jim

> > ---
> >  libselinux/src/Makefile | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> >
> > diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
> > index 15d224e1..86a254da 100644
> > --- a/libselinux/src/Makefile
> > +++ b/libselinux/src/Makefile
> > @@ -131,11 +131,10 @@ DISABLE_FLAGS+=3D -DNO_MEDIA_BACKEND -DNO_DB_BACK=
END -DNO_X_BACKEND \
> >  SRCS=3D callbacks.c freecon.c label.c label_file.c \
> >         label_backends_android.c regex.c label_support.c \
> >         matchpathcon.c setrans_client.c sha1.c booleans.c
> > -else
> >  LABEL_BACKEND_ANDROID=3Dy
> >  endif
> >
> > -ifneq ($(LABEL_BACKEND_ANDROIDT),y)
> > +ifneq ($(LABEL_BACKEND_ANDROID),y)
> >  SRCS:=3D $(filter-out label_backends_android.c, $(SRCS))
> >  DISABLE_FLAGS+=3D -DNO_ANDROID_BACKEND
> >  endif
> > --
> > 2.40.1
> >
