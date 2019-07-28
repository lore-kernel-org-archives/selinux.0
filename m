Return-Path: <SRS0=3sNC=VZ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URI_HEX autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C560FC7618F
	for <selinux@archiver.kernel.org>; Sun, 28 Jul 2019 20:29:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A41A420657
	for <selinux@archiver.kernel.org>; Sun, 28 Jul 2019 20:29:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726177AbfG1U3w (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 28 Jul 2019 16:29:52 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:38462 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726129AbfG1U3w (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 28 Jul 2019 16:29:52 -0400
Received: by mail-oi1-f194.google.com with SMTP id v186so43857896oie.5
        for <selinux@vger.kernel.org>; Sun, 28 Jul 2019 13:29:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Baoc0gnNdfKyvzssBMu2RaR9T8hK1H/5EHPojU8Ayf8=;
        b=Kxtz/EjVwQ6DOAA9MR08MQiK0eRpRjgBwtVSru+johbZqdNVpJsFSBks1g1TPFUuHe
         LA+lZgRQhXf6cwjdpVL86uBcpHdJAwprcDu5+6sZ0pthOlb2qzGnuhGoAk2dp2YfLlrv
         B/PGGlwDiA5Hx7zXARSTOSpZ2ZLmwFkh1uRH3G1LxJxJKAw0M5NobTSlwO2FcXye3U+R
         N5OoQIxK/POv2DgLCr5tj3NEBARCknl8GSVv9e1H74EfPRtBwo9Encx411nntegA9Iuy
         iSb2BnK5ssxHmOwPyIpbm07oLXwtupdJQct3q6l+9qyCkNgTUxfEnaf8RY/c+q37MNTC
         fGCA==
X-Gm-Message-State: APjAAAUkPORTY57SMyfMPOgKln8XtpEXH7jDeyh9jfuGIAGsjbwUHam9
        5rL2rRWWC2sXQu34ut85xVCBMkWkPH8p5Hn8RI1Ovg==
X-Google-Smtp-Source: APXvYqzTDGbZ7iuFIdbiN+Py4uC+mFByt3EzVcRUdYL3W7eKB+q2P3eLe/ZKXU/OdFAc+X0JrdkYbHUyK5zBozcDD+8=
X-Received: by 2002:aca:75c2:: with SMTP id q185mr55128118oic.103.1564345790837;
 Sun, 28 Jul 2019 13:29:50 -0700 (PDT)
MIME-Version: 1.0
References: <20190728183749.30044-1-nicolas.iooss@m4x.org>
In-Reply-To: <20190728183749.30044-1-nicolas.iooss@m4x.org>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Sun, 28 Jul 2019 22:29:39 +0200
Message-ID: <CAFqZXNsbL8tQ+XEHuo7huBs7_3utzKWbG5DYb+jXPo9hmWHEWA@mail.gmail.com>
Subject: Re: [PATCH 1/1] libsepol: initialize a local variable once
To:     Nicolas Iooss <nicolas.iooss@m4x.org>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Sun, Jul 28, 2019 at 8:38 PM Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
> Function optimize_cond_av_list() initializes its local variable pcov_cur
> twice. Remove the first initialization.
>
> This issue has been found using clang's static analyzer:
> https://282-118970575-gh.circle-artifacts.com/0/output-scan-build/2019-06-24-210510-6101-1/report-c64da3.html#EndPath
>
> Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>

Acked-by: Ondrej Mosnacek <omosnace@redhat.com>

> ---
>  libsepol/src/optimize.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/libsepol/src/optimize.c b/libsepol/src/optimize.c
> index 3780b68b24fe..10399a43e1cf 100644
> --- a/libsepol/src/optimize.c
> +++ b/libsepol/src/optimize.c
> @@ -247,7 +247,7 @@ static void optimize_cond_av_list(cond_av_list_t **cond, cond_av_list_t **del,
>  {
>         cond_av_list_t **listp = cond;
>         cond_av_list_t *pcov = NULL;
> -       cond_av_list_t **pcov_cur = &pcov;
> +       cond_av_list_t **pcov_cur;
>
>         /*
>          * Separate out all "potentially covering" rules (src or tgt is an attr)
> --
> 2.22.0
>

-- 
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.
