Return-Path: <SRS0=JPc9=QH=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2F32C169C4
	for <selinux@archiver.kernel.org>; Thu, 31 Jan 2019 21:57:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B71702087F
	for <selinux@archiver.kernel.org>; Thu, 31 Jan 2019 21:57:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726463AbfAaV5o (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 31 Jan 2019 16:57:44 -0500
Received: from mx1.polytechnique.org ([129.104.30.34]:54531 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727017AbfAaV5o (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 31 Jan 2019 16:57:44 -0500
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 73E92561277
        for <selinux@vger.kernel.org>; Thu, 31 Jan 2019 22:57:41 +0100 (CET)
Received: by mail-oi1-f176.google.com with SMTP id v6so4146709oif.2
        for <selinux@vger.kernel.org>; Thu, 31 Jan 2019 13:57:41 -0800 (PST)
X-Gm-Message-State: AJcUukd8wr4nwYp9TEfwvWn9KdzRx9Hsog2x3sGGe8M5NvFNFsekhAmx
        /SlwsIbwhL/x4ls/MJF8kfR1MQhweAJ1dC0FtsI=
X-Google-Smtp-Source: ALg8bN6tX9gyVuUEFQgsaK2q7qG4UJnrJfn3PnQYDPGnA+Ii4lV9d58VFgu0Se4hD54CtJed7Fu1XSXh5tPh2PTygYY=
X-Received: by 2002:aca:44f:: with SMTP id 76mr15726579oie.212.1548971860474;
 Thu, 31 Jan 2019 13:57:40 -0800 (PST)
MIME-Version: 1.0
References: <20190131132226.19030-1-plautrba@redhat.com> <20190131132226.19030-3-plautrba@redhat.com>
In-Reply-To: <20190131132226.19030-3-plautrba@redhat.com>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Thu, 31 Jan 2019 22:57:29 +0100
X-Gmail-Original-Message-ID: <CAJfZ7=kMpqdfbQ4NfHT_5FbY-63N0O2L1xUMBi2MHMnRB=0Y+Q@mail.gmail.com>
Message-ID: <CAJfZ7=kMpqdfbQ4NfHT_5FbY-63N0O2L1xUMBi2MHMnRB=0Y+Q@mail.gmail.com>
Subject: Re: [PATCH 3/3] libsemanage: Fix USE_AFTER_FREE defects reported by
 coverity scan
To:     Petr Lautrbach <plautrba@redhat.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Thu Jan 31 22:57:41 2019 +0100 (CET))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Jan 31, 2019 at 2:22 PM Petr Lautrbach <plautrba@redhat.com> wrote:
>
> Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
> ---
>  libsemanage/src/direct_api.c | 21 ++++++++-------------
>  1 file changed, 8 insertions(+), 13 deletions(-)
>
> diff --git a/libsemanage/src/direct_api.c b/libsemanage/src/direct_api.c
> index c58961be..8e4d116d 100644
> --- a/libsemanage/src/direct_api.c
> +++ b/libsemanage/src/direct_api.c
> @@ -1028,7 +1028,7 @@ static int semanage_direct_write_langext(semanage_handle_t *sh,
>
>         fp = NULL;
>
> -       ret = 0;
> +       return 0;
>
>  cleanup:
>         if (fp != NULL) fclose(fp);
> @@ -2177,7 +2177,6 @@ cleanup:
>         semanage_module_info_destroy(sh, modinfo);
>         free(modinfo);
>
> -       if (fp != NULL) fclose(fp);
>         return status;
>  }
>
> @@ -2342,16 +2341,6 @@ static int semanage_direct_get_module_info(semanage_handle_t *sh,
>         free(tmp);
>         tmp = NULL;
>
> -       if (fclose(fp) != 0) {
> -               ERR(sh,
> -                   "Unable to close %s module lang ext file.",
> -                   (*modinfo)->name);
> -               status = -1;
> -               goto cleanup;
> -       }
> -
> -       fp = NULL;
> -
>         /* lookup enabled/disabled status */
>         ret = semanage_module_get_path(sh,
>                                        *modinfo,
> @@ -2395,7 +2384,13 @@ cleanup:
>                 free(modinfos);
>         }
>
> -       if (fp != NULL) fclose(fp);
> +       if (fp != NULL && fclose(fp) != 0) {
> +               ERR(sh,
> +                   "Unable to close %s module lang ext file.",
> +                   (*modinfo)->name);
> +               status = -1;
> +       }
> +
>         return status;
>  }
>
> --
> 2.20.1

After reading this patch, I am wondering what the USE_AFTER_FREE
defects were about. Were there real use-after-fclose bugs that are
fixed by this patch? Or is this patch more about silencing Coverity's
false positives due to difficulties in parsing constructions such as
"fclose(fp);fp = NULL; if(f != NULL)fclose(fp);"? It would be useful
if the patch description contains answers to these questions.

Otherwise the content of the patch looks good to me.

Nicolas

