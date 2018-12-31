Return-Path: <SRS0=CIh3=PI=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3A52C43387
	for <selinux@archiver.kernel.org>; Mon, 31 Dec 2018 16:08:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA2FD213A2
	for <selinux@archiver.kernel.org>; Mon, 31 Dec 2018 16:08:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ppHuZns9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727465AbeLaQIv (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 31 Dec 2018 11:08:51 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:33622 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727376AbeLaQIv (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 31 Dec 2018 11:08:51 -0500
Received: by mail-ot1-f66.google.com with SMTP id i20so23700627otl.0
        for <selinux@vger.kernel.org>; Mon, 31 Dec 2018 08:08:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KpVuvdlCX8P4sX30urB2/K07BIFVQNMO72VNJc8jdzs=;
        b=ppHuZns9ctA81RBdX1c2HM2proIj7Sf0OmAvvKCmMXLoNNpKtkjlL3cW2d8SgapVoJ
         tKZU5lxb6y3Cv30hqiCm2yOGubVEWdCDn8cMb784htXyJDLqllY/hPrrdwiAc9aKXe3F
         TrcjWHeNWylnmHIvy1l+hLGT5oiykOYppA7aoYT5bNbJOaS3jNnhHYiLdUF0b9NaQsPo
         oeOzfe+7RFuhaX4nGp6B2vFdyAe/Y0TFQu3eATGYQ4S/tthXgcj4dkdy9RMqXvkoGB61
         6NGAiODC0S2EZx7JaL6ssXKO3phHA/maZCFOWR65yzB4JasVZ6KXZnwKthJb8+xosfSY
         hqqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KpVuvdlCX8P4sX30urB2/K07BIFVQNMO72VNJc8jdzs=;
        b=gFeKCDJ1WqEf2w1QwtDNS1etNWz0xio13c5ChRCAtFR8wj02lN9hA5n6xBGQqMpL2Y
         QrLHMi66k2lcKrpC92orH7sUds5AzyX5IVo34/qtP04M8wlLOo7stFMwqieP1MznKk9A
         vNmE3+NHviLtcgQVtgoDdz5PNyOknn9EhMOtOJK5+fdVZafx8swsI2tyNWRS0K2BEV5P
         +vAfp4656e3H7O/w9ZhAIwBCUJ3HVgI5hQLMDHOQwbwp43W5OoeBm18r80pckMVdcVZV
         yyfKC87E5pNw8bplzqIGDmlyjaRBVs6TFhcmkXBM2fLfGgONF8ilnkhZYcg/1R7tqrgT
         YnmA==
X-Gm-Message-State: AJcUukfBeleQhOrhAUMWDSkDbRo7VQFrZoA83HBWHrbD0Zn+ClFTvnuY
        BhgRmX6iuvQJ9v3bGQjxp32lGR21rxhOchXRD/wnODGN
X-Google-Smtp-Source: ALg8bN450kG7xFrGinD7jJcFuRq4t1uCUtra2ywgZP18xw7CduutyiIhU2oLgbILEvA9zO0KoagIsB3gSGZAaqgrpug=
X-Received: by 2002:a9d:1ea7:: with SMTP id n36mr26494754otn.217.1546272529538;
 Mon, 31 Dec 2018 08:08:49 -0800 (PST)
MIME-Version: 1.0
References: <1545836068-7824-1-git-send-email-william.c.roberts@intel.com> <20181227142911.GA14910@baraddur.perfinion.com>
In-Reply-To: <20181227142911.GA14910@baraddur.perfinion.com>
From:   William Roberts <bill.c.roberts@gmail.com>
Date:   Mon, 31 Dec 2018 08:08:35 -0800
Message-ID: <CAFftDdqDCVxdHrajJSrxNike0Tr-04WM=FV6Dc8ctUSBSwLjVw@mail.gmail.com>
Subject: Re: [V2 PATCH 1/3] Makefile: fix _FORTIFY_SOURCE redefined build error
To:     Jason Zaman <jason@perfinion.com>
Cc:     selinux@vger.kernel.org, Stephen Smalley <sds@tycho.nsa.gov>,
        William Roberts <william.c.roberts@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Dec 27, 2018 at 6:29 AM Jason Zaman <jason@perfinion.com> wrote:
>
> On Wed, Dec 26, 2018 at 06:54:26AM -0800, bill.c.roberts@gmail.com wrote:
> > From: William Roberts <william.c.roberts@intel.com>
> >
> > Certain builds of gcc enable _FORTIFY_SOURCE which results in the error:
> > <command-line>:0:0: warning: "_FORTIFY_SOURCE" redefined
> > <command-line>:0:0: note: this is the location of the previous definition
> >
> > Correct this by undefining it first and redefining it. Also, the previous
> > command line option was using -Wp which is passing the value *AS IS* to the
> > pre-processor rather than to the compiler driver. The C pre-processor has
> > an undocumented interface subject to change per man 1 gcc. Just use the
> > -D option to specify this value.
> >
> > Signed-off-by: William Roberts <william.c.roberts@intel.com>
>
> Acked-by: Jason Zaman <jason@perfinion.com>

merged: https://github.com/SELinuxProject/selinux/pull/120

>
> The whole series looks good to me, go ahead and apply it. I dont think
> the other parts have had _FORTIFY_SOURCE so after next release (probably
> too soon to apply it now?) we might want to add these same warnings to
> everything else not only libselinux.
>
> -- Jason
>
> > ---
> >  libselinux/src/Makefile   | 2 +-
> >  libselinux/utils/Makefile | 2 +-
> >  2 files changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
> > index 977b5c8cfcca..6263d11393e6 100644
> > --- a/libselinux/src/Makefile
> > +++ b/libselinux/src/Makefile
> > @@ -64,7 +64,7 @@ ifeq ($(COMPILER), gcc)
> >  EXTRA_CFLAGS = -fipa-pure-const -Wlogical-op -Wpacked-bitfield-compat -Wsync-nand \
> >       -Wcoverage-mismatch -Wcpp -Wformat-contains-nul -Wnormalized=nfc -Wsuggest-attribute=const \
> >       -Wsuggest-attribute=noreturn -Wsuggest-attribute=pure -Wtrampolines -Wjump-misses-init \
> > -     -Wno-suggest-attribute=pure -Wno-suggest-attribute=const -Wp,-D_FORTIFY_SOURCE
> > +     -Wno-suggest-attribute=pure -Wno-suggest-attribute=const -U_FORTIFY_SOURCE -D_FORTIFY_SOURCE
> >  else
> >  EXTRA_CFLAGS = -Wunused-command-line-argument
> >  endif
> > diff --git a/libselinux/utils/Makefile b/libselinux/utils/Makefile
> > index d06ffd66893b..890ff36f3bbc 100644
> > --- a/libselinux/utils/Makefile
> > +++ b/libselinux/utils/Makefile
> > @@ -30,7 +30,7 @@ CFLAGS ?= -O -Wall -W -Wundef -Wformat-y2k -Wformat-security -Winit-self -Wmissi
> >            -Wformat-extra-args -Wformat-zero-length -Wformat=2 -Wmultichar \
> >            -Woverflow -Wpointer-to-int-cast -Wpragmas \
> >            -Wno-missing-field-initializers -Wno-sign-compare \
> > -          -Wno-format-nonliteral -Wframe-larger-than=$(MAX_STACK_SIZE) -Wp,-D_FORTIFY_SOURCE \
> > +          -Wno-format-nonliteral -Wframe-larger-than=$(MAX_STACK_SIZE) -U_FORTIFY_SOURCE -D_FORTIFY_SOURCE \
> >            -fstack-protector-all --param=ssp-buffer-size=4 -fexceptions \
> >            -fasynchronous-unwind-tables -fdiagnostics-show-option -funit-at-a-time \
> >            -Werror -Wno-aggregate-return -Wno-redundant-decls \
> > --
> > 2.7.4
> >
