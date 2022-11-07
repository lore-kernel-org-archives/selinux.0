Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5F30C4332F
	for <selinux@archiver.kernel.org>; Mon,  7 Nov 2022 08:14:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231239AbiKGIO4 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 7 Nov 2022 03:14:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230515AbiKGIOz (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 7 Nov 2022 03:14:55 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF56DB7FF
        for <selinux@vger.kernel.org>; Mon,  7 Nov 2022 00:13:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667808838;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NleJUl74WUMx06o8PHXyXkfi09U5R3AILygzZMQ7d3I=;
        b=VgvxBEzH31V2+FaGSMKjzhGVbXCFWJFwpz50JdOhFbBAAYVIdbjfPIIOnBZTCd/aCHys2u
        9LFduikK0nPpBBBJT3vvpgOWry78veXdmkyWauos8LxTyheEck6p4I52iJwW+hSwfQNvAv
        dmddRvlEFVxmdRguD31BZmnnTN6+4v8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-645-izwSk2WuN9myGYRaHEvzMQ-1; Mon, 07 Nov 2022 03:13:56 -0500
X-MC-Unique: izwSk2WuN9myGYRaHEvzMQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 16DBE101E152;
        Mon,  7 Nov 2022 08:13:56 +0000 (UTC)
Received: from localhost (ovpn-192-172.brq.redhat.com [10.40.192.172])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BFDE61121315;
        Mon,  7 Nov 2022 08:13:55 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     James Carter <jwcart2@gmail.com>, selinux@vger.kernel.org
Subject: Re: [PATCH 0/5 v3] Remove dependency on the Python module distutils
In-Reply-To: <20221104143616.1089636-1-jwcart2@gmail.com>
References: <20221104143616.1089636-1-jwcart2@gmail.com>
Date:   Mon, 07 Nov 2022 09:13:54 +0100
Message-ID: <87r0yfchbx.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

James Carter <jwcart2@gmail.com> writes:

> The distutils package is deprecated and scheduled to be removed in
> Python 3.12.
>
> When building the SELinux userspace we currently get warnings like the following:
> <string>:1: DeprecationWarning: The distutils.sysconfig module is deprecated, use sysconfig instead
> <string>:1: DeprecationWarning: The distutils package is deprecated and slated for removal in Python 3.12. Use setuptools or check PEP 632 for potential alternatives
>
> I am not a Python expert, but everything seems to work with these patches.
> I would appreciate other people testing this and any Python experts to let
> me know if this is the right way of replacing distutils.
>
> v3: Removed a second usage of distutils in python/sepolicy/sepolicy/gui.py
>
> v2: Use sysconfig.get_path('purelib'... when original used
>     get_python_lib(prefix=... and use sysconfig.get_path('platlib'...
>     when original used get_python_lib(plat_specific=1, prefix=...
>
> James Carter (5):
>   libselinux: Remove dependency on the Python module distutils
>   libsemanage: Remove dependency on the Python module distutils
>   python: Remove dependency on the Python module distutils
>   scripts: Remove dependency on the Python module distutils
>   README.md: Remove mention of python3-distutils dependency

Acked-by: Petr Lautrbach <plautrba@redhat.com>


>  README.md                             | 1 -
>  libselinux/src/Makefile               | 2 +-
>  libselinux/src/setup.py               | 2 +-
>  libsemanage/src/Makefile              | 2 +-
>  python/semanage/Makefile              | 2 +-
>  python/sepolgen/src/sepolgen/Makefile | 2 +-
>  python/sepolicy/sepolicy/gui.py       | 4 ++--
>  python/sepolicy/setup.py              | 2 +-
>  scripts/env_use_destdir               | 2 +-
>  scripts/run-scan-build                | 2 +-
>  10 files changed, 10 insertions(+), 11 deletions(-)
>
> -- 
> 2.38.1

