Return-Path: <SRS0=eLZI=A6=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F966C433DF
	for <selinux@archiver.kernel.org>; Sun, 19 Jul 2020 16:51:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75E4820B1F
	for <selinux@archiver.kernel.org>; Sun, 19 Jul 2020 16:51:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726073AbgGSQvo (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 19 Jul 2020 12:51:44 -0400
Received: from mx1.polytechnique.org ([129.104.30.34]:47106 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbgGSQvn (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 19 Jul 2020 12:51:43 -0400
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 99E825646A3
        for <selinux@vger.kernel.org>; Sun, 19 Jul 2020 18:43:46 +0200 (CEST)
Received: by mail-ot1-f43.google.com with SMTP id t18so10423226otq.5
        for <selinux@vger.kernel.org>; Sun, 19 Jul 2020 09:43:46 -0700 (PDT)
X-Gm-Message-State: AOAM530wmf0VWnfNJWLRcxkBz1QSGBDjmobZXa9hzUr0Xe941OPy3DG+
        wT7DTkTnVfBpGVZN9hz4ZQIBeGbdl6m9gvUcuEI=
X-Google-Smtp-Source: ABdhPJwzVE0GOt+0UkT0VVpr70QTGAqUF+SwmMm7rjlo488uICghTcfEZ4b6Vjy5i72msaLnBX4SYUY1advWKKFI06o=
X-Received: by 2002:a9d:855:: with SMTP id 79mr16211081oty.361.1595177025559;
 Sun, 19 Jul 2020 09:43:45 -0700 (PDT)
MIME-Version: 1.0
References: <51d7bd5e067978ea5340ee408a7329e8b921b372.camel@flyn.org>
In-Reply-To: <51d7bd5e067978ea5340ee408a7329e8b921b372.camel@flyn.org>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Sun, 19 Jul 2020 18:43:34 +0200
X-Gmail-Original-Message-ID: <CAJfZ7=kxW1zaROh_9rC8-CCafBciFXmFfKFh0B0fwwGYCTp6Lg@mail.gmail.com>
Message-ID: <CAJfZ7=kxW1zaROh_9rC8-CCafBciFXmFfKFh0B0fwwGYCTp6Lg@mail.gmail.com>
Subject: Re: [PATCH] python/audit2allow: add #include <limits.h> to sepolgen-ifgen-attr-helper.c
To:     "W. Michael Petullo" <mike@flyn.org>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Sun Jul 19 18:43:47 2020 +0200 (CEST))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Jul 16, 2020 at 10:39 PM W. Michael Petullo <mike@flyn.org> wrote:
>
> I found that building on OpenWrt/musl failed with:
>
>   sepolgen-ifgen-attr-helper.c:152:16: error: 'PATH_MAX' undeclared ...
>
> Musl is less "generous" than glibc in recursively including header
> files, and I suspect this is the reason for this error. Explicitly
> including limits.h fixes the problem.
>
> Signed-off-by: W. Michael Petullo <mike@flyn.org>
> ---
>  python/audit2allow/sepolgen-ifgen-attr-helper.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/python/audit2allow/sepolgen-ifgen-attr-helper.c
> b/python/audit2allow/sepolgen-ifgen-attr-helper.c
> index 53f20818..f010c958 100644
> --- a/python/audit2allow/sepolgen-ifgen-attr-helper.c
> +++ b/python/audit2allow/sepolgen-ifgen-attr-helper.c
> @@ -28,6 +28,7 @@
>
>  #include <selinux/selinux.h>
>
> +#include <limits.h>
>  #include <stdio.h>
>  #include <sys/types.h>
>  #include <sys/stat.h>
> --
> 2.26.2

Looks good to me. Nevertheless I had some trouble applying your patch
using "git am" because your message contained
"b/python/audit2allow/sepolgen-ifgen-attr-helper.c" on a new line. Did
you use "git send-email" or something similar, to send your patch?

Acked-by: Nicolas Iooss <nicolas.iooss@m4x.org>

If nobody complains, I will apply this patch tomorrow.
Thanks,
Nicolas

