Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D71AC433FE
	for <selinux@archiver.kernel.org>; Wed,  5 Oct 2022 14:39:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbiJEOjs (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 5 Oct 2022 10:39:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230030AbiJEOjp (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 5 Oct 2022 10:39:45 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B8C49FC6
        for <selinux@vger.kernel.org>; Wed,  5 Oct 2022 07:39:44 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id c7so15408539pgt.11
        for <selinux@vger.kernel.org>; Wed, 05 Oct 2022 07:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=8zJkv1yprIrG58DGKOPVPSaWBAjvB72GkZbtocpVHMM=;
        b=Lb9Hx6WXCYmfesnti0KLcDBUXPi8B6iIRvInYDi4p07FWL2o6D5mNdPb2JZF/z666V
         CvxqUkIVI3yLPxXyk1GOZg7QMcFDy1IsDWFcmsqDKc2xjfW1nlWgT+kXZfEAe+VgJ54M
         JrkpHwQSW+51Q7W3LbXwm5UjobPSMTvpOaHBUBLf4YtlJTQMTKfrUbz65IHSAJDkCSAt
         9VH2uDRMsKUg0sTMkiIoTSX4ojUYYWDb1sjQgSgQ3V5cUNqtmQjXBE+x4+Zeq3WPcLZ5
         KDS2ujlD463hlDm7Drc7PizZK37nwPeqz845OpAgT1L75n5DaDm76HUgBwUzbjCb6wba
         cNww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=8zJkv1yprIrG58DGKOPVPSaWBAjvB72GkZbtocpVHMM=;
        b=UrT1KM62WLWi2GezxycHAoKQi7JgDqW5fsKZ688qQKF3kdJy0I9pJfiziPHemHCCrE
         O5c2CVMeEhEh0SSvQ9CDoqROFMclYPNP2senOCP0KHkN7WgGRFpSzSNIzQG8oZFI/+zu
         jlLBBZd0A2VJpZwFbLPAeCIewdLLkj107n7xvzkJdmRHVV3gZkiT+bwYeDgzAv2ZEZBq
         kovubFnp4gU1Zh1w5ecFGTuBkzwAMew+eYvuJQQMACyrR2VsWvlKv3pd4rC5kq17w486
         pc0oo2Q+BeGo6b6aRwj5JIWYSlQ7ixeKPri+/G7gdsnpsbJ9kCVcuuvkuGxznkUuvF13
         zNlQ==
X-Gm-Message-State: ACrzQf3tGlOv/3X2p64YzJ0a33gZmwcGPDu5DZQHAqSg23ePrAABxs09
        32/qD7/BKSZwB/kZr2+wm3nYLRAo/xv6ikrXCiUYVyee
X-Google-Smtp-Source: AMsMyM7I88DGHtki9YwlktkM4PtlgNbBCG9NZAcFOag+fGkGnipkJafnFgitnC3Uf/d20LuC+UN6oQeuqx/0lNn6Ctg=
X-Received: by 2002:a05:6a00:1a07:b0:541:6060:705d with SMTP id
 g7-20020a056a001a0700b005416060705dmr33625380pfv.61.1664980784314; Wed, 05
 Oct 2022 07:39:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220922180255.2923-1-masheets@linux.microsoft.com>
 <c614d089-31e2-573a-17d0-91eca5e9b218@linux.microsoft.com>
 <1486279f-a1e9-0f03-203c-4a1ee52264d5@linux.microsoft.com> <CAP+JOzTZ-pdooG1xXPiuaGX+4LnHvCCQGEXESk5xAdMadRToLg@mail.gmail.com>
In-Reply-To: <CAP+JOzTZ-pdooG1xXPiuaGX+4LnHvCCQGEXESk5xAdMadRToLg@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Wed, 5 Oct 2022 10:39:33 -0400
Message-ID: <CAP+JOzSsyieb257=DuejPe-C1tCBRaYqAta7QZUnyw--V=4Pvw@mail.gmail.com>
Subject: Re: [PATCH] libsemanage: Allow user to set SYSCONFDIR
To:     Daniel Burgener <dburgener@linux.microsoft.com>
Cc:     Matt Sheets <masheets@linux.microsoft.com>, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Sep 28, 2022 at 11:48 AM James Carter <jwcart2@gmail.com> wrote:
>
> On Thu, Sep 22, 2022 at 2:16 PM Daniel Burgener
> <dburgener@linux.microsoft.com> wrote:
> >
> > On 9/22/2022 2:04 PM, Daniel Burgener wrote:
> > > On 9/22/2022 2:02 PM, Matt Sheets wrote:
> > >> This change will allow a user to set the location of their
> > >> sysconfdir, defaulted to /etc, if they are installing into
> > >> nonstandard locations.
> > >>
> > >> Signed-off-by: Matt Sheets <masheets@linux.microsoft.com>
>
> Acked-by: James Carter <jwcart2@gmail.com>
>

Merged.
Thanks,
Jim

> > >> ---
> > >>   libsemanage/src/Makefile | 3 ++-
> > >>   1 file changed, 2 insertions(+), 1 deletion(-)
> > >>
> > >> diff --git a/libsemanage/src/Makefile b/libsemanage/src/Makefile
> > >> index 71c2a1d2..01df0181 100644
> > >> --- a/libsemanage/src/Makefile
> > >> +++ b/libsemanage/src/Makefile
> > >> @@ -11,6 +11,7 @@ PKG_CONFIG ?= pkg-config
> > >>   PREFIX ?= /usr
> > >>   LIBDIR ?= $(PREFIX)/lib
> > >>   INCLUDEDIR ?= $(PREFIX)/include
> > >> +SYSCONFDIR ?= /etc
> > >>   PYINC ?= $(shell $(PKG_CONFIG) --cflags $(PYPREFIX))
> > >>   PYLIBS ?= $(shell $(PKG_CONFIG) --libs $(PYPREFIX))
> > >>   PYTHONLIBDIR ?= $(shell $(PYTHON) -c "from distutils.sysconfig
> > >> import *; print(get_python_lib(plat_specific=1, prefix='$(PREFIX)'))")
> > >> @@ -19,7 +20,7 @@ RUBYINC ?= $(shell $(RUBY) -e 'puts "-I" +
> > >> RbConfig::CONFIG["rubyarchhdrdir"] +
> > >>   RUBYLIBS ?= $(shell $(RUBY) -e 'puts "-L" +
> > >> RbConfig::CONFIG["libdir"] + " -L" + RbConfig::CONFIG["archlibdir"] +
> > >> " " + RbConfig::CONFIG["LIBRUBYARG_SHARED"]')
> > >>   RUBYINSTALL ?= $(shell $(RUBY) -e 'puts
> > >> RbConfig::CONFIG["vendorarchdir"]')
> > >> -DEFAULT_SEMANAGE_CONF_LOCATION=/etc/selinux/semanage.conf
> > >> +DEFAULT_SEMANAGE_CONF_LOCATION=$(SYSCONFDIR)/selinux/semanage.conf
> > >>   ifeq ($(DEBUG),1)
> > >>       export CFLAGS ?= -g3 -O0 -gdwarf-2 -fno-strict-aliasing -Wall
> > >> -Wshadow -Werror
> > >
> > > That looks good thanks.  Sorry, one last request.  This is a generic
> > > yocto issue, right?  Are you able to provide publicly visible links to
> > > the upstream yocto project in the git commit message to justify why
> > > using a nonstandard /etc is a normal/reasonable thing to do?
> >
> > Oops, I'd been discussing this with Matt, and didn't realize this one
> > hit the public list :)  Just trying to improve the rationale/justification.
> >
> > Regarding the actual change:
> >
> > Reviewed-by: Daniel Burgener <dburgener@linux.microsoft.com>
