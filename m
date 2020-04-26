Return-Path: <SRS0=JMXr=6K=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01B51C54FCB
	for <selinux@archiver.kernel.org>; Sun, 26 Apr 2020 18:14:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E443B2070A
	for <selinux@archiver.kernel.org>; Sun, 26 Apr 2020 18:14:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726156AbgDZSOS convert rfc822-to-8bit (ORCPT
        <rfc822;selinux@archiver.kernel.org>);
        Sun, 26 Apr 2020 14:14:18 -0400
Received: from mx1.polytechnique.org ([129.104.30.34]:60562 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726151AbgDZSOS (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 26 Apr 2020 14:14:18 -0400
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 5FCAD561250
        for <selinux@vger.kernel.org>; Sun, 26 Apr 2020 20:14:15 +0200 (CEST)
Received: by mail-ot1-f51.google.com with SMTP id m18so22199552otq.9
        for <selinux@vger.kernel.org>; Sun, 26 Apr 2020 11:14:15 -0700 (PDT)
X-Gm-Message-State: AGi0PuZZuVHdT4+FVhJDMBkmqFJts/CBpbLtzH4hjUec4e2q8umj+3mY
        RI6nKn5dOCAMVs5j+4ItiS4BoD5ozH0gpFBKkcg=
X-Google-Smtp-Source: APiQypK2yUNv4iFK3DnCcXjId2kiVSfApkZmpW8nstqJuw+CmoHbk9D0lqaormDfr8PsyEkdWi5pKdiDduWke9WfMQg=
X-Received: by 2002:a9d:bca:: with SMTP id 68mr14580559oth.96.1587924854480;
 Sun, 26 Apr 2020 11:14:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200420114650.19093-1-cgzones@googlemail.com>
In-Reply-To: <20200420114650.19093-1-cgzones@googlemail.com>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Sun, 26 Apr 2020 20:14:03 +0200
X-Gmail-Original-Message-ID: <CAJfZ7=ky1rwB3jDMEdXjqSL=Vctut_2Cc6gsj475Et_nLo7B4A@mail.gmail.com>
Message-ID: <CAJfZ7=ky1rwB3jDMEdXjqSL=Vctut_2Cc6gsj475Et_nLo7B4A@mail.gmail.com>
Subject: Re: [PATCH] libselinux: mark security_context_t typedef as deprecated
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Sun Apr 26 20:14:15 2020 +0200 (CEST))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Apr 20, 2020 at 1:47 PM Christian Göttsche
<cgzones@googlemail.com> wrote:
>
> Follow-up of: 9eb9c9327563014ad6a807814e7975424642d5b9 ("Get rid of security_context_t and fix const declarations.")
>
> Use a wrapper macro, because swig does not accept typedef attributes.
>
> Signed-off-by: Christian Göttsche <cgzones@googlemail.com>

Acked-by: Nicolas Iooss <nicolas.iooss@m4x.org>

If nobody raises an objection, I will merge the patch tomorrow.

Thanks,
Nicolas

> ---
>  libselinux/include/selinux/selinux.h | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/libselinux/include/selinux/selinux.h b/libselinux/include/selinux/selinux.h
> index 6a512b38..f88a0363 100644
> --- a/libselinux/include/selinux/selinux.h
> +++ b/libselinux/include/selinux/selinux.h
> @@ -8,13 +8,21 @@
>  extern "C" {
>  #endif
>
> +#ifndef _selinux_deprecated
> +#ifdef __GNUC__
> +#define _selinux_deprecated __attribute__ ((deprecated))
> +#else
> +#define _selinux_deprecated
> +#endif
> +#endif
> +
>  /* Return 1 if we are running on a SELinux kernel, or 0 otherwise. */
>  extern int is_selinux_enabled(void);
>  /* Return 1 if we are running on a SELinux MLS kernel, or 0 otherwise. */
>  extern int is_selinux_mls_enabled(void);
>
>  /* No longer used; here for compatibility with legacy callers. */
> -typedef char *security_context_t;
> +typedef char *security_context_t _selinux_deprecated;
>
>  /* Free the memory allocated for a context by any of the below get* calls. */
>  extern void freecon(char * con);
> --
> 2.26.1
>

