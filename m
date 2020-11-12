Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,URI_HEX autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A05F9C2D0A3
	for <selinux@archiver.kernel.org>; Thu, 12 Nov 2020 14:16:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 34A1720674
	for <selinux@archiver.kernel.org>; Thu, 12 Nov 2020 14:16:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RcC8A5rc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728265AbgKLOQ0 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 12 Nov 2020 09:16:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:28855 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727035AbgKLOQ0 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 12 Nov 2020 09:16:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605190585;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6cXjtImQketryR7Z+0xgGzcQ8TQYwiT1i+sGNcKZOcU=;
        b=RcC8A5rcvuE17RhyDkNARW/rqMNcaiNiZOazL+jw8tAEdlYbA79SGfEWLM8JU71O+TI2A1
        JZG88wzgJMsA5LS/kqAmmklohIh3XtIgyHHMkoygU8wAo0vQbYTKge+uNe4gCzY6y5Qmma
        pEsCGdJSEaUqhq25h1tGnbCJL3jMmec=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-260-hqw7gUORMf6zLNdwT6Agyw-1; Thu, 12 Nov 2020 09:16:22 -0500
X-MC-Unique: hqw7gUORMf6zLNdwT6Agyw-1
Received: by mail-lf1-f72.google.com with SMTP id t3so1830392lfk.21
        for <selinux@vger.kernel.org>; Thu, 12 Nov 2020 06:16:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6cXjtImQketryR7Z+0xgGzcQ8TQYwiT1i+sGNcKZOcU=;
        b=LsqwofOWOuMfewvEn4CtxRVwqnxQGe5IBGxIIYprgx1kRgVHC+sTKgPB7iw9jxz5ER
         O2Mwi6091g2gsusTjccbPTdXef2syCpgBBV12PQhRBeei0G3n77qjgMDwVJ65xjG2X1b
         rNYigYR8zpeCa3jdWtMsS1Jx/h4aYFMTH5NzO//XxW9C+OH4nZ2SMfXIWNkX0bYT13r9
         xUQX043KvygZqZwNTpo5plbddo3DIlBVfoTfMH9CRe+l3FeGm1NW6CrK+mEZUURandiM
         Z18lAaOiZuEL6Hax8T8YsHBhfdTEWm7V+CB9+1zUhe0if8SHND1FE5cewaZI4CZqH1OI
         I2GA==
X-Gm-Message-State: AOAM530g59HilxdE//bfWe9d+0E5t/73Ni+w0saSdrtjG2a+xIxEp7fR
        JjcDGJRpzDZdAMyhqwZXA4aUT47DsPfIducvqUqYyXPH8qLS3Gd/exyacEq1O3fMzhCmRj21Fjf
        gKjwPk/Fe4KBNLho8A2+e2do1myYzmnJVnw==
X-Received: by 2002:a19:f80f:: with SMTP id a15mr4906849lff.247.1605190580703;
        Thu, 12 Nov 2020 06:16:20 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyAfQ0kZbmXbMKRL0A4lm8P0l+w/BV6txPJGzMBdiF5on0Jg71Ipy3ge5qErK2DbRJP3QxguHyBBAKoN9kqBMM=
X-Received: by 2002:a19:f80f:: with SMTP id a15mr4906842lff.247.1605190580483;
 Thu, 12 Nov 2020 06:16:20 -0800 (PST)
MIME-Version: 1.0
References: <20201111212944.17659-1-nicolas.iooss@m4x.org>
In-Reply-To: <20201111212944.17659-1-nicolas.iooss@m4x.org>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Thu, 12 Nov 2020 15:16:09 +0100
Message-ID: <CAFqZXNtLSb4uX7N68+aoAY-AB8AOFAs230_t6Nm4SL5GyrJSOA@mail.gmail.com>
Subject: Re: [PATCH 1/1] libsepol: free memory when realloc() fails
To:     Nicolas Iooss <nicolas.iooss@m4x.org>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Nov 11, 2020 at 10:30 PM Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
> In get_class_info(), if realloc(class_buf, new_class_buf_len) fails to
> grow the memory, the function returns NULL without freeing class_buf.
> This leads to a memory leak which is reported by clang's static
> analyzer:
> https://580-118970575-gh.circle-artifacts.com/0/output-scan-build/2020-11-11-194150-6152-1/report-42a899.html#EndPath
>
> Fix the memory leak by calling free(class_buf).
>
> While at it, use size_t insted of int to store the size of the buffer
> which is growing.
>
> Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
> ---
>  libsepol/src/services.c | 19 +++++++++++--------
>  1 file changed, 11 insertions(+), 8 deletions(-)
>
> diff --git a/libsepol/src/services.c b/libsepol/src/services.c
> index beb0711f6680..72b39657cd2e 100644
> --- a/libsepol/src/services.c
> +++ b/libsepol/src/services.c
> @@ -312,17 +312,20 @@ static char *get_class_info(sepol_security_class_t tclass,
>         else
>                 state_num = mls + 2;
>
> -       int class_buf_len = 0;
> -       int new_class_buf_len;
> -       int len, buf_used;
> +       size_t class_buf_len = 0;
> +       size_t new_class_buf_len;
> +       size_t buf_used;
> +       int len;
>         char *class_buf = NULL, *p;
>         char *new_class_buf = NULL;
>
>         while (1) {
>                 new_class_buf_len = class_buf_len + EXPR_BUF_SIZE;
>                 new_class_buf = realloc(class_buf, new_class_buf_len);
> -                       if (!new_class_buf)
> -                               return NULL;
> +               if (!new_class_buf) {
> +                       free(class_buf);
> +                       return NULL;
> +               }
>                 class_buf_len = new_class_buf_len;
>                 class_buf = new_class_buf;
>                 buf_used = 0;
> @@ -330,7 +333,7 @@ static char *get_class_info(sepol_security_class_t tclass,
>
>                 /* Add statement type */
>                 len = snprintf(p, class_buf_len - buf_used, "%s", statements[state_num]);
> -               if (len < 0 || len >= class_buf_len - buf_used)
> +               if (len < 0 || (size_t)len >= class_buf_len - buf_used)
>                         continue;
>
>                 /* Add class entry */
> @@ -338,7 +341,7 @@ static char *get_class_info(sepol_security_class_t tclass,
>                 buf_used += len;
>                 len = snprintf(p, class_buf_len - buf_used, "%s ",
>                                 policydb->p_class_val_to_name[tclass - 1]);
> -               if (len < 0 || len >= class_buf_len - buf_used)
> +               if (len < 0 || (size_t)len >= class_buf_len - buf_used)
>                         continue;
>
>                 /* Add permission entries (validatetrans does not have perms) */
> @@ -351,7 +354,7 @@ static char *get_class_info(sepol_security_class_t tclass,
>                 } else {
>                         len = snprintf(p, class_buf_len - buf_used, "(");
>                 }
> -               if (len < 0 || len >= class_buf_len - buf_used)
> +               if (len < 0 || (size_t)len >= class_buf_len - buf_used)
>                         continue;
>                 break;
>         }
> --
> 2.29.2

Acked-by: Ondrej Mosnacek <omosnace@redhat.com>

Feel free to apply the patch yourself together with the manpage and CI
patches if you want to.

-- 
Ondrej Mosnacek
Software Engineer, Platform Security - SELinux kernel
Red Hat, Inc.

