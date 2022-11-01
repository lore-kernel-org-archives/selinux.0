Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50505C433FE
	for <selinux@archiver.kernel.org>; Tue,  1 Nov 2022 09:01:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229462AbiKAJBM (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 1 Nov 2022 05:01:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbiKAJBM (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 1 Nov 2022 05:01:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76EAC60D8
        for <selinux@vger.kernel.org>; Tue,  1 Nov 2022 02:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667293220;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=izMaEsWYl8UrlmpXRK1Q5b25yjCdPqUmwP8SpaIifvc=;
        b=Q1iauG4AbgRUtTaQMEh2RoAz3Hvv1QWAPLJq9P69SCJNbF6Ho56sVPydgZs7zUoGol/KPO
        iXVCpeH6SGNboFzffHznzgnCpu23kPfWfYRBdC/IR3laOs+Xo8C+td9KcM0OMe2S+TtOeJ
        G1YuVhfhYTPdVlMEwa7LnMU79k9Ho48=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-387-iOjRdM8_PqCId1-lWTV0AA-1; Tue, 01 Nov 2022 05:00:10 -0400
X-MC-Unique: iOjRdM8_PqCId1-lWTV0AA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E4B1C101036E;
        Tue,  1 Nov 2022 08:59:53 +0000 (UTC)
Received: from localhost (ovpn-194-20.brq.redhat.com [10.40.194.20])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C5EEDC549E2;
        Tue,  1 Nov 2022 08:59:51 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     James Carter <jwcart2@gmail.com>, selinux@vger.kernel.org
Cc:     James Carter <jwcart2@gmail.com>
Subject: Re: [PATCH 3/5] python: Remove dependency on the Python module
 distutils
In-Reply-To: <20221028203852.526472-4-jwcart2@gmail.com>
References: <20221028203852.526472-1-jwcart2@gmail.com>
 <20221028203852.526472-4-jwcart2@gmail.com>
Date:   Tue, 01 Nov 2022 09:59:50 +0100
Message-ID: <87v8nzrqwp.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

James Carter <jwcart2@gmail.com> writes:

> The distutils package is deprecated and scheduled to be removed in
> Python 3.12. Use the setuptools and sysconfig modules instead.
>
> Signed-off-by: James Carter <jwcart2@gmail.com>
> ---
>  python/semanage/Makefile              | 2 +-
>  python/sepolgen/src/sepolgen/Makefile | 2 +-
>  python/sepolicy/sepolicy/gui.py       | 2 +-
>  python/sepolicy/setup.py              | 2 +-
>  4 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/python/semanage/Makefile b/python/semanage/Makefile
> index 024e9640..b1f1bd3a 100644
> --- a/python/semanage/Makefile
> +++ b/python/semanage/Makefile
> @@ -5,7 +5,7 @@ LINGUAS ?= ru
>  PREFIX ?= /usr
>  SBINDIR ?= $(PREFIX)/sbin
>  MANDIR = $(PREFIX)/share/man
> -PYTHONLIBDIR ?= $(shell $(PYTHON) -c "from distutils.sysconfig import *; print(get_python_lib(prefix='$(PREFIX)'))")
> +PYTHONLIBDIR ?= $(shell $(PYTHON) -c "import sysconfig; print(sysconfig.get_path('platlib', vars={'platbase': '$(PREFIX)', 'base': '$(PREFIX)'}))")

$ python3 -c "from distutils.sysconfig import *; print(get_python_lib(prefix='/usr'))"     
/usr/lib/python3.10/site-packages

vs

$ python3 -c "import sysconfig; print(sysconfig.get_path('platlib', vars={'platbase': '/usr', 'base': '/usr'}))"
/usr/lib64/python3.10/site-packages

Given that python/ is not platform specific this should use 'purelib' -
https://docs.python.org/3/library/sysconfig.html#installation-paths

$ python3 -c "import sysconfig; print(sysconfig.get_path('purelib', vars={'platbase': '/usr', 'base': '/usr'}))"
/usr/lib/python3.10/site-packages




>  PACKAGEDIR ?= $(PYTHONLIBDIR)
>  BASHCOMPLETIONDIR ?= $(PREFIX)/share/bash-completion/completions
>  
> diff --git a/python/sepolgen/src/sepolgen/Makefile b/python/sepolgen/src/sepolgen/Makefile
> index cac8def7..9578af23 100644
> --- a/python/sepolgen/src/sepolgen/Makefile
> +++ b/python/sepolgen/src/sepolgen/Makefile
> @@ -1,6 +1,6 @@
>  PREFIX ?= /usr
>  PYTHON ?= python3
> -PYTHONLIBDIR ?= $(shell $(PYTHON) -c "from distutils.sysconfig import *; print(get_python_lib(prefix='$(PREFIX)'))")
> +PYTHONLIBDIR ?= $(shell $(PYTHON) -c "import sysconfig; print(sysconfig.get_path('platlib', vars={'platbase': '$(PREFIX)', 'base': '$(PREFIX)'}))")
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
> 2.37.3

