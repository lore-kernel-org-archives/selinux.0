Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1657C4332F
	for <selinux@archiver.kernel.org>; Thu, 22 Dec 2022 09:10:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235107AbiLVJKY (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 22 Dec 2022 04:10:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235139AbiLVJKX (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 22 Dec 2022 04:10:23 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57CE32018D
        for <selinux@vger.kernel.org>; Thu, 22 Dec 2022 01:09:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671700177;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Rn7w4B9yOQtJ28xv9rxZn0zKDq2emj9c6hkYEcP/suY=;
        b=eVzgYkoXCEF8xKdXAMcNOy2RSG79A3X/KBqxequxArZM/t0yi7F7yz932H8SA1DHKjXt4g
        ghoauBNVGFLhLIq3nxxb/nTJcndsWPMFgQgFZDxSAFVCP/GnxFn6XfROglTetYksNf8b/g
        7Z1YG647bMhD0S7v4dMict9nLteVzbY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-244-nNqQlHPyNs6REKTVIqqMIw-1; Thu, 22 Dec 2022 04:09:34 -0500
X-MC-Unique: nNqQlHPyNs6REKTVIqqMIw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C3CDB811E9C;
        Thu, 22 Dec 2022 09:09:33 +0000 (UTC)
Received: from localhost (ovpn-193-64.brq.redhat.com [10.40.193.64])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7C2EE112132C;
        Thu, 22 Dec 2022 09:09:33 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     Jason Zaman <jason@perfinion.com>, selinux@vger.kernel.org
Cc:     Jason Zaman <jason@perfinion.com>
Subject: Re: [PATCH 1/2] libselinux: Ignore installed when installing python
 bindings to DESTDIR
In-Reply-To: <20221222064452.13722-1-jason@perfinion.com>
References: <20221222064452.13722-1-jason@perfinion.com>
Date:   Thu, 22 Dec 2022 10:09:32 +0100
Message-ID: <87v8m37qk3.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Jason Zaman <jason@perfinion.com> writes:

> When the python bindings are installed to a destdir with pip install
> --prefix= --root=, pip tries to uninstall the existing root-owned
> package and fails
>
> Fixes:
> running build_ext
> python3 -m pip install --prefix=/usr `test -n "/tmp/selinux-release//build-master" && echo --root /tmp/selinux-release//build-master`  .
> Processing /tmp/selinux-release/selinux-master/libselinux/src
>   Preparing metadata (setup.py) ... done
> Building wheels for collected packages: selinux
>   Building wheel for selinux (setup.py) ... done
>   Created wheel for selinux: filename=selinux-3.4-cp310-cp310-linux_x86_64.whl size=725511 sha256=b35e9cdb2a6efce389eeece45446826b4ac6b41f81fdc128893f947036f27e8e
>   Stored in directory: /tmp/pip-ephem-wheel-cache-kemjh99e/wheels/ca/2d/1e/d1ab52426d9add92931471cfa0d2558bcbeed89084af2388c9
> Successfully built selinux
> Installing collected packages: selinux
>   Attempting uninstall: selinux
>     Found existing installation: selinux 3.4
>     Uninstalling selinux-3.4:
> ERROR: Could not install packages due to an OSError: [Errno 13] Permission denied: '__init__.cpython-310.pyc'
> Consider using the `--user` option or check the permissions.


Acked-by: Petr Lautrbach <lautrbach@redhat.com>

> ---
>  libselinux/src/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
> index 0f6396ab..70ba063a 100644
> --- a/libselinux/src/Makefile
> +++ b/libselinux/src/Makefile
> @@ -187,7 +187,7 @@ install: all
>  	ln -sf --relative $(DESTDIR)$(SHLIBDIR)/$(LIBSO) $(DESTDIR)$(LIBDIR)/$(TARGET)
>  
>  install-pywrap: pywrap
> -	$(PYTHON) -m pip install --prefix=$(PREFIX) `test -n "$(DESTDIR)" && echo --root $(DESTDIR)` $(PYTHON_SETUP_ARGS) .
> +	$(PYTHON) -m pip install --prefix=$(PREFIX) `test -n "$(DESTDIR)" && echo --root $(DESTDIR) --ignore-installed --no-deps` $(PYTHON_SETUP_ARGS) .
>  	install -m 644 $(SWIGPYOUT) $(DESTDIR)$(PYTHONLIBDIR)/selinux/__init__.py
>  	ln -sf --relative $(DESTDIR)$(PYTHONLIBDIR)/selinux/_selinux$(PYCEXT) $(DESTDIR)$(PYTHONLIBDIR)/_selinux$(PYCEXT)
>  
> -- 
> 2.38.2

