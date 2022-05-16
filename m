Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F91DC433EF
	for <selinux@archiver.kernel.org>; Mon, 16 May 2022 17:08:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238802AbiEPRIs (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 16 May 2022 13:08:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233953AbiEPRIr (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 16 May 2022 13:08:47 -0400
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 485A4275F2
        for <selinux@vger.kernel.org>; Mon, 16 May 2022 10:08:43 -0700 (PDT)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-edeb6c3642so20992350fac.3
        for <selinux@vger.kernel.org>; Mon, 16 May 2022 10:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X6xjAbay/0nXr0qnQCVIObvRZkq2eDP+KnFjvSx3N3Q=;
        b=MgYx9R7NswH+z0MGNZ4/AWF3RbueUbi6231efT3olq2STiXsN4IM8XTSSXJPS5CoW/
         8TqHYFpcvdkRxDq/38RQwUEXobHFzlShof+4h4d8vSFubNCtZDyu4PuTHgcyJlkQQQSV
         MUDZpS2q7iGciHnhhfsDB7oApF+4bBZvjJrw+9ESilwYR96rx+U7duJU7oE07hVYel0a
         /P0ame64RBU+ArTWyJ+k5+iQk/qnjzlK4I2PJE/7CVUpqlS0cPQ24FwEekKjrOvXgfAA
         Aysvod8LuEjdrS4yIaZn6ONGLHZABu4Ft1mNc+s1dxhiTBTzvGjM34w5heCixzkWJWjW
         sCJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X6xjAbay/0nXr0qnQCVIObvRZkq2eDP+KnFjvSx3N3Q=;
        b=bdQfkmV3m7aVckiD1TR/FUl9+frWp7d/EDXIxY/eF0T8IQGTPAdJ6Y3NBnmjcUlNik
         O6RQwUb/XahmrrrsNPxYZa6k630P0RxtIvlmR8FE1ynpFDSgbJtmdIoux9Z2/9k2IXtB
         mnvWKLk9xwjfYFkhFIhqLkz3938PBnzSOudMh0KiwjihK7TFZTVbFTvT1hsWMCm3Tj52
         amCaXOgv+jPz0hpdMHoHR2FQ2NRZlHhulzvIy0h5OA6xNj2xX9T9FXci/dKG4ffmORKt
         V7qUTL0bFta7tpnNynrn6bxaVhIKOTsd7tcUZoqqowI2Usc4uaWC2fMJj5xm8nUnh0+i
         0Jng==
X-Gm-Message-State: AOAM530miHUdbiNjxfFE9nu/rcI+2s0K6MZBRE2B03+md0hZjY3PkLnm
        RKnZ9x7p3FH5i8lz+v3O4PAgA9mRMy+eqzeRS77r6a6V
X-Google-Smtp-Source: ABdhPJxJPgLqk7oeoxMcswG6Qi8KFigWrKH7v2lAUfkNUdkcRB4hvkC8mduJmXFoM6z4/6ZJu1PuyGeqtkR7HDGTg0Q=
X-Received: by 2002:a05:6870:c692:b0:e9:5368:10df with SMTP id
 cv18-20020a056870c69200b000e9536810dfmr10079658oab.182.1652720922499; Mon, 16
 May 2022 10:08:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220506140623.736036-1-vmojzis@redhat.com> <CAP+JOzRHZrjAv3UUkbBD=E0SPWgv47PnVyme9bKGNwHAu7DEng@mail.gmail.com>
In-Reply-To: <CAP+JOzRHZrjAv3UUkbBD=E0SPWgv47PnVyme9bKGNwHAu7DEng@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Mon, 16 May 2022 13:08:31 -0400
Message-ID: <CAP+JOzT_9vVsz6G+xg2F9cMXVgvda+gBcGOHVYwrXrjULO0n7A@mail.gmail.com>
Subject: Re: [PATCH] gettext: set _ on module level instead of builtins namespace
To:     Vit Mojzis <vmojzis@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, May 12, 2022 at 3:37 PM James Carter <jwcart2@gmail.com> wrote:
>
> On Sun, May 8, 2022 at 10:48 PM Vit Mojzis <vmojzis@redhat.com> wrote:
> >
> > Some calls to "_" where unsuccessful because the function was
> > initialized with a different translation domain than the string.
> > e.g. selinux-polgengui calls functions from sepolicy.generate, which end
> > up printing untranslated strings because polgengui uses selinux-gui
> > domain while sepolicy uses selinux-python
> >
> > - Set "_" in module namespace instead of "builtins"
> > - Set the whole "sepolicy.generate()" confirmation as translatable
> > - Drop "codeset" parameter since it is deprecated
> >
> > Signed-off-by: Vit Mojzis <vmojzis@redhat.com>
>
> Acked-by: James Carter <jwcart2@gmail.com>

Merged.
Thanks,
Jim

>
> > ---
> >  gui/booleansPage.py                   | 4 ++--
> >  gui/domainsPage.py                    | 4 ++--
> >  gui/fcontextPage.py                   | 4 ++--
> >  gui/loginsPage.py                     | 4 ++--
> >  gui/modulesPage.py                    | 4 ++--
> >  gui/polgengui.py                      | 4 ++--
> >  gui/portsPage.py                      | 4 ++--
> >  gui/semanagePage.py                   | 4 ++--
> >  gui/statusPage.py                     | 4 ++--
> >  gui/system-config-selinux.py          | 4 ++--
> >  gui/usersPage.py                      | 4 ++--
> >  python/chcat/chcat                    | 4 ++--
> >  python/semanage/semanage              | 4 ++--
> >  python/semanage/seobject.py           | 4 ++--
> >  python/sepolicy/sepolicy.py           | 4 ++--
> >  python/sepolicy/sepolicy/__init__.py  | 4 ++--
> >  python/sepolicy/sepolicy/generate.py  | 6 +++---
> >  python/sepolicy/sepolicy/gui.py       | 4 ++--
> >  python/sepolicy/sepolicy/interface.py | 4 ++--
> >  sandbox/sandbox                       | 4 ++--
> >  20 files changed, 41 insertions(+), 41 deletions(-)
> >
> > diff --git a/gui/booleansPage.py b/gui/booleansPage.py
> > index dd12b6d6..5beec58b 100644
> > --- a/gui/booleansPage.py
> > +++ b/gui/booleansPage.py
> > @@ -44,10 +44,10 @@ try:
> >      kwargs = {}
> >      if sys.version_info < (3,):
> >          kwargs['unicode'] = True
> > -    gettext.install(PROGNAME,
> > +    t = gettext.translation(PROGNAME,
> >                      localedir="/usr/share/locale",
> > -                    codeset='utf-8',
> >                      **kwargs)
> > +    _ = t.gettext
> >  except:
> >      try:
> >          import builtins
> > diff --git a/gui/domainsPage.py b/gui/domainsPage.py
> > index 6bbe4de5..e08f34b4 100644
> > --- a/gui/domainsPage.py
> > +++ b/gui/domainsPage.py
> > @@ -36,10 +36,10 @@ try:
> >      kwargs = {}
> >      if sys.version_info < (3,):
> >          kwargs['unicode'] = True
> > -    gettext.install(PROGNAME,
> > +    t = gettext.translation(PROGNAME,
> >                      localedir="/usr/share/locale",
> > -                    codeset='utf-8',
> >                      **kwargs)
> > +    _ = t.gettext
> >  except:
> >      try:
> >          import builtins
> > diff --git a/gui/fcontextPage.py b/gui/fcontextPage.py
> > index 52292cae..bac2bec3 100644
> > --- a/gui/fcontextPage.py
> > +++ b/gui/fcontextPage.py
> > @@ -53,10 +53,10 @@ try:
> >      kwargs = {}
> >      if sys.version_info < (3,):
> >          kwargs['unicode'] = True
> > -    gettext.install(PROGNAME,
> > +    t = gettext.translation(PROGNAME,
> >                      localedir="/usr/share/locale",
> > -                    codeset='utf-8',
> >                      **kwargs)
> > +    _ = t.gettext
> >  except:
> >      try:
> >          import builtins
> > diff --git a/gui/loginsPage.py b/gui/loginsPage.py
> > index cbfb0cc2..18b93d8c 100644
> > --- a/gui/loginsPage.py
> > +++ b/gui/loginsPage.py
> > @@ -35,10 +35,10 @@ try:
> >      kwargs = {}
> >      if sys.version_info < (3,):
> >          kwargs['unicode'] = True
> > -    gettext.install(PROGNAME,
> > +    t = gettext.translation(PROGNAME,
> >                      localedir="/usr/share/locale",
> > -                    codeset='utf-8',
> >                      **kwargs)
> > +    _ = t.gettext
> >  except:
> >      try:
> >          import builtins
> > diff --git a/gui/modulesPage.py b/gui/modulesPage.py
> > index 35a0129b..c546d455 100644
> > --- a/gui/modulesPage.py
> > +++ b/gui/modulesPage.py
> > @@ -36,10 +36,10 @@ try:
> >      kwargs = {}
> >      if sys.version_info < (3,):
> >          kwargs['unicode'] = True
> > -    gettext.install(PROGNAME,
> > +    t = gettext.translation(PROGNAME,
> >                      localedir="/usr/share/locale",
> > -                    codeset='utf-8',
> >                      **kwargs)
> > +    _ = t.gettext
> >  except:
> >      try:
> >          import builtins
> > diff --git a/gui/polgengui.py b/gui/polgengui.py
> > index 01f541ba..a18f1cba 100644
> > --- a/gui/polgengui.py
> > +++ b/gui/polgengui.py
> > @@ -69,10 +69,10 @@ try:
> >      kwargs = {}
> >      if sys.version_info < (3,):
> >          kwargs['unicode'] = True
> > -    gettext.install(PROGNAME,
> > +    t = gettext.translation(PROGNAME,
> >                      localedir="/usr/share/locale",
> > -                    codeset='utf-8',
> >                      **kwargs)
> > +    _ = t.gettext
> >  except:
> >      try:
> >          import builtins
> > diff --git a/gui/portsPage.py b/gui/portsPage.py
> > index a537ecc8..54aa80de 100644
> > --- a/gui/portsPage.py
> > +++ b/gui/portsPage.py
> > @@ -41,10 +41,10 @@ try:
> >      kwargs = {}
> >      if sys.version_info < (3,):
> >          kwargs['unicode'] = True
> > -    gettext.install(PROGNAME,
> > +    t = gettext.translation(PROGNAME,
> >                      localedir="/usr/share/locale",
> > -                    codeset='utf-8',
> >                      **kwargs)
> > +    _ = t.gettext
> >  except:
> >      try:
> >          import builtins
> > diff --git a/gui/semanagePage.py b/gui/semanagePage.py
> > index 5361d69c..1371d4e7 100644
> > --- a/gui/semanagePage.py
> > +++ b/gui/semanagePage.py
> > @@ -28,10 +28,10 @@ try:
> >      kwargs = {}
> >      if sys.version_info < (3,):
> >          kwargs['unicode'] = True
> > -    gettext.install(PROGNAME,
> > +    t = gettext.translation(PROGNAME,
> >                      localedir="/usr/share/locale",
> > -                    codeset='utf-8',
> >                      **kwargs)
> > +    _ = t.gettext
> >  except:
> >      try:
> >          import builtins
> > diff --git a/gui/statusPage.py b/gui/statusPage.py
> > index a8f079b9..c241ef83 100644
> > --- a/gui/statusPage.py
> > +++ b/gui/statusPage.py
> > @@ -41,10 +41,10 @@ try:
> >      kwargs = {}
> >      if sys.version_info < (3,):
> >          kwargs['unicode'] = True
> > -    gettext.install(PROGNAME,
> > +    t = gettext.translation(PROGNAME,
> >                      localedir="/usr/share/locale",
> > -                    codeset='utf-8',
> >                      **kwargs)
> > +    _ = t.gettext
> >  except:
> >      try:
> >          import builtins
> > diff --git a/gui/system-config-selinux.py b/gui/system-config-selinux.py
> > index 8c46c987..1b460c99 100644
> > --- a/gui/system-config-selinux.py
> > +++ b/gui/system-config-selinux.py
> > @@ -51,10 +51,10 @@ try:
> >      kwargs = {}
> >      if sys.version_info < (3,):
> >          kwargs['unicode'] = True
> > -    gettext.install(PROGNAME,
> > +    t = gettext.translation(PROGNAME,
> >                      localedir="/usr/share/locale",
> > -                    codeset='utf-8',
> >                      **kwargs)
> > +    _ = t.gettext
> >  except:
> >      try:
> >          import builtins
> > diff --git a/gui/usersPage.py b/gui/usersPage.py
> > index d15d4c5a..d51bd968 100644
> > --- a/gui/usersPage.py
> > +++ b/gui/usersPage.py
> > @@ -35,10 +35,10 @@ try:
> >      kwargs = {}
> >      if sys.version_info < (3,):
> >          kwargs['unicode'] = True
> > -    gettext.install(PROGNAME,
> > +    t = gettext.translation(PROGNAME,
> >                      localedir="/usr/share/locale",
> > -                    codeset='utf-8',
> >                      **kwargs)
> > +    _ = t.gettext
> >  except:
> >      try:
> >          import builtins
> > diff --git a/python/chcat/chcat b/python/chcat/chcat
> > index 839ddd3b..e779fcc6 100755
> > --- a/python/chcat/chcat
> > +++ b/python/chcat/chcat
> > @@ -36,10 +36,10 @@ try:
> >      kwargs = {}
> >      if sys.version_info < (3,):
> >          kwargs['unicode'] = True
> > -    gettext.install(PROGNAME,
> > +    t = gettext.translation(PROGNAME,
> >                      localedir="/usr/share/locale",
> > -                    codeset='utf-8',
> >                      **kwargs)
> > +    _ = t.gettext
> >  except ImportError:
> >      try:
> >          import builtins
> > diff --git a/python/semanage/semanage b/python/semanage/semanage
> > index 12bb159e..8f4e44a7 100644
> > --- a/python/semanage/semanage
> > +++ b/python/semanage/semanage
> > @@ -36,10 +36,10 @@ try:
> >      kwargs = {}
> >      if sys.version_info < (3,):
> >          kwargs['unicode'] = True
> > -    gettext.install(PROGNAME,
> > +    t = gettext.translation(PROGNAME,
> >                      localedir="/usr/share/locale",
> > -                    codeset='utf-8',
> >                      **kwargs)
> > +    _ = t.gettext
> >  except:
> >      try:
> >          import builtins
> > diff --git a/python/semanage/seobject.py b/python/semanage/seobject.py
> > index 69e60db8..ff8f4e9c 100644
> > --- a/python/semanage/seobject.py
> > +++ b/python/semanage/seobject.py
> > @@ -40,10 +40,10 @@ try:
> >      kwargs = {}
> >      if sys.version_info < (3,):
> >          kwargs['unicode'] = True
> > -    gettext.install(PROGNAME,
> > +    t = gettext.translation(PROGNAME,
> >                      localedir="/usr/share/locale",
> > -                    codeset='utf-8',
> >                      **kwargs)
> > +    _ = t.gettext
> >  except:
> >      try:
> >          import builtins
> > diff --git a/python/sepolicy/sepolicy.py b/python/sepolicy/sepolicy.py
> > index 32956e58..7ebe0efa 100755
> > --- a/python/sepolicy/sepolicy.py
> > +++ b/python/sepolicy/sepolicy.py
> > @@ -34,10 +34,10 @@ try:
> >      kwargs = {}
> >      if sys.version_info < (3,):
> >          kwargs['unicode'] = True
> > -    gettext.install(PROGNAME,
> > +    t = gettext.translation(PROGNAME,
> >                      localedir="/usr/share/locale",
> > -                    codeset='utf-8',
> >                      **kwargs)
> > +    _ = t.gettext
> >  except:
> >      try:
> >          import builtins
> > diff --git a/python/sepolicy/sepolicy/__init__.py b/python/sepolicy/sepolicy/__init__.py
> > index 203ca25f..7208234b 100644
> > --- a/python/sepolicy/sepolicy/__init__.py
> > +++ b/python/sepolicy/sepolicy/__init__.py
> > @@ -29,10 +29,10 @@ try:
> >      kwargs = {}
> >      if sys.version_info < (3,):
> >          kwargs['unicode'] = True
> > -    gettext.install(PROGNAME,
> > +    t = gettext.translation(PROGNAME,
> >                      localedir="/usr/share/locale",
> > -                    codeset='utf-8',
> >                      **kwargs)
> > +    _ = t.gettext
> >  except:
> >      try:
> >          import builtins
> > diff --git a/python/sepolicy/sepolicy/generate.py b/python/sepolicy/sepolicy/generate.py
> > index 43180ca6..67189fc3 100644
> > --- a/python/sepolicy/sepolicy/generate.py
> > +++ b/python/sepolicy/sepolicy/generate.py
> > @@ -54,10 +54,10 @@ try:
> >      kwargs = {}
> >      if sys.version_info < (3,):
> >          kwargs['unicode'] = True
> > -    gettext.install(PROGNAME,
> > +    t = gettext.translation(PROGNAME,
> >                      localedir="/usr/share/locale",
> > -                    codeset='utf-8',
> >                      **kwargs)
> > +    _ = t.gettext
> >  except:
> >      try:
> >          import builtins
> > @@ -1372,7 +1372,7 @@ Warning %s does not exist
> >          fd.close()
> >
> >      def generate(self, out_dir=os.getcwd()):
> > -        out = "Created the following files:\n"
> > +        out = _("Created the following files:\n")
> >          out += "%s # %s\n" % (self.write_te(out_dir), _("Type Enforcement file"))
> >          out += "%s # %s\n" % (self.write_if(out_dir), _("Interface file"))
> >          out += "%s # %s\n" % (self.write_fc(out_dir), _("File Contexts file"))
> > diff --git a/python/sepolicy/sepolicy/gui.py b/python/sepolicy/sepolicy/gui.py
> > index 4f892f82..b0263740 100644
> > --- a/python/sepolicy/sepolicy/gui.py
> > +++ b/python/sepolicy/sepolicy/gui.py
> > @@ -47,10 +47,10 @@ try:
> >      kwargs = {}
> >      if sys.version_info < (3,):
> >          kwargs['unicode'] = True
> > -    gettext.install(PROGNAME,
> > +    t = gettext.translation(PROGNAME,
> >                      localedir="/usr/share/locale",
> > -                    codeset='utf-8',
> >                      **kwargs)
> > +    _ = t.gettext
> >  except:
> >      try:
> >          import builtins
> > diff --git a/python/sepolicy/sepolicy/interface.py b/python/sepolicy/sepolicy/interface.py
> > index 9d40aea1..599f97fd 100644
> > --- a/python/sepolicy/sepolicy/interface.py
> > +++ b/python/sepolicy/sepolicy/interface.py
> > @@ -36,10 +36,10 @@ try:
> >      kwargs = {}
> >      if sys.version_info < (3,):
> >          kwargs['unicode'] = True
> > -    gettext.install(PROGNAME,
> > +    t = gettext.translation(PROGNAME,
> >                      localedir="/usr/share/locale",
> > -                    codeset='utf-8',
> >                      **kwargs)
> > +    _ = t.gettext
> >  except:
> >      try:
> >          import builtins
> > diff --git a/sandbox/sandbox b/sandbox/sandbox
> > index 16c43b51..cd5709fb 100644
> > --- a/sandbox/sandbox
> > +++ b/sandbox/sandbox
> > @@ -43,10 +43,10 @@ try:
> >      kwargs = {}
> >      if sys.version_info < (3,):
> >          kwargs['unicode'] = True
> > -    gettext.install(PROGNAME,
> > +    t = gettext.translation(PROGNAME,
> >                      localedir="/usr/share/locale",
> > -                    codeset='utf-8',
> >                      **kwargs)
> > +    _ = t.gettext
> >  except:
> >      try:
> >          import builtins
> > --
> > 2.35.1
> >
