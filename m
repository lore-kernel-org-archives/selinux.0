Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D54ECC4332F
	for <selinux@archiver.kernel.org>; Thu, 22 Dec 2022 09:10:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235029AbiLVJKn (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 22 Dec 2022 04:10:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235120AbiLVJKi (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 22 Dec 2022 04:10:38 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD47820341
        for <selinux@vger.kernel.org>; Thu, 22 Dec 2022 01:09:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671700190;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LUyH0/b4rnEhFnlkPgAriJFKPbxS/FNrtp1yzk/nw/I=;
        b=UgreLxtrZvJo0g1EWrhslIaIwj3imU+EDCeKl1Hh1rTg6qR+TVWhgdtanZNqaKTIByjtBg
        +eRuNjkG4LHguZdtpxtKtj/2z1EGjQiGVS4YPJQMWAPfpiLvRICBNXG6QiCEDk1Kv27C5O
        K2+jNnmb2JbsnEqoPqNo0WjDtDVlQRU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-615-KjaCdrqtOUet9Ty87vJnrQ-1; Thu, 22 Dec 2022 04:09:47 -0500
X-MC-Unique: KjaCdrqtOUet9Ty87vJnrQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 90782101A521;
        Thu, 22 Dec 2022 09:09:47 +0000 (UTC)
Received: from localhost (ovpn-193-64.brq.redhat.com [10.40.193.64])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 468C42166B29;
        Thu, 22 Dec 2022 09:09:47 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     Jason Zaman <jason@perfinion.com>, selinux@vger.kernel.org
Cc:     Jason Zaman <jason@perfinion.com>
Subject: Re: [PATCH 2/2] python: Ignore installed when installing to DESTDIR
In-Reply-To: <20221222064452.13722-2-jason@perfinion.com>
References: <20221222064452.13722-1-jason@perfinion.com>
 <20221222064452.13722-2-jason@perfinion.com>
Date:   Thu, 22 Dec 2022 10:09:46 +0100
Message-ID: <87sfh77qjp.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Jason Zaman <jason@perfinion.com> writes:

> When installing to a destdir with pip install --prefix= --root=, pip tries to
> uninstall the existing root-owned package and fails
>
> Fixes:
> python3 -m pip install --prefix=/usr `test -n "/tmp/selinux-release//build-master" && echo --root /tmp/selinux-release//build-master`  .
> Processing /tmp/selinux-release/selinux-master/python/sepolicy
>   Preparing metadata (setup.py) ... done
> Building wheels for collected packages: sepolicy
>   Building wheel for sepolicy (setup.py) ... done
>   Created wheel for sepolicy: filename=sepolicy-3.4-py3-none-any.whl size=1663564 sha256=229546db123e7d84613d190d49c192291b1a4f7f2a037657b39283b04ac391a4
>   Stored in directory: /tmp/pip-ephem-wheel-cache-50r2x4cn/wheels/b2/9e/63/6a6212a84d65a709923228719d065ed34e66a90c7fed01e8cf
> Successfully built sepolicy
> Installing collected packages: sepolicy
>   Attempting uninstall: sepolicy
>     Found existing installation: sepolicy 3.4
>     Uninstalling sepolicy-3.4:
> ERROR: Could not install packages due to an OSError: [Errno 13] Permission denied: 'generate.py'
> Consider using the `--user` option or check the permissions.


Acked-by: Petr Lautrbach <lautrbach@redhat.com>


> ---
>  python/sepolicy/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/python/sepolicy/Makefile b/python/sepolicy/Makefile
> index 57a2e55e..4e9e93d0 100644
> --- a/python/sepolicy/Makefile
> +++ b/python/sepolicy/Makefile
> @@ -27,7 +27,7 @@ test:
>  	@$(PYTHON) test_sepolicy.py -v
>  
>  install:
> -	$(PYTHON) -m pip install --prefix=$(PREFIX) `test -n "$(DESTDIR)" && echo --root $(DESTDIR)` $(PYTHON_SETUP_ARGS) .
> +	$(PYTHON) -m pip install --prefix=$(PREFIX) `test -n "$(DESTDIR)" && echo --root $(DESTDIR) --ignore-installed --no-deps` $(PYTHON_SETUP_ARGS) .
>  	[ -d $(DESTDIR)$(BINDIR) ] || mkdir -p $(DESTDIR)$(BINDIR)
>  	install -m 755 sepolicy.py $(DESTDIR)$(BINDIR)/sepolicy
>  	(cd $(DESTDIR)$(BINDIR); ln -sf sepolicy sepolgen)
> -- 
> 2.38.2

