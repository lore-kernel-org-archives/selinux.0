Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B14C2C433EF
	for <selinux@archiver.kernel.org>; Sat, 16 Oct 2021 19:35:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 805C360EE9
	for <selinux@archiver.kernel.org>; Sat, 16 Oct 2021 19:35:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241006AbhJPThO convert rfc822-to-8bit (ORCPT
        <rfc822;selinux@archiver.kernel.org>);
        Sat, 16 Oct 2021 15:37:14 -0400
Received: from mx1.polytechnique.org ([129.104.30.34]:36141 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240994AbhJPThN (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sat, 16 Oct 2021 15:37:13 -0400
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id A714256483E
        for <selinux@vger.kernel.org>; Sat, 16 Oct 2021 21:35:03 +0200 (CEST)
Received: by mail-pj1-f41.google.com with SMTP id oa12-20020a17090b1bcc00b0019f715462a8so9751363pjb.3
        for <selinux@vger.kernel.org>; Sat, 16 Oct 2021 12:35:03 -0700 (PDT)
X-Gm-Message-State: AOAM5338u05GA/Z7ZIiSz0A9KKkRA1Muhhf7y1Wc3RZZer9lJ226PwZt
        5W50tOArzOjwshMtjOtcLZkttJ84dkvYDTcCCzQ=
X-Google-Smtp-Source: ABdhPJwyvI8wUGKCOfBMWunygj2VsE15wCka1txi9FJmcA2YzftYd7T5mrzlVnMix08yaNSsclj+Qg0E5d1ExAxrKZ4=
X-Received: by 2002:a17:902:c206:b0:13f:68f:675c with SMTP id
 6-20020a170902c20600b0013f068f675cmr18288480pll.8.1634412902369; Sat, 16 Oct
 2021 12:35:02 -0700 (PDT)
MIME-Version: 1.0
References: <20211013125358.15534-1-cgzones@googlemail.com> <20211013125358.15534-2-cgzones@googlemail.com>
In-Reply-To: <20211013125358.15534-2-cgzones@googlemail.com>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Sat, 16 Oct 2021 21:34:51 +0200
X-Gmail-Original-Message-ID: <CAJfZ7==wB7JawXkm+q=VjUTCNDiALzYy0e-ToVZ107ECpycUnQ@mail.gmail.com>
Message-ID: <CAJfZ7==wB7JawXkm+q=VjUTCNDiALzYy0e-ToVZ107ECpycUnQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] libsemanage: do not sort empty records
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Sat Oct 16 21:35:04 2021 +0200 (CEST))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Oct 13, 2021 at 2:54 PM Christian Göttsche
<cgzones@googlemail.com> wrote:
>
> Do not sort empty records to avoid calling qsort(3) with a NULL pointer.
> qsort(3) might be annotated with the function attribute nonnull and
> UBSan then complains:
>
>     database_join.c:80:2: runtime error: null pointer passed as argument 1, which is declared to never be null
>
> Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
> ---
>  libsemanage/src/database_join.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/libsemanage/src/database_join.c b/libsemanage/src/database_join.c
> index b9b35a61..b0e66e53 100644
> --- a/libsemanage/src/database_join.c
> +++ b/libsemanage/src/database_join.c
> @@ -77,10 +77,12 @@ static int dbase_join_cache(semanage_handle_t * handle, dbase_join_t * dbase)
>                 goto err;
>
>         /* Sort for quicker merge later */
> -       qsort(records1, rcount1, sizeof(record1_t *),
> -             (int (*)(const void *, const void *))rtable1->compare2_qsort);
> -       qsort(records2, rcount2, sizeof(record2_t *),
> -             (int (*)(const void *, const void *))rtable2->compare2_qsort);
> +       if (rcount1 > 0)
> +               qsort(records1, rcount1, sizeof(record1_t *),
> +                     (int (*)(const void *, const void *))rtable1->compare2_qsort);
> +       if (rcount2 > 0)
> +               qsort(records2, rcount2, sizeof(record2_t *),
> +                     (int (*)(const void *, const void *))rtable2->compare2_qsort);
>
>         /* Now merge into this dbase */
>         while (i < rcount1 || j < rcount2) {
> --
> 2.33.0
>

Hello,
This patch looks good, and the code would be more readable with braces
around the qsort calls (so it is clear with a fast glance over the
code that there is no issue of not using braces here). Could you add
braces like this?

if (rcount1 > 0) {
    qsort(records1, rcount1, sizeof(record1_t *),
        (int (*)(const void *, const void *))rtable1->compare2_qsort);
}

Thanks,
Nicolas

