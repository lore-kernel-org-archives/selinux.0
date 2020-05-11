Return-Path: <SRS0=Gc5K=6Z=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9622C47255
	for <selinux@archiver.kernel.org>; Mon, 11 May 2020 18:27:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC5F22078E
	for <selinux@archiver.kernel.org>; Mon, 11 May 2020 18:27:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E69GEjOQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731209AbgEKS1s (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 11 May 2020 14:27:48 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:54979 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729772AbgEKS1q (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 11 May 2020 14:27:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589221664;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jsxgY/4iVflo1uWCwbbZrhEkzoAvx85NV30+E5cHtBg=;
        b=E69GEjOQ3e5ZFo2pZJTZ6ZCGSNG9NG9vsKo9dGKki9eDr30Ea6ZCmogpQbUi/ORxo/W8Z7
        TAPxdpUVDnBt6DOZzJn6dIPMrqBQu1dYRYAo/25Ut5JBVxoVERF2dvW+aCXHo7iXqdVCTy
        HtWJds1wPPcTCErYib3+7ljlCCgmlhc=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-442-K12z2s0IPJSGntdgkxSzgw-1; Mon, 11 May 2020 14:27:42 -0400
X-MC-Unique: K12z2s0IPJSGntdgkxSzgw-1
Received: by mail-oi1-f199.google.com with SMTP id x2so12677342oif.18
        for <selinux@vger.kernel.org>; Mon, 11 May 2020 11:27:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jsxgY/4iVflo1uWCwbbZrhEkzoAvx85NV30+E5cHtBg=;
        b=aYvjOS//5gcFrxePpqX3x4Wo+NK8n5yZayrLrUQt3Yu/dYtMBbexkGKSYOuWQtGJt/
         0AkgVT9iyD33lHKAvL8ryOQezFZkunUJlifyHzLrzI7jPjgNrJXdP5FnT/YrArY58ape
         t1PXQYiCrdF9giYdhEbIf0dt6f2R+Hwvxv3Mc6BVRvN/7L9yGATPQq9UuAEZBOu64Sn4
         W/WN1yWV6Ue0vqxEyfJ8d21ADdSGEbgOHgfTtWW6aD9z+EccM0PUkfPdxS+UDUy4o78n
         J/AVdE3o3DKNjCNwEqW1+ZTft8SCqNS4yjeZrvbhbzpT0x3x48G2nPfkCW3XpznNJmrG
         UZ8Q==
X-Gm-Message-State: AGi0Puaf4AlPWa+qTaa63SthsAsu8D7XqjfnyWFQGdp/VVucs8R+FV6K
        JlrWKSwLs6T91OsmZEUTS4dHFBBP5tY68I5P03fGh61whkYIme7JZLiomPRrssiDgglhW5GFmqy
        4fIA7SqLzXl1aaspyC2LFOmBMKR2T/flKlg==
X-Received: by 2002:a9d:2d89:: with SMTP id g9mr13256002otb.367.1589221661595;
        Mon, 11 May 2020 11:27:41 -0700 (PDT)
X-Google-Smtp-Source: APiQypLXtZ4xuNJFXsC+I2A2OSE5+2PRQTqJifXSirwJbj53IDB9SLkFWhDERqM8PH0K1J8MAEBT1/CJipEFU+v9K0E=
X-Received: by 2002:a9d:2d89:: with SMTP id g9mr13255979otb.367.1589221661315;
 Mon, 11 May 2020 11:27:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200511150118.838-1-stephen.smalley.work@gmail.com>
In-Reply-To: <20200511150118.838-1-stephen.smalley.work@gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Mon, 11 May 2020 20:27:29 +0200
Message-ID: <CAFqZXNs0RnZo1X-y0GTDXBQDJqSgSAVWsw1+G7bFuTku1OPeNg@mail.gmail.com>
Subject: Re: [PATCH v2 testsuite] tests/filesystem: fix quotas_test
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, May 11, 2020 at 5:01 PM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> As per the man page, quotactl(2) expects to be passed a pointer to
> a 4-byte buffer for Q_GETFMT.  The kernel copies a single u32 value.
> On Ubuntu, this was detected as a stack smash when running the test.
> Fix the test program.
>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Acked-by: Ondrej Mosnacek <omosnace@redhat.com>

> ---
> v2 includes stdint.h and uses uint32_t for the fmtval variable.
>
>  tests/filesystem/quotas_test.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/tests/filesystem/quotas_test.c b/tests/filesystem/quotas_test.c
> index 8359811..bca230d 100644
> --- a/tests/filesystem/quotas_test.c
> +++ b/tests/filesystem/quotas_test.c
> @@ -1,3 +1,4 @@
> +#include <stdint.h>
>  #include <stdio.h>
>  #include <stdlib.h>
>  #include <string.h>
> @@ -33,7 +34,7 @@ int main(int argc, char *argv[])
>         int opt, result, qcmd, save_err, test_id = geteuid();
>         char *context, *src = NULL, *tgt = NULL;
>         bool verbose = false;
> -       char fmt_buf[2];
> +       uint32_t fmtval;
>
>         while ((opt = getopt(argc, argv, "s:t:v")) != -1) {
>                 switch (opt) {
> @@ -77,7 +78,7 @@ int main(int argc, char *argv[])
>                         printf("User Quota - ON\n");
>
>                 qcmd = QCMD(Q_GETFMT, USRQUOTA);
> -               result = quotactl(qcmd, src, test_id, fmt_buf);
> +               result = quotactl(qcmd, src, test_id, (caddr_t)&fmtval);
>                 save_err = errno;
>                 if (result < 0) {
>                         fprintf(stderr, "quotactl(Q_GETFMT, USRQUOTA) Failed: %s\n",
> @@ -85,7 +86,7 @@ int main(int argc, char *argv[])
>                         return save_err;
>                 }
>                 if (verbose)
> -                       printf("User Format: 0x%x\n", fmt_buf[0]);
> +                       printf("User Format: 0x%x\n", fmtval);
>
>                 qcmd = QCMD(Q_QUOTAOFF, USRQUOTA);
>                 result = quotactl(qcmd, src, QFMT_VFS_V0, tgt);
> @@ -113,7 +114,7 @@ int main(int argc, char *argv[])
>                         printf("Group Quota - ON\n");
>
>                 qcmd = QCMD(Q_GETFMT, GRPQUOTA);
> -               result = quotactl(qcmd, src, test_id, fmt_buf);
> +               result = quotactl(qcmd, src, test_id, (caddr_t)&fmtval);
>                 save_err = errno;
>                 if (result < 0) {
>                         fprintf(stderr, "quotactl(Q_GETFMT, GRPQUOTA) Failed: %s\n",
> @@ -121,7 +122,7 @@ int main(int argc, char *argv[])
>                         return save_err;
>                 }
>                 if (verbose)
> -                       printf("Group Format: 0x%x\n", fmt_buf[0]);
> +                       printf("Group Format: 0x%x\n", fmtval);
>
>                 qcmd = QCMD(Q_QUOTAOFF, GRPQUOTA);
>                 result = quotactl(qcmd, src, QFMT_VFS_V0, tgt);
> --
> 2.23.3
>


-- 
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.

