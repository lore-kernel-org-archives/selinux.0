Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,URI_HEX autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01A9AC388F7
	for <selinux@archiver.kernel.org>; Thu, 12 Nov 2020 21:05:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D9E1216FD
	for <selinux@archiver.kernel.org>; Thu, 12 Nov 2020 21:05:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727149AbgKLVFK (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 12 Nov 2020 16:05:10 -0500
Received: from mx1.polytechnique.org ([129.104.30.34]:58027 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727139AbgKLVFK (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 12 Nov 2020 16:05:10 -0500
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 60F47564FBB
        for <selinux@vger.kernel.org>; Thu, 12 Nov 2020 22:05:06 +0100 (CET)
Received: by mail-ot1-f52.google.com with SMTP id g19so6937467otp.13
        for <selinux@vger.kernel.org>; Thu, 12 Nov 2020 13:05:06 -0800 (PST)
X-Gm-Message-State: AOAM532o8PIvsqn8p5MY6+4zVa24Qgf1NFWPvRgn1lqER69dJMwAAkne
        8wVAQttU0Ptu1CjsvSasReK5SNR3Mv5JwK6fsKI=
X-Google-Smtp-Source: ABdhPJyHFmpcNrJfBOqoAwyKY/UTpnT2AGBhwQuT5V0RydQ+W0Kxl3MUqSnlp/DNVaaQ6a4xdXRqHqRwEj/hRIpqQUY=
X-Received: by 2002:a9d:1727:: with SMTP id i39mr824075ota.96.1605215105149;
 Thu, 12 Nov 2020 13:05:05 -0800 (PST)
MIME-Version: 1.0
References: <20201111212944.17659-1-nicolas.iooss@m4x.org> <CAFqZXNtLSb4uX7N68+aoAY-AB8AOFAs230_t6Nm4SL5GyrJSOA@mail.gmail.com>
In-Reply-To: <CAFqZXNtLSb4uX7N68+aoAY-AB8AOFAs230_t6Nm4SL5GyrJSOA@mail.gmail.com>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Thu, 12 Nov 2020 22:04:53 +0100
X-Gmail-Original-Message-ID: <CAJfZ7=mYx6=OpYGHmSK6xT6Lrr+rtttkjq7R5gQo=z8EuZh9rw@mail.gmail.com>
Message-ID: <CAJfZ7=mYx6=OpYGHmSK6xT6Lrr+rtttkjq7R5gQo=z8EuZh9rw@mail.gmail.com>
Subject: Re: [PATCH 1/1] libsepol: free memory when realloc() fails
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Thu Nov 12 22:05:06 2020 +0100 (CET))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Nov 12, 2020 at 3:16 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> On Wed, Nov 11, 2020 at 10:30 PM Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
> > In get_class_info(), if realloc(class_buf, new_class_buf_len) fails to
> > grow the memory, the function returns NULL without freeing class_buf.
> > This leads to a memory leak which is reported by clang's static
> > analyzer:
> > https://580-118970575-gh.circle-artifacts.com/0/output-scan-build/2020-11-11-194150-6152-1/report-42a899.html#EndPath
> >
> > Fix the memory leak by calling free(class_buf).
> >
> > While at it, use size_t insted of int to store the size of the buffer
> > which is growing.
> >
> > Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
> > ---
> >  libsepol/src/services.c | 19 +++++++++++--------
> >  1 file changed, 11 insertions(+), 8 deletions(-)
> >
> > diff --git a/libsepol/src/services.c b/libsepol/src/services.c
> > index beb0711f6680..72b39657cd2e 100644
> > --- a/libsepol/src/services.c
> > +++ b/libsepol/src/services.c
> > @@ -312,17 +312,20 @@ static char *get_class_info(sepol_security_class_t tclass,
> >         else
> >                 state_num = mls + 2;
> >
> > -       int class_buf_len = 0;
> > -       int new_class_buf_len;
> > -       int len, buf_used;
> > +       size_t class_buf_len = 0;
> > +       size_t new_class_buf_len;
> > +       size_t buf_used;
> > +       int len;
> >         char *class_buf = NULL, *p;
> >         char *new_class_buf = NULL;
> >
> >         while (1) {
> >                 new_class_buf_len = class_buf_len + EXPR_BUF_SIZE;
> >                 new_class_buf = realloc(class_buf, new_class_buf_len);
> > -                       if (!new_class_buf)
> > -                               return NULL;
> > +               if (!new_class_buf) {
> > +                       free(class_buf);
> > +                       return NULL;
> > +               }
> >                 class_buf_len = new_class_buf_len;
> >                 class_buf = new_class_buf;
> >                 buf_used = 0;
> > @@ -330,7 +333,7 @@ static char *get_class_info(sepol_security_class_t tclass,
> >
> >                 /* Add statement type */
> >                 len = snprintf(p, class_buf_len - buf_used, "%s", statements[state_num]);
> > -               if (len < 0 || len >= class_buf_len - buf_used)
> > +               if (len < 0 || (size_t)len >= class_buf_len - buf_used)
> >                         continue;
> >
> >                 /* Add class entry */
> > @@ -338,7 +341,7 @@ static char *get_class_info(sepol_security_class_t tclass,
> >                 buf_used += len;
> >                 len = snprintf(p, class_buf_len - buf_used, "%s ",
> >                                 policydb->p_class_val_to_name[tclass - 1]);
> > -               if (len < 0 || len >= class_buf_len - buf_used)
> > +               if (len < 0 || (size_t)len >= class_buf_len - buf_used)
> >                         continue;
> >
> >                 /* Add permission entries (validatetrans does not have perms) */
> > @@ -351,7 +354,7 @@ static char *get_class_info(sepol_security_class_t tclass,
> >                 } else {
> >                         len = snprintf(p, class_buf_len - buf_used, "(");
> >                 }
> > -               if (len < 0 || len >= class_buf_len - buf_used)
> > +               if (len < 0 || (size_t)len >= class_buf_len - buf_used)
> >                         continue;
> >                 break;
> >         }
> > --
> > 2.29.2
>
> Acked-by: Ondrej Mosnacek <omosnace@redhat.com>
>
> Feel free to apply the patch yourself together with the manpage and CI
> patches if you want to.

Thanks, I did this and applied all the patches.

Nicolas

