Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8879DCDB46E
	for <selinux@archiver.kernel.org>; Thu, 12 Oct 2023 19:00:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344140AbjJLTAy (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 12 Oct 2023 15:00:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347370AbjJLTAx (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 12 Oct 2023 15:00:53 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE81ECC
        for <selinux@vger.kernel.org>; Thu, 12 Oct 2023 12:00:51 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-50307acd445so1691631e87.0
        for <selinux@vger.kernel.org>; Thu, 12 Oct 2023 12:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697137250; x=1697742050; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+xup227C78mCGL8k0FNTDnmxabuoytsAlQ6fbiCcaqM=;
        b=NWdBHuWF55i2c0LvxF5ZqRKzslLgdWaVbpVKSsDaa8lba7wIOBIOX9Pd9oX7jPPh6o
         BOiupWlAwZa3k5d3PKzoaSm/EuD3RlqL7hafirCn/4MpdGJUfDoe3gKw9G5+Lg32SJYW
         ymaObB+J5HLPyLv0gfh4oxCSUg9lUPNgDa2Y3filIcPigSHi7+VNVF7SLER11i5i1YiQ
         buHE2V+tdK19iJm7YhGv7LPfMmSTSG/oQVLJolNgDPte/rN/wCxw6ikZFmIxlnqwKvBp
         eQBZII6A64V8X7bFpXGd5NuoEIryvtYVGApIFGtFblQ2ukf3g1IIQ5z+eYFkuMEPjUfJ
         JyFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697137250; x=1697742050;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+xup227C78mCGL8k0FNTDnmxabuoytsAlQ6fbiCcaqM=;
        b=CYHuNFbcMwPypt36KtqFPQZTbweRKAYVGTpvnKJEliNu4SoxNxBUtLa3i9oM0wy6BN
         jdXgZO1ch5Ua5v4JEsDBMlFzO/6xz8lCLgI4yqsoFg7CXUcVamAynlJAKTjxRRLeDFNm
         iYdagyBdHKKwKWwbxh6dyg0x4uubhFxONt0ItNEaCGkP3EpMcN3quVOqVw0gCqDd5+K4
         xJ/LGhge5BNPoqeeQ5EG43edpes3JO0jo8SYUeh5A7BqqLjlgaSBryN0x73vS9Z6rY93
         a7gz/OOuYI+yrPbOuh9OueTjlLK6BBL6cRFRXMpXBxesMkPaOY5Y81KU2Df34X29naU4
         bhnA==
X-Gm-Message-State: AOJu0YzR/sNsjgeKeDeiRR4379lKSHeq7MebaTIP2psBQEMc43l7kgqe
        sFN3ZaQCYnitX87oiu3TKoZ13d79RnljVTjk8cdB+tOg
X-Google-Smtp-Source: AGHT+IH7Joz2UA1bfv0S99krFseaR+fU4AFTFCy2no1G2dZd2k3mFsdVL/weYAN64i9if0p9XWhz9N6NqRqRChQQyeU=
X-Received: by 2002:a05:6512:280d:b0:501:bee7:487b with SMTP id
 cf13-20020a056512280d00b00501bee7487bmr23894874lfb.11.1697137249708; Thu, 12
 Oct 2023 12:00:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230814132025.45364-1-cgzones@googlemail.com>
 <20230814132025.45364-23-cgzones@googlemail.com> <CAP+JOzRTxy+feD3cX6e-r+k4XM1X+4UOhB71Q8jrYywWOhOBtw@mail.gmail.com>
In-Reply-To: <CAP+JOzRTxy+feD3cX6e-r+k4XM1X+4UOhB71Q8jrYywWOhOBtw@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Thu, 12 Oct 2023 15:00:37 -0400
Message-ID: <CAP+JOzQ_Ao5E+4=ccxGGviEB_EhUFt8tJQKWJA5XfM1qU_-w-w@mail.gmail.com>
Subject: Re: [RFC PATCH v2 22/27] libselinux/utils: drop include of internal
 header file
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Oct 11, 2023 at 2:49=E2=80=AFPM James Carter <jwcart2@gmail.com> wr=
ote:
>
> On Mon, Aug 14, 2023 at 9:42=E2=80=AFAM Christian G=C3=B6ttsche
> <cgzones@googlemail.com> wrote:
> >
> > selabel_get_digest_all_partial_matches is dynamically linked against
> > libselinux, so it should not depend on any internals and thus do not
> > make use of an internal header file
> >
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Acked-by: James Carter <jwcart2@gmail.com>
>
Merged.
Thanks,
Jim


> > ---
> >  libselinux/utils/selabel_get_digests_all_partial_matches.c | 2 --
> >  1 file changed, 2 deletions(-)
> >
> > diff --git a/libselinux/utils/selabel_get_digests_all_partial_matches.c=
 b/libselinux/utils/selabel_get_digests_all_partial_matches.c
> > index c4e0f836..e2733b41 100644
> > --- a/libselinux/utils/selabel_get_digests_all_partial_matches.c
> > +++ b/libselinux/utils/selabel_get_digests_all_partial_matches.c
> > @@ -8,8 +8,6 @@
> >  #include <selinux/selinux.h>
> >  #include <selinux/label.h>
> >
> > -#include "../src/label_file.h"
> > -
> >  static __attribute__ ((__noreturn__)) void usage(const char *progname)
> >  {
> >         fprintf(stderr,
> > --
> > 2.40.1
> >
