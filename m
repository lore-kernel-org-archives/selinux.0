Return-Path: <SRS0=L/GO=OC=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D57C0C43441
	for <selinux@archiver.kernel.org>; Fri, 23 Nov 2018 21:08:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89D5620664
	for <selinux@archiver.kernel.org>; Fri, 23 Nov 2018 21:08:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89D5620664
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=m4x.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726683AbeKXHyo (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 24 Nov 2018 02:54:44 -0500
Received: from mx1.polytechnique.org ([129.104.30.34]:43062 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726668AbeKXHyo (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sat, 24 Nov 2018 02:54:44 -0500
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 99B7A56495F
        for <selinux@vger.kernel.org>; Fri, 23 Nov 2018 22:08:47 +0100 (CET)
Received: by mail-ot1-f45.google.com with SMTP id f18so10061613otl.11
        for <selinux@vger.kernel.org>; Fri, 23 Nov 2018 13:08:47 -0800 (PST)
X-Gm-Message-State: AA+aEWYuMnd79W6l2TdoV/NHC7Hc1OyV19sNDxy+/1vb5SaK1XeQQe5Q
        YQeIIJIB03Ham4mecuDpXAIx5t1x/PezmtetMbI=
X-Google-Smtp-Source: AFSGD/U0djqLpsJar6Cbjc2ELqGZ8iyx4pRmyxqGmRn0f5doxRwfV8grq72N1F1IvPDNQi+kPiXXMHkhxyWK8qSfnc8=
X-Received: by 2002:a9d:3e4a:: with SMTP id h10mr10428091otg.74.1543007326599;
 Fri, 23 Nov 2018 13:08:46 -0800 (PST)
MIME-Version: 1.0
References: <20181105143838.5198-1-sds@tycho.nsa.gov> <CAJfZ7=keH-Kxs0nE7AvM1POCX=CSsGWU7H2WYqYDWBwdjsWcUQ@mail.gmail.com>
In-Reply-To: <CAJfZ7=keH-Kxs0nE7AvM1POCX=CSsGWU7H2WYqYDWBwdjsWcUQ@mail.gmail.com>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Fri, 23 Nov 2018 22:08:35 +0100
X-Gmail-Original-Message-ID: <CAJfZ7=mcvpmn5PBYMpt2Uk+WYZ0QrLokpXT6h88Hoq-8AWsKGw@mail.gmail.com>
Message-ID: <CAJfZ7=mcvpmn5PBYMpt2Uk+WYZ0QrLokpXT6h88Hoq-8AWsKGw@mail.gmail.com>
Subject: Re: [PATCH] libsepol: ibpkeys.c: fix printf format string specifiers
 for subnet_prefix
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Fri Nov 23 22:08:48 2018 +0100 (CET))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Nov 5, 2018 at 9:55 PM Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
>
> On Mon, Nov 5, 2018 at 3:36 PM Stephen Smalley <sds@tycho.nsa.gov> wrote:
> >
> > Use PRIx64 to print the subnet_prefix (which is a uint64_t) instead
> > of lx.
> >
> > Fixes https://github.com/SELinuxProject/selinux/issues/108
> >
> > Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
> > ---
> >  libsepol/src/ibpkeys.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/libsepol/src/ibpkeys.c b/libsepol/src/ibpkeys.c
> > index 682bf5db..68a9bdfe 100644
> > --- a/libsepol/src/ibpkeys.c
> > +++ b/libsepol/src/ibpkeys.c
> > @@ -1,5 +1,6 @@
> >  #include <netinet/in.h>
> >  #include <stdlib.h>
> > +#include <inttypes.h>
> >
> >  #include "debug.h"
> >  #include "context.h"
> > @@ -176,7 +177,7 @@ int sepol_ibpkey_query(sepol_handle_t *handle,
> >         return STATUS_SUCCESS;
> >
> >  err:
> > -       ERR(handle, "could not query ibpkey subnet prefix: %#lx range %u - %u exists",
> > +       ERR(handle, "could not query ibpkey subnet prefix: %#" PRIx64 " range %u - %u exists",
> >             subnet_prefix, low, high);
> >         return STATUS_ERR;
> >  }
> > @@ -203,7 +204,7 @@ int sepol_ibpkey_modify(sepol_handle_t *handle,
> >         return STATUS_SUCCESS;
> >
> >  err:
> > -       ERR(handle, "could not load ibpkey subnet prefix: %#lx range %u - %u exists",
> > +       ERR(handle, "could not load ibpkey subnet prefix: %#" PRIx64 " range %u - %u exists",
> >             subnet_prefix, low, high);
> >         if (ibpkey) {
> >                 context_destroy(&ibpkey->context[0]);
> > --
> > 2.19.1
> >
>
> This looks good to me, and while testing some things, I found a
> similar issue in libselinux/src/selinux_restorecon.c. Patch
> incoming...
>
> Cheers,
> Nicolas

Merged.

Nicolas

