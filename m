Return-Path: <SRS0=riLa=NQ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04E5DC0044C
	for <selinux@archiver.kernel.org>; Mon,  5 Nov 2018 20:56:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4BFF20827
	for <selinux@archiver.kernel.org>; Mon,  5 Nov 2018 20:56:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4BFF20827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=m4x.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727329AbeKFGRe (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 6 Nov 2018 01:17:34 -0500
Received: from mx1.polytechnique.org ([129.104.30.34]:52731 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726902AbeKFGRe (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 6 Nov 2018 01:17:34 -0500
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 11E24561250
        for <selinux@vger.kernel.org>; Mon,  5 Nov 2018 21:55:59 +0100 (CET)
Received: by mail-ot1-f51.google.com with SMTP id m15so9376506otl.7
        for <selinux@vger.kernel.org>; Mon, 05 Nov 2018 12:55:58 -0800 (PST)
X-Gm-Message-State: AGRZ1gJp+vaOiP5wNrFu2gT/Rq268rPr7YBp70F/mRYekJuxy+cvYXk9
        8SxtzuhQeXnB8MPXVzAzF3RtYZRfL2I29hZFRaI=
X-Google-Smtp-Source: AJdET5cRwb6ejD36d7fr3L7Hb9xhiLf3GGm5SkIIleYP6uoSlVv/meGD8xQXC/8DTaUH8ryJdAqQpipyHiMu5m7KUMo=
X-Received: by 2002:a9d:6108:: with SMTP id i8mr15103081otj.278.1541451358023;
 Mon, 05 Nov 2018 12:55:58 -0800 (PST)
MIME-Version: 1.0
References: <20181105143838.5198-1-sds@tycho.nsa.gov>
In-Reply-To: <20181105143838.5198-1-sds@tycho.nsa.gov>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Mon, 5 Nov 2018 21:55:46 +0100
X-Gmail-Original-Message-ID: <CAJfZ7=keH-Kxs0nE7AvM1POCX=CSsGWU7H2WYqYDWBwdjsWcUQ@mail.gmail.com>
Message-ID: <CAJfZ7=keH-Kxs0nE7AvM1POCX=CSsGWU7H2WYqYDWBwdjsWcUQ@mail.gmail.com>
Subject: Re: [PATCH] libsepol: ibpkeys.c: fix printf format string specifiers
 for subnet_prefix
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Mon Nov  5 21:55:59 2018 +0100 (CET))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Nov 5, 2018 at 3:36 PM Stephen Smalley <sds@tycho.nsa.gov> wrote:
>
> Use PRIx64 to print the subnet_prefix (which is a uint64_t) instead
> of lx.
>
> Fixes https://github.com/SELinuxProject/selinux/issues/108
>
> Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
> ---
>  libsepol/src/ibpkeys.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/libsepol/src/ibpkeys.c b/libsepol/src/ibpkeys.c
> index 682bf5db..68a9bdfe 100644
> --- a/libsepol/src/ibpkeys.c
> +++ b/libsepol/src/ibpkeys.c
> @@ -1,5 +1,6 @@
>  #include <netinet/in.h>
>  #include <stdlib.h>
> +#include <inttypes.h>
>
>  #include "debug.h"
>  #include "context.h"
> @@ -176,7 +177,7 @@ int sepol_ibpkey_query(sepol_handle_t *handle,
>         return STATUS_SUCCESS;
>
>  err:
> -       ERR(handle, "could not query ibpkey subnet prefix: %#lx range %u - %u exists",
> +       ERR(handle, "could not query ibpkey subnet prefix: %#" PRIx64 " range %u - %u exists",
>             subnet_prefix, low, high);
>         return STATUS_ERR;
>  }
> @@ -203,7 +204,7 @@ int sepol_ibpkey_modify(sepol_handle_t *handle,
>         return STATUS_SUCCESS;
>
>  err:
> -       ERR(handle, "could not load ibpkey subnet prefix: %#lx range %u - %u exists",
> +       ERR(handle, "could not load ibpkey subnet prefix: %#" PRIx64 " range %u - %u exists",
>             subnet_prefix, low, high);
>         if (ibpkey) {
>                 context_destroy(&ibpkey->context[0]);
> --
> 2.19.1
>

This looks good to me, and while testing some things, I found a
similar issue in libselinux/src/selinux_restorecon.c. Patch
incoming...

Cheers,
Nicolas

