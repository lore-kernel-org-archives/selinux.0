Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCB56C05027
	for <selinux@archiver.kernel.org>; Wed,  1 Feb 2023 15:50:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbjBAPub (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 1 Feb 2023 10:50:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232389AbjBAPuX (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 1 Feb 2023 10:50:23 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8CC474C21
        for <selinux@vger.kernel.org>; Wed,  1 Feb 2023 07:49:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675266568;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=775JqXzq2LU2xEL+HrnWxTUTmRAP/Dz4BaPSwsGdStA=;
        b=YfdUxWqe/ADmAaskOa9bYGlheotsJwnhnlytqmK6c5jh3pFI7NfiWS4PSErlov63L/I60i
        n27EPd/zcz8nc3SW2k83oJmXupVCR/C1H+1xuATH8HJ28bXsozdulz+lSVra1NgrkdYrdM
        +swjp/No4DJxHGBk3bH53U2exehNivw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-633-R_Idc4elNKmwFe_puw1-bQ-1; Wed, 01 Feb 2023 10:49:19 -0500
X-MC-Unique: R_Idc4elNKmwFe_puw1-bQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C7694800B30;
        Wed,  1 Feb 2023 15:49:16 +0000 (UTC)
Received: from localhost (ovpn-193-64.brq.redhat.com [10.40.193.64])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7E9072026D4B;
        Wed,  1 Feb 2023 15:49:16 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     Jason Zaman <jason@perfinion.com>, selinux@vger.kernel.org
Subject: Re: [PATCH] ci: bump to python 3.11 in GitHub Actions
In-Reply-To: <20230115233426.41204-1-jason@perfinion.com>
References: <20230115233426.41204-1-jason@perfinion.com>
Date:   Wed, 01 Feb 2023 16:49:15 +0100
Message-ID: <87r0v975dw.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Jason Zaman <jason@perfinion.com> writes:

> - Also drop py3.5, py3.6 since they are no longer supported in the
>   github 22.04 runners
>
> Signed-off-by: Jason Zaman <jason@perfinion.com>

Acked-by: Petr Lautrbach <lautrbach@redhat.com>

and merged. Thanks!


> ---
>
> CI passed here: https://github.com/perfinion/selinux/actions/runs/3925727573
>
>
>  .github/workflows/run_tests.yml | 27 +++++++++++++--------------
>  1 file changed, 13 insertions(+), 14 deletions(-)
>
> diff --git a/.github/workflows/run_tests.yml b/.github/workflows/run_tests.yml
> index db0e1af5..198ba7b6 100644
> --- a/.github/workflows/run_tests.yml
> +++ b/.github/workflows/run_tests.yml
> @@ -10,31 +10,30 @@ jobs:
>        matrix:
>          compiler: [gcc, clang]
>          python-ruby-version:
> -          - {python: '3.10', ruby: '3.1'}
> -          - {python: '3.10', ruby: '3.1', other: test-flags-override}
> -          - {python: '3.10', ruby: '3.1', other: test-debug}
> -          - {python: '3.10', ruby: '3.1', other: linker-bfd}
> -          - {python: '3.10', ruby: '3.1', other: linker-gold}
> +          - {python: '3.11', ruby: '3.1'}
> +          - {python: '3.11', ruby: '3.1', other: 'test-flags-override'}
> +          - {python: '3.11', ruby: '3.1', other: 'test-debug'}
> +          - {python: '3.11', ruby: '3.1', other: 'linker-bfd'}
> +          - {python: '3.11', ruby: '3.1', other: 'linker-gold'}
>            # Test several Python versions with the latest Ruby version
> +          - {python: '3.10', ruby: '3.1'}
>            - {python: '3.9', ruby: '3.1'}
>            - {python: '3.8', ruby: '3.1'}
>            - {python: '3.7', ruby: '3.1'}
> -          - {python: '3.6', ruby: '3.1'}
> -          - {python: '3.5', ruby: '3.1'}
>            - {python: 'pypy3.7', ruby: '3.1'}
>            # Test several Ruby versions with the latest Python version
> -          - {python: '3.10', ruby: '3.0'}
> -          - {python: '3.10', ruby: '2.7'}
> -          - {python: '3.10', ruby: '2.6'}
> -          - {python: '3.10', ruby: '2.5'}
> +          - {python: '3.11', ruby: '3.0'}
> +          - {python: '3.11', ruby: '2.7'}
> +          - {python: '3.11', ruby: '2.6'}
> +          - {python: '3.11', ruby: '2.5'}
>          exclude:
>            - compiler: clang
> -            python-ruby-version: {python: '3.10', ruby: '3.1', other: linker-bfd}
> +            python-ruby-version: {python: '3.11', ruby: '3.1', other: 'linker-bfd'}
>            - compiler: clang
> -            python-ruby-version: {python: '3.10', ruby: '3.1', other: linker-gold}
> +            python-ruby-version: {python: '3.11', ruby: '3.1', other: 'linker-gold'}
>          include:
>            - compiler: gcc
> -            python-ruby-version: {python: '3.10', ruby: '3.1', other: sanitizers}
> +            python-ruby-version: {python: '3.11', ruby: '3.1', other: 'sanitizers'}
>  
>      steps:
>      - uses: actions/checkout@v3
> -- 
> 2.38.2

