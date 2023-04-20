Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51532C77B73
	for <selinux@archiver.kernel.org>; Thu, 20 Apr 2023 14:29:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231320AbjDTO32 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 20 Apr 2023 10:29:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbjDTO31 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 20 Apr 2023 10:29:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 230FE3A92
        for <selinux@vger.kernel.org>; Thu, 20 Apr 2023 07:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682000918;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=u8OlpZRBFLcw/+sLBTLiFTf6pGMM4SoOTGAi6HikYIo=;
        b=V/9d1A0wubEh6Cad/L0x6iDNq6KkdsFnx8By62PJZ+YKIJ+3ZZHCD6ZRRmi/Y3qky6xgc+
        9J+nFF/AEw9FVWS6CHnauejsJ3qh2sOF8OPCdRQPTRl8p2hWBHsrQWPEAKxHcrKT9B0R65
        LBt3nNmpyst8HH26a8zyMeHVtgSxHqA=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-534-cd4-Mn2xPKqKN_GLt8xmPQ-1; Thu, 20 Apr 2023 10:28:37 -0400
X-MC-Unique: cd4-Mn2xPKqKN_GLt8xmPQ-1
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-1a6ee59714aso7494215ad.0
        for <selinux@vger.kernel.org>; Thu, 20 Apr 2023 07:28:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682000916; x=1684592916;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u8OlpZRBFLcw/+sLBTLiFTf6pGMM4SoOTGAi6HikYIo=;
        b=l9i3XAhiKfMM86b9Cfe4yqpgf431ihLR/UV82pDfzAD1NMPGyd4XiGhFZ0XuqDtpbo
         RzVS0w8e6GlRbI5UmmSDDiWsfG9T7Oe7ZtxOkhjKOW40uvf+nchyphin7dza2GS/tc7Y
         6A41bBGT9+yoOBO/RbyK1RqAVFw71tnfMemC/8yG+dLv/PI8o7tXqOkiq8t+t3c2ApAu
         Mf4CxASc1SF1Q8XvRrk+NvZpfkZvc/ryP6XEKHJffTbWaL9YTFdcJvSJ86RmSVkostNd
         6jtwZjoYSgqZVBTg2YL2qQF8sS5y+wc5EwFfGFYkVffDhd7qeCITa4kiFZKbU5NyX17D
         W0bQ==
X-Gm-Message-State: AAQBX9cz2gmHhplVqg9SjekOLdQabdMpZUddosZozqD15CltqWgB0aoA
        7YMxTlbyDnkMw+WckG4sQvWXBQYXITpdzecNB+J9CukCU3WqqfzeW5Q8BMVyJ/N243jL+jxrZ6h
        K1kUveJGDwLfYSuYEXad6dLnKta4Qj0Jvgw==
X-Received: by 2002:a17:902:db05:b0:1a6:67e1:4d2c with SMTP id m5-20020a170902db0500b001a667e14d2cmr2400547plx.6.1682000916017;
        Thu, 20 Apr 2023 07:28:36 -0700 (PDT)
X-Google-Smtp-Source: AKy350a9UhAFoaB72J/fasnR1rS/XHk8q+/2IfaqDfRu+6A3Ez5jUPSs6Fvo/gyw19ZD2aEYE5QiN5TDKE2k1wqeLTE=
X-Received: by 2002:a17:902:db05:b0:1a6:67e1:4d2c with SMTP id
 m5-20020a170902db0500b001a667e14d2cmr2400528plx.6.1682000915745; Thu, 20 Apr
 2023 07:28:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230420135803.4692-1-cgzones@googlemail.com>
In-Reply-To: <20230420135803.4692-1-cgzones@googlemail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Thu, 20 Apr 2023 16:28:24 +0200
Message-ID: <CAFqZXNtQ+zxTGBJbxXySaLVZHf7O3nXa9K84kV7GNtLJKZASAw@mail.gmail.com>
Subject: Re: [TESTSUITE PATCH] README.md: update dependencies
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Apr 20, 2023 at 3:59=E2=80=AFPM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
> Add libibverbs-dev, required since 4b4922e1 ("tests/infiniband*:
> simplify test activation"):
>
>     create_modify_qp.c:10:10: fatal error: infiniband/verbs.h: No such fi=
le or directory
>        10 | #include <infiniband/verbs.h>
>           |          ^~~~~~~~~~~~~~~~~~~~
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> ---
>  README.md | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/README.md b/README.md
> index 7bd1dbc..5256cda 100644
> --- a/README.md
> +++ b/README.md
> @@ -82,6 +82,7 @@ following command (NOTE: On Fedora 32 and below you nee=
d to remove
>                 lksctp-tools-devel \
>                 attr \
>                 libbpf-devel \
> +               libibverbs-devel \
>                 keyutils-libs-devel \
>                 quota \
>                 xfsprogs-devel \
> @@ -124,6 +125,7 @@ command:
>                 libselinux1-dev \
>                 net-tools \
>                 iptables \
> +               libibverbs-dev \
>                 libsctp-dev \
>                 attr \
>                 libbpf-dev \
> --
> 2.40.0
>

These have already been added in
https://github.com/SELinuxProject/selinux-testsuite/commit/65cbbb8c4a4cafd1=
b307bfbd954acd7c5a653bb8

--=20
Ondrej Mosnacek
Senior Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

