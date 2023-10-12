Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62373CDB46E
	for <selinux@archiver.kernel.org>; Thu, 12 Oct 2023 17:57:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379725AbjJLR53 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 12 Oct 2023 13:57:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379732AbjJLR5Z (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 12 Oct 2023 13:57:25 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B6C8137
        for <selinux@vger.kernel.org>; Thu, 12 Oct 2023 10:57:13 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2c038a1e2e6so15000911fa.2
        for <selinux@vger.kernel.org>; Thu, 12 Oct 2023 10:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697133431; x=1697738231; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZYHgH2cQUNJIwzVYXgwaXca73G5dMplGrmdv00lmpv0=;
        b=DpGmIr2Z3Lm9BrPCvdOj70LhpV++MLBwalmE/M1uvgoJ+ciJDIsMwIYBlhxTqlJBvw
         eNiLZ6JcXOk9dFCGljY8IIcE0KdZDbIeyGTeBp0lgXB+c2vVdwgKctaqaCrbz+cXhd7o
         sYhGU7LQVv2ZYrJ5aJ2YXs+lWM/qQFBbfdse7Nvf+2tuRfQkY3n6wJSxl/P6YqQUVydF
         9qFwDm51svQUmhQLSNYTtXx7c9/ftuNiTHZadD0YRdRAo1Fdkmxcsa7b/VPHck2Btk+t
         k+7R8Bp7Fl7VYjsF5Sj0XrcKnCfOPAhpisvP/721LLfA5YZ2Bl7xoZ82DqRkP+rNp2fW
         fQCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697133431; x=1697738231;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZYHgH2cQUNJIwzVYXgwaXca73G5dMplGrmdv00lmpv0=;
        b=ihY0mGFRl87siQL60gaG1LmUDlMI4ebCCd6AQM6d0a/sJoaptBgNr+i7OVrxlQN4PV
         Vu3R4GBtGQmRL+YJY+JUBOfB1u1du0uDaSLjj1ljz1xHof44yfYuCP9oNE93bcbWOF4R
         BlDMUULSB2N0/poAiKsoB8LcvQaKZ7Hb9jijMK1cZdqYE66ciGXjHXOC2vspPVaq4B3i
         P2cbH7WAkFPTpiUWBtBewkQyKI8FfUBwww2agWM0gs2WoUNBhB3IX+zQoa3ahbobZGAV
         vJc2bdGGpLYv5zQARIPOzwcLP1KsHskyLsTXaV/Dy2x7ul9oX0tBCDCBubgA7yTyc+Hh
         GPhA==
X-Gm-Message-State: AOJu0YzPbaZfrWuC1y1xuHnirNRDveBjXWVCrjdUIwmQg4Bg0n5BEs/w
        lolAFAfpWVAKpMWg4nKdiIoXBSND1yYxE3H7FT3/h4Pek5E=
X-Google-Smtp-Source: AGHT+IFBZqisuORgCox07yBe+/YR4jLmFQaoiVKronJksrA1WkjpFZWymmic8ECcb0760FhO1hw+rcjBbgfxM2db6H8=
X-Received: by 2002:a05:6512:3608:b0:4ff:9a75:211e with SMTP id
 f8-20020a056512360800b004ff9a75211emr17328246lfs.42.1697133431090; Thu, 12
 Oct 2023 10:57:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230814132025.45364-1-cgzones@googlemail.com>
 <20230814132025.45364-24-cgzones@googlemail.com> <CAP+JOzSnUCL3_vte_4oNfnyOxq-yj+EfFEdpECiux5-qUW9-JQ@mail.gmail.com>
In-Reply-To: <CAP+JOzSnUCL3_vte_4oNfnyOxq-yj+EfFEdpECiux5-qUW9-JQ@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Thu, 12 Oct 2023 13:56:59 -0400
Message-ID: <CAP+JOzS5C+rz83GTsFf2O4EEfJbHMm+GE1ByGmp+pTpawDcYKQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 23/27] libselinux: free elements on
 read_spec_entries() failure
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Oct 11, 2023 at 2:50=E2=80=AFPM James Carter <jwcart2@gmail.com> wr=
ote:
>
> On Mon, Aug 14, 2023 at 9:42=E2=80=AFAM Christian G=C3=B6ttsche
> <cgzones@googlemail.com> wrote:
> >
> > Some entries might have been already parsed and allocated.
> >
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Acked-by: James Carter <jwcart2@gmail.com>
>
Merged.
Thanks,
Jim

> > ---
> > v2: add patch
> > ---
> >  libselinux/src/label_file.h | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/libselinux/src/label_file.h b/libselinux/src/label_file.h
> > index 56439e2d..3827b5c0 100644
> > --- a/libselinux/src/label_file.h
> > +++ b/libselinux/src/label_file.h
> > @@ -446,6 +446,9 @@ static inline int process_line(struct selabel_handl=
e *rec,
> >                                     "%s:  line %u error due to: %m\n", =
path,
> >                                     lineno);
> >                 }
> > +               free(regex);
> > +               free(type);
> > +               free(context);
> >                 return -1;
> >         }
> >
> > --
> > 2.40.1
> >
