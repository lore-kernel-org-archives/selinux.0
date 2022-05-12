Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06BB5C433EF
	for <selinux@archiver.kernel.org>; Thu, 12 May 2022 19:37:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241861AbiELThi (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 12 May 2022 15:37:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238899AbiELThg (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 12 May 2022 15:37:36 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF31262CC9
        for <selinux@vger.kernel.org>; Thu, 12 May 2022 12:37:34 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id y20-20020a056830071400b00606a2ebd91bso3427699ots.5
        for <selinux@vger.kernel.org>; Thu, 12 May 2022 12:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=msWef0jqezlgv7MLzTw2wGQgt07USSgG19IHR3QGqXY=;
        b=iWmjioHSOImuP37tu1FOhSoOsjNMZO4qBx+cXuYO4fHl3xbcd5KylWeZ53KPtrwdkd
         oj/SckgxC/vaDE15W3YTnw2x9ptRaQOLI1DZq4VyfrQxwAWJBTNaHUp4M9W+gtFbrg/p
         BxLPesLJlu+3apDiev1xe39RVpjn6nPL2fH5NpQa1rw7LOWZXd9g/GAOeyB9Bna1eNU1
         VkN9D+SM+LljklN0j15o97ec/mrrRk54xZWEWLHIiVNojaWoVung/HHbq85psdsAnh1s
         9xy1s0pM0HVJWU+ayUx52Cxx+UtNYms9KYZAAOS6MyIpUenYH9250Nz+6qbbAVHSZrs4
         qN0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=msWef0jqezlgv7MLzTw2wGQgt07USSgG19IHR3QGqXY=;
        b=z0KI7Hz1XEIREQTrqGl+Ix1Mzt6LnvVjm8eozOQYCsVVjtPfcqcWhz3j6dLTqyJxqz
         TQcGRL5t5GMz/FtMHL8fDTjPpCiAinThAulYEHFgort/MJwlI6rMjoWyGIJbrqg2y2wW
         RU1+qIpq1ZjnZIg63KRRkGGW7OLFTsx8cyCwyT93dQQP0wJ8GDQCLEchRx5FxkOeuQgr
         yj19LcwLKPRlCrDl2SMgy80/4lpPor6jQke28O9pCttmfIZAmU3KvaP6p145MsdFr3WF
         aE/kyM8CvdkcMflrtP9dRGntnBe8kDMaSRJMuYyyKmOaoS3AbXWCSdrc05iLCAQUrlHc
         G0fg==
X-Gm-Message-State: AOAM532fDdw7wVSAEBxZWaZkMYT6JL4uAlND5BqkP+vqDKnkbScv3Xig
        iBvWgkLJ779m1jxgaunQfPqGkvjv+o9ghHHcHV3MhMbjibs=
X-Google-Smtp-Source: ABdhPJyY3KN/L/PKT1bkB33XzAQjCrZBpVWY2yWukvcxgKnJD2ySoxyP4vTCqEcj07s++z1KqMQxHSTLWuT1vUb9/r0=
X-Received: by 2002:a9d:12f6:0:b0:606:5f8:a407 with SMTP id
 g109-20020a9d12f6000000b0060605f8a407mr621549otg.154.1652384254010; Thu, 12
 May 2022 12:37:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220506140623.736036-1-vmojzis@redhat.com>
In-Reply-To: <20220506140623.736036-1-vmojzis@redhat.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Thu, 12 May 2022 15:37:23 -0400
Message-ID: <CAP+JOzRHZrjAv3UUkbBD=E0SPWgv47PnVyme9bKGNwHAu7DEng@mail.gmail.com>
Subject: Re: [PATCH] gettext: set _ on module level instead of builtins namespace
To:     Vit Mojzis <vmojzis@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Sun, May 8, 2022 at 10:48 PM Vit Mojzis <vmojzis@redhat.com> wrote:
>
> Some calls to "_" where unsuccessful because the function was
> initialized with a different translation domain than the string.
> e.g. selinux-polgengui calls functions from sepolicy.generate, which end
> up printing untranslated strings because polgengui uses selinux-gui
> domain while sepolicy uses selinux-python
>
> - Set "_" in module namespace instead of "builtins"
> - Set the whole "sepolicy.generate()" confirmation as translatable
> - Drop "codeset" parameter since it is deprecated
>
> Signed-off-by: Vit Mojzis <vmojzis@redhat.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  gui/booleansPage.py                   | 4 ++--
>  gui/domainsPage.py                    | 4 ++--
>  gui/fcontextPage.py                   | 4 ++--
>  gui/loginsPage.py                     | 4 ++--
>  gui/modulesPage.py                    | 4 ++--
>  gui/polgengui.py                      | 4 ++--
>  gui/portsPage.py                      | 4 ++--
>  gui/semanagePage.py                   | 4 ++--
>  gui/statusPage.py                     | 4 ++--
>  gui/system-config-selinux.py          | 4 ++--
>  gui/usersPage.py                      | 4 ++--
>  python/chcat/chcat                    | 4 ++--
>  python/semanage/semanage              | 4 ++--
>  python/semanage/seobject.py           | 4 ++--
>  python/sepolicy/sepolicy.py           | 4 ++--
>  python/sepolicy/sepolicy/__init__.py  | 4 ++--
>  python/sepolicy/sepolicy/generate.py  | 6 +++---
>  python/sepolicy/sepolicy/gui.py       | 4 ++--
>  python/sepolicy/sepolicy/interface.py | 4 ++--
>  sandbox/sandbox                       | 4 ++--
>  20 files changed, 41 insertions(+), 41 deletions(-)
>
> diff --git a/gui/booleansPage.py b/gui/booleansPage.py
> index dd12b6d6..5beec58b 100644
> --- a/gui/booleansPage.py
> +++ b/gui/booleansPage.py
> @@ -44,10 +44,10 @@ try:
>      kwargs = {}
>      if sys.version_info < (3,):
>          kwargs['unicode'] = True
> -    gettext.install(PROGNAME,
> +    t = gettext.translation(PROGNAME,
>                      localedir="/usr/share/locale",
> -                    codeset='utf-8',
>                      **kwargs)
> +    _ = t.gettext
>  except:
>      try:
>          import builtins
> diff --git a/gui/domainsPage.py b/gui/domainsPage.py
> index 6bbe4de5..e08f34b4 100644
> --- a/gui/domainsPage.py
> +++ b/gui/domainsPage.py
> @@ -36,10 +36,10 @@ try:
>      kwargs = {}
>      if sys.version_info < (3,):
>          kwargs['unicode'] = True
> -    gettext.install(PROGNAME,
> +    t = gettext.translation(PROGNAME,
>                      localedir="/usr/share/locale",
> -                    codeset='utf-8',
>                      **kwargs)
> +    _ = t.gettext
>  except:
>      try:
>          import builtins
> diff --git a/gui/fcontextPage.py b/gui/fcontextPage.py
> index 52292cae..bac2bec3 100644
> --- a/gui/fcontextPage.py
> +++ b/gui/fcontextPage.py
> @@ -53,10 +53,10 @@ try:
>      kwargs = {}
>      if sys.version_info < (3,):
>          kwargs['unicode'] = True
> -    gettext.install(PROGNAME,
> +    t = gettext.translation(PROGNAME,
>                      localedir="/usr/share/locale",
> -                    codeset='utf-8',
>                      **kwargs)
> +    _ = t.gettext
>  except:
>      try:
>          import builtins
> diff --git a/gui/loginsPage.py b/gui/loginsPage.py
> index cbfb0cc2..18b93d8c 100644
> --- a/gui/loginsPage.py
> +++ b/gui/loginsPage.py
> @@ -35,10 +35,10 @@ try:
>      kwargs = {}
>      if sys.version_info < (3,):
>          kwargs['unicode'] = True
> -    gettext.install(PROGNAME,
> +    t = gettext.translation(PROGNAME,
>                      localedir="/usr/share/locale",
> -                    codeset='utf-8',
>                      **kwargs)
> +    _ = t.gettext
>  except:
>      try:
>          import builtins
> diff --git a/gui/modulesPage.py b/gui/modulesPage.py
> index 35a0129b..c546d455 100644
> --- a/gui/modulesPage.py
> +++ b/gui/modulesPage.py
> @@ -36,10 +36,10 @@ try:
>      kwargs = {}
>      if sys.version_info < (3,):
>          kwargs['unicode'] = True
> -    gettext.install(PROGNAME,
> +    t = gettext.translation(PROGNAME,
>                      localedir="/usr/share/locale",
> -                    codeset='utf-8',
>                      **kwargs)
> +    _ = t.gettext
>  except:
>      try:
>          import builtins
> diff --git a/gui/polgengui.py b/gui/polgengui.py
> index 01f541ba..a18f1cba 100644
> --- a/gui/polgengui.py
> +++ b/gui/polgengui.py
> @@ -69,10 +69,10 @@ try:
>      kwargs = {}
>      if sys.version_info < (3,):
>          kwargs['unicode'] = True
> -    gettext.install(PROGNAME,
> +    t = gettext.translation(PROGNAME,
>                      localedir="/usr/share/locale",
> -                    codeset='utf-8',
>                      **kwargs)
> +    _ = t.gettext
>  except:
>      try:
>          import builtins
> diff --git a/gui/portsPage.py b/gui/portsPage.py
> index a537ecc8..54aa80de 100644
> --- a/gui/portsPage.py
> +++ b/gui/portsPage.py
> @@ -41,10 +41,10 @@ try:
>      kwargs = {}
>      if sys.version_info < (3,):
>          kwargs['unicode'] = True
> -    gettext.install(PROGNAME,
> +    t = gettext.translation(PROGNAME,
>                      localedir="/usr/share/locale",
> -                    codeset='utf-8',
>                      **kwargs)
> +    _ = t.gettext
>  except:
>      try:
>          import builtins
> diff --git a/gui/semanagePage.py b/gui/semanagePage.py
> index 5361d69c..1371d4e7 100644
> --- a/gui/semanagePage.py
> +++ b/gui/semanagePage.py
> @@ -28,10 +28,10 @@ try:
>      kwargs = {}
>      if sys.version_info < (3,):
>          kwargs['unicode'] = True
> -    gettext.install(PROGNAME,
> +    t = gettext.translation(PROGNAME,
>                      localedir="/usr/share/locale",
> -                    codeset='utf-8',
>                      **kwargs)
> +    _ = t.gettext
>  except:
>      try:
>          import builtins
> diff --git a/gui/statusPage.py b/gui/statusPage.py
> index a8f079b9..c241ef83 100644
> --- a/gui/statusPage.py
> +++ b/gui/statusPage.py
> @@ -41,10 +41,10 @@ try:
>      kwargs = {}
>      if sys.version_info < (3,):
>          kwargs['unicode'] = True
> -    gettext.install(PROGNAME,
> +    t = gettext.translation(PROGNAME,
>                      localedir="/usr/share/locale",
> -                    codeset='utf-8',
>                      **kwargs)
> +    _ = t.gettext
>  except:
>      try:
>          import builtins
> diff --git a/gui/system-config-selinux.py b/gui/system-config-selinux.py
> index 8c46c987..1b460c99 100644
> --- a/gui/system-config-selinux.py
> +++ b/gui/system-config-selinux.py
> @@ -51,10 +51,10 @@ try:
>      kwargs = {}
>      if sys.version_info < (3,):
>          kwargs['unicode'] = True
> -    gettext.install(PROGNAME,
> +    t = gettext.translation(PROGNAME,
>                      localedir="/usr/share/locale",
> -                    codeset='utf-8',
>                      **kwargs)
> +    _ = t.gettext
>  except:
>      try:
>          import builtins
> diff --git a/gui/usersPage.py b/gui/usersPage.py
> index d15d4c5a..d51bd968 100644
> --- a/gui/usersPage.py
> +++ b/gui/usersPage.py
> @@ -35,10 +35,10 @@ try:
>      kwargs = {}
>      if sys.version_info < (3,):
>          kwargs['unicode'] = True
> -    gettext.install(PROGNAME,
> +    t = gettext.translation(PROGNAME,
>                      localedir="/usr/share/locale",
> -                    codeset='utf-8',
>                      **kwargs)
> +    _ = t.gettext
>  except:
>      try:
>          import builtins
> diff --git a/python/chcat/chcat b/python/chcat/chcat
> index 839ddd3b..e779fcc6 100755
> --- a/python/chcat/chcat
> +++ b/python/chcat/chcat
> @@ -36,10 +36,10 @@ try:
>      kwargs = {}
>      if sys.version_info < (3,):
>          kwargs['unicode'] = True
> -    gettext.install(PROGNAME,
> +    t = gettext.translation(PROGNAME,
>                      localedir="/usr/share/locale",
> -                    codeset='utf-8',
>                      **kwargs)
> +    _ = t.gettext
>  except ImportError:
>      try:
>          import builtins
> diff --git a/python/semanage/semanage b/python/semanage/semanage
> index 12bb159e..8f4e44a7 100644
> --- a/python/semanage/semanage
> +++ b/python/semanage/semanage
> @@ -36,10 +36,10 @@ try:
>      kwargs = {}
>      if sys.version_info < (3,):
>          kwargs['unicode'] = True
> -    gettext.install(PROGNAME,
> +    t = gettext.translation(PROGNAME,
>                      localedir="/usr/share/locale",
> -                    codeset='utf-8',
>                      **kwargs)
> +    _ = t.gettext
>  except:
>      try:
>          import builtins
> diff --git a/python/semanage/seobject.py b/python/semanage/seobject.py
> index 69e60db8..ff8f4e9c 100644
> --- a/python/semanage/seobject.py
> +++ b/python/semanage/seobject.py
> @@ -40,10 +40,10 @@ try:
>      kwargs = {}
>      if sys.version_info < (3,):
>          kwargs['unicode'] = True
> -    gettext.install(PROGNAME,
> +    t = gettext.translation(PROGNAME,
>                      localedir="/usr/share/locale",
> -                    codeset='utf-8',
>                      **kwargs)
> +    _ = t.gettext
>  except:
>      try:
>          import builtins
> diff --git a/python/sepolicy/sepolicy.py b/python/sepolicy/sepolicy.py
> index 32956e58..7ebe0efa 100755
> --- a/python/sepolicy/sepolicy.py
> +++ b/python/sepolicy/sepolicy.py
> @@ -34,10 +34,10 @@ try:
>      kwargs = {}
>      if sys.version_info < (3,):
>          kwargs['unicode'] = True
> -    gettext.install(PROGNAME,
> +    t = gettext.translation(PROGNAME,
>                      localedir="/usr/share/locale",
> -                    codeset='utf-8',
>                      **kwargs)
> +    _ = t.gettext
>  except:
>      try:
>          import builtins
> diff --git a/python/sepolicy/sepolicy/__init__.py b/python/sepolicy/sepolicy/__init__.py
> index 203ca25f..7208234b 100644
> --- a/python/sepolicy/sepolicy/__init__.py
> +++ b/python/sepolicy/sepolicy/__init__.py
> @@ -29,10 +29,10 @@ try:
>      kwargs = {}
>      if sys.version_info < (3,):
>          kwargs['unicode'] = True
> -    gettext.install(PROGNAME,
> +    t = gettext.translation(PROGNAME,
>                      localedir="/usr/share/locale",
> -                    codeset='utf-8',
>                      **kwargs)
> +    _ = t.gettext
>  except:
>      try:
>          import builtins
> diff --git a/python/sepolicy/sepolicy/generate.py b/python/sepolicy/sepolicy/generate.py
> index 43180ca6..67189fc3 100644
> --- a/python/sepolicy/sepolicy/generate.py
> +++ b/python/sepolicy/sepolicy/generate.py
> @@ -54,10 +54,10 @@ try:
>      kwargs = {}
>      if sys.version_info < (3,):
>          kwargs['unicode'] = True
> -    gettext.install(PROGNAME,
> +    t = gettext.translation(PROGNAME,
>                      localedir="/usr/share/locale",
> -                    codeset='utf-8',
>                      **kwargs)
> +    _ = t.gettext
>  except:
>      try:
>          import builtins
> @@ -1372,7 +1372,7 @@ Warning %s does not exist
>          fd.close()
>
>      def generate(self, out_dir=os.getcwd()):
> -        out = "Created the following files:\n"
> +        out = _("Created the following files:\n")
>          out += "%s # %s\n" % (self.write_te(out_dir), _("Type Enforcement file"))
>          out += "%s # %s\n" % (self.write_if(out_dir), _("Interface file"))
>          out += "%s # %s\n" % (self.write_fc(out_dir), _("File Contexts file"))
> diff --git a/python/sepolicy/sepolicy/gui.py b/python/sepolicy/sepolicy/gui.py
> index 4f892f82..b0263740 100644
> --- a/python/sepolicy/sepolicy/gui.py
> +++ b/python/sepolicy/sepolicy/gui.py
> @@ -47,10 +47,10 @@ try:
>      kwargs = {}
>      if sys.version_info < (3,):
>          kwargs['unicode'] = True
> -    gettext.install(PROGNAME,
> +    t = gettext.translation(PROGNAME,
>                      localedir="/usr/share/locale",
> -                    codeset='utf-8',
>                      **kwargs)
> +    _ = t.gettext
>  except:
>      try:
>          import builtins
> diff --git a/python/sepolicy/sepolicy/interface.py b/python/sepolicy/sepolicy/interface.py
> index 9d40aea1..599f97fd 100644
> --- a/python/sepolicy/sepolicy/interface.py
> +++ b/python/sepolicy/sepolicy/interface.py
> @@ -36,10 +36,10 @@ try:
>      kwargs = {}
>      if sys.version_info < (3,):
>          kwargs['unicode'] = True
> -    gettext.install(PROGNAME,
> +    t = gettext.translation(PROGNAME,
>                      localedir="/usr/share/locale",
> -                    codeset='utf-8',
>                      **kwargs)
> +    _ = t.gettext
>  except:
>      try:
>          import builtins
> diff --git a/sandbox/sandbox b/sandbox/sandbox
> index 16c43b51..cd5709fb 100644
> --- a/sandbox/sandbox
> +++ b/sandbox/sandbox
> @@ -43,10 +43,10 @@ try:
>      kwargs = {}
>      if sys.version_info < (3,):
>          kwargs['unicode'] = True
> -    gettext.install(PROGNAME,
> +    t = gettext.translation(PROGNAME,
>                      localedir="/usr/share/locale",
> -                    codeset='utf-8',
>                      **kwargs)
> +    _ = t.gettext
>  except:
>      try:
>          import builtins
> --
> 2.35.1
>
