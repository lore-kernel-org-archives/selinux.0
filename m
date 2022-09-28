Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69443C54EE9
	for <selinux@archiver.kernel.org>; Wed, 28 Sep 2022 15:49:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233506AbiI1PtB (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 28 Sep 2022 11:49:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233488AbiI1Ps7 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 28 Sep 2022 11:48:59 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24E8ED98F0
        for <selinux@vger.kernel.org>; Wed, 28 Sep 2022 08:48:59 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id l65so12866071pfl.8
        for <selinux@vger.kernel.org>; Wed, 28 Sep 2022 08:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=hEjounuBSA/KW3kVhM5kYRCaO2yofzNOsxkh/GTBwbw=;
        b=jMFMN8fZWU8A8t2DaUg3klBVUnC14ZxLkUK+57voLVPyzQVKQnaebtZFGBBt9bGnpc
         XTqoKBPgyG1aLW48PQ3YzypsJkyutt0K6OM95EIwW9kNYSzK/Bgvjv0TWeMvouQ807LY
         sJDfSvPdEd0Dp+5son/W6I667Ycl03sZEZUq3+DP7hKYM03xWSNMcwC7TCUbMczr6wBc
         pALpWlvO7tC01Ra5lIlbLOWrA3VRTdIX+dM/cEMAxX1clLl4VsSvim00zOrG460uM9N6
         vJiTmcTsYPP/0qTg0ZXeRJ/9U06OVi3fteOi1Mtr4txi5+jCCogqK/STciDcSgG/BJ+l
         7OSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=hEjounuBSA/KW3kVhM5kYRCaO2yofzNOsxkh/GTBwbw=;
        b=2FFkuENhDOdw5Ayr3pDy+HwwvhliiQthqImdElZipLstHjQVBapdNAyAC6nbQptfYj
         7FLNWO7PWmDdqAEVneuUFAwMCCJAq99Y1d7OSf1gKMq5bpwFHsGrXeMbOugjZTBDu9rL
         TEqRpDPfGOya0Zr6FNj17nIQM60GMmmsLE0XnBYUvWRXB0BFBC7a83+P6W2xcQSFX3lV
         1tqkxjZiVD3CZY8CBFzbXRHaPDO9KHJTfKMPzjtONWEQv9rCM8iZ9u66wKFlJdZoReV1
         GbbSRTTot82GOokSeBLIt+LCxmE1dxGWHmD/BGF7eATSfS7WfRmU0nremxvxjv4gAGGR
         rxCQ==
X-Gm-Message-State: ACrzQf1DElFVoVtRvXDcWyIEacaIvhoeUxTHfW7TOI6+nqqnGTQ6lq5w
        0+fKP4HCCeZJS7pHBIUzC8qQIBUfW68OAGiWGvHfWjjGN94=
X-Google-Smtp-Source: AMsMyM5r+n7wGX2GxEKK6P3RR0/PHXhT9SosI2xOzJG4+d0RkLcX7T4nOiO2CI0fUPXURI4pR0BNicePhuR/qf5UCjI=
X-Received: by 2002:a05:6a00:1a07:b0:541:6060:705d with SMTP id
 g7-20020a056a001a0700b005416060705dmr36057826pfv.61.1664380138477; Wed, 28
 Sep 2022 08:48:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220922180255.2923-1-masheets@linux.microsoft.com>
 <c614d089-31e2-573a-17d0-91eca5e9b218@linux.microsoft.com> <1486279f-a1e9-0f03-203c-4a1ee52264d5@linux.microsoft.com>
In-Reply-To: <1486279f-a1e9-0f03-203c-4a1ee52264d5@linux.microsoft.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Wed, 28 Sep 2022 11:48:47 -0400
Message-ID: <CAP+JOzTZ-pdooG1xXPiuaGX+4LnHvCCQGEXESk5xAdMadRToLg@mail.gmail.com>
Subject: Re: [PATCH] libsemanage: Allow user to set SYSCONFDIR
To:     Daniel Burgener <dburgener@linux.microsoft.com>
Cc:     Matt Sheets <masheets@linux.microsoft.com>, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Sep 22, 2022 at 2:16 PM Daniel Burgener
<dburgener@linux.microsoft.com> wrote:
>
> On 9/22/2022 2:04 PM, Daniel Burgener wrote:
> > On 9/22/2022 2:02 PM, Matt Sheets wrote:
> >> This change will allow a user to set the location of their
> >> sysconfdir, defaulted to /etc, if they are installing into
> >> nonstandard locations.
> >>
> >> Signed-off-by: Matt Sheets <masheets@linux.microsoft.com>

Acked-by: James Carter <jwcart2@gmail.com>

> >> ---
> >>   libsemanage/src/Makefile | 3 ++-
> >>   1 file changed, 2 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/libsemanage/src/Makefile b/libsemanage/src/Makefile
> >> index 71c2a1d2..01df0181 100644
> >> --- a/libsemanage/src/Makefile
> >> +++ b/libsemanage/src/Makefile
> >> @@ -11,6 +11,7 @@ PKG_CONFIG ?= pkg-config
> >>   PREFIX ?= /usr
> >>   LIBDIR ?= $(PREFIX)/lib
> >>   INCLUDEDIR ?= $(PREFIX)/include
> >> +SYSCONFDIR ?= /etc
> >>   PYINC ?= $(shell $(PKG_CONFIG) --cflags $(PYPREFIX))
> >>   PYLIBS ?= $(shell $(PKG_CONFIG) --libs $(PYPREFIX))
> >>   PYTHONLIBDIR ?= $(shell $(PYTHON) -c "from distutils.sysconfig
> >> import *; print(get_python_lib(plat_specific=1, prefix='$(PREFIX)'))")
> >> @@ -19,7 +20,7 @@ RUBYINC ?= $(shell $(RUBY) -e 'puts "-I" +
> >> RbConfig::CONFIG["rubyarchhdrdir"] +
> >>   RUBYLIBS ?= $(shell $(RUBY) -e 'puts "-L" +
> >> RbConfig::CONFIG["libdir"] + " -L" + RbConfig::CONFIG["archlibdir"] +
> >> " " + RbConfig::CONFIG["LIBRUBYARG_SHARED"]')
> >>   RUBYINSTALL ?= $(shell $(RUBY) -e 'puts
> >> RbConfig::CONFIG["vendorarchdir"]')
> >> -DEFAULT_SEMANAGE_CONF_LOCATION=/etc/selinux/semanage.conf
> >> +DEFAULT_SEMANAGE_CONF_LOCATION=$(SYSCONFDIR)/selinux/semanage.conf
> >>   ifeq ($(DEBUG),1)
> >>       export CFLAGS ?= -g3 -O0 -gdwarf-2 -fno-strict-aliasing -Wall
> >> -Wshadow -Werror
> >
> > That looks good thanks.  Sorry, one last request.  This is a generic
> > yocto issue, right?  Are you able to provide publicly visible links to
> > the upstream yocto project in the git commit message to justify why
> > using a nonstandard /etc is a normal/reasonable thing to do?
>
> Oops, I'd been discussing this with Matt, and didn't realize this one
> hit the public list :)  Just trying to improve the rationale/justification.
>
> Regarding the actual change:
>
> Reviewed-by: Daniel Burgener <dburgener@linux.microsoft.com>
