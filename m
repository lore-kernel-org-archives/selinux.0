Return-Path: <SRS0=FN9z=54=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38C0BC2BA2B
	for <selinux@archiver.kernel.org>; Sun, 12 Apr 2020 08:33:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14BC5206DA
	for <selinux@archiver.kernel.org>; Sun, 12 Apr 2020 08:33:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725873AbgDLIdL convert rfc822-to-8bit (ORCPT
        <rfc822;selinux@archiver.kernel.org>);
        Sun, 12 Apr 2020 04:33:11 -0400
Received: from mx1.polytechnique.org ([129.104.30.34]:48247 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725832AbgDLIdK (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 12 Apr 2020 04:33:10 -0400
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 02DFF5612D0
        for <selinux@vger.kernel.org>; Sun, 12 Apr 2020 10:24:57 +0200 (CEST)
Received: by mail-ot1-f44.google.com with SMTP id 60so6142315otl.12
        for <selinux@vger.kernel.org>; Sun, 12 Apr 2020 01:24:56 -0700 (PDT)
X-Gm-Message-State: AGi0PuYiL9ytB5kO7p/Dtpim2/iUgUomor3Vc3CYOzQnY6cwiU8uCaUp
        0ftK+1S3NnwNpsCf3gziGR00ySjFoTi39iljmEw=
X-Google-Smtp-Source: APiQypJau/jMd9xksD4K7asXVM/QJFy1uOOUKJhV0lgqVriRmeMjLyGDL122Q9N+6hFNPiMnuZBgZpnX3RSN1NozWD8=
X-Received: by 2002:a05:6830:14:: with SMTP id c20mr9745954otp.279.1586679895948;
 Sun, 12 Apr 2020 01:24:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200407115849.41225-1-cgzones@googlemail.com>
In-Reply-To: <20200407115849.41225-1-cgzones@googlemail.com>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Sun, 12 Apr 2020 10:24:44 +0200
X-Gmail-Original-Message-ID: <CAJfZ7=kDRkdx=J_40VCVXTH5kFeV-ynupPTghbQY70ByNsAF7Q@mail.gmail.com>
Message-ID: <CAJfZ7=kDRkdx=J_40VCVXTH5kFeV-ynupPTghbQY70ByNsAF7Q@mail.gmail.com>
Subject: Re: [PATCH] tree-wide: use python module importlib instead of the
 deprecated imp
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Sun Apr 12 10:24:57 2020 +0200 (CEST))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Apr 7, 2020 at 1:59 PM Christian Göttsche
<cgzones@googlemail.com> wrote:
>
> Replace
>
> python3 -c 'import imp;print([s for s,m,t in imp.get_suffixes() if t == imp.C_EXTENSION][0])'
> <string>:1: DeprecationWarning: the imp module is deprecated in favour of importlib; see the module's documentation for alternative uses
> .cpython-38-x86_64-linux-gnu.so
>
> with
>
> python3 -c 'import importlib;print(importlib.machinery.EXTENSION_SUFFIXES[0])'
> .cpython-38-x86_64-linux-gnu.so
>
> Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
> ---
>  libselinux/src/Makefile  | 2 +-
>  libsemanage/src/Makefile | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
> index 2d1c654e..ddb5e013 100644
> --- a/libselinux/src/Makefile
> +++ b/libselinux/src/Makefile
> @@ -15,7 +15,7 @@ INCLUDEDIR ?= $(PREFIX)/include
>  PYINC ?= $(shell $(PKG_CONFIG) --cflags $(PYPREFIX))
>  PYLIBS ?= $(shell $(PKG_CONFIG) --libs $(PYPREFIX))
>  PYTHONLIBDIR ?= $(shell $(PYTHON) -c "from distutils.sysconfig import *; print(get_python_lib(plat_specific=1, prefix='$(PREFIX)'))")
> -PYCEXT ?= $(shell $(PYTHON) -c 'import imp;print([s for s,m,t in imp.get_suffixes() if t == imp.C_EXTENSION][0])')
> +PYCEXT ?= $(shell $(PYTHON) -c 'import importlib;print(importlib.machinery.EXTENSION_SUFFIXES[0])')
>  RUBYINC ?= $(shell $(RUBY) -e 'puts "-I" + RbConfig::CONFIG["rubyarchhdrdir"] + " -I" + RbConfig::CONFIG["rubyhdrdir"]')
>  RUBYLIBS ?= $(shell $(RUBY) -e 'puts "-L" + RbConfig::CONFIG["libdir"] + " -L" + RbConfig::CONFIG["archlibdir"] + " " + RbConfig::CONFIG["LIBRUBYARG_SHARED"]')
>  RUBYINSTALL ?= $(shell $(RUBY) -e 'puts RbConfig::CONFIG["vendorarchdir"]')
> diff --git a/libsemanage/src/Makefile b/libsemanage/src/Makefile
> index 606ce1c6..00aee063 100644
> --- a/libsemanage/src/Makefile
> +++ b/libsemanage/src/Makefile
> @@ -14,7 +14,7 @@ INCLUDEDIR ?= $(PREFIX)/include
>  PYINC ?= $(shell $(PKG_CONFIG) --cflags $(PYPREFIX))
>  PYLIBS ?= $(shell $(PKG_CONFIG) --libs $(PYPREFIX))
>  PYTHONLIBDIR ?= $(shell $(PYTHON) -c "from distutils.sysconfig import *; print(get_python_lib(plat_specific=1, prefix='$(PREFIX)'))")
> -PYCEXT ?= $(shell $(PYTHON) -c 'import imp;print([s for s,m,t in imp.get_suffixes() if t == imp.C_EXTENSION][0])')
> +PYCEXT ?= $(shell $(PYTHON) -c 'import importlib;print(importlib.machinery.EXTENSION_SUFFIXES[0])')
>  RUBYINC ?= $(shell $(RUBY) -e 'puts "-I" + RbConfig::CONFIG["rubyarchhdrdir"] + " -I" + RbConfig::CONFIG["rubyhdrdir"]')
>  RUBYLIBS ?= $(shell $(RUBY) -e 'puts "-L" + RbConfig::CONFIG["libdir"] + " -L" + RbConfig::CONFIG["archlibdir"] + " " + RbConfig::CONFIG["LIBRUBYARG_SHARED"]')
>  RUBYINSTALL ?= $(shell $(RUBY) -e 'puts RbConfig::CONFIG["vendorarchdir"]')

Hello,
Thanks for your patch, but this does not seem to work on Python 3.5:

python3.5 -c 'import importlib;print(importlib.machinery.EXTENSION_SUFFIXES[0])'
Traceback (most recent call last):
  File "<string>", line 1, in <module>
AttributeError: module 'importlib' has no attribute 'machinery'

importlib.machinery.EXTENSION_SUFFIXES has been available since Python
3.3, but in module importlib.machinery. This works:

python3.5 -c 'import
importlib.machinery;print(importlib.machinery.EXTENSION_SUFFIXES[0])'
.cpython-35m-x86_64-linux-gnu.so

Could you update your patch in order to use "import
importlib.machinery" instead of "import importlib"?

Thanks,
Nicolas

