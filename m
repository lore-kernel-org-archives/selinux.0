Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A1D5C4332F
	for <selinux@archiver.kernel.org>; Thu,  3 Nov 2022 11:41:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbiKCLle (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 3 Nov 2022 07:41:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiKCLld (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 3 Nov 2022 07:41:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAEF31263F
        for <selinux@vger.kernel.org>; Thu,  3 Nov 2022 04:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667475635;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/6/r2FFJgyHWQXcXIlS+Q3aJC7F8CILtFhkppIW1K5M=;
        b=brezc2uD/nudA8pPzb6QpmW1+JZofHXkuP863FPyZc98JjIRTZgnWnxPqNB+LdHPlDhWkz
        n2bHPKgJp2s2EOVf++cMR6Fr3PEBKlLbtRmsoFRv/dYIZoe7ZJXPggI8ROJMLrevT1gbaZ
        30HDjZls25hEQ3aqk35bCVevBMjMhXs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-645-tROdur5POpW3OJYCeD-Q2A-1; Thu, 03 Nov 2022 07:40:34 -0400
X-MC-Unique: tROdur5POpW3OJYCeD-Q2A-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4917985A59D;
        Thu,  3 Nov 2022 11:40:34 +0000 (UTC)
Received: from localhost (ovpn-194-20.brq.redhat.com [10.40.194.20])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F2D9640C6EC3;
        Thu,  3 Nov 2022 11:40:33 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     James Carter <jwcart2@gmail.com>, selinux@vger.kernel.org
Subject: Re: [PATCH 3/5 v2] python: Remove dependency on the Python module
 distutils
In-Reply-To: <20221102140039.914518-4-jwcart2@gmail.com>
References: <20221102140039.914518-1-jwcart2@gmail.com>
 <20221102140039.914518-4-jwcart2@gmail.com>
Date:   Thu, 03 Nov 2022 12:40:33 +0100
Message-ID: <877d0ce05q.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

James Carter <jwcart2@gmail.com> writes:

> The distutils package is deprecated and scheduled to be removed in
> Python 3.12. Use the setuptools and sysconfig modules instead.
>
> Signed-off-by: James Carter <jwcart2@gmail.com>
> ---
> v2: Use sysconfig.get_path('purelib'... since original used
>     get_python_lib(prefix=... instead of
>     get_python_lib(plat_specific=1, prefix=...
>
>  python/semanage/Makefile              | 2 +-
>  python/sepolgen/src/sepolgen/Makefile | 2 +-
>  python/sepolicy/sepolicy/gui.py       | 2 +-
>  python/sepolicy/setup.py              | 2 +-
>  4 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/python/semanage/Makefile b/python/semanage/Makefile
> index 024e9640..b53ee33d 100644
> --- a/python/semanage/Makefile
> +++ b/python/semanage/Makefile
> @@ -5,7 +5,7 @@ LINGUAS ?= ru
>  PREFIX ?= /usr
>  SBINDIR ?= $(PREFIX)/sbin
>  MANDIR = $(PREFIX)/share/man
> -PYTHONLIBDIR ?= $(shell $(PYTHON) -c "from distutils.sysconfig import *; print(get_python_lib(prefix='$(PREFIX)'))")
> +PYTHONLIBDIR ?= $(shell $(PYTHON) -c "import sysconfig; print(sysconfig.get_path('purelib', vars={'platbase': '$(PREFIX)', 'base': '$(PREFIX)'}))")
>  PACKAGEDIR ?= $(PYTHONLIBDIR)
>  BASHCOMPLETIONDIR ?= $(PREFIX)/share/bash-completion/completions
>  
> diff --git a/python/sepolgen/src/sepolgen/Makefile b/python/sepolgen/src/sepolgen/Makefile
> index cac8def7..a1039227 100644
> --- a/python/sepolgen/src/sepolgen/Makefile
> +++ b/python/sepolgen/src/sepolgen/Makefile
> @@ -1,6 +1,6 @@
>  PREFIX ?= /usr
>  PYTHON ?= python3
> -PYTHONLIBDIR ?= $(shell $(PYTHON) -c "from distutils.sysconfig import *; print(get_python_lib(prefix='$(PREFIX)'))")
> +PYTHONLIBDIR ?= $(shell $(PYTHON) -c "import sysconfig; print(sysconfig.get_path('purelib', vars={'platbase': '$(PREFIX)', 'base': '$(PREFIX)'}))")
>  PACKAGEDIR ?= /$(PYTHONLIBDIR)/sepolgen
>  
>  all:
> diff --git a/python/sepolicy/sepolicy/gui.py b/python/sepolicy/sepolicy/gui.py
> index 5bdbfeba..63f2371f 100644
> --- a/python/sepolicy/sepolicy/gui.py
> +++ b/python/sepolicy/sepolicy/gui.py
> @@ -77,7 +77,7 @@ def cmp(a, b):
>          return 1
>      return (a > b) - (a < b)
>  
> -import distutils.sysconfig
> +import sysconfig

CI
https://github.com/bachradsusi/SELinuxProject-selinux/actions/runs/3384927657/jobs/5622477533
reports:

  Analyzing 118 Python scripts
  ./python/sepolicy/build/lib/sepolicy/gui.py:133:26: F821 undefined name 'distutils'
  ./python/sepolicy/sepolicy/gui.py:133:26: F821 undefined name 'distutils'
  Error: Process completed with exit code 1.


The following patch makes the CI happy:

--- a/python/sepolicy/sepolicy/gui.py
+++ b/python/sepolicy/sepolicy/gui.py
@@ -130,7 +130,7 @@ class SELinuxGui():
         self.application = app
         self.filter_txt = ""
         builder = Gtk.Builder()  # BUILDER OBJ
-        self.code_path = distutils.sysconfig.get_python_lib(plat_specific=False) + "/sepolicy/"
+        self.code_path = sysconfig.get_python_lib(plat_specific=False) + "/sepolicy/"




>  ADVANCED_LABEL = (_("Advanced >>"), _("Advanced <<"))
>  ADVANCED_SEARCH_LABEL = (_("Advanced Search >>"), _("Advanced Search <<"))
>  OUTBOUND_PAGE = 0
> diff --git a/python/sepolicy/setup.py b/python/sepolicy/setup.py
> index b0f9650d..c8220664 100644
> --- a/python/sepolicy/setup.py
> +++ b/python/sepolicy/setup.py
> @@ -2,7 +2,7 @@
>  
>  # Author: Thomas Liu <tliu@redhat.com>
>  # Author: Dan Walsh <dwalsh@redhat.com>
> -from distutils.core import setup
> +from setuptools import setup
>  
>  setup(
>      name="sepolicy",
> -- 
> 2.38.1

