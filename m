Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 253CBC43334
	for <selinux@archiver.kernel.org>; Fri, 24 Jun 2022 16:37:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbiFXQhL (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 24 Jun 2022 12:37:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231407AbiFXQhK (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 24 Jun 2022 12:37:10 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5C7544FC47
        for <selinux@vger.kernel.org>; Fri, 24 Jun 2022 09:37:09 -0700 (PDT)
Received: from [172.21.254.60] (rrcs-97-79-186-3.sw.biz.rr.com [97.79.186.3])
        by linux.microsoft.com (Postfix) with ESMTPSA id D45ED20C7938;
        Fri, 24 Jun 2022 09:37:08 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D45ED20C7938
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1656088629;
        bh=N3PbBPvEqFaqGzlLJZPu2GXdYzejNeuADRwbNeHSawk=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=rTER1hXNlxN4OCX+KbgWA+S6dlypCL1F3kPPTFIPbM9hsJg35965br9jFGjA+xjR6
         gQcGbn7pOpxdBQ6NUGhcvx9mnKjjWC1LNWLMcuj+o/pebzBT2sQ9O0kz7ST6WlNG/1
         1kwEEy9POr8bEDRbnVONn3SxI6R5pYWoXCpwfsrw=
Message-ID: <bea122a5-5a68-2c81-25c1-ec9d3a3aa7e5@linux.microsoft.com>
Date:   Fri, 24 Jun 2022 12:37:03 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] gettext: handle unsupported languages properly
Content-Language: en-US
To:     Vit Mojzis <vmojzis@redhat.com>, selinux@vger.kernel.org
References: <20220624142425.3836193-1-vmojzis@redhat.com>
From:   Daniel Burgener <dburgener@linux.microsoft.com>
In-Reply-To: <20220624142425.3836193-1-vmojzis@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 6/24/2022 10:24 AM, Vit Mojzis wrote:
> With "fallback=True" gettext.translation behaves the same as
> gettext.install and uses NullTranslations in case the
> translation file for given language was not found (as opposed to
> throwing an exception).
> 
> Fixes:
>    # LANG is set to any "unsupported" language, e.g. en_US.UTF-8
>    $ chcat --help
>    Traceback (most recent call last):
>    File "/usr/bin/chcat", line 39, in <module>
>      t = gettext.translation(PROGNAME,
>    File "/usr/lib64/python3.9/gettext.py", line 592, in translation
>      raise FileNotFoundError(ENOENT,
>    FileNotFoundError: [Errno 2] No translation file found for domain: 'selinux-python'
> 
> Signed-off-by: Vit Mojzis <vmojzis@redhat.com>
> ---
>   gui/booleansPage.py                          | 3 ++-
>   gui/domainsPage.py                           | 3 ++-
>   gui/fcontextPage.py                          | 3 ++-
>   gui/loginsPage.py                            | 3 ++-
>   gui/modulesPage.py                           | 3 ++-
>   gui/polgengui.py                             | 3 ++-
>   gui/portsPage.py                             | 3 ++-
>   gui/semanagePage.py                          | 3 ++-
>   gui/statusPage.py                            | 3 ++-
>   gui/system-config-selinux.py                 | 3 ++-
>   gui/usersPage.py                             | 3 ++-
>   python/chcat/chcat                           | 5 +++--
>   python/semanage/semanage                     | 3 ++-
>   python/semanage/seobject.py                  | 3 ++-
>   python/sepolgen/src/sepolgen/sepolgeni18n.py | 4 +++-
>   python/sepolicy/sepolicy.py                  | 3 ++-
>   python/sepolicy/sepolicy/__init__.py         | 3 ++-
>   python/sepolicy/sepolicy/generate.py         | 3 ++-
>   python/sepolicy/sepolicy/gui.py              | 3 ++-
>   python/sepolicy/sepolicy/interface.py        | 3 ++-
>   sandbox/sandbox                              | 3 ++-
>   21 files changed, 44 insertions(+), 22 deletions(-)
> 
> diff --git a/gui/booleansPage.py b/gui/booleansPage.py
> index 5beec58b..ad11a9b2 100644
> --- a/gui/booleansPage.py
> +++ b/gui/booleansPage.py
> @@ -46,7 +46,8 @@ try:
>           kwargs['unicode'] = True
>       t = gettext.translation(PROGNAME,
>                       localedir="/usr/share/locale",
> -                    **kwargs)
> +                    **kwargs,
> +                    fallback=True)
>       _ = t.gettext
>   except:
>       try:
> diff --git a/gui/domainsPage.py b/gui/domainsPage.py
> index e08f34b4..e6eadd61 100644
> --- a/gui/domainsPage.py
> +++ b/gui/domainsPage.py
> @@ -38,7 +38,8 @@ try:
>           kwargs['unicode'] = True
>       t = gettext.translation(PROGNAME,
>                       localedir="/usr/share/locale",
> -                    **kwargs)
> +                    **kwargs,
> +                    fallback=True)
>       _ = t.gettext
>   except:
>       try:
> diff --git a/gui/fcontextPage.py b/gui/fcontextPage.py
> index bac2bec3..767664f2 100644
> --- a/gui/fcontextPage.py
> +++ b/gui/fcontextPage.py
> @@ -55,7 +55,8 @@ try:
>           kwargs['unicode'] = True
>       t = gettext.translation(PROGNAME,
>                       localedir="/usr/share/locale",
> -                    **kwargs)
> +                    **kwargs,
> +                    fallback=True)
>       _ = t.gettext
>   except:
>       try:
> diff --git a/gui/loginsPage.py b/gui/loginsPage.py
> index 18b93d8c..7e08232a 100644
> --- a/gui/loginsPage.py
> +++ b/gui/loginsPage.py
> @@ -37,7 +37,8 @@ try:
>           kwargs['unicode'] = True
>       t = gettext.translation(PROGNAME,
>                       localedir="/usr/share/locale",
> -                    **kwargs)
> +                    **kwargs,
> +                    fallback=True)
>       _ = t.gettext
>   except:
>       try:
> diff --git a/gui/modulesPage.py b/gui/modulesPage.py
> index c546d455..02b79f15 100644
> --- a/gui/modulesPage.py
> +++ b/gui/modulesPage.py
> @@ -38,7 +38,8 @@ try:
>           kwargs['unicode'] = True
>       t = gettext.translation(PROGNAME,
>                       localedir="/usr/share/locale",
> -                    **kwargs)
> +                    **kwargs,
> +                    fallback=True)
>       _ = t.gettext
>   except:
>       try:
> diff --git a/gui/polgengui.py b/gui/polgengui.py
> index a18f1cba..7a3ecd50 100644
> --- a/gui/polgengui.py
> +++ b/gui/polgengui.py
> @@ -71,7 +71,8 @@ try:
>           kwargs['unicode'] = True
>       t = gettext.translation(PROGNAME,
>                       localedir="/usr/share/locale",
> -                    **kwargs)
> +                    **kwargs,
> +                    fallback=True)
>       _ = t.gettext
>   except:
>       try:
> diff --git a/gui/portsPage.py b/gui/portsPage.py
> index 54aa80de..bee2bdf1 100644
> --- a/gui/portsPage.py
> +++ b/gui/portsPage.py
> @@ -43,7 +43,8 @@ try:
>           kwargs['unicode'] = True
>       t = gettext.translation(PROGNAME,
>                       localedir="/usr/share/locale",
> -                    **kwargs)
> +                    **kwargs,
> +                    fallback=True)
>       _ = t.gettext
>   except:
>       try:
> diff --git a/gui/semanagePage.py b/gui/semanagePage.py
> index 1371d4e7..efad14d9 100644
> --- a/gui/semanagePage.py
> +++ b/gui/semanagePage.py
> @@ -30,7 +30,8 @@ try:
>           kwargs['unicode'] = True
>       t = gettext.translation(PROGNAME,
>                       localedir="/usr/share/locale",
> -                    **kwargs)
> +                    **kwargs,
> +                    fallback=True)
>       _ = t.gettext
>   except:
>       try:
> diff --git a/gui/statusPage.py b/gui/statusPage.py
> index c241ef83..832849e6 100644
> --- a/gui/statusPage.py
> +++ b/gui/statusPage.py
> @@ -43,7 +43,8 @@ try:
>           kwargs['unicode'] = True
>       t = gettext.translation(PROGNAME,
>                       localedir="/usr/share/locale",
> -                    **kwargs)
> +                    **kwargs,
> +                    fallback=True)
>       _ = t.gettext
>   except:
>       try:
> diff --git a/gui/system-config-selinux.py b/gui/system-config-selinux.py
> index 1b460c99..9f53b7fe 100644
> --- a/gui/system-config-selinux.py
> +++ b/gui/system-config-selinux.py
> @@ -53,7 +53,8 @@ try:
>           kwargs['unicode'] = True
>       t = gettext.translation(PROGNAME,
>                       localedir="/usr/share/locale",
> -                    **kwargs)
> +                    **kwargs,
> +                    fallback=True)
>       _ = t.gettext
>   except:
>       try:
> diff --git a/gui/usersPage.py b/gui/usersPage.py
> index d51bd968..9acd3b84 100644
> --- a/gui/usersPage.py
> +++ b/gui/usersPage.py
> @@ -37,7 +37,8 @@ try:
>           kwargs['unicode'] = True
>       t = gettext.translation(PROGNAME,
>                       localedir="/usr/share/locale",
> -                    **kwargs)
> +                    **kwargs,
> +                    fallback=True)
>       _ = t.gettext
>   except:
>       try:
> diff --git a/python/chcat/chcat b/python/chcat/chcat
> index e779fcc6..952cb818 100755
> --- a/python/chcat/chcat
> +++ b/python/chcat/chcat
> @@ -38,9 +38,10 @@ try:
>           kwargs['unicode'] = True
>       t = gettext.translation(PROGNAME,
>                       localedir="/usr/share/locale",
> -                    **kwargs)
> +                    **kwargs,
> +                    fallback=True)
>       _ = t.gettext
> -except ImportError:
> +except:

