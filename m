Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63642ECAAD4
	for <selinux@archiver.kernel.org>; Wed, 31 Aug 2022 11:55:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230003AbiHaLz1 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 31 Aug 2022 07:55:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbiHaLzX (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 31 Aug 2022 07:55:23 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FED05A88F
        for <selinux@vger.kernel.org>; Wed, 31 Aug 2022 04:55:21 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id l16so7460590ilj.2
        for <selinux@vger.kernel.org>; Wed, 31 Aug 2022 04:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=L36NN89jy9+DXvRAoQ/pe77BoNP+DnoQ16EU2UeWiQc=;
        b=BMc50TepDB9u4B4Mjll51k77zgz7XwDI3UmKjWmJm6JnhDk8UQK2XTg3DBcJvL3r2o
         bKwZEaXMrjpvDr5llg6ij8+HnZrFoXvxm0Yxunu6FuD+y3oa4v5svAcIVrBVYymnjV0p
         dIvPqKujylN/HJXx/Ay3dvABy5+GMFUVvsB1RZOTHV0zSDs31oKLBCwSvW1MqJf4amC/
         FSlqbUuaxv28Jfeb/0GQ8oF3vKwBWi8tBKigWpByorCDvRYI5A/XeCgqiLphrq6yrDFR
         VE/NbpLxEz5BTZone5H3CTOcgWl2i5/PT8V0jzQZC4Ippf0jN5Nnwrc/tkXoJbNKkk8H
         K1XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=L36NN89jy9+DXvRAoQ/pe77BoNP+DnoQ16EU2UeWiQc=;
        b=vDn1bvltY7kVu/M9m7ow2EubmWvUhjlAJMrhd1BeGfktX0eBlFFNkXlNPBPjXjXXAh
         jyuDpjpg16lu3+i1O6sT+1L3tp0cmj0EhxMrXb6rkE3uJLtD43WQT+bXwd7Z1IPeb8KD
         PMkG5mDrr4Ea9/pcZNW1kyDx22XPbXySdFFsYeP93rtgAYRVk06GlRXsnwLzRAyXKU/+
         AawfEN5fO+MHgatkafIm1jKIy9TQ0P16wwJ9uF/EDFrolZ5upU44R1fiqYSMd3lQsplh
         yurODOiCpveibx7JoYxScMEXSFRD4wtlo2pkFVaqUSUteJRjBIhiAlyEdSOT4/Z5oy04
         cPww==
X-Gm-Message-State: ACgBeo0ktWtCkxd/2vmEE2y43G2bVc++Gy815BngSbyw/lJ9jnwHnLIG
        n5sVZ95ZViKzmaMWtdxPulpZSkuuuX6YuPgdGP8=
X-Google-Smtp-Source: AA6agR6ifCdAzDbgQw0Tuz6GfvjmkWQzqv+NkxI5yrj2kMZrtATP+fMe0XGxeRae/ZXYoFok0XuMiV5Gizbiws5Lgo8=
X-Received: by 2002:a92:130f:0:b0:2e4:22c9:7721 with SMTP id
 15-20020a92130f000000b002e422c97721mr14958619ilt.34.1661946920524; Wed, 31
 Aug 2022 04:55:20 -0700 (PDT)
MIME-Version: 1.0
References: <89653753-717f-3ef9-9538-c90ad2aa62b1@gmail.com>
In-Reply-To: <89653753-717f-3ef9-9538-c90ad2aa62b1@gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Wed, 31 Aug 2022 07:55:09 -0400
Message-ID: <CAP+JOzT-kWKqTOGrYso7eWYh_4KBoUn61r_cPUGR8OvefxTVHw@mail.gmail.com>
Subject: Re: [PATCH 3/3] secilc/docs: disable pandoc default css for html docs
To:     bauen1 <j2468h@googlemail.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Sun, Aug 28, 2022 at 8:16 AM bauen1 <j2468h@googlemail.com> wrote:
>
> Some time ago pandoc started shipping a default css file for html, while
> that is nice, it limits the max-width of the body element to 36em. We
> have a lot of tables, code examples, etc... in the manual that are too
> big for that, requiring constant scrolling.
>
> See https://github.com/jgm/pandoc/blob/master/data/templates/styles.html
> for the default used.
>
> While some styling, perhaps even dark/light mode support in the CSS
> would be nice, I didn't manage to find a simple way to achieve this, so
> for now just disable the CSS.
>
> Expand the arguments for pandoc in the Makefile for better readability.
>
> Signed-off-by: Jonathan Hettwer (bauen1) <j2468h@gmail.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>   secilc/docs/Makefile | 18 ++++++++++++++++--
>   1 file changed, 16 insertions(+), 2 deletions(-)
>
> diff --git a/secilc/docs/Makefile b/secilc/docs/Makefile
> index a03ebeed..7e2ba40e 100644
> --- a/secilc/docs/Makefile
> +++ b/secilc/docs/Makefile
> @@ -58,11 +58,25 @@ $(TMPDIR)/policy.cil: $(TESTDIR)/policy.cil
>
>   html: $(PANDOC_FILE_LIST) $(TMPDIR)/policy.cil secil.xml
>         mkdir -p $(HTMLDIR)
> -       $(PANDOC) --highlight-style=$(PANDOC_HIGHLIGHT_STYLE) --syntax-definition=secil.xml --standalone --metadata title="CIL Reference Guide" -t html $(PANDOC_FILE_LIST) $(TMPDIR)/policy.cil  -o $(HTMLDIR)/$(HTML_OUT)
> +       $(PANDOC) \
> +               --highlight-style=$(PANDOC_HIGHLIGHT_STYLE) \
> +               --syntax-definition=secil.xml \
> +               --standalone \
> +               --metadata title="CIL Reference Guide" \
> +               --metadata document-css=false \
> +               -t html \
> +               $(PANDOC_FILE_LIST) $(TMPDIR)/policy.cil \
> +               -o $(HTMLDIR)/$(HTML_OUT)
>
>   pdf: $(PANDOC_FILE_LIST) $(TMPDIR)/policy.cil secil.xml
>         mkdir -p $(PDFDIR)
> -       $(PANDOC) --highlight-style=$(PANDOC_HIGHLIGHT_STYLE) --syntax-definition=secil.xml --standalone --toc $(PANDOC_FILE_LIST) $(TMPDIR)/policy.cil -o $(PDFDIR)/$(PDF_OUT)
> +       $(PANDOC) \
> +               --highlight-style=$(PANDOC_HIGHLIGHT_STYLE) \
> +               --syntax-definition=secil.xml \
> +               --standalone \
> +               --toc \
> +               $(PANDOC_FILE_LIST) $(TMPDIR)/policy.cil \
> +               -o $(PDFDIR)/$(PDF_OUT)
>
>   clean:
>         rm -rf $(HTMLDIR)
> --
> 2.36.1
>
