Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FF2EECAAA1
	for <selinux@archiver.kernel.org>; Mon, 31 Oct 2022 12:50:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230042AbiJaMul (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 31 Oct 2022 08:50:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbiJaMuk (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 31 Oct 2022 08:50:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E50E6DFD3
        for <selinux@vger.kernel.org>; Mon, 31 Oct 2022 05:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667220582;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1UyQSU8xRgI/Z/PRIXcnCqFO6MYq+fJY1z8ECX+9wN4=;
        b=RCvbI9LGZQ2qEthrhFdXXTSZ9ZZvMeVP6Dex6YIFrHcX/0blNHyKeZjpMDZUchZ6omPg0P
        ibs3ovdQB8I6YLK5SAdVJvXEhVQQWMGbPpfthWSCIUFE7zbp/g4L52bxkaYWBkgoHlRgzv
        uNZL70MzLwLkrsYk4qfi/CBXkVmqAHE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-113-M-j1tzmGP9KCRcnFdyYT-w-1; Mon, 31 Oct 2022 08:49:40 -0400
X-MC-Unique: M-j1tzmGP9KCRcnFdyYT-w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9328687B2A5;
        Mon, 31 Oct 2022 12:49:40 +0000 (UTC)
Received: from localhost (ovpn-194-20.brq.redhat.com [10.40.194.20])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4A724140EBF5;
        Mon, 31 Oct 2022 12:49:40 +0000 (UTC)
From:   Petr Lautrbach <lautrbach@redhat.com>
To:     James Carter <jwcart2@gmail.com>, selinux@vger.kernel.org
Subject: Re: [PATCH 0/5] Remove dependency on the Python module distutils
In-Reply-To: <20221028203852.526472-1-jwcart2@gmail.com>
References: <20221028203852.526472-1-jwcart2@gmail.com>
Date:   Mon, 31 Oct 2022 13:49:39 +0100
Message-ID: <877d0grwd8.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
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
> James Carter (5):
>   libselinux: Remove dependency on the Python module distutils
>   libsemanage: Remove dependency on the Python module distutils
>   python: Remove dependency on the Python module distutils
>   scripts: Remove dependency on the Python module distutils
>   README.md: Remove mention of python3-distutils dependency


Acked-by: Petr Lautrbach <lautrbach@redhat.com>

Thanks!



>  README.md                             | 1 -
>  libselinux/src/Makefile               | 2 +-
>  libselinux/src/setup.py               | 2 +-
>  libsemanage/src/Makefile              | 2 +-
>  python/semanage/Makefile              | 2 +-
>  python/sepolgen/src/sepolgen/Makefile | 2 +-
>  python/sepolicy/sepolicy/gui.py       | 2 +-
>  python/sepolicy/setup.py              | 2 +-
>  scripts/env_use_destdir               | 2 +-
>  scripts/run-scan-build                | 2 +-
>  10 files changed, 9 insertions(+), 10 deletions(-)
>
> -- 
> 2.37.3