Isn't the point of the overall change that gettext.translation() doesn't 
throw an exception anymore?  So we don't need to handle OSError/IOError 
here once fallback=True.  I see that this standardizes with the other 
call sites, but I wonder if standardizing on the more specific 
exceptions (or just leaving as is) wouldn't be better?

-Daniel

>       try:
>           import builtins
>           builtins.__dict__['_'] = str
> diff --git a/python/semanage/semanage b/python/semanage/semanage
> index 1d828128..4e8d64d6 100644
> --- a/python/semanage/semanage
> +++ b/python/semanage/semanage
> @@ -38,7 +38,8 @@ try:
>           kwargs['unicode'] = True
>       t = gettext.translation(PROGNAME,
>                       localedir="/usr/share/locale",
> -                    **kwargs)
> +                    **kwargs,
> +                    fallback=True)
>       _ = t.gettext
>   except:
>       try:
> diff --git a/python/semanage/seobject.py b/python/semanage/seobject.py
> index ff8f4e9c..0782c082 100644
> --- a/python/semanage/seobject.py
> +++ b/python/semanage/seobject.py
> @@ -42,7 +42,8 @@ try:
>           kwargs['unicode'] = True
>       t = gettext.translation(PROGNAME,
>                       localedir="/usr/share/locale",
> -                    **kwargs)
> +                    **kwargs,
> +                    fallback=True)
>       _ = t.gettext
>   except:
>       try:
> diff --git a/python/sepolgen/src/sepolgen/sepolgeni18n.py b/python/sepolgen/src/sepolgen/sepolgeni18n.py
> index 56ebd807..1ff307d9 100644
> --- a/python/sepolgen/src/sepolgen/sepolgeni18n.py
> +++ b/python/sepolgen/src/sepolgen/sepolgeni18n.py
> @@ -19,7 +19,9 @@
>   
>   try:
>       import gettext
> -    t = gettext.translation( 'selinux-python' )
> +    t = gettext.translation("selinux-python",
> +                        localedir="/usr/share/locale",
> +                        fallback=True)
>       _ = t.gettext
>   except:
>       def _(str):
> diff --git a/python/sepolicy/sepolicy.py b/python/sepolicy/sepolicy.py
> index 7ebe0efa..c7a70e09 100755
> --- a/python/sepolicy/sepolicy.py
> +++ b/python/sepolicy/sepolicy.py
> @@ -36,7 +36,8 @@ try:
>           kwargs['unicode'] = True
>       t = gettext.translation(PROGNAME,
>                       localedir="/usr/share/locale",
> -                    **kwargs)
> +                    **kwargs,
> +                    fallback=True)
>       _ = t.gettext
>   except:
>       try:
> diff --git a/python/sepolicy/sepolicy/__init__.py b/python/sepolicy/sepolicy/__init__.py
> index 7208234b..9c3caa05 100644
> --- a/python/sepolicy/sepolicy/__init__.py
> +++ b/python/sepolicy/sepolicy/__init__.py
> @@ -31,7 +31,8 @@ try:
>           kwargs['unicode'] = True
>       t = gettext.translation(PROGNAME,
>                       localedir="/usr/share/locale",
> -                    **kwargs)
> +                    **kwargs,
> +                    fallback=True)
>       _ = t.gettext
>   except:
>       try:
> diff --git a/python/sepolicy/sepolicy/generate.py b/python/sepolicy/sepolicy/generate.py
> index 67189fc3..3717d5d4 100644
> --- a/python/sepolicy/sepolicy/generate.py
> +++ b/python/sepolicy/sepolicy/generate.py
> @@ -56,7 +56,8 @@ try:
>           kwargs['unicode'] = True
>       t = gettext.translation(PROGNAME,
>                       localedir="/usr/share/locale",
> -                    **kwargs)
> +                    **kwargs,
> +                    fallback=True)
>       _ = t.gettext
>   except:
>       try:
> diff --git a/python/sepolicy/sepolicy/gui.py b/python/sepolicy/sepolicy/gui.py
> index b0263740..5bdbfeba 100644
> --- a/python/sepolicy/sepolicy/gui.py
> +++ b/python/sepolicy/sepolicy/gui.py
> @@ -49,7 +49,8 @@ try:
>           kwargs['unicode'] = True
>       t = gettext.translation(PROGNAME,
>                       localedir="/usr/share/locale",
> -                    **kwargs)
> +                    **kwargs,
> +                    fallback=True)
>       _ = t.gettext
>   except:
>       try:
> diff --git a/python/sepolicy/sepolicy/interface.py b/python/sepolicy/sepolicy/interface.py
> index 599f97fd..43f86443 100644
> --- a/python/sepolicy/sepolicy/interface.py
> +++ b/python/sepolicy/sepolicy/interface.py
> @@ -38,7 +38,8 @@ try:
>           kwargs['unicode'] = True
>       t = gettext.translation(PROGNAME,
>                       localedir="/usr/share/locale",
> -                    **kwargs)
> +                    **kwargs,
> +                    fallback=True)
>       _ = t.gettext
>   except:
>       try:
> diff --git a/sandbox/sandbox b/sandbox/sandbox
> index cd5709fb..789621e1 100644
> --- a/sandbox/sandbox
> +++ b/sandbox/sandbox
> @@ -45,7 +45,8 @@ try:
>           kwargs['unicode'] = True
>       t = gettext.translation(PROGNAME,
>                       localedir="/usr/share/locale",
> -                    **kwargs)
> +                    **kwargs,
> +                    fallback=True)
>       _ = t.gettext
>   except:
>       try:

