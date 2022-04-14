Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 659E1C433F5
	for <selinux@archiver.kernel.org>; Thu, 14 Apr 2022 18:53:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235851AbiDNS4G (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 14 Apr 2022 14:56:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231168AbiDNS4F (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 14 Apr 2022 14:56:05 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2A0DE0ADF
        for <selinux@vger.kernel.org>; Thu, 14 Apr 2022 11:53:39 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id c11-20020a9d684b000000b00603307cef05so413894oto.3
        for <selinux@vger.kernel.org>; Thu, 14 Apr 2022 11:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=H0SLyAgog6MODXuqiYxzZpEqGpZ/h6LO+9b1dqYNJ7k=;
        b=iEF+zeh6K5krxdNEcvbEcG4bLWrTtR5oLsTzavfoz351mb3bihDc126ajLejz7UEcJ
         2ywGLk5myAgDz7A/xTSw7q8FvAZGfcD6jCR15PfMkqnEv4RxZr+GF8n19XooOnNzbKRy
         h0ZtDhH8h50ZPrEh9cKtJZeVQ4E81pH2J4ybDfuZg8Wp6QuRcdC/F53kgYwX0OMmx2P6
         1ShtuOzOIF5Z8zp5U51RC83lLsBcf2c7lYhaBfIsG6f9LzGUpgTccio4C/v/rhcAneqO
         GOFhrSPy+PkoVraZOC5KmYOlpkXe3ZyJwqHAH8oopTcF4xW7CTa1bjPByAQb0xmMw6qp
         wQ1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=H0SLyAgog6MODXuqiYxzZpEqGpZ/h6LO+9b1dqYNJ7k=;
        b=b5SDGkfPz5/nhun1ermYPGD8XM8FblOIF+CPUY3CC2UlUpJxZELOkWY06SQe34UZrs
         iGuGYLw2t46pFJGcKWm2iZcl+EmmeBpXLLzbZYzx40egZayG3AoNnuLOR6uU50G5FRpq
         otMlWhAS28eyYDXIl+kwi90DfMK+JGrv5KYPE7JKonYoIMNm27CzO215HD8fEyFu26Ny
         +RkS8+dtjreI/9yFFZhuDu1vvGgFQS8yyESFxwJY2J49ZjC2MwSEqQz6+tUcOVDEtdOe
         roBBVDtRrSvag8LZ1BfcuChWo42Hh9iXXXaNvUfoI4VFqK8LNxS26VyZdgU7BA1mX8Bt
         LGdw==
X-Gm-Message-State: AOAM5320LBBDOKkzUyiksLAtz7hcG+efV07MvsWsC+QgL/vZnjru48br
        TTw/tgLrQ/w2WkvWKOakXEEiUiNTQZ0gsdfld0wZ/Avf
X-Google-Smtp-Source: ABdhPJwWfJeQKEqu1Z4ETspT2OV+4hSWvJvI9UQUH283Mj0Akw/pNzEuPAxJB8gg7FbouKANM+SvZ3s03doM2G+lW+4=
X-Received: by 2002:a9d:7842:0:b0:5b2:4dee:79c2 with SMTP id
 c2-20020a9d7842000000b005b24dee79c2mr1454849otm.53.1649962418789; Thu, 14 Apr
 2022 11:53:38 -0700 (PDT)
MIME-Version: 1.0
References: <20220413155633.62677-1-cgzones@googlemail.com> <CAP+JOzQrx0OLTdACuMOucJcTAm0pnDFGYeFkV=XibGqHHfSxXQ@mail.gmail.com>
In-Reply-To: <CAP+JOzQrx0OLTdACuMOucJcTAm0pnDFGYeFkV=XibGqHHfSxXQ@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Thu, 14 Apr 2022 14:53:28 -0400
Message-ID: <CAP+JOzR696tsM4UjU5fvK0y-TyQcgks_ctiP3miEoDoBRNji5g@mail.gmail.com>
Subject: Re: [PATCH 1/3] libselinux: correct parameter type in selabel_open(3)
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Apr 14, 2022 at 2:52 PM James Carter <jwcart2@gmail.com> wrote:
>
> On Wed, Apr 13, 2022 at 1:22 PM Christian G=C3=B6ttsche
> <cgzones@googlemail.com> wrote:
> >
> > selabel_open(3) takes an `unsigned int` as backend parameter.
> >
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Acked-by: James Carter <jwcart2@gmail.com>
For all three patches, of course.

>
> > ---
> >  libselinux/man/man3/selabel_open.3 | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/libselinux/man/man3/selabel_open.3 b/libselinux/man/man3/s=
elabel_open.3
> > index 971ebc1a..c8348ca4 100644
> > --- a/libselinux/man/man3/selabel_open.3
> > +++ b/libselinux/man/man3/selabel_open.3
> > @@ -10,7 +10,7 @@ selabel_open, selabel_close \- userspace SELinux labe=
ling interface
> >  .br
> >  .B #include <selinux/label.h>
> >  .sp
> > -.BI "struct selabel_handle *selabel_open(int " backend ,
> > +.BI "struct selabel_handle *selabel_open(unsigned int " backend ,
> >  .in +\w'struct selabel_handle *selabel_open('u
> >  .BI "const struct selinux_opt *" options ,
> >  .br
> > --
> > 2.35.2
> >
