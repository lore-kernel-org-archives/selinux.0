Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA6A3C4338F
	for <selinux@archiver.kernel.org>; Thu,  5 Aug 2021 14:01:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CCA1560E97
	for <selinux@archiver.kernel.org>; Thu,  5 Aug 2021 14:01:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240537AbhHEOBw (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 5 Aug 2021 10:01:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238069AbhHEOBv (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 5 Aug 2021 10:01:51 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F891C061765
        for <selinux@vger.kernel.org>; Thu,  5 Aug 2021 07:01:36 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id r16-20020a0568304190b02904f26cead745so4838600otu.10
        for <selinux@vger.kernel.org>; Thu, 05 Aug 2021 07:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MMrJk6/3jTO5A5XLnH26wIfb2zXuydt2pwvSNbt20V8=;
        b=vRX/6+ArMy9jQdfBPdjGJiRS/VIXkzcqvH2jrZjOuhnY82mDE1LmQga2Vl/eiQSUdu
         4GDtVlFBCGqfPEWgkLYdLWG6dyvoIh3e+77wMi9lA1K5vQXKKzPaGG/cR/8p09G6OmPc
         miBUbaWhQonWv9Sb9x9Uu/DMnIDC5z54JkoVAmiW6uM3x8yTC+1KCr0VxrFxors0c0Ij
         W+wo59rk7nlLx54NgTkaEBRFMCKhUTAWlb9QT+D2RS+5ocqe4qwWrS5Ya4DS8AcuIBwU
         HShkorGMRxV6PV0WRA2YVqbcuBgF0JqLrkqYozIRnNOfrMzlLlpI8/VyKXxKC5X7J9P/
         4qmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MMrJk6/3jTO5A5XLnH26wIfb2zXuydt2pwvSNbt20V8=;
        b=LEoZcF/DXYmsmnJ7OLMancny52jftl/ehSdH9N0VDqQgpd8CgPe6rf6mhXxaCLgbPM
         wo3uEV7W/lnBj4pNKBIRB7AINgTLM9rPNQPuiQYBFmC6jWNL15/YRaMW07PeNOI71YBj
         pb3tLXPoLhZ0j1HrCvoqkFocjM6MUcO6veCPJxsZU3ygaYu02eouF303DkcHYs5ybN2H
         rntW9uLo3n1e4lRetU/YdZzm+/vqa4I68nQiZtLHc5b56IMFuBPZm472BYi+aZXb4syL
         k/919ltSV8Dk/1uPcPn1BXg6RZ/vZOgL9MhUueDCr8+QIoY3sDKRLl2z+koVOw4JVKI0
         lc4Q==
X-Gm-Message-State: AOAM533Hgp3kg75tY2UtVwQG9J9JWJauPafau0YLRkeVhf6t8SZQ+IXg
        lmj0jaOlCIXtOv/HiKnnXQTbJTqVPK81KdMiX5g=
X-Google-Smtp-Source: ABdhPJzJmTF+wqASooRBYchGjba3NqCuvIodKlNuZPYdgFyU0Sb0I0mCmnBxnBMAeCr8VhvC3VT6ZNJp6XIbcsRTEls=
X-Received: by 2002:a9d:65d0:: with SMTP id z16mr2236685oth.196.1628172095217;
 Thu, 05 Aug 2021 07:01:35 -0700 (PDT)
MIME-Version: 1.0
References: <20210805084550.810783-1-omosnace@redhat.com>
In-Reply-To: <20210805084550.810783-1-omosnace@redhat.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Thu, 5 Aug 2021 10:01:24 -0400
Message-ID: <CAP+JOzS902PUNYq-5HG_-oNEZGnr+rA3TBVHFQnP-+c2XHYYHg@mail.gmail.com>
Subject: Re: [PATCH userspace] libsepol/cil: remove obsolete comment
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Aug 5, 2021 at 5:16 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> Commit a60343cabfc2 ("libsepol/cil: remove unnecessary hash tables")
> removed FILENAME_TRANS_TABLE_SIZE macro that this comment was referring
> to. Remove the comment as well to avoid confusion.
>
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libsepol/cil/src/cil_binary.c | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/libsepol/cil/src/cil_binary.c b/libsepol/cil/src/cil_binary.c
> index 41105c12..2b65c622 100644
> --- a/libsepol/cil/src/cil_binary.c
> +++ b/libsepol/cil/src/cil_binary.c
> @@ -55,9 +55,6 @@
>  #include "cil_find.h"
>  #include "cil_build_ast.h"
>
> -/* There are 44000 filename_trans in current fedora policy. 1.33 times this is the recommended
> - * size of a hashtable. The next power of 2 of this is 2 ** 16.
> - */
>  #define ROLE_TRANS_TABLE_SIZE (1 << 10)
>  #define AVRULEX_TABLE_SIZE (1 <<  10)
>  #define PERMS_PER_CLASS 32
> --
> 2.31.1
>
