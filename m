Return-Path: <SRS0=cYHv=4P=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF4FEC4BA24
	for <selinux@archiver.kernel.org>; Thu, 27 Feb 2020 08:46:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0E7724688
	for <selinux@archiver.kernel.org>; Thu, 27 Feb 2020 08:46:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R7JfeP62"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728440AbgB0Iqp (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 27 Feb 2020 03:46:45 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:27482 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728554AbgB0Iqo (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 27 Feb 2020 03:46:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582793204;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fQkgaC/CfyWdWmXX8ct1kzd7wZkkd5qGZ+4H/VmXPHg=;
        b=R7JfeP629EuwOxs3edaz9F+mlmDEGQDdJmS2qJ+ZrnLgAq1DkK9j39oOl+vfobjBOO+/y3
        G5en70718B/JqA+DV0KNqqJzFWpounmwvZ2LHFW/hyAwDC2vfMCYezwOiwjTrZHWuxWnMZ
        EEC4yTr1fnnyhEmOhuxQq/NA6+3mNpM=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-223-IyCQbxBfM26p4dsQgCTfyA-1; Thu, 27 Feb 2020 03:46:42 -0500
X-MC-Unique: IyCQbxBfM26p4dsQgCTfyA-1
Received: by mail-ot1-f69.google.com with SMTP id d16so1225153otf.5
        for <selinux@vger.kernel.org>; Thu, 27 Feb 2020 00:46:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fQkgaC/CfyWdWmXX8ct1kzd7wZkkd5qGZ+4H/VmXPHg=;
        b=rB664qROqwnLGp6s31CpLFsKm+taDfG3Dw5H7IAOUiW7ontoLXNAuJ/heS/z3O1ORz
         a5Z3xMISEcokYA4CCJruw1wetG4+cERGUg75kfBWVjKL4x3yW1W+lOeEPncCUWtj5Aat
         mI+4dOpS9PtnatjFPub0YziIRkaJFwJnTYV8iDUD1bbvNqVaejzjal+MMO3+U/GkdPbL
         isYhvWcWTpHVz/JxmxyJQ5HFWxa/qOAyTxkJiApczUplyz8ACBgYhHtZ/uz/dsfmRWE6
         vi+5I5x4AT6JZFBfeZmnKlpivoKcmu5JqHOaO/0eD61CuKdOAgurwyjVWRo+pCBD69s+
         zBnw==
X-Gm-Message-State: APjAAAWouEWFaoKkcBE3u4fmOvHB9UXtlQVrIarPJcaRmegMeNJZFL5Z
        oyPuFhFtutBxKXxqJIT4J8eBXAB513Remh2jdskhMq6fOVvW+ELxrxkUsL8VfTu+p5crfGNCTLs
        gpuBEqLp/WM3mOGIeyLIdK2K7K389zYrL6g==
X-Received: by 2002:a9d:7ccc:: with SMTP id r12mr2507895otn.22.1582793201397;
        Thu, 27 Feb 2020 00:46:41 -0800 (PST)
X-Google-Smtp-Source: APXvYqx/SONctSEX4F/jMbJ5WCncf1/kZ7t0d4GbE2vDzZb7ErGMhmtcxRF4GX66f6DC47wYQNWtNsRsyTYgbXMBBBQ=
X-Received: by 2002:a9d:7ccc:: with SMTP id r12mr2507886otn.22.1582793201149;
 Thu, 27 Feb 2020 00:46:41 -0800 (PST)
MIME-Version: 1.0
References: <20200225224841.2693481-1-nicolas.iooss@m4x.org>
In-Reply-To: <20200225224841.2693481-1-nicolas.iooss@m4x.org>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Thu, 27 Feb 2020 09:46:31 +0100
Message-ID: <CAFqZXNuySxX6M0P2azXxFBD68EB6m89xG8-4++m-RD1h8uW8Qg@mail.gmail.com>
Subject: Re: [PATCH 1/1] libsepol: make ebitmap_cardinality() of linear complexity
To:     Nicolas Iooss <nicolas.iooss@m4x.org>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Feb 25, 2020 at 11:49 PM Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
> As ebitmap_get_bit() complexity is linear in the size of the bitmap, the
> complexity of ebitmap_cardinality() is quadratic. This can be optimized
> by browsing the nodes of the bitmap directly in ebitmap_cardinality().
>
> While at it, use built-in function __builtin_popcountll() to count the
> ones in the 64-bit value n->map for each bitmap node. This seems better
> suited than "count++". This seems to work on gcc and clang on x86,
> x86_64, ARM and ARM64 but if it causes compatibility issues with some
> compilers or architectures (or with older versions of gcc or clang),
> the use of __builtin_popcountll() can be replaced by a C implementation
> of a popcount algorithm.
>
> Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
> ---
>  libsepol/src/ebitmap.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/libsepol/src/ebitmap.c b/libsepol/src/ebitmap.c
> index d23444ce5064..a5108b7184c5 100644
> --- a/libsepol/src/ebitmap.c
> +++ b/libsepol/src/ebitmap.c
> @@ -128,14 +128,15 @@ int ebitmap_andnot(ebitmap_t *dst, ebitmap_t *e1, ebitmap_t *e2, unsigned int ma
>
>  unsigned int ebitmap_cardinality(ebitmap_t *e1)
>  {
> -       unsigned int i, count = 0;
> +       unsigned int count = 0;
> +       ebitmap_node_t *n;
>
>         if (e1->cardinality || e1->highbit == 0)
>                 return e1->cardinality;
>
> -       for (i=ebitmap_startbit(e1); i < ebitmap_length(e1); i++)
> -               if (ebitmap_get_bit(e1, i))
> -                       count++;
> +       for (n = e1->node; n; n = n->next) {
> +               count += __builtin_popcountll(n->map);
> +       }
>         e1->cardinality = count;
>         return count;
>  }
> --
> 2.25.0
>

Acked-by: Ondrej Mosnacek <omosnace@redhat.com>

I'll check if the cardinality caching still makes any measurable
difference and if not, I'll post a revert patch.

-- 
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.

