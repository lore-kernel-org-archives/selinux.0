Return-Path: <SRS0=fYOO=63=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBE15C433E0
	for <selinux@archiver.kernel.org>; Wed, 13 May 2020 18:52:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 87A272065C
	for <selinux@archiver.kernel.org>; Wed, 13 May 2020 18:52:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387427AbgEMSwf (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 13 May 2020 14:52:35 -0400
Received: from mx1.polytechnique.org ([129.104.30.34]:33755 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732218AbgEMSwf (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 13 May 2020 14:52:35 -0400
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 2FBA05662AC
        for <selinux@vger.kernel.org>; Wed, 13 May 2020 20:52:32 +0200 (CEST)
Received: by mail-oo1-f45.google.com with SMTP id p67so167217ooa.11
        for <selinux@vger.kernel.org>; Wed, 13 May 2020 11:52:32 -0700 (PDT)
X-Gm-Message-State: AOAM532Tbdyp0aV1k6LLEgi7mdol1JQwp2aAWMlcqjm3itU2J2WMmgg9
        4hg0BNWIU3BCmc8cLSse2uiUxjlUWIb2C6y1Azw=
X-Google-Smtp-Source: ABdhPJzDn0H9WX9n3yfMhnbx1ZvQtV1yf8V0t8ltZKS4CcZLZSodyf2lYdWPopMU6ewvgwHwMjxpyBJVzIXGpdcLAXs=
X-Received: by 2002:a4a:4cca:: with SMTP id a193mr676584oob.46.1589395951013;
 Wed, 13 May 2020 11:52:31 -0700 (PDT)
MIME-Version: 1.0
References: <5ebc4079.1c69fb81.c8782.38eb@mx.google.com>
In-Reply-To: <5ebc4079.1c69fb81.c8782.38eb@mx.google.com>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Wed, 13 May 2020 20:52:20 +0200
X-Gmail-Original-Message-ID: <CAJfZ7=mvfqdh_5KFff7itT3m3FPVnMpcG8_kn+U3EYOw8KebiA@mail.gmail.com>
Message-ID: <CAJfZ7=mvfqdh_5KFff7itT3m3FPVnMpcG8_kn+U3EYOw8KebiA@mail.gmail.com>
Subject: Re: [PATCH] libsemanage: fsync before rename
To:     Smalley <stephen.smalley.work@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Wed May 13 20:52:32 2020 +0200 (CEST))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, May 13, 2020 at 8:46 PM Smalley <stephen.smalley.work@gmail.com> wrote:
>
> From: Stephen Smalley <stephen.smalley.work@gmail.com>
>
> Prior to rename(2)'ing new files into place, fsync(2) them to ensure
> the contents will be fully written prior to rename.  While we are here,
> also fix checking of write(2) to detect short writes.  This code could
> be more generally improved but keeping to the minimal changes required
> to fix this bug.
>
> Fixes: https://github.com/SELinuxProject/selinux/issues/237
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---
>  libsemanage/src/semanage_store.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/libsemanage/src/semanage_store.c b/libsemanage/src/semanage_store.c
> index 859c0a22..3cac36d4 100644
> --- a/libsemanage/src/semanage_store.c
> +++ b/libsemanage/src/semanage_store.c
> @@ -735,7 +735,7 @@ int semanage_copy_file(const char *src, const char *dst, mode_t mode)
>         }
>         umask(mask);
>         while (retval == 0 && (amount_read = read(in, buf, sizeof(buf))) > 0) {
> -               if (write(out, buf, amount_read) < 0) {
> +               if (write(out, buf, amount_read) != amount_read) {
>                         errsv = errno;
>                         retval = -1;
>                 }

If I remember correctly, errno is not defined if a short write
happens. If this is confirmed and if you want to keep the patch short,
you could for example use errsv = EIO if write() returned a value
different from -1 and from amount_read.

Thanks,
Nicolas

> @@ -745,6 +745,10 @@ int semanage_copy_file(const char *src, const char *dst, mode_t mode)
>                 retval = -1;
>         }
>         close(in);
> +       if (fsync(out) < 0) {
> +               errsv = errno;
> +               retval = -1;
> +       }
>         if (close(out) < 0) {
>                 errsv = errno;
>                 retval = -1;
> --
> 2.23.3
>

