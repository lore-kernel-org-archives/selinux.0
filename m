Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DA63C4332F
	for <selinux@archiver.kernel.org>; Mon,  7 Nov 2022 19:34:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232396AbiKGTef (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 7 Nov 2022 14:34:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230186AbiKGTee (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 7 Nov 2022 14:34:34 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1F9AE71
        for <selinux@vger.kernel.org>; Mon,  7 Nov 2022 11:34:33 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id p8so18129931lfu.11
        for <selinux@vger.kernel.org>; Mon, 07 Nov 2022 11:34:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HfjDFhF7cQUgNH6nBuYcfgGQH3GIcr1OF2ehUwi2F+Y=;
        b=avs3of6OkdaSGFytr6eEtgkD63Wg7Gz1abV1uFcKP9P7BZLfdTdlKi9Rn9Se0Jjc8j
         u67Ph9MOVvqyRUfNPdIhBPv8YVMCv104k3VbEWi+RsQyMlwNsWnSNiNjuxdrQxm6gR8O
         AAIsw6hia38QzS1/SDj/9cVIc94BWZRgH1cWo8p7EE2pd2dWgH6PLestsJUVkRqRSPvb
         X3kp5fLYIRr5ImcqmHZaWVDEbuondkF/9Im2eopdDhkbiWSPVrzmotbdlxEKbIr7j/aK
         zx3tyTFat7L1nlcBW+fwQTXQxKx/na5zWPvl1ljGzMMqOSmwVEz5+0BArsXeJBUy6yRT
         6E+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HfjDFhF7cQUgNH6nBuYcfgGQH3GIcr1OF2ehUwi2F+Y=;
        b=FXT5dIjKA19qFSKwN2yGfY5YUndtepombH4rynmGCuMMnuI0B2g5vLkwsbuZ+Z+Y36
         a+A67dGTGSSUhwnDYdTP8FeWEN0lLikjfHQo9WUsb8cW9MHvIvCG5vJXGH4rUghuUAJ1
         GWIm4NLinj8ZWD0mqitYtpuhQMRiNfXgvg9ZH/HAIk++9sLcqW/ZUfHocIsrvqxxUyoX
         WYQHU42RVURe8y5HHSNrh7if2ruIwelnwKZVvHzWuCIPf6Ae5Ti0HPpffAICyxDbKxxB
         vMB+cLEgPuE2Qhr1AlENV2Tyu9FEZK7TxLJjSkpocHizsXQyqflFem2EzwE0+zuYCQK/
         736w==
X-Gm-Message-State: ACrzQf289fH80xxB9QBNxydpLnGRDrKD0ExPeAfOSDKUt0qO71u8Bc6x
        siGshiyP1PfdvIj3VJMYMXXVJfD7AKzrMMbl+57ViuV/MoM=
X-Google-Smtp-Source: AMsMyM59tTLKZ+xZm8unniQSAdEElV9UbI22nPFYUwlhtoM0pBuGO516r4HxaMD3N8vb27QwLcpWe/aXv8UExXtClDU=
X-Received: by 2002:ac2:5bcd:0:b0:4b0:d503:9afb with SMTP id
 u13-20020ac25bcd000000b004b0d5039afbmr13594329lfn.13.1667849671999; Mon, 07
 Nov 2022 11:34:31 -0800 (PST)
MIME-Version: 1.0
References: <20221031164617.3096227-1-vmojzis@redhat.com>
In-Reply-To: <20221031164617.3096227-1-vmojzis@redhat.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Mon, 7 Nov 2022 14:34:20 -0500
Message-ID: <CAP+JOzQgPGLxD32ezck6anpdWCjTOeK6MX=3RadQS7iitV_F6g@mail.gmail.com>
Subject: Re: [PATCH] libselinux: Ignore missing directories when -i is used
To:     Vit Mojzis <vmojzis@redhat.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Oct 31, 2022 at 12:51 PM Vit Mojzis <vmojzis@redhat.com> wrote:
>
> Currently "-i" only ignores a file whose parent directory exists. Start also
> ignoring paths with missing components.
>
> Fixes:
>   # restorecon -i -v -R /var/log/missingdir/missingfile; echo $?
>   255
>   restorecon: SELinux: Could not get canonical path for /var/log/missingdir/missingfile restorecon: No such file or directory.
>
> Signed-off-by: Vit Mojzis <vmojzis@redhat.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libselinux/src/selinux_restorecon.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/libselinux/src/selinux_restorecon.c b/libselinux/src/selinux_restorecon.c
> index 2d24559f..6b5f6921 100644
> --- a/libselinux/src/selinux_restorecon.c
> +++ b/libselinux/src/selinux_restorecon.c
> @@ -1108,6 +1108,10 @@ static int selinux_restorecon_common(const char *pathname_orig,
>                         pathname = realpath(pathname_orig, NULL);
>                         if (!pathname) {
>                                 free(basename_cpy);
> +                               /* missing parent directory */
> +                               if (state.flags.ignore_noent && errno == ENOENT) {
> +                                       return 0;
> +                               }
>                                 goto realpatherr;
>                         }
>                 } else {
> @@ -1121,6 +1125,9 @@ static int selinux_restorecon_common(const char *pathname_orig,
>                         free(dirname_cpy);
>                         if (!pathdnamer) {
>                                 free(basename_cpy);
> +                               if (state.flags.ignore_noent && errno == ENOENT) {
> +                                       return 0;
> +                               }
>                                 goto realpatherr;
>                         }
>                         if (!strcmp(pathdnamer, "/"))
> --
> 2.37.3
>
