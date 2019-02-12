Return-Path: <SRS0=5iRL=QT=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1C5EC282C4
	for <selinux@archiver.kernel.org>; Tue, 12 Feb 2019 21:02:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7292222C0
	for <selinux@archiver.kernel.org>; Tue, 12 Feb 2019 21:02:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727816AbfBLVCe (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 12 Feb 2019 16:02:34 -0500
Received: from mx1.polytechnique.org ([129.104.30.34]:50954 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726788AbfBLVCe (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 12 Feb 2019 16:02:34 -0500
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 326AF5646D5
        for <selinux@vger.kernel.org>; Tue, 12 Feb 2019 22:02:30 +0100 (CET)
Received: by mail-ot1-f46.google.com with SMTP id i20so253271otl.0
        for <selinux@vger.kernel.org>; Tue, 12 Feb 2019 13:02:30 -0800 (PST)
X-Gm-Message-State: AHQUAuZAXDCuv+f1Wh/OBZjiqnFUCUphtQN9AkZaYxjy9n2tCxxg19G0
        BENTuDGWRucrY6hk1cqv8LqSiAWwv7TxsQUcYQ8=
X-Google-Smtp-Source: AHgI3IYYYf7/5wRBM5s4Iy6jzJjUiQ4xQ6dIYoh7/2ukmLC/cPlI+vjplkbWq2O0ExXGAXoJMOOgdWVrtzMNq69a4yY=
X-Received: by 2002:a9d:6206:: with SMTP id g6mr5808580otj.338.1550005349298;
 Tue, 12 Feb 2019 13:02:29 -0800 (PST)
MIME-Version: 1.0
References: <pjdimxuxm7c.fsf@redhat.com> <20190212152046.13875-1-plautrba@redhat.com>
In-Reply-To: <20190212152046.13875-1-plautrba@redhat.com>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Tue, 12 Feb 2019 22:02:18 +0100
X-Gmail-Original-Message-ID: <CAJfZ7=kFKx6cz1Tj1impdii4iDKfKtC_LffBTW3Rfg1fEJkHzA@mail.gmail.com>
Message-ID: <CAJfZ7=kFKx6cz1Tj1impdii4iDKfKtC_LffBTW3Rfg1fEJkHzA@mail.gmail.com>
Subject: Re: [PATCH v2] libsemanage: genhomedircon - improve handling large groups
To:     Petr Lautrbach <plautrba@redhat.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Tue Feb 12 22:02:30 2019 +0100 (CET))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Feb 12, 2019 at 4:20 PM Petr Lautrbach <plautrba@redhat.com> wrote:
>
> getgrnam_r() uses a preallocated buffer to store a structure containing
> the broken-out fields of the record in the group database. The size of
> this buffer is usually sysconf(_SC_GETGR_R_SIZE_MAX) == 1024 and it is
> not enough for groups with a large number of users.  In these cases,
> getgrnam_r() returns -1 and sets errno to ERANGE and the caller can
> retry with a larger buffer.
>
> Fixes:
> $ semanage login -a -s user_u -r s0-s0:c1.c2 '%largegroup'
> libsemanage.semanage_direct_commit: semanage_genhomedircon returned error code -1. (Numerical result out of range).
> OSError: Numerical result out of range
>
> Signed-off-by: Petr Lautrbach <plautrba@redhat.com>

Acked-by: Nicolas Iooss <nicolas.iooss@m4x.org>
> ---
>  libsemanage/src/genhomedircon.c | 20 +++++++++++++++++---
>  1 file changed, 17 insertions(+), 3 deletions(-)
>
> diff --git a/libsemanage/src/genhomedircon.c b/libsemanage/src/genhomedircon.c
> index 591941fb..e5f8d371 100644
> --- a/libsemanage/src/genhomedircon.c
> +++ b/libsemanage/src/genhomedircon.c
> @@ -1077,10 +1077,24 @@ static int get_group_users(genhomedircon_settings_t * s,
>
>         const char *grname = selogin + 1;
>
> -       if (getgrnam_r(grname, &grstorage, grbuf,
> -                       (size_t) grbuflen, &group) != 0) {
> -               goto cleanup;
> +       errno = 0;
> +       while (
> +               (retval = getgrnam_r(grname, &grstorage, grbuf, (size_t) grbuflen, &group)) != 0 &&
> +               errno == ERANGE
> +       ) {
> +               char *new_grbuf;
> +               grbuflen *= 2;
> +               if (grbuflen < 0)
> +                       /* the member list could exceed 2Gb on a system with a 32-bit CPU (where
> +                        * sizeof(long) = 4) - if this ever happened, the loop would become infinite. */
> +                       goto cleanup;
> +               new_grbuf = realloc(grbuf, grbuflen);
> +               if (new_grbuf == NULL)
> +                       goto cleanup;
> +               grbuf = new_grbuf;
>         }
> +       if (retval != 0)
> +               goto cleanup;
>
>         if (group == NULL) {
>                 ERR(s->h_semanage, "Can't find group named %s\n", grname);
> --
> 2.20.1
>

