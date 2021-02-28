Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7561AC433E0
	for <selinux@archiver.kernel.org>; Sun, 28 Feb 2021 18:38:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D7AF64DBD
	for <selinux@archiver.kernel.org>; Sun, 28 Feb 2021 18:38:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230491AbhB1Sif (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 28 Feb 2021 13:38:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbhB1Sie (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 28 Feb 2021 13:38:34 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B7E4C06174A
        for <selinux@vger.kernel.org>; Sun, 28 Feb 2021 10:37:53 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id h10so17707500edl.6
        for <selinux@vger.kernel.org>; Sun, 28 Feb 2021 10:37:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ppGDpTFzSXWWlGE51pox82buiuX04gD9pOg1/3MREt0=;
        b=fzIMkkwc6VXyZF+e5HqKudARIH8IhkbVBJP3UmfsNZH67f1544pHFaGHfwP/FO36aI
         eTSEfVcBj+15O4ZH9c65NPAXPNS3HPUC/Lm6ORbep6aFgY9jZXo9hKM0YDEubl3+QEEZ
         CTINTi3RBSFnHKFgHzTHtKafez9J1PpeLBJgvLAMNYRdB+n/LXfvrTkSGFjkKSvOOACN
         lQ+pJPOjN0mQW6ezEaU7zEYzzEYj97uZ8TZJy1kw/65Ggsci3ud9bVJe2aGxqI+x28ZU
         XhGu8leiG3yJ2v35aoyo/GnuI1DqaQTUDEY1OwvcWuHmN18TQj7bw84yqAETo1MoFfPz
         ZqbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ppGDpTFzSXWWlGE51pox82buiuX04gD9pOg1/3MREt0=;
        b=omcQVzeCqKW9mmgIa0npUDVpBeTCXFZpXDLZFTASvIVv1XPh/b3Xcf1JxHk65/PtW+
         bLLxhcBN28EVgJq72nNJtwEOa3SPcLcwam8GbldIwqxg6dTRlzN1AbPJUeLXyaR37bU7
         X25ytLGhWnzOu1pnZ4GajcW1qfqO5qSz8SE2PNzh8MXB69xkpp0/HUP+zZ8BbNFOxOCv
         xcJizr/oPPVohR+UJ77/AAjN+eIKdPrAX/kCElOKbyFqkNE1ZXo4XSA/h7dYJL2uGwi5
         lPKHkAYo89hQQshDL0vHtxBETHB8gAqAkO7wVdLbhXwi2tAldZs9/lxvHV7jZuoLlKMT
         r6Mw==
X-Gm-Message-State: AOAM532VTLhQ7+cFjmMMlG2IkZzvfX8EPQWOO9sRIkzgHa56/A7i+MxQ
        wpu0qTd9iUMuSSlYV1fESrgGiaRtLm48xpx/DMlY
X-Google-Smtp-Source: ABdhPJy8sTRUUiKp4ovwElzch6ia8u+MqZN0LydyVqnFlDPVOkQGZgCct6BclpSvPM0shzYvLlp2pVEOiDGHubcT/R0=
X-Received: by 2002:a05:6402:c96:: with SMTP id cm22mr13096764edb.128.1614537472148;
 Sun, 28 Feb 2021 10:37:52 -0800 (PST)
MIME-Version: 1.0
References: <YDvLYzsGu+l1pQ2y@localhost.localdomain> <YDvNF+QVOv3vqDbm@localhost.localdomain>
In-Reply-To: <YDvNF+QVOv3vqDbm@localhost.localdomain>
From:   Paul Moore <paul@paul-moore.com>
Date:   Sun, 28 Feb 2021 13:37:41 -0500
Message-ID: <CAHC9VhTr0=WGvacsCGgpwiPwU_ziQeThV88ZqZRdVXqO+HafYQ@mail.gmail.com>
Subject: Re: [PATCH 09/11] pragma once: convert scripts/selinux/genheaders/genheaders.c
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Sun, Feb 28, 2021 at 12:04 PM Alexey Dobriyan <adobriyan@gmail.com> wrote:
>
> From 097f2c8b2af7d9e88cff59376ea0ad51b95341cb Mon Sep 17 00:00:00 2001
> From: Alexey Dobriyan <adobriyan@gmail.com>
> Date: Tue, 9 Feb 2021 00:39:23 +0300
> Subject: [PATCH 09/11] pragma once: convert scripts/selinux/genheaders/genheaders.c
>
> Generate security/selinux/flask.h and security/selinux/av_permissions.h
> without include guards.
>
> Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
> ---
>  scripts/selinux/genheaders/genheaders.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)

My LKML subscription must have died at some point due to mail bounces,
or maybe I dopped it (?), because I'm not seeing the rest of this
patchset for context.

However, unless the rest of the kernel transitions to this, or there
is some other big win that I'm missing, I don't see much of a reason
for this; can you provide some compelling reason for why we should
make this change?  A quick search on "#pragma once" seems to indicate
it is non-standard, so why replace the simple #ifdef/#define solution
for this?

> diff --git a/scripts/selinux/genheaders/genheaders.c b/scripts/selinux/genheaders/genheaders.c
> index f355b3e0e968..e13ee4221993 100644
> --- a/scripts/selinux/genheaders/genheaders.c
> +++ b/scripts/selinux/genheaders/genheaders.c
> @@ -74,8 +74,8 @@ int main(int argc, char *argv[])
>                         initial_sid_to_string[i] = stoupperx(s);
>         }
>
> +       fprintf(fout, "#pragma once\n");
>         fprintf(fout, "/* This file is automatically generated.  Do not edit. */\n");
> -       fprintf(fout, "#ifndef _SELINUX_FLASK_H_\n#define _SELINUX_FLASK_H_\n\n");
>
>         for (i = 0; secclass_map[i].name; i++) {
>                 struct security_class_mapping *map = &secclass_map[i];
> @@ -109,7 +109,6 @@ int main(int argc, char *argv[])
>         fprintf(fout, "\treturn sock;\n");
>         fprintf(fout, "}\n");
>
> -       fprintf(fout, "\n#endif\n");
>         fclose(fout);
>
>         fout = fopen(argv[2], "w");
> @@ -119,8 +118,8 @@ int main(int argc, char *argv[])
>                 exit(4);
>         }
>
> +       fprintf(fout, "#pragma once\n");
>         fprintf(fout, "/* This file is automatically generated.  Do not edit. */\n");
> -       fprintf(fout, "#ifndef _SELINUX_AV_PERMISSIONS_H_\n#define _SELINUX_AV_PERMISSIONS_H_\n\n");
>
>         for (i = 0; secclass_map[i].name; i++) {
>                 struct security_class_mapping *map = &secclass_map[i];
> @@ -136,7 +135,6 @@ int main(int argc, char *argv[])
>                 }
>         }
>
> -       fprintf(fout, "\n#endif\n");
>         fclose(fout);
>         exit(0);
>  }
> --
> 2.29.2

-- 
paul moore
www.paul-moore.com
